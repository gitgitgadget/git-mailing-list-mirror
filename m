Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A0C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D72071A
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKXRGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:06:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:59380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726887AbfKXRGp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:06:45 -0500
Received: (qmail 21027 invoked by uid 109); 24 Nov 2019 17:06:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Nov 2019 17:06:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12886 invoked by uid 111); 24 Nov 2019 17:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 24 Nov 2019 12:10:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 24 Nov 2019 12:06:43 -0500
From:   Jeff King <peff@peff.net>
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` definition
Message-ID: <20191124170643.GA16907@sigill.intra.peff.net>
References: <pull.473.git.1574600963.gitgitgadget@gmail.com>
 <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 24, 2019 at 01:09:23PM +0000, Hariom Verma via GitGitGadget wrote:

> From: Hariom Verma <hariom18599@gmail.com>
> 
> Git's code base already seems to be using `PRIdMAX` without any such
> fallback definition for quite a while (75459410edd (json_writer: new
> routines to create JSON data, 2018-07-13), to be precise, and the
> first Git version to include that commit was v2.19.0).
> 
> Therefore it should be safe to drop the fallback definition for
> `PRIuMAX` in `git-compat-util.h`.

I noticed this recently, too, and wondered if it was time for a cleanup.

We do sometimes get portability reports more than a year after the
problem was introduced. But I think this one is pretty safe. PRIuMAX is
in C99, and we've been picking up other C99-isms without complaint.

I was curious what system originally spurred this. The PRIuMAX
definition was originally added in 3efb1f343a (Check for PRIuMAX rather
than NO_C99_FORMAT in fast-import.c., 2007-02-20). But it was replacing
a construct that was introduced in 579d1fbfaf (Add NO_C99_FORMAT to
support older compilers., 2006-07-30), which talks about gcc 2.95.
That's pretty ancient at this point.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 607dca7534..ba710cfa6c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -320,10 +320,6 @@ char *gitdirname(char *);
>  #define PATH_MAX 4096
>  #endif
>  
> -#ifndef PRIuMAX
> -#define PRIuMAX "llu"
> -#endif
> -

This part of the patch looks obviously correct. :) But...

>  #ifndef SCNuMAX
>  #define SCNuMAX PRIuMAX
>  #endif

Can we likewise ditch the fallback definition for SCNuMAX? And PRIu32,
etc? It seems likely any platform would either have all of them or none.

-Peff
