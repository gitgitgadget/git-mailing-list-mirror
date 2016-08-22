Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9F21F859
	for <e@80x24.org>; Mon, 22 Aug 2016 21:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756265AbcHVV5k (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 17:57:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:59283 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755787AbcHVV5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 17:57:38 -0400
Received: (qmail 29437 invoked by uid 109); 22 Aug 2016 21:57:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 21:57:29 +0000
Received: (qmail 17465 invoked by uid 111); 22 Aug 2016 21:57:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 17:57:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 17:57:26 -0400
Date:   Mon, 22 Aug 2016 17:57:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] tweaking the delta base cache
Message-ID: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the experiments I did with --depth=50 recently, I noticed there
seemed to be a lot of room for improvement in the delta-base-cache (and
in particular, there seemed to be a lack of actual numbers).

So I tried a series of experiments, and these are the tweaks I came up
with. There are a lot of numbers and analysis in the commit messages
themselves. The most dramatic effect I got was that before this patch,
bumping core.deltaBaseCacheLimit for the kernel gets you basically
nothing, whereas with it, I get:

  core.deltaBaseCacheLimit    time to run git log -Sfoo --raw
  ------------------------    -------------------------------
                      128m    4m56.486s
                      256m    4m33.769s
                      512m    4m12.968s
                     1024m    3m32.623s

Note that I don't actually propose bumping the memory limit in this
series. That's a bit more contentious, as it's really using more
resources to do a space/time tradeoff, and people may not want to spend
the RAM. Whereas this series just adjusts the actual data structures to
let us use the RAM we've already been allocated more efficiently.

The interesting changes are really patches 5 and 6, which adjust the LRU
management and the underlying hash structure.

There are a few ideas I thought of or saw in past threads but didn't
explore. I don't plan on digging further on them right now, so if
anybody else wants to do so, be my guest:

  - limiting the size of items entering the cache (e.g., to avoid a
    single giant blob blowing out all of the other entries)

  - something more clever than LRU, like weighting by a mix of size and
    recency

  - I didn't look at the criteria for adding entries to the cache at all

  - we seem to drop cache entries as we use them in unpack_entry(); I'm
    not sure if we would do better to retain them and let them leave via
    LRU expiration

So there may be more work, but I think these improvements stand on their
own.

  [1/7]: cache_or_unpack_entry: drop keep_cache parameter
  [2/7]: clear_delta_base_cache_entry: use a more descriptive name
  [3/7]: release_delta_base_cache: reuse existing detach function
  [4/7]: delta_base_cache: use list.h for LRU
  [5/7]: delta_base_cache: drop special treatment of blobs
  [6/7]: delta_base_cache: use hashmap.h
  [7/7]: t/perf: add basic perf tests for delta base cache

-Peff
