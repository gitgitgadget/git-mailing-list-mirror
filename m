Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93554C77B73
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjESAT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjESATE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:19:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F819A5
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:18:46 -0700 (PDT)
Received: (qmail 6219 invoked by uid 109); 19 May 2023 00:18:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:18:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26821 invoked by uid 111); 19 May 2023 00:18:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:18:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:18:03 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] fetch: pass through `fetch_config` directly
Message-ID: <20230519001803.GC2442034@coredump.intra.peff.net>
References: <cover.1684324059.git.ps@pks.im>
 <b09f21dff786780dfb0ae71efd9a0cabe31c1e0b.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b09f21dff786780dfb0ae71efd9a0cabe31c1e0b.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 01:48:51PM +0200, Patrick Steinhardt wrote:

> The `fetch_config` structure currently only has a single member, which
> is the `display_format`. We're about extend it to contain all parsed
> config values and will thus need it available in most of the code.
> 
> Prepare for this change by passing through the `fetch_config` directly
> instead of only passing its single member.

Makes sense.

One small nit:

>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs,
> -		    enum display_format display_format)
> +		    const struct fetch_config *config)
>  {
>  	struct ref_transaction *transaction = NULL;
>  	struct ref *ref_map = NULL;
> @@ -1639,7 +1639,8 @@ static int do_fetch(struct transport *transport,
>  	if (retcode)
>  		goto cleanup;
>  
> -	display_state_init(&display_state, ref_map, transport->url, display_format);
> +	display_state_init(&display_state, ref_map, transport->url,
> +			   config->display_format);

If the point is that fetch_config may start carrying new information,
wouldn't we want to pass it as a whole down to display_state_init()? It
might eventually want to see some of that other config, too.

It's presumably academic for now, and it would not be too hard to change
later if needed, so I don't know that it's worth a re-roll. I just found
it especially funny here since the purpose of the patch is to treat the
config struct as a single unit.

-Peff
