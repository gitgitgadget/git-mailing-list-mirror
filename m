Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63A31F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 09:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbdKLJ7O (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 04:59:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:53760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750723AbdKLJ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 04:59:13 -0500
Received: (qmail 18055 invoked by uid 109); 12 Nov 2017 09:59:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 09:59:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13545 invoked by uid 111); 12 Nov 2017 09:59:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 04:59:25 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 09:59:10 +0000
Date:   Sun, 12 Nov 2017 09:59:10 +0000
From:   Jeff King <peff@peff.net>
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git@vger.kernel.org, olyatelezhnaya@gmail.com
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20171112095910.xwz43bzfbr5hz3tq@sigill.intra.peff.net>
References: <1510423606-9616-1-git-send-email-gs051095@gmail.com>
 <20171112095435.f4o662ygtt2taf5y@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171112095435.f4o662ygtt2taf5y@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 09:54:35AM +0000, Jeff King wrote:

> > @@ -1566,6 +1566,7 @@ struct pack_window {
> >  
> >  extern struct packed_git {
> >  	struct packed_git *next;
> > +	struct list_head mru;
> >  	struct pack_window *windows;
> >  	off_t pack_size;
> >  	const void *index_data;
> 
> Sort of a side note, but seeing these two list pointers together makes
> me wonder what we should do with the list created by the "next" pointer.
> It seems like there are three options:
> 
>   1. Convert it to "struct list_head", too, for consistency.
> 
>   2. Leave it as-is. We never delete from the list nor do any fancy
>      manipulation, so it doesn't benefit from the reusable code.
> 
>   3. I wonder if we could drop it entirely, and just keep a single list
>      of packs, ordered by mru. I'm not sure if anybody actually cares
>      about accessing them in the "original" order. That order is
>      reverse-chronological (by prepare_packed_git()), but I think that
>      was mostly out of a sense that recent packs would be accessed more
>      than older ones (but having a real mru strategy replaces that
>      anyway).
> 
> What do you think?

Thinking on this a bit more, even if we want to go down any road except
(2), it probably ought to come as a separate patch on top anyway. The
changes you're making here are quite obviously a noop for visible
behavior.

But dropping the "next" pointer (and the matching "don't clear the list"
I mentioned later) would potentially mean examining the packs in a
slightly different order. I _think_ that's fine, but it's possible there
could be a subtle fallout. So it's better to keep it separate from the
more pure refactoring in your patch.

-Peff
