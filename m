From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC v2 6/8] contrib/subtree: Make each test self-contained
Date: Mon, 14 Jan 2013 11:52:19 +0800
Message-ID: <1358135541-10349-7-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
 <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TubCn-0006Wq-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab3AND6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:58:53 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45679 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291Ab3AND6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:58:52 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so1993150pad.9
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=RgF2INIRsOrwVa2Zg5I6I/I0H9YePrOKIq2V454Ijws=;
        b=sbk/i94vhEXeTx77bnCNt2laLZE26VmUNmlV4/aj5G4VGFk2bPn7s5CvNOa49iTFV0
         VJCbKcmRHdefYt5B8QhogmFG5P0IgqLvr8p+aCfC+M19Sj1YyxUlzZea9BtTSjrriB0A
         OFWVOS2Ra/rM5I/HJFW41k3SWIutQMBIirjXcrEiwIj3xP16ZYk/eDxf83ko7uYtwYIL
         WmgYg7MhoDFKKXw+i/+66/p5tGcpHijMgNl6Jr8FNPDKUmS7tXfE9pQNGEbM8P/G2Ebz
         MIkiTkJPf69EyKvhIZMW/X+ojLWsCNg6iqeQzfoY9odc03KaREbM7OJZUNZRDmiAG/+4
         Fesg==
X-Received: by 10.68.216.201 with SMTP id os9mr35419406pbc.36.1358135932016;
        Sun, 13 Jan 2013 19:58:52 -0800 (PST)
Received: from home.techlive.me ([122.244.159.146])
        by mx.google.com with ESMTPS id kl3sm7400598pbc.15.2013.01.13.19.58.45
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 19:58:51 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213429>

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/t/t7900-subtree.sh | 865 ++++++++++++++++++++++++++-----------
 1 file changed, 614 insertions(+), 251 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 69bd41c..ef83f31 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -12,12 +12,6 @@ export TEST_DIRECTORY=$(pwd)/../../../t
 
 . ../../../t/test-lib.sh
 
-create()
-{
-	echo "$1" >"$1"
-	git add "$1"
-}
-
 fixnl()
 {
 	t=""
@@ -37,11 +31,6 @@ multiline()
 	done
 }
 
-undo()
-{
-	git reset --hard HEAD~
-}
-
 test_equal()
 {
 	test_debug 'echo'
@@ -78,373 +67,746 @@ join_commits()
 	echo "$commit $all"
 }
 
+test_create_commit() (
+	repo=$1
+	commit=$2
+	cd "$repo"
+	mkdir -p "$(dirname "$commit")"
+	echo "$commit" > "$commit"
+	git add "$commit"
+	git commit -m "$commit"
+)
+
 last_commit_message()
 {
 	git log --pretty=format:%s -1
 }
 
-test_expect_success 'init subproj' '
-		test_create_repo subproj
-'
-
-# To the subproject!
-cd subproj
-
-test_expect_success 'add sub1' '
-		create sub1 &&
-		git commit -m "sub1" &&
-		git branch sub1 &&
-		git branch -m master subproj
-'
-
-test_expect_success 'add sub2' '
-		create sub2 &&
-		git commit -m "sub2" &&
-		git branch sub2
-'
-
-test_expect_success 'add sub3' '
-		create sub3 &&
-		git commit -m "sub3" &&
-		git branch sub3
-'
-
-# Back to mainline
-cd ..
-
-test_expect_success 'add main4' '
-		create main4 &&
-		git commit -m "main4" &&
-		git branch -m master mainline &&
-		git branch init
-'
-
-test_expect_success 'fetch subproj history' '
-		git fetch ./subproj sub1 &&
-		git branch sub1 FETCH_HEAD
-'
+#
+# Tests for 'git subtree add'
+#
 
 test_expect_success 'no pull from non-existant subtree' '
-		test_must_fail git subtree pull --prefix=subdir ./subproj sub1
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		test_must_fail git subtree pull --prefix=subdir ./subproj master
+	)
 '
 
 test_expect_success 'no merge from non-existant subtree' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		test_must_fail git subtree merge --prefix=subdir FETCH_HEAD
