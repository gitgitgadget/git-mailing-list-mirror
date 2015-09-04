From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v1 1/2] t7900-subtree: test the "space in a subdirectory name" case
Date: Sat,  5 Sep 2015 01:24:10 +0300
Message-ID: <d3e9f4150d2b6f1308a01eb248e5a54bc16e683a.1441404851.git.Alex.Crezoff@gmail.com>
References: <cover.1441404851.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:24:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXzPY-00085K-UM
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 00:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760545AbbIDWYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 18:24:39 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:34571 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760190AbbIDWYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 18:24:36 -0400
Received: by laeb10 with SMTP id b10so22203450lae.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=p44k6UuSXjHUDQ+xuGCYMVlEZAjvlZzIVZXyZ5RJck0=;
        b=F9cW46cqRsISkdyKsVs1viisFgCPuok8NVc1xU287Lszw9mhyXnUX0m9tuvTN2Xm5/
         tajjPmIHIlWLrwHklNIDJ64AELalE5WhAyDYLSXlLkJvXnTGitRLE9Y0x4RoVpjIPnrd
         YnvkDviFxx/nwU93hvvyp4LBBzjbsGnyTJ4v2IAieltsjXxZiKzqws4YtdmXJk33K1PR
         gcvtJODLGycEtGeu+vLLOvAx1nGL/OzA9y68/kL8xl9AcUw9OG50XD8ChkN6i/fpyjWX
         KSfBuFdeB4dGfIqD+N9V0p2kR60MhBFQy2yWLWbSJJBbqmEYVRciFJ2SVpmCS3+pg0kY
         uMOQ==
X-Received: by 10.152.21.103 with SMTP id u7mr5545429lae.49.1441405474590;
        Fri, 04 Sep 2015 15:24:34 -0700 (PDT)
Received: from localhost ([213.108.22.197])
        by smtp.gmail.com with ESMTPSA id h7sm899631lbl.8.2015.09.04.15.24.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2015 15:24:33 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 2.4.1-21
In-Reply-To: <cover.1441404851.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1441404851.git.Alex.Crezoff@gmail.com>
References: <cover.1441404851.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277342>

In common case there can be spaces in a subdirectory name. Change tests
accorgingly to this statement.

Also, as far as a call to the `rejoin_msg` function (in `cmd_split`)
does not take into account such a case this patch fixes commit message
when `--rejoin` option is set .

Besides, as `fixnl` and `multiline` functions did not take into account
the "new" tested "space in a subdirectory name" case they become unused
and redundant, so they are removed.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 contrib/subtree/git-subtree.sh     |   2 +-
 contrib/subtree/t/t7900-subtree.sh | 147 +++++++++++++++++++------------------
 2 files changed, 76 insertions(+), 73 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9f06571..72a20c0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -648,7 +648,7 @@ cmd_split()
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old)
 		git merge -s ours \
-			-m "$(rejoin_msg $dir $latest_old $latest_new)" \
+			-m "$(rejoin_msg "$dir" $latest_old $latest_new)" \
 			$latest_new >&2 || exit $?
 	fi
 	if [ -n "$branch" ]; then
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 9051982..9979827 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -32,25 +32,6 @@ check_equal()
 	fi
 }
 
-fixnl()
-{
-	t=""
-	while read x; do
-		t="$t$x "
-	done
-	echo $t
-}
-
-multiline()
-{
-	while read x; do
-		set -- $x
-		for d in "$@"; do
-			echo "$d"
-		done
-	done
-}
-
 undo()
 {
 	git reset --hard HEAD~
@@ -62,11 +43,11 @@ last_commit_message()
 }
 
 test_expect_success 'init subproj' '
-	test_create_repo subproj
+	test_create_repo "sub proj"
 '
 
 # To the subproject!
-cd subproj
+cd ./"sub proj"
 
 test_expect_success 'add sub1' '
 	create sub1 &&
@@ -106,39 +87,39 @@ test_expect_success 'add main4' '
 '
 
 test_expect_success 'fetch subproj history' '
-	git fetch ./subproj sub1 &&
+	git fetch ./"sub proj" sub1 &&
 	git branch sub1 FETCH_HEAD
 '
 
 test_expect_success 'no subtree exists in main tree' '
-	test_must_fail git subtree merge --prefix=subdir sub1
+	test_must_fail git subtree merge --prefix="sub dir" sub1
 '
 
 test_expect_success 'no pull from non-existant subtree' '
-	test_must_fail git subtree pull --prefix=subdir ./subproj sub1
+	test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" sub1
 '
 
 test_expect_success 'check if --message works for add' '
-	git subtree add --prefix=subdir --message="Added subproject" sub1 &&
+	git subtree add --prefix="sub dir" --message="Added subproject" sub1 &&
 	check_equal ''"$(last_commit_message)"'' "Added subproject" &&
 	undo
 '
 
 test_expect_success 'check if --message works as -m and --prefix as -P' '
