Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65FC201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 16:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdKLQQV (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 11:16:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:54072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751360AbdKLQQU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 11:16:20 -0500
Received: (qmail 6564 invoked by uid 109); 12 Nov 2017 16:16:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 16:16:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15929 invoked by uid 111); 12 Nov 2017 16:16:32 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 11:16:32 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 16:16:18 +0000
Date:   Sun, 12 Nov 2017 16:16:18 +0000
From:   Jeff King <peff@peff.net>
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20171112161617.fhysws3idztguu23@sigill.intra.peff.net>
References: <1510423606-9616-1-git-send-email-gs051095@gmail.com>
 <20171112095435.f4o662ygtt2taf5y@sigill.intra.peff.net>
 <CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 12:49:17PM +0000, Gargi Sharma wrote:

> > Sort of a side note, but seeing these two list pointers together makes
> > me wonder what we should do with the list created by the "next" pointer.
> > It seems like there are three options:
> >
> >   1. Convert it to "struct list_head", too, for consistency.
> >
> >   2. Leave it as-is. We never delete from the list nor do any fancy
> >      manipulation, so it doesn't benefit from the reusable code.
> >
> >   3. I wonder if we could drop it entirely, and just keep a single list
> >      of packs, ordered by mru. I'm not sure if anybody actually cares
> >      about accessing them in the "original" order. That order is
> >      reverse-chronological (by prepare_packed_git()), but I think that
> >      was mostly out of a sense that recent packs would be accessed more
> >      than older ones (but having a real mru strategy replaces that
> >      anyway).
> >
> > What do you think?
> I think in the long run, it'll be easier if there is only a single
> list of packs given
> that no one needs to access the list in order.

Yeah, it's that "given..." that makes me just a little nervous that I'm
missing something.

> If we go down road 1/3, would it be better if I sent an entirely
> different patch or
> a patch series with patch 1 as removing mru[.ch] and patch 2 as removing
> next pointer from the struct?

I think you could do it as a 2-patch series like that, or you could send
the first patch now (since I think it stands on its own merits) and do
the other one later on top.

> > This matches the original code, which did the clear/re-create, resetting
> > the mru to the "original" pack order. But I do wonder if that's actually
> > necessary. Could we skip that and just add any new packs to the list?
> 
> But if we do not clear the older entries from the list, wouldn't there be a
> problem when you access packed_git_mru->next, since that will be populated
> instead of being empty? Or am I misunderstanding something here?

What I mean is that instead of clearing and re-adding all of the packs
(including any new ones we picked up by rescanning the directory), we
would _just_ add new ones to the list.

So I think we'd scrap this whole "set up the mru" preparation here and
just teach install_packed_git() to add the new pack to the MRU list.

-Peff
