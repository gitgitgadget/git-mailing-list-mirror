Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73EE91F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392159AbeHPS4h (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:56:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:57648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392156AbeHPS4g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:56:36 -0400
Received: (qmail 6652 invoked by uid 109); 16 Aug 2018 15:57:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 15:57:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16674 invoked by uid 111); 16 Aug 2018 15:57:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 11:57:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 11:57:14 -0400
Date:   Thu, 16 Aug 2018 11:57:14 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180816155714.GA22739@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 08:54:25AM +0200, Ulrich Windl wrote:

> I'd like to point out some minor issue observed while processing some
> 50000-object repository with many binary objects, but most are rather
> small:
> 
> Between the two phases of "git fsck" (checking directories and
> checking objects) there was a break of several seconds where no
> progress was indicated.
> 
> During "git gc" the writing objects phase did not update for some
> seconds, but then the percentage counter jumped like from 15% to 42%.
> 
> I understand that updating the progress output too often can be a
> performance bottleneck, while upating it too rarely might only bore
> the user... ;-)

We update the counter integer for every object we process, and then
actually update the display whenever the percentage increases or a
second has elapsed, whichever comes first.

What you're seeing is likely an artifact of _what_ we're counting:
written objects. Not all objects are the same size, so it's not uncommon
to see thousands/sec when dealing with small ones, and then several
seconds for one giant blob.

The only way to solve that is to count bytes. We don't have a total byte
count in most cases, and it wouldn't always make sense (e.g., the
"Compressing objects" meter can show the same issue, but it's not really
putting through bytes in a linear way).  In some cases we do show
transmitted size and throughput, but that's just for network operations.
We could do the same for "gc" with the patch below. But usually
throughput isn't all that interesting for a filesystem write, because
bandwidth isn't the bottleneck.

Possibly we could have a "half throughput" mode that counts up the total
size written, but omits the speed indicator. That's not an unreasonable
thing to show for a local pack, since you end up with the final pack
size. The object counter would still be jumpy, but you'd at least have
one number updated at least once per second as you put through a large
blob.

If you really want a smooth percentage, then we'd have to start counting
bytes instead of objects. Two reasons we don't do that are:

  - we often don't know the total byte size exactly. E.g., for a
    packfile write, it depends on the result of deflating each object.
    You can make an approximation and just pretend at the end that you
    hit 100%.  Or you can count the pre-deflate sizes, but then your
    meter doesn't match the bytes from the throughput counter.

  - for something like fsck, we're not actually writing out bytes.  So I
    guess you'd be measuring "here's how many bytes of objects I
    fsck-ed". But is that on-disk compressed bytes, or decompressed
    bytes?

    If the former, that's only marginally better as a measure of effort,
    since delta compression means that a small number of on-disk bytes
    may require a big effort (imagine processing a 100 byte blob versus
    a 100 byte delta off of a 100MB blob).

    The latter is probably more accurate. But it's also not free to
    pre-generate the total. We can get the number of objects or the size
    of the packfile in constant-time, but totaling up the uncompressed
    size of all objects is O(n). So that's extra computation, but it
    also means a potential lag before we can start the progress meter.

    I'm also not sure how meaningful a byte count is for a user there.

So there. That's probably more than you wanted to know about Git's
progress code. I think it probably _could_ be improved by counting
more/different things, but I also think it can be a bit of a rabbit
hole. Which is why AFAIK nobody's really looked too seriously into
changing it.

-Peff
