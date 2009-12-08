From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] t7508-status: test all modes with color
Date: Tue,  8 Dec 2009 11:12:02 +0100
Message-ID: <39211ecec866882503d1188d359e1183341faeb1.1260266027.git.git@drmicha.warpmail.net>
References: <cover.1260266027.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 11:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHx3S-0005Rh-Ge
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 11:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbZLHKMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 05:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbZLHKMI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 05:12:08 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37330 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753374AbZLHKMF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 05:12:05 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 08E81C5A5F;
	Tue,  8 Dec 2009 05:12:12 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 08 Dec 2009 05:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=UonSiPtj17o10giZO536Zo5mNTY=; b=UrowjTTcs350hBWA1eCahVoI4+Bm9Bfdpmt1SjVGxgWmeI7aaw6q1hqYGKZCKvISS1hgFPqYevfHsXvQgX/qaAjTsmPcwAc5IeQMATcNCDRZQ52UBL/8VpDN4bHZr4jio0vWh1GXW9yCc0fVnfMb10vI5woOJ2pE6wD/jUO6lnE=
X-Sasl-enc: 2QppMml3QAPuxMeHALa28/TJcnyaZZg7IabSqEqGlRUr 1260267131
Received: from localhost (p5DCC1658.dip0.t-ipconnect.de [93.204.22.88])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F2C285574;
	Tue,  8 Dec 2009 05:12:10 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.292.gd8fe
In-Reply-To: <cover.1260266027.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134851>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8e7727e..50554a0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -31,6 +31,15 @@ test_expect_success 'setup' '
 	git add dir2/added
 '
 
+decrypt_color () {
+	sed \
+		-e 's/.\[1m/<WHITE>/g' \
+		-e 's/.\[31m/<RED>/g' \
+		-e 's/.\[32m/<GREEN>/g' \
+		-e 's/.\[34m/<BLUE>/g' \
+		-e 's/.\[m/<RESET>/g'
+}
+
 test_expect_success 'status (1)' '
 
 	grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
@@ -315,6 +324,115 @@ test_expect_success 'status --porcelain ignores relative paths setting' '
 
 '
 
+test_expect_success 'setup unique colors' '
+
+	git config status.color.untracked blue
+
+'
+
+cat > expect << \EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	<GREEN>new file:   dir2/added<RESET>
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
+#
+#	<RED>modified:   dir1/modified<RESET>
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	<BLUE>dir1/untracked<RESET>
+#	<BLUE>dir2/modified<RESET>
+#	<BLUE>dir2/untracked<RESET>
+#	<BLUE>expect<RESET>
+#	<BLUE>output<RESET>
+#	<BLUE>untracked<RESET>
+EOF
+
+test_expect_success 'status with color.ui' '
+
+	git config color.ui always &&
+	git status | decrypt_color > output &&
+	test_cmp expect output
+
+'
+
+test_expect_success 'status with color.status' '
+
+	git config --unset color.ui &&
+	git config color.status always &&
+	git status | decrypt_color > output &&
+	test_cmp expect output
+
+'
+
+cat > expect << \EOF
+ <RED>M<RESET> dir1/modified
+<GREEN>A<RESET>  dir2/added
+<BLUE>??<RESET> dir1/untracked
+<BLUE>??<RESET> dir2/modified
+<BLUE>??<RESET> dir2/untracked
+<BLUE>??<RESET> expect
+<BLUE>??<RESET> output
+<BLUE>??<RESET> untracked
+EOF
+
+test_expect_success 'status -s with color.ui' '
+
+	git config --unset color.status &&
+	git config color.ui always &&
+	git status -s | decrypt_color > output &&
+	test_cmp expect output
+
+'
+
+test_expect_success 'status -s with color.status' '
+
+	git config --unset color.ui &&
+	git config color.status always &&
+	git status -s | decrypt_color > output &&
+	test_cmp expect output
+
+'
+
+cat > expect << \EOF
+ M dir1/modified
+A  dir2/added
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? expect
+?? output
+?? untracked
+EOF
+
+test_expect_success 'status --porcelain ignores color.ui' '
+
+	git config --unset color.status &&
+	git config color.ui always &&
+	git status --porcelain | decrypt_color > output &&
+	test_cmp expect output
+
+'
+
+test_expect_success 'status --porcelain ignores color.status' '
+
+	git config --unset color.ui &&
+	git config color.status always &&
+	git status --porcelain | decrypt_color > output &&
+	test_cmp expect output
+
+'
+
+# recover unconditionally from color tests
+git config --unset color.status
+git config --unset color.ui
+
 cat > expect << \EOF
 # On branch master
 # Changes to be committed:
@@ -339,6 +457,7 @@ cat > expect << \EOF
 #	untracked
 EOF
 
+
 test_expect_success 'status without relative paths' '
 
 	git config status.relativePaths false
-- 
1.6.6.rc1.292.gd8fe
