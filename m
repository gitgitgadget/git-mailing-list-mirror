From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 5/5] git-merge: add --ff and --no-ff options
Date: Sat, 22 Sep 2007 02:33:06 +0200
Message-ID: <1190421186-21784-6-git-send-email-hjemli@gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
 <1190421186-21784-3-git-send-email-hjemli@gmail.com>
 <1190421186-21784-4-git-send-email-hjemli@gmail.com>
 <1190421186-21784-5-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYt68-00030j-Mf
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbXIVAnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbXIVAnp
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:43:45 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:47449 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbXIVAnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:43:45 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8M0WYsS018896;
	Sat, 22 Sep 2007 02:32:36 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190421186-21784-5-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58908>

These new options can be used to control the policy for fast-forward
merges: --ff allows it (this is the default) while --no-ff will create
a merge commit.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/merge-options.txt |    9 +++++++++
 git-merge.sh                    |   20 +++++++++++++++-----
 t/t7600-merge.sh                |   18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 9be90b5..b6c4dc4 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -23,6 +23,15 @@
 	top of the current branch whose effect is the same as
 	merging another branch (or more in case of an octopus).
 
+--no-ff::
+	Generate a merge commit even if the merge resolved as a
+	fast-forward.
+
+--ff::
+	Do not generate a merge commit if the merge resolved as
+	a fast-forward, only update the branch pointer. This is
+	the default behavior of git-merge.
+
 -s <strategy>, \--strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
diff --git a/git-merge.sh b/git-merge.sh
index 73ff130..daa95a1 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--[no-]commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--[no-]commit] [--squash] [--[no-]ff] -s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -127,11 +127,15 @@ parse_option () {
 	--summary)
 		show_diffstat=t ;;
 	--sq|--squ|--squa|--squas|--squash)
-		squash=t no_commit=t ;;
+		allow_fast_forward=t squash=t no_commit=t ;;
 	--c|--co|--com|--comm|--commi|--commit)
-		squash= no_commit= ;;
+		allow_fast_forward=t squash= no_commit= ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		squash= no_commit=t ;;
+		allow_fast_forward=t squash= no_commit=t ;;
+	--ff)
+		allow_fast_forward=t squash= no_commit= ;;
+	--no-ff)
+		allow_fast_forward=false squash= no_commit= ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -470,7 +474,13 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    parents=$(git show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
+    if test "$allow_fast_forward" = "t"
+    then
+        parents=$(git show-branch --independent "$head" "$@")
+    else
+        parents=$(git rev-parse "$head" "$@")
+    fi
+    parents=$(echo "$parents" | sed -e 's/^/-p /')
     result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge made by $wt_strategy."
     dropsave
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 75b0ee4..6e16a28 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -393,4 +393,22 @@ test_expect_success 'merge c1 with c2 (override --squash)' '
 	test "$c2" = "$(git rev-parse HEAD^2)"
 '
 
+test_expect_success 'merge c0 with c1 (no-ff)' '
+	git reset --hard c0 &&
+	git merge --no-ff c1 &&
+	test "$c0" = "$(git rev-parse HEAD^1)" &&
+	test "$c1" = "$(git rev-parse HEAD^2)"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--no-ff" &&
+	git merge --ff c1 &&
+	test "$c1" = "$(git rev-parse HEAD)"
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.3.2.82.g75c8d
