Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1796E1F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 07:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeFAHE7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 03:04:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:58962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750750AbeFAHE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 03:04:58 -0400
Received: (qmail 12778 invoked by uid 109); 1 Jun 2018 07:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Jun 2018 07:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21846 invoked by uid 111); 1 Jun 2018 07:05:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 03:05:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 03:04:56 -0400
Date:   Fri, 1 Jun 2018 03:04:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] git gc "--prune=now" semantics considered harmful
Message-ID: <20180601070456.GB15578@sigill.intra.peff.net>
References: <alpine.LFD.2.21.999.1805261449160.6211@i7.lan>
 <xmqqd0xim1tp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0xim1tp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 27, 2018 at 08:31:14AM +0900, Junio C Hamano wrote:

> > So I actually would much prefer that foir git gc, "--prune=now" means
> >
> >  (a) "now"
> >
> >  (b) now at the _start_ of the "git gc" operation, not the time at
> >      the _end_ of the operation when we've already spent a minute or
> >      two doing repacking and are now doing the final pruning.
> >
> > anyway, with that explanation in mind, I'm appending a patch that is 
> > pretty small and does that. It's a bit hacky, but I think it still makes 
> > sense.
> >
> > Comments?
> 
> Closing the possiblity of racing a running "gc" and new object
> creation like the above generally makes sense, I would think,
> whether the creation is due to 'pull/fetch', 'add', or even 'push'.

I think Linus's suggestion is an obvious improvement. It does shorten
the window for confusing things to happen, and I think it makes things
much easier to reason about if all parts of the gc are using the same
timestamp.

Regarding the implementation:

> > -	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
> > -		die(_("failed to parse prune expiry value %s"), prune_expire);
> > +	if (prune_expire) {
> > +		if (!strcmp(prune_expire, "now"))
> > +			prune_expire = show_date(time(NULL), 0, DATE_MODE(ISO8601));
> > +		if (parse_expiry_date(prune_expire, &dummy))
> > +			die(_("failed to parse prune expiry value %s"), prune_expire);
> > +	}

We'd also accept relative times like "5.minutes.ago" (in fact, the
default is a relative 2.weeks.ago, though it's long enough that the
difference between "2 weeks" and "2 weeks plus 5 minutes" may not matter
much). So we probably ought to just normalize _everything_ without even
bothering to match "now". It's a noop for non-relative times, but that's
OK.

> I however have to wonder if there are opposite "oops" end-user
> operation we also need to worry about, i.e. we are doing a large-ish
> fetch, and get bored and run a gc fron another terminal.  Perhaps
> *that* is a bit too stupid to worry about?  Auto-gc deliberately
> does not use 'now' because it wants to leave a grace period to avoid
> exactly that kind of race.

There are still possibilities for a race, even with the grace period.
You can have an unreferenced 2-week-old object sitting on disk, and
somebody can choose to reference it at the same time as we are pruning
it. My freshness patches from a few years ago made things a bit better:

  - when we optimize out the write of an existing object, we now at
    least update its timestamp

  - we consider non-fresh objects reachable from fresh ones to also be
    fresh

But fundamentally none of this is atomic. You can have an old tree, and
while you're pruning somebody writes a new commit referencing it and
sticks that in a ref. It's more common if your grace period is "now",
but it can still happen with any grace period.

-Peff
