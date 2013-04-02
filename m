From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] t5516 (fetch-push): drop implicit arguments from helper functions
Date: Tue,  2 Apr 2013 13:10:31 +0530
Message-ID: <1364888434-30388-4-git-send-email-artagnon@gmail.com>
References: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:40:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvp7-0007OZ-3P
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab3DBHj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:39:28 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:41382 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759834Ab3DBHj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:39:26 -0400
Received: by mail-pb0-f50.google.com with SMTP id jt11so93410pbb.37
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q+8GXJTfWd+ac4KtVD/nSolQvGhJ4tWVujDhF7F6khw=;
        b=lTITU4Q4UTW9u6Rdvnx1hdu44GXFweaddTbbPY2xF5b9Hsc5wDDDAoLw+U6FhA5RrL
         0qNACP2eUOYHzegXhl7X+T7rzhsufb2JKrfWRDXAhLakchMwjnZUt+L4lM7WsYziB+8K
         2JxA1FoWJHb8yeU16C68lI5W18EW1NEUeAxdMhZtyCRPlnkRe78Oe6GJscaAzLDzGggS
         evJhu6EGI+vqVcLSZz9OK1Xa5ygWnNYqqE+62fgleRZg5ki7uHZm7RL4o7LsiR+q0HoV
         dzF20tZN9qJ5ojibCW+1u1tF4qulsgbZLtywoKxqyZ5tKOSMTRRQanNr56d0I7UvY4Y8
         Klgg==
