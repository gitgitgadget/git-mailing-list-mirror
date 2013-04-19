From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/8] contrib: cc-cmd: add support for multiple patches
Date: Fri, 19 Apr 2013 00:14:13 -0500
Message-ID: <1366348458-7706-4-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3fm-0007yE-Lq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab3DSFPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:15:41 -0400
Received: from mail-gh0-f177.google.com ([209.85.160.177]:39467 "EHLO
	mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3DSFPj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:39 -0400
Received: by mail-gh0-f177.google.com with SMTP id g22so453023ghb.8
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Bl6IZKDI5yitbmo+XdNT2i6KndISlUW0peYDoMtTAnI=;
        b=tNyXsdpiLedEbrQ69gSWk8OjqV2Yve3lCaNH5/FJmJqV+TB5wiU4g68QA6/1/hffVL
         2eUSUmzQzM5IG534RbSY5UNbWYMdm7qANzDLPko6DaPlWAYsFComAFnd0eZeylrIISsU
         knmbHU7auEm/xWKjithOpUBH/QZDrzpKfuGRENkgTiND5P5kWW5sXVlL4W52QJMZgnwz
         FmcasfQkuMqWIDtSxQvSJ+7G9ZjsjO4xBRu/O+KEpG5CGp8XXaGv8Go8GrHmsXoTsFaE
         CJuUkaXGVfTSwaDeujToEY1ViduL6wG2sJtpBygLvBVUn+63bFOW1rVznPkRoJoh9LEw
         bd+g==
X-Received: by 10.236.19.196 with SMTP id n44mr10353334yhn.65.1366348538794;
        Thu, 18 Apr 2013 22:15:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id w69sm22359193yhe.4.2013.04.18.22.15.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221731>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 0a5ec01..e36b1bf 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -8,7 +8,7 @@ $min_percent = 5
 begin
   OptionParser.new do |opts|
     opts.program_name = 'git cc-cmd'
-    opts.banner = 'usage: git cc-cmd [options] <file>'
+    opts.banner = 'usage: git cc-cmd [options] <files>'
 
     opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
       $min_percent = v
@@ -66,6 +66,7 @@ class Commits
 
   def initialize()
     @items = {}
+    @main_commits = {}
   end
 
   def size
@@ -103,24 +104,27 @@ class Commits
       p.each do |line|
         if line =~ /^(\h{40})/
           id = $1
-          @items[id] = Commit.new(id)
+          @items[id] = Commit.new(id) if not @main_commits.include?(id)
         end
       end
     end
   end
 
-  def from_patch(file)
+  def from_patches(files)
     source = nil
-    from = nil
-    File.open(file) do |f|
-      f.each do |line|
-        case line
-        when /^From (\h+) (.+)$/
-          from = $1
-        when /^---\s+(\S+)/
-          source = $1 != '/dev/null' ? $1[2..-1] : nil
-        when /^@@\s-(\d+),(\d+)/
-          get_blame(source, $1, $2, from)
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
+          when /^@@\s-(\d+),(\d+)/
+            get_blame(source, $1, $2, from)
+          end
         end
       end
     end
@@ -128,10 +132,8 @@ class Commits
 
 end
 
-exit 1 if ARGV.size != 1
-
 commits = Commits.new
-commits.from_patch(ARGV[0])
+commits.from_patches(ARGV)
 commits.import
 
 # hash of hashes
-- 
1.8.2.1.790.g4588561
