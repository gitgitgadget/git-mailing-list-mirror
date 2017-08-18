Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92111F667
	for <e@80x24.org>; Fri, 18 Aug 2017 06:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdHRGxg (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 02:53:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:42448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750729AbdHRGxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 02:53:36 -0400
Received: (qmail 22607 invoked by uid 109); 18 Aug 2017 06:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 06:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32722 invoked by uid 111); 18 Aug 2017 06:54:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 02:54:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 02:53:34 -0400
Date:   Fri, 18 Aug 2017 02:53:34 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: ignoring extra bitmap file?
Message-ID: <20170818065333.7povtg6b4sugnnfg@sigill.intra.peff.net>
References: <20170817192436.GA4782@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170817192436.GA4782@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 09:24:36PM +0200, Andreas Krey wrote:

> I'm seeing the message
> 
>    remote: warning: ignoring extra bitmap file: ./objects/pack/pack-2943dc24....pack
> 
> and indeed, there is such a thing (two, actually):

Only one is the extra. :) The other is doing something useful.

Basically, the bitmap code was written to a handle a single bitmap file.
It would be possible to handle multiple, but it simplified the
implementation greatly to only handle one. And in practice, since a
bitmap can only be made for a pack which contains all of the reachable
objects, you'd have only one bitmap per repo, for the one big "main"
pack.

> But it looks like something went wrong in that repack cycle (that
> pack-2943dc247702 is the full repo), and it won't get removed later
> in the next repack in the evening.

Yes, it looks like you got a full repack that failed to remove the old
pack. Or more likely you had two full repacks racing with each other,
each creating a new big pack.

So the extra bitmap here is harmless. Both of them contain more or less
the same data, and whichever one we use will be fine (and remember that
the .bitmap files are purely an optimization, so that "more or less"
will only make a minor impact on the speed of operations, not on the
output).

> Question: Can I safely remove the .bitmap file, and repack will then
> clean up the .pack and .idx files as will?

Yes, it's always safe to remove a .bitmap file (though if you remove the
last one, you may expect performance to drop for some operations).

Whether there's a .bitmap doesn't impact whether .pack and .idx files
are deleted. The next full repack would pack everything into a new big
pack, and then delete any existing files, including .pack, .idx, and
.bitmap.

-Peff
