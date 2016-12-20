Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4FC1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 16:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933743AbcLTQ57 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 11:57:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:59027 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932357AbcLTQ56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 11:57:58 -0500
Received: (qmail 2914 invoked by uid 109); 20 Dec 2016 16:57:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Dec 2016 16:57:57 +0000
Received: (qmail 5753 invoked by uid 111); 20 Dec 2016 16:58:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Dec 2016 11:58:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Dec 2016 11:57:55 -0500
Date:   Tue, 20 Dec 2016 11:57:55 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] log: support 256 colors with --graph=256colors
Message-ID: <20161220165754.hkmnsxiwbcgn6uin@sigill.intra.peff.net>
References: <20161220123929.15329-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161220123929.15329-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 07:39:29PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  I got mad after tracing two consecutive red history lines in `git log
>  --graph --oneline` back to their merge points, far far away. Yeah
>  probably should fire up tig, or gitk or something.
> 
>  This may sound like a good thing to add, but I don't know how good it
>  is compared to the good old 16 color palette, yet as I haven't tried it
>  for long since it's just written.

Hmm. At some point the colors become too close together to be easily
distinguishable. In your code you have:

> +	if (arg && !strcmp(arg, "256colors")) {
> +		int i, start = 17, stop = 232;
> +		column_colors_max = stop - start;
> +		column_colors =
> +			xmalloc((column_colors_max + 1) * sizeof(*column_colors));
> +		for (i = start; i < stop; i++) {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_addf(&sb, "\033[38;5;%dm", i);
> +			column_colors[i - start] = strbuf_detach(&sb, NULL);
> +		}
> +		column_colors[column_colors_max] = xstrdup(GIT_COLOR_RESET);
> +		/* ignore the closet 16 colors on either side for the next line */
> +		column_colors_step = 16;
> +	}

So you step by 16, over a set of 215 colors. That seems to give only 13
colors, versus the original 16. :)

I know that is a simplification. If you wrap around, then you get your
13 colors, and then another 13 colors that aren't _quite_ the same, and
so on, until you've used all 256. I'm just not sure if the 1st and 14th
color would be visually different enough for it to matter (I admit I
didn't do any experiments, though).

> ---graph::
> +--graph[=<options>]::
>  	Draw a text-based graphical representation of the commit history
>  	on the left hand side of the output.  This may cause extra lines
>  	to be printed in between commits, in order for the graph history

I wonder if we would ever want another use for "--graph=foo". I guess
any such thing could fall under the name of "graph options", and we'd
end up with "--graph=256colors,unicode" or something like that.

I do suspect people would want a config option for this, though. I.e.,
you'd want to enable it all the time if you have a terminal which can
handle 256 colors, not just for a particular invocation.

-Peff
