From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Fri, 22 Mar 2013 10:44:55 -0400
Message-ID: <20130322144454.GA3083@sigill.intra.peff.net>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 15:45:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3Dz-000606-3d
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933657Ab3CVOpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:45:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35731 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933410Ab3CVOpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:45:09 -0400
Received: (qmail 858 invoked by uid 107); 22 Mar 2013 14:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 10:46:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 10:44:55 -0400
Content-Disposition: inline
In-Reply-To: <1363938756-13722-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218802>

On Fri, Mar 22, 2013 at 01:22:33PM +0530, Ramkumar Ramachandra wrote:

> mk_test() creates a repository with the constant name "testrepo", and
> this may be limiting for tests that need to create more than one
> repository for testing.  To fix this, create a new mk_test_with_name()
> which accepts the repository name as $1.  Reimplement mk_test() as a
> special case of this function, making sure that no tests need to be
> rewritten.  Do the same thing for check_push_result().

I think this is OK, and I do not mind if it gets applied. But what I was
hinting at in my earlier mail was that we might want to do this (I have
it as a separate patch on top of your 3/6 here, but it would make more
sense squashed in):

-- >8 --
Subject: [PATCH] t5516: drop implicit arguments from helper functions

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

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh | 268 ++++++++++++++++++++++++--------------------------
 1 file changed, 130 insertions(+), 138 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 05579b6..d27b8d3 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -8,7 +8,6 @@ mk_empty () {
 
 mk_empty () {
 	repo_name="$1"
-	test -z "$repo_name" && repo_name=testrepo
 	rm -fr $repo_name &&
 	mkdir $repo_name &&
 	(
@@ -19,7 +18,7 @@ mk_empty () {
 	)
 }
 
-mk_test_with_name () {
+mk_test () {
 	repo_name="$1"
 	shift
 
@@ -45,14 +44,11 @@ mk_test_with_hooks() {
 	)
 }
 
-mk_test () {
-	mk_test_with_name testrepo "$@"
-}
-
 mk_test_with_hooks() {
+	repo_name=$1
 	mk_test "$@" &&
 	(
-		cd testrepo &&
+		cd $repo_name &&
 		mkdir .git/hooks &&
 		cd .git/hooks &&
 
@@ -84,11 +80,11 @@ mk_child() {
 }
 
 mk_child() {
-	rm -rf "$1" &&
-	git clone testrepo "$1"
+	rm -rf "$2" &&
+	git clone "$1" "$2"
 }
 
-check_push_result_with_name () {
+check_push_result () {
 	repo_name="$1"
 	shift
 
@@ -108,10 +104,6 @@ check_push_result_with_name () {
 	)
 }
 
-check_push_result () {
-	check_push_result_with_name testrepo "$@"
-}
-
 test_expect_success setup '
 
 	>path1 &&
@@ -129,7 +121,7 @@ test_expect_success 'fetch without wildcard' '
 '
 
 test_expect_success 'fetch without wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		cd testrepo &&
 		git fetch .. refs/heads/master:refs/remotes/origin/master &&
@@ -142,7 +134,7 @@ test_expect_success 'fetch with wildcard' '
 '
 
 test_expect_success 'fetch with wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		cd testrepo &&
 		git config remote.up.url .. &&
@@ -157,7 +149,7 @@ test_expect_success 'fetch with insteadOf' '
 '
 
 test_expect_success 'fetch with insteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
@@ -174,7 +166,7 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 '
 
 test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
-	mk_empty &&
+	mk_empty testrepo &&
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
@@ -191,7 +183,7 @@ test_expect_success 'push without wildcard' '
 '
 
 test_expect_success 'push without wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
@@ -204,7 +196,7 @@ test_expect_success 'push with wildcard' '
 '
 
 test_expect_success 'push with wildcard' '
-	mk_empty &&
+	mk_empty testrepo &&
 
 	git push testrepo "refs/heads/*:refs/remotes/origin/*" &&
 	(
@@ -217,7 +209,7 @@ test_expect_success 'push with insteadOf' '
 '
 
 test_expect_success 'push with insteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	git config "url.$TRASH.insteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
@@ -231,7 +223,7 @@ test_expect_success 'push with pushInsteadOf' '
 '
 
 test_expect_success 'push with pushInsteadOf' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	git config "url.$TRASH.pushInsteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
@@ -245,7 +237,7 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 '
 
 test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
-	mk_empty &&
+	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	git config "url.trash2/.pushInsteadOf" trash/ &&
 	git config remote.r.url trash/wrong &&
@@ -262,242 +254,242 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 
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
@@ -509,8 +501,8 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	git config remote.there.push HEAD &&
 	git config branch.master.remote there &&
 	git push &&
-	check_push_result $the_commit heads/master &&
-	check_push_result $the_first_commit heads/local
+	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_first_commit heads/local
 '
 
 # clean up the cruft left with the previous one
@@ -519,12 +511,12 @@ test_expect_success 'push with config remote.*.pushurl' '
 
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
@@ -532,19 +524,19 @@ test_expect_success 'push updates local refs' '
 
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
@@ -557,9 +549,9 @@ test_expect_success 'push updates up-to-date local refs' '
 
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
@@ -573,8 +565,8 @@ test_expect_success 'push preserves up-to-date packed refs' '
 
 test_expect_success 'push preserves up-to-date packed refs' '
 
-	mk_test heads/master &&
-	mk_child child &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child &&
 	(
 		cd child &&
 		git push &&
@@ -585,8 +577,8 @@ test_expect_success 'push does not update local refs on failure' '
 
 test_expect_success 'push does not update local refs on failure' '
 
-	mk_test heads/master &&
-	mk_child child &&
+	mk_test testrepo heads/master &&
+	mk_child testrepo child &&
 	mkdir testrepo/.git/hooks &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
@@ -602,7 +594,7 @@ test_expect_success 'allow deleting an invalid remote ref' '
 
 test_expect_success 'allow deleting an invalid remote ref' '
 
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
@@ -610,7 +602,7 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 '
 
 test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master heads/next &&
+	mk_test_with_hooks testrepo heads/master heads/next &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
@@ -646,7 +638,7 @@ test_expect_success 'deleting dangling ref triggers hooks with correct args' '
 '
 
 test_expect_success 'deleting dangling ref triggers hooks with correct args' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
 	(
@@ -675,7 +667,7 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 '
 
 test_expect_success 'deletion of a non-existent ref is not fed to post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	git push testrepo master :refs/heads/nonexistent &&
@@ -707,7 +699,7 @@ test_expect_success 'deletion of a non-existent ref alone does trigger post-rece
 '
 
 test_expect_success 'deletion of a non-existent ref alone does trigger post-receive and post-update hooks' '
-	mk_test_with_hooks heads/master &&
+	mk_test_with_hooks testrepo heads/master &&
 	git push testrepo :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
@@ -727,7 +719,7 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 '
 
 test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks with correct input' '
-	mk_test_with_hooks heads/master heads/next heads/pu &&
+	mk_test_with_hooks testrepo heads/master heads/next heads/pu &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
@@ -773,14 +765,14 @@ test_expect_success 'allow deleting a tag using --delete' '
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
@@ -789,17 +781,17 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
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
@@ -810,7 +802,7 @@ test_expect_success 'deny push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -820,7 +812,7 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -832,7 +824,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
-	mk_test heads/master &&
+	mk_test testrepo heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -843,7 +835,7 @@ test_expect_success 'fetch with branches' '
 '
 
 test_expect_success 'fetch with branches' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
 	echo ".." > testrepo/.git/branches/branch1 &&
@@ -858,7 +850,7 @@ test_expect_success 'fetch with branches containing #' '
 '
 
 test_expect_success 'fetch with branches containing #' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
@@ -871,7 +863,7 @@ test_expect_success 'push with branches' '
 '
 
 test_expect_success 'push with branches' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git checkout second &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
@@ -884,7 +876,7 @@ test_expect_success 'push with branches containing #' '
 '
 
 test_expect_success 'push with branches containing #' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
 	git push branch2 &&
 	(
@@ -897,9 +889,9 @@ test_expect_success 'push into aliased refs (consistent)' '
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
@@ -919,9 +911,9 @@ test_expect_success 'push into aliased refs (inconsistent)' '
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
@@ -946,9 +938,9 @@ test_expect_success 'push requires --force to update lightweight tag' '
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
@@ -967,7 +959,7 @@ test_expect_success 'push --porcelain' '
 '
 
 test_expect_success 'push --porcelain' '
-	mk_empty &&
+	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
 	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
 	echo >>.git/foo "Done" &&
@@ -982,13 +974,13 @@ test_expect_success 'push --porcelain rejected' '
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
@@ -1002,7 +994,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 '
 
 test_expect_success 'push --porcelain --dry-run rejected' '
-	mk_empty &&
+	mk_empty testrepo &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
 		git reset --hard origin/master
@@ -1017,25 +1009,25 @@ do
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
@@ -1043,32 +1035,32 @@ test_expect_success 'fetch exact SHA1' '
 
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
1.8.2.13.g0f18d3c
