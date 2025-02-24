require '../lib/solareventcalculator'

describe SolarEventCalculator, "Test the sunset algorithm" do

  before do
    @date = Date.parse('2008-11-01') #01 November 2008 (DST)
    @calc = SolarEventCalculator.new(@date, BigDecimal("39.9537"), BigDecimal("-75.7850"))
  end

  it "returns correct longitude hour" do
    expect(@calc.compute_lnghour).to eq(BigDecimal("-5.0523"))
  end

  it "returns correct longitude hour" do
    expect(@calc.compute_longitude_hour(false)).to eq(BigDecimal("306.9605"))
  end

  it "returns correct sunset mean anomaly" do
    expect(@calc.compute_sun_mean_anomaly(BigDecimal("306.9605"))).to eq(BigDecimal("299.2513"))
  end

  it "returns correct sunset's sun true longitude" do
    expect(@calc.compute_sun_true_longitude(BigDecimal("299.2513"))).to eq(BigDecimal("220.1966"))
  end

  it "returns correct sunset's right ascension" do
    expect(@calc.compute_right_ascension(BigDecimal("220.1966"))).to eq(BigDecimal("37.7890"))
  end

  it "returns correct sunset's right ascension quadrant" do
    expect(@calc.put_ra_in_correct_quadrant(BigDecimal("220.1966"))).to eq(BigDecimal("14.5193"))
  end

  it "returns correct sunset sin sun declination" do
    expect(@calc.compute_sin_sun_declination(BigDecimal("220.1966"))).to eq(BigDecimal("-0.2568"))
  end

  it "returns correct sunset cosine sun declination" do
    expect(@calc.compute_cosine_sun_declination(BigDecimal("-0.2541"))).to eq(BigDecimal("0.9672"))
  end

  it "returns correct sunset cosine sun local hour" do
    expect(@calc.compute_cosine_sun_local_hour(BigDecimal("220.1966"), 96)).to eq(BigDecimal("0.0815"))
  end

  it "returns correct sunset local hour angle" do
    expect(@calc.compute_local_hour_angle(BigDecimal("0.0815"), false)).to eq(BigDecimal("5.6883"))
  end

  it "returns correct sunset local mean time" do
    trueLong = BigDecimal("220.1966")
    longHour = BigDecimal("-5.0523")
    localHour = BigDecimal("5.6883")
    t = BigDecimal("306.9605")
    expect(@calc.compute_local_mean_time(trueLong, longHour, t, localHour)).to eq(BigDecimal("22.4675"))
  end

  it "returns correct UTC civil sunset time" do
    expect(@calc.compute_utc_civil_sunset).to eq(DateTime.parse("#{@date.strftime}T22:28:00-00:00"))
  end

  it "returns correct UTC official sunset time" do
    expect(@calc.compute_utc_official_sunset).to eq(DateTime.parse("#{@date.strftime}T21:59:00-00:00"))
  end

  it "returns correct UTC nautical sunset time" do
    expect(@calc.compute_utc_nautical_sunset).to eq(DateTime.parse("#{@date.strftime}T23:00:00-00:00"))
  end

  it "returns correct UTC astronomical sunset time" do
    expect(@calc.compute_utc_astronomical_sunset).to eq(DateTime.parse("#{@date.strftime}T23:31:00-00:00"))
  end

  it "returns correct 'America/New_York' offical sunset time" do
    expect(@calc.compute_official_sunset("America/New_York")).to eq(DateTime.parse("#{@date.strftime}T17:59:00-04:00"))
  end

  it "returns correct 'America/New_York' civil sunset time" do
    expect(@calc.compute_civil_sunset("America/New_York")).to eq(DateTime.parse("#{@date.strftime}T18:28:00-04:00"))
  end

  it "returns correct 'America/New_York' nautical sunset time" do
    expect(@calc.compute_nautical_sunset("America/New_York")).to eq(DateTime.parse("#{@date.strftime}T19:00:00-04:00"))
  end

  it "returns correct 'America/New_York' astronomical sunset time" do
    expect(@calc.compute_astronomical_sunset("America/New_York")).to eq(DateTime.parse("#{@date.strftime}T19:31:00-04:00"))
  end
  # DateTime.parse("#{@date.strftime}T06:32:00-04:00")
end

describe SolarEventCalculator, "test the math for areas where the sun doesn't set" do

  it "returns correct time" do
    date = Date.parse('2008-04-25') #25 April 2008
    calc = SolarEventCalculator.new(date, BigDecimal("64.8378"), BigDecimal("-147.7164"))
    expect(calc.compute_utc_nautical_sunset).to eq(nil)
  end

  it "returns correct time" do
    date = Date.parse('2008-04-25') #25 April 2008
    calc = SolarEventCalculator.new(date, BigDecimal("64.8378"), BigDecimal("-147.7164"))
    expect(calc.compute_utc_nautical_sunset).to eq(nil)
  end
end
