From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/11] contrib: related: add support for multiple patches
Date: Thu, 25 Apr 2013 14:59:35 -0500
Message-ID: <1366919983-27521-4-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMB-0003yE-2G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365Ab3DYUBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:15 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:57404 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab3DYUBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:13 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so2924775obc.34
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yz8yMhxq0WUNeKryBHpGkZJjuhcwg6vipUAEkSAE1iU=;
        b=BciOF66oBrTRun3dcpIuB8fC28oLc7pWjVnDdzgwSlRu8BJdV+yEh2J26/SEzAv/NC
         swUM1DWGr2AsRyfh5CNvwOeXdpeAMZGbxUWrourWb7Nk54zTHm9YaZXF1IcPuTmwciL9
         a/StL3CrSAFd7Tj0Zg1WZRiuG/pBrDVzBQlmg+9DT5oWQO1z/6DUqjRz2HWC5GQylAOv
         MtzcGU/EvXw0AoKudLY+1tq4LRDNrCWaoE45aEeV37AvmNRitFduqrLXXUvwjZ84Dh1p
         8uVeqXDRdtWYpC55lpYpRGu3fdufEc6sETJaO0BYayAWr7dPiDKuMAUM+MIhS4aGh9DK
         aL7A==
X-Received: by 10.60.179.7 with SMTP id dc7mr12645638oec.3.1366920073390;
        Thu, 25 Apr 2013 13:01:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pq6sm1858409obc.11.2013.04.25.13.01.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222431>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 702836a..90ec3aa 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
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
1.8.2.1
