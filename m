From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 5/6] git-merge: add support for --commit and --no-squash
Date: Mon, 24 Sep 2007 00:51:44 +0200
Message-ID: <1190587905-700-6-git-send-email-hjemli@gmail.com>
References: <1190587905-700-1-git-send-email-hjemli@gmail.com>
 <1190587905-700-2-git-send-email-hjemli@gmail.com>
 <1190587905-700-3-git-send-email-hjemli@gmail.com>
 <1190587905-700-4-git-send-email-hjemli@gmail.com>
 <1190587905-700-5-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaIQ-000243-UZ
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbXIWWvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbXIWWvT
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:51:19 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:42776 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106AbXIWWvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:51:17 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8NMp91Q023085;
	Mon, 24 Sep 2007 00:51:11 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190587905-700-5-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58993>

These options can be used to override --no-commit and --squash, which is
needed since --no-commit and --squash now can be specified as default merge
options in $GIT_DIR/config.

The change also introduces slightly different behavior for --no-commit:
when specified, it explicitly overrides --squash. Earlier,
'git merge --squash --no-commit' would result in a squashed merge (i.e. no
$GIT_DIR/MERGE_HEAD was created) but with this patch the command will
behave as if --squash hadn't been specified.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/merge-options.txt |    8 ++++++++
 git-merge.sh                    |    8 ++++++--
 t/t7600-merge.sh                |   22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index d64c259..0464a34 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -10,6 +10,10 @@
 	not autocommit, to give the user a chance to inspect and
 	further tweak the merge result before committing.
 
+--commit::
+	Perform the merge and commit the result. This option can
+	be used to override --no-commit.
+
 --squash::
 	Produce the working tree and index state as if a real
 	merge happened, but do not actually make a commit or
@@ -19,6 +23,10 @@
 	top of the current branch whose effect is the same as
 	merging another branch (or more in case of an octopus).
 
+--no-squash::
+	Perform the merge and commit the result. This option can
+	be used to override --squash.
+
 -s <strategy>, \--strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
diff --git a/git-merge.sh b/git-merge.sh
index e95d4a7..ee8342d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--[no-]commit] [--[no-]squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -128,8 +128,12 @@ parse_option () {
 		show_diffstat=t ;;
 	--sq|--squ|--squa|--squas|--squash)
 		squash=t no_commit=t ;;
+	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
+		squash= no_commit= ;;
+	--c|--co|--com|--comm|--commi|--commit)
+		squash= no_commit= ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		no_commit=t ;;
+		squash= no_commit=t ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 110974c..b0ef488 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -395,4 +395,26 @@ test_expect_success 'override config option --summary' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (override --no-commit)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--no-commit" &&
+	test_tick &&
+	git merge --commit c2 &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (override --squash)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--squash" &&
+	test_tick &&
+	git merge --no-squash c2 &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.3.2.82.g75c8d
