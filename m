Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256691FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 06:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbdFJGfW (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:35:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:37462 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdFJGfV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:35:21 -0400
Received: (qmail 29056 invoked by uid 109); 10 Jun 2017 06:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:35:20 +0000
Received: (qmail 28977 invoked by uid 111); 10 Jun 2017 06:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 02:35:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 02:35:19 -0400
Date:   Sat, 10 Jun 2017 02:35:19 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision.c: use skip_prefix() in
 handle_revision_opt()
Message-ID: <20170610063518.6ihim2za6vil24pt@sigill.intra.peff.net>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170609181733.6793-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 08:17:28PM +0200, SZEDER Gábor wrote:

> > would let us do:
> >
> >   if (match_opt(arg, "--early-output"), &optarg)) {
> >         int count = optarg ? atoi(optarg) : 100;
> >         ...
> >   }
> >
> > which is a little nicer and could maybe help other options (I didn't see
> > any, though).
> 
> Besides '--show-linear-break' and '--pretty', other options that could
> benefit from this, i.e. long options with an optional argument, are
> '--expand-tabs', '--abbrev' and '--no-walk'.  These are handled
> differently than '--early--output' and '--show-linear-break': each is
> covered by two if branches, one with and one without the optional 
> argument, i.e.:
> 
>   } else if (!strcmp(arg, "--option")) {
>     ...
>   } else if (starts_with(arg, "--option=")) {
>     ...
>   } else ...

I think those multi-branch cases end up as an improvement with a helper:

  if (match_opt(arg, "--no-walk", &optarg)) {
	if (!optarg || !strcmp(optarg, "sorted"))
		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
	else if (!strcmp(optarg, "unsorted"))
		revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
	else
		return error(...);
  }

> '--pretty=' couldn't benefit, though, because it is special in that
> it's equivalent with '--format=', and the two are handled in the same
> branch.

I think you could still handle them both in the same branch, like:

  if (match_opt(arg, "--pretty", &optarg) ||
      skip_prefix(arg, "--format=", &optarg)) {
       revs->verbose_header = 1;
       revs->pretty-given = 1;
       /* OK to pass NULL for --pretty case */
       get_commit_format(optarg, revs);
  }

> So inherently there are a few repeated option names and variable
> assignments, and that's not so good.  However, refactoring these to
> use match_opt() adds 40% more lines than it removes and, more
> importantly, increases the number of nested conditions.  Subjectively
> I don't think it's better, so I went with the "follow the conventions
> of the surrounding code" rule for the update.

I care less about lines of boilerplate code and more about repeated
logic. In the --pretty example above, the first two lines of the block
are common to both --pretty and --pretty=. If they ever need to change,
somebody has to update two spots.

Anyway. I certainly don't insist on you working on this, especially if
you don't agree with the aesthetics. Just fixing the actual bugs would
be sufficient for my review. ;)

> As far as I can tell, parse-options doesn't handle options with an
> optional argument by itself, but only with callback functions, so it
> is no help here as it is.

There's a flag, PARSE_OPT_OPTARG, which would do what you want. But I
agree that converting the whole thing to parse-options would be a lot of
work (quite a few of these really aren't just "this is a string", but
would need independent callback functions.

-Peff
