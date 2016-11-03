Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665E22021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758589AbcKCSAV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:00:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:38184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756863AbcKCSAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:00:20 -0400
Received: (qmail 4508 invoked by uid 109); 3 Nov 2016 18:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 18:00:19 +0000
Received: (qmail 15076 invoked by uid 111); 3 Nov 2016 18:00:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 14:00:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 14:00:17 -0400
Date:   Thu, 3 Nov 2016 14:00:17 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103180017.x2hjb5wm2u6isajm@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <CAGZ79kbvs+ryGRjCkHYO=3iNK4tPPhBhYjRMZaH7rP0QMrULhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbvs+ryGRjCkHYO=3iNK4tPPhBhYjRMZaH7rP0QMrULhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 10:39:35AM -0700, Stefan Beller wrote:

> >>   protocol.X.allow = always | user | never
> >
> > It sounds like there is interest for this sort of behavior, it would
> > definitely require a larger change than what I initially proposed.  One
> > problem I see though is that with this we have support for both a
> > blacklist and a whitelist.  Which wins?
> 
> For the submodule operations we'll use a whitelist, because we want to
> provide security and for the other case we can offer a blacklist as a bandaid.
> 
> My opinion on blacklists is roughly aligned with e.g. :
> https://blog.codinghorror.com/blacklists-dont-work/
> http://blog.deepinstinct.com/2016/02/04/when-blacklists-dont-really-work/
> 
> So IMHO we could drop the "never" and substitute it with a "warn" or
> "ask-user", such that this configuration becomes a white list for both cases:
> 
>      protocol.X.allow = always | user | warn

I don't think blacklists work in the general case, because they grow out
of date and fail-open. But you want to have _some_ blacklisting
mechanism, in order override a decision of the whitelist.

For instance, the default submodule whitelist would probably include
https and ssh. But if I'm cloning potentially malicious repos and I
don't ever want them to trigger ssh (because I don't want them to use my
ssh keys, whereas I have explicitly set up my credentials such that http
is safe to use), I would want to be able to do:

  git config protocol.ssh.allow never

(or "git -c", or whatever).

True, a whitelist is safer. If we add a new "foo" protocol that also
looks at your ssh keys, you're screwed. And that's why I designed it as
a pure-whitelist in the first place. But it comes at the price of
convenience, because you have to manually add each new innocent protocol
to the whitelist.

> So you're suggesting that setting it to "never" doesn't have any effect
> except for cluttering the config file?
> I don't think we should do that; each setting should have an impact.
> So maybe the "never" would be there to disallow protocols of the hardcoded
> white list (e.g. http)

Exactly.

> > I don't know if I'm sold on a 'user' state just yet, perhaps that's just
> > because I view a whitelist or blacklist as well black and white and
> > having this user state adds in a gray area.
> 
> Well the "user" state is to differentiate between the
> * "I consciously typed `git clone ...` (and e.g. I know what happens as
>   I know the server admin and they are trustworthy.)
> * a repository contains a possible hostile .gitmodules file such
>   that I am not aware of the network connection.

Right. I had assumed that we would tell the difference between those
automatically (by seeing if we got the URL on the command line), but
things like "go get" show that the context is often before git is even
called.

-Peff
