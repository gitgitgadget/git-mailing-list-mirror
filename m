From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Thu, 12 Jun 2014 14:39:01 -0500
Message-ID: <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 21:39:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAqS-0006wg-Es
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbaFLTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:39:23 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45282 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752059AbaFLTjV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 15:39:21 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0B3CC647;
	Thu, 12 Jun 2014 15:39:21 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 12 Jun 2014 15:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=
	mesmtp; bh=3+zo+dKYfiaGlWEgMulwSy2w+bc=; b=e2VfrtRF7E0BsMdi4aR54
	Zi6b/dYAGjZ30KasmwSlbmc87d1Fb4AQmcyH3od4/CNexyydy5gvS+6ENh5SAZ6z
	AhqPzy2ZmRihbx1U85yDo+fxUXey68PyFzRGa/gPcDG4JcejOsHCtqYNFSLB/kHj
	fiPRBcq6XqRfDwiHwgKA3o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=3+zo+dKYfiaGlWEgMulwSy2w+
	bc=; b=Z5WXLCsWsfhjgy53n94Q0CVqrm/fqnbyvd109Bmma8ix5EprqRjvmSE50
	O7PzK0VE0rCG6okSUaVJNYrUGoWq79f9Zkwvl/kS1HueJYwQ1VPQrpWWB3mvvgZw
	cNt8s0sacTvv3xlISY+Xh6G751E21Vg0qeFJT+PV0z1NwVwa4w=
X-Sasl-enc: Dm5wtFJ3Iql8Gdt+hJvgoi62Ngki2uLjCU9yDWUxQzWt 1402601960
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id D2A7E680184;
	Thu, 12 Jun 2014 15:39:19 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251488>

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
