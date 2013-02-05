From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 10/13] contrib/subtree: Code cleaning and refactoring
Date: Tue,  5 Feb 2013 05:36:56 -0600
Message-ID: <1360064219-28789-11-git-send-email-greened@obbligato.org>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
Cc: Techlive Zheng <techlivezheng@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 13:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2hJt-0003Lu-2z
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 13:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab3BEMHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 07:07:39 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38280 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754885Ab3BEMHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 07:07:36 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2grb-00055A-U6; Tue, 05 Feb 2013 05:39:01 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360064219-28789-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> Mostly prepare
    for the later tests refactoring. Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
    Signed-off-by: David A. Greene <greened@obbligato.org> --- contrib/subtree/t/t7900-subtree.sh
    | 270 ++++++++++++++++++ 1 file changed, 136 insertions(+), 134 deletions(-)
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED         
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215494>

From: Techlive Zheng <techlivezheng@gmail.com>

Mostly prepare for the later tests refactoring.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/t/t7900-subtree.sh |  270 ++++++++++++++++++------------------
 1 file changed, 136 insertions(+), 134 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index e6bcd50..9cfaaf9 100755
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
@@ -97,7 +120,7 @@ test_expect_success 'add main4' '
 		create main4 &&
 		git commit -m "main4" &&
 		git branch -m master mainline &&
-		git branch subdir
+		git branch init
 '
 
 test_expect_success 'fetch subproj history' '
@@ -105,40 +128,43 @@ test_expect_success 'fetch subproj history' '
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
@@ -161,25 +187,30 @@ test_expect_success 'fetch new subproj history' '
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
@@ -190,59 +221,56 @@ test_expect_success 'Check that prefix argument is required for split' '
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
-		git branch spl1 "$spl1" &&
-		check_equal ''"$(last_commit_message)"'' "Split & rejoin" &&
-		undo
-'
+test_expect_success 'split subdir/ with --rejoin' '
+		spl1=$(git subtree split --prefix=subdir --annotate="*") &&
+ 		git branch spl1 "$spl1" &&
+		git subtree split --prefix=subdir --annotate="*" --rejoin &&
+		test_equal "$(last_commit_message)" "Split '\''subdir/'\'' into commit '\''$spl1'\''" &&
+ 		undo
+ '
 
-test_expect_success 'check split with --branch' '
-		spl1=$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
-		undo &&
-		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr1 &&
-		check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
+test_expect_success 'split subdir/ with --rejoin and --message' '
+		git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin &&
+		test_equal "$(last_commit_message)" "Split & rejoin" &&
+		undo
 '
 
-test_expect_success 'check hash of split' '
-        spl1=$(git subtree split --prefix subdir) &&
-        undo &&
-        git subtree split --prefix subdir --branch splitbr1test &&
-        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
-        git checkout splitbr1test &&
-        new_hash=$(git rev-parse HEAD~2) &&
-        git checkout mainline &&
-        check_equal ''"$new_hash"'' "$subdir_hash"
-'
+test_expect_success 'split subdir/ with --branch' '
+		spl1=$(git subtree split --prefix=subdir --message="Split & rejoin" --annotate="*" --rejoin) &&
+ 		undo &&
+		git subtree split --prefix=subdir --annotate="*" --branch splitbr1 &&
+		test_equal "$(git rev-parse splitbr1)" "$spl1"
+ '
 
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
+test_expect_success 'check --unannotate' '
+		spl1=$(git subtree split --unannotate="subproj:" --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
 		undo &&
-		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --rejoin &&
-		check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
+ 		git subtree split --unannotate="subproj:" --prefix subdir --onto FETCH_HEAD --branch splitunann &&
+		test_equal "$(git rev-parse splitunann)" "$spl1" &&
+		test_equal "$(git log splitunann | grep subproj)" ""
 '
 
 test_expect_success 'add main-sub8' '
@@ -268,8 +296,8 @@ test_expect_success 'add sub9' '
 cd ..
 
 test_expect_success 'split for sub8' '
-		split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
-		git branch split2 "$split2"
+		spl2=$(git subtree split --prefix=subdir/ --annotate="*" --rejoin) &&
+		git branch spl2 "$spl2"
 '
 
 test_expect_success 'add main-sub10' '
@@ -278,7 +306,7 @@ test_expect_success 'add main-sub10' '
 '
 
 test_expect_success 'split for sub10' '
-		spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
+		spl3=$(git subtree split --prefix=subdir --annotate="*" --rejoin) &&
 		git branch spl3 "$spl3"
 '
 
@@ -299,13 +327,13 @@ chks="sub1 sub2 sub3 sub9"
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
@@ -318,25 +346,25 @@ test_expect_success 'pull from subproj' '
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
@@ -374,7 +402,7 @@ cd ../main
 test_expect_success 'add sub as subdir in main' '
 		git fetch ../sub master &&
 		git branch sub2 FETCH_HEAD &&
-		git subtree add --prefix subdir sub2
+		git subtree add --prefix=subdir sub2
 '
 
 cd ../sub
@@ -389,7 +417,7 @@ cd ../main
 test_expect_success 'merge from sub' '
 		git fetch ../sub master &&
 		git branch sub3 FETCH_HEAD &&
-		git subtree merge --prefix subdir sub3
+		git subtree merge --prefix=subdir sub3
 '
 
 test_expect_success 'add main-sub4' '
@@ -398,7 +426,7 @@ test_expect_success 'add main-sub4' '
 '
 
 test_expect_success 'split for main-sub4 without --onto' '
-		git subtree split --prefix subdir --branch mainsub4
+		git subtree split --prefix=subdir --branch mainsub4
 '
 
 # at this point, the new commit parent should be sub3 if it is not,
@@ -407,7 +435,7 @@ test_expect_success 'split for main-sub4 without --onto' '
 # itself)
 
 test_expect_success 'check that the commit parent is sub3' '
-		check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
+		test_equal "$(git log --pretty=format:%P -1 mainsub4)" "$(git rev-parse sub3)"
 '
 
 test_expect_success 'add main-sub5' '
@@ -420,49 +448,23 @@ test_expect_success 'split for main-sub5 without --onto' '
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
1.7.10.4
