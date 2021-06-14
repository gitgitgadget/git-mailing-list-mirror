Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB6C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D84611BD
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhFNMHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:07:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:54662 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232755AbhFNMHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 08:07:48 -0400
Received: (qmail 1792 invoked by uid 109); 14 Jun 2021 12:05:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Jun 2021 12:05:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 736 invoked by uid 111); 14 Jun 2021 12:05:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Jun 2021 08:05:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Jun 2021 08:05:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
Message-ID: <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 03:27:04AM -0400, Jeff King wrote:

> @@ -620,6 +636,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  		incdata.seen = seen;
>  
>  		revs->include_check = should_include;
> +		revs->include_check_obj = should_include_obj;
>  		revs->include_check_data = &incdata;
>  
>  		if (prepare_revision_walk(revs))

Whoops. This is missing one crucial thing. I wrote this patch a month or
two ago, but cherry-picked it onto the current master. These days we
have 1e951c6473 (pack-bitmap: clean up include_check after use,
2021-04-28), so we need to do the same cleanup.

t5304 notices, and I even caught it before sending, but I failed to
stage the change before running "git commit --amend". One of these days
I will figure out this whole "git" thing.

The squashable fix is just:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9dfee4a5b7..bfc10148f5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -650,6 +650,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 					      &show_data, NULL);
 
 		revs->include_check = NULL;
+		revs->include_check_obj = NULL;
 		revs->include_check_data = NULL;
 	}
 

but the complete corrected patch is below.

-- >8 --
Subject: [PATCH] bitmaps: don't recurse into trees already in the bitmap

If an object is already mentioned in a reachability bitmap we are
building, then by definition so are all of the objects it can reach. We
have an optimization to stop traversing commits when we see they are
already in the bitmap, but we don't do the same for trees.

It's generally unavoidable to recurse into trees for commits not yet
covered by bitmaps (since most commits generally do have unique
top-level trees). But they usually have subtrees that are shared with
other commits (i.e., all of the subtrees the commit _didn't_ touch). And
some of those commits (and their trees) may be covered by the bitmap.

Usually this isn't _too_ big a deal, because we'll visit those subtrees
only once in total for the whole walk. But if you have a large number of
unbitmapped commits, and if your tree is big, then you may end up
opening a lot of sub-trees for no good reason.

We can use the same optimization we do for commits here: when we are
about to open a tree, see if it's in the bitmap (either the one we are
building, or the "seen" bitmap which covers the UNINTERESTING side of
the bitmap when doing a set-difference).

This works especially well because we'll visit all commits before
hitting any trees. So even in a history like:

  A -- B

if "A" has a bitmap on disk but "B" doesn't, we'll already have OR-ed in
the results from A before looking at B's tree (so we really will only
look at trees touched by B).

For most repositories, the timings produced by p5310 are unspectacular.
Here's linux.git:

  Test                         HEAD^             HEAD
  --------------------------------------------------------------------
  5310.4: simulated clone      6.00(5.90+0.10)   5.98(5.90+0.08) -0.3%
  5310.5: simulated fetch      2.98(5.45+0.18)   2.85(5.31+0.18) -4.4%
  5310.7: rev-list (commits)   0.32(0.29+0.03)   0.33(0.30+0.03) +3.1%
  5310.8: rev-list (objects)   1.48(1.44+0.03)   1.49(1.44+0.05) +0.7%

Any improvement there is within the noise (the +3.1% on test 7 has to be
noise, since we are not recursing into trees, and thus the new code
isn't even run). The results for git.git are likewise uninteresting.

But here are numbers from some other real-world repositories (that are
not public). This one's tree is comparable in size to linux.git, but has
~16k refs (and so less complete bitmap coverage):

  Test                         HEAD^               HEAD
  -------------------------------------------------------------------------
  5310.4: simulated clone      38.34(39.86+0.74)   33.95(35.53+0.76) -11.5%
  5310.5: simulated fetch      2.29(6.31+0.35)     2.20(5.97+0.41) -3.9%
  5310.7: rev-list (commits)   0.99(0.86+0.13)     0.96(0.85+0.11) -3.0%
  5310.8: rev-list (objects)   11.32(11.04+0.27)   6.59(6.37+0.21) -41.8%

And here's another with a very large tree (~340k entries), and a fairly
large number of refs (~10k):

  Test                         HEAD^               HEAD
  -------------------------------------------------------------------------
  5310.3: simulated clone      53.83(54.71+1.54)   39.77(40.76+1.50) -26.1%
  5310.4: simulated fetch      19.91(20.11+0.56)   19.79(19.98+0.67) -0.6%
  5310.6: rev-list (commits)   0.54(0.44+0.11)     0.51(0.43+0.07) -5.6%
  5310.7: rev-list (objects)   24.32(23.59+0.73)   9.85(9.49+0.36) -59.5%

This patch provides substantial improvements in these larger cases, and
have any drawbacks for smaller ones (the cost of the bitmap check is
quite small compared to an actual tree traversal).

Note that we have to add a version of revision.c's include_check
callback which handles non-commits. We could possibly consolidate this
into a single callback for all objects types, as there's only one user
of the feature which would need converted (pack-bitmap.c:should_include).
That would in theory let us avoid duplicating any logic. But when I
tried it, the code ended up much worse to read, with lots of repeated
"if it's a commit do this, otherwise do that". Having two separate
callbacks splits that naturally, and matches the existing split of
show_commit/show_object callbacks.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c |  3 +++
 pack-bitmap.c  | 18 ++++++++++++++++++
 revision.h     |  1 +
 3 files changed, 22 insertions(+)

diff --git a/list-objects.c b/list-objects.c
index 7f404677d5..473a332416 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -164,6 +164,9 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+	if (revs->include_check_obj &&
+	    !revs->include_check_obj(&tree->object, revs->include_check_data))
+		return;
 
 	failed_parse = parse_tree_gently(tree, 1);
 	if (failed_parse) {
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d90e1d9d8c..bfc10148f5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -525,6 +525,22 @@ static int should_include(struct commit *commit, void *_data)
 	return 1;
 }
 
+static int should_include_obj(struct object *obj, void *_data)
+{
+	struct include_data *data = _data;
+	int bitmap_pos;
+
+	bitmap_pos = bitmap_position(data->bitmap_git, &obj->oid);
+	if (bitmap_pos < 0)
+		return 1;
+	if ((data->seen && bitmap_get(data->seen, bitmap_pos)) ||
+	     bitmap_get(data->base, bitmap_pos)) {
+		obj->flags |= SEEN;
+		return 0;
+	}
+	return 1;
+}
+
 static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
 				struct bitmap **base,
 				struct commit *commit)
@@ -620,6 +636,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		incdata.seen = seen;
 
 		revs->include_check = should_include;
+		revs->include_check_obj = should_include_obj;
 		revs->include_check_data = &incdata;
 
 		if (prepare_revision_walk(revs))
@@ -633,6 +650,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 					      &show_data, NULL);
 
 		revs->include_check = NULL;
+		revs->include_check_obj = NULL;
 		revs->include_check_data = NULL;
 	}
 
diff --git a/revision.h b/revision.h
index 93aa012f51..7bb5fa4e7c 100644
--- a/revision.h
+++ b/revision.h
@@ -262,6 +262,7 @@ struct rev_info {
 	int min_parents;
 	int max_parents;
 	int (*include_check)(struct commit *, void *);
+	int (*include_check_obj)(struct object *obj, void *);
 	void *include_check_data;
 
 	/* diff info for patches and for paths limiting */
-- 
2.32.0.549.g52475a27a6

