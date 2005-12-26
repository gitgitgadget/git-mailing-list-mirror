From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Handle symlinks graciously
Date: Mon, 26 Dec 2005 22:31:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512262231350.21076@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Dec 26 22:31:54 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eqzwe-00015w-9D
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 22:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVLZVbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 16:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVLZVbs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 16:31:48 -0500
Received: from mail.gmx.net ([213.165.64.21]:35264 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750813AbVLZVbs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Dec 2005 16:31:48 -0500
Received: (qmail invoked by alias); 26 Dec 2005 21:31:46 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp001) with SMTP; 26 Dec 2005 22:31:46 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14060>


This patch converts a stat() to an lstat() call, thereby fixing the case
when the date of a symlink was not the same as the one recorded in the
index. The included test case demonstrates this.

This is for the case that the symlink points to a non-existing file. If
the file exists, worse things than just an error message happen.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	A few weeks ago I hunted a bug in t4004 on OS X, just to discover
	that it only occurred rarely. The problem is when the atime or mtime
	differ: in this case, diff-index would try to stat() the symlink,
	not lstat() it.

 diff.c                  |    2 +
 t/t4011-diff-symlink.sh |   84 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletions(-)
 create mode 100755 t/t4011-diff-symlink.sh

bd43cfdf69d99c3552fab5a375d9a72657d3bcad
diff --git a/diff.c b/diff.c
index c815918..6f064df 100644
--- a/diff.c
+++ b/diff.c
@@ -650,7 +650,7 @@ static void diff_fill_sha1_info(struct d
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->sha1_valid) {
 			struct stat st;
-			if (stat(one->path, &st) < 0)
+			if (lstat(one->path, &st) < 0)
 				die("stat %s", one->path);
 			if (index_path(one->sha1, one->path, &st, 0))
 				die("cannot hash %s\n", one->path);
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
new file mode 100755
index 0000000..9e70063
--- /dev/null
+++ b/t/t4011-diff-symlink.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+test_description='Test diff of symlinks.
+
+'
+. ./test-lib.sh
+. ../diff-lib.sh
+
+cat > expected << EOF
+diff --git a/frotz b/frotz
+new file mode 120000
+index 0000000..7c465af
+--- /dev/null
++++ b/frotz
+@@ -0,0 +1 @@
++xyzzy
+\ No newline at end of file
+EOF
+
+test_expect_success \
+    'diff new symlink' \
+    'ln -s xyzzy frotz &&
+    git-update-index &&
+    tree=$(git-write-tree) &&
+    git-update-index --add frotz &&
+    GIT_DIFF_OPTS=--unified=0 git-diff-index -M -p $tree > current &&
+    compare_diff_patch current expected'
+
+test_expect_success \
+    'diff unchanged symlink' \
+    'tree=$(git-write-tree) &&
+    test -z "$(git-diff-index --name-only $tree)"'
+
+cat > expected << EOF
+diff --git a/frotz b/frotz
+deleted file mode 120000
+index 7c465af..0000000
+--- a/frotz
++++ /dev/null
+@@ -1 +0,0 @@
+-xyzzy
+\ No newline at end of file
+EOF
+
+test_expect_success \
+    'diff removed symlink' \
+    'rm frotz &&
+    git-diff-index -M -p $tree > current &&
+    compare_diff_patch current expected'
+
+cat > expected << EOF
+diff --git a/frotz b/frotz
+EOF
+
+test_expect_success \
+    'diff identical, but newly created symlink' \
+    'sleep 1 &&
+    ln -s xyzzy frotz &&
+    git-diff-index -M -p $tree > current &&
+    compare_diff_patch current expected'
+
+cat > expected << EOF
+diff --git a/frotz b/frotz
+index 7c465af..df1db54 120000
+--- a/frotz
++++ b/frotz
+@@ -1 +1 @@
+-xyzzy
+\ No newline at end of file
++yxyyz
+\ No newline at end of file
+EOF
+
+test_expect_success \
+    'diff different symlink' \
+    'rm frotz &&
+    ln -s yxyyz frotz &&
+    git-diff-index -M -p $tree > current &&
+    compare_diff_patch current expected'
+
+test_done
-- 
1.0.GIT
