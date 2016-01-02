From: David Greene <greened@obbligato.org>
Subject: [PATCH] contrib/subtree: Remove --annotate
Date: Sat,  2 Jan 2016 14:36:24 -0600
Message-ID: <1451766984-4648-2-git-send-email-greened@obbligato.org>
References: <1451766984-4648-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com, gitster@pobox.com,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 02 21:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFSuu-00026L-Nb
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jan 2016 21:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbcABUgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2016 15:36:44 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:43527 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751735AbcABUgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2016 15:36:44 -0500
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aFSva-0002zw-R2; Sat, 02 Jan 2016 14:37:30 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1451766984-4648-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283269>

From: "David A. Greene" <greened@obbligato.org>

Remove --annotate.  This obviates the need for an --unannotate
command, which is both an obvious addition and difficult to define
due to the numerous ways one might want to specify how to edit
commit messages.  git has other tools more suited to rewriting
commit messages and it's easy enough to use them after a subtree
split.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |  6 +----
 contrib/subtree/t/t7900-subtree.sh | 50 +++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index edf36f8..699c954 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -21,7 +21,6 @@ d             show debug messages
 P,prefix=     the name of the subdir to split out
 m,message=    use the given message as the commit message for the merge commit
  options for 'split'
-annotate=     add a prefix to commit message of new commits
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
@@ -43,7 +42,6 @@ command=
 onto=
 rejoin=
 ignore_joins=
-annotate=
 squash=
 message=
 prefix=
@@ -87,8 +85,6 @@ while [ $# -gt 0 ]; do
 	case "$opt" in
 		-q) quiet=1 ;;
 		-d) debug=1 ;;
-		--annotate) annotate="$1"; shift ;;
-		--no-annotate) annotate= ;;
 		-b) branch="$1"; shift ;;
 		-P) prefix="${1%/}"; shift ;;
 		-m) message="$1"; shift ;;
@@ -319,7 +315,7 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(printf "%s" "$annotate"; cat ) |
+		(echo -n ""; cat ) |
 		git commit-tree "$2" $3  # reads the rest of stdin
 	) || die "Can't copy commit $1"
 }
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 751aee3..521c401 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -340,8 +340,8 @@ test_expect_success 'split sub dir/ with --rejoin' '
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
-		git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
+		split_hash=$(git subtree split --prefix="sub dir") &&
+		git subtree split --prefix="sub dir" --rejoin &&
 		check_equal "$(last_commit_message)" "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
 	)
  '
@@ -365,7 +365,7 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		git subtree split --prefix="sub dir" --message="Split & rejoin" --annotate="*" --rejoin &&
+		git subtree split --prefix="sub dir" --message="Split & rejoin" --rejoin &&
 		check_equal "$(last_commit_message)" "Split & rejoin"
 	)
 '
@@ -389,8 +389,8 @@ test_expect_success 'split "sub dir"/ with --branch' '
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
+		split_hash=$(git subtree split --prefix="sub dir") &&
+		git subtree split --prefix="sub dir" --branch subproj-br &&
 		check_equal "$(git rev-parse subproj-br)" "$split_hash"
 	)
 '
@@ -414,8 +414,8 @@ test_expect_success 'check hash of split' '
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
+		split_hash=$(git subtree split --prefix="sub dir") &&
+		git subtree split --prefix="sub dir" --branch subproj-br &&
 		check_equal "$(git rev-parse subproj-br)" "$split_hash" &&
 		# Check hash of split
 		new_hash=$(git rev-parse subproj-br^2) &&
@@ -500,7 +500,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub3 &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
@@ -512,12 +512,12 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 	test_create_commit "$subtree_test_count/sub proj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/sub proj" &&
@@ -566,7 +566,7 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub3 &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
@@ -578,12 +578,12 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 	test_create_commit "$subtree_test_count/sub proj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/sub proj" &&
@@ -631,7 +631,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub3 &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
@@ -643,12 +643,12 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 	test_create_commit "$subtree_test_count/sub proj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/sub proj" &&
@@ -704,7 +704,7 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub3 &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
@@ -716,12 +716,12 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	test_create_commit "$subtree_test_count/sub proj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/sub proj" &&
@@ -785,7 +785,7 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub3 &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
@@ -797,12 +797,12 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 	test_create_commit "$subtree_test_count/sub proj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/sub proj" &&
@@ -835,7 +835,7 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub3 &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
@@ -847,12 +847,12 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 	test_create_commit "$subtree_test_count/sub proj" sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
+		git subtree split --prefix="sub dir" --branch subproj-br --rejoin
 	) &&
 	(
 		cd "$subtree_test_count/sub proj" &&
-- 
2.6.1
