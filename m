Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0231F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967182AbeE2VkA (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:40:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:55830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966992AbeE2VkA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:40:00 -0400
Received: (qmail 4302 invoked by uid 109); 29 May 2018 21:40:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 21:40:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31229 invoked by uid 111); 29 May 2018 21:40:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 17:40:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 17:39:57 -0400
Date:   Tue, 29 May 2018 17:39:57 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from
 `advise()`
Message-ID: <20180529213957.GF7964@sigill.intra.peff.net>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
 <cover.1527279322.git.martin.agren@gmail.com>
 <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 11:00:53PM +0200, Martin Ågren wrote:

> +/*
> + * Write the message to the file, prefixing and suffixing
> + * each line with `prefix` resp. `suffix`.
> + */
> +void prefix_suffix_lines(FILE *f, const char *prefix,
> +			 const char *message, const char *suffix);

Should this perhaps learn about colors, too?

That would save us from having to allocate here:

> diff --git a/advice.c b/advice.c
> index 370a56d054..ffb29e7ef4 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -79,24 +79,22 @@ static struct {
>  
>  void advise(const char *advice, ...)
>  {
> +	struct strbuf prefix = STRBUF_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	va_list params;
> -	const char *cp, *np;
> +
> +	strbuf_addf(&prefix, _("%shint: "),
> +		    advise_get_color(ADVICE_COLOR_HINT));

But most importantly, it means we could eventually colorize errors, too,
where we are not allowed to allocate.

So perhaps:

  void report_lines(FILE *out,
                    const char *color, const char *color_reset,
		    const char *prefix, const char *msg);

or something?

-Peff
