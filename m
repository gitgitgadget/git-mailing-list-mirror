Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0E3C433F5
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 05:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C3361151
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 05:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbhIYFut (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 01:50:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:55150 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhIYFus (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 01:50:48 -0400
Received: (qmail 21139 invoked by uid 109); 25 Sep 2021 05:49:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Sep 2021 05:49:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17788 invoked by uid 111); 25 Sep 2021 05:49:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Sep 2021 01:49:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Sep 2021 01:49:13 -0400
From:   Jeff King <peff@peff.net>
To:     Greywolf <greywolf@starwolf.com>
Cc:     git@vger.kernel.org
Subject: Re: ANSI sequences produced on non-ANSI terminal
Message-ID: <YU64WQOg/zY7P+Gh@coredump.intra.peff.net>
References: <20210923052122.2F655CE@eddie.starwolf.com>
 <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <592a799b-0d16-1615-4737-3c634d029d7f@starwolf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <592a799b-0d16-1615-4737-3c634d029d7f@starwolf.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 04:57:11PM -0700, Greywolf wrote:

> On 9/23/2021 14:20, Jeff King wrote:
> 
> > Git doesn't have any kind of list of terminals, beyond knowing that "dumb"
> > should disable auto-color. It's possible we could expand that if there are
> > known terminals that don't understand ANSI colors. I'm a bit wary of having
> > a laundry list of obscure terminals, though.
> 
> Oh, gods, I wouldn't have that at all!  No, I just want it NOT to spit out
> not only the colour codes, but the cursor positioning codes as it seems
> wont to do when I do a fetch.  I'm more than happy to turn coloring off
> (conditional on TERM would be a bonus, however it's done) on my own;
> in fact, I have done so, but the fetch/pull still seem to be messing up
> my screen, with color turned off (unless I'm not turning it off
> *enough*, which is entirely possible).

OK, that makes things a bit easier. The colors, as you noticed, can be
disabled by config. The other thing you're seeing is ANSI ESC[K, which
is used to clear to the end of line. We use this in a couple places,
notably when relaying progress lines from the server (with the "remote:"
prefix) which may use carriage-returns to overwrite lines.

See ebe8fa738d (fix display overlap between remote and local progress,
2007-11-04) if you're really interested.

Anyway, there's no config option to disable that. However, we do disable
it if TERM is empty or set to "dumb" (and instead just write some extra
spaces to clear out the line). So that may be an option, though of
course setting TERM=dumb may affect other programs you use.

I don't think it would be unreasonable to have a config option to
select whether we use the ANSI or dumb-term version.

> > If we built against ncurses or some other terminfo-aware library we could
> > outsource that, but that would be a new dependency. I'm hesitant to do that
> > even as an optional dependency given the bang-for-the-buck (and certainly
> > making it require would be right out).
> 
> Well understood.  Also, not asking for people to jump thru flaming hoops.
> Just trying to figure out how to get git to stop assuming things.
> (as stated, I am aware it could be my fault for not setting variables
> properly all the way).

Nah, it sounds like you actually set the variables correctly. We've just
assumed that we can get by with ANSI codes as a lowest common
denominator in the modern world, without having to resort to all the
complexities of using a terminfo library. It's worked pretty well so
far. ;)

-Peff
