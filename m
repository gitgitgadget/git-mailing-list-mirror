Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B403D202DD
	for <e@80x24.org>; Tue, 11 Jul 2017 04:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdGKEoE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 00:44:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:36508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751162AbdGKEoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 00:44:03 -0400
Received: (qmail 21349 invoked by uid 109); 11 Jul 2017 04:44:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 04:44:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12170 invoked by uid 111); 11 Jul 2017 04:44:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 00:44:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 00:44:01 -0400
Date:   Tue, 11 Jul 2017 00:44:01 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] Makefile: add helper for compiling with -fsanitize
Message-ID: <20170711044401.pf7gmovxe7yss2s7@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
 <20170710132442.epsox4rawxlyvrw3@sigill.intra.peff.net>
 <xmqqefto6vqb.fsf@gitster.mtv.corp.google.com>
 <20170710174454.jbkednmzwts7yr7z@sigill.intra.peff.net>
 <752db1ea-8416-3a98-babf-78b766432f0f@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <752db1ea-8416-3a98-babf-78b766432f0f@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 09:02:24PM +0100, Ramsay Jones wrote:

> After a quick look at the ./t0000-basic.sh test, I managed to get
> the test to complete (with 15 tests failing), with the following
> patch applied:
> 
> -- >8 --
> diff --git a/Makefile b/Makefile
> index 3c341b2a6..8e6433738 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1016,7 +1016,7 @@ ifdef SANITIZE
>  BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>  BASIC_CFLAGS += -fno-omit-frame-pointer
>  ifeq ($(SANITIZE),undefined)
> -BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
> +BASIC_CFLAGS += -DNO_UNALIGNED_LOADS -DSHA1DC_FORCE_ALIGNED_ACCESS
>  endif
>  endif

Thanks, I forgot to mention SHA1DC. When I had originally tested with
"undefined", it was before we had SHA1DC. I hacked around it earlier
today by just using OPENSSL_SHA1. ;)

I agree if we can ask it to avoid unaligned access that is even better.

> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 25eded139..3baddc636 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -118,6 +118,10 @@
>  #define SHA1DC_ALLOW_UNALIGNED_ACCESS
>  #endif /*UNALIGNMENT DETECTION*/
>  
> +#if defined(SHA1DC_ALLOW_UNALIGNED_ACCESS) && defined(SHA1DC_FORCE_ALIGNED_ACCESS)
> +#undef SHA1DC_ALLOW_UNALIGNED_ACCESS
> +#endif

I think our current strategy is to avoid touching sha1.c as much as
possible. I think we'd prefer a patch to the upstream project to support
FORCE_ALIGNED_ACCESS (unfortunately I do not see a way to tweak it using
only external defines.

-Peff
