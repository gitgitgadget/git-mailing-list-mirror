From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] t5516 (fetch-push): drop implicit arguments from helper functions
Date: Thu, 28 Mar 2013 18:56:39 +0530
Message-ID: <1364477202-5742-4-git-send-email-artagnon@gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCqD-00039X-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab3C1NZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:25:38 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:61871 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab3C1NZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:25:36 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so3408437dal.40
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=H6Zq76TBQD2bQwiTiHQdzd4IsfLEQGxkX0oa3WlstZ4=;
        b=FOxVYJT64yqVKsp0JtlGwbXHFVumYbuO7jk1nV+zxCkdq8RfeOCtqWBwoL/Nf6TTdk
         DiP5X/mN022JHl54kqiKhxM4FvbysOPoGHZJQMSIJs2x3zzfUAVofDgc+x9aLPjxIEk/
         IixVha5MhdEER0+VprycCGkE5rOmt8+DB7U1gueokoWcB9e9lQqQK3G+mcLndnThOe1j
         XtG7GDvKIBMxVbKYZ/fvu8ekBDcaxe3/af22BdVOIxGAhQ0laDDPfwlkDgG/m6Bm6ijE
         eaiZ1eCTxC7ukU0hgAVDet0MQf4JSAgEGbp0HqL4yZZdczFquUw2gleJs51RnTWkiUIX
         6NNg==
X-Received: by 10.68.197.193 with SMTP id iw1mr35526560pbc.86.1364477135824;
        Thu, 28 Mar 2013 06:25:35 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id tm1sm25586603pbc.11.2013.03.28.06.25.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:25:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g3797f84
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219390>

From: Jeff King <peff@peff.net>

Many of the tests in t5516 look like:

  mk_empty &&
  git push testrepo ... &&
  check_push_result $commit heads/master

It's reasonably easy to see what is being tested, with the
exception that "testrepo" is a magic global name (it is
implicitly used in the helpers, but we have to name it
explicitly when calling git directly). Let's make it
explicit when call the helpers, too. This is slightly more
typing, but makes the test snippets read more naturally.

It also makes it easy for future tests to use an alternate
or multiple repositories, without a proliferation of helper
functions.

