From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 2/8] Add --unannotate
Date: Mon, 31 Dec 2012 21:57:29 -0600
Message-ID: <1357012655-24974-3-git-send-email-greened@obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
Cc: James Nylen <jnylen@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 04:58:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpszw-0008Jl-LC
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab3AAD6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:58:21 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48320 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751358Ab3AAD6U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:58:20 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpt6e-0005na-TH; Mon, 31 Dec 2012 22:05:38 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357012655-24974-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: James Nylen <jnylen@gmail.com> Teach git-subtree about
    --unannotate. This option strips a prefix from a commit message when doing
    a subtree split. Author: James Nylen <jnylen@gmail.com> [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                       
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212404>

From: James Nylen <jnylen@gmail.com>

Teach git-subtree about --unannotate.  This option strips a prefix
from a commit message when doing a subtree split.

Author:    James Nylen <jnylen@gmail.com>

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |   11 +++++-
 contrib/subtree/git-subtree.txt    |   15 ++++++++
 contrib/subtree/t/t7900-subtree.sh |   73 ++++++++++++++++++++----------------
 3 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index f2b6d4a..7ceb413 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -21,6 +21,7 @@ P,prefix=     the name of the subdir to split out
 m,message=    use the given message as the commit message for the merge commit
  options for 'split'
 annotate=     add a prefix to commit message of new commits
+unannotate=   remove a prefix from new commit messages (supports bash globbing)
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
@@ -43,6 +44,7 @@ onto=
 rejoin=
 ignore_joins=
 annotate=
+unannotate=
 squash=
 message=
 
@@ -80,6 +82,8 @@ while [ $# -gt 0 ]; do
 		-d) debug=1 ;;
 		--annotate) annotate="$1"; shift ;;
 		--no-annotate) annotate= ;;
+		--unannotate) unannotate="$1"; shift ;;
+		--no-unannotate) unannotate= ;;
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
@@ -315,8 +319,11 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(echo -n "$annotate"; cat ) |
-		git commit-tree "$2" $3  # reads the rest of stdin
+		(
+			read FIRST_LINE
+			echo "$annotate${FIRST_LINE#$unannotate}"
+			cat  # reads the rest of stdin
+		) | git commit-tree "$2" $3
 	) || die "Can't copy commit $1"
 }
 
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 0c44fda..ae420aa 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -198,6 +198,21 @@ OPTIONS FOR split
 	git subtree tries to make it work anyway, particularly
 	if you use --rejoin, but it may not always be effective.
 
+--unannotate=<annotation>::
+	This option is only valid for the split command.
+
+	When generating synthetic history, try to remove the prefix
+	<annotation> from each commit message (using bash's "strip
+	shortest match from beginning" command, which supports
+	globbing).  This makes sense if you format library commits
+	like "library: Change something or other" when you're working
+	in your project's repository, but you want to remove this
+	prefix when pushing back to the library's upstream repository.
+	(In this case --unannotate='*: ' would work well.)
+	
+	Like --annotate,  you need to use the same <annotation>
+	whenever you split, or you may run into problems.
+
 -b <branch>::
 --branch=<branch>::
 	This option is only valid for the split command.
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 93eeb09..9816da5 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -157,7 +157,7 @@ test_expect_success 'merge fetched subproj' '
 # 14
 test_expect_success 'add main-sub5' '
         create subdir/main-sub5 &&
-        git commit -m "main-sub5"
+        git commit -m "subproj: main-sub5"
 '
 # 15
 test_expect_success 'add main6' '
@@ -168,7 +168,7 @@ test_expect_success 'add main6' '
 # 16
 test_expect_success 'add main-sub7' '
         create subdir/main-sub7 &&
-        git commit -m "main-sub7"
+        git commit -m "subproj: main-sub7"
 '
 
 # 17
@@ -238,7 +238,7 @@ test_expect_success 'check split with --branch' '
         check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
 '
 
-#25
+# 25
 test_expect_success 'check hash of split' '
         spl1=$(git subtree split --prefix subdir) &&
         undo &&
@@ -251,6 +251,15 @@ test_expect_success 'check hash of split' '
 '
 
 # 26
