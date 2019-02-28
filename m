Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB03120248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfB1VWZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:22:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:33454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728111AbfB1VWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:22:25 -0500
Received: (qmail 31145 invoked by uid 109); 28 Feb 2019 21:22:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:22:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23818 invoked by uid 111); 28 Feb 2019 21:22:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:22:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:22:23 -0500
Date:   Thu, 28 Feb 2019 16:22:23 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 05/20] cat-file: remove split_on_whitespace
Message-ID: <20190228212222.GE12723@sigill.intra.peff.net>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a4b-b346412b-752e-4068-8a25-62cac2a1f555-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102016915f49a4b-b346412b-752e-4068-8a25-62cac2a1f555-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:

> Get rid of split_on_whitespace field in struct expand_data.
> expand_data may be global further as we use it in ref-filter also,
> so we need to remove cat-file specific fields from it.

OK, that makes some sense.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index e5de596611800..60f3839b06f8c 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -203,13 +203,6 @@ struct expand_data {
>  	 */
>  	int mark_query;
>  
> -	/*
> -	 * Whether to split the input on whitespace before feeding it to
> -	 * get_sha1; this is decided during the mark_query phase based on
> -	 * whether we have a %(rest) token in our format.
> -	 */
> -	int split_on_whitespace;

It looks like we lose this name and comment in the movement, though
(it's now "is_rest"). If it's just a local variable inside
batch_objects(), I don't know that we need the comment. But I think it's
more than is_rest, isn't it?

It looks like we auto-enable it when --textconv or --filters is given.
Can we stick with the split_on_whitespace name (which I think is also
more descriptive about how we intend it to be used)?

> @@ -491,6 +482,7 @@ static int batch_objects(struct batch_options *opt)
>  	struct expand_data data;
>  	int save_warning;
>  	int retval = 0;
> +	int is_rest = strstr(opt->format.format, "%(rest)") != NULL || opt->cmdmode;

I'm not excited by this loose parsing. It would do the wrong thing in
some funny corner cases (e.g., "%%(rest)").

We should be able to ask the format parser whether the "rest"
placeholder was used. That's what the initial strbuf_expand() call is
doing. I see that it's hard for us to pass something to its callback
outside of expand_data (since after all, expand_data takes up the
void-pointer data slot).

But doesn't that point to this being the wrong change (or perhaps the
wrong time to make it)?  I think we'd want to keep using our own local
expand_data as long as we are not using ref-filter. And then ref-filter
would grow its own struct to hold the data that _it_ needs. Some of that
would be duplicates of what we have here, but that's OK. When we cut
over to ref-filter, that's when we'd drop the fields here.

And eventually we'd drop that strbuf_expand(), too, as ref-filter would
do the parsing. But at that point we wouldn't want this strstr() either:
we'd have ref-filter parse the format, and then check the parsed atoms
to see if one of them is "rest".

-Peff
