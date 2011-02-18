From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] rev-list: documentation and test for --cherry
Date: Fri, 18 Feb 2011 13:34:20 +0100
Message-ID: <c61e49d0955c6fbb8d5334e2f90aec2bde43bba9.1298032360.git.git@drmicha.warpmail.net>
References: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 13:37:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqPae-0003mw-M7
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 13:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab1BRMhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 07:37:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60613 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755122Ab1BRMhg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 07:37:36 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 15BF920D75;
	Fri, 18 Feb 2011 07:37:36 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 18 Feb 2011 07:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=/ephA/vEe5AvUuMPEj+8V6zRqfc=; b=O8HsiD6PpoUlFL7gZxXcnbtJoQYVZ5+huqGc5uE2xydvQRFsGbcZZ7rbTfeHQyEPCHyEjakYZIyTn8xz0A62vOIYDBnmUp8Ya5bBFQw1FrpMnsJDCF9rXkeuG3pWrL+SVPODLV/6yrQ5lrU+FYMs+mLDdK5Cp5cb/0obUW5dz9s=
X-Sasl-enc: fx4nemGykVqVKTWpy3bVx6BC2UTzNsBLunVwXr1ABWJN 1298032655
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6646B44A077;
	Fri, 18 Feb 2011 07:37:35 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167203>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt       |    1 +
 Documentation/rev-list-options.txt   |   10 ++++++++++
 t/t6007-rev-list-cherry-pick-file.sh |   25 +++++++++++++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 8e1e329..a74fb97 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -32,6 +32,7 @@ SYNOPSIS
 	     [ \--timestamp ]
 	     [ \--left-right ]
 	     [ \--cherry-pick ]
+	     [ \--cherry ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ \--regexp-ignore-case | -i ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 44a2ef1..3a68629 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -319,6 +319,16 @@ from the other branch (for example, "3rd on b" may be cherry-picked
 from branch A).  With this option, such pairs of commits are
 excluded from the output.
 
+--cherry::
+
+	Omit any commit that instroduces the same change as
+	another commit on the left side of a symmetric or asymmetric
+	range (they are treated the same).
++
+For example, `git rev-list --cherry A..B` omits those commits from
+`B` which are in `A` or are patch-equivalent to a commit in `A`.
+In other words, this lists the `{plus}` commits from `git cherry A B`.
+
 -g::
 --walk-reflogs::
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 64b72a3..56efdd0 100755
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
@@ -83,11 +88,23 @@ test_expect_success 'bar does not come up empty' '
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
+test_expect_success '--cherry bar does not come up empty' '
+	git rev-list --cherry F..E -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp actual.named expect
-- 
1.7.4.1.74.gf39475.dirty