+test_expect_success 'check --unannotate' '
+        spl1=$(git subtree split --unannotate='"subproj:"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
+        undo &&
+        git subtree split --unannotate='"subproj:"' --prefix subdir --onto FETCH_HEAD --branch splitunann &&
+        check_equal ''"$(git rev-parse splitunann)"'' "$spl1" &&
+        check_equal ''"$(git log splitunann | grep subproj)"'' ""
+'
+
+# 27
 test_expect_success 'check split with --branch for an existing branch' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
@@ -259,13 +268,13 @@ test_expect_success 'check split with --branch for an existing branch' '
         check_equal ''"$(git rev-parse splitbr2)"'' "$spl1"
 '
 
-# 27
+# 28
 test_expect_success 'check split with --branch for an incompatible branch' '
         test_must_fail git subtree split --prefix subdir --onto FETCH_HEAD --branch subdir
 '
 
 
-# 28
+# 29
 test_expect_success 'check split+rejoin' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
@@ -273,7 +282,7 @@ test_expect_success 'check split+rejoin' '
         check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
 '
 
-# 29
+# 30
 test_expect_success 'add main-sub8' '
         create subdir/main-sub8 &&
         git commit -m "main-sub8"
@@ -282,14 +291,14 @@ test_expect_success 'add main-sub8' '
 # To the subproject!
 cd ./subproj
 
-# 30
+# 31
 test_expect_success 'merge split into subproj' '
         git fetch .. spl1 &&
         git branch spl1 FETCH_HEAD &&
         git merge FETCH_HEAD
 '
 
-# 31
+# 32
 test_expect_success 'add sub9' '
         create sub9 &&
         git commit -m "sub9"
@@ -298,19 +307,19 @@ test_expect_success 'add sub9' '
 # Back to mainline
 cd ..
 
-# 32
+# 33
 test_expect_success 'split for sub8' '
         split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
         git branch split2 "$split2"
 '
 
-# 33
+# 34
 test_expect_success 'add main-sub10' '
         create subdir/main-sub10 &&
         git commit -m "main-sub10"
 '
 
-# 34
+# 35
 test_expect_success 'split for sub10' '
         spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
         git branch spl3 "$spl3"
@@ -319,7 +328,7 @@ test_expect_success 'split for sub10' '
 # To the subproject!
 cd ./subproj
 
-# 35
+# 36
 test_expect_success 'merge split into subproj' '
         git fetch .. spl3 &&
         git branch spl3 FETCH_HEAD &&
@@ -333,13 +342,13 @@ chkms_sub=$(echo $chkms | multiline | sed 's,^,subdir/,' | fixnl)
 chks="sub1 sub2 sub3 sub9"
 chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
 
-# 36
+# 37
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
         subfiles=''"$(git ls-files | fixnl)"'' &&
         check_equal "$subfiles" "$chkms $chks"
 '
 
-# 37
+# 38
 test_expect_success 'make sure the subproj history *only* contains commits that affect the subdir' '
         allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
         check_equal "$allchanges" "$chkms $chks"
@@ -348,20 +357,20 @@ test_expect_success 'make sure the subproj history *only* contains commits that
 # Back to mainline
 cd ..
 
-# 38
+# 39
 test_expect_success 'pull from subproj' '
         git fetch ./subproj subproj-merge-spl3 &&
         git branch subproj-merge-spl3 FETCH_HEAD &&
         git subtree pull --prefix=subdir ./subproj subproj-merge-spl3
 '
 
-# 39
+# 40
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
         mainfiles=''"$(git ls-files | fixnl)"'' &&
         check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
 '
 
-# 40
+# 41
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
         # main-sub?? and /subdir/main-sub?? both change, because those are the
         # changes that were split into their own history.  And subdir/sub?? never
@@ -370,12 +379,12 @@ test_expect_success 'make sure each filename changed exactly once in the entire
         check_equal "$allchanges" ''"$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"''
 '
 
-# 41
+# 42
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
         check_equal ''"$(git log --pretty=format:'"'%s'"' HEAD^2 | grep -i split)"'' ""
 '
 
-# 42
+# 43
 test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
         # They are meaningless to subproj since one side of the merge refers to the mainline
         check_equal ''"$(git log --pretty=format:'"'%s%n%b'"' HEAD^2 | grep "git-subtree.*:")"'' ""
@@ -385,14 +394,14 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 mkdir test2
 cd test2
 
-# 43
+# 44
 test_expect_success 'init main' '
         test_create_repo main
 '
 
 cd main
 
-# 44
+# 45
 test_expect_success 'add main1' '
         create main1 &&
         git commit -m "main1"
@@ -400,14 +409,14 @@ test_expect_success 'add main1' '
 
 cd ..
 
-# 45
+# 46
 test_expect_success 'init sub' '
         test_create_repo sub
 '
 
 cd sub
 
-# 46
+# 47
 test_expect_success 'add sub2' '
         create sub2 &&
         git commit -m "sub2"
@@ -417,7 +426,7 @@ cd ../main
 
 # check if split can find proper base without --onto
 
-# 47
+# 48
 test_expect_success 'add sub as subdir in main' '
         git fetch ../sub master &&
         git branch sub2 FETCH_HEAD &&
@@ -426,7 +435,7 @@ test_expect_success 'add sub as subdir in main' '
 
 cd ../sub
 
-# 48
+# 49
 test_expect_success 'add sub3' '
         create sub3 &&
         git commit -m "sub3"
@@ -434,20 +443,20 @@ test_expect_success 'add sub3' '
 
 cd ../main
 
-# 49
+# 50
 test_expect_success 'merge from sub' '
         git fetch ../sub master &&
         git branch sub3 FETCH_HEAD &&
         git subtree merge --prefix subdir sub3
 '
 
-# 50
+# 51
 test_expect_success 'add main-sub4' '
         create subdir/main-sub4 &&
         git commit -m "main-sub4"
 '
 
-# 51
+# 52
 test_expect_success 'split for main-sub4 without --onto' '
         git subtree split --prefix subdir --branch mainsub4
 '
@@ -457,19 +466,19 @@ test_expect_success 'split for main-sub4 without --onto' '
 # have been sub3, but it was not, because its cache was not set to
 # itself)
 
-# 52
+# 53
 test_expect_success 'check that the commit parent is sub3' '
         check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
 '
 
-# 53
+# 54
 test_expect_success 'add main-sub5' '
         mkdir subdir2 &&
         create subdir2/main-sub5 &&
         git commit -m "main-sub5"
 '
 
-# 53
+# 55
 test_expect_success 'split for main-sub5 without --onto' '
         # also test that we still can split out an entirely new subtree
         # if the parent of the first commit in the tree is not empty,
@@ -502,7 +511,7 @@ joincommits()
 	echo "$commit $all"
 }
 
-# 54
+# 56
 test_expect_success 'verify one file change per commit' '
         x= &&
         list=''"$(git log --pretty=format:'"'commit: %H'"' | joincommits)"'' &&
-- 
1.7.10.4
