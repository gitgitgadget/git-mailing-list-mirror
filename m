From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 01/10] git-rebase.sh: Fix --merge --abort failures when path contains whitespace
Date: Thu, 10 Apr 2008 02:50:07 -0400
Message-ID: <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjqdd-00035M-5z
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYDJGvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYDJGvT
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:51:19 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34041 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbYDJGvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:51:18 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wB-OK; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbw-0007Fr-Q8; Thu, 10 Apr 2008 02:50:16 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79176>

Also update t/t3407-rebase-abort.sh to exercise the bug

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 git-rebase.sh           |    2 +-
 t/t3407-rebase-abort.sh |   55 +++++++++++++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 24 deletions(-)

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
index 37944c3..396a354 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -4,7 +4,13 @@ test_description='git rebase --abort tests'
 
 . ./test-lib.sh
 
+### Test that we handle strange characters properly
+work_dir="$(pwd)/test \" ' \$ \\ dir"
+
 test_expect_success setup '
+	mkdir -p "$work_dir" &&
+	cd "$work_dir" &&
+	git init &&
 	echo a > a &&
 	git add a &&
 	git commit -m a &&
@@ -27,42 +33,45 @@ testrebase() {
 	type=$1
 	dotest=$2
 
-	test_expect_success "rebase$type --abort" '
+	test_expect_success "rebase$type --abort" "
+		cd \"\$work_dir\" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d \"\$dotest\" &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
-	'
+		test \$(git rev-parse to-rebase) = \$(git rev-parse pre-rebase) &&
+		test ! -d \"\$dotest\"
+	"
 
-	test_expect_success "rebase$type --abort after --skip" '
+	test_expect_success "rebase$type --abort after --skip" "
+		cd \"\$work_dir\" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d \"\$dotest\" &&
 		test_must_fail git rebase --skip &&
-		test $(git rev-parse HEAD) = $(git rev-parse master) &&
+		test \$(git rev-parse HEAD) = \$(git rev-parse master) &&
 		git-rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
-	'
+		test \$(git rev-parse to-rebase) = \$(git rev-parse pre-rebase) &&
+		test ! -d \"\$dotest\"
+	"
 
-	test_expect_success "rebase$type --abort after --continue" '
+	test_expect_success "rebase$type --abort after --continue" "
+		cd \"\$work_dir\" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d \"\$dotest\" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
 		test_must_fail git rebase --continue &&
-		test $(git rev-parse HEAD) != $(git rev-parse master) &&
+		test \$(git rev-parse HEAD) != \$(git rev-parse master) &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
-	'
+		test \$(git rev-parse to-rebase) = \$(git rev-parse pre-rebase) &&
+		test ! -d \"\$dotest\"
+	"
 }
 
 testrebase "" .dotest
-- 
1.5.5.33.gc0a39.dirty
