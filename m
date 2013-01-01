From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 1/8] Use %B for Split Subject/Body
Date: Mon, 31 Dec 2012 21:57:28 -0600
Message-ID: <1357012655-24974-2-git-send-email-greened@obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
Cc: Techlive Zheng <techlivezheng@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 04:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpszu-0008Jl-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab3AAD6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:58:17 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48317 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751358Ab3AAD6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:58:16 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpt6b-0005na-Fj; Mon, 31 Dec 2012 22:05:34 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357012655-24974-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> Use %B to format
    the commit message and body to avoid an extra newline if a commit only has
    a subject line. Author: Techlive Zheng <techlivezheng@gmail.com> [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
           
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212402>

From: Techlive Zheng <techlivezheng@gmail.com>

Use %B to format the commit message and body to avoid an extra newline
if a commit only has a subject line.

Author:    Techlive Zheng <techlivezheng@gmail.com>

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |    5 +++
 contrib/subtree/t/t7900-subtree.sh |   73 ++++++++++++++++++++++--------------
 2 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..f2b6d4a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -296,7 +296,12 @@ copy_commit()
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
+	# Use %B rather than %s%n%n%b to handle the special case of a
+	# commit that only has a subject line.  We don't want to
+	# introduce a newline after the subject, causing generation of
+	# a new hash.
 	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
+#	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
 	(
 		read GIT_AUTHOR_NAME
 		read GIT_AUTHOR_EMAIL
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index bc2eeb0..93eeb09 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -76,6 +76,10 @@ test_expect_success 'add sub1' '
         git branch -m master subproj
 '
 
+# Save this hash for testing later.
+
+subdir_hash=`git rev-parse HEAD`
+
 # 3
 test_expect_success 'add sub2' '
         create sub2 &&
@@ -155,7 +159,6 @@ test_expect_success 'add main-sub5' '
         create subdir/main-sub5 &&
         git commit -m "main-sub5"
 '
-
 # 15
 test_expect_success 'add main6' '
         create main6 &&
@@ -235,7 +238,19 @@ test_expect_success 'check split with --branch' '
         check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
 '
 
-# 25
+#25
+test_expect_success 'check hash of split' '
+        spl1=$(git subtree split --prefix subdir) &&
+        undo &&
+        git subtree split --prefix subdir --branch splitbr1test &&
+        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
+        git checkout splitbr1test &&
+        new_hash=$(git rev-parse HEAD~2) &&
+        git checkout mainline &&
+        check_equal ''"$new_hash"'' "$subdir_hash"
+'
+
+# 26
 test_expect_success 'check split with --branch for an existing branch' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
@@ -244,13 +259,13 @@ test_expect_success 'check split with --branch for an existing branch' '
         check_equal ''"$(git rev-parse splitbr2)"'' "$spl1"
 '
 
-# 26
+# 27
 test_expect_success 'check split with --branch for an incompatible branch' '
         test_must_fail git subtree split --prefix subdir --onto FETCH_HEAD --branch subdir
 '
 
 
-# 27
+# 28
 test_expect_success 'check split+rejoin' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
@@ -258,7 +273,7 @@ test_expect_success 'check split+rejoin' '
         check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
 '
 
-# 28
+# 29
 test_expect_success 'add main-sub8' '
         create subdir/main-sub8 &&
         git commit -m "main-sub8"
@@ -267,14 +282,14 @@ test_expect_success 'add main-sub8' '
 # To the subproject!
 cd ./subproj
 
-# 29
+# 30
 test_expect_success 'merge split into subproj' '
         git fetch .. spl1 &&
         git branch spl1 FETCH_HEAD &&
         git merge FETCH_HEAD
 '
 
-# 30
+# 31
 test_expect_success 'add sub9' '
         create sub9 &&
         git commit -m "sub9"
@@ -283,19 +298,19 @@ test_expect_success 'add sub9' '
 # Back to mainline
 cd ..
 
-# 31
+# 32
 test_expect_success 'split for sub8' '
         split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
         git branch split2 "$split2"
 '
 
-# 32
+# 33
 test_expect_success 'add main-sub10' '
         create subdir/main-sub10 &&
         git commit -m "main-sub10"
 '
 
-# 33
+# 34
 test_expect_success 'split for sub10' '
         spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
         git branch spl3 "$spl3"
@@ -304,7 +319,7 @@ test_expect_success 'split for sub10' '
 # To the subproject!
 cd ./subproj
 
-# 34
+# 35
 test_expect_success 'merge split into subproj' '
         git fetch .. spl3 &&
         git branch spl3 FETCH_HEAD &&
@@ -318,13 +333,13 @@ chkms_sub=$(echo $chkms | multiline | sed 's,^,subdir/,' | fixnl)
 chks="sub1 sub2 sub3 sub9"
 chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
 
-# 35
+# 36
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
         subfiles=''"$(git ls-files | fixnl)"'' &&
         check_equal "$subfiles" "$chkms $chks"
 '
 
-# 36
+# 37
 test_expect_success 'make sure the subproj history *only* contains commits that affect the subdir' '
         allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
         check_equal "$allchanges" "$chkms $chks"
@@ -333,20 +348,20 @@ test_expect_success 'make sure the subproj history *only* contains commits that
 # Back to mainline
 cd ..
 
-# 37
+# 38
 test_expect_success 'pull from subproj' '
         git fetch ./subproj subproj-merge-spl3 &&
         git branch subproj-merge-spl3 FETCH_HEAD &&
         git subtree pull --prefix=subdir ./subproj subproj-merge-spl3
 '
 
-# 38
+# 39
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
         mainfiles=''"$(git ls-files | fixnl)"'' &&
         check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
 '
 
-# 39
+# 40
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
         # main-sub?? and /subdir/main-sub?? both change, because those are the
         # changes that were split into their own history.  And subdir/sub?? never
@@ -355,12 +370,12 @@ test_expect_success 'make sure each filename changed exactly once in the entire
         check_equal "$allchanges" ''"$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"''
 '
 
-# 40
+# 41
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
         check_equal ''"$(git log --pretty=format:'"'%s'"' HEAD^2 | grep -i split)"'' ""
 '
 
-# 41
+# 42
 test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
         # They are meaningless to subproj since one side of the merge refers to the mainline
         check_equal ''"$(git log --pretty=format:'"'%s%n%b'"' HEAD^2 | grep "git-subtree.*:")"'' ""
@@ -370,14 +385,14 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 mkdir test2
 cd test2
 
-# 42
+# 43
 test_expect_success 'init main' '
         test_create_repo main
 '
 
 cd main
 
-# 43
+# 44
 test_expect_success 'add main1' '
         create main1 &&
         git commit -m "main1"
@@ -385,14 +400,14 @@ test_expect_success 'add main1' '
 
 cd ..
 
-# 44
+# 45
 test_expect_success 'init sub' '
         test_create_repo sub
 '
 
 cd sub
 
-# 45
+# 46
 test_expect_success 'add sub2' '
         create sub2 &&
         git commit -m "sub2"
@@ -402,7 +417,7 @@ cd ../main
 
 # check if split can find proper base without --onto
 
-# 46
+# 47
 test_expect_success 'add sub as subdir in main' '
         git fetch ../sub master &&
         git branch sub2 FETCH_HEAD &&
@@ -411,7 +426,7 @@ test_expect_success 'add sub as subdir in main' '
 
 cd ../sub
 
-# 47
+# 48
 test_expect_success 'add sub3' '
         create sub3 &&
         git commit -m "sub3"
@@ -419,20 +434,20 @@ test_expect_success 'add sub3' '
 
 cd ../main
 
-# 48
+# 49
 test_expect_success 'merge from sub' '
         git fetch ../sub master &&
         git branch sub3 FETCH_HEAD &&
         git subtree merge --prefix subdir sub3
 '
 
-# 49
+# 50
 test_expect_success 'add main-sub4' '
         create subdir/main-sub4 &&
         git commit -m "main-sub4"
 '
 
-# 50
+# 51
 test_expect_success 'split for main-sub4 without --onto' '
         git subtree split --prefix subdir --branch mainsub4
 '
@@ -442,12 +457,12 @@ test_expect_success 'split for main-sub4 without --onto' '
 # have been sub3, but it was not, because its cache was not set to
 # itself)
 
-# 51
+# 52
 test_expect_success 'check that the commit parent is sub3' '
         check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
 '
 
-# 52
+# 53
 test_expect_success 'add main-sub5' '
         mkdir subdir2 &&
         create subdir2/main-sub5 &&
-- 
1.7.10.4
