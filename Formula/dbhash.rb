class Dbhash < Formula
  desc "Computes the SHA1 hash of schema and content of a SQLite database"
  homepage "https://www.sqlite.org/dbhash.html"
  url "https://www.sqlite.org/2016/sqlite-src-3150000.zip"
  version "3.15.0"
  sha256 "c68a7064b1932aa8c40f9b1e644ab899771530e16d514ba4a065434666d4a3a2"

  bottle do
    cellar :any_skip_relocation
    sha256 "e30691050b398f92047e0e0e874244a71c64c59935c8699dd5cfdde355c06b89" => :sierra
    sha256 "5490da75d257a767b564a407dafe1d2fb71d2a3087054414fb735dcfb5ac292c" => :el_capitan
    sha256 "15bac28a21ffa1469abe10ea2d539536281cb9a19d54a186f769d1fcac0a8f17" => :yosemite
  end

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make", "dbhash"
    bin.install "dbhash"
  end

  test do
    dbpath = testpath/"test.sqlite"
    sqlpath = testpath/"test.sql"
    sqlpath.write "create table test (name text);"
    system "/usr/bin/sqlite3 #{dbpath} < #{sqlpath}"
    assert_equal "b6113e0ce62c5f5ca5c9f229393345ce812b7309",
                 shell_output("#{bin}/dbhash #{dbpath}").strip.split.first
  end
end
