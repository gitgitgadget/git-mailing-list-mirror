Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FE31F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 08:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758256AbcIHIEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 04:04:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:40020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757650AbcIHIEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 04:04:51 -0400
Received: (qmail 2780 invoked by uid 109); 8 Sep 2016 08:04:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 08:04:50 +0000
Received: (qmail 12931 invoked by uid 111); 8 Sep 2016 08:04:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 04:04:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 04:04:47 -0400
Date:   Thu, 8 Sep 2016 04:04:47 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Introduce a function to run regexec() on
 non-NUL-terminated buffers
Message-ID: <20160908080447.adquu2e5d7bbeorn@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <cover.1473319844.git.johannes.schindelin@gmx.de>
 <94ee698b2736929d37640012a1b1735b134dd3d6.1473319844.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94ee698b2736929d37640012a1b1735b134dd3d6.1473319844.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 09:31:11AM +0200, Johannes Schindelin wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index db89ba7..19128b3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -965,6 +965,27 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>  #define qsort git_qsort
>  #endif
>  
> +static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
> +			      size_t nmatch, regmatch_t pmatch[], int eflags)
> +{
> +#ifdef REG_STARTEND
> +	assert(nmatch > 0 && pmatch);
> +	pmatch[0].rm_so = 0;
> +	pmatch[0].rm_eo = size;
> +	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
> +#else
> +	char *buf2 = xmalloc(size + 1);
> +	int ret;
> +
> +	memcpy(buf2, buf, size);
> +	buf2[size] = '\0';

I mentioned elsewhere that I'd prefer we just push people into using
compat/regex if they don't have REG_STARTEND. But if we _do_ keep this
fallback, note that the above has a buffer overflow (think what happens
when "size" is the maximum value for a size_t).  You can avoid it by
using xmallocz().

-Peff
