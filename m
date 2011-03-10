From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 03/10] rev-list: documentation and test for --left/right-only
Date: Thu, 10 Mar 2011 15:44:56 +0100
Message-ID: <59c8afdf475d2b072fb63383df9f62afd2b3b1ee.1299767412.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:49:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhB6-0007ob-L8
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab1CJOsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:47 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44717 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752324Ab1CJOsp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:45 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2559920D2F;
	Thu, 10 Mar 2011 09:48:45 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Mar 2011 09:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=vtDKfqukD/yqBQRw3LGsr0ta9lE=; b=HeMHDHH7xFKHmw5Q3b0g6zHz1+hVnOEIXh5bQGrT/8ZzJ5/yH2Y7w8xAavntdK5g17PiUo33D3bmvgcgd2WCjNZxcxNzNXl9xC9M/8Zk23358l3S5w/TnORWht//ldp8irMHhayKDxF3fq7kqCB2zS4hYv+nmXSSWk0duHmSefM=
X-Sasl-enc: udofIFcoCGDSo3BxaO0RyeurGxruJai5HPDVz9rEPQZ4 1299768524
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7267E40D398;
	Thu, 10 Mar 2011 09:48:44 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168820>

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
1.7.4.1.317.gf445f