+	)
 '
 
 test_expect_success 'add subproj as subtree into subdir/ with --prefix' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree add --prefix=subdir FETCH_HEAD &&
-		test_equal "$(last_commit_message)" "Add '\''subdir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''" &&
-		undo
+		test_equal "$(last_commit_message)" "Add '\''subdir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
 '
 
 test_expect_success 'add subproj as subtree into subdir/ with --prefix and --message' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree add --prefix=subdir --message="Added subproject" FETCH_HEAD &&
-		test_equal "$(last_commit_message)" "Added subproject" &&
-		undo
+		test_equal "$(last_commit_message)" "Added subproject"
+	)
 '
 
 test_expect_success 'add subproj as subtree into subdir/ with --prefix as -P and --message as -m' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree add -P subdir -m "Added subproject" FETCH_HEAD &&
-		test_equal "$(last_commit_message)" "Added subproject" &&
-		undo
+		test_equal "$(last_commit_message)" "Added subproject"
+	)
 '
 
 test_expect_success 'add subproj as subtree into subdir/ with --squash and --prefix and --message' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree add --prefix=subdir --message="Added subproject with squash" --squash FETCH_HEAD &&
-		test_equal "$(last_commit_message)" "Added subproject with squash" &&
-		undo
+		test_equal "$(last_commit_message)" "Added subproject with squash"
+	)
 '
 
 test_expect_success 'merge the added subproj again, should do nothing' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree add --prefix=subdir FETCH_HEAD &&
 		# this shouldn not actually do anything, since FETCH_HEAD
 		# is already a parent
 		git merge -s ours -m "merge -s -ours" FETCH_HEAD
+	)
 '
 
-test_expect_success 'add main-sub5' '
-		create subdir/main-sub5 &&
-		git commit -m "main-sub5"
-'
-
-test_expect_success 'add main6' '
-		create main6 &&
-		git commit -m "main6 boring"
-'
-
-test_expect_success 'add main-sub7' '
-		create subdir/main-sub7 &&
-		git commit -m "main-sub7"
-'
-
-test_expect_success 'fetch new subproj history' '
-		git fetch ./subproj sub2 &&
-		git branch sub2 FETCH_HEAD
-'
+#
+# Tests for 'git subtree merge'
+#
 
 test_expect_success 'merge new subproj history into subdir/ with --prefix' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		test_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into mainline" &&
-		undo
+		test_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
 '
 
 test_expect_success 'merge new subproj history into subdir/ with --prefix and --message' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir --message="Merged changes from subproject" FETCH_HEAD &&
-		test_equal "$(last_commit_message)" "Merged changes from subproject" &&
-		undo
+		test_equal "$(last_commit_message)" "Merged changes from subproject"
+	)
 '
 
 test_expect_success 'merge new subproj history into subdir/ with --squash and --prefix and --message' '
+	test_create_repo "$test_count/subproj" &&
+	test_create_repo "$test_count" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir --message="Merged changes from subproject using squash" --squash FETCH_HEAD &&
-		test_equal "$(last_commit_message)" "Merged changes from subproject using squash" &&
-		undo
+		test_equal "$(last_commit_message)" "Merged changes from subproject using squash"
+	)
 '
 
-test_expect_success 'merge new subproj history into subdir/' '
-		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git branch pre-split
-'
+#
+# Tests for 'git subtree split'
+#
 
 test_expect_success 'split requires option --prefix' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD &&
 		echo "You must provide the --prefix option." > expected &&
 		test_must_fail git subtree split > actual 2>&1 &&
 		test_debug "echo -n expected: " &&
 		test_debug "cat expected" &&
 		test_debug "echo -n actual: " &&
 		test_debug "cat actual" &&
-		test_cmp expected actual &&
-		rm -f expected actual
+		test_cmp expected actual
+	)
 '
 
 test_expect_success 'split requires path given by option --prefix must exist' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD &&
 		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" > expected &&
 		test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
 		test_debug "echo -n expected: " &&
 		test_debug "cat expected" &&
 		test_debug "echo -n actual: " &&
 		test_debug "cat actual" &&
