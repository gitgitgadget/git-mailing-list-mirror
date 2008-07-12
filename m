From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] t3404: Let "preserve merges with -p" check two cases
Date: Sat, 12 Jul 2008 17:47:31 +0200
Message-ID: <1215877651-17008-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 17:48:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhKs-0006Bs-Ni
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 17:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbYGLPrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYGLPrg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:47:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:44878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753354AbYGLPrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:47:35 -0400
Received: (qmail invoked by alias); 12 Jul 2008 15:47:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp050) with SMTP; 12 Jul 2008 17:47:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/5UixLuBz5suJLf8j7R1tOg8w/XfGrvcr8Ul6/YL
	Nc14qSIgUdGEDA
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHhJr-0004Qh-RB; Sat, 12 Jul 2008 17:47:31 +0200
X-Mailer: git-send-email 1.5.6.2.303.g79662
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88248>

There are two cases for preserving merges:
1. The merge base is outside the trunk that is to be rebased.
   Then commits of those other parents must not be picked.
2. The merge base is inside the trunk that is to be rebased.
   Then all the commits related to that merge must be picked
   and the merge must be redone.

The "preserve merges with -p" test case tested for case 1 only.
This patch adds case 2.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t3404-rebase-interactive.sh |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1c80148..092aa26 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -211,7 +211,7 @@ test_expect_success 'preserve merges with -p' '
 	git add unrelated-file &&
 	test_tick &&
 	git commit -m "unrelated" &&
-	git checkout -b to-be-rebased master &&
+	git checkout -b another-branch master &&
 	echo B > file1 &&
 	test_tick &&
 	git commit -m J file1 &&
@@ -220,12 +220,28 @@ test_expect_success 'preserve merges with -p' '
 	echo C > file1 &&
 	test_tick &&
 	git commit -m K file1 &&
+	echo D > file1 &&
+	test_tick &&
+	git commit -m L1 file1 &&
+	git checkout HEAD^ &&
+	echo 1 > unrelated-file &&
+	test_tick &&
+	git commit -m L2 unrelated-file &&
+	test_tick &&
+	git merge another-branch &&
+	echo E > file1 &&
+	test_tick &&
+	git commit -m M file1 &&
+	git checkout -b to-be-rebased &&
 	test_tick &&
 	git rebase -i -p --onto branch1 master &&
-	test $(git rev-parse HEAD^^2) = $(git rev-parse to-be-preserved) &&
-	test $(git rev-parse HEAD~3) = $(git rev-parse branch1) &&
-	test $(git show HEAD:file1) = C &&
-	test $(git show HEAD~2:file1) = B
+	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
+	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
+	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
+	test $(git show HEAD~5:file1) = B &&
+	test $(git show HEAD~3:file1) = C &&
+	test $(git show HEAD:file1) = E &&
+	test $(git show HEAD:unrelated-file) = 1
 '
 
 test_expect_success '--continue tries to commit' '
-- 
1.5.6.2.303.g79662
