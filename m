Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB66C1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 05:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeI3MZU (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 08:25:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:36648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727719AbeI3MZU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 08:25:20 -0400
Received: (qmail 16376 invoked by uid 109); 30 Sep 2018 05:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Sep 2018 05:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10222 invoked by uid 111); 30 Sep 2018 05:53:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Sep 2018 01:53:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Sep 2018 01:53:43 -0400
Date:   Sun, 30 Sep 2018 01:53:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
Message-ID: <20180930055343.GA2542@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
 <20180926184914.GC30680@sigill.intra.peff.net>
 <3677a12b-5b9b-ad2a-1e3a-7de251baa40d@rasmusvillemoes.dk>
 <20180929082108.GJ2174@sigill.intra.peff.net>
 <xmqq4le89p91.fsf@gitster-ct.c.googlers.com>
 <20180930042735.GA32120@sigill.intra.peff.net>
 <xmqqy3bj7dxo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3bj7dxo.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 10:27:15PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And I think this has to be stderr. We're polluting the output of the
> > aliased command with our extra message, so we have two choices:
> >
> >   1. Pollute stderr, and risk copious stdout (or a pager) scrolling it
> >      off the screen.
> >
> >   2. Pollute stdout, at which point our message may be confused as part
> >      of the actual output of the command (and that may not even be
> >      immediately noticed if it is passed through a shell pipeline or
> >      into a file).
> >
> > Choice (2) seems like a regression to me. Choice (1) is unfortunate in
> > some cases, but is no worse than today's behavior.
> 
> I think the output of "git foo -h" changing (i.e. has "aliased
> to..."  message in front) is about the same degree of regression as
> "git foo --help" no longer giving "aliased to..." information
> anywhere, though.

Hmm. They seem quite different to me. Changing "--help" output is
something that's only going to impact what the user sees (a manpage
versus the alias message). And the user can follow-up by asking for what
they wanted.

Whereas if I have an alias that currently understands "-h", and I do
something like:

  git foo -h | wc -l

if we output to stdout, that's going to produce subtly broken results.
But if we output to stderr instead, then they may see the extra message,
but it's obvious what's happening, and it's probably an annoyance at
worst).

> > Yeah. I think if "git foo -h" produces a bunch of output you didn't
> > expect, then "git help foo" or "git foo --help" may be the next thing
> > you reach for. That's not so different than running the command even
> > without any aliases involved.
> 
> Hmmm.  With the "teach 'git foo -h' to output 'foo is aliased to
> bar' to the standard error before running 'git bar -h'", plus "'git
> foo --help' now goes straight to 'git bar --help'", "git foo --help"
> no longer tells us that foo is aliased to bar.  Presumably "git help
> foo" will still give "foo is bar" and stop?

Yes, that was the intent in the behavior I laid out earlier.

-Peff
