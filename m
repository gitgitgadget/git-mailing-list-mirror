From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 6/6] contrib: related: implement custom option parser
Date: Fri, 31 May 2013 02:37:44 -0500
Message-ID: <1369985864-31922-7-git-send-email-felipe.contreras@gmail.com>
References: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:40:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJwO-0008Qh-75
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab3EaHjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:39:47 -0400
Received: from mail-gg0-f177.google.com ([209.85.161.177]:57438 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620Ab3EaHjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:39:46 -0400
Received: by mail-gg0-f177.google.com with SMTP id r4so289979ggn.36
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fcekwEf0y1ayvicUhyxC5XFJ5gjoeeAqqqu1QA80wi4=;
        b=ZRgsAtbRr70dbalLI99il6GhPnk+mAkDP4XxuNJa0LGmota7lt7VyexTeqc1GKHfrp
         EFitS8yYFPiBD3yCJvj+uesOpIqHKNMVtedksoDmMVBq0JL9BAverBCOsxMobZ5OZLam
         iU9gueuqVq4ZkUjaHPrsZR1nBF6w1py4Zq2UHQOU6FjwMw8N+p8LDTztLKx3Jp4U3xG7
         BVr4Vh835IMYU6PKEztlRqsIn9GwyGo0E8OA9Lqw05ChQFZXhTNPDW5feR6js9V5CyxY
         /7rnRpfAW9IDR1a/tNtfYBo7ValhE0yan+Rs38Fq5UyrwuQZkM+h+EKk/oDhCinWQuJ6
         KlkQ==
X-Received: by 10.236.22.230 with SMTP id t66mr5982840yht.70.1369985985641;
        Fri, 31 May 2013 00:39:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id f19sm65169310yhj.3.2013.05.31.00.39.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:39:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226063>

Ruby's option parser is not extensible enough to keep unknown options.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 83 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 585572b..c933898 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -3,26 +3,85 @@
 # This script finds people that might be interested in a patch
 # usage: git related <file>
 
-require 'optparse'
-
 $since = '5-years-ago'
 $min_percent = 10
 $files = []
 $rev_args = []
 
-OptionParser.new do |opts|
-  opts.program_name = 'git related'
-  opts.banner = 'usage: git related [options] <files | rev-list options>'
+class SimpleParser
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
 
-  opts.on('-p', '--min-percent N', Integer,
-          'Minium percentage of role participation') do |v|
-    $min_percent = v
+  def initialize
+    @list = {}
+  end
+
+  def on(short=nil, long=nil, help=nil, &block)
+    opt = Option.new(short, long, help, &block)
+    @list[short] = opt if short
+    @list[long] = opt if long
+  end
+
+  def parse
+    i = 0
+    if ARGV.member?('-h') or ARGV.member?('--help')
+      usage
+      exit 1
+    end
+    while cur = ARGV[i] do
+      if cur =~ /^(-.+?)(?:=(.*))?$/
+        opt = @list[$1]
+        if opt
+          v = $2 || ARGV.delete_at(i + 1)
+          opt.call(v)
+          ARGV.delete_at(i)
+          next
+        end
+      end
+      i += 1
+    end
   end
-  opts.on('-d', '--since DATE',
-          'How far back to search for relevant commits') do |v|
-    $since = v
+
+  def usage
+    puts 'usage: %s' % @usage
+    @list.values.uniq.each do |opt|
+      s = '    '
+      s << [opt.short, opt.long].compact.join(', ')
+      s << '%*s%s' % [26 - s.size, '', opt.help] if opt.help
+      puts s
+    end
   end
-end.parse!
+
+end
+
+opts = SimpleParser.new
+opts.usage = 'usage: git related [options] <files | rev-list options>'
+
+opts.on('-p', '--min-percent',
+        'Minium percentage of role participation') do |v|
+  $min_percent = v.to_i
+end
+
+opts.on('-d', '--since',
+        'How far back to search for relevant commits') do |v|
+  $since = v
+end
+
+opts.parse
 
 class Commit
 
-- 
1.8.3.358.g5a91d05
