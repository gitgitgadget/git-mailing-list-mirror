Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ACDC43457
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51D5221FD
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgJHQIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:08:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:53896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHQIR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 12:08:17 -0400
Received: (qmail 29559 invoked by uid 109); 8 Oct 2020 16:08:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Oct 2020 16:08:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25126 invoked by uid 111); 8 Oct 2020 16:08:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Oct 2020 12:08:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Oct 2020 12:08:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
Message-ID: <20201008160816.GC2823778@coredump.intra.peff.net>
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 12:06:47PM +0200, Johannes Schindelin wrote:

> My little script also finds this:
> 
> -- snip --
> @@ -1231,8 +1231,8 @@ space := $(empty) $(empty)
> 
>  ifdef SANITIZE
>  SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
> -BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>  BASIC_CFLAGS += -fno-omit-frame-pointer
> +BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>  ifneq ($(filter undefined,$(SANITIZERS)),)
>  BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
>  endif
> -- snap --
> 
> I am not _so_ sure that we want to order `BASIC_CFLAGS`, but then, it does
> not hurt, does it?

I agree it would not be wrong to reorder here from the compiler's
perspective, but:

  - the current ordering is not arbitrary; the intent was to show that
    we are enabling -fsanitize, and then follow it up with any other
    related options (first any that apply to all sanitizers, of which
    there is only one, and then any sanitizer-specific ones). The patch
    above splits that logic apart.

  - I'd worry that there are cases in which order _does_ matter to the
    compiler. I'm not sure if anything that goes in CFLAGS might
    qualify, but certainly order can matter for other parts of the
    command-line (e.g., static library order).

    So it might be setting us up for confusion later.

-Peff
