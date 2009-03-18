From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 06/10] test-lib: Introduce test_chmod and use it instead of update-index --chmod
Date: Wed, 18 Mar 2009 22:27:08 +0100
Message-ID: <c44430314c9976a0c30e1b94df49d8217c66fd50.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Kr-000574-If
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbZCRV1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbZCRV1j
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46787 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3D38ECDF92;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CFB8060F0C;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113680>

This function replaces sequences of 'chmod +x' and 'git update-index
--chmod=+x' in the test suite, whose purpose is to help filesystems
that need core.filemode=false. Two places where only 'chmod +x' was used
we also use this new function.

The function calls 'git update-index --chmod' without checking
core.filemode (unlike some of the call sites did). We do this because the
call sites *expect* that the executable bit ends up in the index (ie. it
is not the purpose of the call sites to *test* whether git treats
'chmod +x' and 'update-index --chmod=+x' correctly). Therefore, on
filesystems with core.filemode=true the 'git update-index --chmod' is a
no-op.

The function uses --add with update-index to help one call site in
t6031-merge-recursive. It makes no difference for the other callers.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t1410-reflog.sh                      |    4 +---
 t/t3400-rebase.sh                      |    4 ++--
 t/t4006-diff-mode.sh                   |   19 ++++---------------
 t/t4014-format-patch.sh                |    4 +---
 t/t6031-merge-recursive.sh             |    9 ++-------
 t/t9500-gitweb-standalone-no-errors.sh |   18 +++++-------------
 t/test-lib.sh                          |    9 +++++++++
 7 files changed, 24 insertions(+), 43 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 5b24f05..80af6b9 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -70,9 +70,7 @@ test_expect_success setup '
 	E=`git rev-parse --verify HEAD:A/B/E` &&
 	check_fsck &&
 
-	chmod +x C &&
-	( test "`git config --bool core.filemode`" != false ||
-	  echo executable >>C ) &&
+	test_chmod +x C &&
 	git add C &&
 	test_tick && git commit -m dragon &&
 	L=`git rev-parse --verify HEAD` &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index be7ae5a..6e391a3 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -83,9 +83,9 @@ test_expect_success 'rebase a single mode change' '
      git checkout -b modechange HEAD^ &&
      echo 1 > X &&
      git add X &&
-     chmod a+x A &&
+     test_chmod +x A &&
      test_tick &&
-     git commit -m modechange A X &&
+     git commit -m modechange &&
      GIT_TRACE=1 git rebase master
 '
 
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 4e92fce..8c1b81e 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -15,21 +15,10 @@ test_expect_success \
      tree=`git write-tree` &&
      echo $tree'
 
-if [ "$(git config --get core.filemode)" = false ]
-then
-	say 'filemode disabled on the filesystem, using update-index --chmod=+x'
-	test_expect_success \
-	    'git update-index --chmod=+x' \
-	    'git update-index rezrov &&
-	     git update-index --chmod=+x rezrov &&
-	     git diff-index $tree >current'
-else
-	test_expect_success \
-	    'chmod' \
-	    'chmod +x rezrov &&
-	     git update-index rezrov &&
-	     git diff-index $tree >current'
-fi
+test_expect_success \
+    'chmod' \
+    'test_chmod +x rezrov &&
+     git diff-index $tree >current'
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ebfc4a6..f187d15 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -16,9 +16,7 @@ test_expect_success setup '
 	git checkout -b side &&
 
 	for i in 1 2 5 6 A B C 7 8 9 10; do echo "$i"; done >file &&
-	chmod +x elif &&
-	git update-index file elif &&
-	git update-index --chmod=+x elif &&
+	test_chmod +x elif &&
 	git commit -m "Side changes #1" &&
 
 	for i in D E F; do echo "$i"; done >>file &&
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index 8073e0c..41c6860 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -3,9 +3,6 @@
 test_description='merge-recursive: handle file mode'
 . ./test-lib.sh
 
