Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF631F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbdAZOY1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:24:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:45309 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752685AbdAZOY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:24:26 -0500
Received: (qmail 4284 invoked by uid 109); 26 Jan 2017 14:24:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:24:26 +0000
Received: (qmail 23336 invoked by uid 111); 26 Jan 2017 14:24:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 09:24:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 09:24:24 -0500
Date:   Thu, 26 Jan 2017 09:24:24 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after
 --exclude
Message-ID: <20170126142423.6rrorahyzfo6z43q@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
 <20170125125054.7422-5-pclouds@gmail.com>
 <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
 <CACsJy8ATM_kc5SPY0dqprUefRy3vtpKW-4QEyJFK54jw0QgeJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8ATM_kc5SPY0dqprUefRy3vtpKW-4QEyJFK54jw0QgeJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 04:28:17PM +0700, Duy Nguyen wrote:

> On Thu, Jan 26, 2017 at 3:57 AM, Jeff King <peff@peff.net> wrote:
> > I don't think it means either. It means to include remotes in the
> > selected revisions, but excluding the entries mentioned by --exclude.
> >
> > IOW:
> >
> >   --exclude=foo --remotes
> >         include all remotes except refs/remotes/foo
> >
> >   --exclude=foo --unrelated --remotes
> >         same
> >
> >   --exclude=foo --decorate-reflog --remotes
> >         decorate reflogs of all remotes except "foo". Do _not_ use them
> >         as traversal tips.
> >
> >   --decorate-reflog --exclude=foo --remotes
> >         same
> >
> > IOW, the ref-selector options build up until a group option is given,
> > which acts on the built-up options (over that group) and then resets the
> > built-up options. Doing "--unrelated" as above is orthogonal (though I
> > think in practice nobody would do that, because it's hard to read).
> 
> This is because it makes sense to combine --exclude and
> --decorate-reflog. But what about a new --something that conflicts
> with either --exclude or --decorate-reflog? Should we simply catch
> such combinations and error out (which may be a bit more complicated
> than this patch, or maybe not)?

I'd cross that bridge when we see what the option is. But my gut is that
rules would be:

  - apply all non-conflicting relevant options. So:

      --exclude=foo/* --decorate-refs --decorate-reflog --remotes

    would presumably decorate both ref tips _and_ reflogs for all
    remotes (except ones in refs/remotes/foo/*)

  - for ones that are directly related and override each other,
    use the usual last-one-wins rule. So:

      --decorate-reflog --no-decorate-reflog --remotes

    would countermand the original --decorate-reflog.

  - for ones that really have complex interactions, notice and complain
    in handle_refs().

That just seems to me like it follows our usual option parsing
procedure. The only difference here is that process and reset some
subset of the flags when we hit a special marker option ("--remotes" in
these examples) instead of doing it at the end.

-Peff
