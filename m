Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D336208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 09:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbdHQJDM (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 05:03:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:41482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750926AbdHQJDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 05:03:10 -0400
Received: (qmail 3063 invoked by uid 109); 17 Aug 2017 09:03:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 09:03:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25348 invoked by uid 111); 17 Aug 2017 09:03:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 05:03:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 05:03:08 -0400
Date:   Thu, 17 Aug 2017 05:03:08 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git add -p breaks after split on change at the top of the file
Message-ID: <20170817090308.yh3jnztgfmkwtqpr@sigill.intra.peff.net>
References: <20170816202442.aumzwa443spqgyul@ruderich.org>
 <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 04:41:09AM -0400, Jeff King wrote:

> diff --git a/apply.c b/apply.c
> index 41ee63e1db..606db58218 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2966,8 +2966,9 @@ static int apply_one_fragment(struct apply_state *state,
>  	 * In other words, a hunk that is (frag->oldpos <= 1) with or
>  	 * without leading context must match at the beginning.
>  	 */
> -	match_beginning = (!frag->oldpos ||
> -			   (frag->oldpos == 1 && !state->unidiff_zero));
> +	match_beginning = (nth_fragment == 1 &&
> +			   (!frag->oldpos ||
> +			    (frag->oldpos == 1 && !state->unidiff_zero)));
>  
>  	/*
>  	 * A hunk without trailing lines must match at the end.
> 
> 
> But I'm not quite sure if that's right. The rest of the overlap code
> seems to mark patched lines with a flag. Meaning that instead of giving
> up and saying "well, this is the second line so we can't ever try
> matching the beginning", we should be redefining "beginning" in that
> case to allow 0 or more PATCHED lines starting from the beginning of the
> file.

Hmm, actually I was reading that part of the code backwards. We record
the PATCHED flag _only_ when allow_overlap isn't set, not the other way
around. So I had been imagining we'd want something like this:

diff --git a/apply.c b/apply.c
index 41ee63e1db..4048751807 100644
--- a/apply.c
+++ b/apply.c
@@ -2489,8 +2489,11 @@ static int match_fragment(struct apply_state *state,
 		return 0;
 	}
 
-	if (match_beginning && try_lno)
-		return 0;
+	if (match_beginning) {
+		for (i = 0; i < try_lno; i++)
+			if (!(img->line[i].flag & LINE_PATCHED))
+				return 0;
+	}
 
 	/* Quick hash check */
 	for (i = 0; i < preimage_limit; i++)

But that does the opposite of what we want: it makes this case work when
--allow-overlap isn't specified. I think my first attempt is probably
closer to the right direction (but we'd want to have it kick in only
when --allow-overlap is specified; well formed patches shouldn't overlap
but we'd want to barf loudly if they do).

I'll stop here for now before digging any further. I'm not all that
familiar with the apply code, so I have a feeling Junio's comments may
stop me from going down an unproductive dead end. :)

-Peff