-		test_cmp expected actual &&
-		rm -f expected actual
+		test_cmp expected actual
+	)
 '
 
 test_expect_success 'split subdir/ with --rejoin' '
-		spl1=$(git subtree split --prefix=subdir --annotate="*") &&
-		git branch spl1 "$spl1" &&
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
 		git subtree split --prefix=subdir --annotate="*" --rejoin &&
-		test_equal "$(last_commit_message)" "Split '\''subdir/'\'' into commit '\''$spl1'\''" &&
-		undo
+		test_equal "$(last_commit_message)" "Split '\''subdir/'\'' into commit '\''$split_hash'\''"
+	)
 '
 
 test_expect_success 'split subdir/ with --rejoin and --message' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
 		git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin &&
-		test_equal "$(last_commit_message)" "Split & rejoin" &&
-		undo
+		test_equal "$(last_commit_message)" "Split & rejoin"
+	)
 '
 
 test_expect_success 'split subdir/ with --branch' '
-		spl1=$(git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin) &&
-		undo &&
-		git subtree split --prefix=subdir --annotate="*" --branch splitbr1 &&
-		test_equal "$(git rev-parse splitbr1)" "$spl1"
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br &&
+		test_equal "$(git rev-parse subproj-br)" "$split_hash"
+	)
 '
 
 test_expect_success 'split subdir/ with --branch for an existing branch' '
-		spl1=$(git subtree split --prefix=subdir --annotate="*" --message="Split & rejoin" --rejoin) &&
-		undo &&
-		git branch splitbr2 sub1 &&
-		git subtree split --prefix=subdir --annotate="*" --branch splitbr2 &&
-		test_equal "$(git rev-parse splitbr2)" "$spl1"
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git branch subproj-br FETCH_HEAD &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		split_hash=$(git subtree split --prefix=subdir --annotate="*") &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br &&
+		test_equal "$(git rev-parse subproj-br)" "$split_hash"
+	)
 '
 
 test_expect_success 'split subdir/ with --branch for an incompatible branch' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git branch init HEAD &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
 		test_must_fail git subtree split --prefix=subdir --branch init
+	)
 '
 
