Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6191F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfACHus (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:50:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:53662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726129AbfACHur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:50:47 -0500
Received: (qmail 26533 invoked by uid 109); 3 Jan 2019 07:50:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 07:50:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8769 invoked by uid 111); 3 Jan 2019 07:50:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 02:50:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 02:50:45 -0500
Date:   Thu, 3 Jan 2019 02:50:45 -0500
From:   Jeff King <peff@peff.net>
To:     William Chargin <wchargin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Parsing trailers
Message-ID: <20190103075045.GD24925@sigill.intra.peff.net>
References: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
 <20190103070744.GA24149@sigill.intra.peff.net>
 <CAFW+GMD9P-E4xCP+K5JAX70a6cgoHUzOXU-Tv3w6yhKGT_GaEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFW+GMD9P-E4xCP+K5JAX70a6cgoHUzOXU-Tv3w6yhKGT_GaEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 02, 2019 at 11:43:55PM -0800, William Chargin wrote:

> > IMHO this is a bug in --parse. It was always meant to give sane,
> > normalized output
> 
> Okay; this is good to hear. In that case, what would you think about
> changing `interpret-trailers` as a whole to always emit colons? (Note
> that the command is already lossy: even with no flags, it replaces each
> separator character with the first character of `trailer.separators`.)
> This has the advantage that we avoid adding a configuration option of
> dubious value—it’s not clear to me why a user would actually _want_ to
> change the separator to anything other than a colon. The patch should be
> quite simple, too (only tested lightly on my machine):
> 
> diff --git a/trailer.c b/trailer.c
> index 0796f326b3..722040e48c 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -156,7 +156,7 @@ static void print_tok_val(FILE *outfile, const
> char *tok, const char *val)
>         if (strchr(separators, c))
>                 fprintf(outfile, "%s%s\n", tok, val);
>         else
> -               fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
> +               fprintf(outfile, "%s: %s\n", tok, val);
>  }
> 
> Is this veering too much from “bug fix” toward “backward-incompatible
> behavior change” for your comfort?

I think that gets weird in non-parse modes. For example, if I'm not
trying to parse, but rather to _add_ a new trailer (because I'm writing
out a commit message to feed to git-commit-tree), then I'd presumably
want the normal configured separators.

I dunno. I don't think I've ever seen a trailer with a non-colon
separator, nor have I ever used interpret-trailers for anything except
parsing. But it obviously was designed with more flexibility in mind,
and I suspect the patch above has a high chance of breaking something
somewhere.  Tying it to --parse seems a lot safer, since that was
introduced exactly for this case.

-Peff
