Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA04C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A001E60F50
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJUOgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:36:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:43620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhJUOgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:36:20 -0400
Received: (qmail 15833 invoked by uid 109); 21 Oct 2021 14:34:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Oct 2021 14:34:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6962 invoked by uid 111); 21 Oct 2021 14:34:03 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Oct 2021 10:34:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Oct 2021 10:34:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Message-ID: <YXF6Wwcvc0vq5ADZ@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
 <YXCKqAEwtwFozWk6@nand.local>
 <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
 <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
 <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 02:48:24AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> There's subtle dependency issues there as well, and just having a
> >> one-off solution for the the command-list.h doesn't get us closer to
> >> addressing that sibling implementation.
> >
> > So I don't know what "subtle dependency issues" you found here, but this
> > is exactly the kind of complexity it was my goal to avoid.
> 
> But how? I don't see how narrowly making the loop in generate-cmdlist.sh
> gets us closer to generating the "cmds_txt" in the
> Documentation/Makefile.

What I meant is that the work to get everything right in the Makefile to
correctly handle dependencies and a partial rebuild can be tricky. For
instance, you're still stuck with a big wildcard dependency on
Documentation/git*.txt (and a manual list of exclusions in the Makefile)
because it's hard in make to do make new dynamic rules based on an
existing one (i.e., the list _should_ come from what's in
command-list.txt). Or the fact that we apparently need to keep the old
script around or cmake anyway.

It's also much slower. Here are from-scratch builds before and after
your patch 7:

  $ hyperfine --warmup 1 -p 'make clean' 'make command-list.h'
  Benchmark #1: make command-list.h
    Time (mean ± σ):      1.527 s ±  0.060 s    [User: 1.320 s, System: 0.649 s]
    Range (min … max):    1.433 s …  1.625 s    10 runs
   
  
  $ hyperfine --warmup 1 -p 'make clean' 'make command-list.h'
  Benchmark #1: make command-list.h
    Time (mean ± σ):      2.661 s ±  0.080 s    [User: 2.359 s, System: 1.082 s]
    Range (min … max):    2.481 s …  2.756 s    10 runs

I know that partial builds will offset that in some cases, but it still
feels like a step in the wrong direction. Even with a partial build,
swapping out "make clean" for "touch Documentation/git-add.txt" takes
about 200ms for me. Whereas with the faster version of
generate-cmdlist.sh I showed, it takes 150ms.

Now performance isn't everything, and it's possible these partial
snippets will be useful in other places. But I'm not sure I see any real
advantage in this series, and it seems like we're taking a hit in both
performance and complexity in the meantime.

-Peff
