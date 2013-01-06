From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/4] t5000, t5002: move ZIP tests into their own script
Date: Sun, 06 Jan 2013 18:51:34 +0100
Message-ID: <50E9B9A6.5070400@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 18:52:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TruO5-0005XP-2h
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 18:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab3AFRvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 12:51:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:37107 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069Ab3AFRvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 12:51:37 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id DD277193;
	Sun,  6 Jan 2013 18:51:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E9B82D.50005@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212829>

This makes ZIP specific tweaks easier.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh    |  69 ----------------------------
 t/t5002-archive-zip.sh | 119 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 69 deletions(-)
 create mode 100755 t/t5002-archive-zip.sh

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 6702157..e7c240f 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,37 +25,11 @@ commit id embedding:
 '
 
 . ./test-lib.sh
-GIT_UNZIP=${GIT_UNZIP:-unzip}
 GZIP=${GZIP:-gzip}
 GUNZIP=${GUNZIP:-gzip -d}
 
 SUBSTFORMAT=%H%n
 
-test_lazy_prereq UNZIP '
-	"$GIT_UNZIP" -v >/dev/null 2>&1
-	test $? -ne 127
-'
-
-check_zip() {
-	zipfile=$1.zip
-	listfile=$1.lst
-	dir=$1
-	dir_with_prefix=$dir/$2
-
-	test_expect_success UNZIP " extract ZIP archive" '
-		(mkdir $dir && cd $dir && "$GIT_UNZIP" ../$zipfile)
-	'
-
-	test_expect_success UNZIP " validate filenames" "
-		(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
-		test_cmp a.lst $listfile
-	"
-
-	test_expect_success UNZIP " validate file contents" "
-		diff -r a ${dir_with_prefix}a
-	"
-}
-
 test_expect_success \
     'populate workdir' \
     'mkdir a b c &&
@@ -206,55 +180,12 @@ test_expect_success \
       test_cmp a/substfile2 g/prefix/a/substfile2
 '
 
-test_expect_success \
-    'git archive --format=zip' \
-    'git archive --format=zip HEAD >d.zip'
-
-check_zip d
-
-test_expect_success \
-    'git archive --format=zip in a bare repo' \
-    '(cd bare.git && git archive --format=zip HEAD) >d1.zip'
-
-test_expect_success \
-    'git archive --format=zip vs. the same in a bare repo' \
-    'test_cmp d.zip d1.zip'
-
-test_expect_success 'git archive --format=zip with --output' \
-    'git archive --format=zip --output=d2.zip HEAD &&
-    test_cmp d.zip d2.zip'
-
-test_expect_success 'git archive with --output, inferring format' '
-	git archive --output=d3.zip HEAD &&
-	test_cmp d.zip d3.zip
-'
-
 test_expect_success 'git archive with --output, override inferred format' '
 	git archive --format=tar --output=d4.zip HEAD &&
 	test_cmp b.tar d4.zip
 '
 
 test_expect_success \
-    'git archive --format=zip with prefix' \
-    'git archive --format=zip --prefix=prefix/ HEAD >e.zip'
-
-check_zip e prefix/
-
-test_expect_success 'git archive -0 --format=zip on large files' '
-	test_config core.bigfilethreshold 1 &&
-	git archive -0 --format=zip HEAD >large.zip
-'
-
-check_zip large
-
-test_expect_success 'git archive --format=zip on large files' '
-	test_config core.bigfilethreshold 1 &&
-	git archive --format=zip HEAD >large-compressed.zip
-'
-
-check_zip large-compressed
-
-test_expect_success \
     'git archive --list outside of a git repo' \
     'GIT_DIR=some/non-existing/directory git archive --list'
 
diff --git a/t/t5002-archive-zip.sh b/t/t5002-archive-zip.sh
new file mode 100755
index 0000000..ac9c6d4
--- /dev/null
+++ b/t/t5002-archive-zip.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description='git archive --format=zip test'
+
+. ./test-lib.sh
+GIT_UNZIP=${GIT_UNZIP:-unzip}
+
+SUBSTFORMAT=%H%n
+
+test_lazy_prereq UNZIP '
+	"$GIT_UNZIP" -v >/dev/null 2>&1
+	test $? -ne 127
+'
+
+check_zip() {
+	zipfile=$1.zip
+	listfile=$1.lst
+	dir=$1
+	dir_with_prefix=$dir/$2
+
+	test_expect_success UNZIP " extract ZIP archive" '
+		(mkdir $dir && cd $dir && "$GIT_UNZIP" ../$zipfile)
+	'
+
+	test_expect_success UNZIP " validate filenames" "
+		(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
+		test_cmp a.lst $listfile
+	"
+
+	test_expect_success UNZIP " validate file contents" "
+		diff -r a ${dir_with_prefix}a
+	"
+}
+
+test_expect_success \
+    'populate workdir' \
+    'mkdir a b c &&
+     echo simple textfile >a/a &&
+     mkdir a/bin &&
+     cp /bin/sh a/bin &&
+     printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
+     printf "A not substituted O" >a/substfile2 &&
+     if test_have_prereq SYMLINKS; then
+	ln -s a a/l1
+     else
+	printf %s a > a/l1
+     fi &&
+     (p=long_path_to_a_file && cd a &&
+      for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
+      echo text >file_with_long_path) &&
+     (cd a && find .) | sort >a.lst'
+
+test_expect_success \
+    'add ignored file' \
+    'echo ignore me >a/ignored &&
+     echo ignored export-ignore >.git/info/attributes'
+
+test_expect_success \
+    'add files to repository' \
+    'find a -type f | xargs git update-index --add &&
+     find a -type l | xargs git update-index --add &&
+     treeid=`git write-tree` &&
+     echo $treeid >treeid &&
+     git update-ref HEAD $(TZ=GMT GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
+     git commit-tree $treeid </dev/null)'
+
+test_expect_success \
+    'create bare clone' \
+    'git clone --bare . bare.git &&
+     cp .git/info/attributes bare.git/info/attributes'
+
+test_expect_success \
+    'remove ignored file' \
+    'rm a/ignored'
+
+test_expect_success \
+    'git archive --format=zip' \
+    'git archive --format=zip HEAD >d.zip'
+
+check_zip d
+
+test_expect_success \
+    'git archive --format=zip in a bare repo' \
+    '(cd bare.git && git archive --format=zip HEAD) >d1.zip'
+
+test_expect_success \
+    'git archive --format=zip vs. the same in a bare repo' \
+    'test_cmp d.zip d1.zip'
+
+test_expect_success 'git archive --format=zip with --output' \
+    'git archive --format=zip --output=d2.zip HEAD &&
+    test_cmp d.zip d2.zip'
+
+test_expect_success 'git archive with --output, inferring format' '
+	git archive --output=d3.zip HEAD &&
+	test_cmp d.zip d3.zip
+'
+
+test_expect_success \
+    'git archive --format=zip with prefix' \
+    'git archive --format=zip --prefix=prefix/ HEAD >e.zip'
+
+check_zip e prefix/
+
+test_expect_success 'git archive -0 --format=zip on large files' '
+	test_config core.bigfilethreshold 1 &&
+	git archive -0 --format=zip HEAD >large.zip
+'
+
+check_zip large
+
+test_expect_success 'git archive --format=zip on large files' '
+	test_config core.bigfilethreshold 1 &&
+	git archive --format=zip HEAD >large-compressed.zip
+'
+
+check_zip large-compressed
+
+test_done
-- 
1.7.12
