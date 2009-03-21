From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 07/16] Skip tests that fail if the executable bit is not handled by the filesystem
Date: Sat, 21 Mar 2009 22:26:30 +0100
Message-ID: <4cc90ded4ca612650968d84233cf84993d4359a2.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lf-0004Ii-QJ
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbZCUV1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbZCUV1L
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27942 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 987D4CDF88;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3C3074279F;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114065>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3701-add-interactive.sh     |    9 +++++----
 t/t4102-apply-rename.sh        |    8 +++++---
 t/t4129-apply-samemode.sh      |   19 +++++++++++++------
 t/t6031-merge-recursive.sh     |   13 +++++++++++++
 t/t9200-git-cvsexportcommit.sh |   13 ++++++-------
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index e95663d..fe01783 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -135,10 +135,12 @@ test_expect_success 'real edit works' '
 
 if test "$(git config --bool core.filemode)" = false
 then
-    say 'skipping filemode tests (filesystem does not properly support modes)'
+	say 'skipping filemode tests (filesystem does not properly support modes)'
 else
+	test_set_prereq FILEMODE
+fi
 
-test_expect_success 'patch does not affect mode' '
+test_expect_success FILEMODE 'patch does not affect mode' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -147,7 +149,7 @@ test_expect_success 'patch does not affect mode' '
 	git diff file | grep "new mode"
 '
 
-test_expect_success 'stage mode but not hunk' '
+test_expect_success FILEMODE 'stage mode but not hunk' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -156,7 +158,6 @@ test_expect_success 'stage mode but not hunk' '
 	git diff          file | grep "+content"
 '
 
-fi
 # end of tests disabled when filemode is not usable
 
 test_done
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index d42abff..1597965 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -31,14 +31,16 @@ test_expect_success setup \
 test_expect_success apply \
     'git apply --index --stat --summary --apply test-patch'
 
-if [ "$(git config --get core.filemode)" = false ]
+if test "$(git config --bool core.filemode)" = false
 then
 	say 'filemode disabled on the filesystem'
 else
-	test_expect_success validate \
-	    'test -f bar && ls -l bar | grep "^-..x......"'
+	test_set_prereq FILEMODE
 fi
 
+test_expect_success FILEMODE validate \
+	    'test -f bar && ls -l bar | grep "^-..x......"'
+
 test_expect_success 'apply reverse' \
     'git apply -R --index --stat --summary --apply test-patch &&
      test "$(cat foo)" = "This is foo"'
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index adfcbb5..fc7af04 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -4,6 +4,13 @@ test_description='applying patch with mode bits'
 
 . ./test-lib.sh
 
+if test "$(git config --bool core.filemode)" = false
+then
+	say 'filemode disabled on the filesystem'
+else
+	test_set_prereq FILEMODE
+fi
+
 test_expect_success setup '
 	echo original >file &&
 	git add file &&
@@ -16,14 +23,14 @@ test_expect_success setup '
 	git diff --stat -p >patch-1.txt
 '
 
-test_expect_success 'same mode (no index)' '
+test_expect_success FILEMODE 'same mode (no index)' '
 	git reset --hard &&
 	chmod +x file &&
 	git apply patch-0.txt &&
 	test -x file
 '
 
-test_expect_success 'same mode (with index)' '
+test_expect_success FILEMODE 'same mode (with index)' '
 	git reset --hard &&
 	chmod +x file &&
 	git add file &&
@@ -32,7 +39,7 @@ test_expect_success 'same mode (with index)' '
 	git diff --exit-code
 '
 
-test_expect_success 'same mode (index only)' '
+test_expect_success FILEMODE 'same mode (index only)' '
 	git reset --hard &&
 	chmod +x file &&
 	git add file &&
@@ -40,20 +47,20 @@ test_expect_success 'same mode (index only)' '
 	git ls-files -s file | grep "^100755"
 '
 
-test_expect_success 'mode update (no index)' '
+test_expect_success FILEMODE 'mode update (no index)' '
 	git reset --hard &&
 	git apply patch-1.txt &&
 	test -x file
 '
 
-test_expect_success 'mode update (with index)' '
+test_expect_success FILEMODE 'mode update (with index)' '
 	git reset --hard &&
 	git apply --index patch-1.txt &&
 	test -x file &&
 	git diff --exit-code
 '
 
-test_expect_success 'mode update (index only)' '
+test_expect_success FILEMODE 'mode update (index only)' '
 	git reset --hard &&
 	git apply --cached patch-1.txt &&
 	git ls-files -s file | grep "^100755"
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index 41c6860..8a3304f 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -3,6 +3,11 @@
 test_description='merge-recursive: handle file mode'
 . ./test-lib.sh
 
+if ! test "$(git config --bool core.filemode)" = false
+then
+	test_set_prereq FILEMODE
+fi
+
 test_expect_success 'mode change in one branch: keep changed version' '
 	: >file1 &&
 	git add file1 &&
@@ -16,6 +21,10 @@ test_expect_success 'mode change in one branch: keep changed version' '
 	git commit -m b1 &&
 	git checkout a1 &&
 	git merge-recursive master -- a1 b1 &&
+	git ls-files -s file1 | grep ^100755
+'
+
+test_expect_success FILEMODE 'verify executable bit on file' '
 	test -x file1
 '
 
@@ -41,6 +50,10 @@ test_expect_success 'mode change in both branches: expect conflict' '
 		echo "100644 $H 3	file2"
 	) >expect &&
 	test_cmp actual expect &&
+	git ls-files -s file2 | grep ^100755
+'
+
+test_expect_success FILEMODE 'verify executable bit on file' '
 	test -x file2
 '
 
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index d28b71b..995f607 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -225,11 +225,12 @@ test_expect_success \
       test_must_fail git cvsexportcommit -c $id
       )'
 
-case "$(git config --bool core.filemode)" in
-false)
-	;;
-*)
-test_expect_success \
+if ! test "$(git config --bool core.filemode)" = false
+then
+	test_set_prereq FILEMODE
+fi
+
+test_expect_success FILEMODE \
      'Retain execute bit' \
      'mkdir G &&
       echo executeon >G/on &&
@@ -243,8 +244,6 @@ test_expect_success \
       test -x G/on &&
       ! test -x G/off
       )'
-	;;
-esac
 
 test_expect_success '-w option should work with relative GIT_DIR' '
       mkdir W &&
-- 
1.6.2.1.224.g2225f
