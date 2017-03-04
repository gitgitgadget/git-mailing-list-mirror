Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DAE20133
	for <e@80x24.org>; Sat,  4 Mar 2017 03:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdCDDT7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 22:19:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:38476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdCDDT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 22:19:59 -0500
Received: (qmail 2452 invoked by uid 109); 4 Mar 2017 03:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 03:13:17 +0000
Received: (qmail 2982 invoked by uid 111); 4 Mar 2017 03:13:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 22:13:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 22:13:14 -0500
Date:   Fri, 3 Mar 2017 22:13:14 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH] http: inform about alternates-as-redirects behavior
Message-ID: <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
References: <20170304013504.GA27183@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304013504.GA27183@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2017 at 01:35:04AM +0000, Eric Wong wrote:

> It is disconcerting for users to not notice the behavior
> change in handling alternates from commit cb4d2d35c4622ec2
> ("http: treat http-alternates like redirects")
> 
> Give the user a hint about the config option so they can
> see the URL and decide whether or not they want to enable
> http.followRedirects in their config.

Yeah, I agree it makes sense to notify the user.

> diff --git a/http-walker.c b/http-walker.c
> index b34b6ace7..626badfe6 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -168,6 +168,12 @@ static int is_alternate_allowed(const char *url)
>  	};
>  	int i;
>  
> +	if (http_follow_config != HTTP_FOLLOW_ALWAYS) {
> +		warning("alternate disabled by http.followRedirects!=true: %s",
> +			url);
> +		return 0;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(protocols); i++) {
>  		const char *end;
>  		if (skip_prefix(url, protocols[i], &end) &&
> @@ -331,9 +337,6 @@ static void fetch_alternates(struct walker *walker, const char *base)
>  	struct alternates_request alt_req;
>  	struct walker_data *cdata = walker->data;
>  
> -	if (http_follow_config != HTTP_FOLLOW_ALWAYS)
> -		return;
> -

I was surprised from the description to see not just the addition of a
warning, but a movement of the enforcement code.

I think it's necessary because the original did not bother even fetching
http-alternates if we were not going to respect it. Whereas the new code
will fetch and parse it, and warn only if we actually found something in
it. Which seems reasonable.

The warning itself:

> +		warning("alternate disabled by http.followRedirects!=true: %s",

feels like it could use some whitespace around the "!=", but maybe
that's just me.

-Peff
