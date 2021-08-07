Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A4C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FD361078
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 14:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhHGOOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 10:14:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:41832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhHGOOP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 10:14:15 -0400
Received: (qmail 20594 invoked by uid 109); 7 Aug 2021 14:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Aug 2021 14:13:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19781 invoked by uid 111); 7 Aug 2021 14:13:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Aug 2021 10:13:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Aug 2021 10:13:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Message-ID: <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com>
 <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
 <875ywiyn4y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875ywiyn4y.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 07, 2021 at 04:56:04AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > On Sat, Aug 07, 2021 at 04:02:45AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >
> >> Perhaps I've missed some obvious reason not to do this, but why are we
> >> parsing the --version output of two modern compilers, as opposed to just
> >> asking them what type/version they are via their usual macro facilities?
> >> I.e. something like the below:
> >
> > That would probably work OK in practice, but it actually seems more
> > complex to me (how do other random compilers react to "-E -"?
> 
> We only care about gcc and clang in that script, which I think have
> supported that form of "-E" on stdin input for any version we're likely
> to care about for the purposes of config.mak.dev. It seems unlikely that
> we'll care about non-modern compilers in config.mak.dev, so using more
> modern features there seems fine (it's all for opting us into even more
> modern warning flags and the like...).

Yeah, but we don't find out what we have until we run the script in
question. I guess it is OK as long as we redirect stderr, ignore the
exit code, and only look for a positive outcome in the output (your
patch does the latter two already).

I also wondered how this might interact with CC="ccache gcc" (where
caching might fail to notice version changes). But from some quick
testing, it looks like it doesn't cache in this case (neither stdin, nor
with -E).

> > Is it possible for us to get other output from the preprocessor that
> > would confuse an eval?).
> 
> Probably, I just meant that as a POC. We could pipe it into some
> awk/grep/cut/perl or whatever that would be more strict.

That would probably be better. I would be curious to hear from somebody
with a mac if this technique gives more sensible version numbers for the
Apple-clang compiler.

-Peff
