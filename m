Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FB01F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbcHOULC (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:11:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:55767 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932346AbcHOULB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:11:01 -0400
Received: (qmail 8453 invoked by uid 109); 15 Aug 2016 20:11:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 20:11:01 +0000
Received: (qmail 19325 invoked by uid 111); 15 Aug 2016 20:11:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 16:11:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 16:10:58 -0400
Date:	Mon, 15 Aug 2016 16:10:58 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 1/3] index-pack: add --max-input-size=<size> option
Message-ID: <20160815201058.v2u24nnu6rjwlr2k@sigill.intra.peff.net>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
 <20160815195729.16826-2-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160815195729.16826-2-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 09:57:27PM +0200, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> When receiving a pack-file, it can be useful to abort the
> `git index-pack`, if the pack-file is too big.

Not much rationale here. I guess because it is all in the 3rd patch,
which ties it into receive-pack. I'm not sure it's worth repeating. I
guess it could all be squished back into one patch. I'm OK either way.

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 1d2ea58..1fd60bd 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -87,6 +87,7 @@ static struct progress *progress;
>  static unsigned char input_buffer[4096];
>  static unsigned int input_offset, input_len;
>  static off_t consumed_bytes;
> +static off_t max_input_size;
>  static unsigned deepest_delta;
>  static git_SHA_CTX input_ctx;
>  static uint32_t input_crc32;
> @@ -297,6 +298,8 @@ static void use(int bytes)
>  	if (signed_add_overflows(consumed_bytes, bytes))
>  		die(_("pack too large for current definition of off_t"));
>  	consumed_bytes += bytes;
> +	if (max_input_size && consumed_bytes > max_input_size)
> +		die(_("pack exceeds maximum allowed size"));

Looks good. I see you marked it for translation, which makes sense.

On the original, I waffled on whether to share the size with the user in
the message. I didn't want to encourage people with "oh, if it's under
2G it must be OK, then!". Because really 2G was meant to be a "you
really shouldn't get this high, and we will unceremoniously dump your
push if you do".

>  static const char *open_pack_file(const char *pack_name)
> @@ -1714,6 +1717,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  					opts.off32_limit = strtoul(c+1, &c, 0);
>  				if (*c || opts.off32_limit & 0x80000000)
>  					die(_("bad %s"), arg);
> +			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
> +				max_input_size = strtoul(arg, NULL, 10);

max_input_size is an off_t, but your parse only up to ULONG_MAX here.
For my purposes in the original patch, this was OK, as we set it at 2GB,
which works everywhere (and also, GitHub systems all have 64-bit "long"
these days). But somebody on a 32-bit system could not set this to 4GB,
even though I think index-pack could otherwise handle it. We seem to use
strtoumax() elsewhere, so that's probably a good match (technically it
can overflow an off_t, but in practice this value comes from the admin
and they will set something sane).

-Peff
