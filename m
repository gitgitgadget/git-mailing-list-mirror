Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5BED1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfJ3UhQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:37:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:34270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726527AbfJ3UhP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:37:15 -0400
Received: (qmail 28974 invoked by uid 109); 30 Oct 2019 20:37:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Oct 2019 20:37:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23691 invoked by uid 111); 30 Oct 2019 20:40:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Oct 2019 16:40:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Oct 2019 16:37:14 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Holmberg <simon.holmberg@avalanchestudios.se>
Cc:     git@vger.kernel.org
Subject: Re: Partial Clone garbage collection?
Message-ID: <20191030203714.GC29013@sigill.intra.peff.net>
References: <CA+M_GG35V3yNCfQ247PSrpP-R_f8bWNcBcmrnTWbrn1Nap_A4A@mail.gmail.com>
 <CA+M_GG1SfxGW=p_=418hdR1ypB3v-4GrooK6_75UUNJDb+kk2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+M_GG1SfxGW=p_=418hdR1ypB3v-4GrooK6_75UUNJDb+kk2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 06:08:18PM +0100, Simon Holmberg wrote:

> I've been experimenting with the new Partial Clone feature, attempting
> to use it to filter out the otherwise full history of the large binary
> resources in our repos. It works really well on the initial clone. But
> once you start jumping around in history a lot, the repo will grow out
> of proportion again as promised pack files are fetched.
> 
> Are there any plans to add a --filter parameter to git gc as well,
> that would be able to prune past history of objects and convert them
> back into pack promises? Or am I wrong in assuming that this could
> ever act as a native replacement for LFS? Without this, a repo would
> only continue to grow ad infinitum, resulting in the same issues as
> before unless you actively chose to delete your entire clone and
> re-clone it from upstream once in a while.

I don't recall seeing anybody actively working on this, but I think it
would be a good idea. You'd probably want to be able to specify it in
your config somehow, so that subsequent repacks pruned as necessary
without you having to remember to do it each time.

You could naively just drop everything that matches the filter, and then
re-fetch it as needed. But for efficiency, you may want to keep some
other objects:

  - objects mentioned directly in the index, or the tree of HEAD; you'd
    end up re-fetching these next time you "git checkout"

  - perhaps objects fetched recently are more worth keeping (e.g., ones
    with an mtime less than a day or two). I don't know if that helps,
    though. What you really care about is how recently they were
    accessed (assuming there's some locality there), not written. A
    frequently-accessed object may have been fetched immediately after
    you cloned, giving it an old mtime.

    Since we can get any of the objects again if we want and we're just
    optimizing, this is really just a cache-expiration problem. But it
    may be hard to implement any of the stock algorithms without having
    logs of which objects were accessed.

-Peff
