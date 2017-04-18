Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13EE6201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 17:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757854AbdDRRuP (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:50:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:35455 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753042AbdDRRuO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:50:14 -0400
Received: (qmail 29810 invoked by uid 109); 18 Apr 2017 17:50:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 17:50:13 +0000
Received: (qmail 14491 invoked by uid 111); 18 Apr 2017 17:50:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 13:50:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 13:50:11 -0400
Date:   Tue, 18 Apr 2017 13:50:11 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH] repack: respect gc.pid lock
Message-ID: <20170418175011.qx64luolrvqwwtpa@sigill.intra.peff.net>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
 <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
 <2400e9cbfaff4838a8f3b23c4c2c5a22@exmbdft7.ad.twosigma.com>
 <20170418171930.zad5wrbu5rvdsmg5@sigill.intra.peff.net>
 <710ded65bb8843ab838d9c52cd796317@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <710ded65bb8843ab838d9c52cd796317@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 05:43:29PM +0000, David Turner wrote:

> > A lock can catch the racy cases where both run at the same time. But I think that
> > even:
> > 
> >   git -c repack.writeBitmaps=true repack -Ad
> >   [...wait...]
> >   git gc
> > 
> > is questionable, because that gc will erase your bitmaps. How does git-gc know
> > that it's doing a bad thing by repacking without bitmaps, and that you didn't
> > simply change your configuration or want to get rid of them?
> 
> Sorry, the gc in Gitlab does keep bitmaps.  The one I quoted in a previous 
> message  doesn't, because the person typing the command was just doing some 
> manual  testing and I guess didn't realize that bitmaps were important.  Or 
> perhaps he knew that repack.writeBitmaps was already set in the config.

Sure, but I guess I'd just wonder what _else_ is different between the
commands (and if nothing, why are both running).

> So given that the lock will catch the races, might it be a good idea (if 
> Implemented to avoid locking on repack -d)?

I'm mildly negative just because it increases complexity, and I don't
think it's actually buying very much. It's not clear to me which
invocations of repack would want to lock and which ones wouldn't.

Is "-a" or "-A" the key factor? Are there current callers who prefer the
current behavior of "possibly duplicate some work, but never report
failure" versus "do not duplicate work, but sometimes fail due to lock
contention"?

-Peff
