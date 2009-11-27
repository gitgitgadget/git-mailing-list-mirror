From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t7508-status.sh: Add tests for status -s
Date: Fri, 27 Nov 2009 22:29:30 +0100
Message-ID: <fe120e6f508634ed9061546fe7373c80d27cd376.1259357047.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 22:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE8Nt-0005Gm-8k
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 22:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbZK0V3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 16:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbZK0V3d
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 16:29:33 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56771 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009AbZK0V3c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 16:29:32 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A65A5C2ACB;
	Fri, 27 Nov 2009 16:29:38 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 27 Nov 2009 16:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=VHMGMpf3HogWt5bz0Jx39KKqkC0=; b=HxrgeTSLsMPcfvVSUif8qLzM74o8kpNrqFh6lYBUVZB81b/MndhJGoCPAqRDk8InEvzbqzy8bDEiDjoXz68cinIuHNDFrdjqbwsG6G+RmkKL7mA9FLi8sUxKENtDDYCogy+WPN3yU2wgWkZzhJ8ukpRR3NoMtEJUeXgdjlkE+P0=
X-Sasl-enc: gtmATcvnPPwvTXTF4d6wLHo7UhJ+GNgaJrdclaQcgcAJ 1259357377
Received: from localhost (p5DCC18F0.dip0.t-ipconnect.de [93.204.24.240])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F604177E4;
	Fri, 27 Nov 2009 16:29:37 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc0.274.g71380
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133941>

The new short status has been completely untested so far. Introduce
tests by duplicating all tests which are present for the long format.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 166 insertions(+), 0 deletions(-)

I think having them one by one (long, short, long, short, ...) makes more sense
than having them in separate files. But I'm not sure I should follow this
strategy when testing with color and with --porcelain as well. Maybe
it's enough to duplicate a few tests only for --porcelain and with
color?

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 1173dbb..99a74bd 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -68,6 +68,24 @@ test_expect_success 'status (2)' '
 
 '
 
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
+test_expect_success 'status -s (2)' '
+
+	git status -s > output &&
+	test_cmp expect output
+
+'
+
 cat >expect <<EOF
 # On branch master
 # Changes to be committed:
@@ -97,6 +115,22 @@ test_expect_success 'status (status.showUntrackedFiles no)' '
 	test_cmp expect output
 '
 
+cat >expect << EOF
+ M dir1/modified
+A  dir2/added
+EOF
+test_expect_success 'status -s -uno' '
+	git config --unset status.showuntrackedfiles
+	git status -s -uno >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'status -s (status.showUntrackedFiles no)' '
+	git config status.showuntrackedfiles no
+	git status -s >output &&
+	test_cmp expect output
+'
+
 cat >expect <<EOF
 # On branch master
 # Changes to be committed:
@@ -133,6 +167,29 @@ test_expect_success 'status (status.showUntrackedFiles normal)' '
 '
 
 cat >expect <<EOF
+ M dir1/modified
+A  dir2/added
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? dir3/
+?? expect
+?? output
+?? untracked
+EOF
+test_expect_success 'status -s -unormal' '
+	git config --unset status.showuntrackedfiles
+	git status -s -unormal >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'status -s (status.showUntrackedFiles normal)' '
+	git config status.showuntrackedfiles normal
+	git status -s >output &&
+	test_cmp expect output
+'
+
+cat >expect <<EOF
 # On branch master
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
@@ -169,6 +226,29 @@ test_expect_success 'status (status.showUntrackedFiles all)' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+ M dir1/modified
+A  dir2/added
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? expect
+?? output
+?? untracked
+EOF
+test_expect_success 'status -s -uall' '
+	git config --unset status.showuntrackedfiles
+	git status -s -uall >output &&
+	test_cmp expect output
+'
+test_expect_success 'status -s (status.showUntrackedFiles all)' '
+	git config status.showuntrackedfiles all
+	git status -s >output &&
+	rm -rf dir3 &&
+	git config --unset status.showuntrackedfiles &&
+	test_cmp expect output
+'
+
 cat > expect << \EOF
 # On branch master
 # Changes to be committed:
@@ -201,6 +281,23 @@ test_expect_success 'status with relative paths' '
 '
 
 cat > expect << \EOF
+ M modified
+A  ../dir2/added
+?? untracked
+?? ../dir2/modified
+?? ../dir2/untracked
+?? ../expect
+?? ../output
+?? ../untracked
+EOF
+test_expect_success 'status -s with relative paths' '
+
+	(cd dir1 && git status -s) > output &&
+	test_cmp expect output
+
+'
+
+cat > expect << \EOF
 # On branch master
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
@@ -232,6 +329,24 @@ test_expect_success 'status without relative paths' '
 
 '
 
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
+test_expect_success 'status -s without relative paths' '
+
+	(cd dir1 && git status -s) > output &&
+	test_cmp expect output
+
+'
+
 cat <<EOF >expect
 # On branch master
 # Changes to be committed:
@@ -298,6 +413,28 @@ test_expect_success 'status --untracked-files=all does not show submodule' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+ M dir1/modified
+A  dir2/added
+A  sm
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? expect
+?? output
+?? untracked
+EOF
+test_expect_success 'status -s submodule summary is disabled by default' '
+	git status -s >output &&
+	test_cmp expect output
+'
+
+# we expect the same as the previous test
+test_expect_success 'status -s --untracked-files=all does not show submodule' '
+	git status -s --untracked-files=all >output &&
+	test_cmp expect output
+'
+
 head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 
 cat >expect <<EOF
@@ -335,6 +472,21 @@ test_expect_success 'status submodule summary' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+ M dir1/modified
+A  dir2/added
+A  sm
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? expect
+?? output
+?? untracked
+EOF
+test_expect_success 'status -s submodule summary' '
+	git status -s >output &&
+	test_cmp expect output
+'
 
 cat >expect <<EOF
 # On branch master
@@ -365,6 +517,20 @@ test_expect_success 'status submodule summary (clean submodule)' '
 '
 
 cat >expect <<EOF
+ M dir1/modified
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? expect
+?? output
+?? untracked
+EOF
+test_expect_success 'status -s submodule summary (clean submodule)' '
+	git status -s >output &&
+	test_cmp expect output
+'
+
+cat >expect <<EOF
 # On branch master
 # Changes to be committed:
 #   (use "git reset HEAD^1 <file>..." to unstage)
-- 
1.6.6.rc0.274.g71380
