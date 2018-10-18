Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7095E1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 17:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJSBDk (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 21:03:40 -0400
Received: from avasout02.plus.net ([212.159.14.17]:52562 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSBDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 21:03:39 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id DBg9goVQD4OhTDBgAgNL1r; Thu, 18 Oct 2018 18:01:47 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NKr7BXyg c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=toPC2ywZNuCD_NLFrwsA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] config.mak.dev: enable -Wunused-function
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20181018070522.GA29499@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3295c759-473b-f279-5443-f915fd0b1061@ramsayjones.plus.com>
Date:   Thu, 18 Oct 2018 18:01:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018070522.GA29499@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCmcrc+ipywwT+w55gCPei1T2bjNRmxPV6E2GzCBKZuQjl3HxN5p+igXdnbLkBPxOqFxUxB5PhBVglubhMqHKWOsQriboF0YgV5dlQ/PC04A1i7TPAmh
 qBy43tDVvTycLOIqN0BhIWWkvND0xvPtNdcgEYXvnbNzMPZAB5xsCXzzRmxCdq01fxElBOdh1s96Iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/10/2018 08:05, Jeff King wrote:
> We explicitly omitted -Wunused-function when we added
> -Wextra, but there is no need: the current code compiles
> cleanly with it. And it's worth having, since it can let you
> know when there are cascading effects from a cleanup (e.g.,
> deleting one function lets you delete its static helpers).
> 
> There are cases where we may need an unused function to
> exist, but we can handle these easily:
> 
>   - macro-generated code like commit-slab; there we have the
>     MAYBE_UNUSED annotation to silence the compiler
> 
>   - conditional compilation, where we may or may not need a
>     static helper. These generally fall into one of two
>     categories:
> 
>       - the call should not be conditional, but rather the
> 	function body itself should be (and may just be a
> 	no-op on one side of the #if). That keeps the
> 	conditional pollution out of the main code.
> 
>       - call-chains of static helpers should all be in the
>         same #if block, so they are all-or-nothing
> 
>     And if there's some case that doesn't cover, we still
>     have MAYBE_UNUSED as a fallback.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.mak.dev | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/config.mak.dev b/config.mak.dev
> index 92d268137f..bbeeff44fe 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -34,7 +34,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
>  CFLAGS += -Wno-empty-body
>  CFLAGS += -Wno-missing-field-initializers
>  CFLAGS += -Wno-sign-compare
> -CFLAGS += -Wno-unused-function
>  CFLAGS += -Wno-unused-parameter
>  endif
>  endif
> 

Heh, as luck would have it, tonight I had an -Wunused-function
warning on cygwin, but not Linux, when building the 'pu' branch.

[On linux, I am using DEVELOPER=1 in my config.mak etc., whereas
on cygwin I am still using an explicit (but very similar) list
of -W args.]

I haven't looked too deeply, but this seems to be caused by
Junio's commit 42c89ea70a ("SQUASH??? - convert the other user of
string-list as db", 2018-10-17) which removes a call to the
add_existing() function - the subject of the warning.

[BTW there is another 'static add_existing()' in builtin/show_ref.c]

ATB,
Ramsay Jones

