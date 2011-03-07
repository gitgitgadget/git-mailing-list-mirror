From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/9] t6007: Make sure we test --cherry-pick
Date: Mon,  7 Mar 2011 13:31:36 +0100
Message-ID: <e0b9c34f7eec9d7943bbb8a3134f24e6e4e4ed3e.1299499429.git.git@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZf4-0003Ub-03
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab1CGMfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35334 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004Ab1CGMfP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:15 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0B810207FD;
	Mon,  7 Mar 2011 07:35:15 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 07 Mar 2011 07:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=iK64xaImEeQYTruFjllaH6mXN5U=; b=nDs8MDJYqej7SxatOvZNhP3+EvhJ6yxUO6anotjByqcc3LhVv5INSqLhC/YqrDnfXLXKCgmbPv/ENrK5rcVg2Ll802ThPbvE/XFsZ3ezkbMf3mB4owrrufEnPEajQj66RDus3Agd57Ld++SCAH8sK0xUB8x7LxxoFztuskpu8J4=
X-Sasl-enc: NmrVHisrWar+pQqa7Yl+juIouB62LbVxHHLqldbCUn+B 1299501314
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 64FF0402397;
	Mon,  7 Mar 2011 07:35:14 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168582>

Test 5 wants to test --cherry-pick but limits by pathspec in such a way
that there are no commits on the left side of the range.

Add a test without "--cherry-pick" which displays this, and add two
more commits and another test which tests what we're after. This also
shortens the last test.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.4.1.299.g567d7.dirty
