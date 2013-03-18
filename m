From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] push test: simplify check of push result
Date: Mon, 18 Mar 2013 16:13:41 -0700
Message-ID: <20130318231340.GF5062@elie.Belkin>
References: <20130318220224.3b23a381@hoelz.ro>
 <20130318231043.GD5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Tue Mar 19 00:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHjFt-000736-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 00:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab3CRXNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 19:13:47 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:57292 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab3CRXNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 19:13:46 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so6805746pbc.25
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 16:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=A9MUVRkr7SIwolsJRVPtBhnMbXqm6cL2z/Ar6azsBFk=;
        b=AEt/k6eoZl+LrB0YSwvc8md7w1gFMGCK0ic+LYJTYK9UPOc6C5sPwvPewAc7KXgWuG
         y0kyOs+NHqM58rI6E2iMIZ8a9pNbSsULdinBAdmN9inf8ebME8LpaZ6VWMOJgIuLtYdz
         NTXjzWHPX0OtgRlg69nRHVAq76dvGMKiz3NWl2tDEPbkliaSPNajbaPX9mW0HDi2z0Cq
         ctQVjBG7kyqYtdPWaoKDc8Zk9bdtqV+fFu/i6kzOyze+XQZl28GYJarWivlBxt+k2HPi
         33JTj+wSJoOSEhbYNRHvaiU84aRRyHAWHGH6tARWewmP7w58ZajLc3NlMOyh27XO+wbK
         mU6w==
X-Received: by 10.68.29.98 with SMTP id j2mr35934443pbh.216.1363648425839;
        Mon, 18 Mar 2013 16:13:45 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id hp1sm9873735pac.3.2013.03.18.16.13.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 16:13:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130318231043.GD5062@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218463>

This test checks each ref with code like the following:

	r=$(git show-ref -s --verify refs/$ref) &&
	test "z$r" = "z$the_first_commit"

Afterward it counts refs:

	test 1 = $(git for-each-ref refs/remotes/origin | wc -l)

Simpler to test the number and values of relevant refs in for-each-ref
output at the same time using test_cmp.  This makes the test more
readable and provides more helpful "./t5516-push-push.sh -v" output
when the test fails.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5516-fetch-push.sh | 114 ++++++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 63 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 5b89c111..2f1255d4 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -30,11 +30,10 @@ mk_test () {
 		cd testrepo &&
 		for ref in "$@"
 		do
-			r=$(git show-ref -s --verify refs/$ref) &&
-			test "z$r" = "z$the_first_commit" || {
-				echo "Oops, refs/$ref is wrong"
-				exit 1
-			}
+			echo "$the_first_commit" >expect &&
+			git show-ref -s --verify refs/$ref >actual &&
+			test_cmp expect actual ||
+			exit
 		done &&
 		git fsck --full
 	)
@@ -82,15 +81,13 @@ mk_child() {
 check_push_result () {
 	(
 		cd testrepo &&
-		it="$1" &&
-		shift
+		echo "$1" >expect &&
+		shift &&
 		for ref in "$@"
 		do
-			r=$(git show-ref -s --verify refs/$ref) &&
-			test "z$r" = "z$it" || {
-				echo "Oops, refs/$ref is wrong"
-				exit 1
-			}
+			git show-ref -s --verify refs/$ref >actual &&
+			test_cmp expect actual ||
+			exit
 		done &&
 		git fsck --full
 	)
@@ -118,10 +115,9 @@ test_expect_success 'fetch without wildcard' '
 		cd testrepo &&
 		git fetch .. refs/heads/master:refs/remotes/origin/master &&
 
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -133,10 +129,9 @@ test_expect_success 'fetch with wildcard' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -150,10 +145,9 @@ test_expect_success 'fetch with insteadOf' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -167,10 +161,9 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -180,10 +173,9 @@ test_expect_success 'push without wildcard' '
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -193,10 +185,9 @@ test_expect_success 'push with wildcard' '
 	git push testrepo "refs/heads/*:refs/remotes/origin/*" &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -207,10 +198,9 @@ test_expect_success 'push with insteadOf' '
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -221,10 +211,9 @@ test_expect_success 'push with pushInsteadOf' '
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -237,10 +226,9 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 	git push r refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -827,9 +815,9 @@ test_expect_success 'fetch with branches' '
 	(
 		cd testrepo &&
 		git fetch branch1 &&
-		r=$(git show-ref -s --verify refs/heads/branch1) &&
-		test "z$r" = "z$the_commit" &&
-		test 1 = $(git for-each-ref refs/heads | wc -l)
+		echo "$the_commit commit	refs/heads/branch1" >expect &&
+		git for-each-ref refs/heads >actual &&
+		test_cmp expect actual
 	) &&
 	git checkout master
 '
@@ -840,9 +828,9 @@ test_expect_success 'fetch with branches containing #' '
 	(
 		cd testrepo &&
 		git fetch branch2 &&
-		r=$(git show-ref -s --verify refs/heads/branch2) &&
-		test "z$r" = "z$the_first_commit" &&
-		test 1 = $(git for-each-ref refs/heads | wc -l)
+		echo "$the_first_commit commit	refs/heads/branch2" >expect &&
+		git for-each-ref refs/heads >actual &&
+		test_cmp expect actual
 	) &&
 	git checkout master
 '
@@ -854,9 +842,9 @@ test_expect_success 'push with branches' '
 	git push branch1 &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/heads/master) &&
-		test "z$r" = "z$the_first_commit" &&
-		test 1 = $(git for-each-ref refs/heads | wc -l)
+		echo "$the_first_commit commit	refs/heads/master" >expect &&
+		git for-each-ref refs/heads >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -866,9 +854,9 @@ test_expect_success 'push with branches containing #' '
 	git push branch2 &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/heads/branch3) &&
-		test "z$r" = "z$the_first_commit" &&
-		test 1 = $(git for-each-ref refs/heads | wc -l)
+		echo "$the_first_commit commit	refs/heads/branch3" >expect &&
+		git for-each-ref refs/heads >actual &&
+		test_cmp expect actual
 	) &&
 	git checkout master
 '
@@ -951,9 +939,9 @@ test_expect_success 'push --porcelain' '
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
-		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
-		test "z$r" = "z$the_commit" &&
-		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		git for-each-ref refs/remotes/origin >actual &&
+		test_cmp expect actual
 	) &&
 	test_cmp .git/foo .git/bar
 '
-- 
1.8.2.rc3
