From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 3/6] contrib: related: add support for multiple patches
Date: Fri, 31 May 2013 02:37:41 -0500
Message-ID: <1369985864-31922-4-git-send-email-felipe.contreras@gmail.com>
References: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJwM-0008Qh-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab3EaHji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:39:38 -0400
Received: from mail-ye0-f178.google.com ([209.85.213.178]:40727 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3EaHjh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:39:37 -0400
Received: by mail-ye0-f178.google.com with SMTP id m2so294230yen.23
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fe69gCAHlq+iX5b3wtSAa2BwboBgBgCTGus4UMNg5g4=;
        b=OUsibRglC8wRW6aKD39aL37nVmznA+6OK6+q8hy6IDPSRH9vb2wtodU4Xv+yylhKRx
         Q9PgeiyO7BKNuAQlFqd+mUH3sjfM9VlY7BruWCe1hmhPYA4tc3lPhKiVdkgW/ijRts0+
         FIfmgr4ovM/SuO656d+PILw3AihRB4GpD3yxRxIq2jZdPKvcC4V3wxmyjHJoaIPzLFk0
         +ZpAl86Bl7HtfV1J970diXzuz9q+5vx7hLgwP6cVQ6JloFFm7ok+ld0vufiwM1wt0WeC
         LcRoFuC75Ljd3KjZF83Q1R7nef+rj3qRJv1lsK3fUdPHB0obe0JCR6lXN2jXHQBvigUL
         +VOQ==
X-Received: by 10.236.146.137 with SMTP id r9mr5999160yhj.42.1369985976959;
        Fri, 31 May 2013 00:39:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id e64sm66063279yhm.4.2013.05.31.00.39.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:39:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226064>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index bde5b99..0de1c6c 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -10,7 +10,7 @@ $min_percent = 10
 
 OptionParser.new do |opts|
   opts.program_name = 'git related'
-  opts.banner = 'usage: git related [options] <file>'
+  opts.banner = 'usage: git related [options] <files>'
 
   opts.on('-p', '--min-percent N', Integer,
           'Minium percentage of role participation') do |v|
@@ -56,6 +56,7 @@ class Commits
 
   def initialize
     @items = {}
+    @main_commits = {}
   end
 
   def size
@@ -91,23 +92,27 @@ class Commits
       p.each do |line|
         if line =~ /^\h{40}/
           id = $&
-          @items[id] = Commit.new(id)
+          @items[id] = Commit.new(id) if not @main_commits.include?(id)
         end
       end
     end
   end
 
-  def from_patch(file)
-    from = source = nil
-    File.open(file) do |f|
-      f.each do |line|
-        case line
-        when /^From (\h+) (.+)$/
-          from = $1
-        when /^---\s+(\S+)/
-          source = $1 != '/dev/null' ? $1[2..-1] : nil
-        when /^@@ -(\d+)(?:,(\d+))?/
-          get_blame(source, $1, $2, from) if source and from
+  def from_patches(files)
+    source = nil
+    files.each do |file|
+      from = nil
+      File.open(file) do |f|
+        f.each do |line|
+          case line
+          when /^From (\h+) (.+)$/
+            from = $1
+            @main_commits[from] = true
+          when /^---\s+(\S+)/
+            source = $1 != '/dev/null' ? $1[2..-1] : nil
+          when /^@@ -(\d+)(?:,(\d+))?/
+            get_blame(source, $1, $2, from) if source and from
+          end
         end
       end
     end
@@ -115,10 +120,8 @@ class Commits
 
 end
 
-exit 1 if ARGV.size != 1
-
 commits = Commits.new
-commits.from_patch(ARGV[0])
+commits.from_patches(ARGV)
 commits.import
 
 count_per_person = Hash.new(0)
-- 
1.8.3.358.g5a91d05