[rr: fixed sloppy quoting]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5516-fetch-push.sh | 276 ++++++++++++++++++++++++++------------------------
 1 file changed, 142 insertions(+), 134 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 38f8fc0..94e0189 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -18,10 +18,11 @@ This test checks the following functionality:
 D=`pwd`
 
 mk_empty () {
-	rm -fr testrepo &&
-	mkdir testrepo &&
+	repo_name="$1"
+	rm -fr "$repo_name" &&
+	mkdir "$repo_name" &&
 	(
-		cd testrepo &&
+		cd "$repo_name" &&
 		git init &&
 		git config receive.denyCurrentBranch warn &&
 		mv .git/hooks .git/hooks-disabled
@@ -29,16 +30,19 @@ mk_empty () {
 }
 
 mk_test () {
-	mk_empty &&
+	repo_name="$1"
+	shift
+
+	mk_empty "$repo_name" &&
 	(
 		for ref in "$@"
 		do
-			git push testrepo $the_first_commit:refs/$ref || {
+			git push "$repo_name" $the_first_commit:refs/$ref || {
 				echo "Oops, push refs/$ref failure"
 				exit 1
 			}
 		done &&
-		cd testrepo &&
+		cd "$repo_name" &&
 		for ref in "$@"
 		do
 			r=$(git show-ref -s --verify refs/$ref) &&
@@ -52,9 +56,10 @@ mk_test () {
 }
 
 mk_test_with_hooks() {
+	repo_name=$1
 	mk_test "$@" &&
 	(
-		cd testrepo &&
+		cd "$repo_name" &&
 		mkdir .git/hooks &&
 		cd .git/hooks &&
 
@@ -86,13 +91,16 @@ mk_test_with_hooks() {
 }
 
 mk_child() {
-	rm -rf "$1" &&
-	git clone testrepo "$1"
+	rm -rf "$2" &&
+	git clone "$1" "$2"
 }
 
 check_push_result () {
+	repo_name="$1"
+	shift
+
 	(
-		cd testrepo &&
+		cd "$repo_name" &&
 		it="$1" &&
 		shift
 		for ref in "$@"
@@ -124,7 +132,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'fetch without wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		cd testrepo &&
 		git fetch .. refs/heads/master:refs/remotes/origin/master &&
@@ -137,7 +145,7 @@ test_expect_success 'fetch without wildcard' '
 '
 
 test_expect_success 'fetch with wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		cd testrepo &&
 		git config remote.up.url .. &&
@@ -152,7 +160,7 @@ test_expect_success 'fetch with wildcard' '
 '
 
 test_expect_success 'fetch with insteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
@@ -169,7 +177,7 @@ test_expect_success 'fetch with insteadOf' '
 '
 
 test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
@@ -186,7 +194,7 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 '
 
 test_expect_success 'push without wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
@@ -199,7 +207,7 @@ test_expect_success 'push without wildcard' '
 '
 
 test_expect_success 'push with wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 
 	git push testrepo "refs/heads/*:refs/remotes/origin/*" &&
 	(
@@ -212,7 +220,7 @@ test_expect_success 'push with wildcard' '
 '
 
 test_expect_success 'push with insteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	git config "url.$TRASH.insteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
@@ -226,7 +234,7 @@ test_expect_success 'push with insteadOf' '
 '
 
 test_expect_success 'push with pushInsteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	git config "url.$TRASH.pushInsteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
@@ -240,7 +248,7 @@ test_expect_success 'push with pushInsteadOf' '
 '
 
 test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	git config "url.trash2/.pushInsteadOf" trash/ &&
 	git config remote.r.url trash/wrong &&
@@ -257,242 +265,242 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 
 test_expect_success 'push with matching heads' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git push testrepo &&
-	check_push_result $the_commit heads/master
+	check_push_result testrepo $the_commit heads/master
 
 '
 
 test_expect_success 'push with matching heads on the command line' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git push testrepo : &&
-	check_push_result $the_commit heads/master
+	check_push_result testrepo $the_commit heads/master
 
 '
 
 test_expect_success 'failed (non-fast-forward) push with matching heads' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	test_must_fail git push testrepo &&
-	check_push_result $the_commit heads/master &&
+	check_push_result testrepo $the_commit heads/master &&
 	git reset --hard $the_commit
 
 '
 
 test_expect_success 'push --force with matching heads' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push --force testrepo &&
-	! check_push_result $the_commit heads/master &&
+	! check_push_result testrepo $the_commit heads/master &&
 	git reset --hard $the_commit
 
 '
 
 test_expect_success 'push with matching heads and forced update' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push testrepo +: &&
-	! check_push_result $the_commit heads/master &&
+	! check_push_result testrepo $the_commit heads/master &&
 	git reset --hard $the_commit
 
 '
 
 test_expect_success 'push with no ambiguity (1)' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git push testrepo master:master &&
-	check_push_result $the_commit heads/master
+	check_push_result testrepo $the_commit heads/master
 
 '
 
 test_expect_success 'push with no ambiguity (2)' '
 
-	mk_test remotes/origin/master &&
+	mk_test testrepo remotes/origin/master &&
 	git push testrepo master:origin/master &&
-	check_push_result $the_commit remotes/origin/master
+	check_push_result testrepo $the_commit remotes/origin/master
 
 '
 
 test_expect_success 'push with colon-less refspec, no ambiguity' '
 
-	mk_test heads/master heads/t/master &&
+	mk_test testrepo heads/master heads/t/master &&
 	git branch -f t/master master &&
 	git push testrepo master &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_first_commit heads/t/master
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_first_commit heads/t/master
 
 '
 
 test_expect_success 'push with weak ambiguity (1)' '
 
-	mk_test heads/master remotes/origin/master &&
+	mk_test testrepo heads/master remotes/origin/master &&
 	git push testrepo master:master &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_first_commit remotes/origin/master
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_first_commit remotes/origin/master
 
 '
 
 test_expect_success 'push with weak ambiguity (2)' '
 
-	mk_test heads/master remotes/origin/master remotes/another/master &&
+	mk_test testrepo heads/master remotes/origin/master remotes/another/master &&
 	git push testrepo master:master &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_first_commit remotes/origin/master remotes/another/master
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_first_commit remotes/origin/master remotes/another/master
 
 '
 
 test_expect_success 'push with ambiguity' '
 
-	mk_test heads/frotz tags/frotz &&
+	mk_test testrepo heads/frotz tags/frotz &&
 	if git push testrepo master:frotz
 	then
 		echo "Oops, should have failed"
 		false
 	else
-		check_push_result $the_first_commit heads/frotz tags/frotz
+		check_push_result testrepo $the_first_commit heads/frotz tags/frotz
 	fi
 
 '
 
 test_expect_success 'push with colon-less refspec (1)' '
 
-	mk_test heads/frotz tags/frotz &&
+	mk_test testrepo heads/frotz tags/frotz &&
 	git branch -f frotz master &&
 	git push testrepo frotz &&
-	check_push_result $the_commit heads/frotz &&
-	check_push_result $the_first_commit tags/frotz
+	check_push_result testrepo $the_commit heads/frotz &&
+	check_push_result testrepo $the_first_commit tags/frotz
 
 '
 
 test_expect_success 'push with colon-less refspec (2)' '
 
-	mk_test heads/frotz tags/frotz &&
+	mk_test testrepo heads/frotz tags/frotz &&
 	if git show-ref --verify -q refs/heads/frotz
 	then
 		git branch -D frotz
 	fi &&
 	git tag -f frotz &&
 	git push -f testrepo frotz &&
-	check_push_result $the_commit tags/frotz &&
-	check_push_result $the_first_commit heads/frotz
+	check_push_result testrepo $the_commit tags/frotz &&
+	check_push_result testrepo $the_first_commit heads/frotz
 
 '
 
 test_expect_success 'push with colon-less refspec (3)' '
 
-	mk_test &&
+	mk_test testrepo &&
 	if git show-ref --verify -q refs/tags/frotz
 	then
 		git tag -d frotz
 	fi &&
 	git branch -f frotz master &&
 	git push testrepo frotz &&
-	check_push_result $the_commit heads/frotz &&
+	check_push_result testrepo $the_commit heads/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
 '
 
 test_expect_success 'push with colon-less refspec (4)' '
 
-	mk_test &&
+	mk_test testrepo &&
 	if git show-ref --verify -q refs/heads/frotz
 	then
 		git branch -D frotz
 	fi &&
 	git tag -f frotz &&
 	git push testrepo frotz &&
-	check_push_result $the_commit tags/frotz &&
+	check_push_result testrepo $the_commit tags/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
 
 '
 
 test_expect_success 'push head with non-existent, incomplete dest' '
 
-	mk_test &&
+	mk_test testrepo &&
 	git push testrepo master:branch &&
-	check_push_result $the_commit heads/branch
+	check_push_result testrepo $the_commit heads/branch
 
 '
 
 test_expect_success 'push tag with non-existent, incomplete dest' '
 
-	mk_test &&
+	mk_test testrepo &&
 	git tag -f v1.0 &&
 	git push testrepo v1.0:tag &&
-	check_push_result $the_commit tags/tag
+	check_push_result testrepo $the_commit tags/tag
 
 '
 
 test_expect_success 'push sha1 with non-existent, incomplete dest' '
 
-	mk_test &&
+	mk_test testrepo &&
 	test_must_fail git push testrepo `git rev-parse master`:foo
 
 '
 
 test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
-	mk_test &&
+	mk_test testrepo &&
 	test_must_fail git push testrepo master^:branch
 
 '
 
 test_expect_success 'push with HEAD' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git checkout master &&
 	git push testrepo HEAD &&
-	check_push_result $the_commit heads/master
+	check_push_result testrepo $the_commit heads/master
 
 '
 
 test_expect_success 'push with HEAD nonexisting at remote' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git checkout -b local master &&
 	git push testrepo HEAD &&
-	check_push_result $the_commit heads/local
+	check_push_result testrepo $the_commit heads/local
 '
 
 test_expect_success 'push with +HEAD' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git checkout master &&
 	git branch -D local &&
 	git checkout -b local &&
 	git push testrepo master local &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_commit heads/local &&
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_commit heads/local &&
 
 	# Without force rewinding should fail
 	git reset --hard HEAD^ &&
 	test_must_fail git push testrepo HEAD &&
-	check_push_result $the_commit heads/local &&
+	check_push_result testrepo $the_commit heads/local &&
 
 	# With force rewinding should succeed
 	git push testrepo +HEAD &&
-	check_push_result $the_first_commit heads/local
+	check_push_result testrepo $the_first_commit heads/local
 
 '
 
 test_expect_success 'push HEAD with non-existent, incomplete dest' '
 
-	mk_test &&
+	mk_test testrepo &&
 	git checkout master &&
 	git push testrepo HEAD:branch &&
-	check_push_result $the_commit heads/branch
+	check_push_result testrepo $the_commit heads/branch
 
 '
 
 test_expect_success 'push with config remote.*.push = HEAD' '
 
-	mk_test heads/local &&
+	mk_test testrepo heads/local &&
 	git checkout master &&
 	git branch -f local $the_commit &&
 	(
@@ -504,8 +512,8 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	git config remote.there.push HEAD &&
 	git config branch.master.remote there &&
 	git push &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_first_commit heads/local
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_first_commit heads/local
 '
 
 # clean up the cruft left with the previous one
@@ -514,12 +522,12 @@ git config --remove-section branch.master
 
 test_expect_success 'push with config remote.*.pushurl' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git checkout master &&
 	git config remote.there.url test2repo &&
 	git config remote.there.pushurl testrepo &&
 	git push there &&
-	check_push_result $the_commit heads/master
+	check_push_result testrepo $the_commit heads/master
 '
 
 # clean up the cruft left with the previous one
@@ -527,19 +535,19 @@ git config --remove-section remote.there
 
 test_expect_success 'push with dry-run' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		old_commit=$(git show-ref -s --verify refs/heads/master)
 	) &&
 	git push --dry-run testrepo &&
-	check_push_result $old_commit heads/master
+	check_push_result testrepo $old_commit heads/master
 '
 
 test_expect_success 'push updates local refs' '
 
-	mk_test heads/master &&
-	mk_child child &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child &&
 	(
 		cd child &&
 		git pull .. master &&
@@ -552,9 +560,9 @@ test_expect_success 'push updates local refs' '
 
 test_expect_success 'push updates up-to-date local refs' '
 
-	mk_test heads/master &&
-	mk_child child1 &&
-	mk_child child2 &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child1 &&
+	mk_child testrepo child2 &&
 	(cd child1 && git pull .. master && git push) &&
 	(
 		cd child2 &&
@@ -568,8 +576,8 @@ test_expect_success 'push updates up-to-date local refs' '
 
 test_expect_success 'push preserves up-to-date packed refs' '
 
-	mk_test heads/master &&
-	mk_child child &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child &&
 	(
 		cd child &&
 		git push &&
@@ -580,8 +588,8 @@ test_expect_success 'push preserves up-to-date packed refs' '
 
 test_expect_success 'push does not update local refs on failure' '
 
-	mk_test heads/master &&
-	mk_child child &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child &&
 	mkdir testrepo/.git/hooks &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
@@ -597,7 +605,7 @@ test_expect_success 'push does not update local refs on failure' '
 
 test_expect_success 'allow deleting an invalid remote ref' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
@@ -605,7 +613,7 @@ test_expect_success 'allow deleting an invalid remote ref' '
 '
 
 test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master heads/next &&
+	mk_test_with_hooks testrepo heads/master heads/next &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
@@ -641,7 +649,7 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 '
 
 test_expect_success 'deleting dangling ref triggers hooks with correct args' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
 	(
@@ -670,7 +678,7 @@ test_expect_success 'deleting dangling ref triggers hooks with correct args' '
 '
 
 test_expect_success 'deletion of a non-existent ref is not fed to post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	git push testrepo master :refs/heads/nonexistent &&
@@ -702,7 +710,7 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 '
 
 test_expect_success 'deletion of a non-existent ref alone does trigger post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	git push testrepo :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
@@ -722,7 +730,7 @@ test_expect_success 'deletion of a non-existent ref alone does trigger post-rece
 '
 
 test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks with correct input' '
-	mk_test_with_hooks heads/master heads/next heads/pu &&
+	mk_test_with_hooks testrepo heads/master heads/next heads/pu &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
@@ -768,14 +776,14 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 '
 
 test_expect_success 'allow deleting a ref using --delete' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(cd testrepo && git config receive.denyDeleteCurrent warn) &&
 	git push testrepo --delete master &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
 '
 
 test_expect_success 'allow deleting a tag using --delete' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git tag -a -m dummy_message deltag heads/master &&
 	git push testrepo --tags &&
 	(cd testrepo && git rev-parse --verify -q refs/tags/deltag) &&
@@ -784,17 +792,17 @@ test_expect_success 'allow deleting a tag using --delete' '
 '
 
 test_expect_success 'push --delete without args aborts' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	test_must_fail git push testrepo --delete
 '
 
 test_expect_success 'push --delete refuses src:dest refspecs' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	test_must_fail git push testrepo --delete master:foo
 '
 
 test_expect_success 'warn on push to HEAD of non-bare repository' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -805,7 +813,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -815,7 +823,7 @@ test_expect_success 'deny push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -827,7 +835,7 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -838,7 +846,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 '
 
 test_expect_success 'fetch with branches' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
 	echo ".." > testrepo/.git/branches/branch1 &&
@@ -853,7 +861,7 @@ test_expect_success 'fetch with branches' '
 '
 
 test_expect_success 'fetch with branches containing #' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
@@ -866,7 +874,7 @@ test_expect_success 'fetch with branches containing #' '
 '
 
 test_expect_success 'push with branches' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git checkout second &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
@@ -879,7 +887,7 @@ test_expect_success 'push with branches' '
 '
 
 test_expect_success 'push with branches containing #' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
 	git push branch2 &&
 	(
@@ -892,9 +900,9 @@ test_expect_success 'push with branches containing #' '
 '
 
 test_expect_success 'push into aliased refs (consistent)' '
-	mk_test heads/master &&
-	mk_child child1 &&
-	mk_child child2 &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child1 &&
+	mk_child testrepo child2 &&
 	(
 		cd child1 &&
 		git branch foo &&
@@ -914,9 +922,9 @@ test_expect_success 'push into aliased refs (consistent)' '
 '
 
 test_expect_success 'push into aliased refs (inconsistent)' '
-	mk_test heads/master &&
-	mk_child child1 &&
-	mk_child child2 &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child1 &&
+	mk_child testrepo child2 &&
 	(
 		cd child1 &&
 		git branch foo &&
@@ -941,9 +949,9 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 '
 
 test_expect_success 'push requires --force to update lightweight tag' '
-	mk_test heads/master &&
-	mk_child child1 &&
-	mk_child child2 &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child1 &&
+	mk_child testrepo child2 &&
 	(
 		cd child1 &&
 		git tag Tag &&
@@ -962,7 +970,7 @@ test_expect_success 'push requires --force to update lightweight tag' '
 '
 
 test_expect_success 'push --porcelain' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
 	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
 	echo >>.git/foo "Done" &&
@@ -977,13 +985,13 @@ test_expect_success 'push --porcelain' '
 '
 
 test_expect_success 'push --porcelain bad url' '
-	mk_empty &&
+	mk_empty testrepo &&
 	test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/master:refs/remotes/origin/master &&
 	test_must_fail grep -q Done .git/bar
 '
 
 test_expect_success 'push --porcelain rejected' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
 		git reset --hard origin/master^
@@ -997,7 +1005,7 @@ test_expect_success 'push --porcelain rejected' '
 '
 
 test_expect_success 'push --porcelain --dry-run rejected' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
 		git reset --hard origin/master
@@ -1012,25 +1020,25 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 '
 
 test_expect_success 'push --prune' '
-	mk_test heads/master heads/second heads/foo heads/bar &&
+	mk_test testrepo heads/master heads/second heads/foo heads/bar &&
 	git push --prune testrepo &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_first_commit heads/second &&
-	! check_push_result $the_first_commit heads/foo heads/bar
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_first_commit heads/second &&
+	! check_push_result testrepo $the_first_commit heads/foo heads/bar
 '
 
 test_expect_success 'push --prune refspec' '
-	mk_test tmp/master tmp/second tmp/foo tmp/bar &&
+	mk_test testrepo tmp/master tmp/second tmp/foo tmp/bar &&
 	git push --prune testrepo "refs/heads/*:refs/tmp/*" &&
-	check_push_result $the_commit tmp/master &&
-	check_push_result $the_first_commit tmp/second &&
-	! check_push_result $the_first_commit tmp/foo tmp/bar
+	check_push_result testrepo $the_commit tmp/master &&
+	check_push_result testrepo $the_first_commit tmp/second &&
+	! check_push_result testrepo $the_first_commit tmp/foo tmp/bar
 '
 
 for configsection in transfer receive
 do
 	test_expect_success "push to update a ref hidden by $configsection.hiderefs" '
-		mk_test heads/master hidden/one hidden/two hidden/three &&
+		mk_test testrepo heads/master hidden/one hidden/two hidden/three &&
 		(
 			cd testrepo &&
 			git config $configsection.hiderefs refs/hidden
@@ -1038,32 +1046,32 @@ do
 
 		# push to unhidden ref succeeds normally
 		git push testrepo master:refs/heads/master &&
-		check_push_result $the_commit heads/master &&
+		check_push_result testrepo $the_commit heads/master &&
 
 		# push to update a hidden ref should fail
 		test_must_fail git push testrepo master:refs/hidden/one &&
-		check_push_result $the_first_commit hidden/one &&
+		check_push_result testrepo $the_first_commit hidden/one &&
 
 		# push to delete a hidden ref should fail
 		test_must_fail git push testrepo :refs/hidden/two &&
-		check_push_result $the_first_commit hidden/two &&
+		check_push_result testrepo $the_first_commit hidden/two &&
 
 		# idempotent push to update a hidden ref should fail
 		test_must_fail git push testrepo $the_first_commit:refs/hidden/three &&
-		check_push_result $the_first_commit hidden/three
+		check_push_result testrepo $the_first_commit hidden/three
 	'
 done
 
 test_expect_success 'fetch exact SHA1' '
-	mk_test heads/master hidden/one &&
+	mk_test testrepo heads/master hidden/one &&
 	git push testrepo master:refs/hidden/one &&
 	(
 		cd testrepo &&
 		git config transfer.hiderefs refs/hidden
 	) &&
-	check_push_result $the_commit hidden/one &&
+	check_push_result testrepo $the_commit hidden/one &&
 
-	mk_child child &&
+	mk_child testrepo child &&
 	(
 		cd child &&
 
-- 
1.8.2.141.g3797f84
