From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 14:17:12 +0200
Message-ID: <11900314321506-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:27:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXFgz-0003ap-JK
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbXIQM1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 08:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbXIQM1E
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:27:04 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:53650 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbXIQM1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 08:27:03 -0400
Received: from localhost.localdomain (ti231210a341-0856.bb.online.no [88.88.171.88])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l8HCGe4J001970;
	Mon, 17 Sep 2007 14:16:40 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.1.92.g2f5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58430>

This new option forces all merges to create a "true" merge commit, i.e. a
commit with multiple parents.

Although a fast-forward would normally be The Right Thing, it isn't when the
branches to be merged originated in subversion and the merge commit will
be pushed back by means of 'git svn dcommit'. In these cases, a fast-
forward merge simply will not work.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/merge-options.txt |    4 ++++
 git-merge.sh                    |   13 +++++++++++--
 t/t6028-merge-up-to-date.sh     |   25 +++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index d64c259..ed28017 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -25,3 +25,7 @@
 	If there is no `-s` option, a built-in list of strategies
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).
+
+--no-ff::
+	Force the creation of a merge commit even when the merge would
+	have resolved as a fast-forward operation.
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
