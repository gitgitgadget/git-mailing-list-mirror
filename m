Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A592C352A4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D44206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgBMCPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:15:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:42046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729333AbgBMCPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:15:07 -0500
Received: (qmail 9779 invoked by uid 109); 13 Feb 2020 02:13:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:13:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8490 invoked by uid 111); 13 Feb 2020 02:24:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:24:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:15:06 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/13] combining object filters and bitmaps
Message-ID: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Partial clones are nice for saving bandwidth, but they can actually be
more expensive in CPU because many of the filters require the server to
do extra work to figure out which objects to send.

In particular, it's impossible for many filters to work with
reachability bitmaps, because the bitmap result doesn't provide enough
information. E.g., we can't evaluate a path-based sparse filter without
actually walking the trees to find out which objects are referred to at
which paths.

But in some cases the bitmaps _do_ give enough information, and it's
just a weakness of our implementation. E.g., it's easy to remove all of
the blobs from a bitmap result. So this patch series implements some of
the easier filters, while providing a framework for the bitmap code to
say "nope, that filter is too complex for me" so we can fallback to a
non-bitmap path.

One thing I'm not wild about is that this basically creates a parallel
universe of filter implementations, as nothing is shared with the
code in list-objects-filter.c (beyond the option parsing stage).
But if you look at the implementations in patches 11 and 12, I think
that's how it has to be in order to be efficient. The existing filters
are inherently about hooking into the traversal, and the whole point of
reachability bitmaps is to avoid that traversal.

So I think the best we can do is carefully write bitmap-aware versions
of specific filters, and then fall back to a regular traversal as
necessary. I'd like to also give server providers some tools for
limiting which filters they're willing to support (so they can protect
themselves from people running expensive filters), but I've left that as
future work for now.

Here's an outline of the series:

  [01/13]: pack-bitmap: factor out type iterator initialization
  [02/13]: pack-bitmap: fix leak of haves/wants object lists

    Some related fixes and cleanups in the bitmap area.

  [03/13]: rev-list: fallback to non-bitmap traversal when filtering
  [04/13]: rev-list: consolidate bitmap-disabling options
  [05/13]: rev-list: factor out bitmap-optimized routines

    It's much easier to exercise this code via rev-list, so this is some
    refactoring around the bitmap support there.

  [06/13]: rev-list: make --count work with --objects
  [07/13]: rev-list: allow bitmaps when counting objects

    These two aren't strictly necessary for the topic at hand, but have
    been bugging me for years. And they were made simple by the earlier
    refactoring, and provide a handy test mechanism.

  [08/13]: pack-bitmap: basic noop bitmap filter infrastructure
  [09/13]: rev-list: use bitmap filters for traversal
  [10/13]: bitmap: add bitmap_unset() function

    More refactoring in preparation for supporting filters.

  [11/13]: pack-bitmap: implement BLOB_NONE filtering
  [12/13]: pack-bitmap: implement BLOB_LIMIT filtering

    Some actual filters (tested with rev-list support added earlier).

  [13/13]: pack-objects: support filters with bitmaps

    And finally turning on support for pack generation. The final
    numeric result is (using linux.git with blob:none):

      Test                              HEAD^               HEAD
      ------------------------------------------------------------------------------
      5310.9: simulated partial clone   38.94(37.28+5.87)   11.06(11.27+4.07) -71.6%

    which isn't too shabby.

 builtin/pack-objects.c             |   3 +-
 builtin/rev-list.c                 | 124 +++++++++++---
 ewah/bitmap.c                      |   8 +
 ewah/ewok.h                        |   1 +
 object.c                           |   9 ++
 object.h                           |   2 +
 pack-bitmap.c                      | 252 +++++++++++++++++++++++++----
 pack-bitmap.h                      |   4 +-
 reachable.c                        |   2 +-
 t/perf/p5310-pack-bitmaps.sh       |  14 ++
 t/t5310-pack-bitmaps.sh            |  20 +++
 t/t6000-rev-list-misc.sh           |  12 ++
 t/t6113-rev-list-bitmap-filters.sh |  77 +++++++++
 13 files changed, 468 insertions(+), 60 deletions(-)
 create mode 100755 t/t6113-rev-list-bitmap-filters.sh

-Peff
