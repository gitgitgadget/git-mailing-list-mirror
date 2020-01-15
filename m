Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B099C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCED24671
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgAOWmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:42:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:37380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729442AbgAOWmp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 17:42:45 -0500
Received: (qmail 19811 invoked by uid 109); 15 Jan 2020 22:42:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 22:42:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 904 invoked by uid 111); 15 Jan 2020 22:49:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 17:49:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 17:42:44 -0500
From:   Jeff King <peff@peff.net>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] color.c: Support bright aixterm colors
Message-ID: <20200115224244.GB4117117@coredump.intra.peff.net>
References: <20200110111516.GA474613@coredump.intra.peff.net>
 <20200110150547.221314-1-shawarmakarma@gmail.com>
 <20200110150547.221314-2-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110150547.221314-2-shawarmakarma@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 10:05:46AM -0500, Eyal Soha wrote:

> These colors are the bright variants of the 3-bit colors.

It might be worth noting a few things we discussed. In particular:

  These can generally already be accessed as colors 8-15 of 256-color
  mode. But some terminals support these 16-color versions without
  supporting 256-color mode. And they're fewer bytes, which can make the
  output slightly more efficient.

>  color.c          | 30 +++++++++++++++++++++++-------
>  t/t4026-color.sh |  8 ++++++++
>  2 files changed, 31 insertions(+), 7 deletions(-)

I think we'd need a documentation change, too. These are discussed in
Documentation/config.txt (search for the "color::" heading).

> +	int color_offset = COLOR_FOREGROUND_ANSI;
> +	if (strncasecmp(name, "bright", 6) == 0) {
> +		color_offset = COLOR_FOREGROUND_BRIGHT_ANSI;
> +		name += 6;
> +		len -= 6;
> +	}

This drops the "+" version. I think we _could_ do both, but just having
"bright" is probably fine.

Having to repeat "6" isn't ideal, but we sadly don't have a
case-insensitive version of skip_prefix(). We could do:

  static const char bright[] = "bright";
  ...

  if (istarts_with(name, bright)) {
	color_offset = COLOR_FOREGROUND_BRIGHT_ANSI;
	name += strlen(bright);
	len -= strlen(bright);
  }

but I'm not sure if it's worth it.

> +	for (int i = 0; i < ARRAY_SIZE(color_names); i++) {
> +		if (match_word(name, len, color_names[i])) {
> +			out->type = COLOR_ANSI;
> +			out->value = i + color_offset;
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}

The 0/1 return here is unusual for our codebase. We'd usually return "0"
for success and "-1" for failure.

Otherwise, the patch looks good.

-Peff
