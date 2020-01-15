Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C06CC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAEF24671
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgAOWdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:33:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:37364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728899AbgAOWdK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 17:33:10 -0500
Received: (qmail 19758 invoked by uid 109); 15 Jan 2020 22:33:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 22:33:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 838 invoked by uid 111); 15 Jan 2020 22:39:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 17:39:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 17:33:09 -0500
From:   Jeff King <peff@peff.net>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums
Message-ID: <20200115223309.GA4117117@coredump.intra.peff.net>
References: <20200110111516.GA474613@coredump.intra.peff.net>
 <20200110150547.221314-1-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110150547.221314-1-shawarmakarma@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 10:05:45AM -0500, Eyal Soha wrote:

> Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
> ---
>  color.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)

The patch itself looks good, but it would be nice to have a commit
message explaining what's going on and why. Maybe something like:

  Using an enum reduces the number of magic numbers in the code. Note
  that we also use values that allow easier computations. For example,
  colors with type COLOR_ANSI now store the actual foreground code we
  expect (e.g., red=31) instead of an offset into our array, and we can
  switch between foreground/background for all types by adding an
  offset. That will help when we add new color types in a future patch.

> @@ -280,13 +286,13 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>  			if (sep++)
>  				OUT(';');
>  			/* foreground colors are all in the 3x range */
> -			dst = color_output(dst, end - dst, &fg, '3');
> +			dst = color_output(dst, end - dst, &fg, 0);
>  		}
>  		if (!color_empty(&bg)) {
>  			if (sep++)
>  				OUT(';');
>  			/* background colors are all in the 4x range */
> -			dst = color_output(dst, end - dst, &bg, '4');
> +			dst = color_output(dst, end - dst, &bg, COLOR_BACKGROUND_OFFSET);
>  		}

Your original dropped the comments here, since we're not saying "3" or
"4" literally anymore. I could go either way, but I think I slightly
preferred dropping them. It might be even nicer if we had
COLOR_FOREGROUND_OFFSET = 0, which you could use instead of the bare
"0".

-Peff
