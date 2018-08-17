Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF441F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeHQX7W (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 19:59:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:59254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728332AbeHQX7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 19:59:22 -0400
Received: (qmail 8749 invoked by uid 109); 17 Aug 2018 20:54:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 20:54:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28414 invoked by uid 111); 17 Aug 2018 20:54:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 16:54:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 16:54:27 -0400
Date:   Fri, 17 Aug 2018 16:54:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] reuse on-disk deltas for fetches with bitmaps
Message-ID: <20180817205427.GA19580@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series more aggressively reuses on-disk deltas to serve fetches
when reachability bitmaps tell us a more complete picture of what the
client has. That saves server CPU and results in smaller packs. See the
final patch for numbers and more discussion.

It's a resurrection of this very old series:

  https://public-inbox.org/git/20140326072215.GA31739@sigill.intra.peff.net/

The core idea is good, but it got left as "I should dig into this more
to see if we can do even better". In fact, I _did_ do some of that
digging, as you can see in the thread, so I'm mildly embarrassed not to
have reposted it before now.

We've been using that original at GitHub since 2014, which I think helps
demonstrate the correctness of the approach (and the numbers here and in
that thread show that performance is generally a net win over the status
quo).

I's rebased on top of the current master, since the original made some
assumptions about struct object_entry that are no longer true post-v2.18
(due to the struct-shrinking exercise). So I fixed that and a few other
rough edges. But that also means you're not getting code with 4-years of
production testing behind it. :)

The other really ugly thing in the original was the way it leaked
object_entry structs (though in practice that didn't really matter since
we needed them until the end of the program anyway). This version fixes
that.

  [1/6]: t/perf: factor boilerplate out of test_perf
  [2/6]: t/perf: factor out percent calculations
  [3/6]: t/perf: add infrastructure for measuring sizes
  [4/6]: t/perf: add perf tests for fetches from a bitmapped server
  [5/6]: pack-bitmap: save "have" bitmap from walk
  [6/6]: pack-objects: reuse on-disk deltas for thin "have" objects

 builtin/pack-objects.c             | 28 +++++++----
 pack-bitmap.c                      | 23 +++++++++-
 pack-bitmap.h                      |  7 +++
 pack-objects.c                     | 19 ++++++++
 pack-objects.h                     | 20 +++++++-
 t/perf/README                      | 25 ++++++++++
 t/perf/aggregate.perl              | 69 ++++++++++++++++++++++------
 t/perf/p5311-pack-bitmaps-fetch.sh | 45 ++++++++++++++++++
 t/perf/perf-lib.sh                 | 74 +++++++++++++++++++-----------
 9 files changed, 258 insertions(+), 52 deletions(-)
 create mode 100755 t/perf/p5311-pack-bitmaps-fetch.sh

-Peff
