From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 5/6] t7510: test verify-commit
Date: Fri, 13 Jun 2014 12:42:47 +0200
Message-ID: <3aaf65288733117909150771cc62508f3236d107.1402655839.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:43:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOwt-0007ft-5W
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbaFMKnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:43:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41734 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbaFMKnA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 06:43:00 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6B8AB20F9C;
	Fri, 13 Jun 2014 06:42:58 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 13 Jun 2014 06:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Zu
	VYUum9TBqDV0NS6DaIrMoIaDE=; b=q+xInUGg79GgHDk5rddwTz7sFwBBQiauOL
	i191NIfIvVhvreoRSqOGvcn6zi4w9QIPh4b7avLHy7Y5kiCHhY3kJ0+t0QPZ+L4v
	aEBswGFIMspf0N0uLJSh9xNenLYy/8OD10WO1nlpkypMOe/LZwkEtX4pT6Eef10I
	cJU3ydllA=
X-Sasl-enc: Y6zL0bWk5HZUP+//cohPm7Av1XH9jvZ8mHsw9DBmwerm 1402656178
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 06E376800F2;
	Fri, 13 Jun 2014 06:42:57 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251540>

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
index a5ba48e..89941a7 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -45,10 +45,11 @@ test_expect_success GPG 'create signed commits' '
 	git tag seventh-signed
 '
 
-test_expect_success GPG 'show signatures' '
+test_expect_success GPG 'verify and show signatures' '
 	(
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
 		do
+			git verify-commit $commit || exit 1
 			git show --pretty=short --show-signature $commit >actual || exit 1
 			grep "Good signature from" actual || exit 1
 			! grep "BAD signature from" actual || exit 1
@@ -58,6 +59,7 @@ test_expect_success GPG 'show signatures' '
 	(
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
+			! git verify-commit $commit || exit 1
 			git show --pretty=short --show-signature $commit >actual || exit 1
 			grep "Good signature from" actual && exit 1
 			! grep "BAD signature from" actual || exit 1
@@ -66,11 +68,25 @@ test_expect_success GPG 'show signatures' '
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
 	git cat-file commit master >raw &&
 
 	sed -e "s/seventh/7th forged/" raw >forged1 &&
 	git hash-object -w -t commit forged1 >forged1.commit &&
+	! git verify-commit $(cat forged1.commit) &&
 	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
 	grep "BAD signature from" actual1 &&
 	! grep "Good signature from" actual1
@@ -81,6 +97,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 	cat raw >forged2 &&
 	echo Qwik | tr "Q" "\000" >>forged2 &&
 	git hash-object -w -t commit forged2 >forged2.commit &&
+	! git verify-commit $(cat forged2.commit) &&
 	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
 	grep "BAD signature from" actual2 &&
 	! grep "Good signature from" actual2
@@ -89,6 +106,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 test_expect_success GPG 'amending already signed commit' '
 	git checkout fourth-signed^0 &&
 	git commit --amend -S --no-edit &&
+	git verify-commit HEAD &&
 	git show -s --show-signature HEAD >actual &&
 	grep "Good signature from" actual &&
 	! grep "BAD signature from" actual
-- 
2.0.0.426.g37dbf84
