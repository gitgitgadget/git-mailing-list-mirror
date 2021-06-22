Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D177FC48BE5
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42486128E
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFVT1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:27:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:36308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhFVT1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 15:27:46 -0400
Received: (qmail 6635 invoked by uid 109); 22 Jun 2021 19:25:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 19:25:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29683 invoked by uid 111); 22 Jun 2021 19:25:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 15:25:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 15:25:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Subject: Re: [PATCH 2/3] Makefile: fix "cscope" target to refer to cscope.out
Message-ID: <YNI5KVGT2mLlTrnz@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 04:21:26PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The cscope target added in a2a9150bf06 (makefile: Add a cscope target,
> 2007-10-06) has for some reason been referring to cscope* instead of
> cscope.out. Let's generate the cscope.out file directly so we don't
> need to speculate.
> 
> The "-fcscope.out" (note, no whitespace) argument is enabled by
> default on my system's cscope 15.9, but let's provide it explicitly
> for good measure.

I don't use cscope myself, but it can generate other files (e.g., with
"-q"). It looks like we don't even allow people to set $(CSCOPE),
though, so that shouldn't ever happen.

(I wonder if anybody even really uses cscope. I wanted to love it as a
better form of ctags, but I have always found it so baroque and
complicated that it ends up being a waste of my time to try it).

> +cscope.out:
> +	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
> +
>  .PHONY: cscope
> -cscope:
> -	$(RM) cscope*
> -	$(FIND_SOURCE_FILES) | xargs cscope -b
> +cscope: cscope.out

This drops the $(RM). Does cscope always overwrite the output file, or
does it append? Just trying "cscope -b foo.c; cscope -b bar.c", it looks
like it overwrites. Which makes your patch correct, but that existing
"xargs" is somewhat questionable (if it splits into two commands, the
first half will get dropped).

-Peff
