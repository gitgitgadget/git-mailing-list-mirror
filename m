From: Jeff King <peff@peff.net>
Subject: [PATCH 03/16] more tr portability test script fixes
Date: Wed, 12 Mar 2008 17:31:06 -0400
Message-ID: <20080312213106.GD26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:31:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYYA-0006jq-QX
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYCLVbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYCLVbK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:31:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4851 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbYCLVbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:31:09 -0400
Received: (qmail 2736 invoked by uid 111); 12 Mar 2008 21:31:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:31:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:31:06 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76993>

Dealing with NULs is not always safe with tr. On Solaris,
incoming NULs are silently deleted by both the System V and
UCB versions of tr. When converting to NULs, the System V
version works fine, but the UCB version silently ignores the
request to convert the character.

This patch changes all instances of tr using NULs to use
"perl -pe 'y///'" instead.

Signed-off-by: Jeff King <peff@peff.net>
---
This dramatically increases the amount of perl in the testsuite.
However, it is a portable subset of perl, and it isn't the first perl in
the testsuite.

 t/diff-lib.sh            |    4 ++--
 t/t0020-crlf.sh          |    2 +-
 t/t1300-repo-config.sh   |    4 ++--
 t/t3300-funny-names.sh   |    6 +++---
 t/t4020-diff-external.sh |    2 +-
 t/t4103-apply-binary.sh  |    4 ++--
 t/t4116-apply-reverse.sh |    4 ++--
 t/t4200-rerere.sh        |    2 +-
 t/t5300-pack-object.sh   |    2 +-
 test-sha1.sh             |    4 ++--
 10 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/diff-lib.sh b/t/diff-lib.sh
index 7dc6d7e..28b941c 100644
--- a/t/diff-lib.sh
+++ b/t/diff-lib.sh
@@ -21,8 +21,8 @@ compare_diff_raw_z () {
     # Also we do not check SHA1 hash generation in this test, which
     # is a job for t0000-basic.sh
 
-    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
-    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
+    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
+    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
     git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 90ea081..2bfeac9 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -5,7 +5,7 @@ test_description='CRLF conversion'
 . ./test-lib.sh
 
 q_to_nul () {
-	tr Q '\000'
+	perl -pe 'y/Q/\000/'
 }
 
 q_to_cr () {
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4928a57..b36a901 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -657,12 +657,12 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
 
-git config --null --list | tr '\000' 'Q' > result
+git config --null --list | perl -pe 'y/\000/Q/' > result
 echo >>result
 
 test_expect_success '--null --list' 'cmp result expect'
 
-git config --null --get-regexp 'val[0-9]' | tr '\000' 'Q' > result
+git config --null --get-regexp 'val[0-9]' | perl -pe 'y/\000/Q/' > result
 echo >>result
 
 test_expect_success '--null --get-regexp' 'cmp result expect'
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 98c133d..24a00a9 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -54,7 +54,7 @@ echo 'just space
 no-funny
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git ls-files -z with-funny' \
-	'git ls-files -z | tr \\000 \\012 >current &&
+	'git ls-files -z | perl -pe y/\\000/\\012/ >current &&
 	git diff expected current'
 
 t1=`git write-tree`
@@ -83,11 +83,11 @@ test_expect_success 'git diff-tree with-funny' \
 echo 'A
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git diff-index -z with-funny' \
-	'git diff-index -z --name-status $t0 | tr \\000 \\012 >current &&
+	'git diff-index -z --name-status $t0 | perl -pe y/\\000/\\012/ >current &&
 	git diff expected current'
 
 test_expect_success 'git diff-tree -z with-funny' \
-	'git diff-tree -z --name-status $t0 $t1 | tr \\000 \\012 >current &&
+	'git diff-tree -z --name-status $t0 $t1 | perl -pe y/\\000/\\012/ >current &&
 	git diff expected current'
 
 cat > expected <<\EOF
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 8882933..bf8f778 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -99,7 +99,7 @@ test_expect_success 'no diff with -diff' '
 	git diff | grep Binary
 '
 
-echo NULZbetweenZwords | tr Z '\000' > file
+echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
 
 test_expect_success 'force diff with "diff"' '
 	echo >.gitattributes "file diff" &&
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 7c25634..1b58233 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -24,10 +24,10 @@ git update-index --add --remove file1 file2 file4
 git-commit -m 'Initial Version' 2>/dev/null
 
 git-checkout -b binary
-tr 'x' '\000' <file1 >file3
+perl -pe 'y/x/\000/' <file1 >file3
 cat file3 >file4
 git add file2
-tr '\000' 'v' <file3 >file1
+perl -pe 'y/\000/v/' <file3 >file1
 rm -f file2
 git update-index --add --remove file1 file2 file3 file4
 git-commit -m 'Second Version'
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index b1d35ab..c3f4579 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -12,14 +12,14 @@ test_description='git apply in reverse
 test_expect_success setup '
 
 	for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
-	tr "ijk" '\''\000\001\002'\'' <file1 >file2 &&
+	perl -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
 
 	git add file1 file2 &&
 	git commit -m initial &&
 	git tag initial &&
 
 	for i in a b c g h i J K L m o n p q; do echo $i; done >file1 &&
-	tr "mon" '\''\000\001\002'\'' <file1 >file2 &&
+	perl -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
 
 	git commit -a -m second &&
 	git tag second &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index eeff3c9..3cbfee7 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -129,7 +129,7 @@ test_expect_success 'rerere kicked in' "! grep ======= a1"
 test_expect_success 'rerere prefers first change' 'git diff a1 expect'
 
 rm $rr/postimage
-echo "$sha1	a1" | tr '\012' '\000' > .git/rr-cache/MERGE_RR
+echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/rr-cache/MERGE_RR
 
 test_expect_success 'rerere clear' 'git rerere clear'
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index cd3c149..c955fe4 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -15,7 +15,7 @@ test_expect_success \
     'rm -f .git/index*
      for i in a b c
      do
-	     dd if=/dev/zero bs=4k count=1 | tr "\\000" $i >$i &&
+	     dd if=/dev/zero bs=4k count=1 | perl -pe "y/\\000/$i/" >$i &&
 	     git update-index --add $i || return 1
      done &&
      cat c >d && echo foo >>d && git update-index --add d &&
diff --git a/test-sha1.sh b/test-sha1.sh
index bf526c8..0f0bc5d 100755
--- a/test-sha1.sh
+++ b/test-sha1.sh
@@ -10,7 +10,7 @@ do
 		{
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-			tr '\000' 'g'
+			perl -pe 'y/\000/g/'
 		} | ./test-sha1 $cnt
 	`
 	if test "$expect" = "$actual"
@@ -55,7 +55,7 @@ do
 		{
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-			tr '\000' 'g'
+			perl -pe 'y/\000/g/'
 		} | sha1sum |
 		sed -e 's/ .*//'
 	`
-- 
1.5.4.4.543.g30fdd.dirty
