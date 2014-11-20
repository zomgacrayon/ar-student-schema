
require_relative '../../db/config'

class Student < ActiveRecord::Base
  has_many :teachings
  has_many :teachers, through: :teachings
# implement your Student model here
  # validates :email, format: { :with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{2,}\z/, :message => "Wrong email!" }
  # validates :email, uniqueness: {:message => "Email not unique!"}
  # validate :age_checker
  # # validates :phone, format: { :with => /\d{10,}[a-zA-z]*/, :message => "Wrong format for number"}
  # validate :phone_checker

  def age_checker
    if age < 5
      errors.add(:age, "Underage!")
    end
  end

  def phone_checker
    temp_phone = phone.to_s.gsub(/\D/,"")
    if !(temp_phone =~ /\d{10,}/)
      errors.add(:phone, "Wrong format for number")
    end
  end

  def name
    first_name = self.first_name
    last_name = self.last_name
    return first_name + " " + last_name
  end

  def age
    diff = Date.today - self.birthday
    age = (diff/365.25).floor
  end

end

# ben = Student.create(first_name: "Ben", last_name: "Tan",birthday: "1980-12-1", email: "ben@gmail.com", phone: "1056446589")

# p ben.new_record?

# ben.age
# p ben.valid?