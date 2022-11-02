Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C095C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 05:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKBF14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 01:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBF1y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 01:27:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA97526497
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 22:27:52 -0700 (PDT)
Received: (qmail 8646 invoked by uid 109); 2 Nov 2022 05:27:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 05:27:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2056 invoked by uid 111); 2 Nov 2022 05:27:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 01:27:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 01:27:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Martin von Zweigbergk <martinvonz@google.com>
Subject: [PATCH v2] branch: gracefully handle '-d' on orphan HEAD
Message-ID: <Y2H/1S3G+KeeEN/l@coredump.intra.peff.net>
References: <Y2F9lkCWf/2rjT2E@nand.local>
 <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:32:18PM -0400, Taylor Blau wrote:

> Subject: Re: [PATCH] branch: gracefully handle '-d' on detached HEAD

OK, here's my version of the patch (which I called v2 for the sake of
confusion). I ended up rewriting the tests and commit message, as there
were a few inaccuracies, and some subtle things our earlier conversation
didn't turn up.

This should really be s/detached/orphan/ here and elsewhere (including
the branch name you used). All of this works fine on a detached HEAD.
It's only a problem when it can't be resolved to a commit at all (one
could perhaps argue that a branch being merged to a detached HEAD isn't
any real kind of safety valve, but that's how it has always worked and
is outside the scope of this fix).

> Since 67affd5173 (git-branch -D: make it work even when on a
> yet-to-be-born branch, 2006-11-24), 'git branch -d' refuses to work when
> orphaned, since there is no HEAD to resolve.

It was true even before that commit that "git branch -d" would refuse to
work. That commit just made it so that "branch -D" worked as a safety
hatch (rather than also dying!).

> But since 67affd5173, there have been other checks, like 99c419c915
> (branch -d: base the "already-merged" safety on the branch it merges
> with, 2009-12-29), which makes it OK to delete a branch if it is merged
> to HEAD or its upstream.

I always thought of this as "either-or", but it is a little different.
If we are merged to HEAD and there is an upstream but we are not merged
to it, we'll still refuse the deletion. Not super relevant for our
purposes here, except that there's extra code to produce a custom
message for this case, which we need to fix to handle NULL. ;)

> Since the code in delete_branches() tolerates a NULL head_rev perfectly
> fine, make it non-fatal to fail to resolve a commit object at HEAD.

And alas, this "perfectly fine" turns out to not be true. :) See below
for the gory details.

-- >8 --
Subject: [PATCH] branch: gracefully handle '-d' on orphan HEAD

When deleting a branch, "git branch -d" has a safety check that ensures
the branch is merged to its upstream (if any), or to HEAD. To do that,
naturally we try to resolve HEAD to a commit object. If we're on an
orphan branch (i.e., HEAD points to a branch that does not yet exist),
that will fail, and we'll bail with an error:

  $ git branch -d to-delete
  fatal: Couldn't look up commit object for HEAD

This usually isn't that big of a deal. The deletion would fail anyway,
since the branch isn't merged to HEAD, and you'd need to use "-D" (or
"-f"). And doing so skips the HEAD resolution, courtesy of 67affd5173
(git-branch -D: make it work even when on a yet-to-be-born branch,
2006-11-24).

But there are still two problems:

  1. The error message isn't very helpful. We should give the usual "not
     fully merged" message, which points the user at "branch -D". That
     was a problem even back in 67affd5173.

  2. Even without a HEAD, these days it's still possible for the
     deletion to succeed. After 67affd5173, commit 99c419c915 (branch
     -d: base the "already-merged" safety on the branch it merges with,
     2009-12-29) made it OK to delete a branch if it is merged to its
     upstream.

We can fix both by removing the die() in delete_branches() completely,
leaving head_rev NULL in this case. It's tempting to stop there, as it
appears at first glance that the rest of the code does the right thing
with a NULL. But sadly, it's not quite true.

