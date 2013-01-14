From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC v2 5/8] contrib/subtree: Code cleaning and refactoring
Date: Mon, 14 Jan 2013 11:52:18 +0800
Message-ID: <1358135541-10349-6-git-send-email-techlivezheng@gmail.com>
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
	id 1TubCn-0006Wq-1X
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab3AND6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:58:48 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:41924 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291Ab3AND6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:58:46 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so1925516pbc.27
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2skQ4SzBintHbG2MbEt0ObeBTgqJ84V5hR7gnQ7yl8I=;
        b=gqZ2BZjMA3Lx1buxwU0givjdO1c8Np/1IxNK8Kszzr9hN8gqmXyalz7/zYm5B8wY7W
         Dq3GyKABRUiRxb7h6REGR15PRIyvT1QuIuFyWDKOH+YWiL5FrRPU5FQfA7imaX0s38MG
         rbRxXSEHEs1Z5iqyp85F2G2X3E+kIAjC1WavXr3sdplGp5KDeWdnrCS+KmsnXZvx0a1t
         UHOBjgqJaAToM+XIYEjHM5pBcq5DZLq4MKcAJKytggs1PEpt99312vYoPIdWZq8Nx2mA
         9036fyanzceQhFQoVlgNX9TePsB3OSCAVzd6wBF8wEWI+icOaNF365wkXM0dMQ7Os1bS
         jCNQ==
X-Received: by 10.68.138.229 with SMTP id qt5mr247915326pbb.122.1358135925245;
        Sun, 13 Jan 2013 19:58:45 -0800 (PST)
Received: from home.techlive.me ([122.244.159.146])
        by mx.google.com with ESMTPS id kl3sm7400598pbc.15.2013.01.13.19.58.39
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 19:58:44 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213427>

Mostly prepare for the later tests refactoring.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/t/t7900-subtree.sh | 251 +++++++++++++++++++------------------
 1 file changed, 130 insertions(+), 121 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 851d00c..69bd41c 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -4,7 +4,7 @@
 #
 test_description='Basic porcelain support for subtrees
 
-This test verifies the basic operation of the merge, pull, add
+This test verifies the basic operation of the add, pull, merge
 and split subcommands of git subtree.
 '
 
@@ -18,19 +18,6 @@ create()
 	git add "$1"
 }
 
-
-check_equal()
-{
-	test_debug 'echo'
-	test_debug "echo \"check a:\" \"{$1}\""
-	test_debug "echo \"		 b:\" \"{$2}\""
-	if [ "$1" = "$2" ]; then
-		return 0
-	else
-		return 1
-	fi
-}
-
 fixnl()
 {
 	t=""
@@ -55,6 +42,42 @@ undo()
 	git reset --hard HEAD~
 }
 
