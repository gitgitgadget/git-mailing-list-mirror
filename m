From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] t6007: Make sure we test --cherry-pick
Date: Fri, 18 Feb 2011 13:34:19 +0100
Message-ID: <396d51a65165db5025dc70965cff9955af7b4b68.1298032360.git.git@drmicha.warpmail.net>
References: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 13:37:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqPae-0003mw-5q
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 13:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab1BRMhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 07:37:36 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34334 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753426Ab1BRMhe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 07:37:34 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 13DF420D78;
	Fri, 18 Feb 2011 07:37:34 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 18 Feb 2011 07:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=8eO4zMgBOQ+zGm8QYrZghzc7IHo=; b=A+rznUuKrdu0jxu011DoS/8TuRHUtakLtQz6r/MGUxOWtUto4gFf5UgCYImhhviZfzlp7zALd21DtKw4MrWQOWVfll/Kw/iScqQwJU+EHTJOEw8jnQnyBLIleujxHmgTQZQ0k9bITsHTDZgEydeVz/9E5pSK5IhQPueRxoQOk9s=
X-Sasl-enc: x6+9OYI4IEo8kktrXM1Ynh3lny8JgeVMpSISXi4DB4da 1298032653
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6672840B145;
	Fri, 18 Feb 2011 07:37:33 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167204>

Test 5 wants to test --cherry-pick but limits by pathspec in such a way
that there are no commits on the left side of the range.

Add a test without "--cherry-pick" which displays this, and add two
more commits and another test which tests what we're after. This also
shortens the last test.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6007-rev-list-cherry-pick-file.sh |   49 ++++++++++++++++++++++++++++-----
 1 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index b565638..64b72a3 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -4,13 +4,14 @@ test_description='test git rev-list --cherry-pick -- file'
 
 . ./test-lib.sh
 
-# A---B
+# A---B---D
 #  \
 #   \
-#    C
+#    C---E
 #
 # B changes a file foo.c, adding a line of text.  C changes foo.c as
 # well as bar.c, but the change in foo.c was identical to change B.
+# D and C change bar in the same way, E differently.
 
 test_expect_success setup '
 	echo Hallo > foo &&
@@ -25,11 +26,21 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "C" &&
 	git tag C &&
+	echo Dello > bar &&
+	git add bar &&
+	test_tick &&
+	git commit -m "E" &&
+	git tag E &&
 	git checkout master &&
 	git checkout branch foo &&
 	test_tick &&
 	git commit -m "B" &&
-	git tag B
+	git tag B &&
+	echo Cello > bar &&
+	git add bar &&
+	test_tick &&
+	git commit -m "D" &&
+	git tag D
 '
 
 cat >expect <<EOF
@@ -53,8 +64,33 @@ test_expect_success '--cherry-pick foo comes up empty' '
 	test -z "$(git rev-list --left-right --cherry-pick B...C -- foo)"
 '
 
+cat >expect <<EOF
+>tags/C
+EOF
+
 test_expect_success '--cherry-pick bar does not come up empty' '
-	! test -z "$(git rev-list --left-right --cherry-pick B...C -- bar)"
+	git rev-list --left-right --cherry-pick B...C -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+test_expect_success 'bar does not come up empty' '
+	git rev-list --left-right B...C -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
+>tags/E
+EOF
+
+test_expect_success '--cherry-pick bar does not come up empty (II)' '
+	git rev-list --left-right --cherry-pick D...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
 '
 
 test_expect_success '--cherry-pick with independent, but identical branches' '
@@ -75,11 +111,8 @@ cat >expect <<EOF
 1	2
 EOF
 
-# Insert an extra commit to break the symmetry
 test_expect_success '--count --left-right' '
-	git checkout branch &&
-	test_commit D &&
-	git rev-list --count --left-right B...D > actual &&
+	git rev-list --count --left-right C...D > actual &&
 	test_cmp expect actual
 '
 
-- 
1.7.4.1.74.gf39475.dirty
