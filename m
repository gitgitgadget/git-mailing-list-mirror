From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 6/6] git-merge: add --ff and --no-ff options
Date: Mon, 24 Sep 2007 00:51:45 +0200
Message-ID: <1190587905-700-7-git-send-email-hjemli@gmail.com>
References: <1190587905-700-1-git-send-email-hjemli@gmail.com>
 <1190587905-700-2-git-send-email-hjemli@gmail.com>
 <1190587905-700-3-git-send-email-hjemli@gmail.com>
 <1190587905-700-4-git-send-email-hjemli@gmail.com>
 <1190587905-700-5-git-send-email-hjemli@gmail.com>
 <1190587905-700-6-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:52:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaIy-0002CH-Kb
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbXIWWvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbXIWWvY
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:51:24 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:42784 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474AbXIWWvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:51:23 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8NMp91R023085;
	Mon, 24 Sep 2007 00:51:12 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190587905-700-6-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58995>

These new options can be used to control the policy for fast-forward
merges: --ff allows it (this is the default) while --no-ff will create
a merge commit.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/merge-options.txt |    9 +++++++++
 git-merge.sh                    |   22 ++++++++++++++++------
 t/t7600-merge.sh                |   20 ++++++++++++++++++++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 0464a34..9f1fc82 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -27,6 +27,15 @@
 	Perform the merge and commit the result. This option can
 	be used to override --squash.
 
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
index ee8342d..212e0ee 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--[no-]commit] [--[no-]squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -127,13 +127,17 @@ parse_option () {
 	--summary)
 		show_diffstat=t ;;
 	--sq|--squ|--squa|--squas|--squash)
-		squash=t no_commit=t ;;
+		allow_fast_forward=t squash=t no_commit=t ;;
 	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
-		squash= no_commit= ;;
+		allow_fast_forward=t squash= no_commit= ;;
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
@@ -477,7 +481,13 @@ done
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
index b0ef488..6424c6e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -417,4 +417,24 @@ test_expect_success 'merge c1 with c2 (override --squash)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c0 with c1 (no-ff)' '
+	git reset --hard c0 &&
+	test_tick &&
+	git merge --no-ff c1 &&
+	verify_merge file result.1 &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--no-ff" &&
+	git merge --ff c1 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.3.2.82.g75c8d
