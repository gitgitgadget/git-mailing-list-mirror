From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/3] contrib/subtree: Fix broken &&-chains and revealed test error
Date: Mon, 22 Jun 2015 14:53:29 +0100
Message-ID: <1434981210-13036-2-git-send-email-charles@hashpling.org>
References: <1434981210-13036-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:53:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Ac-0000dB-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 15:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbbFVNxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 09:53:43 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:33180 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123AbbFVNxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 09:53:36 -0400
Received: from hashpling.plus.com ([212.159.69.125]:60387)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z72AI-0004JB-Bj; Mon, 22 Jun 2015 14:53:34 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434981210-13036-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272340>

From: Charles Bailey <cbailey32@bloomberg.net>

This fixes two instances where a &&-chain was broken in the subtree
tests and fixes a test error that was revealed because of this.

Many tests in t7900-subtree.sh make a commit and then use 'undo' to
reset the state for the next test. In the 'check hash of split' test,
an 'undo' was being invoked after a 'subtree split' even though the
particular invocation of 'subtree split' did not actually make a commit.
The subsequent check_equal was failing, but this failure was masked by
that broken &&-chain.

Removing this undo causes the failing check_equal to succeed but breaks
the a check_equal later on in the same test.

It turns out that an earlier test ('check if --message for merge works
with squash too') makes a commit but doesn't 'undo' to the state
expected by the remaining tests. None of the intervening tests cared
enough about the state of the test repo to fail and the spurious 'undo'
in 'check hash of split' restored the expected state for any remaining
test that might care.

Adding the missing 'undo' to 'check if --message for merge works
with squash too' and removing the spurious one from 'check hash of
split' fixes all tests once the &&-chains are completed.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 contrib/subtree/t/t7900-subtree.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 2c5bfc1..001c604 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -177,7 +177,8 @@ test_expect_success 'check if --message for merge works with squash too' '
 test_expect_success 'merge new subproj history into subdir' '
 	git subtree merge --prefix=subdir FETCH_HEAD &&
 	git branch pre-split &&
-	check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline"
+	check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline" &&
+	undo
 '
 
 test_expect_success 'Check that prefix argument is required for split' '
@@ -218,9 +219,8 @@ test_expect_success 'check split with --branch' '
 
 test_expect_success 'check hash of split' '
 	spl1=$(git subtree split --prefix subdir) &&
-	undo &&
 	git subtree split --prefix subdir --branch splitbr1test &&
-	check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
+	check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1" &&
 	git checkout splitbr1test &&
 	new_hash=$(git rev-parse HEAD~2) &&
 	git checkout mainline &&
@@ -269,7 +269,7 @@ test_expect_success 'add sub9' '
 cd ..
 
 test_expect_success 'split for sub8' '
-	split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
+	split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"'' &&
 	git branch split2 "$split2"
 '
 
-- 
2.4.0.53.g8440f74
