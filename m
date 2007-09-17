From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 18:23:04 +0200
Message-ID: <11900461843997-git-send-email-hjemli@gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJNn-0000pP-NQ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbXIQQXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbXIQQXX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:23:23 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:54436 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbXIQQXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:23:22 -0400
Received: from localhost.localdomain (ti231210a341-0856.bb.online.no [88.88.171.88])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l8HGMWVg002869;
	Mon, 17 Sep 2007 18:22:32 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.1.92.g2f5e
In-Reply-To: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58460>

This option forces fast-forward merges to create a "true" merge commit,
i.e. a commit with multiple parents.

Although a fast-forward merge would normally be the right thing to do with
git branches, it is suboptimal when operating on git-svn branches since it
makes 'git-svn dcommit' fail to recognize the correct upstream subversion
branch. But performing such a merge with --no-ff specified will both make
git-svn dcommit recognize the correct upstream and create the logically
correct history in subversion (the merge performed in git will be recorded
as a single revision in subversion, not as a series of revisions seemingly
cherry-picked from the merged branch).

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

When updating git-svn.txt, I noticed that we might want to update the 
section "DESIGN PHILOSOPHY". Eric?


 Documentation/git-svn.txt       |   13 +++++++++++++
 Documentation/merge-options.txt |    5 +++++
 git-merge.sh                    |   13 +++++++++++--
 t/t6028-merge-up-to-date.sh     |   25 +++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index be2e34e..c510c21 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -475,6 +475,19 @@ use 'git-svn rebase' to update your work branch instead of 'git pull' or
 when committing into SVN, which can lead to merge commits reversing
 previous commits in SVN.
 
+If you use 'git-svn dcommit' to commit your local work to the upstream
+subversion branch, merge commits are usually handled correctly, i.e.
+git-svn will only follow the first parent of each merge commit and create
+a single subversion revision for each of them. An exception is when two
+subversion branches has been merged locally and the merge ended up as a
+fast-forward operation. This will make git-svn belive that there are no
+local changes to dcommit. To work around this issue, one can redo the
+merge using the --no-ff option:
+
+       $ git reset --hard HEAD@{1}   ## undo the fast-forward merge
+       $ git merge --no-ff <branch>
+
+
 DESIGN PHILOSOPHY
 -----------------
 Merge tracking in Subversion is lacking and doing branched development
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index d64c259..b34b888 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -25,3 +25,8 @@
 	If there is no `-s` option, a built-in list of strategies
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).
+
+--no-ff::
+	Force the creation of a merge commit even when the merge would
+	have resolved as a fast-forward operation. See gitlink:git-svn[1]
+	for a use-case for this option.
diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..13b98e6 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--no-commit] [--no-ff] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -165,6 +165,10 @@ do
 		merge_msg="$1"
 		have_message=t
 		;;
+	--no-ff)
+		no_ff=t
+		no_fast_forward_strategies=$all_strategies
+		;;
 	-*)	usage ;;
 	*)	break ;;
 	esac
@@ -444,7 +448,12 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    parents=$(git show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
+    if test $no_ff = 't'
+    then
+        parents=$(git rev-parse "$head" "$@" | sed -e 's/^/-p /')
+    else
+        parents=$(git show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
+    fi
     result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge made by $wt_strategy."
     dropsave
diff --git a/t/t6028-merge-up-to-date.sh b/t/t6028-merge-up-to-date.sh
index f8f3e3f..afd74e2 100755
--- a/t/t6028-merge-up-to-date.sh
+++ b/t/t6028-merge-up-to-date.sh
@@ -10,12 +10,14 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m initial &&
 	git tag c0 &&
+	c0=$(git rev-parse c0)
 
 	echo second >file &&
 	git add file &&
 	test_tick &&
 	git commit -m second &&
 	git tag c1 &&
+	c1=$(git rev-parse c1)
 	git branch test
 '
 
@@ -41,6 +43,16 @@ test_expect_success 'merge -s recursive fast-forward' '
 
 '
 
+test_expect_success 'merge -s recursive --no-ff' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge -s recursive --no-ff c1 &&
+	test $c0 = $(git rev-parse HEAD^1) &&
+	test $c1 = $(git rev-parse HEAD^2)
+
+'
+
 test_expect_success 'merge -s ours up-to-date' '
 
 	git reset --hard c1 &&
@@ -63,6 +75,19 @@ test_expect_success 'merge -s ours fast-forward' '
 
 '
 
+test_expect_success 'merge -s ours --no-ff' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge -s ours --no-ff c1 &&
+	expect=$(git rev-parse c0^{tree}) &&
+	current=$(git rev-parse HEAD^{tree}) &&
+	test "$expect" = "$current" &&
+	test $c0 = $(git rev-parse HEAD^1) &&
+	test $c1 = $(git rev-parse HEAD^2)
+
+'
+
 test_expect_success 'merge -s subtree up-to-date' '
 
 	git reset --hard c1 &&
-- 
1.5.3.1.92.g2f5e
