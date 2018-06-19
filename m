Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35151F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966480AbeFSQ23 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:28:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:48492 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965953AbeFSQ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:28:28 -0400
Received: (qmail 31226 invoked by uid 109); 19 Jun 2018 16:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 16:28:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14312 invoked by uid 111); 19 Jun 2018 16:28:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 12:28:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 12:28:26 -0400
Date:   Tue, 19 Jun 2018 12:28:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 4/7] grep.c: display column number of first match
Message-ID: <20180619162825.GA22034@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <df2d08efc1fb717a564157fb760ff71becb658dd.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df2d08efc1fb717a564157fb760ff71becb658dd.1529365072.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 06:43:14PM -0500, Taylor Blau wrote:

>  static void show_line(struct grep_opt *opt, char *bol, char *eol,
> -		      const char *name, unsigned lno, char sign)
> +		      const char *name, unsigned lno, unsigned cno, char sign)

Here "cno" is unsigned. But later...

> +	if (opt->columnnum && cno) {
> +		char buf[32];
> +		xsnprintf(buf, sizeof(buf), "%d", cno);

...we print it with "%d". Should this be "%u"?

But ultimately, the column number comes from this code:

> @@ -1785,6 +1796,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  	while (left) {
>  		char *eol, ch;
>  		int hit;
> +		ssize_t cno;
>  		ssize_t col = -1, icol = -1;
>  
>  		/*
> @@ -1850,7 +1862,15 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  				show_pre_context(opt, gs, bol, eol, lno);
>  			else if (opt->funcname)
>  				show_funcname_line(opt, gs, bol, lno);
> -			show_line(opt, bol, eol, gs->name, lno, ':');
> +			cno = opt->invert ? icol : col;
> +			if (cno < 0) {
> +				/*
> +				 * A negative cno means that there was no match.
> +				 * Clamp to the beginning of the line.
> +				 */
> +				cno = 0;
> +			}

...which is a ssize_t. Should we just be using ssize_t consistently?

We do at least clamp the negative values here, but on 64-bit systems
ssize_t is much larger than "unsigned".  I admit that it's probably
ridiculous for any single line to overflow 32 bits, but it seems like we
should consistently use size_t/ssize_t for buffer offsets, and then we
don't have to think about it.

-Peff
