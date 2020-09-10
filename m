Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA2C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 12:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2872D208FE
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 12:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgIJMjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:39:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:53238 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbgIJMfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 08:35:15 -0400
Received: (qmail 20078 invoked by uid 109); 10 Sep 2020 12:35:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 12:35:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18434 invoked by uid 111); 10 Sep 2020 12:35:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 08:35:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 08:35:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] quote_path: optionally allow quoting a path with SP
 in it
Message-ID: <20200910123509.GB57925@coredump.intra.peff.net>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
 <20200908205224.4126551-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908205224.4126551-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 01:52:21PM -0700, Junio C Hamano wrote:

> Some code in wt-status.c special case a path with SP in it, which
> usually does not have to be c-quoted, and ensure that such a path
> does get quoted.  Move the logic to quote_path() and give it a bit
> in the flags word, QUOTE_PATH_QUOTE_SP.
> 
> No behaviour change intended.

Sounds like a good direction.

> @@ -357,9 +357,16 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
>  	struct strbuf sb = STRBUF_INIT;
>  	const char *rel = relative_path(in, prefix, &sb);
>  	strbuf_reset(out);
> -	quote_c_style_counted(rel, strlen(rel), out, NULL, flags);
> +	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
>  	strbuf_release(&sb);
>  
> +	if ((flags & QUOTE_PATH_QUOTE_SP) &&
> +	    (out->buf[0] != '"' && strchr(out->buf, ' '))) {
> +		/* Ensure the whole thing is quoted if the path has SP in it */
> +		strbuf_insertstr(out, 0, "\"");
> +		strbuf_addch(out, '"');
> +	}

This might be premature optimization, but using insertstr() means we
have to recopy the entire string. As a general rule these kind of
"splice into an array" operations tickle my accidentally-quadratic
spider sense. But I don't think that's the case here (because we'd do at
most one insertstr() per string; the real sin would be inserting
characters like that throughout the string).

So it may not be worth addressing. I do think it would be conceptually
simpler if we could just tell quote_c_style_counted() to look for space
characters, but it looks like doing that ends up pretty invasive.

-Peff
