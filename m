Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EACB51F576
	for <e@80x24.org>; Sat,  3 Feb 2018 09:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBCJ2O (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 04:28:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:38960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750860AbeBCJ2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 04:28:09 -0500
Received: (qmail 13999 invoked by uid 109); 3 Feb 2018 09:28:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Feb 2018 09:28:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25448 invoked by uid 111); 3 Feb 2018 09:28:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Feb 2018 04:28:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Feb 2018 04:28:07 -0500
Date:   Sat, 3 Feb 2018 04:28:07 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>, szeder.dev@gmail.com
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
Message-ID: <20180203092806.GA25927@sigill.intra.peff.net>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
 <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
 <CAGZ79kb8kHAb6HYrxY_oMq5v3p1+AHX_ad40nwUEwiDKe=i+Ng@mail.gmail.com>
 <xmqq607fc8j8.fsf@gitster-ct.c.googlers.com>
 <25571438-bdb1-81ce-ac5e-18dd0b6292d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25571438-bdb1-81ce-ac5e-18dd0b6292d5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 02, 2018 at 08:58:52PM -0500, Derrick Stolee wrote:

> I don't think pairing this with pack-objects or index-pack is a good
> direction, because the commit graph is not locked into a packfile the way
> the bitmap is. In fact, the entire ODB could be replaced independently and
> the graph is still valid (the commits in the graph may no longer have their
> paired commits in the ODB due to a GC; you should never navigate to those
> commits without having a ref pointing to them, so this is not immediately a
> problem).

One advantage of tying this to packs is that you can piggy-back on the
.idx to avoid storing object ids a second time. If we imagine that you
use a 32-bit index into the .idx instead, that's a savings of 16 bytes
per object (or more when we switch to a longer hash). You only need to
refer to commits and their root trees, though. So on something like
linux.git, you're talking about 2 * 700k * 16 = 21 megabytes you could
save.

That may not be worth worrying about too much, compared to the size of
the rest of the data. Disk space is obviously cheap, but I'm more
concerned about working-set size. However, 21 megabytes probably isn't
breaking the bank there these days (and it may even be faster, since the
commit-graph lookups can use the more compact index that contains only
commits, not other objects).

The big advantage of your scheme is that you can update the graph index
without repacking. The traditional advice has been that you should
always do a full repack during a gc (since it gives the most delta
opportunities). So metadata like reachability bitmaps were happy to tied
to packs, since you're repacking anyway during a gc. But my
understanding is that this doesn't really fly with the Windows
repository, where it's simply so big that you never obtain a single
pack, and just pass around slices of history in pack format.

So I think I'm OK with the direction here of keeping metadata caches
separate from the pack storage.

> This sort of interaction with GC is one reason why I did not include the
> automatic updates in this patch. The integration with existing maintenance
> tasks will be worth discussion in its own right. I'd rather demonstrate the
> value of having a graph (even if it is currently maintained manually) and
> then follow up with a focus to integrate with repack, gc, etc.
> 
> I plan to clean up this patch on Monday given the feedback I received the
> last two days (Thanks Jonathan and Szeder!). However, if the current builtin
> design will block merging, then I'll wait until we can find one that works.

If they're not tied to packs, then I think having a separate builtin
like this is the best approach. It gives you a plumbing command to
experiment with, and it can easily be called from git-gc.

-Peff
