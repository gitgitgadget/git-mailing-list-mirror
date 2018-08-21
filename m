Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC171F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeHUW1q (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:27:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:50734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726627AbeHUW1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:27:46 -0400
Received: (qmail 6913 invoked by uid 109); 21 Aug 2018 19:06:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:06:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26000 invoked by uid 111); 21 Aug 2018 19:06:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:06:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:06:22 -0400
Date:   Tue, 21 Aug 2018 15:06:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] reuse on-disk deltas for fetches with bitmaps
Message-ID: <20180821190622.GA30301@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817205427.GA19580@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 04:54:27PM -0400, Jeff King wrote:

> This series more aggressively reuses on-disk deltas to serve fetches
> when reachability bitmaps tell us a more complete picture of what the
> client has. That saves server CPU and results in smaller packs. See the
> final patch for numbers and more discussion.

Here's a v2, with just a few cosmetic fixes to address the comments on
v1 (range-diff below).

  [1/6]: t/perf: factor boilerplate out of test_perf
  [2/6]: t/perf: factor out percent calculations
  [3/6]: t/perf: add infrastructure for measuring sizes
  [4/6]: t/perf: add perf tests for fetches from a bitmapped server
  [5/6]: pack-bitmap: save "have" bitmap from walk
  [6/6]: pack-objects: reuse on-disk deltas for thin "have" objects

 builtin/pack-objects.c             | 28 +++++++----
 pack-bitmap.c                      | 25 +++++++++-
 pack-bitmap.h                      |  7 +++
 pack-objects.c                     | 19 ++++++++
 pack-objects.h                     | 20 +++++++-
 t/perf/README                      | 25 ++++++++++
 t/perf/aggregate.perl              | 69 ++++++++++++++++++++++------
 t/perf/p5311-pack-bitmaps-fetch.sh | 45 ++++++++++++++++++
 t/perf/perf-lib.sh                 | 74 +++++++++++++++++++-----------
 9 files changed, 260 insertions(+), 52 deletions(-)
 create mode 100755 t/perf/p5311-pack-bitmaps-fetch.sh

1:  89fa0ec8d8 ! 1:  3e1b94d7d6 pack-bitmap: save "have" bitmap from walk
    @@ -69,6 +69,8 @@
     +
     +	if (!bitmap_git)
     +		return 0; /* no bitmap loaded */
    ++	if (!bitmap_git->result)
    ++		BUG("failed to perform bitmap walk before querying");
     +	if (!bitmap_git->haves)
     +		return 0; /* walk had no "haves" */
     +
2:  f7ca0d59e3 ! 2:  b8b2416aac pack-objects: reuse on-disk deltas for thin "have" objects
    @@ -12,7 +12,7 @@
         However, this misses some opportunities. Modulo some special
         cases like shallow or partial clones, we know that every
         object reachable from the "haves" could be a preferred base.
    -    We don't use them all for two reasons:
    +    We don't use all of them for two reasons:
     
           1. It's expensive to traverse the whole history and
              enumerate all of the objects the other side has.
    @@ -100,15 +100,16 @@
     
         The second is that the rest of the code assumes that any
         reused delta will point to another "struct object_entry" as
    -    its base. But by definition, we don't have such an entry!
    +    its base. But of course the case we are interested in here
    +    is the one where don't have such an entry!
     
         I looked at a number of options that didn't quite work:
     
    -     - we could use a different flag for reused deltas. But it's
    -       not a single bit for "I'm being reused". We have to
    -       actually store the oid of the base, which is normally
    -       done by pointing to the existing object_entry. And we'd
    -       have to modify all the code which looks at deltas.
    +     - we could use a flag to signal a reused delta, but it's
    +       not a single bit. We have to actually store the oid of
    +       the base, which is normally done by pointing to the
    +       existing object_entry. And we'd have to modify all the
    +       code which looks at deltas.
     
          - we could add the reused bases to the end of the existing
            object_entry array. While this does create some extra
    @@ -173,7 +174,7 @@
      static int depth = 50;
      static int delta_search_threads;
      static int pack_to_stdout;
    -+static int thin = 0;
    ++static int thin;
      static int num_preferred_base;
      static struct progress *progress_state;
      
