From: Jeff King <peff@peff.net>
Subject: [PATCH] do not use GIT_TRACE_PACKET=3 in tests
Date: Wed, 20 Mar 2013 13:43:47 -0400
Message-ID: <20130320174347.GA28548@sigill.intra.peff.net>
References: <20130320172640.GC10752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIN42-0006mK-JG
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab3CTRny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:43:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60291 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab3CTRnx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:43:53 -0400
Received: (qmail 10142 invoked by uid 107); 20 Mar 2013 17:45:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 13:45:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 13:43:47 -0400
Content-Disposition: inline
In-Reply-To: <20130320172640.GC10752@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218628>

Some test scripts use the GIT_TRACE mechanism to dump
debugging information to descriptor 3 (and point it to a
file using the shell). On Windows, however, bash is unable
to set up descriptor 3. We do not write our trace to the
file, and worse, we may interfere with other operations
happening on descriptor 3, causing tests to fail or other
even behave inconsistently.

Prior to commit 97a83fa (upload-pack: remove packet debugging
harness), these tests used GIT_DEBUG_SEND_PACK, which only
supported output to a descriptor. The tests in t5503 were
always broken on Windows, and were marked to be skipped via
the NOT_MINGW prerequisite. In t5700, the tests used to pass
prior to 97a83fa, but only because they were not careful
enough; because we only grepped the trace file, an empty
file looked successful to us. But post-97a83fa, the writing
to descriptor 3 causes "git fetch" to hang (presumably
because we are throwing random bytes into the middle of the
protocol).

Now that we are using the GIT_TRACE mechanism, we can
improve both scripts by asking git to write directly to a
file rather than a descriptor. That fixes the hang in t5700,
and should allow t5503 to successfully run on Windows.

In both cases we now also use "test -s" to double-check that
our trace file actually contains output, which should reduce
the possibility of an erroneously passing test.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of jk/pkt-line-cleanup.

This works for me on Linux, but I do not have a mingw system to test
t5503 on. If my reasoning is right, it should, but one never knows. :)

Johannes, can you report whether it fixes the problem?

 t/t5503-tagfollow.sh       | 38 ++++++++++++++++++--------------------
 t/t5700-clone-reference.sh | 14 +++++++++-----
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index d181c96..f30c038 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -4,10 +4,6 @@ test_description='test automatic tag following'
 
 . ./test-lib.sh
 
-if ! test_have_prereq NOT_MINGW; then
-	say "GIT_TRACE_PACKET not supported - skipping tests"
-fi
-
 # End state of the repository:
 #
 #         T - tag1          S - tag2
@@ -17,7 +13,7 @@ fi
 #     \   C - origin/cat    \
 #      origin/master         master
 
-test_expect_success NOT_MINGW setup '
+test_expect_success setup '
 	test_tick &&
 	echo ichi >file &&
 	git add file &&
@@ -39,33 +35,35 @@ test_expect_success NOT_MINGW 'fetch A (new commit : 1 connection)' '
 '
 
 U=UPLOAD_LOG
+UPATH="$(pwd)/$U"
 
-test_expect_success NOT_MINGW 'setup expect' '
+test_expect_success 'setup expect' '
 cat - <<EOF >expect
 want $A
 EOF
 '
 
 get_needs () {
+	test -s "$1" &&
 	perl -alne '
 		next unless $F[1] eq "upload-pack<";
 		last if $F[2] eq "0000";
 		print $F[2], " ", $F[3];
-	' "$@"
+	' "$1"
 }
 
-test_expect_success NOT_MINGW 'fetch A (new commit : 1 connection)' '
+test_expect_success 'fetch A (new commit : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $A = $(git rev-parse --verify origin/master)
 	) &&
 	get_needs $U >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW "create tag T on A, create C on branch cat" '
+test_expect_success "create tag T on A, create C on branch cat" '
 	git tag -a -m tag1 tag1 $A &&
 	T=$(git rev-parse --verify tag1) &&
 
@@ -77,18 +75,18 @@ test_expect_success NOT_MINGW 'fetch C, T (new branch, tag : 1 connection)' '
 	git checkout master
 '
 
-test_expect_success NOT_MINGW 'setup expect' '
+test_expect_success 'setup expect' '
 cat - <<EOF >expect
 want $C
 want $T
 EOF
 '
 
-test_expect_success NOT_MINGW 'fetch C, T (new branch, tag : 1 connection)' '
+test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $C = $(git rev-parse --verify origin/cat) &&
 		test $T = $(git rev-parse --verify tag1) &&
 		test $A = $(git rev-parse --verify tag1^0)
@@ -97,7 +95,7 @@ test_expect_success NOT_MINGW 'fetch C, T (new branch, tag : 1 connection)' '
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW "create commits O, B, tag S on B" '
+test_expect_success "create commits O, B, tag S on B" '
 	test_tick &&
 	echo O >file &&
 	git add file &&
@@ -113,18 +111,18 @@ test_expect_success NOT_MINGW 'fetch B, S (commit and tag : 1 connection)' '
 	S=$(git rev-parse --verify tag2)
 '
 
-test_expect_success NOT_MINGW 'setup expect' '
+test_expect_success 'setup expect' '
 cat - <<EOF >expect
 want $B
 want $S
 EOF
 '
 
-test_expect_success NOT_MINGW 'fetch B, S (commit and tag : 1 connection)' '
+test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $S = $(git rev-parse --verify tag2)
@@ -133,14 +131,14 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW 'setup expect' '
+test_expect_success 'setup expect' '
 cat - <<EOF >expect
 want $B
 want $S
 EOF
 '
 
-test_expect_success NOT_MINGW 'new clone fetch master and tags' '
+test_expect_success 'new clone fetch master and tags' '
 	git branch -D cat
 	rm -f $U
 	(
@@ -148,7 +146,7 @@ test_expect_success NOT_MINGW 'new clone fetch master and tags' '
 		cd clone2 &&
 		git init &&
 		git remote add origin .. &&
-		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $S = $(git rev-parse --verify tag2) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 9cd3b4d..60f1552 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -54,11 +54,14 @@ test_expect_success 'cloning with reference (no -l -s)' \
 
 rm -f "$U.D"
 
-test_expect_success 'cloning with reference (no -l -s)' \
-'GIT_TRACE_PACKET=3 git clone --reference B "file://$(pwd)/A" D 3>"$U.D"'
+test_expect_success 'cloning with reference (no -l -s)' '
+	GIT_TRACE_PACKET=$U.D git clone --reference B "file://$(pwd)/A" D
+'
 
-test_expect_success 'fetched no objects' \
-'! grep " want" "$U.D"'
+test_expect_success 'fetched no objects' '
+	test -s "$U.D" &&
+	! grep " want" "$U.D"
+'
 
 cd "$base_dir"
 
@@ -173,9 +176,10 @@ test_expect_success 'fetch with incomplete alternates' '
 	(
 		cd K &&
 		git remote add J "file://$base_dir/J" &&
-		GIT_TRACE_PACKET=3 git fetch J 3>"$U.K"
+		GIT_TRACE_PACKET=$U.K git fetch J
 	) &&
 	master_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/master) &&
+	test -s "$U.K" &&
 	! grep " want $master_object" "$U.K" &&
 	tag_object=$(cd A && git for-each-ref --format="%(objectname)" refs/tags/HEAD) &&
 	! grep " want $tag_object" "$U.K"
-- 
1.8.2.22.g1efe1a3
