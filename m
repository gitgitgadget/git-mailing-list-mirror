Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F3E20401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdFNJvU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:51:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:39887 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbdFNJu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:50:26 -0400
Received: (qmail 15673 invoked by uid 109); 14 Jun 2017 09:50:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 09:50:25 +0000
Received: (qmail 10060 invoked by uid 111); 14 Jun 2017 09:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:50:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 05:50:23 -0400
Date:   Wed, 14 Jun 2017 05:50:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170614095023.nzu535pv6cluzdz7@sigill.intra.peff.net>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com>
 <20170614004816.GR133952@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170614004816.GR133952@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 05:48:16PM -0700, Jonathan Nieder wrote:

> > The reason for this is that the initial fetch is not a fully fledged
> > 'git fetch' but a bunch of direct calls into the fetch/transport
> > machinery with clone's own refs-to-refspec matching logic, which
> > bypasses parts of 'git fetch' processing configured fetch refspecs.
> 
> Agh, subtle.
> 
> I'm hoping that longer term we can make fetch behave more like a
> library and make the initial fetch into a fully fledged 'git fetch'
> like thing again.  But this smaller change is the logical fix in the
> meantime.

We talked about this earlier in the thread, but I doubt that will ever
happen. Things like --single-branch means that clone has to actually
look at what the remote has before it decides what to fetch.

Of course we _could_ teach all that logic to fetch, too, but I don't
think you'll ever get the nice simple:

  1. configure refspecs
  2. fetch
  3. checkout

So the best thing is probably to push any repeated logic down into the
transport layer, where it can be easily used by both commands.

> > +	/* Not free_refspecs(), as we copied its pointers above */
> > +	free(rs);
> 
> Allocating an array to put the parsed refspec in and then freeing it
> seems wasteful.  Should parse_refspec_internal be changed to take an
> output parameter so it can put the refspec into remote->fetch
> directly?

It's not quite trivial to make that change. parse_refspec_internal()
actually handles an array of refspecs. So its callers would all have to
start allocating the correctly-sized array.

I doubt that one malloc per clone is worth caring about. I'd worry more
about the trickiness that merited the comment above, but it's at least
contained in this one function.

-Peff