X-Received: by 10.66.11.164 with SMTP id r4mr23303946pab.219.1364888365999;
        Tue, 02 Apr 2013 00:39:25 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id oq3sm1259341pac.16.2013.04.02.00.39.23
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 00:39:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.363.g901f5bc
In-Reply-To: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219747>

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
 t/t5516-fetch-push.sh | 282 ++++++++++++++++++++++++++------------------------
 1 file changed, 145 insertions(+), 137 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f394271..b800a8e 100755
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
@@ -29,14 +30,17 @@ mk_empty () {
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
-			git push testrepo $the_first_commit:refs/$ref ||
+			git push "$repo_name" $the_first_commit:refs/$ref ||
 			exit
 		done &&
-		cd testrepo &&
+		cd "$repo_name" &&
 		for ref in "$@"
 		do
 			echo "$the_first_commit" >expect &&
@@ -49,9 +53,10 @@ mk_test () {
 }
 
 mk_test_with_hooks() {
+	repo_name=$1
 	mk_test "$@" &&
 	(
-		cd testrepo &&
+		cd "$repo_name" &&
 		mkdir .git/hooks &&
 		cd .git/hooks &&
 
@@ -83,13 +88,16 @@ mk_test_with_hooks() {
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
 		echo "$1" >expect &&
 		shift &&
 		for ref in "$@"
@@ -119,7 +127,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'fetch without wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		cd testrepo &&
 		git fetch .. refs/heads/master:refs/remotes/origin/master &&
@@ -131,7 +139,7 @@ test_expect_success 'fetch without wildcard' '
 '
 
 test_expect_success 'fetch with wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		cd testrepo &&
 		git config remote.up.url .. &&
@@ -145,7 +153,7 @@ test_expect_success 'fetch with wildcard' '
 '
 
 test_expect_success 'fetch with insteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
@@ -161,7 +169,7 @@ test_expect_success 'fetch with insteadOf' '
 '
 
 test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
@@ -177,7 +185,7 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 '
 
 test_expect_success 'push without wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
@@ -189,7 +197,7 @@ test_expect_success 'push without wildcard' '
 '
 
 test_expect_success 'push with wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 
 	git push testrepo "refs/heads/*:refs/remotes/origin/*" &&
 	(
@@ -201,7 +209,7 @@ test_expect_success 'push with wildcard' '
 '
 
 test_expect_success 'push with insteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	test_config "url.$TRASH.insteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
@@ -214,7 +222,7 @@ test_expect_success 'push with insteadOf' '
 '
 
 test_expect_success 'push with pushInsteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	test_config "url.$TRASH.pushInsteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
@@ -227,7 +235,7 @@ test_expect_success 'push with pushInsteadOf' '
 '
 
 test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	test_config "url.trash2/.pushInsteadOf" trash/ &&
 	test_config remote.r.url trash/wrong &&
@@ -243,237 +251,237 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 
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
 	test_must_fail git push testrepo master:frotz &&
-	check_push_result $the_first_commit heads/frotz tags/frotz
+	check_push_result testrepo $the_first_commit heads/frotz tags/frotz
 
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
@@ -485,35 +493,35 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	test_config remote.there.push HEAD &&
 	test_config branch.master.remote there &&
 	git push &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_first_commit heads/local
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_first_commit heads/local
 '
 
 test_expect_success 'push with config remote.*.pushurl' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	git checkout master &&
 	test_config remote.there.url test2repo &&
 	test_config remote.there.pushurl testrepo &&
 	git push there &&
-	check_push_result $the_commit heads/master
+	check_push_result testrepo $the_commit heads/master
 '
 
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
@@ -526,9 +534,9 @@ test_expect_success 'push updates local refs' '
 
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
@@ -542,8 +550,8 @@ test_expect_success 'push updates up-to-date local refs' '
 
 test_expect_success 'push preserves up-to-date packed refs' '
 
-	mk_test heads/master &&
-	mk_child child &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child &&
 	(
 		cd child &&
 		git push &&
@@ -554,8 +562,8 @@ test_expect_success 'push preserves up-to-date packed refs' '
 
 test_expect_success 'push does not update local refs on failure' '
 
-	mk_test heads/master &&
-	mk_child child &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child &&
 	mkdir testrepo/.git/hooks &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
@@ -571,7 +579,7 @@ test_expect_success 'push does not update local refs on failure' '
 
 test_expect_success 'allow deleting an invalid remote ref' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
@@ -579,7 +587,7 @@ test_expect_success 'allow deleting an invalid remote ref' '
 '
 
 test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master heads/next &&
+	mk_test_with_hooks testrepo heads/master heads/next &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
@@ -615,7 +623,7 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 '
 
 test_expect_success 'deleting dangling ref triggers hooks with correct args' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
 	(
@@ -644,7 +652,7 @@ test_expect_success 'deleting dangling ref triggers hooks with correct args' '
 '
 
 test_expect_success 'deletion of a non-existent ref is not fed to post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	git push testrepo master :refs/heads/nonexistent &&
@@ -676,7 +684,7 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 '
 
 test_expect_success 'deletion of a non-existent ref alone does trigger post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	git push testrepo :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
@@ -696,7 +704,7 @@ test_expect_success 'deletion of a non-existent ref alone does trigger post-rece
 '
 
 test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks with correct input' '
-	mk_test_with_hooks heads/master heads/next heads/pu &&
+	mk_test_with_hooks testrepo heads/master heads/next heads/pu &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
@@ -742,14 +750,14 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
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
@@ -758,17 +766,17 @@ test_expect_success 'allow deleting a tag using --delete' '
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
@@ -779,7 +787,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -789,7 +797,7 @@ test_expect_success 'deny push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -801,7 +809,7 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -812,7 +820,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 '
 
 test_expect_success 'fetch with branches' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
 	echo ".." > testrepo/.git/branches/branch1 &&
@@ -827,7 +835,7 @@ test_expect_success 'fetch with branches' '
 '
 
 test_expect_success 'fetch with branches containing #' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
@@ -840,7 +848,7 @@ test_expect_success 'fetch with branches containing #' '
 '
 
 test_expect_success 'push with branches' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git checkout second &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
@@ -853,7 +861,7 @@ test_expect_success 'push with branches' '
 '
 
 test_expect_success 'push with branches containing #' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
 	git push branch2 &&
 	(
@@ -866,9 +874,9 @@ test_expect_success 'push with branches containing #' '
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
@@ -888,9 +896,9 @@ test_expect_success 'push into aliased refs (consistent)' '
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
@@ -915,9 +923,9 @@ test_expect_success 'push into aliased refs (inconsistent)' '
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
@@ -936,7 +944,7 @@ test_expect_success 'push requires --force to update lightweight tag' '
 '
 
 test_expect_success 'push --porcelain' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
 	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
 	echo >>.git/foo "Done" &&
@@ -951,13 +959,13 @@ test_expect_success 'push --porcelain' '
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
@@ -971,7 +979,7 @@ test_expect_success 'push --porcelain rejected' '
 '
 
 test_expect_success 'push --porcelain --dry-run rejected' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
 		git reset --hard origin/master
@@ -986,25 +994,25 @@ test_expect_success 'push --porcelain --dry-run rejected' '
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
@@ -1012,32 +1020,32 @@ do
 
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
 
@@ -1063,7 +1071,7 @@ test_expect_success 'fetch exact SHA1' '
 '
 
 test_expect_success 'fetch follows tags by default' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	rm -fr src dst &&
 	git init src &&
 	(
@@ -1090,7 +1098,7 @@ test_expect_success 'fetch follows tags by default' '
 '
 
 test_expect_success 'push does not follow tags by default' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	rm -fr src dst &&
 	git init src &&
 	git init --bare dst &&
@@ -1113,7 +1121,7 @@ test_expect_success 'push does not follow tags by default' '
 '
 
 test_expect_success 'push --follow-tag only pushes relevant tags' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	rm -fr src dst &&
 	git init src &&
 	git init --bare dst &&
-- 
1.8.2.363.g901f5bc