-	git subtree add -P subdir -m "Added subproject using git subtree" sub1 &&
+	git subtree add -P "sub dir" -m "Added subproject using git subtree" sub1 &&
 	check_equal ''"$(last_commit_message)"'' "Added subproject using git subtree" &&
 	undo
 '
 
 test_expect_success 'check if --message works with squash too' '
-	git subtree add -P subdir -m "Added subproject with squash" --squash sub1 &&
+	git subtree add -P "sub dir" -m "Added subproject with squash" --squash sub1 &&
 	check_equal ''"$(last_commit_message)"'' "Added subproject with squash" &&
 	undo
 '
 
 test_expect_success 'add subproj to mainline' '
-	git subtree add --prefix=subdir/ FETCH_HEAD &&
-	check_equal ''"$(last_commit_message)"'' "Add '"'subdir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
+	git subtree add --prefix="sub dir"/ FETCH_HEAD &&
+	check_equal ''"$(last_commit_message)"'' "Add '"'sub dir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
 '
 
 # this shouldn't actually do anything, since FETCH_HEAD is already a parent
@@ -147,7 +128,7 @@ test_expect_success 'merge fetched subproj' '
 '
 
 test_expect_success 'add main-sub5' '
-	create subdir/main-sub5 &&
+	create "sub dir/main-sub5" &&
 	git commit -m "main-sub5"
 '
 
@@ -157,29 +138,29 @@ test_expect_success 'add main6' '
 '
 
 test_expect_success 'add main-sub7' '
-	create subdir/main-sub7 &&
+	create "sub dir/main-sub7" &&
 	git commit -m "main-sub7"
 '
 
 test_expect_success 'fetch new subproj history' '
-	git fetch ./subproj sub2 &&
+	git fetch ./"sub proj" sub2 &&
 	git branch sub2 FETCH_HEAD
 '
 
 test_expect_success 'check if --message works for merge' '
-	git subtree merge --prefix=subdir -m "Merged changes from subproject" sub2 &&
+	git subtree merge --prefix="sub dir" -m "Merged changes from subproject" sub2 &&
 	check_equal ''"$(last_commit_message)"'' "Merged changes from subproject" &&
 	undo
 '
 
 test_expect_success 'check if --message for merge works with squash too' '
-	git subtree merge --prefix subdir -m "Merged changes from subproject using squash" --squash sub2 &&
+	git subtree merge --prefix "sub dir" -m "Merged changes from subproject using squash" --squash sub2 &&
 	check_equal ''"$(last_commit_message)"'' "Merged changes from subproject using squash" &&
 	undo
 '
 
 test_expect_success 'merge new subproj history into subdir' '
-	git subtree merge --prefix=subdir FETCH_HEAD &&
+	git subtree merge --prefix="sub dir" FETCH_HEAD &&
 	git branch pre-split &&
 	check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline" &&
 	undo
@@ -208,53 +189,53 @@ test_expect_success 'Check that the <prefix> exists for a split' '
 '
 
 test_expect_success 'check if --message works for split+rejoin' '
-	spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+	spl1=''"$(git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
 	git branch spl1 "$spl1" &&
 	check_equal ''"$(last_commit_message)"'' "Split & rejoin" &&
 	undo
 '
 
 test_expect_success 'check split with --branch' '
