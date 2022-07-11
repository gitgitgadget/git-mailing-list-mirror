Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8374C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiGKOsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiGKOsI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:48:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4506D2F7
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:48:07 -0700 (PDT)
Received: (qmail 8319 invoked by uid 109); 11 Jul 2022 14:48:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 14:48:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20222 invoked by uid 111); 11 Jul 2022 14:48:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 10:48:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 10:48:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] ref-filter: disable save_commit_buffer while traversing
Message-ID: <Ysw4JtoHW1vWmqhz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various ref-filter options like "--contains" or "--merged" may cause us
to traverse large segments of the history graph. It's counter-productive
to have save_commit_buffer turned on, as that will instruct the commit
code to cache in-memory the object contents for each commit we traverse.

This increases the amount of heap memory used while providing little or
no benefit, since we're not actually planning to display those commits
(which is the usual reason that tools like git-log want to keep them
around). We can easily disable this feature while ref-filter is running.
This lowers peak heap (as measured by massif) for running:

  git tag --contains 1da177e4c3

in linux.git from ~100MB to ~20MB. It also seems to improve runtime by
4-5% (600ms vs 630ms).

A few points to note:

  - it should be safe to temporarily disable save_commit_buffer like
    this. The saved buffers are accessed through get_commit_buffer(),
    which treats the saved ones like a cache, and loads on-demand from
    the object database on a cache miss. So any code that was using this
    would not be wrong, it might just incur an extra object lookup for
    some objects. But...

  - I don't think any ref-filter related code is using the cache. While
    it's true that an option like "--format=%(*contents:subject)" or
    "--sort=*authordate" will need to look at the commit contents,
    ref-filter doesn't use get_commit_buffer() to do so! It always reads
    the objects directly via read_object_file(), though it does avoid
    re-reading objects if the format can be satisfied without them.

    Timing "git tag --format=%(*authordate)" shows that we're the same
    before and after, as expected.

  - Note that all of this assumes you don't have a commit-graph file. if
    you do, then the heap usage is even lower, and the runtime is 10x
    faster. So in that sense this is not urgent, as there's a much
    better solution. But since it's such an obvious and easy win for
    fallback cases (including commits which aren't yet in the graph
    file), there's no reason not to.

Signed-off-by: Jeff King <peff@peff.net>
---
Just pulling this out of the discussion in:

  https://lore.kernel.org/git/YswuaPx6Mk7YkIim@coredump.intra.peff.net/

as it's an easy win.

I doubt that anyone even cares about restoring the value of
save_commit_buffer. So this _could_ be a one-liner turning it off,
rather than doing the save/restore dance. I was mostly erring on the
conservative side, but maybe fewer lines of code is a worthwhile thing.

 ref-filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index d3c90e5dbe..bdf39fa761 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2405,13 +2405,17 @@ static void reach_filter(struct ref_array *array,
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
 {
 	struct ref_filter_cbdata ref_cbdata;
+	int save_commit_buffer_orig;
 	int ret = 0;
 
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
 	filter->kind = type & FILTER_REFS_KIND_MASK;
 
+	save_commit_buffer_orig = save_commit_buffer;
+	save_commit_buffer = 0;
+
 	init_contains_cache(&ref_cbdata.contains_cache);
 	init_contains_cache(&ref_cbdata.no_contains_cache);
 
@@ -2444,6 +2448,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
 	reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);
 
+	save_commit_buffer = save_commit_buffer_orig;
 	return ret;
 }
 
-- 
2.37.0.424.g982e2d45d0
