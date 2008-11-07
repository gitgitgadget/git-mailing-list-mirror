From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] t5516: refactor oddball tests
Date: Fri, 7 Nov 2008 17:20:33 -0500
Message-ID: <20081107222033.GB16058@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:22:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZiC-0003ab-El
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYKGWUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYKGWUh
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:20:37 -0500
Received: from peff.net ([208.65.91.99]:4431 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbYKGWUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:20:37 -0500
Received: (qmail 2883 invoked by uid 111); 7 Nov 2008 22:20:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 17:20:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 17:20:33 -0500
Content-Disposition: inline
In-Reply-To: <20081107220730.GA15942@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100349>

t5516 sets up some utility functions for starting each test
with a clean slate. However, there were a few tests added
that do not use these functions, but instead make their own
repositories.

Let's bring these in line with the rest of the tests. Not
only do we reduce the number of lines, but these tests will
benefit from any further enhancements to the utility
scripts.

The conversion is pretty straightforward. Most of the tests
created a parent/child clone relationship, for which we now
use 'testrepo' as the parent.  One test looked in testrepo,
but relied on previous tests to have set it up; it now sets
up testrepo explicitly, which makes it a bit more robust to
changes in the script, as well.

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of 'next' to pick up the recent test from Clemens
Buchacher.

A few oddities here while I was digging in the history:

  - I actually introduced the first of these tests for local tracking
    refs in 09fba7a59 (and the others, being related, copied the style).
    But then I reverted them in 0673c96, because Alex had added other
    similar tests in t5404.  However, these tests ended up being
    re-added by Dscho in 28391a80, which adds a totally unrelated test.
    I think it's the result of a bad patch application (IIRC, he marked
    up my tests to avoid having them chdir for the whole test script.
    During application, Junio would see them going from tweaks to whole
    creation, and presumably just resolved the conflict that way).

    So my initial thought was to simply delete these tests. But since
    then, other related tests have been added to this script, and we do
    want to keep those. So I decided to keep them all, as they form a
    logical progression related to tracking refs. So while there is some
    duplication with t5404, I don't think it is a problem.

  - One of the tests called 'pwd', and I can't see that it would do
    anything useful. I assume it was just leftover debugging cruft
    (especially since it is from that same commit by Dscho).

 t/t5516-fetch-push.sh |   50 ++++++++++++++++++++----------------------------
 1 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 598664c..3411107 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -39,6 +39,11 @@ mk_test () {
 	)
 }
 
+mk_child() {
+	rm -rf "$1" &&
+	git clone testrepo "$1"
+}
+
 check_push_result () {
 	(
 		cd testrepo &&
@@ -425,13 +430,10 @@ test_expect_success 'push with dry-run' '
 
 test_expect_success 'push updates local refs' '
 
-	rm -rf parent child &&
-	mkdir parent &&
-	(cd parent && git init &&
-		echo one >foo && git add foo && git commit -m one) &&
-	git clone parent child &&
+	mk_test heads/master &&
+	mk_child child &&
 	(cd child &&
-		echo two >foo && git commit -a -m two &&
+		git pull .. master &&
 		git push &&
 	test $(git rev-parse master) = $(git rev-parse remotes/origin/master))
 
@@ -439,15 +441,10 @@ test_expect_success 'push updates local refs' '
 
 test_expect_success 'push updates up-to-date local refs' '
 
-	rm -rf parent child &&
-	mkdir parent &&
-	(cd parent && git init &&
-		echo one >foo && git add foo && git commit -m one) &&
-	git clone parent child1 &&
-	git clone parent child2 &&
-	(cd child1 &&
-		echo two >foo && git commit -a -m two &&
-		git push) &&
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(cd child1 && git pull .. master && git push) &&
 	(cd child2 &&
 		git pull ../child1 master &&
 		git push &&
@@ -457,11 +454,8 @@ test_expect_success 'push updates up-to-date local refs' '
 
 test_expect_success 'push preserves up-to-date packed refs' '
 
-	rm -rf parent child &&
-	mkdir parent &&
-	(cd parent && git init &&
-		echo one >foo && git add foo && git commit -m one) &&
-	git clone parent child &&
+	mk_test heads/master &&
+	mk_child child &&
 	(cd child &&
 		git push &&
 	! test -f .git/refs/remotes/origin/master)
@@ -470,15 +464,13 @@ test_expect_success 'push preserves up-to-date packed refs' '
 
 test_expect_success 'push does not update local refs on failure' '
 
-	rm -rf parent child &&
-	mkdir parent &&
-	(cd parent && git init &&
-		echo one >foo && git add foo && git commit -m one &&
-		echo exit 1 >.git/hooks/pre-receive &&
-		chmod +x .git/hooks/pre-receive) &&
-	git clone parent child &&
+	mk_test heads/master &&
+	mk_child child &&
+	mkdir testrepo/.git/hooks &&
+	echo exit 1 >testrepo/.git/hooks/pre-receive &&
+	chmod +x testrepo/.git/hooks/pre-receive &&
 	(cd child &&
-		echo two >foo && git commit -a -m two &&
+		git pull .. master
 		test_must_fail git push &&
 		test $(git rev-parse master) != \
 			$(git rev-parse remotes/origin/master))
@@ -487,7 +479,7 @@ test_expect_success 'push does not update local refs on failure' '
 
 test_expect_success 'allow deleting an invalid remote ref' '
 
-	pwd &&
+	mk_test heads/master &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
-- 
1.6.0.3.866.gc189b
