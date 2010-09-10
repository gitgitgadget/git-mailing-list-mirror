From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t7003: Use test_commit instead of custom function
Date: Fri, 10 Sep 2010 18:06:36 -0400
Message-ID: <1284156396-81023-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuBk8-0003ro-NJ
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab0IJWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 18:06:43 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38753 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0IJWGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 18:06:42 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 8807B1FFC549; Fri, 10 Sep 2010 22:06:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 736271FFC544;
	Fri, 10 Sep 2010 22:06:31 +0000 (UTC)
X-Mailer: git-send-email 1.7.2.3.531.g1a508
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155973>

t7003-filter-branch.sh had a make_commit() function that was identical
to test_commit() in test-lib.sh except that it used tr to create a
lowercase file name from the uppercase branch name instead of
appending ".t".

Not only is this unneeded code duplication, it also was something
simply waiting to fail on case-insensitive file systems.  So replace
all uses of make_commit with test_commit.

While we're editing the setup, chain it together with && so that
failures early in the sequence don't get lost and add a commit graph.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t7003-filter-branch.sh |   77 ++++++++++++++++++++++++----------------------
 1 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 12aa63e..e022773 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -3,31 +3,34 @@
 test_description='git filter-branch'
 . ./test-lib.sh
 
-make_commit () {
-	lower=$(echo $1 | tr '[A-Z]' '[a-z]')
-	echo $lower > $lower
-	git add $lower
-	test_tick
-	git commit -m $1
-	git tag $1
-}
-
 test_expect_success 'setup' '
-	make_commit A
-	make_commit B
-	git checkout -b branch B
-	make_commit D
-	mkdir dir
-	make_commit dir/D
-	make_commit E
-	git checkout master
-	make_commit C
-	git checkout branch
-	git merge C
-	git tag F
-	make_commit G
-	make_commit H
-'
+	test_commit A &&
+	test_commit B &&
+	git checkout -b branch B &&
+	test_commit D &&
+	mkdir dir &&
+	test_commit dir/D &&
+	test_commit E &&
+	git checkout master &&
+	test_commit C &&
+	git checkout branch &&
+	git merge C &&
+	git tag F &&
+	test_commit G &&
+	test_commit H
+'
+# * (HEAD, branch) H
+# * G
+# *   Merge commit 'C' into branch
+# |\
+# | * (master) C
+# * | E
+# * | dir/D
+# * | D
+# |/
+# * B
+# * A
+
 
 H=$(git rev-parse H)
 
@@ -65,14 +68,14 @@ test_expect_success 'Fail if commit filter fails' '
 '
 
 test_expect_success 'rewrite, renaming a specific file' '
-	git filter-branch -f --tree-filter "mv d doh || :" HEAD
+	git filter-branch -f --tree-filter "mv D.t doh || :" HEAD
 '
 
 test_expect_success 'test that the file was renamed' '
-	test d = "$(git show HEAD:doh --)" &&
-	! test -f d &&
+	test D = "$(git show HEAD:doh --)" &&
+	! test -f D.t &&
 	test -f doh &&
-	test d = "$(cat doh)"
+	test D = "$(cat doh)"
 '
 
 test_expect_success 'rewrite, renaming a specific directory' '
@@ -80,18 +83,18 @@ test_expect_success 'rewrite, renaming a specific directory' '
 '
 
 test_expect_success 'test that the directory was renamed' '
-	test dir/d = "$(git show HEAD:diroh/d --)" &&
+	test dir/D = "$(git show HEAD:diroh/D.t --)" &&
 	! test -d dir &&
 	test -d diroh &&
 	! test -d diroh/dir &&
-	test -f diroh/d &&
-	test dir/d = "$(cat diroh/d)"
+	test -f diroh/D.t &&
+	test dir/D = "$(cat diroh/D.t)"
 '
 
 git tag oldD HEAD~4
 test_expect_success 'rewrite one branch, keeping a side branch' '
 	git branch modD oldD &&
-	git filter-branch -f --tree-filter "mv b boh || :" D..modD
+	git filter-branch -f --tree-filter "mv B.t boh || :" D..modD
 '
 
 test_expect_success 'common ancestor is still common (unchanged)' '
@@ -104,13 +107,13 @@ test_expect_success 'filter subdirectory only' '
 	git add subdir/new &&
 	test_tick &&
 	git commit -m "subdir" &&
-	echo H > a &&
+	echo H > A.t &&
 	test_tick &&
-	git commit -m "not subdir" a &&
+	git commit -m "not subdir" A.t &&
 	echo A > subdir/new &&
 	test_tick &&
 	git commit -m "again subdir" subdir/new &&
-	git rm a &&
+	git rm A.t &&
 	test_tick &&
 	git commit -m "again not subdir" &&
 	git branch sub &&
@@ -134,7 +137,7 @@ test_expect_success 'more setup' '
 	git add subdir/new &&
 	test_tick &&
 	git commit -m "subdir on master" subdir/new &&
-	git rm a &&
+	git rm A.t &&
 	test_tick &&
 	git commit -m "again subdir on master" &&
 	git merge branch
@@ -283,8 +286,8 @@ test_expect_success 'Tag name filtering allows slashes in tag names' '
 
 test_expect_success 'Prune empty commits' '
 	git rev-list HEAD > expect &&
-	make_commit to_remove &&
-	git filter-branch -f --index-filter "git update-index --remove to_remove" --prune-empty HEAD &&
+	test_commit to_remove &&
+	git filter-branch -f --index-filter "git update-index --remove to_remove.t" --prune-empty HEAD &&
 	git rev-list HEAD > actual &&
 	test_cmp expect actual
 '
-- 
1.7.2.3.531.g1a508
