Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28DE20357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754181AbdGNPaT (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:30:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754076AbdGNPaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 11:30:19 -0400
Received: (qmail 24512 invoked by uid 109); 14 Jul 2017 15:30:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 15:30:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12116 invoked by uid 111); 14 Jul 2017 15:30:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 11:30:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 11:30:16 -0400
Date:   Fri, 14 Jul 2017 11:30:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix regression: CamelCased aliases
Message-ID: <20170714153015.crklfqaa2qc573zo@sigill.intra.peff.net>
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
 <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net>
 <xmqq60evrqyd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60evrqyd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 08:14:18AM -0700, Junio C Hamano wrote:

> >> It was possible before v2.13.3 to invoke:
> >> 
> >> 	git config alias.CamelCased <something>
> >> 	git CamelCased
> >> 
> >> This regressed (due to a stupid mistake of mine that was not caught in
> >> patch review, sadly) in v2.13.3.
> >
> > Interesting. I don't think this was ever intended to work.
> > ...
> > The patches look obviously correct.
> 
> How can something be "(n)ever intended to work" and yet patches to
> make it work be "obviously correct"? ;-)

You snipped the part where I said "this is probably reasonable to do in
the meantime." :)

My "obviously correct" is only that the patches fulfill that.

> But I think that it is still reasonable for an end user to expect
> that 'git Foo' would trigger that alias.  And that is what was
> recently changed, inadvertently.
> 
> So the problem may need to be explained better in this series, but I
> think the usage was expected to work and the series is fixing a real
> regression.

Sort of. It did not work until it accidentally did work, and now it
accidentally does not work again. So "usage was expected to work" was
certainly not true for Git developers (or at least nobody intentionally
wrote code to make it so). And anybody relying on it started doing so
since v2.2.0.

But like I said, it's probably reasonable to make it work. There's
little harm in doing so.  The only downside I can see is that doing:

  git config alias.foo <something>
  git Foo

now triggers the alias. That seems like at worst a minor bug, and
possibly even the right thing to do (see below).

> Do we want to promise to keep the following "working"?
> 
>     git config alias.Foo <something>
>     git foo
> 
> By designing the system in such a way that an alias is created with
> a two-level name in our system, we are saying that alias names are
> case insensitive to the end users, so I _think_ the above is
> intended to work, and we are effectively promising that it will keep
> working.

Yes, I think we must. Keys are case-insensitive, and you are allowed to
write them in whatever case you like. The more interesting case is the
reverse, that I showed above. I think there are basically two mental
models that are reasonable:

  1. Uppercase in key names is treated the same as lowercase. Therefore
     we must allow "alias.Foo" to match "git foo", but "git Foo" can
     never have a match (in the current schema).

  2. Keys are case-insensitive, and anything that matches them is
     considered case-insensitive, too. That means "Foo" and "foo" are
     identical for these purposes, and you can never have two aliases
     "Foo" and "foo".

In either mental model, "alias.Foo" for "git foo" must work. But the
reverse only works in (2).

I think either model is fine. These patches push us into (2).

-Peff
