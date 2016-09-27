Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D159A207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 05:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbcI0F5t (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 01:57:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:48584 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751499AbcI0F5s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 01:57:48 -0400
Received: (qmail 18855 invoked by uid 109); 27 Sep 2016 05:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 05:57:48 +0000
Received: (qmail 12779 invoked by uid 111); 27 Sep 2016 05:58:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 01:58:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 01:57:45 -0400
Date:   Tue, 27 Sep 2016 01:57:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] utf8: accept "latin-1" as ISO-8859-1
Message-ID: <20160927055744.el2jbxzdqfhjl6qt@sigill.intra.peff.net>
References: <20160927012211.9378-1-gitster@pobox.com>
 <20160927012211.9378-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160927012211.9378-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 06:22:11PM -0700, Junio C Hamano wrote:

> Even though latin-1 is still seen in e-mail headers, some platforms
> only install ISO-8859-1.  "iconv -f ISO-8859-1" succeeds, while
> "iconv -f latin-1" fails on such a system.
> 
> Using the same fallback_encoding() mechanism factored out in the
> previous step, teach ourselves that "ISO-8859-1" has a better chance
> of being accepted than "latin-1".

I was curious if this was the most official or accepted spelling.
Grepping a few hundred thousand messages from my mail archives, it does
seem to be the most common.

> diff --git a/utf8.c b/utf8.c
> index 550e785..0c8e011 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -501,6 +501,13 @@ static const char *fallback_encoding(const char *name)
>  	if (is_encoding_utf8(name))
>  		return "UTF-8";
>  
> +	/*
> +	 * Even though latin-1 is still seen in e-mail
> +	 * headers, some platforms only install ISO-8859-1.
> +	 */
> +	if (!strcasecmp(name, "latin-1"))
> +		return "ISO-8859-1";
> +

For the UTF-8 fallbacks, we actually detect their equivalence via
same_encoding() before even hitting iconv. Is it worth doing the same
here?

I have to admit that I don't care too deeply about performance for
somebody who wants to convert "latin1" to "ISO-8859-1". If one of your
encodings is not UTF-8, you are probably Doing It Wrong. :)

-Peff
