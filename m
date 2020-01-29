Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB785C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1A5207FD
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgA2Fqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:46:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:47198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725858AbgA2Fqs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 00:46:48 -0500
Received: (qmail 14098 invoked by uid 109); 29 Jan 2020 05:46:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 05:46:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14118 invoked by uid 111); 29 Jan 2020 05:54:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 00:54:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 00:46:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] avoid computing zero offsets from NULL pointer
Message-ID: <20200129054647.GA611490@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
 <20200125053834.GB744673@coredump.intra.peff.net>
 <xmqq7e1cbr9w.fsf@gitster-ct.c.googlers.com>
 <20200127211933.GA3794@coredump.intra.peff.net>
 <xmqqtv4f8nlm.fsf@gitster-ct.c.googlers.com>
 <20200129023146.GA596379@coredump.intra.peff.net>
 <xmqqblqm7sg8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblqm7sg8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 09:16:39PM -0800, Junio C Hamano wrote:

> My preference was to take the patch as-is, as it was clear enough,
> before seeing this one ...
> [..]
> which makes quite a lot of sense.

Yeah, about an hour after I wrote it, I thought "gee, that's clearly
better than the other way; I should have done that from the start".

So here's a re-roll of the patch using that technique, with a note in
the commit message.

-- >8 --
Subject: [PATCH] avoid computing zero offsets from NULL pointer

The Undefined Behavior Sanitizer in clang-11 seems to have learned a new
trick: it complains about computing offsets from a NULL pointer, even if
that offset is 0. This causes numerous test failures. For example, from
t1090:

  unpack-trees.c:1355:41: runtime error: applying zero offset to null pointer
  ...
  not ok 6 - in partial clone, sparse checkout only fetches needed blobs

The code in question looks like this:

  struct cache_entry **cache_end = cache + nr;
  ...
  while (cache != cache_end)

and we sometimes pass in a NULL and 0 for "cache" and "nr". This is
conceptually fine, as "cache_end" would be equal to "cache" in this
case, and we wouldn't enter the loop at all. But computing even a zero
offset violates the C standard. And given the fact that UBSan is
noticing this behavior, this might be a potential problem spot if the
compiler starts making unexpected assumptions based on undefined
behavior.

So let's just avoid it, which is pretty easy. In some cases we can just
switch to iterating with a numeric index (as we do in sequencer.c here).
In other cases (like the cache_end one) the use of an end pointer is
more natural; we can keep that by just explicitly checking for the
NULL/0 case when assigning the end pointer.

Note that there are two ways you can write this latter case, checking
for the pointer:

  cache_end = cache ? cache + nr : cache;

or the size:

  cache_end = nr ? cache + nr : cache;

For the case of a NULL/0 ptr/len combo, they are equivalent. But writing
it the second way (as this patch does) has the property that if somebody
were to incorrectly pass a NULL pointer with a non-zero length, we'd
continue to notice and segfault, rather than silently pretending the
length was zero.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c       | 6 +++---
 unpack-trees.c    | 2 +-
 xdiff-interface.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..4d31ec3296 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -588,7 +588,7 @@ static int do_recursive_merge(struct repository *r,
 	struct merge_options o;
 	struct tree *next_tree, *base_tree, *head_tree;
 	int clean;
-	char **xopt;
+	int i;
 	struct lock_file index_lock = LOCK_INIT;
 
 	if (repo_hold_locked_index(r, &index_lock, LOCK_REPORT_ON_ERROR) < 0)
@@ -608,8 +608,8 @@ static int do_recursive_merge(struct repository *r,
 	next_tree = next ? get_commit_tree(next) : empty_tree(r);
 	base_tree = base ? get_commit_tree(base) : empty_tree(r);
 
-	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
-		parse_merge_opt(&o, *xopt);
+	for (i = 0; i < opts->xopts_nr; i++)
+		parse_merge_opt(&o, opts->xopts[i]);
 
 	clean = merge_trees(&o,
 			    head_tree,
diff --git a/unpack-trees.c b/unpack-trees.c
index d5f4d997da..a027504b56 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1352,7 +1352,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    enum pattern_match_result default_match,
 			    int progress_nr)
 {
-	struct cache_entry **cache_end = cache + nr;
+	struct cache_entry **cache_end = nr ? cache + nr : cache;
 
 	/*
 	 * Process all entries that have the given prefix and meet
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 8509f9ea22..99661d43c6 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -84,8 +84,8 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b)
 {
 	const int blk = 1024;
 	long trimmed = 0, recovered = 0;
-	char *ap = a->ptr + a->size;
-	char *bp = b->ptr + b->size;
+	char *ap = a->size ? a->ptr + a->size : a->ptr;
+	char *bp = b->size ? b->ptr + b->size : b->ptr;
 	long smaller = (a->size < b->size) ? a->size : b->size;
 
 	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
-- 
2.25.0.515.g69a699b7aa

