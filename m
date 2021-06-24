Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC5C49EAB
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48400613F3
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhFXOv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:51:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhFXOvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 10:51:54 -0400
Received: (qmail 12043 invoked by uid 109); 24 Jun 2021 14:49:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 14:49:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12933 invoked by uid 111); 24 Jun 2021 14:49:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 10:49:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 10:49:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Message-ID: <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
 <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
 <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
 <871r8r1hwe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r8r1hwe.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 03:53:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> ..and "this behavior is really annoying on one platform we target, and
> >> the fix is rather trivial".
> >
> > Yeah, that's a fine reason, too. I'm not entirely clear on what the
> > problem is, though, or why this is the best solution (I expect you
> > probably explained it in an earlier thread/series, but if so it went in
> > one ear and out the other on my end).
> 
> On *nix systems you can open a file, and unlink() it in another process,
> on Windows this is an error.
> 
> AIX has its own variant of this annoying behavior, you can't clobber (or
> open for writing) binaries that are currently being run, you can unlink
> and rename them though.

Ah, right. Thanks for refreshing me.

TBH, I don't find this that serious a problem. Your compile will fail.
But is rebuilding in the middle of a test run something it's important
to support seamlessly? It seems like a bad practice in the first place.

It would likewise be a problem if you were running regular git commands
straight out of your build directory. And we do support that, but IMHO
it is not that important a use case.

So again, I'm not all that opposed to atomic rename-into-place
generation. But the use case doesn't seem important to me.

> So without that "mv $@ $@+" trick you can't recompile if you have a
> concurrent test (that you don't care about failing) running, and we have
> bugs in our tests where e.g. "git-daemon" gets lost and won't get killed
> on that platform, so you can't recompile and test without tracking it
> down and killing it.

The "git-daemon" thing sounds like a separate bug that is maybe
exacerbating things. But we'd want to fix it anyway, since even without
blocking compilation, it will cause a re-run of the tests to use the
wrong version (and either fail, or hit the auto-skip behavior). I've run
into this with apache hanging around after tests were killed (we do try
to clean up, but depending how the script is killed, that may or may not
succeed).

-Peff
