From: Jeff King <peff@peff.net>
Subject: [PATCH 16/25] t6030: use modern test_* helpers
Date: Fri, 20 Mar 2015 06:13:05 -0400
Message-ID: <20150320101304.GP12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvf-0005qT-VB
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbbCTKNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:35708 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbCTKNH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:07 -0400
Received: (qmail 5909 invoked by uid 102); 20 Mar 2015 10:13:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:07 -0500
Received: (qmail 21626 invoked by uid 107); 20 Mar 2015 10:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:05 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265890>

We can get rid of a lot of hand-rolled error messages by
using test_must_fail and test_expect_code. The existing code
was careful to use "|| return 1" when breaking the
&&-chain, but it did fool --chain-lint; the new code is more
idiomatic.

We also add some uses of test_when_finished, which is less
cryptic and more robust than putting code at the end of a
test. In two cases we run "git bisect reset" from a
subshell, which is a problem for test_when_finished (it
would not run). However, in both of these cases, we are
performing the tests in one-off sub-repos, so we do not need
to clean up at all (and in fact it is nicer not to if the
user wants to inspect the trash directory after a failure).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6030-bisect-porcelain.sh | 91 +++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 60 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e6abe65..06b4868 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -52,15 +52,8 @@ test_expect_success 'bisect starts with only one bad' '
 test_expect_success 'bisect does not start with only one good' '
 	git bisect reset &&
 	git bisect start &&
-	git bisect good $HASH1 || return 1
-
-	if git bisect next
-	then
-		echo Oops, should have failed.
-		false
-	else
-		:
-	fi
+	git bisect good $HASH1 &&
+	test_must_fail git bisect next
 '
 
 test_expect_success 'bisect start with one bad and good' '
@@ -191,34 +184,27 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
 test_expect_success 'bisect skip: successful result' '
+	test_when_finished git bisect reset &&
 	git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$HASH2 is the first bad commit" my_bisect_log.txt &&
-	git bisect reset
+	grep "$HASH2 is the first bad commit" my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3 and $HASH2
 # so we should not be able to tell the first bad commit
 # among $HASH2, $HASH3 and $HASH4
 test_expect_success 'bisect skip: cannot tell between 3 commits' '
+	test_when_finished git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
-	git bisect skip || return 1
-
-	if git bisect skip > my_bisect_log.txt
-	then
-		echo Oops, should have failed.
-		false
-	else
-		test $? -eq 2 &&
-		grep "first bad commit could be any of" my_bisect_log.txt &&
-		! grep $HASH1 my_bisect_log.txt &&
-		grep $HASH2 my_bisect_log.txt &&
-		grep $HASH3 my_bisect_log.txt &&
-		grep $HASH4 my_bisect_log.txt &&
-		git bisect reset
-	fi
+	git bisect skip &&
+	test_expect_code 2 git bisect skip >my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt &&
+	! grep $HASH1 my_bisect_log.txt &&
+	grep $HASH2 my_bisect_log.txt &&
+	grep $HASH3 my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
@@ -226,22 +212,15 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
 # so we should not be able to tell the first bad commit
 # among $HASH3 and $HASH4
 test_expect_success 'bisect skip: cannot tell between 2 commits' '
+	test_when_finished git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
-	git bisect skip || return 1
-
-	if git bisect good > my_bisect_log.txt
-	then
-		echo Oops, should have failed.
-		false
-	else
-		test $? -eq 2 &&
-		grep "first bad commit could be any of" my_bisect_log.txt &&
-		! grep $HASH1 my_bisect_log.txt &&
-		! grep $HASH2 my_bisect_log.txt &&
-		grep $HASH3 my_bisect_log.txt &&
-		grep $HASH4 my_bisect_log.txt &&
-		git bisect reset
-	fi
+	git bisect skip &&
+	test_expect_code 2 git bisect good >my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt &&
+	! grep $HASH1 my_bisect_log.txt &&
+	! grep $HASH2 my_bisect_log.txt &&
+	grep $HASH3 my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is both skipped and bad, we skip $HASH3
@@ -249,24 +228,18 @@ test_expect_success 'bisect skip: cannot tell between 2 commits' '
 # so we should not be able to tell the first bad commit
 # among $HASH3 and $HASH4
 test_expect_success 'bisect skip: with commit both bad and skipped' '
+	test_when_finished git bisect reset &&
 	git bisect start &&
 	git bisect skip &&
 	git bisect bad &&
 	git bisect good $HASH1 &&
 	git bisect skip &&
-	if git bisect good > my_bisect_log.txt
-	then
-		echo Oops, should have failed.
-		false
-	else
-		test $? -eq 2 &&
-		grep "first bad commit could be any of" my_bisect_log.txt &&
-		! grep $HASH1 my_bisect_log.txt &&
-		! grep $HASH2 my_bisect_log.txt &&
-		grep $HASH3 my_bisect_log.txt &&
-		grep $HASH4 my_bisect_log.txt &&
-		git bisect reset
-	fi
+	test_expect_code 2 git bisect good >my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt &&
+	! grep $HASH1 my_bisect_log.txt &&
+	! grep $HASH2 my_bisect_log.txt &&
+	grep $HASH3 my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt
 '
 
 # We want to automatically find the commit that
@@ -601,8 +574,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout specified' '
 		git bisect bad $HASH4 &&
 		git bisect run eval \
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
-			>../nocheckout.log &&
-		git bisect reset
+			>../nocheckout.log
 	) &&
 	grep "$HASH3 is the first bad commit" nocheckout.log
 '
@@ -617,8 +589,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
 		git bisect bad $HASH4 &&
 		git bisect run eval \
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
-			>../defaulted.log &&
-		git bisect reset
+			>../defaulted.log
 	) &&
 	grep "$HASH3 is the first bad commit" defaulted.log
 '
@@ -642,14 +613,14 @@ test_expect_success 'broken branch creation' '
 	mkdir missing &&
 	:> missing/MISSING &&
 	git add missing/MISSING &&
-	git commit -m "6(broken): Added file that will be deleted"
+	git commit -m "6(broken): Added file that will be deleted" &&
 	git tag BROKEN_HASH6 &&
 	add_line_into_file "7(broken): second line on a broken branch" hello2 &&
 	git tag BROKEN_HASH7 &&
 	add_line_into_file "8(broken): third line on a broken branch" hello2 &&
 	git tag BROKEN_HASH8 &&
 	git rm missing/MISSING &&
-	git commit -m "9(broken): Remove missing file"
+	git commit -m "9(broken): Remove missing file" &&
 	git tag BROKEN_HASH9 &&
 	rm .git/objects/39/f7e61a724187ab767d2e08442d9b6b9dab587d
 '
-- 
2.3.3.520.g3cfbb5d
