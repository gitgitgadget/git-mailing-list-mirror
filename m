From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 5/5] t7510: test verify-commit
Date: Mon, 23 Jun 2014 09:05:51 +0200
Message-ID: <340919e5e17a582acaa57faefb362141e64d32a1.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:06:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyyKb-0000rM-I5
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 09:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbaFWHGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 03:06:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49303 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560AbaFWHGB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 03:06:01 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5522B20E64;
	Mon, 23 Jun 2014 03:06:00 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 23 Jun 2014 03:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=6R
	DeLQcUzr4iT4QKVlv5GG+zFlY=; b=rssI7/WDqxxMnywJIzHe9bUdhdNwRMS1sN
	0dEKl2H8UjSysvaggOcEZ7JJsXhmB3KQlGlRCS9H+Bzd9dpAyrbj5D1IBJx/z2Uv
	MY1SoM+PJS+wKmzFnv9EZcDHzapeZuaKwEtVrS9sLlZfeVx6GyoyaP+pVSuwH+td
	JGkJEAaw4=
X-Sasl-enc: jkOPSNtMSwV6+vMXeZCZkQnmZ46mPX5oOBfCVuTNYZc1 1403507160
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0DC296801F1;
	Mon, 23 Jun 2014 03:05:59 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1403506792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252322>

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
index 96cfddf..dd4b948 100755
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
+			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
 			grep "Good signature from" actual &&
 			! grep "BAD signature from" actual || exit 1
@@ -58,6 +59,7 @@ test_expect_success GPG 'show signatures' '
 	(
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
+			test_must_fail git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
 			! grep "Good signature from" actual &&
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
