Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8E7C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 02:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C6F61158
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 02:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhHGCKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 22:10:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:41666 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhHGCKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 22:10:02 -0400
Received: (qmail 17527 invoked by uid 109); 7 Aug 2021 02:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Aug 2021 02:09:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16859 invoked by uid 111); 7 Aug 2021 02:09:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Aug 2021 22:09:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Aug 2021 22:09:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] build: catch clang that identifies itself as
 "$VENDOR clang"
Message-ID: <YQ3raB5ZtPHBQWSQ@coredump.intra.peff.net>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <20210806205235.988761-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210806205235.988761-4-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 06, 2021 at 01:52:35PM -0700, Junio C Hamano wrote:

> diff --git a/detect-compiler b/detect-compiler
> index 955be1c906..11d60da5b7 100755
> --- a/detect-compiler
> +++ b/detect-compiler
> @@ -38,13 +38,10 @@ case "$(get_family)" in
>  gcc)
>  	print_flags gcc
>  	;;
> -clang)
> +clang | *" clang")
>  	print_flags clang
>  	;;
> -"FreeBSD clang")
> -	print_flags clang
> -	;;
> -"Apple LLVM"|"Apple clang")
> +"Apple LLVM")
>  	print_flags clang
>  	;;

All three patches look fine to me, and functionality-wise are a strict
improvement over the status quo. But I suspect in the long run we'd need
to keep all of the Apple bits in their own case-arm, like:

  # this must come first, so we prefer it over "* clang".
  "Apple LLVM" | "Apple clang")
	print_apple_magic
        ;;
  clang | *" clang")
        print_flags clang
        ;;

and then apple_magic does the version conversion from Wikipedia I linked
to earlier.

I don't think your patch is really making it significantly harder to get
there, though splitting up "Apple LLVM" and "Apple clang" feels a bit
like it's the wrong direction.

I wasn't personally planning to take that next step, as I lack the
platform to test it on. And as noted, unless you have a pretty old
version of Xcode, it doesn't matter either way (so I'm content to leave
it until dev with a mac is bitten by it and cares enough to make it more
accurate).

-Peff
