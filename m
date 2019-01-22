Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050B71F453
	for <e@80x24.org>; Tue, 22 Jan 2019 07:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfAVHH2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 02:07:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:43512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726981AbfAVHH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 02:07:28 -0500
Received: (qmail 5761 invoked by uid 109); 22 Jan 2019 07:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 07:07:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3366 invoked by uid 111); 22 Jan 2019 07:07:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 02:07:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 02:07:25 -0500
Date:   Tue, 22 Jan 2019 02:07:25 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/3] setup: do not use invalid `repository_format`
Message-ID: <20190122070725.GA28555@sigill.intra.peff.net>
References: <20190115193112.GE4886@sigill.intra.peff.net>
 <20190117063114.1901775-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190117063114.1901775-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 07:31:14AM +0100, Martin Ågren wrote:

> > I also get why read_repository_format() doing this in patch 3 would be a
> > problem:
> >
> >   +       if (format->version == -1) {
> >   +               clear_repository_format(format);
> >   +               format->version = -1;
> >   +       }
> >
> > but doesn't that point out that clear_repository_format() should be
> > setting hash_algo to GIT_HASH_SHA1 as the default (and likewise "bare =
> > -1", etc, that is done in that function)?
> 
> Something like the below on top of this series (then rebased). (The last
> hunk below is a revert of this patch.)

Yes, that's exactly what I had in mind. Usually our clear() functions
put the struct back into some default state from which it can be used
gain. But the state after clear() here (without the patch below) is
something that nobody is ever expected to look at.

Granted, the only function which fills it in is read_...(), and it sets
those defaults itself. But it just seems to me if we're going to have to
put _something_ in the struct to initialize or clear it, it might as
well be those.

> I'd like to think of the situation before this patch above as a
> situation where the API promises something and the user uses the API
> beyond that. The next patch in this series changes the internals of the
> API in a way that is consistent with the promise made, but which ends up
> affecting an over-eager user.

As with many parts of Git, there really isn't a clear promise. :) I
don't think you're wrong at all about the current state of things. I'm
mostly basing my comments on "what would I _expect_ the promise to be
based on our general patterns". If that's far from what we promise now,
then it's a hassle to convert. But I think it's actually pretty close.

> What this patch above does is to make the user do what the API promise
> allows them to do, i.e., no more shortcuts. What you're saying is, why
> isn't the promise stronger? So the user won't have to think as much?
> 
> So in particular, why doesn't `clear...()` and the error path in
> `read_...()` impose sane, usable defaults? My first concern is that it
> means we need to make a stronger promise, which might then be hard to
> back away from, if we want to. Maybe we'll never want to...

I'm not too worried about that personally. I think the more likely
problem is that the API is misunderstood and misused. ;)

> My second concern is, what should we be falling back to, going forward?
> At some point, the hash indicated by `REPOSITORY_FORMAT_INIT` will be
> SHA-256. Before that, and as soon as we support both hashes, what if we
> pick up SHA-256 before stumbling on some other piece of the config --
> should we now reset the struct to indicate SHA-1, or rather keep the
> SHA-256 value, which by itself is valid? (The same could be argued now,
> for something other than hash functions, but the SHA-1/256 example might
> be more obvious in the context of this patch.)

I'd think this would _always_ be sha-1. Because it's not about "what's
the default for this program running". It's about "what have I read from
this on-disk repo config". And the rule there is "if they don't say
otherwise, it is sha1". That won't change even in a sha256 world,
because we'll maintain backwards-compatibility with legacy repositories
forever.

Now if your next question is: "does any caller misuse this as more than
looking at the repo format", I don't know the answer for sure. That
would be worth poking at (or perhaps having just poked yourself, you
might have an idea already).

> My third worry is that we should then equip `clear_...()` or at least
> the error path of `read_...()` with some logic to keep "as much as
> possible" of what we've picked up and reset the rest, all the while
> making sure we don't end up with something self-contradicting or stupid.
> After all, we'll have promised the users that they can ignore any errors
> and just run ahead.

I think clear() should always throw everything away. Saving partial bits
from the error path of read() is harder. My gut says "no", but I agree
that's a trickier question. I think the real-world thing here is: we're
reading repo config and see an extensions.* field that says "use
sha256". But then we encounter an error, or don't otherwise have a
version. What do we do?

If that's an undefined setup (and I think it is -- if you're using
extensions.* you're supposed to always set the version field), then I
don't know that it really matters that much. But throwing the whole
thing away (even if it means a buggy code path is more likely to use
sha1) seems OK to me.

> Maybe I'm worrying way too much, and I shouldn't be so afraid of making
> a stronger promise here and now because of vague slippery-slope thinking.
> 
> Thanks for pushing back and forcing me to articulate my thinking.

For the record, I can live with it either way. There are so many funky
little setup corner cases in the code already, and we don't even really
have a real-world case to dissect at this point. So the right thing may
also just be to finish this patch series as quickly as possible and move
on to something more useful. :)

-Peff
