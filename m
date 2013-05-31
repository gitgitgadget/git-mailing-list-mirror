From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 2/4] contrib: related: add support for multiple patches
Date: Fri, 31 May 2013 02:46:18 -0500
Message-ID: <1369986380-412-3-git-send-email-felipe.contreras@gmail.com>
References: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiK4R-0004GS-PS
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab3EaHsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:48:15 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:43178 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab3EaHsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:48:11 -0400
Received: by mail-yh0-f50.google.com with SMTP id b6so332527yha.9
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aefg/ILlUqOq3OKmnjfP9UWkt/Qyi+MIXdd2rpuZesk=;
        b=QNgjMOEoe2dkdegjQNQeKum7GU533icGF0mFxE6G8Fqta5jmQorrKKqGKNSsVntyTx
         xKyMzZSS7VaS0rYi8Lt8681vIafZ2s5IHlS+wbYrFBvAeLWetTvbZI65vRXsEQtbXZsg
         saP3y6MV0cmbI1pNIvOIfVpjc3hz74TzQ9HIm925Tt9GRICZscy6Ice0kLvQV9QuDblU
         Tyh0fE7syZxj6Zo7gkpH9/al0JHxuDgNWpGGpG2FX6NJZF6n3FQkcuftsfZn0F8VPw6g
         +Jo1uK+vqONxkrEujaJC0E4ZQLKnVdzW3utrm0nSIgP0qkqz9UwfFNeRRVQTkPphQK9X
         iGiQ==
X-Received: by 10.236.122.147 with SMTP id t19mr6252910yhh.86.1369986490536;
        Fri, 31 May 2013 00:48:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j64sm66078413yhj.25.2013.05.31.00.48.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:48:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226068>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 1b9b1e7..3379982 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -1,7 +1,7 @@
 #!/usr/bin/env ruby
 
 # This script finds people that might be interested in a patch
-# usage: git related <file>
+# usage: git related <files>
 
 $since = '5-years-ago'
 $min_percent = 10
@@ -40,6 +40,7 @@ class Commits
 
   def initialize
     @items = {}
+    @main_commits = {}
   end
 
   def size
@@ -75,23 +76,27 @@ class Commits
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
@@ -99,10 +104,8 @@ class Commits
 
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
