Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CCCC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62486108F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2U7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:59:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49806 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhJ2U7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:59:01 -0400
Received: (qmail 23821 invoked by uid 109); 29 Oct 2021 20:56:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 20:56:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22880 invoked by uid 111); 29 Oct 2021 20:56:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 16:56:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 16:56:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Message-ID: <YXxf/+dwx5giy6im@coredump.intra.peff.net>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local>
 <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
 <211027.86v91iyis4.gmgdl@evledraar.gmail.com>
 <YXkWhFGS/uTAnsI1@coredump.intra.peff.net>
 <211027.865ytixjcw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211027.865ytixjcw.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 10:57:52PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > So it's not the "container" element, but rather it can be a problem if
> > people annotate too broadly (you will miss some leaks). In the case of
> > rev_info, there is no way to _not_ leak right now, because it has no
> > cleanup function.
> 
> It doesn't have one, but there are uses of setup_revisions() and
> rev_info usage that don't leak, as that builtin/rev-list.c case shows.
> 
> I mean, in that case it's not doing much of anything, but at least we
> test that setup_revisions() itself doesn't leak right now, but wouldn't
> with UNLEAK().

I don't think that's true. If you UNLEAK() the rev_info in the caller,
then it will only affect allocations that are still reachable from
rev_info. I.e., things that are by definition not a leak in
setup_revisions().

Now you could argue that setup_revisions() is "leaking" by allocating
things and stuffing them into rev_info that it should not be. But we can
never know that until we have an actual function that cleans up a
rev_info, which defines what it's "supposed" to have ownership of.

Maybe we have callers that explicitly try to de-allocate bits of the
rev_info. But IMHO that is the source of the whole problem: how is
random code using rev_info supposed to know which of its internal
details are owned or not? This should be documented and enforced with a
single function.

> So just FWIW I'm not saying "hey can we hold off on that UNLEAK() for
> far future xyz", but for a thing I've got queued up that I'd rather not
> start rewriting...

Just to be clear: I am totally fine with dropping Taylor's UNLEAK
patches (as I've said already). I was only arguing here that annotating
via external files is worse than just adding an UNLEAK().

I'm also trying to combat what I see as mis-conceptions or inaccuracies
about what UNLEAK() does or its implications (or even what counts as a
"leak"). But I hope in the long run that we don't need _any_ kind of
annotation, because we'll actually be leak-free. And then we don't have
to care about any of this.

> > I don't see how UNLEAK() would impact stack traces. It should either
> > make something not-leaked-at-all (in which case LSan will no longer
> > mention it), or it does nothing (it throws some wasted memory into a
> > structure which is itself not leaked).
> 
> Yes, I think either categorically wrong here, or it applies to some
> other case I wasn't able to dig up. Or maybe not, doesn't Taylor's
> example take it from "Direct leak" to "Indirect leak" with the
> suppression in play? I think those were related somehow (but don't have
> that in front of me as I type this out).

I don't think UNLEAK() can move something from "direct" to "indirect" in
LSan's terminology. If rev_info points to an array of structs, and those
structs point to allocated strings, then the array itself is a "direct"
leak, and the strings are "indirect" (they are leaked, but presumably
fixing the direct leak would also deallocate them).

If UNLEAK() makes the array not-leaked, then those indirect leaks don't
become direct. They should be transitively not-leaked, too.

> E.g. (to reinforce your point) try compiling with SANITIZE=leak and running:
> 
>     $ TZ=UTC t/helper/test-tool date show:format:%z 1466000000 +0200
>     1466000000 -> +0000
>     +0200 -> +0000
>     
>     =================================================================
>     ==335188==ERROR: LeakSanitizer: detected memory leaks
>     
>     Direct leak of 3 byte(s) in 1 object(s) allocated from:
>         #0 0x7f31cdd21db0 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:54
>         #1 0x7f31cdb04e4a in __GI___strdup string/strdup.c:42
>     
>     SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).

So these should be real leaks. Of course with the lousy stack trace it's
hard to see what they are. But I don't see how UNLEAK() is responsible
for making the lousy stack trace. You could try compiling with LSan but
_not_ -DSUPPRESS_ANNOTATED_LEAKS and see if the result is similarly bad
(but I expect it to be, since test-date.c does not have any UNLEAK()
calls in it).

-Peff
