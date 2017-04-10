Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F2B20966
	for <e@80x24.org>; Mon, 10 Apr 2017 16:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbdDJQdx (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 12:33:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:59250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751921AbdDJQdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 12:33:52 -0400
Received: (qmail 8865 invoked by uid 109); 10 Apr 2017 16:33:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 16:33:52 +0000
Received: (qmail 26504 invoked by uid 111); 10 Apr 2017 16:34:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 12:34:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 12:33:50 -0400
Date:   Mon, 10 Apr 2017 12:33:50 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: honnor empty http.proxy option to bypass proxy
Message-ID: <20170410163350.3zqm33tgqafsp76u@sigill.intra.peff.net>
References: <20170410151556.10054-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170410151556.10054-1-ryazanov.s.a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 06:15:56PM +0300, Sergey Ryazanov wrote:

> Curl distinguish between empty proxy address and NULL proxy address. In
> the first case it completly disable proxy usage, but if proxy address
> option is NULL then curl attempt to determine proxy address from
> http_proxy environment variable.
> 
> According to documentation, if http.proxy configured to empty string
> then git should bypass proxy and connects to the server directly:
> 
>     export http_proxy=http://network-proxy/
>     cd ~/foobar-project
>     git config remote.origin.proxy ""
>     git fetch
> 
> Previously, proxy host was configured by one line:
> 
>     curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> 
> Commit 372370f (http: use credential API to handle proxy auth...) parses
> proxy option, extracts proxy host address and additionaly updates curl
> configuration:
> 
>     credential_from_url(&proxy_auth, curl_http_proxy);
>     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
> 
> But if proxy option is empty then proxy host field become NULL this
> force curl to fallback to proxy configuration detection from
> environment. This caused empty http.proxy option not working any more.

That makes sense. And if I understand correctly, this was a regression
in 372370f; before that we fed curl_http_proxy directly, and it was
either NULL or not, depending on whether we had seen the config option.

It looks like we _still_ set CURLOPT_PROXY to curl_http_proxy, and then
immediately afterward set it to proxy_auth.host. That should make the
first one always a noop, I would think, and it should be removed.

But...

> diff --git a/http.c b/http.c
> index 96d84bb..bf0e709 100644
> --- a/http.c
> +++ b/http.c
> @@ -861,7 +861,12 @@ static CURL *get_curl_handle(void)
>  			strbuf_release(&url);
>  		}
>  
> -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
> +		/*
> +		 * Avoid setting CURLOPT_PROXY to NULL if empty http.proxy
> +		 * option configured.
> +		 */
> +		if (proxy_auth.host)
> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

Here that second one becomes conditional, and we rely on the earlier
setting (but only sometimes). I would think this whole thing would be
more clear if we dropped the first CURLOPT_PROXY call entirely, and just
did:

  /*
   * If we parsed a null host from the URL, we must convert that
   * back into an empty string so that curl knows we want no proxy at
   * all (not to find the default).
   */
  curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host ?
                                          proxy_auth.host : "");

-Peff
