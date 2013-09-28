From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 43/44] ruby: add simpler option parser
Date: Sat, 28 Sep 2013 17:04:08 -0500
Message-ID: <1380405849-13000-44-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2kN-0004Mv-2e
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab3I1WMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:12:12 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:58885 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab3I1WMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:12:09 -0400
Received: by mail-oa0-f49.google.com with SMTP id i4so2990680oah.22
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dSlYBy1Eb3MAtnaag6kRTwbRobLk+vMVU1YO2PWwVyU=;
        b=x4HyUu3kBwHZHoVd8/B5VlMRioWvS7zwzDu2clUL5cmzkhkprG6ePKwH0DzyeTcOmA
         9OGIkRdbHA26uC7hU4TOSbPYhvUS+oTgUWWAvhKJr3MibIy0yt/XGH9UMNTCs5Z7ZJjg
         PtJhlUTXp8/HVGgOzY8xCz6MWYK2o1SFz3AZVEus2m+n0YuQV1JWWN7nKI7SRrZB3WQ1
         HWo/96UGwmJk6+n9AH714s+pGloFxz42Gtc9+x3DXCzqxPdWy/uiXOa6ordhu1haBuxL
         TwKaHclzeLOlRRLN4yauk3tWIMU62e8fSRvnEPyMT6gSnJWfdWHR1kTWzfkenQ97emjR
         BMNA==
X-Received: by 10.182.121.137 with SMTP id lk9mr12550528obb.32.1380406328786;
        Sat, 28 Sep 2013 15:12:08 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm25456334oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:12:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235563>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    We could use Git's internap parseopt, but the resulting code in Ruby wouldn't
    look very good, and the complexity to bind it wouldn't be trivial either (I
    tried).
    
    Instead, let's use the advantage of Ruby blocks to set the variables to their
    right values and try to keep the code simple, and add more features as they are
    needed later on.

 git-rb-setup.rb  |  75 ++++++++++++++++++++++++++++++++
 t/t10000-ruby.sh | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+)

diff --git a/git-rb-setup.rb b/git-rb-setup.rb
index 6f283da..cd2502f 100644
--- a/git-rb-setup.rb
+++ b/git-rb-setup.rb
@@ -32,3 +32,78 @@ class String
     return self[prefix.length..-1]
   end
 end
+
+class ParseOpt
+  attr_writer :usage
+
+  class Option
+    attr_reader :short, :long, :help
+
+    def initialize(short, long, help, &block)
+      @block = block
+      @short = short
+      @long = long
+      @help = help
+    end
+
+    def call(v)
+      @block.call(v)
+    end
+  end
+
+  def initialize
+    @list = {}
+  end
+
+  def on(short = nil, long = nil, help: nil, &block)
+    opt = Option.new(short, long, help, &block)
+    @list[short] = opt if short
+    @list[long] = opt if long
+  end
+
+  def parse
+    if ARGV.member?('-h') or ARGV.member?('--help')
+      usage
+      exit 0
+    end
+    seen_dash = false
+    ARGV.delete_if do |cur|
+      opt = val = nil
+      next false if cur[0] != '-' or seen_dash
+      case cur
+      when '--'
+        seen_dash = true
+        next true
+      when /^--no-(.+)$/
+        opt = @list[$1]
+        val = false
+      when /^-([^-])(.+)?$/, /^--(.+?)(?:=(.+))?$/
+        opt = @list[$1]
+        val = $2 || true
+      end
+      if opt
+        opt.call(val)
+        true
+      else
+        usage
+        exit 1
+      end
+    end
+  end
+
+  def usage
+    def fmt(prefix, str)
+      return str ? prefix + str : nil
+    end
+    puts 'usage: %s' % @usage
+    @list.values.uniq.each do |opt|
+      s = '    '
+      s << ''
+      s << [fmt('-', opt.short), fmt('--', opt.long)].compact.join(', ')
+      s << ''
+      s << '%*s%s' % [26 - s.size, '', opt.help] if opt.help
+      puts s
+    end
+  end
+
+end
diff --git a/t/t10000-ruby.sh b/t/t10000-ruby.sh
index e5a397c..a365849 100755
--- a/t/t10000-ruby.sh
+++ b/t/t10000-ruby.sh
@@ -102,4 +102,132 @@ test_expect_success 'test Commit' '
 	test_cmp expected actual
 '
 
+test_expect_success 'test ParseOpt' '
+	cat > parse-script <<"EOF"
+	$str = "default"
+	$num = 0
+	$bool = false
+
+	opts = ParseOpt.new
+	opts.usage = "git foo"
+
+	opts.on("b", "bool", help: "Boolean") do |v|
+	  $bool = v
+	end
+
+	opts.on("s", "string", help: "String") do |v|
+	  $str = v
+	end
+
+	opts.on("n", "number", help: "Number") do |v|
+	  $num = v.to_i
+	end
+
+	opts.parse
+
+	p(ARGV)
+	p({ :bool => $bool, :str => $str, :num => $num })
+	EOF
+
+	git ruby parse-script > actual &&
+	cat > expected <<-EOF &&
+	[]
+	{:bool=>false, :str=>"default", :num=>0}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script --bool > actual &&
+	cat > expected <<-EOF &&
+	[]
+	{:bool=>true, :str=>"default", :num=>0}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script -b > actual &&
+	cat > expected <<-EOF &&
+	[]
+	{:bool=>true, :str=>"default", :num=>0}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script --string=foo > actual &&
+	cat > expected <<-EOF &&
+	[]
+	{:bool=>false, :str=>"foo", :num=>0}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script -sfoo > actual &&
+	cat > expected <<-EOF &&
+	[]
+	{:bool=>false, :str=>"foo", :num=>0}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script --number=10 > actual &&
+	cat > expected <<-EOF &&
+	[]
+	{:bool=>false, :str=>"default", :num=>10}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script --bool --string=bar --number=-20 > actual &&
+	cat > expected <<-EOF &&
+	[]
+	{:bool=>true, :str=>"bar", :num=>-20}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script --help > actual &&
+	cat > expected <<-EOF &&
+	usage: git foo
+	    -b, --bool            Boolean
+	    -s, --string          String
+	    -n, --number          Number
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script --help > actual &&
+	cat > expected <<-EOF &&
+	usage: git foo
+	    -b, --bool            Boolean
+	    -s, --string          String
+	    -n, --number          Number
+	EOF
+	test_cmp expected actual &&
+
+	test_must_fail git ruby parse-script --bad > actual &&
+	cat > expected <<-EOF &&
+	usage: git foo
+	    -b, --bool            Boolean
+	    -s, --string          String
+	    -n, --number          Number
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script one --bool two --string=bar three --number=-20 mambo > actual &&
+	cat > expected <<-EOF &&
+	["one", "two", "three", "mambo"]
+	{:bool=>true, :str=>"bar", :num=>-20}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script one --bool two -- --three four > actual &&
+	cat > expected <<-EOF &&
+	["one", "two", "--three", "four"]
+	{:bool=>true, :str=>"default", :num=>0}
+	EOF
+	test_cmp expected actual &&
+
+	git ruby parse-script one --bool --no-bool > actual &&
+	cat > expected <<-EOF &&
+	["one"]
+	{:bool=>false, :str=>"default", :num=>0}
+	EOF
+	cat actual
+	test_cmp expected actual &&
+
+	true
+'
+
 test_done
-- 
1.8.4-fc
