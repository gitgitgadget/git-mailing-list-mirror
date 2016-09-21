Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC111F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbcIULJj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:09:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:45975 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753933AbcIULJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:09:38 -0400
Received: (qmail 16741 invoked by uid 109); 21 Sep 2016 11:09:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 11:09:37 +0000
Received: (qmail 30904 invoked by uid 111); 21 Sep 2016 11:09:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 07:09:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Sep 2016 07:09:35 -0400
Date:   Wed, 21 Sep 2016 07:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160921110934.f6eu2dz6i2mlpa45@sigill.intra.peff.net>
References: <20160916210204.31282-1-me@ikke.info>
 <20160919185440.18234-3-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160919185440.18234-3-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 08:54:40PM +0200, Kevin Daudt wrote:

> diff --git a/mailinfo.c b/mailinfo.c
> index e19abe3..6a7c2f2 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -54,6 +54,50 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
>  	get_sane_name(&mi->name, &mi->name, &mi->email);
>  }
>  
> +static void unquote_quoted_string(struct strbuf *line)
> +{
> +	const char *in = strbuf_detach(line, NULL);

I see that this version uses the "detach, and then write into the
replacement" approach, which is good. But...

> +	int c, take_next_literally = 0;
> +	int found_error = 0;
> +
> +	/*
> +	 * Stores the character that started the escape mode so that we know what
> +	 * character will stop it
> +	 */
> +	char escape_context = 0;
> +
> +	while ((c = *in++) != 0) {
> +		if (take_next_literally) {
> +			take_next_literally = 0;
> +		} else {
> [...]
> +		}
> +
> +		strbuf_addch(line, c);
> +	}
> +}

It needs to `free(in)` at the end of the function.

Your original also fed "line->len" as a hint, but I doubt it really
matters in practice, so I don't mind losing that.

-Peff
