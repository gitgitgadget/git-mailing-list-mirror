From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/2] git-merge: add option --no-ff
Date: Thu, 20 Sep 2007 14:53:08 +0200
Message-ID: <1190292789-16203-2-git-send-email-hjemli@gmail.com>
References: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 14:52:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYLWV-0001SS-Gy
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 14:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbXITMwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 08:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbXITMwp
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 08:52:45 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:61037 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826AbXITMwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 08:52:45 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8KCqe63013119;
	Thu, 20 Sep 2007 14:52:40 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58772>

This option forces all merges to create a "true" merge commit, i.e. a commit
with multiple parents.

A fast-forward merge will often be considered The Right Thing when working
in a distributed environment, but it doesn't work well when the branches to
be merged originated in subversion and the merge commit will be pushed back
with 'git svn dcommit'. In this case, a fast-forward merge will make git-svn
mistakenly think that the current branch is tracking the merged upstream
branch. But if the merge is created with --no-ff, 'git svn dcommit' will work
as expected (and the history in subversion and git will be equal).

There are also a use-case for --no-ff in 'native git' when integrating topic
branches: if the merge of a topic-branch results in a fast-forward operation,
there will be no way to detect that the topic-branch ever existed. This might
be good or bad dependent on project policy, but both options (ff/no-ff) are
technically sane.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-svn.txt       |   13 +++++++++++
 Documentation/merge-options.txt |    5 ++++
 git-merge.sh                    |   13 +++++++++-
 t/t6029-merge-integration.sh    |   46 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100755 t/t6029-merge-integration.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e157c6a..619023d 100644
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
+fast-forward operation. This will make git-svn believe that there are no
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
index 3a01db0..70ca5ff 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--no-commit] [--no-ff] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -165,6 +165,9 @@ do
 		merge_msg="$1"
 		have_message=t
 		;;
+	--no-ff)
+		allow_fast_forward=f
+		;;
 	-*)	usage ;;
 	*)	break ;;
 	esac
@@ -444,7 +447,13 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    parents=$(git show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
+    if test "$allow_fast_forward" = "f"
+    then
+        parents=$(git rev-parse "$head" "$@")
+    else
+        parents=$(git show-branch --independent "$head" "$@")
+    fi
+    parents=$(echo "$parents" | sed -e 's/^/-p /')
     result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge made by $wt_strategy."
     dropsave
diff --git a/t/t6029-merge-integration.sh b/t/t6029-merge-integration.sh
new file mode 100755
index 0000000..6ba7dd9
--- /dev/null
+++ b/t/t6029-merge-integration.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='merge --no-ff'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git tag c0 &&
+	c0=$(git rev-parse c0)
+
+	echo second >file &&
+	git add file &&
+	test_tick &&
+	git commit -m second &&
+	git tag c1 &&
+	c1=$(git rev-parse c1)
+	git branch test
+'
+
+test_expect_success 'merge c1' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge c1 &&
+	test $c0 = $(git rev-parse HEAD^) &&
+	test $c1 = $(git rev-parse HEAD)
+
+'
+
+test_expect_success 'merge --no-ff c1' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge --no-ff c1 &&
+	test $c0 = $(git rev-parse HEAD^1) &&
+	test $c1 = $(git rev-parse HEAD^2)
+
+'
+
+test_debug 'gitk &'
+
+test_done
-- 
1.5.3.2.82.g75c8d
