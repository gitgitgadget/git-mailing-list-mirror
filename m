Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6AC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12754206B2
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgKFU4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 15:56:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:50336 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgKFU4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 15:56:20 -0500
Received: (qmail 20850 invoked by uid 109); 6 Nov 2020 20:56:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Nov 2020 20:56:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4335 invoked by uid 111); 6 Nov 2020 20:56:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Nov 2020 15:56:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Nov 2020 15:56:18 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <20201106205618.GA197338@coredump.intra.peff.net>
References: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
 <20201106181804.GA183267@coredump.intra.peff.net>
 <a654c95f-2367-5805-d4f8-56c466a141d4@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a654c95f-2367-5805-d4f8-56c466a141d4@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 06, 2020 at 07:38:06PM +0000, Ramsay Jones wrote:

> I hadn't done so yet, but I had planned to modify the GIT-VERSION-GEN script
> (with -v parameter, say) to just output the version to stdout, because it
> would save a sed invocation. It currently looks something like this:
> 
>   diff --git a/Makefile b/Makefile
>   index 372139f1f2..f166fbe067 100644
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -493,7 +493,11 @@ all::
>  
>    GIT-VERSION-FILE: FORCE
>           @$(SHELL_PATH) ./GIT-VERSION-GEN
>   --include GIT-VERSION-FILE
>   +
>   +ifeq ($(wildcard GIT-VERSION-FILE),)
>   +$(shell ./GIT-VERSION-GEN)
>   +endif
>   +GIT_VERSION = $(eval GIT_VERSION := $$(shell cat GIT-VERSION-FILE | sed -e 's/^GIT_VERSION = //'))$(GIT_VERSION)

Yeah, not too surprising. If we grow a lot of these fill-in-the-value
stubs, it might be worth abstracting it out into a function (using
$(call) should be OK, as even Apple's ancient version of GNU make has
it).

I do think the one that evals an "include" might end up being more
readable and flexible, though. I'm not sure if the include needs to be
more aggressive about using ":=" though (in a simple test it didn't seem
to be, and since we'll be filling in a concrete value that's OK to
evaluate multiple times, I think it would be OK).

> Ignore the 'ifeq' for now (I had several versions, including getting rid
> of the GIT-VERSION-FILE rule, but that caused problems without changing
> the Documentation/Makefile, and several others ... (including in contrib)).

Yeah, I didn't look at all at what complications we might get from other
Makefiles. Though if everything is literally running `GIT-VERSION-GEN`
directly then I think they could all use the same code.

> So, I haven't worked everything out yet, but I had planned to look at
> this next.

Sounds good. I mostly wanted to plant the seed in your head. Finding
that it was already growing is better still. :)

-Peff
