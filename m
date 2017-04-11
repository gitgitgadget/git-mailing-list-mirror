Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF1820970
	for <e@80x24.org>; Tue, 11 Apr 2017 13:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdDKNHG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 09:07:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdDKNHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 09:07:05 -0400
Received: (qmail 3696 invoked by uid 109); 11 Apr 2017 13:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 13:07:02 +0000
Received: (qmail 1924 invoked by uid 111); 11 Apr 2017 13:07:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 09:07:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 09:06:59 -0400
Date:   Tue, 11 Apr 2017 09:06:59 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: honnor empty http.proxy option to bypass proxy
Message-ID: <20170411130659.ehit7jdhnk43m23g@sigill.intra.peff.net>
References: <20170411092050.15867-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411092050.15867-1-ryazanov.s.a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:20:50PM +0300, Sergey Ryazanov wrote:

> diff --git a/http.c b/http.c
> index 96d84bb..8be75b2 100644
> --- a/http.c
> +++ b/http.c
> @@ -836,8 +836,14 @@ static CURL *get_curl_handle(void)
>  		}
>  	}
>  
> -	if (curl_http_proxy) {
> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +	if (curl_http_proxy && curl_http_proxy[0] == '\0') {
> +		/*
> +		 * Handle case with the empty http.proxy value here to keep
> +		 * common code clean.
> +		 * NB: empty option disables proxying at all.
> +		 */
> +		curl_easy_setopt(result, CURLOPT_PROXY, "");
> +	} else if (curl_http_proxy) {

This seems pretty reasonable. You could bump this under the existing "if
(curl_http_proxy)" condition, but that would add an extra level of
indentation to the rest of the parsing.

One thing I do wonder, though: can credential_from_url() ever return a
NULL host field for other inputs, and what should we do on those inputs?

For example, if I set the value to just "https://" with no hostname,
then I think we'll end up with a NULL proxy_auth.host field. And we'll
feed that NULL to CURLOPT_PROXY, which will cause it to use the
defaults.

I don't know _what_ "https://" should do. It's clearly bogus. But
telling curl to use the defaults seems funny. In that sense, your
original was much better (we'd feed it to curl, which would be free to
complain).

-Peff
