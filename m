Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18AD9200E0
	for <e@80x24.org>; Wed, 28 Dec 2016 05:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750840AbcL1F6b (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 00:58:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:60880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbcL1F6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 00:58:30 -0500
Received: (qmail 2107 invoked by uid 109); 28 Dec 2016 05:58:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 05:58:30 +0000
Received: (qmail 15934 invoked by uid 111); 28 Dec 2016 05:59:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 00:59:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 00:58:26 -0500
Date:   Wed, 28 Dec 2016 00:58:26 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org
Subject: Re: [PATCH] pathspec: give better message for submodule related
 pathspec error
Message-ID: <20161228055826.xu2gclwkvisbft6o@sigill.intra.peff.net>
References: <20161228000559.17842-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161228000559.17842-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 04:05:59PM -0800, Stefan Beller wrote:

> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1].

If people are running into it, it definitely should not be an assert,
nor a die("BUG"). It should be a regular die(), which your patch does.
So this is definitely a good step, even if the ultimate goal may be to
handle the case more gracefully (I say that without having even read the
background, or knowing what the right handling would be).

But...

> diff --git a/pathspec.c b/pathspec.c
> index 22ca74a126..d522f43331 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -313,8 +313,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	}
>  
>  	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <= item->len &&
> -	       item->prefix         <= item->len);
> +	if (item->nowildcard_len <= item->len &&
> +	    item->prefix         <= item->len)
> +		die (_("Path leads inside submodule '%s', but the submodule "
> +		       "was not recognized, i.e. not initialized or deleted"),
> +		       ce->name);

Don't you need to flip the logic here? An assert() triggers when the
condition is not true, but an "if" does the opposite. So "assert(X)"
should always become "if (!X) die(...)".

-Peff
