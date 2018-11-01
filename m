Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB3A1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 18:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKBDjV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 23:39:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:36760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726017AbeKBDjV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 23:39:21 -0400
Received: (qmail 32215 invoked by uid 109); 1 Nov 2018 18:35:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Nov 2018 18:35:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27067 invoked by uid 111); 1 Nov 2018 18:34:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Nov 2018 14:34:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Nov 2018 14:35:12 -0400
Date:   Thu, 1 Nov 2018 14:35:12 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jon Simons <jon@jonsimons.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [BUG?] protocol.version=2 sends HTTP "Expect" headers
Message-ID: <20181101183511.GA32547@sigill.intra.peff.net>
References: <20181031160353.GA17267@sigill.intra.peff.net>
 <20181101004803.GA731755@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101004803.GA731755@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 01, 2018 at 12:48:04AM +0000, brian m. carlson wrote:

> > So a few questions:
> > 
> >   - is this a bug or not? I.e., do we still need to care about proxies
> >     that can't handle Expect? The original commit was from 2011. Maybe
> >     things are better now. Or maybe that's blind optimism.
> > 
> >     Nobody has complained yet, but that's probably just because v2 isn't
> >     widely deployed yet.
> 
> HTTP/1.1 requires support for 100 Continue on the server side and in
> proxies (it is mandatory to implement).  The original commit disabling
> it (959dfcf42f ("smart-http: Really never use Expect: 100-continue",
> 2011-03-14)), describes proxies as the reason for disabling it.
> 
> It's my understanding that all major proxies (including, as of version
> 3.2, Squid) support HTTP/1.1 at this point.  Moreover, Kerberos is more
> likely to be used in enterprises, where proxies (especially poorly
> behaved and outright broken proxies) are more common.  We haven't seen
> any complaints about Kerberos support in a long time.  This leads me to
> believe that things generally work[0].

Rooting around in the archive a bit, I found this discussion:

  https://public-inbox.org/git/CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com/

The original motivation for 959dfcf42f was apparently Google's own
servers. And they are likely the biggest users of the v2 protocol
(since my impression is that Google ships a modified client to most of
their devs that flips the v2 switch). So if they're not having problems,
maybe that's a sign that this is a non-issue.

> Finally, modern versions of libcurl also have a timeout after which they
> assume that the server is not going to respond and just send the request
> body anyways.  This makes the issue mostly moot.

I think this was always the case. It's just that it introduced annoying
stalls into the protocol.

> >   - alternatively, should we just leave it on for v2, and provide a
> >     config switch to disable it if you have a crappy proxy? I don't know
> >     how widespread the problem is, but I can imagine that the issue is
> >     subtle enough that most users wouldn't even know.
> 
> For the reasons I mentioned above, I'd leave it on for now.  Between
> libcurl and better proxy support, I think this issue is mostly solved.
> If we need to fix it in the future, we can, and people can fall back to
> older protocols via config in the interim.

OK. If nobody is complaining, this seems like a good way to ease into
the migration. I.e., if we dropped the old "suppress Expect headers"
code, people might complain that things are now broken. But if it
gradually follows the v2 adoptions, that's a bit more of a gentle curve
(well, until we hit the cliff where we switch the default to trying v2).

-Peff
