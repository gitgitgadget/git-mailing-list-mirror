Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486111F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbcI1RQP (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:16:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:49473 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932856AbcI1RQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:16:13 -0400
Received: (qmail 19541 invoked by uid 109); 28 Sep 2016 17:16:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 17:16:12 +0000
Received: (qmail 26676 invoked by uid 111); 28 Sep 2016 17:16:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 13:16:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2016 13:16:10 -0400
Date:   Wed, 28 Sep 2016 13:16:10 -0400
From:   Jeff King <peff@peff.net>
To:     Petr Stodulka <pstodulk@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: Control GSSAPI credential delegation.
Message-ID: <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
References: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 06:05:52PM +0200, Petr Stodulka wrote:

> Delegation of credentials is disabled by default in libcurl since
> version 7.21.7 due to security vulnerability CVE-2011-2192. Which
> makes troubles with GSS/kerberos authentication where delegation
> of credentials is required. This can be changed with option
> CURLOPT_GSSAPI_DELEGATION in libcurl with set expected parameter
> since libcurl version 7.22.0.

I don't have any real knowledge of GSSAPI, so I'll refrain from
commenting on that aspect. But I did notice one mechanical issue:

> +#if LIBCURL_VERSION_NUM >= 0x071600
> +static const char *curl_deleg;
> +static struct {
> +	const char *name;
> +	long curl_deleg_param;
> +} curl_deleg_levels[] = {
> +	{ "none", CURLGSSAPI_DELEGATION_NONE },
> +	{ "policy", CURLGSSAPI_DELEGATION_POLICY_FLAG },
> +	{ "always", CURLGSSAPI_DELEGATION_FLAG },
> +};
> +#endif

We only declare the curl_deleg variable if we have a new-enough curl.
But...

> @@ -323,6 +335,10 @@ static int http_options(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.delegation", var)) {
> +		return git_config_string(&curl_deleg, var, value);
> +	}
> +

...here we try to use it regardless. I think you want another #ifdef,
and probably to warn the user in the #else block (similar to what the
http.pinnedpubkey code does).

-Peff
