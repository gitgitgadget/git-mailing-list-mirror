Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B2C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8218461182
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhEEOJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:09:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:45380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhEEOJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:09:14 -0400
Received: (qmail 18520 invoked by uid 109); 5 May 2021 14:08:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 14:08:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9974 invoked by uid 111); 5 May 2021 14:08:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 10:08:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 10:08:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
Message-ID: <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
 <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 02:21:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
> 2018-04-10) we have been declaring PERL_DEFINES right after assigning
> to it, with the effect that the first PERL_DEFINES was ignored.
> 
> That bug didn't matter in practice since the first line had all the
> same variables as the second, so we'd correctly re-generate
> everything. It just made for confusing reading.
> 
> Let's remove that first assignment, and while we're at it split these
> across lines to make them more maintainable.

This and the other three patches all look sensible to me.

I did have one question:

> diff --git a/Makefile b/Makefile
> index 93664d67146..1d4c02e59d9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2270,9 +2270,10 @@ perl_localedir_SQ = $(localedir_SQ)
>  
>  ifndef NO_PERL
>  PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
> -PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
> -
> -PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
> +PERL_DEFINES :=
> +PERL_DEFINES += $(PERL_PATH_SQ)
> +PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
> +PERL_DEFINES += $(perllibdir_SQ)
>  PERL_DEFINES += $(RUNTIME_PREFIX)

I don't think we generally use simply-expanded variables in our Makefile
unless there's a reason. Do we actually need it here? Obviously not new
in your patch, but just a curiosity I noticed while reading it.

-Peff
