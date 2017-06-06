Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64219209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdFFSh2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:37:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751432AbdFFSh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:37:27 -0400
Received: (qmail 20767 invoked by uid 109); 6 Jun 2017 18:37:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 18:37:27 +0000
Received: (qmail 26635 invoked by uid 111); 6 Jun 2017 18:38:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 14:38:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jun 2017 14:37:26 -0400
Date:   Tue, 6 Jun 2017 14:37:26 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170606183726.ycl4k2aoyurj5sfr@sigill.intra.peff.net>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com>
 <20170531042304.unkxkuw6s3tcpzkm@sigill.intra.peff.net>
 <CAM0VKjkfuyBzZmpJL47xmK24EOh6X5OjrxtxVdsgGupAseT_wQ@mail.gmail.com>
 <20170605081845.tvzidc5nblbnuner@sigill.intra.peff.net>
 <CAM0VKjngnRv6iAozvhY_c61CyWhQP2khcr0bs1=7G_-MDNu4kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjngnRv6iAozvhY_c61CyWhQP2khcr0bs1=7G_-MDNu4kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 08:19:09PM +0200, SZEDER Gábor wrote:

> >   if (!remote->fetch)
> >         BUG("cannot add refspec to an unparsed remote");
> >
> > ?
> 
> But as mentioned before, remote->fetch being NULL is not a bug in
> itself, it's a perfectly valid value even in a fully parsed remote
> when the remote has no fetch refspecs.
> Therefore, I think, the condition should instead be:
> 
>   remote->fetch_refspec_nr && !remote->fetch

Right, that would be a better check.

> We could even try to be extra helpful by checking this condition and
> calling parse_fetch_refspec() to initialize remote->fetch instead of
> BUG()ing out.  However, that would mask the real issue, namely not
> using remote_get() to get the remote, so I don't actually think that's
> a good thing to do.

OK.

> To put your worries to rest we should eliminate remote->fetch_refspec
> altogether and parse refspecs into remote->fetch right away, I'd
> think.  After all, that's what's used in most places anyway, and it
> can be easily turned back to a single string where needed (I think in
> only 3 places in builtin/remote.c).

I don't think we can parse right away without regressing the error
handling. If I have two remotes, one with a bogus refspec, like:

  [remote "one"]
  url = ...
  fetch = refs/heads/*:refs/remotes/one/*
  [remote "two"]
  url = ...
  fetch = ***bogus***

and I do:

  git fetch one

then read_config() will grab the data for _both_ of them, but only call
remote_get() on the first one. If we parsed the refspecs during
read_config(), we'd parse the bogus remote.two.fetch and die().

I guess that's a minor case, but as far as I can tell that's the
motivation for the lazy parsing.

-Peff
