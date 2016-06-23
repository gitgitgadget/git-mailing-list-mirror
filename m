Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D7E1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 19:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbcFWTQS (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 15:16:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:59288 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750890AbcFWTQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 15:16:17 -0400
Received: (qmail 1822 invoked by uid 102); 23 Jun 2016 19:16:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:16:16 -0400
Received: (qmail 13995 invoked by uid 107); 23 Jun 2016 19:16:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:16:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 15:16:14 -0400
Date:	Thu, 23 Jun 2016 15:16:14 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] diffcore-pickaxe: "share" regex error handling code
Message-ID: <20160623191614.GA1841@sigill.intra.peff.net>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160623162907.23295-10-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160623162907.23295-10-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 06:29:05PM +0200, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 7715c13..69c6567 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -204,20 +204,13 @@ void diffcore_pickaxe(struct diff_options *o)
>  	int opts = o->pickaxe_opts;
>  	regex_t regex, *regexp = NULL;
>  	kwset_t kws = NULL;
> +	int err = 0;
>  
>  	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
> -		int err;
>  		int cflags = REG_EXTENDED | REG_NEWLINE;
>  		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
>  			cflags |= REG_ICASE;
>  		err = regcomp(&regex, needle, cflags);
> -		if (err) {
> -			/* The POSIX.2 people are surely sick */
> -			char errbuf[1024];
> -			regerror(err, &regex, errbuf, 1024);
> -			regfree(&regex);
> -			die("invalid regex: %s", errbuf);
> -		}
>  		regexp = &regex;
>  	} else {
>  		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
> @@ -225,6 +218,13 @@ void diffcore_pickaxe(struct diff_options *o)
>  		kwsincr(kws, needle, strlen(needle));
>  		kwsprep(kws);
>  	}
> +	if (err) {
> +		/* The POSIX.2 people are surely sick */
> +		char errbuf[1024];
> +		regerror(err, &regex, errbuf, 1024);
> +		regfree(&regex);
> +		die("invalid regex: %s", errbuf);
> +	}

Hrm. I wondered what happens if we see an error in the kwset code block,
which did not put anything useful in "regex" at all.

It's OK right now, because "err" is newly promoted to the top of the
function, and so we know that kwset cannot call it. But it seems like
an accident waiting to happen. Calling it "regex_err" or something might
help.

But I also wonder if a function wouldn't be better. You could even roll
it up with regcomp, like:

  static void regcomp_or_die(regex_t *regex, const char *pattern, int flags)
  {
	int err = regcomp(regex, pattern, flags);
	if (err) {
		char buf[1024];
		regerror(err, &regex, buf, sizeof(buf));
		regfree(&regex);
		die("invalid regex: %s", buf);
	}
  }

I think you could also skip the regfree(), since we are about to die. I
also think the error message would probably be better if it mentioned
the text of "pattern" itself (since it might be coming from config, or
you might have provided several patterns, or you might have thought
something was supposed to be a non-regex).

-Peff