-	spl1=$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
+	spl1=$(git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
 	undo &&
-	git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr1 &&
+	git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --branch splitbr1 &&
 	check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
 '
 
 test_expect_success 'check hash of split' '
-	spl1=$(git subtree split --prefix subdir) &&
-	git subtree split --prefix subdir --branch splitbr1test &&
+	spl1=$(git subtree split --prefix "sub dir") &&
+	git subtree split --prefix "sub dir" --branch splitbr1test &&
 	check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1" &&
 	new_hash=$(git rev-parse splitbr1test~2) &&
 	check_equal ''"$new_hash"'' "$subdir_hash"
 '
 
 test_expect_success 'check split with --branch for an existing branch' '
-	spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+	spl1=''"$(git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
 	undo &&
 	git branch splitbr2 sub1 &&
-	git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr2 &&
+	git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --branch splitbr2 &&
 	check_equal ''"$(git rev-parse splitbr2)"'' "$spl1"
 '
 
 test_expect_success 'check split with --branch for an incompatible branch' '
-	test_must_fail git subtree split --prefix subdir --onto FETCH_HEAD --branch subdir
+	test_must_fail git subtree split --prefix "sub dir" --onto FETCH_HEAD --branch subdir
 '
 
 test_expect_success 'check split+rejoin' '
-	spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+	spl1=''"$(git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
 	undo &&
-	git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --rejoin &&
-	check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
+	git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --rejoin &&
+	check_equal ''"$(last_commit_message)"'' "Split '"'"'sub dir/'"'"' into commit '"'"'"$spl1"'"'"'"
 '
 
 test_expect_success 'add main-sub8' '
-	create subdir/main-sub8 &&
+	create "sub dir/main-sub8" &&
 	git commit -m "main-sub8"
 '
 
 # To the subproject!
-cd ./subproj
+cd ./"sub proj"
 
 test_expect_success 'merge split into subproj' '
 	git fetch .. spl1 &&
@@ -271,22 +252,22 @@ test_expect_success 'add sub9' '
 cd ..
 
 test_expect_success 'split for sub8' '
-	split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"'' &&
+	split2=''"$(git subtree split --annotate='"'*'"' --prefix "sub dir/" --rejoin)"'' &&
 	git branch split2 "$split2"
 '
 
 test_expect_success 'add main-sub10' '
-	create subdir/main-sub10 &&
+	create "sub dir/main-sub10" &&
 	git commit -m "main-sub10"
 '
 
 test_expect_success 'split for sub10' '
-	spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
+	spl3=''"$(git subtree split --annotate='"'*'"' --prefix "sub dir" --rejoin)"'' &&
 	git branch spl3 "$spl3"
 '
 
 # To the subproject!
-cd ./subproj
+cd ./"sub proj"
 
 test_expect_success 'merge split into subproj' '
 	git fetch .. spl3 &&
@@ -295,42 +276,64 @@ test_expect_success 'merge split into subproj' '
 	git branch subproj-merge-spl3
 '
 
-chkm="main4 main6"
-chkms="main-sub10 main-sub5 main-sub7 main-sub8"
-chkms_sub=$(echo $chkms | multiline | sed 's,^,subdir/,' | fixnl)
-chks="sub1 sub2 sub3 sub9"
-chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
+chkm="main4
+main6"
+chkms="main-sub10
+main-sub5
+main-sub7
+main-sub8"
+chkms_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+$chkms
+TXT
+)
+chks="sub1
+sub2
+sub3
+sub9"
+chks_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+$chks
+TXT
+)
 
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
-	subfiles=''"$(git ls-files | fixnl)"'' &&
-	check_equal "$subfiles" "$chkms $chks"
+	subfiles="$(git ls-files)" &&
+	check_equal "$subfiles" "$chkms
+$chks"
 '
-
 test_expect_success 'make sure the subproj history *only* contains commits that affect the subdir' '
-	allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
-	check_equal "$allchanges" "$chkms $chks"
+	allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | sed "/^$/d")"'' &&
+	check_equal "$allchanges" "$chkms
+$chks"
 '
 
 # Back to mainline
 cd ..
 
 test_expect_success 'pull from subproj' '
-	git fetch ./subproj subproj-merge-spl3 &&
+	git fetch ./"sub proj" subproj-merge-spl3 &&
 	git branch subproj-merge-spl3 FETCH_HEAD &&
-	git subtree pull --prefix=subdir ./subproj subproj-merge-spl3
+	git subtree pull --prefix="sub dir" ./"sub proj" subproj-merge-spl3
 '
 
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
-	mainfiles=''"$(git ls-files | fixnl)"'' &&
-	check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
+	mainfiles=$(git ls-files) &&
+	check_equal "$mainfiles" "$chkm
+$chkms_sub
+$chks_sub"
 '
 
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
 	# main-sub?? and /subdir/main-sub?? both change, because those are the
 	# changes that were split into their own history.  And subdir/sub?? never
 	# change, since they were *only* changed in the subtree branch.
-	allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
-	check_equal "$allchanges" ''"$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"''
+	allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | sed "/^$/d")"'' &&
+	check_equal "$allchanges" ''"$(cat <<TXT | sort
+$chkms
+$chkm
+$chks
+$chkms_sub
+TXT
+)"''
 '
 
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
@@ -377,7 +380,7 @@ cd ../main
 test_expect_success 'add sub as subdir in main' '
 	git fetch ../sub master &&
 	git branch sub2 FETCH_HEAD &&
-	git subtree add --prefix subdir sub2
+	git subtree add --prefix "sub dir" sub2
 '
 
 cd ../sub
@@ -392,16 +395,16 @@ cd ../main
 test_expect_success 'merge from sub' '
 	git fetch ../sub master &&
 	git branch sub3 FETCH_HEAD &&
-	git subtree merge --prefix subdir sub3
+	git subtree merge --prefix "sub dir" sub3
 '
 
 test_expect_success 'add main-sub4' '
-	create subdir/main-sub4 &&
+	create "sub dir/main-sub4" &&
 	git commit -m "main-sub4"
 '
 
 test_expect_success 'split for main-sub4 without --onto' '
-	git subtree split --prefix subdir --branch mainsub4
+	git subtree split --prefix "sub dir" --branch mainsub4
 '
 
 # at this point, the new commit parent should be sub3 if it is not,
-- 
2.4.1-21
