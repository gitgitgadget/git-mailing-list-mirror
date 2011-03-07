From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/9] rev-list: documentation and test for --left/right-only
Date: Mon,  7 Mar 2011 13:31:37 +0100
Message-ID: <59c8afdf475d2b072fb63383df9f62afd2b3b1ee.1299499429.git.git@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZf3-0003Ub-F3
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab1CGMfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:18 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48960 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751701Ab1CGMfR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:17 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 022A020832;
	Mon,  7 Mar 2011 07:35:17 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 07 Mar 2011 07:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=RUxtLxTDE7HoJT6y/gMD4zik+sE=; b=nucitY+64Gip35Qon05mfPf3Mdjd058KAxVX0FUkoIxzNhEkhejZ32W6NvCXNqcMKGTmaylEan5B+ifVpczTh+owRBdKwJaJ+oIBAqp8hClFsAhxvYmAjBpPEHI6qdSHBFhjziYNHVWjhCGtv20QVFp/m++uHEWi2y/CdKBvTVM=
X-Sasl-enc: ivP2qgLoKhZ1PgW2gj2HYV6LCNVfLvXBkusTFUxqzA31 1299501316
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 526CC44424F;
	Mon,  7 Mar 2011 07:35:16 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168583>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rev-list.txt       |    2 ++
 Documentation/rev-list-options.txt   |   13 +++++++++++++
 t/t6007-rev-list-cherry-pick-file.sh |   32 ++++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 8e1e329..5f47a13 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -31,6 +31,8 @@ SYNOPSIS
 	     [ \--parents ]
 	     [ \--timestamp ]
 	     [ \--left-right ]
+	     [ \--left-only ]
+	     [ \--right-only ]
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 44a2ef1..cebba62 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -319,6 +319,19 @@ from the other branch (for example, "3rd on b" may be cherry-picked
 from branch A).  With this option, such pairs of commits are
 excluded from the output.
 
+--left-only::
+--right-only::
+
+	List only commits on the respective side of a symmetric range,
+	i.e. only those which would be marked `<` resp. `>` by
+	`--left-right`.
++
+For example, `--cherry-pick --right-only A...B` omits those
+commits from `B` which are in `A` or are patch-equivalent to a commit in
+`A`. In other words, this lists the `{plus}` commits from `git cherry A B`.
+More precisely, `--cherry-pick --right-only --no-merges` gives the exact
+list.
+
 -g::
 --walk-reflogs::
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 64b72a3..cd089a9 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -4,14 +4,14 @@ test_description='test git rev-list --cherry-pick -- file'
 
 . ./test-lib.sh
 
-# A---B---D
+# A---B---D---F
 #  \
 #   \
 #    C---E
 #
 # B changes a file foo.c, adding a line of text.  C changes foo.c as
 # well as bar.c, but the change in foo.c was identical to change B.
-# D and C change bar in the same way, E differently.
+# D and C change bar in the same way, E and F differently.
 
 test_expect_success setup '
 	echo Hallo > foo &&
@@ -40,7 +40,12 @@ test_expect_success setup '
 	git add bar &&
 	test_tick &&
 	git commit -m "D" &&
-	git tag D
+	git tag D &&
+	echo Nello > bar &&
+	git add bar &&
+	test_tick &&
+	git commit -m "F" &&
+	git tag F
 '
 
 cat >expect <<EOF
@@ -83,11 +88,30 @@ test_expect_success 'bar does not come up empty' '
 '
 
 cat >expect <<EOF
+<tags/F
 >tags/E
 EOF
 
 test_expect_success '--cherry-pick bar does not come up empty (II)' '
-	git rev-list --left-right --cherry-pick D...E -- bar > actual &&
+	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
+tags/E
+EOF
+
+test_expect_success '--cherry-pick --right-only' '
+	git rev-list --cherry-pick --right-only F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+test_expect_success '--cherry-pick --left-only' '
+	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp actual.named expect
-- 
1.7.4.1.299.g567d7.dirty
