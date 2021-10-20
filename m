Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579BDC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 23:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31216610A2
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 23:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhJTXtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 19:49:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:43210 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJTXtB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 19:49:01 -0400
Received: (qmail 10841 invoked by uid 109); 20 Oct 2021 23:46:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Oct 2021 23:46:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31739 invoked by uid 111); 20 Oct 2021 23:46:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Oct 2021 19:46:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Oct 2021 19:46:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Message-ID: <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
 <YXCKqAEwtwFozWk6@nand.local>
 <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 01:14:37AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Jeff: Just in terms of error prone both of these implementations will
> accept bad input that's being caught in 8/8 of this series.
> 
> We accept a lot of bad input now, ending up with some combinations of
> bad output or compile errors if you screw with the input *.txt files. I
> think I've addressed all of those in this series.

I don't mind more error-checking, though TBH I don't find a huge value
in it. But what I did mean was:

> If you mean the general concept of making a "foo.gen" from a "foo.txt"
> as an intermediate with make as a way to get to "many-foo.h" I don't
> really see how it's error prone conceptually. You get error checking
> each step of the way, and it encourages logic that's simpler each step
> of the way.

Yes. It just seems like the Makefile gets more complicated, and
sometimes that can lead to subtle dependency issues (e.g., the ".build"
dependency in the earlier iteration of the series).

And in general I'd much rather debug an awk script than a Makefile.

> Per Eric's Sunshine's upthread comments an awk and Perl implementation
> were both considered before[1].

Ah sorry, I thought it was just a perl one that had been the
show-stopper. I hadn't noticed the awk one. However, the point of my
patch was to use perl if available, and fall back otherwise. Maybe
that's too ugly, but it does address the concern with Eric's
implementation.

> I.e. I think if you e.g. touch Documentation/git-a*.txt with this series
> with/without this awk version the difference in runtime is within the
> error bars. I.e. making the loop faster isn't necessary. It's better to
> get to a point where make can save you from doing all/most of the work
> by checking modification times, rather than making an O(n) loop faster.

FWIW, I don't agree with this paragraph at all. Parallelizing or reusing
partial results is IMHO inferior to just making things faster.

> I'm also interested in (and have WIP patches for) simplifying things
> more generally in the Makefile. Once we have a file exploded out has
> just the synopsis line that can be used to replace what's now in
> Documentation/cmd-list.perl, i.e. those summary blurbs also end up in
> "man git".
> 
> There's subtle dependency issues there as well, and just having a
> one-off solution for the the command-list.h doesn't get us closer to
> addressing that sibling implementation.

So I don't know what "subtle dependency issues" you found here, but this
is exactly the kind of complexity it was my goal to avoid.

-Peff
