From: "" <caleb@calebthompson.io>
Subject: [PATCH v4 3/4] commit test: test_set_editor in each test
Date: Wed, 11 Jun 2014 13:24:38 -0500
Message-ID: <1402511079-17735-4-git-send-email-caleb@calebthompson.io>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 20:32:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WunKL-0003Zp-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 20:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbaFKScj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 14:32:39 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38696 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753806AbaFKScf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 14:32:35 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8E53D63C;
	Wed, 11 Jun 2014 14:25:12 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 11 Jun 2014 14:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=
	mesmtp; bh=3+zo+dKYfiaGlWEgMulwSy2w+bc=; b=lQLIYskgAIshgiw+ThEQX
	Mq7rNeEyOOmI/n0mw17pi2n2XNh+celYId1NNNtOcFiufS3QyRVP3PIqirKTb+Uq
	zG/O7g7BTOLIp7wHuP4D3yOuSl4QTgwklZd5H6Wg9sTAEhGZ7DICmIzGvClo5cDm
	Xg6NvUXrNxHWTTe1hW0bTM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=3+zo+dKYfiaGlWEgMulwSy2w+
	bc=; b=A8Xa+lmVCx6XZBfa4+QH+PMG8wFWpd4yvmytopv4eBdgrluilaVHa3VPS
	9SQLx0x1I5MNYgvQyUS+XSCxFGw/12Ah8UkRl2cSdkeNzD9wH2tf9VqlnHqaLiCF
	Q05OCwXG+o/DnzgbV3onZIcuFWM0ump08YdIrq4XMFU4dHSAW4=
X-Sasl-enc: ZT79yWKJGMM7UZV1CaqTV5mkSPUX26zKOXaJBL5vBdED 1402511111
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id C3949680537;
	Wed, 11 Jun 2014 14:25:10 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251379>

t/t7507-commit-verbose.sh was using a global test_set_editor call to
build its environment.

Improve robustness against global state changes by having only tests
which intend to use the $EDITOR to check for presence of a diff in the
editor set up the test-editor to use check-for-diff rather than relying
upon the editor set once at script start.

Besides being in line with current practices, it also allows the tests
which set GIT_EDITOR=cat manually to avoid using a subshell and simplify
their logic.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 t/t7507-commit-verbose.sh | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index db09107..35a4d06 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -6,7 +6,6 @@ test_description='verbose commit template'
 write_script check-for-diff <<-'EOF'
	exec grep '^diff --git' "$1"
 EOF
-test_set_editor "$PWD/check-for-diff"

 cat >message <<'EOF'
 subject
@@ -21,6 +20,7 @@ test_expect_success 'setup' '
 '

 test_expect_success 'initial commit shows verbose diff' '
+	test_set_editor "$PWD/check-for-diff" &&
	git commit --amend -v
 '

@@ -36,11 +36,13 @@ check_message() {
 }

 test_expect_success 'verbose diff is stripped out' '
+	test_set_editor "$PWD/check-for-diff" &&
	git commit --amend -v &&
	check_message message
 '

 test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
+	test_set_editor "$PWD/check-for-diff" &&
	test_config diff.mnemonicprefix true &&
	git commit --amend -v &&
	check_message message
@@ -77,20 +79,14 @@ test_expect_success 'submodule log is stripped out too with -v' '
		echo "more" >>file &&
		git commit -a -m "submodule commit"
	) &&
-	(
-		GIT_EDITOR=cat &&
-		export GIT_EDITOR &&
-		test_must_fail git commit -a -v 2>err
-	) &&
+	test_set_editor cat &&
+	test_must_fail git commit -a -v 2>err &&
	test_i18ngrep "Aborting commit due to empty commit message." err
 '

 test_expect_success 'verbose diff is stripped out with set core.commentChar' '
-	(
-		GIT_EDITOR=cat &&
-		export GIT_EDITOR &&
-		test_must_fail git -c core.commentchar=";" commit -a -v 2>err
-	) &&
+	test_set_editor cat &&
+	test_must_fail git -c core.commentchar=";" commit -a -v 2>err &&
	test_i18ngrep "Aborting commit due to empty commit message." err
 '

--
2.0.0
