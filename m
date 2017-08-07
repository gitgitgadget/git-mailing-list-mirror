Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DAA12047F
	for <e@80x24.org>; Mon,  7 Aug 2017 20:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdHGUBa (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 16:01:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:59580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751505AbdHGUB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 16:01:29 -0400
Received: (qmail 28112 invoked by uid 109); 7 Aug 2017 20:01:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 20:01:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10072 invoked by uid 111); 7 Aug 2017 20:01:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 16:01:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Aug 2017 16:01:26 -0400
Date:   Mon, 7 Aug 2017 16:01:26 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] imap-send: use curl by default
Message-ID: <20170807200126.fnbz57qd44vj43c6@sigill.intra.peff.net>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 04:04:05PM +0200, Nicolas Morey-Chaisemartin wrote:

> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>

Thanks for moving forward with this.

Can you please flesh out your commit messages with some of the reasoning
and related discussion? I know from a nearby thread why we want to flip
the default, but people reading `git log` much later will not have that
context.

> diff --git a/imap-send.c b/imap-send.c
> index 90b8683ed..4ebc16437 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -35,13 +35,7 @@ typedef void *SSL;
>  #include "http.h"
>  #endif
>  
> -#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
> -/* only available option */
>  #define USE_CURL_DEFAULT 1
> -#else
> -/* strictly opt in */
> -#define USE_CURL_DEFAULT 0
> -#endif

I agree with the comments Martin made here. I think there are really two
levels of "default" we need to care about:

  1. Build-time: do we default to requiring curl if you want imap-send
     at all?

  2. Run-time: if build with both implementations, which do we use by
     default? Related, if there is only one implementation, what should
     the default be?

I think the answer to (1) is that we still want to build imap-send
without USE_CURL_FOR_IMAP_SEND if the user doesn't have curl installed.
And your patch leaves that, which is good. Though if we are deprecating
it, we may want to issue a deprecation warning (eventually; we can still
switch the run-time default now, get more data on whether a
deprecation/switch is a good idea, and then later decide to deprecate).

For (2), you're trying to switch the default when both are built. But I
think it's important to continue to default to the old-style
implementation if that's the only thing that was built. Otherwise it
effectively becomes the build-time deprecation warning, and we're not
quite ready for that.

So I think this maybe needs to be:

  #if defined(USE_CURL_FOR_IMAP_SEND)
  /* Always default to curl if it's available. */
  #define USE_CURL_DEFAULT 1
  #else
  /* We don't have curl, so continue to use the historical implementation */
  #define USE_CURL_DEFAULT 0
  #endif

-Peff
