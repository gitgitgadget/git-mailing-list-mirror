Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEAB1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755545AbcLAVkI (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 16:40:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:50244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbcLAVkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 16:40:08 -0500
Received: (qmail 19126 invoked by uid 109); 1 Dec 2016 21:40:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 21:40:07 +0000
Received: (qmail 4572 invoked by uid 111); 1 Dec 2016 21:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 16:40:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 16:40:04 -0500
Date:   Thu, 1 Dec 2016 16:40:04 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480623959-126129-5-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 12:25:59PM -0800, Brandon Williams wrote:

> Add the from_user parameter to the 'is_transport_allowed' function.
> This allows callers to query if a transport protocol is allowed, given
> that the caller knows that the protocol is coming from the user (1) or
> not from the user (0), such as redirects in libcurl.  If unknown, a -1
> should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
> to determine if the protocol came from the user.

Patches 3 and 4 look good to me (1 and 2 are unchanged, right? They are
already in 'next' anyway, though I guess we are due for a post-release
reset of 'next').

> diff --git a/http.c b/http.c
> index fee128b..e74c0f0 100644
> --- a/http.c
> +++ b/http.c
> @@ -725,13 +725,13 @@ static CURL *get_curl_handle(void)
>  	curl_easy_setopt(result, CURLOPT_POST301, 1);
>  #endif
>  #if LIBCURL_VERSION_NUM >= 0x071304
> -	if (is_transport_allowed("http"))
> +	if (is_transport_allowed("http", 0))
>  		allowed_protocols |= CURLPROTO_HTTP;
> -	if (is_transport_allowed("https"))
> +	if (is_transport_allowed("https", 0))
>  		allowed_protocols |= CURLPROTO_HTTPS;
> -	if (is_transport_allowed("ftp"))
> +	if (is_transport_allowed("ftp", 0))
>  		allowed_protocols |= CURLPROTO_FTP;
> -	if (is_transport_allowed("ftps"))
> +	if (is_transport_allowed("ftps", 0))
>  		allowed_protocols |= CURLPROTO_FTPS;
>  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
>  #else

This is better, but I think we still need to deal with http-alternates
on top.

I think we'd need to move this allowed_protocols setup into a function
like:

  int generate_allowed_protocols(int from_user)
  {
	int ret;
	if (is_transport_allowed("http", from_user))
		ret |= CURLPROTO_HTTP;
	... etc ...
	return ret;
  }

and then create a protocol list for each situation:

  allowed_protocols = generate_allowed_protocols(-1);
  allowed_redir_protocols = generate_allowed_protocols(0);

and then we know we can always set up the redir protocols:

  curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_redir_protocols);

and which we feed for CURLOPT_PROTOCOLS depends on whether we are
following an http-alternates redirect or not. But I suspect it will be a
nasty change to plumb through the idea of "this request is on behalf of
an http-alternates redirect".

Given how few people probably care, I'm tempted to document it as a
quirk and direct people to the upcoming http.followRedirects. The newly
proposed default value of that disables http-alternates entirely anyway.

-Peff