-# Note that we follow "chmod +x F" with "update-index --chmod=+x F" to
-# help filesystems that do not have the executable bit.
-
 test_expect_success 'mode change in one branch: keep changed version' '
 	: >file1 &&
 	git add file1 &&
@@ -15,8 +12,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
 	git add dummy &&
 	git commit -m a &&
 	git checkout -b b1 master &&
-	chmod +x file1 &&
-	git update-index --chmod=+x file1 &&
+	test_chmod +x file1 &&
 	git commit -m b1 &&
 	git checkout a1 &&
 	git merge-recursive master -- a1 b1 &&
@@ -28,8 +24,7 @@ test_expect_success 'mode change in both branches: expect conflict' '
 	git checkout -b a2 master &&
 	: >file2 &&
 	H=$(git hash-object file2) &&
-	chmod +x file2 &&
-	git update-index --add --chmod=+x file2 &&
+	test_chmod +x file2 &&
 	git commit -m a2 &&
 	git checkout -b b2 master &&
 	: >file2 &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 1b78e28..dce06bc 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -63,14 +63,6 @@ gitweb_run () {
 	# gitweb.log is left for debugging
 }
 
-safe_chmod () {
-	chmod "$1" "$2" &&
-	if [ "$(git config --get core.filemode)" = false ]
-	then
-		git update-index --chmod="$1" "$2"
-	fi
-}
-
 . ./test-lib.sh
 
 perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
@@ -242,7 +234,7 @@ test_debug 'cat gitweb.log'
 
 test_expect_success \
 	'commitdiff(0): mode change' \
-	'safe_chmod +x new_file &&
+	'test_chmod +x new_file &&
 	 git commit -a -m "Mode changed." &&
 	 gitweb_run "p=.git;a=commitdiff"'
 test_debug 'cat gitweb.log'
@@ -281,7 +273,7 @@ test_debug 'cat gitweb.log'
 test_expect_success \
 	'commitdiff(0): mode change and modified' \
 	'echo "New line" >> file2 &&
-	 safe_chmod +x file2 &&
+	 test_chmod +x file2 &&
 	 git commit -a -m "Mode change and modification." &&
 	 gitweb_run "p=.git;a=commitdiff"'
 test_debug 'cat gitweb.log'
@@ -308,7 +300,7 @@ test_expect_success \
 	'commitdiff(0): renamed, mode change and modified' \
 	'git mv file3 file2 &&
 	 echo "Propter nomen suum." >> file2 &&
-	 safe_chmod +x file2 &&
+	 test_chmod +x file2 &&
 	 git commit -a -m "File rename, mode change and modification." &&
 	 gitweb_run "p=.git;a=commitdiff"'
 test_debug 'cat gitweb.log'
@@ -425,10 +417,10 @@ test_expect_success \
 	 git add 03-new &&
 	 git mv 04-rename-from 04-rename-to &&
 	 echo "Changed" >> 04-rename-to &&
-	 safe_chmod +x 05-mode-change &&
+	 test_chmod +x 05-mode-change &&
 	 rm -f 06-file-or-symlink && ln -s 01-change 06-file-or-symlink &&
 	 echo "Changed and have mode changed" > 07-change-mode-change	&&
-	 safe_chmod +x 07-change-mode-change &&
+	 test_chmod +x 07-change-mode-change &&
 	 git commit -a -m "Large commit" &&
 	 git checkout master'
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ace440c..638cca4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -238,6 +238,15 @@ test_merge () {
 	git tag "$1"
 }
 
+# This function helps systems where core.filemode=false is set.
+# Use it instead of plain 'chmod +x' to set or unset the executable bit
+# of a file in the working directory and add it to the index.
+
+test_chmod () {
+	chmod "$@" &&
+	git update-index --add "--chmod=$@"
+}
+
 # You are not expected to call test_ok_ and test_failure_ directly, use
 # the text_expect_* functions instead.
 
-- 
1.6.2.1.224.g2225f
