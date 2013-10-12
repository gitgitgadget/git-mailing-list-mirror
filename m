From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 03/15] contrib: related: add support for multiple patches
Date: Sat, 12 Oct 2013 02:06:18 -0500
Message-ID: <1381561584-20529-10-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNh-00059v-Ex
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab3JLHMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:52 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:49363 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab3JLHMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:49 -0400
Received: by mail-oa0-f50.google.com with SMTP id j1so3177063oag.9
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i5HKkhyHQP2lKFZy9LloZjgLzMVrhAlvZvymHOFS4Gg=;
        b=RkFeQ8NiZiEEAWeC5wVrw7A5cj4J0mh7scZgCNdVPGRCmY5kxa9Yvz7FB3bUfhnSxB
         +34dTqkAZ8lEuW+mN8v2b3Q8GgNfv9hQQzi5KI2fyS+x+XPxWGR1PkAVvL2Bk5cBjwC/
         exDymqdj6sVimVZ0JESLENN10zmy8cJ/QTnPYV5r24Wl6dBuXo690dmhGHVZ7Yb3Nt4U
         FZO81oVocYAlp0ncerTKxPxIllWMsBiJ2tpjWLTAjCkdwbq5HtsxUWb/PkVtv2id6LL1
         UqDpaFkaFjWek/LxSQjhRGobV22VwtkPecxdI946ZVgkuuqAQmJU5l3pyMSo0y/LCfmj
         H78w==
X-Received: by 10.60.136.226 with SMTP id qd2mr17775367oeb.20.1381561969090;
        Sat, 12 Oct 2013 00:12:49 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm101384876oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236000>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    | 35 +++++++++++++++++++----------------
 contrib/related/test-related.t | 13 +++++++++++++
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 66c1009..7e79d78 100755
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
-          @items[id] ||= Commit.new(id)
+          @items[id] ||= Commit.new(id) if not @main_commits.include?(id)
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
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index b69684d..8102b3c 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -51,4 +51,17 @@ test_expect_success "others" "
 	test_cmp expected actual
 "
 
+test_expect_success "multiple patches" "
+	git format-patch --stdout -1 master > patch1 &&
+	git format-patch --stdout -1 master^ > patch2 &&
+	git related patch1 patch2 | sort > actual &&
+	cat > expected <<-EOF &&
+	John Doe <john@doe.com>
+	John Poppins <john@doe.com>
+	Jon Stewart <jon@stewart.com>
+	Pablo Escobar <pablo@escobar.com>
+	EOF
+	test_cmp expected actual
+"
+
 test_done
-- 
1.8.4-fc
