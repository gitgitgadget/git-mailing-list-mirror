From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/4] t3300-funny-names: shell portability fixes
Date: Thu, 25 May 2006 19:06:15 -0700
Message-ID: <11486091783542-git-send-email-normalperson@yhbt.net>
References: <1148609178788-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 26 04:06:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjRie-00077O-EC
	for gcvg-git@gmane.org; Fri, 26 May 2006 04:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWEZCGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 22:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWEZCGV
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 22:06:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:6550 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030204AbWEZCGU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 22:06:20 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id BB37A7DC020; Thu, 25 May 2006 19:06:18 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <1148609178788-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20776>

echo isn't remotely standardized for handling backslashes,
so cat + heredoc seems better

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 t/t3300-funny-names.sh |   51 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 18 deletions(-)

6b5ef54aa860b557f88084c1d642a611f7abcf4d
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 72a93da..c12270e 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -40,9 +40,11 @@ test_expect_success 'git-ls-files no-fun
 t0=`git-write-tree`
 echo "$t0" >t0
 
-echo 'just space
+cat > expected <<\EOF
+just space
 no-funny
-"tabs\t,\" (dq) and spaces"' >expected
+"tabs\t,\" (dq) and spaces"
+EOF
 test_expect_success 'git-ls-files with-funny' \
 	'git-update-index --add "$p1" &&
 	git-ls-files >current &&
@@ -58,14 +60,18 @@ test_expect_success 'git-ls-files -z wit
 t1=`git-write-tree`
 echo "$t1" >t1
 
-echo 'just space
+cat > expected <<\EOF
+just space
 no-funny
-"tabs\t,\" (dq) and spaces"' >expected
+"tabs\t,\" (dq) and spaces"
+EOF
 test_expect_success 'git-ls-tree with funny' \
 	'git-ls-tree -r $t1 | sed -e "s/^[^	]*	//" >current &&
 	 diff -u expected current'
 
-echo 'A	"tabs\t,\" (dq) and spaces"' >expected
+cat > expected <<\EOF
+A	"tabs\t,\" (dq) and spaces"
+EOF
 test_expect_success 'git-diff-index with-funny' \
 	'git-diff-index --name-status $t0 >current &&
 	diff -u expected current'
@@ -84,53 +90,62 @@ test_expect_success 'git-diff-tree -z wi
 	'git-diff-tree -z --name-status $t0 $t1 | tr \\0 \\012 >current &&
 	diff -u expected current'
 
-echo 'CNUM	no-funny	"tabs\t,\" (dq) and spaces"' >expected
+cat > expected <<\EOF
+CNUM	no-funny	"tabs\t,\" (dq) and spaces"
+EOF
 test_expect_success 'git-diff-tree -C with-funny' \
 	'git-diff-tree -C --find-copies-harder --name-status \
 		$t0 $t1 | sed -e 's/^C[0-9]*/CNUM/' >current &&
 	diff -u expected current'
 
-echo 'RNUM	no-funny	"tabs\t,\" (dq) and spaces"' >expected
+cat > expected <<\EOF
+RNUM	no-funny	"tabs\t,\" (dq) and spaces"
+EOF
 test_expect_success 'git-diff-tree delete with-funny' \
 	'git-update-index --force-remove "$p0" &&
 	git-diff-index -M --name-status \
 		$t0 | sed -e 's/^R[0-9]*/RNUM/' >current &&
 	diff -u expected current'
 
-echo 'diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
+cat > expected <<\EOF
+diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
 similarity index NUM%
 rename from no-funny
-rename to "tabs\t,\" (dq) and spaces"' >expected
-
+rename to "tabs\t,\" (dq) and spaces"
+EOF
 test_expect_success 'git-diff-tree delete with-funny' \
 	'git-diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
 	 diff -u expected current'
 
 chmod +x "$p1"
-echo 'diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
+cat > expected <<\EOF
+diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
 old mode 100644
 new mode 100755
 similarity index NUM%
 rename from no-funny
-rename to "tabs\t,\" (dq) and spaces"' >expected
-
+rename to "tabs\t,\" (dq) and spaces"
+EOF
 test_expect_success 'git-diff-tree delete with-funny' \
 	'git-diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
 	 diff -u expected current'
 
-echo >expected ' "tabs\t,\" (dq) and spaces"
- 1 files changed, 0 insertions(+), 0 deletions(-)'
+cat >expected <<\EOF
+ "tabs\t,\" (dq) and spaces"
+ 1 files changed, 0 insertions(+), 0 deletions(-)
+EOF
 test_expect_success 'git-diff-tree rename with-funny applied' \
 	'git-diff-index -M -p $t0 |
 	 git-apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
 	 diff -u expected current'
 
-echo >expected ' no-funny
+cat > expected <<\EOF
+ no-funny
  "tabs\t,\" (dq) and spaces"
- 2 files changed, 3 insertions(+), 3 deletions(-)'
-
+ 2 files changed, 3 insertions(+), 3 deletions(-)
+EOF
 test_expect_success 'git-diff-tree delete with-funny applied' \
 	'git-diff-index -p $t0 |
 	 git-apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-- 
1.3.2.g7d11
