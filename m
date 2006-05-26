From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/4] tests: Remove heredoc usage inside quotes
Date: Thu, 25 May 2006 19:06:16 -0700
Message-ID: <11486091783808-git-send-email-normalperson@yhbt.net>
References: <11486091783542-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 26 04:06:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjRie-00077O-VC
	for gcvg-git@gmane.org; Fri, 26 May 2006 04:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWEZCGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 22:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWEZCGX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 22:06:23 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7062 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030215AbWEZCGU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 22:06:20 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 0733F7DC021; Thu, 25 May 2006 19:06:18 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <11486091783542-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20779>

The use of heredoc inside quoted strings doesn't seem to be
supported by dash.  pdksh seems to handle it fine, however.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 t/t2101-update-index-reupdate.sh |   48 ++++++++++++++++++++------------------
 t/t4012-diff-binary.sh           |   17 +++++--------
 2 files changed, 31 insertions(+), 34 deletions(-)

250810154c837c6999a954fc6bc4318099b67c01
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index 77aed8d..a78ea7f 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -8,15 +8,16 @@ test_description='git-update-index --aga
 
 . ./test-lib.sh
 
+cat > expected <<\EOF
+100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	file1
+100644 9db8893856a8a02eaa73470054b7c1c5a7c82e47 0	file2
+EOF
 test_expect_success 'update-index --add' \
 	'echo hello world >file1 &&
 	 echo goodbye people >file2 &&
 	 git-update-index --add file1 file2 &&
 	 git-ls-files -s >current &&
-	 cmp current - <<\EOF
-100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	file1
-100644 9db8893856a8a02eaa73470054b7c1c5a7c82e47 0	file2
-EOF'
+	 cmp current expected'
 
 test_expect_success 'update-index --again' \
 	'rm -f file1 &&
@@ -29,20 +30,22 @@ test_expect_success 'update-index --agai
 		echo happy - failed as expected
 	fi &&
 	 git-ls-files -s >current &&
-	 cmp current - <<\EOF
-100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	file1
-100644 9db8893856a8a02eaa73470054b7c1c5a7c82e47 0	file2
-EOF'
+	 cmp current expected'
 
+cat > expected <<\EOF
+100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
+EOF
 test_expect_success 'update-index --remove --again' \
 	'git-update-index --remove --again &&
 	 git-ls-files -s >current &&
-	 cmp current - <<\EOF
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF'
+	 cmp current expected'
 
 test_expect_success 'first commit' 'git-commit -m initial'
 
+cat > expected <<\EOF
+100644 53ab446c3f4e42ce9bb728a0ccb283a101be4979 0	dir1/file3
+100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
+EOF
 test_expect_success 'update-index again' \
 	'mkdir -p dir1 &&
 	echo hello world >dir1/file3 &&
@@ -52,11 +55,12 @@ test_expect_success 'update-index again'
 	echo happy >dir1/file3 &&
 	git-update-index --again &&
 	git-ls-files -s >current &&
-	cmp current - <<\EOF
-100644 53ab446c3f4e42ce9bb728a0ccb283a101be4979 0	dir1/file3
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF'
+	cmp current expected'
 
+cat > expected <<\EOF
+100644 d7fb3f695f06c759dbf3ab00046e7cc2da22d10f 0	dir1/file3
+100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
+EOF
 test_expect_success 'update-index --update from subdir' \
 	'echo not so happy >file2 &&
 	cd dir1 &&
@@ -64,19 +68,17 @@ test_expect_success 'update-index --upda
 	git-update-index --again &&
 	cd .. &&
 	git-ls-files -s >current &&
-	cmp current - <<\EOF
-100644 d7fb3f695f06c759dbf3ab00046e7cc2da22d10f 0	dir1/file3
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF'
+	cmp current expected'
 
+cat > expected <<\EOF
+100644 594fb5bb1759d90998e2bf2a38261ae8e243c760 0	dir1/file3
+100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
+EOF
 test_expect_success 'update-index --update with pathspec' \
 	'echo very happy >file2 &&
 	cat file2 >dir1/file3 &&
 	git-update-index --again dir1/ &&
 	git-ls-files -s >current &&
-	cmp current - <<\EOF
-100644 594fb5bb1759d90998e2bf2a38261ae8e243c760 0	dir1/file3
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF'
+	cmp current expected'
 
 test_done
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index bdd95c0..323606c 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -16,25 +16,20 @@ test_expect_success 'prepare repository'
 	 echo git >c &&
 	 cat b b >d'
 
-test_expect_success 'diff without --binary' \
-	'git-diff | git-apply --stat --summary >current &&
-	 cmp current - <<\EOF
+cat > expected <<\EOF
  a |    2 +-
  b |  Bin
  c |    2 +-
  d |  Bin
  4 files changed, 2 insertions(+), 2 deletions(-)
-EOF'
+EOF
+test_expect_success 'diff without --binary' \
+	'git-diff | git-apply --stat --summary >current &&
+	 cmp current expected'
 
 test_expect_success 'diff with --binary' \
 	'git-diff --binary | git-apply --stat --summary >current &&
-	 cmp current - <<\EOF
- a |    2 +-
- b |  Bin
- c |    2 +-
- d |  Bin
- 4 files changed, 2 insertions(+), 2 deletions(-)
-EOF'
+	 cmp current expected'
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-- 
1.3.2.g7d11
