Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D54C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B686023406
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLGTK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:10:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:55224 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgLGTK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:10:58 -0500
Received: (qmail 8980 invoked by uid 109); 7 Dec 2020 19:10:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:10:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25634 invoked by uid 111); 7 Dec 2020 19:10:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:10:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:10:17 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/9] misc commit-graph and oid-array cleanups
Message-ID: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a re-roll of my series to clean up commit-graph and oid-array.
The changes are all cosmetic: comments and commit messages (and most of
those just in the for-loop patch). I recommend just reading the
range-diff below, if you reviewed v1.

  [1/9]: oid-array.h: drop sha1 mention from header guard
  [2/9]: t0064: drop sha1 mention from filename
  [3/9]: t0064: make duplicate tests more robust
  [4/9]: cache.h: move hash/oid functions to hash.h
  [5/9]: oid-array: make sort function public
  [6/9]: oid-array: provide a for-loop iterator
  [7/9]: commit-graph: drop count_distinct_commits() function
  [8/9]: commit-graph: replace packed_oid_list with oid_array
  [9/9]: commit-graph: use size_t for array allocation and indexing

 cache.h                                       |  94 ---------------
 commit-graph.c                                | 107 +++---------------
 hash.h                                        |  95 ++++++++++++++++
 oid-array.c                                   |  17 ++-
 oid-array.h                                   |  34 +++++-
 t/{t0064-sha1-array.sh => t0064-oid-array.sh} |   9 +-
 6 files changed, 157 insertions(+), 199 deletions(-)
 rename t/{t0064-sha1-array.sh => t0064-oid-array.sh} (90%)

Range-diff from v1:

 1:  7cfd2f9a29 =  1:  1b52a4ea67 oid-array.h: drop sha1 mention from header guard
 2:  82b8902560 =  2:  96ef8b8bb8 t0064: drop sha1 mention from filename
 3:  b69af2f0d5 =  3:  7382ad6d52 t0064: make duplicate tests more robust
 4:  0e258a486a =  4:  a0b8b9aabf cache.h: move hash/oid functions to hash.h
 5:  1ed342fe20 =  5:  336650a307 oid-array: make sort function public
 6:  28893c76f8 !  6:  cc1c2a16da oid-array: provide a for-loop iterator
    @@ oid-array.h: void oid_array_filter(struct oid_array *array,
      void oid_array_sort(struct oid_array *array);
      
     +/**
    -+ * Find the next unique oid in the array after position "cur". You
    -+ * can use this to iterate over unique elements, like:
    ++ * Find the next unique oid in the array after position "cur".
    ++ * The array must be sorted for this to work. You can iterate
    ++ * over unique elements like this:
     + *
     + *   size_t i;
     + *   oid_array_sort(array);
 7:  d025d6215c !  7:  16fd32e41c commit-graph: drop count_distinct_commits() function
    @@ Commit message
         the count are:
     
           - check if our count will overflow our data structures. But the limit
    -        there is 2^31 commits, so it's not likely to happen in practice.
    +        there is 2^31 commits, so while this is a useful check, the
    +        off-by-one is not likely to matter.
     
           - pre-allocate the array of commit pointers. But over-allocating by
    -        one isn't a problem.
    +        one isn't a problem; we'll just waste a few extra bytes.
     
         The bug would be easy enough to fix, but we can observe that neither of
    -    those steps is necessary. We'll check the count of the commit array
    -    after we build it anyway, so checking at this point is redundant. And we
    -    use ALLOC_GROW() when building the commit array, so there's no need to
    -    preallocate it (it's possible that doing so is slightly more efficient,
    -    but if we care we can just optimistically allocate one slot for each
    -    oid; I didn't bother here).
    +    those steps is necessary.
    +
    +    After building the actual commit array, we'll likewise check its count
    +    for overflow. So the extra check of the distinct commit count here is
    +    redundant.
    +
    +    And likewise we use ALLOC_GROW() when building the commit array, so
    +    there's no need to preallocate it (it's possible that doing so is
    +    slightly more efficient, but if we care we can just optimistically
    +    allocate one slot for each oid; I didn't bother here).
     
         So count_distinct_commits() isn't doing anything useful. Let's just get
         rid of that step.
     
         Note that a side effect of the function was that we sorted the list of
         oids, which we do rely on in copy_oids_to_commits(), since it must also
    -    skip the duplicates. So we'll move the qsort there.
    +    skip the duplicates. So we'll move the qsort there. I didn't copy the
    +    "TODO" about adding more progress meters. It's actually quite hard to
    +    make a repository large enough for this qsort would take an appreciable
    +    amount of time, so this doesn't seem like a useful note.
     
         Signed-off-by: Jeff King <peff@peff.net>
     
 8:  55d6052e0d =  8:  b0f6326fbe commit-graph: replace packed_oid_list with oid_array
 9:  c9c6e2de47 =  9:  89848e2214 commit-graph: use size_t for array allocation and indexing
