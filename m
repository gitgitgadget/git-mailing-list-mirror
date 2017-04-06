Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9929D209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 09:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbdDFJTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 05:19:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:57408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932395AbdDFJTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 05:19:00 -0400
Received: (qmail 31280 invoked by uid 109); 6 Apr 2017 09:18:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 09:18:59 +0000
Received: (qmail 24407 invoked by uid 111); 6 Apr 2017 09:19:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 05:19:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Apr 2017 05:18:57 -0400
Date:   Thu, 6 Apr 2017 05:18:57 -0400
From:   Jeff King <peff@peff.net>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0
Message-ID: <20170406091857.hl4ndn52kj2z4ujh@sigill.intra.peff.net>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
 <20170405130424.13803-8-tgc@jupiterrise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170405130424.13803-8-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2017 at 03:04:24PM +0200, Tom G. Christensen wrote:

> Commit 17966c0a added an unguarded use of curl_easy_strerror.
> This adds a guard so it is not used with curl < 7.12.0.
> 
> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
> ---
>  http.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/http.c b/http.c
> index a46ab23af..104caaa75 100644
> --- a/http.c
> +++ b/http.c
> @@ -2116,8 +2116,12 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>  		CURLcode c = curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE,
>  						&slot->http_code);
>  		if (c != CURLE_OK)
> +#if LIBCURL_VERSION_NUM >= 0x070c00
>  			die("BUG: curl_easy_getinfo for HTTP code failed: %s",
>  				curl_easy_strerror(c));
> +#else
> +			die("BUG: curl_easy_getinfo for HTTP code failed");
> +#endif

These kinds of interleaved conditionals make me nervous that we'll get
something wrong (especially without braces, it's not immediately clear
that both sides are a single statement).

I wonder if it would be more readable to do something like:

  #if LIBCURL_VERSION_NUM < 0x070c00
  static const char *curl_easy_strerror(CURL *curl)
  {
	return "[error code unavailable; curl version too old]";
  }
  #endif

Then callers don't have to individually deal with the ifdef. It does
mean that the user sees that kind-of ugly message, but maybe that is a
good thing. They know they need to upgrade curl to see more details.

-Peff
