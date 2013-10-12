From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 04/15] contrib: related: add option to parse from committish
Date: Sat, 12 Oct 2013 02:06:15 -0500
Message-ID: <1381561584-20529-7-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNh-00059v-Vr
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab3JLHMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:43 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:35113 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3JLHMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:41 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so2573933oag.17
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USLZoii40JTXjiD7Kknifi4g9KKIHz6sQmQ37Z41gRY=;
        b=dN4e1GiGwULfqhqACszKakH5IMsxAEAGUrYw6EOIsJsLweb/fdJhB7Yb7dpmfdb2rw
         +/QS/+5Gle0OmG+RgWXsNSimVPz4h/dxBMtuAmKLq1pZYjPW50ztn5nS2eSzbJpDQL3e
         YqHEasdaUumTIxCov7YE3DyppsyqjRwq2ZIYoUBmqtLDHSFQRUvj9V7lL0dwY34wi3qu
         eJPCxCvR3x5WQTuyDYnLUvQ1jqmy0JPK/FaQ6dNhd+a1bpdNEZku2T3XeIyasQAAsXVT
         YELXdB8d/KRGqsVChZkhmbz1n8ZurZUwedgsoCaPyi5YYT58vAhnWfMeuV+hj9Kt1JCU
         ygFA==
X-Received: by 10.182.129.201 with SMTP id ny9mr17904382obb.0.1381561961401;
        Sat, 12 Oct 2013 00:12:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm28639574obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236001>

For example master..feature-a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    | 57 +++++++++++++++++++++++++++++++-----------
 contrib/related/test-related.t | 10 ++++++++
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 7e79d78..4f78304 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -1,10 +1,12 @@
 #!/usr/bin/env ruby
 
 # This script finds people that might be interested in a patch
-# usage: git related <files>
+# usage: git related <files | rev-list options>
 
 $since = '5-years-ago'
 $min_percent = 10
+$files = []
+$rev_args = []
 
 class Commit
 
@@ -82,21 +84,36 @@ class Commits
     end
   end
 
-  def from_patches(files)
+  def scan_patch(f, id = nil)
     source = nil
+    f.each do |line|
+      case line
+      when /^From (\h+) (.+)$/
+        id = $1
+        @main_commits[id] = true
+      when /^---\s+(\S+)/
+        source = $1 != '/dev/null' ? $1[2..-1] : nil
+      when /^@@ -(\d+)(?:,(\d+))?/
+        get_blame(source, $1, $2, id) if source and id
+      end
+    end
+  end
+
+  def from_patches(files)
     files.each do |file|
-      from = nil
       File.open(file) do |f|
-        f.each do |line|
-          case line
-          when /^From (\h+) (.+)$/
-            from = $1
-            @main_commits[from] = true
-          when /^---\s+(\S+)/
-            source = $1 != '/dev/null' ? $1[2..-1] : nil
-          when /^@@ -(\d+)(?:,(\d+))?/
-            get_blame(source, $1, $2, from) if source and from
-          end
+        scan_patch(f)
+      end
+    end
+  end
+
+  def from_rev_args(args)
+    File.popen(%w[git rev-list --reverse] + args) do |p|
+      p.each do |e|
+        id = e.chomp
+        @main_commits[id] = true
+        File.popen(%w[git show -C --oneline] + [id]) do |p|
+          scan_patch(p, id)
         end
       end
     end
@@ -104,8 +121,20 @@ class Commits
 
 end
 
+ARGV.each do |e|
+  if File.exists?(e)
+    $files << e
+  else
+    $rev_args << e
+  end
+end
+
 commits = Commits.new
-commits.from_patches(ARGV)
+if $files.empty?
+  commits.from_rev_args($rev_args)
+else
+  commits.from_patches($files)
+end
 commits.import
 
 count_per_person = Hash.new(0)
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index 8102b3c..b623d69 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -64,4 +64,14 @@ test_expect_success "multiple patches" "
 	test_cmp expected actual
 "
 
+test_expect_success "from committish" "
+	git related -1 master | sort > actual &&
+	cat > expected <<-EOF &&
+	John Doe <john@doe.com>
+	John Poppins <john@doe.com>
+	Jon Stewart <jon@stewart.com>
+	EOF
+	test_cmp expected actual
+"
+
 test_done
-- 
1.8.4-fc
