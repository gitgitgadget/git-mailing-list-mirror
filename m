From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 4/5] git-merge: add support for --commit
Date: Sat, 22 Sep 2007 02:33:05 +0200
Message-ID: <1190421186-21784-5-git-send-email-hjemli@gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
 <1190421186-21784-3-git-send-email-hjemli@gmail.com>
 <1190421186-21784-4-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYswe-00017n-1T
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbXIVAda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420AbXIVAda
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:33:30 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:46840 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbXIVAd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:33:29 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8M0WYsR018896;
	Sat, 22 Sep 2007 02:32:35 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190421186-21784-4-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58907>

This option can be used to override --no-commit and --squash. The change
also introduces slightly different behavior for --no-commit: when specified,
it explicitly overrides --squash.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/merge-options.txt |    4 ++++
 git-merge.sh                    |    6 ++++--
 t/t7600-merge.sh                |   16 ++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index d64c259..9be90b5 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -10,6 +10,10 @@
 	not autocommit, to give the user a chance to inspect and
 	further tweak the merge result before committing.
 
+--commit::
+	Perform the merge and commit the result. This option can
+	be used to override --no-commit and --squash.
+
 --squash::
 	Produce the working tree and index state as if a real
 	merge happened, but do not actually make a commit or
diff --git a/git-merge.sh b/git-merge.sh
index 39a24ac..73ff130 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--[no-]commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -128,8 +128,10 @@ parse_option () {
 		show_diffstat=t ;;
 	--sq|--squ|--squa|--squas|--squash)
 		squash=t no_commit=t ;;
+	--c|--co|--com|--comm|--commi|--commit)
+		squash= no_commit= ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		no_commit=t ;;
+		squash= no_commit=t ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e99b5d9..75b0ee4 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -377,4 +377,20 @@ test_expect_success 'override config option --summary' '
 	fi
 '
 
+test_expect_success 'merge c1 with c2 (override --no-commit)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--no-commit" &&
+	git merge --commit c2 &&
+	test "$c1" = "$(git rev-parse HEAD^1)" &&
+	test "$c2" = "$(git rev-parse HEAD^2)"
+'
+
+test_expect_success 'merge c1 with c2 (override --squash)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--squash" &&
+	git merge --commit c2 &&
+	test "$c1" = "$(git rev-parse HEAD^1)" &&
+	test "$c2" = "$(git rev-parse HEAD^2)"
+'
+
 test_done
-- 
1.5.3.2.82.g75c8d
