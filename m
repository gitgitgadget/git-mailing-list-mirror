From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 01/10] git-rebase.sh: Fix --merge --abort failures when path contains whitespace
Date: Sun,  4 May 2008 01:37:51 -0400
Message-ID: <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:40:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWxC-0004ce-3C
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYEDFjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYEDFjP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:39:15 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37821 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYEDFjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:39:14 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Mi-Ug; Sun, 04 May 2008 05:38:08 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvA-0004P7-Do; Sun, 04 May 2008 01:38:00 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81143>

Also update t/t3407-rebase-abort.sh to exercise the bug

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 git-rebase.sh           |    2 +-
 t/t3407-rebase-abort.sh |   33 +++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9b13b83..c43afe5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -214,7 +214,7 @@ do
 		else
 			die "No rebase in progress?"
 		fi
-		git reset --hard $(cat $dotest/orig-head)
+		git reset --hard $(cat "$dotest/orig-head")
 		rm -r "$dotest"
 		exit
 		;;
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 37944c3..1777ffe 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -4,7 +4,13 @@ test_description='git rebase --abort tests'
 
 . ./test-lib.sh
 
+### Test that we handle space characters properly
+work_dir="$(pwd)/test dir"
+
 test_expect_success setup '
+	mkdir -p "$work_dir" &&
+	cd "$work_dir" &&
+	git init &&
 	echo a > a &&
 	git add a &&
 	git commit -m a &&
@@ -28,32 +34,35 @@ testrebase() {
 	dotest=$2
 
 	test_expect_success "rebase$type --abort" '
+		cd "$work_dir" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d "$dotest" &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
+		test ! -d "$dotest"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
+		cd "$work_dir" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d "$dotest" &&
 		test_must_fail git rebase --skip &&
 		test $(git rev-parse HEAD) = $(git rev-parse master) &&
 		git-rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
+		test ! -d "$dotest"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
+		cd "$work_dir" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d "$dotest" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
@@ -61,7 +70,7 @@ testrebase() {
 		test $(git rev-parse HEAD) != $(git rev-parse master) &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
+		test ! -d "$dotest"
 	'
 }
 
-- 
1.5.5.1.128.g03a943
