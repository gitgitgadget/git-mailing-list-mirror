From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 4/4] t7510: test verify-commit
Date: Fri, 27 Jun 2014 16:13:26 +0200
Message-ID: <02b475e94770ed809e18e6258d593242abd23569.1403877431.git.git@drmicha.warpmail.net>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 16:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0WuP-0007Si-BN
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 16:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbaF0ONj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 10:13:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46384 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779AbaF0ONi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 10:13:38 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9399D21ACC
	for <git@vger.kernel.org>; Fri, 27 Jun 2014 10:13:34 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 27 Jun 2014 10:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Dn
	OGSa2YfiQAWUHpzgvMUl9H6yI=; b=q+fdC2Webl03WHi9J6pSUhp0SjbD6dr677
	6oPBFP37pOlrIyG/iXJUYff2n5AmiGnjLb4teACdjn619Vohf6O4t7OKFtnNqHtL
	kmpJGg9cKzUKldJZVcUE396RO40D02ZCgPh6J6oC+ZFxDUZREEVfkhd1wYL3EFQ/
	T/DP/fJRk=
X-Sasl-enc: zm99FR4AcGEM7TRcxmCV2QsLZZKoXLa0d8r2rYHtAhWu 1403878414
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1344CC007B3;
	Fri, 27 Jun 2014 10:13:33 -0400 (EDT)
X-Mailer: git-send-email 2.0.1.563.g162087b.dirty
In-Reply-To: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1403877430.git.git@drmicha.warpmail.net>
References: <cover.1403877430.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252555>

This mixes the "git verify-commit" tests in with the "git show
--show-signature" tests, to keep the tests more readable.

The tests already mix in the "call show" tests with the "verify" tests.
So in case of a test beakage, a '-v' run would be needed to reveal the
exact point of breakage anyway.

Additionally, test the actual output of "git verify-commit" and "git
show --show-signature" and compare to "git cat-file".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7510-signed-commit.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index e97477a..474dab3 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -48,10 +48,11 @@ test_expect_success GPG 'create signed commits' '
 	git tag eighth-signed-alt
 '
 
-test_expect_success GPG 'show signatures' '
+test_expect_success GPG 'verify and show signatures' '
 	(
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
 		do
+			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
 			grep "Good signature from" actual &&
 			! grep "BAD signature from" actual &&
@@ -61,6 +62,7 @@ test_expect_success GPG 'show signatures' '
 	(
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
+			test_must_fail git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
 			! grep "Good signature from" actual &&
 			! grep "BAD signature from" actual &&
@@ -79,11 +81,25 @@ test_expect_success GPG 'show signatures' '
 	)
 '
 
+test_expect_success GPG 'show signed commit with signature' '
+	git show -s initial >commit &&
+	git show -s --show-signature initial >show &&
+	git verify-commit -v initial >verify.1 2>verify.2 &&
+	git cat-file commit initial >cat &&
+	grep -v "gpg: " show >show.commit &&
+	grep "gpg: " show >show.gpg &&
+	grep -v "^ " cat | grep -v "^gpgsig " >cat.commit &&
+	test_cmp show.commit commit &&
+	test_cmp show.gpg verify.2 &&
+	test_cmp cat.commit verify.1
+'
+
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file commit seventh-signed >raw &&
 
 	sed -e "s/seventh/7th forged/" raw >forged1 &&
 	git hash-object -w -t commit forged1 >forged1.commit &&
+	! git verify-commit $(cat forged1.commit) &&
 	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
 	grep "BAD signature from" actual1 &&
 	! grep "Good signature from" actual1
@@ -94,6 +110,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 	cat raw >forged2 &&
 	echo Qwik | tr "Q" "\000" >>forged2 &&
 	git hash-object -w -t commit forged2 >forged2.commit &&
+	! git verify-commit $(cat forged2.commit) &&
 	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
 	grep "BAD signature from" actual2 &&
 	! grep "Good signature from" actual2
@@ -102,6 +119,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 test_expect_success GPG 'amending already signed commit' '
 	git checkout fourth-signed^0 &&
 	git commit --amend -S --no-edit &&
+	git verify-commit HEAD &&
 	git show -s --show-signature HEAD >actual &&
 	grep "Good signature from" actual &&
 	! grep "BAD signature from" actual
-- 
2.0.1.563.g162087b.dirty
