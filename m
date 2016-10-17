Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3039020988
	for <e@80x24.org>; Mon, 17 Oct 2016 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934056AbcJQJ5A (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 05:57:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:58341 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933723AbcJQJ4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 05:56:46 -0400
Received: (qmail 18923 invoked by uid 109); 17 Oct 2016 09:50:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Oct 2016 09:50:04 +0000
Received: (qmail 28983 invoked by uid 111); 17 Oct 2016 09:50:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Oct 2016 05:50:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Oct 2016 05:50:02 -0400
Date:   Mon, 17 Oct 2016 05:50:02 -0400
From:   Jeff King <peff@peff.net>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, tboegi@web.de, gitster@pobox.com
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and
 APPLE_COMMON_CRYPTO for macOS >10.11
Message-ID: <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-2-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161017002550.88782-2-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2016 at 05:25:49PM -0700, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Apple removed the OpenSSL header files in macOS 10.11 and above. OpenSSL
> was deprecated since macOS 10.7.
> 
> Set `NO_OPENSSL` and `APPLE_COMMON_CRYPTO` to `YesPlease` as default for
> macOS. Make it possible to override this and use OpenSSL by defining
> `DARWIN_OPENSSL`.

I like that you gave an override, but I don't think it works in all
cases:

> diff --git a/config.mak.uname b/config.mak.uname
> index b232908..f0c94a9 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -108,6 +108,12 @@ ifeq ($(uname_S),Darwin)
>  	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
>  		HAVE_GETDELIM = YesPlease
>  	endif
> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 15 && echo 1),1)
> +		ifndef DARWIN_OPENSSL
> +			NO_OPENSSL = YesPlease
> +			APPLE_COMMON_CRYPTO=YesPlease
> +		endif
> +	endif

This is in config.mak.uname, which gets sourced before config.mak (and
ifndef is evaluated at the time of parsing). So it would work to do:

  make DARWIN_OPENSSL=Yep

but not:

  echo DARWIN_OPENSSL=Yep >>config.mak
  make

I think you'd have to set a flag in config.mak.uname, and then resolve
it in the Makefile proper like:

  ifdef DARWIN_OPENSSL
	# Overrides AUTO_AVOID_OPENSSL, do nothing.
  else ifdef AUTO_AVOID_OPENSSL
	NO_OPENSSL = YesPlease
	APPLE_COMMON_CRYPTO = YesPlease
  endif

but that's totally untested.

-Peff
