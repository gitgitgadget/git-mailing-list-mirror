Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995D6C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA08613CB
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFJKsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:48:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:51102 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJKsM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:48:12 -0400
Received: (qmail 7228 invoked by uid 109); 10 Jun 2021 10:46:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 10:46:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28377 invoked by uid 111); 10 Jun 2021 10:46:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 06:46:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 06:46:13 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: UNLEAK(), leak checking in the default tests etc.
Message-ID: <YMHtdYxNCf6DwUZG@coredump.intra.peff.net>
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 09, 2021 at 07:44:12PM +0200, Andrzej Hunt wrote:

> > I ran into this when manually checking with valgrind and discovered that
> > you need SANITIZERS for -DSUPPRESS_ANNOTATED_LEAKS to squash it.
> > 
> > I wonder if that shouldn't be in DEVOPTS (or even a default under
> > DEVELOPER=1). I.e. you don't need any other special compile flags, just
> > a compiled git that you then run under valgrind to spot this.
> 
> I'm not familiar with git's development conventions/philosophy, but my 2c is
> that it's better not to enable it by default in order to minimise divergence
> from the code that users are running. OTOH it's not a major difference in
> behaviour so perhaps that's not a concern here.

Yeah, I'd rather not enable the option during normal builds. It carries
a run-time penalty (it is actually building a pointless data structure
that _does_ effectively leak the pointers, but backed by a global so
they're "findable" by leak checkers). So it changes speed and possibly
correctness of the final binary in a way that is different from what
people would actually run in practice.

That might be worth it if there was some advantage to just turning it
on (i.e., if by running with it all the time we might detect some bug).
But by itself it does nothing useful.

If you really want to leak-check more thoroughly the normal binary, then
IMHO you'd be better off to convert UNLEAK() sites to actual free calls.

> More significantly: I get the impression it's easier to do leak checking
> using LSAN, which requires recompiling git anyway - at which point you get
> the flag for free - so how often will people actually perform leak checking
> with Valgrind in the first place?

And yeah, I'd very much agree here. It's definitely not wrong to run
with Valgrind. But it's slower and much less thorough than ASan (probably not for
leak detection, but definitely for bug-finding, since it can't look at
stack variables).

If you do use it, and want to build with -DSUPPRESS_ANNOTATED_LEAKS all
the time, that's OK, but I don't think it makes sense for it to the
default even under DEVELOPER=1. I'm not opposed to a patch to make it
easier to flip the switch, though (but I also find sticking a line in
your config.mak to be pretty easy already).

-Peff
