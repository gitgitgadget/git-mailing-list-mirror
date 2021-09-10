Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6832C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C489360F92
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhIJPGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:06:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:43980 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJPGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:06:02 -0400
Received: (qmail 5982 invoked by uid 109); 10 Sep 2021 15:04:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:04:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25918 invoked by uid 111); 10 Sep 2021 15:04:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:04:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:04:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 3/8] Makefile: drop support for curl < 7.9.8 (again)
Message-ID: <YTt0EpbdmYVlu1zR@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-3.8-76c2aa6e78d-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-3.8-76c2aa6e78d-20210910T105523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 01:04:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In 1119a15b5c8 (http: drop support for curl < 7.11.1, 2021-07-30)
> support for curl versions older than 7.11.1 was removed, and we
> currently require at least version 7.19.4, see 644de29e220 (http: drop
> support for curl < 7.19.4, 2021-07-30).
> 
> In those changes this Makefile-specific check added in
> 0890098780f (Decide whether to build http-push in the Makefile,
> 2005-11-18) was missed, now that we're never going to use such an
> ancient curl version we don't need to check that we have at least
> 7.9.8 here. I have no idea what in http-push.c broke on versions older
> than that.

Nice catch. I was curious, and I think the issue was just that older
versions did not have the curl_multi_* interface.

> @@ -1436,15 +1436,8 @@ else
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>  	PROGRAM_OBJS += http-fetch.o
>  	PROGRAMS += $(REMOTE_CURL_NAMES)
> -	curl_check := $(shell (echo 070908; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
> -	ifeq "$(curl_check)" "070908"
> -		ifndef NO_EXPAT
> -			PROGRAM_OBJS += http-push.o
> -		else
> -			EXCLUDED_PROGRAMS += git-http-push
> -		endif
> -	else
> -		EXCLUDED_PROGRAMS += git-http-push
> +	ifndef NO_EXPAT
> +		PROGRAM_OBJS += http-push.o
>  	endif

I wonder if this $(CURL_CONFIG) check could have been be problematic for
some obscure platforms, if they set up CURL_{CFLAGS,LDFLAGS,LIBCURL}
manually (rather than relying on curl-config). We do have one more
similar check:

>  	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)

...and nobody has complained either way, so perhaps it doesn't matter
much. Anyway, I'm happy to see this now-useless code go away. :)

-Peff
