Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6072027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdFBULq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:11:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:34054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBULp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:11:45 -0400
Received: (qmail 30120 invoked by uid 109); 2 Jun 2017 20:11:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 20:11:45 +0000
Received: (qmail 31007 invoked by uid 111); 2 Jun 2017 20:12:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 16:12:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 16:11:43 -0400
Date:   Fri, 2 Jun 2017 16:11:43 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision.c: use skip_prefix() in
 handle_revision_opt()
Message-ID: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
References: <20170602191010.16834-1-szeder.dev@gmail.com>
 <20170602191010.16834-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170602191010.16834-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 09:10:09PM +0200, SZEDER Gábor wrote:

> @@ -1785,15 +1785,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--author-date-order")) {
>  		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
>  		revs->topo_order = 1;
> -	} else if (starts_with(arg, "--early-output")) {
> +	} else if (skip_prefix(arg, "--early-output", &optarg)) {
>  		int count = 100;
> -		switch (arg[14]) {
> +		switch (*optarg) {
>  		case '=':
> -			count = atoi(arg+15);
> +			count = atoi(optarg + 1);
>  			/* Fallthrough */
>  		case 0:
>  			revs->topo_order = 1;
> -		       revs->early_output = count;
> +			revs->early_output = count;
>  		}

What happens if I say "--early-output-foobar"? There should probably be
a "default" here that rejects it. Though we'd probably to goto to get to
the unknown block, yuck.

Perhaps we could do:

  if (skip_prefix(arg, "--early-output", &optarg) &&
      (*optarg == '=' || !*optarg)) {
          int count = *optarg ? atoi(optarg + 1) : 100;
	  revs->topo_order = 1;
	  revs->early_output = count;
  }

Alternatively, a helper like:

  int match_opt(const char *have, const char *want, const char **argout)
  {
	const char *arg;
	if (!skip_prefix(have, want, &arg))
		return 0;
	if (!*arg)
		*argout = NULL;
	else if (*arg == '=')
		*argout = arg + 1;
	else
		return 0;
	return 1;
  }

would let us do:

  if (match_opt(arg, "--early-output"), &optarg)) {
	int count = optarg ? atoi(optarg) : 100;
	...
  }

which is a little nicer and could maybe help other options (I didn't see
any, though). If we're going to go that route, though, I suspect there
may be some helpers we already have. Looks like parse_long_opt() is
almost there, but doesn't handle options. I wonder if we could reuse
bits of parse-options here (or even better, just parse-optify many of
these).

Anyway, none of that is caused by your patch, but at least doing the
minimal fix (my first hunk) seems like it fits into your series.

-Peff
