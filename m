From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v6 3/4] commit test: test_set_editor in each test
Date: Tue, 17 Jun 2014 14:38:59 -0500
Message-ID: <41484002d48514cc6eefc1bebbf6fea8d0f93a40.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 21:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwzE8-0007ID-QU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbaFQTjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:39:24 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38655 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933376AbaFQTjW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 15:39:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9A4D4684;
	Tue, 17 Jun 2014 15:39:21 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 17 Jun 2014 15:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references; s=mesmtp; bh=dpAuuuPZDWLXisv1JVEX4b8L/B
	4=; b=DdyhVtlVce5CxqXvdLjuSh68xluZsnLXDHyxmsDI4J3iool3pfavIjofep
	JlqLJA+IjjO1EJB4q8E1PGSGnHidOLjvB+xjcn/umxkQeNEJxz/EivFq8TGoBElL
	wJ4QG7OlVip3jCAKTu+VxvYkfirqthaJk0M4+9Kfm5qASnL9Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=dp
	AuuuPZDWLXisv1JVEX4b8L/B4=; b=adXXHL3skd83pK7jA9x2J7huGn1ljtvFUG
	ad3Dbtd5dSu3mgwIqX2MLkAc0ethAUqjMY7jlVjaWbPKYsSm/fGoAfJ1o+XUpcvl
	+v9UWDDg3eGihM5szOuEHLv4c6G1FW8jK/hU0pFDtPsSuDU+07FqHdEg6hUKJt47
	chjGkUWO8=
X-Sasl-enc: e0+yMojKCJyoeNnkr4aBaYiWqnV13MJKpPt9biLK22YF 1403033952
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 296E4C007BD;
	Tue, 17 Jun 2014 15:39:12 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251942>

t/t7507-commit-verbose.sh was using a global test_set_editor call to
build its environment. The $EDITOR being used was not necessary for
all tests, and was in fact circumvented using subshells in some
cases.

To improve robustness against global state changes and avoid the use of
subshells to temporarily switch the editor as some were with
GIT_EDITOR=cat, set the editor explicitly wherever it will be important.

Specifically, in tests that need to check for the presence of a diff in the
editor, make calls to set_test_editor to set $EDITOR to check-for-diff
rather than relying on that editor being configured globally. This also
helps readers grok the tests as the setup is closer to the verification.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>
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
