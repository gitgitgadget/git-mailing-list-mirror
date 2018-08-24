Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8021F404
	for <e@80x24.org>; Fri, 24 Aug 2018 20:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHYAaG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 20:30:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:55316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726928AbeHYAaG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 20:30:06 -0400
Received: (qmail 12713 invoked by uid 109); 24 Aug 2018 20:53:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 20:53:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31463 invoked by uid 111); 24 Aug 2018 20:53:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 Aug 2018 16:53:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2018 16:53:50 -0400
Date:   Fri, 24 Aug 2018 16:53:50 -0400
From:   Jeff King <peff@peff.net>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     git@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] excluding a function from coccinelle transformation
Message-ID: <20180824205349.GA31853@sigill.intra.peff.net>
References: <20180824064228.GA3183@sigill.intra.peff.net>
 <alpine.DEB.2.21.1808240652370.2344@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808240652370.2344@hadrien>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 07:04:27AM -0400, Julia Lawall wrote:

> On Fri, 24 Aug 2018, Jeff King wrote:
> 
> > In Git's Coccinelle patches, we sometimes want to suppress a
> > transformation inside a particular function. For example, in finding
> > conversions of hashcmp() to oidcmp(), we should not convert the call in
> > oidcmp() itself, since that would cause infinite recursion. We write the
> > semantic patch like this:
> >
> >   @@
> >   identifier f != oidcmp;
> >   expression E1, E2;
> >   @@
> >     f(...) {...
> >   - hashcmp(E1->hash, E2->hash)
> >   + oidcmp(E1, E2)
> >     ...}
> 
> The problem is with how how ... works.  For transformation, A ... B
> requires that B occur on every execution path starting with A, unless that
> execution path ends up in error handling code.
> (eg, if (...) { ... return; }).  Here your A is the start if the function.
> So you need a call to hashcmp on every path through the function, which
> fails when you add ifs.

Thank you! This explanation (and the one below about A and B not
appearing in the matched region) helped my understanding tremendously.

> What you want is what you ended up using, which is <... P ...> which
> allows zero or more occurrences of P.

And now this makes much more sense (I stumbled onto it through brute
force, but now I understand _why_ it works).

> However, this can all be very expensive, because you are matching paths
> through the function definition which you don't really care about.  All
> you care about here is the name.  So another approach is

Yeah, it is. Using the pre-1.0.7 version, the original patch runs in
~1.3 minutes on my machine. With "<... P ...>" it's almost 4 minutes.
Your python suggestion runs in about 1.5 minutes.

Curiously, 1.0.4 runs the original patch in only 24 seconds, and the
angle-bracket one takes 52 seconds. I'm not sure if something changed in
coccinelle, or if my build is simply less optimized (my 1.0.4 is from
the Debian package, and I'm building 1.0.7 from source; I had trouble
building 1.0.4 from source).

> @@
> position p : script:python() { p[0].current_element != "oldcmp" };
> expression E1,E2;
> @@
> 
> - hashcmp(E1->hash, E2->hash)
> + oidcmp(E1, E2)

Aha, this is exactly the magic I was hoping for. I agree this is the
best way to express it. I just had to tweak the patch to include the
position:

  - hashcmp@p(E1->hash, E2->hash)

and it worked great. Unfortunately, Debian's spatch is not built with
python support. :(

I'm not sure if we (the Git project) want to make the jump to requiring
a more specific spatch. OTOH, only a handful of developers actually run
it, and the python support does seem quite useful. And 1.0.4 is rather
old at this point.

Again, thanks very much for your response. I have a much better
understanding of what's going on now, and what our options are for
moving forward.

-Peff
