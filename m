From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 13/15] contrib: related: add option parsing
Date: Sat, 12 Oct 2013 02:06:20 -0500
Message-ID: <1381561584-20529-12-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNs-0005LL-4c
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310Ab3JLHM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:56 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48565 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3JLHMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:54 -0400
Received: by mail-ob0-f173.google.com with SMTP id wo20so3442040obc.18
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dwURhsK/lsvbf+PnU/c5S8vtGhda9SnBfQc/9hSd6sY=;
        b=lq5StADxwrMjtxRgYqCD5HaMEeJlqmji4ILaURrGs4GpSb8JRCuHTwugBSi6zZ3sKc
         UnAcUo/cJuuuj4HuCjYEVz+9Go8orrxKd2MDzQ7w7t3xLftPyh1gmu0ojTnyy4FI+3FT
         kbt0+J8aePlNfSxEixw3ujJzu8wlImCdc8UidjdeORH49xKxI6r8tVrLC4Yb+s452NQt
         d32R2SQJTFkbW+tvvjTykTL9xupsyU0jsJR82XjhpjG17gPFdq5bwqAQbf9f6ufYpA0D
         6SOCV322c5ZmlX+UxXoYBkMgnLA/x0n8vZhc7Ok6yuDDp4/X+Mj/MCw/0mCADTvhNSvR
         jYDA==
X-Received: by 10.182.40.134 with SMTP id x6mr17797295obk.31.1381561973976;
        Sat, 12 Oct 2013 00:12:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm101395692oef.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236003>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 85 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 6ab74c7..d6b44c7 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -45,6 +45,91 @@ get_mailmap(File.join($base_dir, '.mailmap'))
 mailmap_file = %x[git config mailmap.file].chomp
 get_mailmap(mailmap_file)
 
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
+  def on(short = nil, long = nil, help = nil, &block)
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
+
+opts = ParseOpt.new
+opts.usage = 'git related [options] <files | rev-list options>'
+
+opts.on('p', 'min-percent', 'Minium percentage of role participation') do |v|
+  $min_percent = v.to_i
+end
+
+opts.on('d', 'since', 'How far back to search for relevant commits') do |v|
+  $since = v
+end
+
+opts.parse
+
 class Person
 
   attr_reader :roles
-- 
1.8.4-fc
