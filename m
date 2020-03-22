Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B937C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 07:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564A5206F8
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 07:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgCVHvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 03:51:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:46876 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725785AbgCVHvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 03:51:41 -0400
Received: (qmail 25402 invoked by uid 109); 22 Mar 2020 07:51:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 07:51:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30609 invoked by uid 111); 22 Mar 2020 08:01:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 04:01:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 03:51:40 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] t3419: drop EXPENSIVE tests
Message-ID: <20200322075140.GA600888@coredump.intra.peff.net>
References: <20200320213916.604658-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320213916.604658-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 09:39:16PM +0000, brian m. carlson wrote:

> I noticed this when I was working on another series and running the
> testsuite with GIT_TEST_LONG=1.  We'll probably want to add this before
> the release if possible.
> 
> It may also be desirable to have at least once CI run that runs this
> way.  In my experience, it does not take substantially longer to run the
> testsuite on a modern Linux system with this option enabled.

I do agree that anything marked with EXPENSIVE is practically useless if
nobody is running it. In many cases these can be made much less
expensive by being smarter about setup (e.g., using fast-import or
test_commit_bulk to create commits rather than looping and creating many
processes).

This one in particular seems to add about 500ms, which isn't too bad.
But I actually don't think it's doing anything useful. See below.

-- >8 --
Subject: [PATCH] t3419: drop EXPENSIVE tests

When t3419 was originally written, it was designed to run a smaller test
for correctness, and then the same test with a larger number of patches
for performance. But it seems unlikely the latter was helping us:

 - it was marked with EXPENSIVE, so hardly anybody ran it anyway

 - there's no indication that it was more likely to find bugs than the
   smaller case (the commit message isn't very helpful, but the original
   cover letter describes it as: "The first patch adds correctness and
   (optional) performance tests".

 - the timing results are shown only via test_debug(). So also not run
   unless the user says "-d", and then not provided in any
   machine-readable form.

If we're interested in performance regressions, a script in t/perf would
be more appropriate. I didn't add one here, because it's not at all
clear to me that what the script is timing is even all that interesting.

Let's simplify the script by dropping the EXPENSIVE run. That in turn
lets us drop the do_tests() wrapper, which lets us consistently use
single-quotes for our test snippets. And we can drop the useless
test_debug() timings, as well as their run() helper. And finally, while
we're here, we can replace the count() helper with the standard
test_seq().

Signed-off-by: Jeff King <peff@peff.net>
---
Prepared on top of en/rebase-backend, since it textually conflicts
otherwise. Best viewed with "diff -w" because of the re-indenting.

 t/t3419-rebase-patch-id.sh | 112 ++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 71 deletions(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index e71560e614..3dc754b13a 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -4,15 +4,6 @@ test_description='git rebase - test patch id computation'
 
 . ./test-lib.sh
 
-count () {
-	i=0
-	while test $i -lt $1
-	do
-		echo "$i"
-		i=$(($i+1))
-	done
-}
-
 scramble () {
 	i=0
 	while read x
@@ -26,75 +17,54 @@ scramble () {
 	mv -f "$1.new" "$1"
 }
 
-run () {
-	echo \$ "$@"
-	/usr/bin/time "$@" >/dev/null
-}
-
 test_expect_success 'setup' '
 	git commit --allow-empty -m initial &&
 	git tag root
 '
 
-do_tests () {
-	nlines=$1 pr=${2-}
-
-	test_expect_success $pr "setup: $nlines lines" "
-		rm -f .gitattributes &&
-		git checkout -q -f master &&
-		git reset --hard root &&
-		count $nlines >file &&
-		git add file &&
-		git commit -q -m initial &&
-		git branch -f other &&
-
-		scramble file &&
-		git add file &&
-		git commit -q -m 'change big file' &&
-
-		git checkout -q other &&
-		: >newfile &&
-		git add newfile &&
-		git commit -q -m 'add small file' &&
-
-		git cherry-pick master >/dev/null 2>&1
-	"
-
-	test_debug "
-		run git diff master^\!
-	"
-
-	test_expect_success $pr 'setup attributes' "
-		echo 'file binary' >.gitattributes
-	"
-
-	test_debug "
-		run git format-patch --stdout master &&
-		run git format-patch --stdout --ignore-if-in-upstream master
-	"
+test_expect_success 'setup: 500 lines' '
+	rm -f .gitattributes &&
+	git checkout -q -f master &&
+	git reset --hard root &&
+	test_seq 500 >file &&
+	git add file &&
+	git commit -q -m initial &&
+	git branch -f other &&
+
+	scramble file &&
+	git add file &&
+	git commit -q -m "change big file" &&
+
+	git checkout -q other &&
+	: >newfile &&
+	git add newfile &&
+	git commit -q -m "add small file" &&
+
+	git cherry-pick master >/dev/null 2>&1
+'
 
-	test_expect_success $pr 'detect upstream patch' '
-		git checkout -q master &&
-		scramble file &&
-		git add file &&
-		git commit -q -m "change big file again" &&
-		git checkout -q other^{} &&
-		git rebase master &&
-		test_must_fail test -n "$(git rev-list master...HEAD~)"
-	'
+test_expect_success 'setup attributes' '
+	echo "file binary" >.gitattributes
+'
 
-	test_expect_success $pr 'do not drop patch' '
-		git branch -f squashed master &&
-		git checkout -q -f squashed &&
-		git reset -q --soft HEAD~2 &&
-		git commit -q -m squashed &&
-		git checkout -q other^{} &&
-		test_must_fail git rebase squashed &&
-		git rebase --quit
-	'
-}
+test_expect_success 'detect upstream patch' '
+	git checkout -q master &&
+	scramble file &&
+	git add file &&
+	git commit -q -m "change big file again" &&
+	git checkout -q other^{} &&
+	git rebase master &&
+	test_must_fail test -n "$(git rev-list master...HEAD~)"
+'
 
-do_tests 500
-do_tests 50000 EXPENSIVE
+test_expect_success 'do not drop patch' '
+	git branch -f squashed master &&
+	git checkout -q -f squashed &&
+	git reset -q --soft HEAD~2 &&
+	git commit -q -m squashed &&
+	git checkout -q other^{} &&
+	test_must_fail git rebase squashed &&
+	git rebase --quit
+'
 
 test_done
-- 
2.26.0.rc2.641.gac63ba406a