-test_expect_success 'split and rejoin' '
-		git subtree split --prefix=subdir --annotate="*" --rejoin
-'
-
-test_expect_success 'add main-sub8' '
-		create subdir/main-sub8 &&
-		git commit -m "main-sub8"
-'
-
-# To the subproject!
-cd ./subproj
-
-test_expect_success 'merge split into subproj' '
-		git fetch .. spl1 &&
-		git branch spl1 FETCH_HEAD &&
-		git merge FETCH_HEAD
-'
-
-test_expect_success 'add sub9' '
-		create sub9 &&
-		git commit -m "sub9"
-'
-
-# Back to mainline
-cd ..
-
-test_expect_success 'split for sub8' '
-		spl2=$(git subtree split --prefix=subdir/ --annotate="*" --rejoin) &&
-		git branch spl2 "$spl2"
-'
-
-test_expect_success 'add main-sub10' '
-		create subdir/main-sub10 &&
-		git commit -m "main-sub10"
-'
-
-test_expect_success 'split for sub10' '
-		spl3=$(git subtree split --prefix=subdir --annotate="*" --rejoin) &&
-		git branch spl3 "$spl3"
-'
-
-# To the subproject!
-cd ./subproj
-
-test_expect_success 'merge split into subproj' '
-		git fetch .. spl3 &&
-		git branch spl3 FETCH_HEAD &&
-		git merge FETCH_HEAD &&
-		git branch subproj-merge-spl3
-'
-
-chkm="main4 main6"
-chkms="main-sub10 main-sub5 main-sub7 main-sub8"
-chkms_sub=$(echo $chkms | multiline | sed 's,^,subdir/,' | fixnl)
-chks="sub1 sub2 sub3 sub9"
-chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
+#
+# Validity checking
+#
 
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count/subproj" sub3 &&
+	test_create_commit "$test_count" subdir/main-sub3 &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count" subdir/main-sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD &&
+
+		chks="sub1 sub2 sub3 sub4" &&
+		chks_sub=$(echo $chks | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+		chkms="main-sub1 main-sub2 main-sub3 main-sub4" &&
+		chkms_sub=$(echo $chkms | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+
 		subfiles=$(git ls-files | fixnl) &&
 		test_equal "$subfiles" "$chkms $chks"
+	)
 '
 
 test_expect_success 'make sure the subproj *only* contains commits that affect the subdir' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count/subproj" sub3 &&
+	test_create_commit "$test_count" subdir/main-sub3 &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count" subdir/main-sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD &&
+
+		chks="sub1 sub2 sub3 sub4" &&
+		chks_sub=$(echo $chks | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+		chkms="main-sub1 main-sub2 main-sub3 main-sub4" &&
+		chkms_sub=$(echo $chkms | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+
 		allchanges=$(git log --name-only --pretty=format:"" | sort | fixnl) &&
 		test_equal "$allchanges" "$chkms $chks"
-'
-
-# Back to mainline
-cd ..
-
-test_expect_success 'pull from subproj' '
-		git fetch ./subproj subproj-merge-spl3 &&
-		git branch subproj-merge-spl3 FETCH_HEAD &&
-		git subtree pull --prefix=subdir ./subproj subproj-merge-spl3
+	)
 '
 
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count/subproj" sub3 &&
+	test_create_commit "$test_count" subdir/main-sub3 &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count" subdir/main-sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	(
+		cd "$test_count" &&
+		git subtree pull --prefix=subdir ./subproj master &&
+
+		chkm="main1 main2" &&
+		chks="sub1 sub2 sub3 sub4" &&
+		chks_sub=$(echo $chks | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+		chkms="main-sub1 main-sub2 main-sub3 main-sub4" &&
+		chkms_sub=$(echo $chkms | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+
 		mainfiles=$(git ls-files | fixnl) &&
 		test_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
+	)
 '
 
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count/subproj" sub3 &&
+	test_create_commit "$test_count" subdir/main-sub3 &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count" subdir/main-sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	(
+		cd "$test_count" &&
+		git subtree pull --prefix=subdir ./subproj master &&
+
+		chkm="main1 main2" &&
+		chks="sub1 sub2 sub3 sub4" &&
+		chks_sub=$(echo $chks | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+		chkms="main-sub1 main-sub2 main-sub3 main-sub4" &&
+		chkms_sub=$(echo $chkms | multiline | sed '\''s,^,subdir/,'\'' | fixnl) &&
+
 		# main-sub?? and /subdir/main-sub?? both change, because those are the
 		# changes that were split into their own history.  And subdir/sub?? never
 		# change, since they were *only* changed in the subtree branch.
 		allchanges=$(git log --name-only --pretty=format:"" | sort | fixnl) &&
 		test_equal "$allchanges" "$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"
+	)
 '
 
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count/subproj" sub3 &&
+	test_create_commit "$test_count" subdir/main-sub3 &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count" subdir/main-sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	(
+		cd "$test_count" &&
+		git subtree pull --prefix=subdir ./subproj master &&
+
 		test_equal "$(git log --pretty=format:"%s" HEAD^2 | grep -i split)" ""
+	)
 '
 
 test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	test_create_commit "$test_count" subdir/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count/subproj" sub3 &&
+	test_create_commit "$test_count" subdir/main-sub3 &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	test_create_commit "$test_count" subdir/main-sub4 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --annotate="*" --branch subproj-br --rejoin
+	) &&
+	(
+		cd "$test_count/subproj" &&
+		git fetch .. subproj-br && git merge FETCH_HEAD
+	) &&
+	(
+		cd "$test_count" &&
+		git subtree pull --prefix=subdir ./subproj master &&
+
 		# They are meaningless to subproj since one side of the merge refers to the mainline
 		test_equal "$(git log --pretty=format:"%s%n%b" HEAD^2 | grep "git-subtree.*:")" ""
+	)
 '
 
-# prepare second pair of repositories
-mkdir test2
-cd test2
-
-test_expect_success 'init main' '
-		test_create_repo main
-'
-
-cd main
-
-test_expect_success 'add main1' '
-		create main1 &&
-		git commit -m "main1"
-'
-
-cd ..
-
-test_expect_success 'init sub' '
-		test_create_repo sub
-'
-
-cd sub
-
-test_expect_success 'add sub2' '
-		create sub2 &&
-		git commit -m "sub2"
-'
-
-cd ../main
-
-# check if split can find proper base without --onto
-
-test_expect_success 'add sub as subdir in main' '
-		git fetch ../sub master &&
-		git branch sub2 FETCH_HEAD &&
-		git subtree add --prefix=subdir sub2
-'
-
-cd ../sub
-
-test_expect_success 'add sub3' '
-		create sub3 &&
-		git commit -m "sub3"
-'
-
-cd ../main
-
-test_expect_success 'merge from sub' '
-		git fetch ../sub master &&
-		git branch sub3 FETCH_HEAD &&
-		git subtree merge --prefix=subdir sub3
-'
-
-test_expect_success 'add main-sub4' '
-		create subdir/main-sub4 &&
-		git commit -m "main-sub4"
-'
-
-test_expect_success 'split for main-sub4 without --onto' '
-		git subtree split --prefix=subdir --branch mainsub4
-'
-
-# at this point, the new commit parent should be sub3 if it is not,
-# something went wrong (the "newparent" of "master~" commit should
-# have been sub3, but it was not, because its cache was not set to
-# itself)
-
-test_expect_success 'check that the commit parent is sub3' '
-		test_equal "$(git log --pretty=format:%P -1 mainsub4)" "$(git rev-parse sub3)"
-'
+#
+# A new set of tests
+#
 
-test_expect_success 'add main-sub5' '
-		mkdir subdir2 &&
-		create subdir2/main-sub5 &&
-		git commit -m "main-sub5"
-'
+test_expect_success 'make sure "git subtree split" find the correct parent' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git branch subproj-ref FETCH_HEAD &&
+		git subtree merge --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --branch subproj-br &&
+
+		# at this point, the new commit parent should be subproj-ref, if it is
+		# not, something went wrong (the "newparent" of "master~" commit should
+		# have been sub2, but it was not, because its cache was not set to
+		# itself)
+		test_equal "$(git log --pretty=format:%P -1 subproj-br)" "$(git rev-parse subproj-ref)"
+	)
+'
+
+test_expect_success 'split a new subtree without --onto option' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --branch subproj-br
+	) &&
+	test_create_commit "$test_count" subdir2/main-sub2 &&
+	(
+		cd "$test_count" &&
 
-test_expect_success 'split for main-sub5 without --onto' '
 		# also test that we still can split out an entirely new subtree
 		# if the parent of the first commit in the tree is not empty,
 		# then the new subtree has accidently been attached to something
-		git subtree split --prefix=subdir2 --branch mainsub5 &&
-		test_equal "$(git log --pretty=format:%P -1 mainsub5)" ""
+		git subtree split --prefix=subdir2 --branch subproj2-br &&
+		test_equal "$(git log --pretty=format:%P -1 subproj2-br)" ""
+	)
 '
 
 test_expect_success 'verify one file change per commit' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git branch sub1 FETCH_HEAD &&
+		git subtree add --prefix=subdir sub1
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subdir/main-sub1 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir --branch subproj-br
+	) &&
+	test_create_commit "$test_count" subdir2/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subdir2 --branch subproj2-br &&
+
 		x= &&
 		git log --pretty=format:"commit: %H" | join_commits |
 		(
@@ -457,6 +819,7 @@ test_expect_success 'verify one file change per commit' '
 			done
 			test_equal "$x" 1
 		)
+	)
 '
 
 test_done
-- 
1.8.1