+test_equal()
+{
+	test_debug 'echo'
+	test_debug "echo \"check a:\" \"{$1}\""
+	test_debug "echo \"		 b:\" \"{$2}\""
+	if [ "$1" = "$2" ]; then
+		return 0
+	else
+		return 1
+	fi
+}
+
+# Make sure no patch changes more than one file.
+# The original set of commits changed only one file each.
+# A multi-file change would imply that we pruned commits
+# too aggressively.
+join_commits()
+{
+	commit=
+	all=
+	while read x y; do
+		if [ -z "$x" ]; then
+			continue
+		elif [ "$x" = "commit:" ]; then
+			if [ -n "$commit" ]; then
+				echo "$commit $all"
+				all=
+			fi
+			commit="$y"
+		else
+			all="$all $y"
+		fi
+	done
+	echo "$commit $all"
+}
+
 last_commit_message()
 {
 	git log --pretty=format:%s -1
@@ -93,7 +116,7 @@ test_expect_success 'add main4' '
 		create main4 &&
 		git commit -m "main4" &&
 		git branch -m master mainline &&
-		git branch subdir
+		git branch init
 '
 
 test_expect_success 'fetch subproj history' '
@@ -101,40 +124,43 @@ test_expect_success 'fetch subproj history' '
 		git branch sub1 FETCH_HEAD
 '
 
-test_expect_success 'no subtree exists in main tree' '
-		test_must_fail git subtree merge --prefix=subdir sub1
-'
-
 test_expect_success 'no pull from non-existant subtree' '
 		test_must_fail git subtree pull --prefix=subdir ./subproj sub1
 '
 
-test_expect_success 'check if --message works for add' '
-		git subtree add --prefix=subdir --message="Added subproject" sub1 &&
-		check_equal ''"$(last_commit_message)"'' "Added subproject" &&
+test_expect_success 'no merge from non-existant subtree' '
+		test_must_fail git subtree merge --prefix=subdir FETCH_HEAD
+'
+
+test_expect_success 'add subproj as subtree into subdir/ with --prefix' '
+		git subtree add --prefix=subdir FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Add '\''subdir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''" &&
 		undo
 '
 
-test_expect_success 'check if --message works as -m and --prefix as -P' '
-		git subtree add -P subdir -m "Added subproject using git subtree" sub1 &&
-		check_equal ''"$(last_commit_message)"'' "Added subproject using git subtree" &&
+test_expect_success 'add subproj as subtree into subdir/ with --prefix and --message' '
+		git subtree add --prefix=subdir --message="Added subproject" FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Added subproject" &&
 		undo
 '
 
-test_expect_success 'check if --message works with squash too' '
-		git subtree add -P subdir -m "Added subproject with squash" --squash sub1 &&
-		check_equal ''"$(last_commit_message)"'' "Added subproject with squash" &&
+test_expect_success 'add subproj as subtree into subdir/ with --prefix as -P and --message as -m' '
+		git subtree add -P subdir -m "Added subproject" FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Added subproject" &&
 		undo
 '
 
-test_expect_success 'add subproj to mainline' '
-		git subtree add --prefix=subdir/ FETCH_HEAD &&
-		check_equal ''"$(last_commit_message)"'' "Add '"'subdir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
+test_expect_success 'add subproj as subtree into subdir/ with --squash and --prefix and --message' '
+		git subtree add --prefix=subdir --message="Added subproject with squash" --squash FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Added subproject with squash" &&
+		undo
 '
 
-# this shouldn't actually do anything, since FETCH_HEAD is already a parent
-test_expect_success 'merge fetched subproj' '
-		git merge -m "merge -s -ours" -s ours FETCH_HEAD
+test_expect_success 'merge the added subproj again, should do nothing' '
+		git subtree add --prefix=subdir FETCH_HEAD &&
+		# this shouldn not actually do anything, since FETCH_HEAD
+		# is already a parent
+		git merge -s ours -m "merge -s -ours" FETCH_HEAD
 '
 
 test_expect_success 'add main-sub5' '
@@ -157,25 +183,30 @@ test_expect_success 'fetch new subproj history' '
 		git branch sub2 FETCH_HEAD
 '
 
-test_expect_success 'check if --message works for merge' '
-		git subtree merge --prefix=subdir -m "Merged changes from subproject" sub2 &&
-		check_equal ''"$(last_commit_message)"'' "Merged changes from subproject" &&
+test_expect_success 'merge new subproj history into subdir/ with --prefix' '
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into mainline" &&
 		undo
 '
 
-test_expect_success 'check if --message for merge works with squash too' '
-		git subtree merge --prefix subdir -m "Merged changes from subproject using squash" --squash sub2 &&
-		check_equal ''"$(last_commit_message)"'' "Merged changes from subproject using squash" &&
+test_expect_success 'merge new subproj history into subdir/ with --prefix and --message' '
+		git subtree merge --prefix=subdir --message="Merged changes from subproject" FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Merged changes from subproject" &&
 		undo
 '
 
-test_expect_success 'merge new subproj history into subdir' '
+test_expect_success 'merge new subproj history into subdir/ with --squash and --prefix and --message' '
+		git subtree merge --prefix=subdir --message="Merged changes from subproject using squash" --squash FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Merged changes from subproject using squash" &&
+		undo
+'
+
+test_expect_success 'merge new subproj history into subdir/' '
 		git subtree merge --prefix=subdir FETCH_HEAD &&
-		git branch pre-split &&
-		check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline"
+		git branch pre-split
 '
 
-test_expect_success 'Check that prefix argument is required for split' '
+test_expect_success 'split requires option --prefix' '
 		echo "You must provide the --prefix option." > expected &&
 		test_must_fail git subtree split > actual 2>&1 &&
 		test_debug "echo -n expected: " &&
@@ -186,48 +217,52 @@ test_expect_success 'Check that prefix argument is required for split' '
 		rm -f expected actual
 '
 
-test_expect_success 'Check that the <prefix> exists for a split' '
-		echo "'"'"'non-existent-directory'"'"'" does not exist\; use "'"'"'git subtree add'"'"'" > expected &&
+test_expect_success 'split requires path given by option --prefix must exist' '
+		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" > expected &&
 		test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
 		test_debug "echo -n expected: " &&
 		test_debug "cat expected" &&
 		test_debug "echo -n actual: " &&
 		test_debug "cat actual" &&
-		test_cmp expected actual
-#		 rm -f expected actual
+		test_cmp expected actual &&
+		rm -f expected actual
 '
 
-test_expect_success 'check if --message works for split+rejoin' '
-		spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+test_expect_success 'split subdir/ with --rejoin' '
+		spl1=$(git subtree split --prefix=subdir --annotate="*") &&
 		git branch spl1 "$spl1" &&
-		check_equal ''"$(last_commit_message)"'' "Split & rejoin" &&
+		git subtree split --prefix=subdir --annotate="*" --rejoin &&
+		test_equal "$(last_commit_message)" "Split '\''subdir/'\'' into commit '\''$spl1'\''" &&
 		undo
 '
 
-test_expect_success 'check split with --branch' '
-		spl1=$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
+test_expect_success 'split subdir/ with --rejoin and --message' '
+		git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin &&
+		test_equal "$(last_commit_message)" "Split & rejoin" &&
+		undo
+'
+
+test_expect_success 'split subdir/ with --branch' '
+		spl1=$(git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin) &&
 		undo &&
-		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr1 &&
-		check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
+		git subtree split --prefix=subdir --annotate="*" --branch splitbr1 &&
+		test_equal "$(git rev-parse splitbr1)" "$spl1"
 '
 
-test_expect_success 'check split with --branch for an existing branch' '
-		spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+test_expect_success 'split subdir/ with --branch for an existing branch' '
+		spl1=$(git subtree split --prefix=subdir --annotate="*" --message="Split & rejoin" --rejoin) &&
 		undo &&
 		git branch splitbr2 sub1 &&
-		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr2 &&
-		check_equal ''"$(git rev-parse splitbr2)"'' "$spl1"
+		git subtree split --prefix=subdir --annotate="*" --branch splitbr2 &&
+		test_equal "$(git rev-parse splitbr2)" "$spl1"
 '
 
-test_expect_success 'check split with --branch for an incompatible branch' '
-		test_must_fail git subtree split --prefix subdir --onto FETCH_HEAD --branch subdir
+test_expect_success 'split subdir/ with --branch for an incompatible branch' '
+		test_must_fail git subtree split --prefix=subdir --branch init
 '
 
-test_expect_success 'check split+rejoin' '
-		spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
-		undo &&
-		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --rejoin &&
-		check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
+test_expect_success 'split and rejoin' '
+		git subtree split --prefix=subdir --annotate="*" --rejoin
 '
 
 test_expect_success 'add main-sub8' '
@@ -253,8 +288,8 @@ test_expect_success 'add sub9' '
 cd ..
 
 test_expect_success 'split for sub8' '
-		split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
-		git branch split2 "$split2"
+		spl2=$(git subtree split --prefix=subdir/ --annotate="*" --rejoin) &&
+		git branch spl2 "$spl2"
 '
 
 test_expect_success 'add main-sub10' '
@@ -263,7 +298,7 @@ test_expect_success 'add main-sub10' '
 '
 
 test_expect_success 'split for sub10' '
-		spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
+		spl3=$(git subtree split --prefix=subdir --annotate="*" --rejoin) &&
 		git branch spl3 "$spl3"
 '
 
@@ -284,13 +319,13 @@ chks="sub1 sub2 sub3 sub9"
 chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
 
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
-		subfiles=''"$(git ls-files | fixnl)"'' &&
-		check_equal "$subfiles" "$chkms $chks"
+		subfiles=$(git ls-files | fixnl) &&
+		test_equal "$subfiles" "$chkms $chks"
 '
 
-test_expect_success 'make sure the subproj history *only* contains commits that affect the subdir' '
-		allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
-		check_equal "$allchanges" "$chkms $chks"
+test_expect_success 'make sure the subproj *only* contains commits that affect the subdir' '
+		allchanges=$(git log --name-only --pretty=format:"" | sort | fixnl) &&
+		test_equal "$allchanges" "$chkms $chks"
 '
 
 # Back to mainline
@@ -303,25 +338,25 @@ test_expect_success 'pull from subproj' '
 '
 
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
-		mainfiles=''"$(git ls-files | fixnl)"'' &&
-		check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
+		mainfiles=$(git ls-files | fixnl) &&
+		test_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
 '
 
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
 		# main-sub?? and /subdir/main-sub?? both change, because those are the
 		# changes that were split into their own history.  And subdir/sub?? never
 		# change, since they were *only* changed in the subtree branch.
-		allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
-		check_equal "$allchanges" ''"$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"''
+		allchanges=$(git log --name-only --pretty=format:"" | sort | fixnl) &&
+		test_equal "$allchanges" "$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"
 '
 
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
-		check_equal ''"$(git log --pretty=format:'"'%s'"' HEAD^2 | grep -i split)"'' ""
+		test_equal "$(git log --pretty=format:"%s" HEAD^2 | grep -i split)" ""
 '
 
 test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
 		# They are meaningless to subproj since one side of the merge refers to the mainline
-		check_equal ''"$(git log --pretty=format:'"'%s%n%b'"' HEAD^2 | grep "git-subtree.*:")"'' ""
+		test_equal "$(git log --pretty=format:"%s%n%b" HEAD^2 | grep "git-subtree.*:")" ""
 '
 
 # prepare second pair of repositories
@@ -359,7 +394,7 @@ cd ../main
 test_expect_success 'add sub as subdir in main' '
 		git fetch ../sub master &&
 		git branch sub2 FETCH_HEAD &&
-		git subtree add --prefix subdir sub2
+		git subtree add --prefix=subdir sub2
 '
 
 cd ../sub
@@ -374,7 +409,7 @@ cd ../main
 test_expect_success 'merge from sub' '
 		git fetch ../sub master &&
 		git branch sub3 FETCH_HEAD &&
-		git subtree merge --prefix subdir sub3
+		git subtree merge --prefix=subdir sub3
 '
 
 test_expect_success 'add main-sub4' '
@@ -383,7 +418,7 @@ test_expect_success 'add main-sub4' '
 '
 
 test_expect_success 'split for main-sub4 without --onto' '
-		git subtree split --prefix subdir --branch mainsub4
+		git subtree split --prefix=subdir --branch mainsub4
 '
 
 # at this point, the new commit parent should be sub3 if it is not,
@@ -392,7 +427,7 @@ test_expect_success 'split for main-sub4 without --onto' '
 # itself)
 
 test_expect_success 'check that the commit parent is sub3' '
-		check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
+		test_equal "$(git log --pretty=format:%P -1 mainsub4)" "$(git rev-parse sub3)"
 '
 
 test_expect_success 'add main-sub5' '
@@ -405,49 +440,23 @@ test_expect_success 'split for main-sub5 without --onto' '
 		# also test that we still can split out an entirely new subtree
 		# if the parent of the first commit in the tree is not empty,
 		# then the new subtree has accidently been attached to something
-		git subtree split --prefix subdir2 --branch mainsub5 &&
-		check_equal ''"$(git log --pretty=format:%P -1 mainsub5)"'' ""
+		git subtree split --prefix=subdir2 --branch mainsub5 &&
+		test_equal "$(git log --pretty=format:%P -1 mainsub5)" ""
 '
 
-# make sure no patch changes more than one file.  The original set of commits
-# changed only one file each.  A multi-file change would imply that we pruned
-# commits too aggressively.
-joincommits()
-{
-	commit=
-	all=
-	while read x y; do
-		#echo "{$x}" >&2
-		if [ -z "$x" ]; then
-			continue
-		elif [ "$x" = "commit:" ]; then
-			if [ -n "$commit" ]; then
-				echo "$commit $all"
-				all=
-			fi
-			commit="$y"
-		else
-			all="$all $y"
-		fi
-	done
-	echo "$commit $all"
-}
-
 test_expect_success 'verify one file change per commit' '
 		x= &&
-		list=''"$(git log --pretty=format:'"'commit: %H'"' | joincommits)"'' &&
-#		 test_debug "echo HERE" &&
-#		 test_debug "echo ''"$list"''" &&
-		(git log --pretty=format:'"'commit: %H'"' | joincommits |
-		(		while read commit a b; do
-				test_debug "echo Verifying commit "''"$commit"''
-				test_debug "echo a: "''"$a"''
-				test_debug "echo b: "''"$b"''
-				check_equal "$b" ""
+		git log --pretty=format:"commit: %H" | join_commits |
+		(
+			while read commit a b; do
+				test_debug "echo Verifying commit $commit"
+				test_debug "echo a: $a"
+				test_debug "echo b: $b"
+				test_equal "$b" ""
 				x=1
 			done
-			check_equal "$x" 1
-		))
+			test_equal "$x" 1
+		)
 '
 
 test_done
-- 
1.8.1
