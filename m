From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] t3412: clean up GIT_EDITOR usage
Date: Fri, 30 Jan 2009 23:47:00 +0100
Message-ID: <1233355621-4783-1-git-send-email-trast@student.ethz.ch>
References: <200901302343.39921.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT2A4-0007bo-Uy
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbZA3WrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbZA3WrH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:47:07 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:25598 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbZA3WrF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 17:47:05 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:47:02 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:47:02 +0100
X-Mailer: git-send-email 1.6.1.2.464.g6066
In-Reply-To: <200901302343.39921.trast@student.ethz.ch>
X-OriginalArrivalTime: 30 Jan 2009 22:47:02.0505 (UTC) FILETIME=[AADB0590:01C9832C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107880>

a6c7a27 (rebase -i: correctly remember --root flag across --continue,
2009-01-26) introduced a more portable GIT_EDITOR usage, but left the
old tests unchanged.

Since we never use the editor (all tests run the rebase script as
proposed by rebase -i), just disable it outright, which simplifies the
tests.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t3412-rebase-root.sh |   38 +++++++++++++-------------------------
 1 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 9fc528f..8a9154a 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -6,6 +6,10 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
 '
 . ./test-lib.sh
 
+# we always run the interactive rebases unchanged, so just disable the editor
+GIT_EDITOR=:
+export GIT_EDITOR
+
 test_expect_success 'prepare repository' '
 	test_commit 1 A &&
 	test_commit 2 A &&
@@ -59,7 +63,7 @@ test_expect_success 'pre-rebase got correct input (2)' '
 
 test_expect_success 'rebase -i --root --onto <newbase>' '
 	git checkout -b work3 other &&
-	GIT_EDITOR=: git rebase -i --root --onto master &&
+	git rebase -i --root --onto master &&
 	git log --pretty=tformat:"%s" > rebased3 &&
 	test_cmp expect rebased3
 '
@@ -70,7 +74,7 @@ test_expect_success 'pre-rebase got correct input (3)' '
 
 test_expect_success 'rebase -i --root --onto <newbase> <branch>' '
 	git branch work4 other &&
-	GIT_EDITOR=: git rebase -i --root --onto master work4 &&
+	git rebase -i --root --onto master work4 &&
 	git log --pretty=tformat:"%s" > rebased4 &&
 	test_cmp expect rebased4
 '
@@ -81,7 +85,7 @@ test_expect_success 'pre-rebase got correct input (4)' '
 
 test_expect_success 'rebase -i -p with linear history' '
 	git checkout -b work5 other &&
-	GIT_EDITOR=: git rebase -i -p --root --onto master &&
+	git rebase -i -p --root --onto master &&
 	git log --pretty=tformat:"%s" > rebased5 &&
 	test_cmp expect rebased5
 '
@@ -111,7 +115,7 @@ EOF
 
 test_expect_success 'rebase -i -p with merge' '
 	git checkout -b work6 other &&
-	GIT_EDITOR=: git rebase -i -p --root --onto master &&
+	git rebase -i -p --root --onto master &&
 	git log --graph --topo-order --pretty=tformat:"%s" > rebased6 &&
 	test_cmp expect-side rebased6
 '
@@ -142,7 +146,7 @@ EOF
 
 test_expect_success 'rebase -i -p with two roots' '
 	git checkout -b work7 other &&
-	GIT_EDITOR=: git rebase -i -p --root --onto master &&
+	git rebase -i -p --root --onto master &&
 	git log --graph --topo-order --pretty=tformat:"%s" > rebased7 &&
 	test_cmp expect-third rebased7
 '
@@ -158,22 +162,14 @@ EOF
 
 test_expect_success 'pre-rebase hook stops rebase' '
 	git checkout -b stops1 other &&
-	(
-		GIT_EDITOR=:
-		export GIT_EDITOR
-		test_must_fail git rebase --root --onto master
-	) &&
+	test_must_fail git rebase --root --onto master &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops1
 	test 0 = $(git rev-list other...stops1 | wc -l)
 '
 
 test_expect_success 'pre-rebase hook stops rebase -i' '
 	git checkout -b stops2 other &&
-	(
-		GIT_EDITOR=:
-		export GIT_EDITOR
-		test_must_fail git rebase --root --onto master
-	) &&
+	test_must_fail git rebase --root --onto master &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops2
 	test 0 = $(git rev-list other...stops2 | wc -l)
 '
@@ -218,11 +214,7 @@ test_expect_success 'rebase --root with conflict (second part)' '
 
 test_expect_success 'rebase -i --root with conflict (first part)' '
 	git checkout -b conflict2 other &&
-	(
-		GIT_EDITOR=:
-		export GIT_EDITOR
-		test_must_fail git rebase -i --root --onto master
-	) &&
+	test_must_fail git rebase -i --root --onto master &&
 	git ls-files -u | grep "B$"
 '
 
@@ -260,11 +252,7 @@ EOF
 
 test_expect_success 'rebase -i -p --root with conflict (first part)' '
 	git checkout -b conflict3 other &&
-	(
-		GIT_EDITOR=:
-		export GIT_EDITOR
-		test_must_fail git rebase -i -p --root --onto master
-	) &&
+	test_must_fail git rebase -i -p --root --onto master &&
 	git ls-files -u | grep "B$"
 '
 
-- 
1.6.1.2.464.g6066
