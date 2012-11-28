From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 09/13] remote-testgit: exercise more features
Date: Wed, 28 Nov 2012 23:11:05 +0100
Message-ID: <1354140669-23533-10-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdprs-0003JU-N9
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813Ab2K1WL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809Ab2K1WLy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:54 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1z40Jl48xsLcMqT/Zn8UMLkpmoO2PHvBvK7lxNtyQKM=;
        b=lGhHBJG0ETmdkNddH2pijAy64Tb1aHF5I6X5CIVXA9lKEOXfFiRctkTe0CBsaKZ5uj
         sfPT83YVq2mn76RnIeWtJfsnMpzWEcgBDSEl1RlYpQSoAps7zRqFT54F83TcY24q6DTR
         9pITK1Zui2F9sk0C91JjKiUvaG2cA/z5Q2sErKxtd6OJp+53NXstkzML89ilhZwK3jUZ
         hMxrddXv7cQlTXxMbDQEFonJ4NWylgOHMqNa9JOQ5YMtCJhcfc06WAT/3V0TcQlzNt2c
         7HBO4axM/FFJcerXTCYvtv9JDbhKRFfvMFXjvIlg9r4U4eqybRU/QmhSd5CVFoZTbA3r
         v3Iw==
Received: by 10.204.149.204 with SMTP id u12mr5551522bkv.108.1354140713912;
        Wed, 28 Nov 2012 14:11:53 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id f24sm13784949bkv.7.2012.11.28.14.11.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:53 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210796>

Unfortunately a lot of these tests fail.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote-testgit        | 38 +++++++++++++++++++++++-----------
 t/t5801-remote-helpers.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 5117ab5..efda74b 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -6,17 +6,25 @@ url=$2
 
 dir="$GIT_DIR/testgit/$alias"
 prefix="refs/testgit/$alias"
-refspec="refs/heads/*:${prefix}/heads/*"
 
-gitmarks="$dir/git.marks"
-testgitmarks="$dir/testgit.marks"
+default_refspec="refs/heads/*:${prefix}/heads/*"
+
+refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
+
+test -z "$refspec" && prefix="refs"
 
 export GIT_DIR="$url/.git"
 
 mkdir -p "$dir"
 
-test -e "$gitmarks" || > "$gitmarks"
-test -e "$testgitmarks" || > "$testgitmarks"
+if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"
+then
+	gitmarks="$dir/git.marks"
+	testgitmarks="$dir/testgit.marks"
+	test -e "$gitmarks" || >"$gitmarks"
+	test -e "$testgitmarks" || >"$testgitmarks"
+	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
+fi
 
 while read line
 do
@@ -24,9 +32,12 @@ do
 	capabilities)
 		echo 'import'
 		echo 'export'
-		echo "refspec $refspec"
-		echo "*import-marks $gitmarks"
-		echo "*export-marks $gitmarks"
+		test -n "$refspec" && echo "refspec $refspec"
+		if test -n "$gitmarks"
+		then
+			echo "*import-marks $gitmarks"
+			echo "*export-marks $gitmarks"
+		fi
 		echo
 		;;
 	list)
@@ -45,13 +56,16 @@ do
 			test "${line%% *}" != "import" && break
 		done
 
-		echo "feature import-marks=$gitmarks"
-		echo "feature export-marks=$gitmarks"
-		git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs |
+		if test -n "$gitmarks"
+		then
+			echo "feature import-marks=$gitmarks"
+			echo "feature export-marks=$gitmarks"
+		fi
+		git fast-export --use-done-feature "${testgitmarks_args[@]}" $refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		;;
 	export)
-		git fast-import --{import,export}-marks="$testgitmarks" --quiet
+		git fast-import "${testgitmarks_args[@]}" --quiet
 		echo
 		;;
 	'')
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index bc0b5f7..12ae256 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -110,4 +110,56 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'cloning without refspec' '
+	GIT_REMOTE_TESTGIT_REFSPEC="" \
+	git clone "testgit::${PWD}/server" local2 &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_success 'pulling without refspecs' '
+	(cd local2 &&
+	git reset --hard &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without refspecs' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m ten &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_success 'pulling with straight refspec' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing with straight refspec' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m eleven &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_success 'pulling without marks' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without marks' '
+	test_when_finished "(cd local2 && git reset --hard origin)" &&
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m twelve &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
 test_done
-- 
1.8.0.1
