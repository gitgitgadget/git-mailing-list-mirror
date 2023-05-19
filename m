Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186FC77B73
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjESANN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjESANM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:13:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D1C13D
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:13:10 -0700 (PDT)
Received: (qmail 6179 invoked by uid 109); 19 May 2023 00:13:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:13:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26725 invoked by uid 111); 19 May 2023 00:13:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:13:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:13:09 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/9] fetch: drop unused DISPLAY_FORMAT_UNKNOWN enum value
Message-ID: <20230519001309.GA2442034@coredump.intra.peff.net>
References: <cover.1684324059.git.ps@pks.im>
 <9417a62e9bbd30d9350b65e5396a31f9cb7c60b6.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9417a62e9bbd30d9350b65e5396a31f9cb7c60b6.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 01:48:42PM +0200, Patrick Steinhardt wrote:

> With 50957937f9 (fetch: introduce `display_format` enum, 2023-05-10), a
> new enumeration was introduced to determine the display format that is
> to be used by git-fetch(1). The `DISPLAY_FORMAT_UNKNOWN` value isn't
> ever used though, and neither do we rely on the explicit `0` value for
> initialization anywhere.

To be slightly pedantic, we'd also want to make sure the we do not rely
on the zero value for reading, like:

  if (display_state->format)
     ....

But having looked over the code, we don't (it's always a switch or
equality with a known name), so this is safe to do.

Thanks for cleaning this up.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 849a9be421..9147b700e5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -58,7 +58,6 @@ enum {
>  };
>  
>  enum display_format {
> -	DISPLAY_FORMAT_UNKNOWN = 0,
>  	DISPLAY_FORMAT_FULL,
>  	DISPLAY_FORMAT_COMPACT,
>  	DISPLAY_FORMAT_PORCELAIN,

Just for similar situations in the future, I think we could do:

  DISPLAY_FORMAT_FULL = 1,

if we were worried about keeping the zero-behavior the same for existing
callers. But given how new and how limited this code is, I feel
confident that we've checked all of the code, and what you've written
above is preferable.

-Peff
