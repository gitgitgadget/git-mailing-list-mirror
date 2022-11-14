Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836D3C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiKNWkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiKNWkW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:40:22 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CCE17401
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:40:21 -0800 (PST)
Received: (qmail 15553 invoked by uid 109); 14 Nov 2022 22:40:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Nov 2022 22:40:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14689 invoked by uid 111); 14 Nov 2022 22:40:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Nov 2022 17:40:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Nov 2022 17:40:20 -0500
From:   Jeff King <peff@peff.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify that credential discards unrecognised
 attributes
Message-ID: <Y3LD1Ilq8kLPlJMO@coredump.intra.peff.net>
References: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
 <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
 <CAGJzqsmH0DpEZDVZYU=6XpBO_vPfbirrK7KaWm2RmKG3aAk0oA@mail.gmail.com>
 <Y2/OIrSz+xrqkd+C@coredump.intra.peff.net>
 <CAGJzqsnd3UbCuj6xfsAgVEFz5OaDBhnCTNeAvOVPK9NWBDnDRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsnd3UbCuj6xfsAgVEFz5OaDBhnCTNeAvOVPK9NWBDnDRA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 07:08:42PM +0000, M Hickford wrote:

> On Sat, 12 Nov 2022 at 16:47, Jeff King <peff@peff.net> wrote:
> > > > We did discuss patches a long time ago that would let Git carry
> > > > arbitrary keys between helpers, even if Git itself didn't understand it.
> > > > One of the intended uses was to let helpers talk to each other about
> > > > TTLs. So if you had say:
> > > >
> > > >   [credential]
> > > >   helper = generate-some-token
> > > >   helper = cache
> > > >
> > > > where the first helper generates a token, and the second caches it, the
> > > > first one could shove a "ttl" or "expiration" key into the protocol,
> > > > which the cache could then learn to respect.
> > >
> >
> > What you're doing works fine with the code as-is; you just can't carry
> > extra data (like a ttl) between the two.
> 
> FWIW I have a draft patch that adds password_expiry_utc and
> oauth_refresh_token attributes to credential
> https://github.com/gitgitgadget/git/pull/1394 introducing expiry logic
> in the credential layer. I'll share a RFC sometime in future.

Neat.

I'm not _totally_ opposed to introducing these as something Git
understands, but I think it makes more sense to just teach Git to relay
unknown entries between helpers.

The oauth thing is going to be very helper specific, and not something I
think Git would ever do anything with itself.

In theory Git might care about expiration, but in practice I think it
doesn't. It's very unlikely for a token to expire in the course of Git
using it. It's only much later, when we ask for it back, that a helper
will notice it's expired. Git could save the helper some work by
noticing this on read, but since the helper has to learn to store and
report the expiration in the first place, not much is gained.

And in the case of something like credential-cache, we want to do more
than just store; we'd actually drop the credential entirely (and maybe
even cause the daemon to exit) if it expires before the usual timeout.

-Peff
