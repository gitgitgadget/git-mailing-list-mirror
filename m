From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 02/10] t6007: Make sure we test --cherry-pick
Date: Thu, 10 Mar 2011 15:44:55 +0100
Message-ID: <e0b9c34f7eec9d7943bbb8a3134f24e6e4e4ed3e.1299767412.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:48:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhAY-0007SI-7v
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab1CJOsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:45 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:46724 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752091Ab1CJOsn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:43 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1BFCF20D40;
	Thu, 10 Mar 2011 09:48:43 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 10 Mar 2011 09:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=IdkcoXjXu9vC24wef+8YzGvWPq8=; b=SNCmY9fdxLzhu+0gpGN1IGjNxy7L+SH4ATS0TjHi3mq5C7e0Ew49kKcIhEQbAzMlBFFwuWNPirXM4RALSu6K6qF03ZTnCmTf6WZTT71SrHf2hdnuJSpG+fUcLbQt+9NHdw5YlFhGeTllLWnRVUnBbdDA6mviY/i1+FU1djMOZKc=
X-Sasl-enc: zlZg/8gRDAcbY6h9m7kHPI4eJGwkfNv7wBFRQX3A+IYz 1299768522
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 76C1C446B47;
	Thu, 10 Mar 2011 09:48:42 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168818>

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
1.7.4.1.317.gf445f
