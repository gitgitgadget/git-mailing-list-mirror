Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6334C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeCNWPr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 18:15:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751279AbeCNWPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 18:15:47 -0400
Received: (qmail 9224 invoked by uid 109); 14 Mar 2018 22:15:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Mar 2018 22:15:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9675 invoked by uid 111); 14 Mar 2018 22:16:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Mar 2018 18:16:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2018 18:15:44 -0400
Date:   Wed, 14 Mar 2018 18:15:44 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] http: fix an unused variable warning for 'curl_no_proxy'
Message-ID: <20180314221544.GA20167@sigill.intra.peff.net>
References: <517c4210-c381-899e-b13a-00f8e4caba74@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <517c4210-c381-899e-b13a-00f8e4caba74@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 09:56:06PM +0000, Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Junio,
> 
> I happened to be building git on an _old_ laptop earlier this evening
> and gcc complained, thus:
> 
>       CC http.o
>   http.c:77:20: warning: ‘curl_no_proxy’ defined but not used [-Wunused-variable]
>    static const char *curl_no_proxy;
>                       ^
> The version of libcurl installed was 0x070f04. So, while it was fresh in my
> mind, I applied and tested this patch.

Makes sense. This #if would go away under my "do not support antique
curl versions" proposal. I haven't really pushed that forward since Tom
Christensen's patches to actually make the thing build (and presumably
since he is building on antique versions he can't turn on -Werror
anyway, since IIRC it tends to have some false positives).

I agree with Jonathan that this explanation should be in the commit
message. The patch itself looks OK, although:

> diff --git a/http.c b/http.c
> index 8c11156ae..a5bd5d62c 100644
> --- a/http.c
> +++ b/http.c
> @@ -69,6 +69,9 @@ static const char *ssl_key;
>  #if LIBCURL_VERSION_NUM >= 0x070908
>  static const char *ssl_capath;
>  #endif
> +#if LIBCURL_VERSION_NUM >= 0x071304
> +static const char *curl_no_proxy;
> +#endif
>  #if LIBCURL_VERSION_NUM >= 0x072c00
>  static const char *ssl_pinnedkey;
>  #endif
> @@ -77,7 +80,6 @@ static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
> -static const char *curl_no_proxy;

I'm not sure whether our ordering of these variables actually means
much, but arguably it makes sense to keep the proxy-related variables
near each other, even if one of them has to be surrounded by an #if.

I guess you were going for ordering the #if's in increasing version
order. I'm not sure the existing code follows that pattern very well.

-Peff
