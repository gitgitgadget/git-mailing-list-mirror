From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 03/11] contrib: cc-cmd: add support for multiple patches
Date: Fri, 19 Apr 2013 14:30:23 -0500
Message-ID: <1366399831-5964-4-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2W-0004xK-4P
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab3DSTcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:00 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:44453 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab3DSTby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:31:54 -0400
Received: by mail-qc0-f178.google.com with SMTP id d10so391814qca.37
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=k7u7/qfLK4HeBnCGZ8PZcEdukiJso2sXAL2ysHs9xSM=;
        b=z5ojKuNzgeJRFKgwKxHL1DVj15d1D4WgUm3ZUDaD3Qu065/nPVaHqapnIC/Yty4s5s
         u2/xhYfmqS7p0NQo+kIKoELMzE3BIOfhCG0mauewKa16ONsgAOudtBjMsJ4MfMpqiHnc
         N602b+6v6Ws/Lfjcjng3rHYxZDs0qpDsvsS/30ePXUW7YyKpHQKxoIWLNIx7h/Jy0uWL
         RtiVKT+50ZsvWQKW0NCD+/S8GrKyi2hFOjDKvmn/FIcY9KdYXNr8f10NpPvm+94bTqKu
         mfZasUr6QxgZv0fbrXGb06D5YI1akBlJW48+hqi7fZ0E/8My8+EC0E1pscdAJG+hReH2
         RtJg==
X-Received: by 10.224.200.70 with SMTP id ev6mr14946932qab.57.1366399914018;
        Fri, 19 Apr 2013 12:31:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id bv6sm18590683qab.5.2013.04.19.12.31.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:31:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221798>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index d78759d..3a9c70e 100755
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
@@ -61,6 +61,7 @@ class Commits
 
   def initialize()
     @items = {}
+    @main_commits = {}
   end
 
   def size
@@ -91,24 +92,27 @@ class Commits
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
@@ -116,10 +120,8 @@ class Commits
 
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
