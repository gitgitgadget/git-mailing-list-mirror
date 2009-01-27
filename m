From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/6] Simplify t3411
Date: Tue, 27 Jan 2009 18:48:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271848090.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs4N-0000f3-Jk
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbZA0Rs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbZA0Rs0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:48:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:52123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753305AbZA0Rs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:48:26 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:48:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 27 Jan 2009 18:48:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z38E0fZrZr3jdwpvUp400QTLBPyQYBUKLhjUmg4
	uXu5B+dKSMzkuY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107370>


Use test_commit() and test_merge().  This way, it is harder to forget to
tag, or to call test_tick before committing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3411-rebase-preserve-around-merges.sh |   65 ++++++++----------------------
 1 files changed, 17 insertions(+), 48 deletions(-)

diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 6a1586a..6533505 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -21,27 +21,13 @@ set_fake_editor
 #        -- C1 --
 
 test_expect_success 'setup' '
-	touch a &&
-	touch b &&
-	git add a &&
-	git commit -m A1 &&
-	git tag A1
-	git add b &&
-	git commit -m B1 &&
-	git tag B1 &&
-	git checkout -b branch &&
-	touch c &&
-	git add c &&
-	git commit -m C1 &&
-	git checkout master &&
-	touch d &&
-	git add d &&
-	git commit -m D1 &&
-	git merge branch &&
-	touch f &&
-	git add f &&
-	git commit -m F1 &&
-	git tag F1
+	test_commit A1 &&
+	test_commit B1 &&
+	test_commit C1 &&
+	git reset --hard B1 &&
+	test_commit D1 &&
+	test_merge E1 C1 &&
+	test_commit F1
 '
 
 # Should result in:
@@ -52,7 +38,7 @@ test_expect_success 'setup' '
 #
 test_expect_success 'squash F1 into D1' '
 	FAKE_LINES="1 squash 3 2" git rebase -i -p B1 &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse branch)" &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse C1)" &&
 	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
 	git tag E2
 '
@@ -70,32 +56,15 @@ test_expect_success 'squash F1 into D1' '
 # And rebase G1..M1 onto E2
 
 test_expect_success 'rebase two levels of merge' '
-	git checkout -b branch2 A1 &&
-	touch g &&
-	git add g &&
-	git commit -m G1 &&
-	git checkout -b branch3 &&
-	touch h
-	git add h &&
-	git commit -m H1 &&
-	git checkout -b branch4 &&
-	touch i &&
-	git add i &&
-	git commit -m I1 &&
-	git tag I1 &&
-	git checkout branch3 &&
-	touch j &&
-	git add j &&
-	git commit -m J1 &&
-	git merge I1 --no-commit &&
-	git commit -m K1 &&
-	git tag K1 &&
-	git checkout branch2 &&
-	touch l &&
-	git add l &&
-	git commit -m L1 &&
-	git merge K1 --no-commit &&
-	git commit -m M1 &&
+	test_commit G1 &&
+	test_commit H1 &&
+	test_commit I1 &&
+	git checkout -b branch3 H1 &&
+	test_commit J1 &&
+	test_merge K1 I1 &&
+	git checkout -b branch2 G1 &&
+	test_commit L1 &&
+	test_merge M1 K1 &&
 	GIT_EDITOR=: git rebase -i -p E2 &&
 	test "$(git rev-parse HEAD~3)" = "$(git rev-parse E2)" &&
 	test "$(git rev-parse HEAD~2)" = "$(git rev-parse HEAD^2^2~2)" &&
-- 
1.6.1.482.g7d54be
