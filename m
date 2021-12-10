Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A878C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 08:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhLJI76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 03:59:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:48526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhLJI75 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 03:59:57 -0500
Received: (qmail 17926 invoked by uid 109); 10 Dec 2021 08:56:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 08:56:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28213 invoked by uid 111); 10 Dec 2021 08:56:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 03:56:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 03:56:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] config.mak.dev: specify -std=gnu99 for gcc/clang
Message-ID: <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g>
 <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
 <xmqq4k7j68eg.fsf@gitster.g>
 <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
 <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 01:05:44PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > +
> > +ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
> > +DEVELOPER_CFLAGS += -std=gnu99
> > +endif
> [...]
> 
> This approach looks good & the rationale make sense.
> 
> I mentioned in [1] that this might be a bad idea because:
> 
>     And as you note it's not only that older or non-gcc non-clang compilers
>     may not understand this at all, but are we getting worse behavior on
>     modern versions of those two because they're forced into some 20 year
>     old C99 standard mode, instead of the current preferred default?
> 
> But from some short testing of GCC it will generate the exact same
> <file>.s regardless of -std=* option, so I think this indeed only
> impacts the warnings we'll emit. So pinning this seems to categorically
> be a good thing.

Thanks for looking into that. The thought crossed my mind, too, but I
didn't have any actual data. I think some of this is due to the standard
committee keeping backwards compatibility. I.e., it's unlikely for there
to be a case where the N standard says "you must do X", and N+1 says
"that's dumb, you can do Y instead". Usually it is about new features
that were syntactically invalid or created undefined behavior in version
N.

> A bad thing about this is that we'll explicitly avoid happy accidents
> where we start relying on some newer C standard, and discover N releases
> later that it was no big deal, and can thus just use that feature.
> 
> On the other hand having this means less back & forth churn of adding
> such a dependency only to find it breaks on one of our platforms
> etc. Overall I think this makes sense, just say'n.

Right. I think it forces us to be more deliberate, but that's probably
OK.

> I don't think this needs to change, but FWIW this would benefit from the
> same sort of "let's just compile it" step as [2]. I.e. I think you'll
> find that we could just check the exit code of:
> 
>     $(CC) -E -std=gnu99 - </dev/null
> 
> This works on GCC/Clang, and will die on xlc/suncc, and I assume any
> other compiler that doesn't grok this. But I think it's better to avoid
> a $(shell) here just for that, and any such change can wait until we
> have some proper "compile this once and cache it" probing for
> config.mak.dev.

You'd lose one property that the version-check has, which is that we
don't ever _upgrade_ to gnu99 from gnu89. I'm not sure how important
that is, though. It would have been bad if we took something like
brian's c99 patch, and developers and CI both failed to realize that it
was breaking the out-of-the-box build for older compilers (because
behind the scenes they were getting -std=gnu99 that non-developers do
not). But now that we've decided on that direction anyway, I'm not sure
there's anything left to be learned.

-Peff
