Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A8220834
	for <e@80x24.org>; Sun, 16 Jul 2017 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdGPKRr (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 06:17:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:41936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751048AbdGPKRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 06:17:46 -0400
Received: (qmail 23458 invoked by uid 109); 16 Jul 2017 10:17:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:17:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24451 invoked by uid 111); 16 Jul 2017 10:18:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 06:18:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 06:17:44 -0400
Date:   Sun, 16 Jul 2017 06:17:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] Makefile: disable unaligned loads with UBSan
Message-ID: <20170716101744.2g3x7v2dtasg45ll@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
 <20170710132450.yxojk5cybejy7und@sigill.intra.peff.net>
 <de9c876c-f018-ad6b-3813-576ea73dd49a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de9c876c-f018-ad6b-3813-576ea73dd49a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 15, 2017 at 07:18:56PM +0200, René Scharfe wrote:

> -- >8 --
> Subject: [PATCH] Makefile: allow combining UBSan with other sanitizers
> 
> Multiple sanitizers can be specified as a comma-separated list.  Set
> the flag NO_UNALIGNED_LOADS even if UndefinedBehaviorSanitizer is not
> the only sanitizer to build with.

Nice, I didn't know you could do comma-separation here. ;)

I always just built the various sanitizers separately since I was
testing whether each one worked. But if we can get UBSan to build
cleanly, I agree that "make SANITIZE=address,undefined test" would be a
nice thing to run periodically.

> diff --git a/Makefile b/Makefile
> index ba4359ef8d..9b98535a04 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1022,10 +1022,15 @@ ifdef DEVELOPER
>  CFLAGS += $(DEVELOPER_CFLAGS)
>  endif
>  
> +comma := ,
> +empty :=
> +space := $(empty) $(empty)
> +
>  ifdef SANITIZE
> +SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
>  BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>  BASIC_CFLAGS += -fno-omit-frame-pointer
> -ifeq ($(SANITIZE),undefined)
> +ifneq ($(filter undefined,$(SANITIZERS)),)

The implementation is convoluted in the way that "make" usually forces
us into. ;)

I would have written it as:

  ifeq ($findstring $(SANITIZERS), undefined), undefined)

but I think your version:

  1. Isn't fooled by superstrings like a potential undefined-foo
     sanitizer.

  2. Handles SANITIZE=undefined,undefined correctly.

Neither are expected, but it doesn't hurt to be a bit more robust.

-Peff
