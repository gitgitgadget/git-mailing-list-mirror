From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/6] Simplify t3410
Date: Tue, 27 Jan 2009 18:48:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271847230.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:49:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs3l-0000Ob-Cs
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbZA0Rrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbZA0Rrs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:47:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:58997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753305AbZA0Rrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:47:48 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:47:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 27 Jan 2009 18:47:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rZpY2CRErnpoxBrZSGIBmhSQjJLKcmJZ3qjZq3K
	kDM6aAyPpRQWDa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107369>


Use test_commit() and test_merge(), reducing the code while making the
intent clearer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Stephen, this and the next one touches your code.

 t/t3410-rebase-preserve-dropped-merges.sh |  126 +++++++++--------------------
 1 files changed, 37 insertions(+), 89 deletions(-)

diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
index 5816415..0669b48 100755
--- a/t/t3410-rebase-preserve-dropped-merges.sh
+++ b/t/t3410-rebase-preserve-dropped-merges.sh
@@ -11,6 +11,8 @@ rewritten.
 '
 . ./test-lib.sh
 
+. ../lib-rebase.sh
+
 # set up two branches like this:
 #
 # A - B - C - D - E
@@ -22,47 +24,17 @@ rewritten.
 # where B, D and G touch the same file.
 
 test_expect_success 'setup' '
-	: > file1 &&
-	git add file1 &&
-	test_tick &&
-	git commit -m A &&
-	git tag A &&
-	echo 1 > file1 &&
-	test_tick &&
-	git commit -m B file1 &&
-	: > file2 &&
-	git add file2 &&
-	test_tick &&
-	git commit -m C &&
-	echo 2 > file1 &&
-	test_tick &&
-	git commit -m D file1 &&
-	: > file3 &&
-	git add file3 &&
-	test_tick &&
-	git commit -m E &&
-	git tag E &&
-	git checkout -b branch1 A &&
-	: > file4 &&
-	git add file4 &&
-	test_tick &&
-	git commit -m F &&
-	git tag F &&
-	echo 3 > file1 &&
-	test_tick &&
-	git commit -m G file1 &&
-	git tag G &&
-	: > file5 &&
-	git add file5 &&
-	test_tick &&
-	git commit -m H &&
-	git tag H &&
-	git checkout -b branch2 F &&
-	: > file6 &&
-	git add file6 &&
-	test_tick &&
-	git commit -m I &&
-	git tag I
+	test_commit A file1 &&
+	test_commit B file1 1 &&
+	test_commit C file2 &&
+	test_commit D file1 2 &&
+	test_commit E file3 &&
+	git checkout A &&
+	test_commit F file4 &&
+	test_commit G file1 3 &&
+	test_commit H file5 &&
+	git checkout F &&
+	test_commit I file6
 '
 
 # A - B - C - D - E
@@ -72,68 +44,44 @@ test_expect_success 'setup' '
 #         I -- G2 -- J -- K           I -- K
 # G2 = same changes as G
 test_expect_success 'skip same-resolution merges with -p' '
-	git checkout branch1 &&
+	git checkout H &&
 	! git merge E &&
-	echo 23 > file1 &&
-	git add file1 &&
-	git commit -m L &&
-	git checkout branch2 &&
-	echo 3 > file1 &&
-	git commit -a -m G2 &&
+	test_commit L file1 23 &&
+	git checkout I &&
+	test_commit G2 file1 3 &&
 	! git merge E &&
-	echo 23 > file1 &&
-	git add file1 &&
-	git commit -m J &&
-	echo file7 > file7 &&
-	git add file7 &&
-	git commit -m K &&
-	GIT_EDITOR=: git rebase -i -p branch1 &&
-	test $(git rev-parse branch2^^) = $(git rev-parse branch1) &&
+	test_commit J file1 23 &&
+	test_commit K file7 file7 &&
+	git rebase -i -p L &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse L) &&
 	test "23" = "$(cat file1)" &&
-	test "" = "$(cat file6)" &&
-	test "file7" = "$(cat file7)" &&
-
-	git checkout branch1 &&
-	git reset --hard H &&
-	git checkout branch2 &&
-	git reset --hard I
+	test "I" = "$(cat file6)" &&
+	test "file7" = "$(cat file7)"
 '
 
 # A - B - C - D - E
 #   \             \ \
-#     F - G - H -- L \        -->   L
-#       \            |               \
-#         I -- G2 -- J -- K           I -- G2 -- K
+#     F - G - H -- L2 \        -->   L2
+#       \             |                \
+#         I -- G3 --- J2 -- K2           I -- G3 -- K2
 # G2 = different changes as G
 test_expect_success 'keep different-resolution merges with -p' '
-	git checkout branch1 &&
+	git checkout H &&
 	! git merge E &&
-	echo 23 > file1 &&
-	git add file1 &&
-	git commit -m L &&
-	git checkout branch2 &&
-	echo 4 > file1 &&
-	git commit -a -m G2 &&
+	test_commit L2 file1 23 &&
+	git checkout I &&
+	test_commit G3 file1 4 &&
 	! git merge E &&
-	echo 24 > file1 &&
-	git add file1 &&
-	git commit -m J &&
-	echo file7 > file7 &&
-	git add file7 &&
-	git commit -m K &&
-	! GIT_EDITOR=: git rebase -i -p branch1 &&
+	test_commit J2 file1 24 &&
+	test_commit K2 file7 file7 &&
+	test_must_fail git rebase -i -p L2 &&
 	echo 234 > file1 &&
 	git add file1 &&
-	GIT_EDITOR=: git rebase --continue &&
-	test $(git rev-parse branch2^^^) = $(git rev-parse branch1) &&
+	git rebase --continue &&
+	test $(git rev-parse HEAD^^^) = $(git rev-parse L2) &&
 	test "234" = "$(cat file1)" &&
-	test "" = "$(cat file6)" &&
-	test "file7" = "$(cat file7)" &&
-
-	git checkout branch1 &&
-	git reset --hard H &&
-	git checkout branch2 &&
-	git reset --hard I
+	test "I" = "$(cat file6)" &&
+	test "file7" = "$(cat file7)"
 '
 
 test_done
-- 
1.6.1.482.g7d54be
