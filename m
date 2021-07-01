Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCCDC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD14C61407
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhGAW1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:27:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhGAW1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:27:37 -0400
Received: (qmail 29167 invoked by uid 109); 1 Jul 2021 22:25:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 22:25:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19819 invoked by uid 111); 1 Jul 2021 22:25:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 18:25:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 18:25:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/5] Makefile: fix "cscope" target to refer to
 cscope.out
Message-ID: <YN5AwdVC3QAcy2tA@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <patch-3.5-35c8b83904-20210629T110837Z-avarab@gmail.com>
 <YN5AeMiTiHFrFW/7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YN5AeMiTiHFrFW/7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 01, 2021 at 06:23:52PM -0400, Jeff King wrote:

> On Tue, Jun 29, 2021 at 01:12:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > diff --git a/Makefile b/Makefile
> > index faa8900097..2e3b257164 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2737,10 +2737,12 @@ tags: FORCE
> >  	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
> >  	mv tags+ tags
> >  
> > +cscope.out:
> > +	$(QUIET_GEN)$(RM) cscope.out && \
> > +	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
> > +
> >  .PHONY: cscope
> > -cscope:
> > -	$(QUIET_GEN)$(RM) cscope* && \
> > -	$(FIND_SOURCE_FILES) | xargs cscope -b
> > +cscope: cscope.out
> 
> Doesn't this break subsequent runs after the first generation? With a
> phony "cscope" target, "make cscope" will always run the command, even
> if it's not necessary. But with a real "cscope.out" target but not
> dependencies, it will _never_ run it, even if one of the files changed.
> 
> E.g., with your patch:
> 
>   $ make cscope.out
>     GEN cscope.out
> 
>   $ make cscope.out
>   make: 'cscope.out' is up to date.
> 
>   $ echo 'void foo(void) { }' >>git.c
>   $ make cscope.out
>   GIT_VERSION = 2.32.0.96.g5daee1b7bb.dirty
>   make: 'cscope.out' is up to date.

Ah, I see it is un-broken in the next commit, which adds actual
dependencies. I think it is OK to have a temporarily-broken state in the
history for something so trivial, but it might be worth mentioning it in
the commit message.

-Peff
