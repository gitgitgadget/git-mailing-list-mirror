Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E9AC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082AA2076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633061AbgDNUYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:24:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:53706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2633040AbgDNUYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 16:24:02 -0400
Received: (qmail 7537 invoked by uid 109); 14 Apr 2020 20:24:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Apr 2020 20:24:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1684 invoked by uid 111); 14 Apr 2020 20:34:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2020 16:34:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Apr 2020 16:24:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] date.c: allow compact version of ISO-8601 datetime
Message-ID: <20200414202401.GC1879688@coredump.intra.peff.net>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:31:55PM +0700, Đoàn Trần Công Danh wrote:

> @@ -666,6 +666,24 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
>  		n++;
>  	} while (isdigit(date[n]));
>  
> +	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
> +	if (n == 8) {
> +		tm->tm_year = num / 10000 - 1900;
> +		tm->tm_mon = (num % 10000) / 100 - 1;
> +		tm->tm_mday = num % 100;
> +		return n;
> +	}

I worry a little this may conflict with other approxidate heuristics.
The only one I can think of is an actual unix timestamp, though, and we
already require that to have at least 9 digits (plus anybody wanting to
use one robustly really should be using @12345678).

And it looks like we'd exit early from the function for anything longer
than 4 digits anyway, ignoring the value.

We could probably tighten the heuristics a bit by insisting that the
month and day be sensible. Or even year (see the 1900 to 2100 magic for
the 4-digit year guess).

> +	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
> +	if (n == 6) {
> +		tm->tm_hour = num / 10000;
> +		tm->tm_min = (num % 10000) / 100;
> +		tm->tm_sec = num % 100;
> +		if (*end == '.' && isdigit(end[1]))
> +			strtoul(end + 1, &end, 10);
> +		return end - date;
> +	}

And likewise here that the hour, minute, and second be reasonable.

-Peff