We end up feeding the NULL to repo_is_descendant_of(). In the
traditional code path there, we call repo_in_merge_bases_many(). It
feeds the NULL to repo_parse_commit(), which is smart enough to return
an error, and we immediately return "no, it's not a descendant".

But there's an alternate code path: if we have a commit graph with
generation numbers, we end up in can_all_from_reach(), which does
eventually try to set a flag on the NULL commit and segfaults.

So instead, we'll teach the local branch_merged() helper to treat a NULL
as "not merged". This would be a little more elegant in in_merge_bases()
itself, but that function is called in a lot of places, and it's not
clear that quietly returning "not merged" is the right thing everywhere
(I'd expect in many cases, feeding a NULL is a sign of a bug).

There are four tests here:

  a. The first one confirms that deletion succeeds with an orphaned HEAD
     when the branch is merged to its upstream. This is case (2) above.

  b. Same, but with commit graphs enabled. Even if it is merged to
     upstream, we still check head_rev so that we can say "deleting
     because it's merged to upstream, even though it's not merged to
     HEAD". Without the second hunk in branch_merged(), this test would
     segfault in can_all_from_reach().

  c. The third one confirms that we correctly say "not merged to HEAD"
     when we can't resolve HEAD, and reject the deletion.

  d. Same, but with commit graphs enabled. Without the first hunk in
     branch_merged(), this one would segfault.

Reported-by: Martin von Zweigbergk <martinvonz@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c  |  9 +++------
 t/t3200-branch.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 15be0c03ef..9470c980c1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -150,7 +150,7 @@ static int branch_merged(int kind, const char *name,
 	if (!reference_rev)
 		reference_rev = head_rev;
 
-	merged = in_merge_bases(rev, reference_rev);
+	merged = reference_rev ? in_merge_bases(rev, reference_rev) : 0;
 
 	/*
 	 * After the safety valve is fully redefined to "check with
@@ -160,7 +160,7 @@ static int branch_merged(int kind, const char *name,
 	 * a gentle reminder is in order.
 	 */
 	if ((head_rev != reference_rev) &&
-	    in_merge_bases(rev, head_rev) != merged) {
+	    (head_rev ? in_merge_bases(rev, head_rev) : 0) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
 				"         '%s', but not yet merged to HEAD."),
@@ -235,11 +235,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force) {
+	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
-		if (!head_rev)
-			die(_("Couldn't look up commit object for HEAD"));
-	}
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7f605f865b..5a169b68d6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,42 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '
 
+test_expect_success 'git branch -d on orphan HEAD (merged)' '
+	test_when_finished git checkout main &&
+	git checkout --orphan orphan &&
+	test_when_finished "rm -rf .git/objects/commit-graph*" &&
+	git commit-graph write --reachable &&
+	git branch --track to-delete main &&
+	git branch -d to-delete
+'
+
+test_expect_success 'git branch -d on orphan HEAD (merged, graph)' '
+	test_when_finished git checkout main &&
+	git checkout --orphan orphan &&
+	git branch --track to-delete main &&
+	git branch -d to-delete
+'
+
+test_expect_success 'git branch -d on orphan HEAD (unmerged)' '
+	test_when_finished git checkout main &&
+	git checkout --orphan orphan &&
+	test_when_finished "git branch -D to-delete" &&
+	git branch to-delete main &&
+	test_must_fail git branch -d to-delete 2>err &&
+	grep "not fully merged" err
+'
+
+test_expect_success 'git branch -d on orphan HEAD (unmerged, graph)' '
+	test_when_finished git checkout main &&
+	git checkout --orphan orphan &&
+	test_when_finished "git branch -D to-delete" &&
+	git branch to-delete main &&
+	test_when_finished "rm -rf .git/objects/commit-graph*" &&
+	git commit-graph write --reachable &&
+	test_must_fail git branch -d to-delete 2>err &&
+	grep "not fully merged" err
+'
+
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	git rev-parse --verify refs/heads/t &&
-- 
2.38.1.669.g2ee9a5b0e3

