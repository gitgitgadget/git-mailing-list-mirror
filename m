Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25345201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbdKLPhC (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:37:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:54026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751012AbdKLPhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 10:37:02 -0500
Received: (qmail 4258 invoked by uid 109); 12 Nov 2017 15:37:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 15:37:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15463 invoked by uid 111); 12 Nov 2017 15:37:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 10:37:14 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 15:37:00 +0000
Date:   Sun, 12 Nov 2017 15:37:00 +0000
From:   Jeff King <peff@peff.net>
To:     Soukaina NAIT HMID <nhsoukaina@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [add-default-config 2/5] adding default to color
Message-ID: <20171112153659.lt77rn6h6faeqfpb@sigill.intra.peff.net>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
 <0102015fb0bf3002-3462777a-2363-40cf-af37-80e26c0db65b-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015fb0bf3002-3462777a-2363-40cf-af37-80e26c0db65b-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 03:00:40PM +0000, Soukaina NAIT HMID wrote:

> diff --git a/builtin/config.c b/builtin/config.c
> index 124a682d50fa8..9df2d9c43bcad 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -30,6 +30,7 @@ static int end_null;
>  static int respect_includes_opt = -1;
>  static struct config_options config_options;
>  static int show_origin;
> +static const char *default_value;
> [...]
> +	OPT_STRING(0, "default", &default_value, N_("default-value"), N_("sets default for bool/int/path/color when no value is returned from config")),

These hunks make sense. We're adding a new "--default" option that would
kick in when you try to look up a key and it isn't present.

I think we can skip the "bool/int/path/color" thing in the help string.
We would want this to kick in for every type, right?  The only
constraint is that we are doing a "get" operation. It wouldn't make any
sense to use "--default" when setting a variable, listing, etc. Should
we catch these cases and return an error?

We'd also want to mention this in Documentation/git-config.txt.

> @@ -47,6 +48,7 @@ static int show_origin;
>  #define ACTION_GET_COLOR (1<<13)
>  #define ACTION_GET_COLORBOOL (1<<14)
>  #define ACTION_GET_URLMATCH (1<<15)
> +#define ACTION_GET_COLORORDEFAULT (1<<16)

I'm not sure I understand this part, though. Providing a default should
be something that goes along with a "get" action, but isn't its own
action.

> +static void get_color_default(const char *var)
> +{
> +	get_color(var, default_value);
> +}
> +

And here we're just applying --default to colors, but we'd eventually
want them for everything. I think that's fixed later in the series, so
I'll keep reading. But I'd expect a function like get_value() to be
detecting the case where we got no hits and filling in the default_value
there, as if we had read it from the config file.

-Peff
