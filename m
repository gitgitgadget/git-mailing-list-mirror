Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D33C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5D661075
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 09:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbhJ0JIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:08:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241177AbhJ0JIk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 05:08:40 -0400
Received: (qmail 12918 invoked by uid 109); 27 Oct 2021 09:06:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 09:06:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20326 invoked by uid 111); 27 Oct 2021 09:06:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 05:06:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 05:06:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Message-ID: <YXkWhFGS/uTAnsI1@coredump.intra.peff.net>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local>
 <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
 <211027.86v91iyis4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211027.86v91iyis4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 10:04:17AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >   - it keeps the annotations near the code. Yes, that creates conflicts
> >     when the code is changed (or the leak is actually fixed), but that's
> >     a feature. It keeps them from going stale.
> 
> I fully agree with you in general for "good" uses of UNLEAK(). E.g. consider:
> 
>     struct strbuf buf = xmalloc(...);
>     [...]
>     UNLEAK(buf);
> 
> If I was fixing leaks in that sort of code what I pointed out downthread
> in [1] wouldn't apply.

I'm OK with such a use of UNLEAK(), though of course you could probably
just free the buffer in that instance.

But...

> So to clarify, I'm not asking in [1] that UNLEAK() not be used at all
> while we have in-flight leak fixes. I.e. I'd run into a textual
> conflict, but that would be trivial to resolve, and obvious what the
> semantic & textual conflict was.
> 
> Rather, it's not marking specific leaks, but UNLEAK() on a container
> struct that's problematic.

...that's the whole point of UNLEAK(), IMHO. You know that the container
struct is leaked, but you don't care because the program is about to
exit, or there's no easy way to avoid the leak.

So it's not the "container" element, but rather it can be a problem if
people annotate too broadly (you will miss some leaks). In the case of
rev_info, there is no way to _not_ leak right now, because it has no
cleanup function. In the long run we should probably add one. But in the
meantime, annotating them so we can find the _interesting_ leaks is
worth doing (and that was the whole point of adding UNLEAK in the first
place.

And I think the UNLEAK() calls in Taylor's patch are fine in that sense.
While yes, _some_ runs of those commands will not leak, the point is to
say that when they do leak, they are not interesting. And they are not
interesting because that rev_info is in scope until the program exits,
so anything it points to is only leaked at a moment where we no longer
care.

> So we wouldn't just be marking a known specific leak, but hiding all
> leaks & non-leaks in container from the top-level, and thus hide
> potential regressions, an addition to attaining the end-goal of marking
> some specific test as passing.

I'd argue it _is_ a known specific leak. It is rev_info going out of
scope that causes the leak, not rev_info holding on to memory in things
like its pending array.

Now those can be interesting, too (if it no longer needs the memory, can
it perhaps get rid of it). But IMHO all of that is pretty secondary to
clearing the noise so you can find "true" leaks (ones where some
sub-function really is allocating and then losing the pointer entirely,
especially if it's called an arbitrary number of times).

> >   - leak-checkers only know where things are allocated, not who is
> >     supposed to own them. So you're often annotating the wrong thing;
> >     it's not a strdup() call which is buggy and leaking, but the
> >     function five layers up the stack which was supposed to take
> >     ownership and didn't.
> 
> As noted in [3] this case is because the LSAN suppressions list was in
> play, so we excluded the meaningful part of the stack trace (which is
> shown in that mail).

I don't think that's true at all. The annotations you showed in that
message, for example, are pointing at add_rev_cmdline(). But that is
_not_ the source of the leak, nor where it should be fixed. It is a
necessary part of how rev_info works. The leak is when the rev_info goes
out of scope without anybody cleaning it up.

> Hrm, now that I think about it I think that the cases where I had to
> resort to valgrind to get around such crappy stacktraces (when that was
> all I got, even without suppressions) were probably all because there
> was an UNLEAK() in play...

I don't see how UNLEAK() would impact stack traces. It should either
make something not-leaked-at-all (in which case LSan will no longer
mention it), or it does nothing (it throws some wasted memory into a
structure which is itself not leaked).

-Peff
