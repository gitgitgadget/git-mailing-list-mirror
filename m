Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052FC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 14:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhLNOEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:04:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:51500 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232643AbhLNOEb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 09:04:31 -0500
Received: (qmail 13792 invoked by uid 109); 14 Dec 2021 14:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 14:04:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24737 invoked by uid 111); 14 Dec 2021 14:04:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 09:04:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 09:04:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 5/5] range-diff: fix integer overflow & segfault
 on cost[i + n * j]
Message-ID: <YbikbfdEH2EKZE1p@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
 <RFC-patch-v2-5.5-9194965635a-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-v2-5.5-9194965635a-20211210T122901Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 01:30:42PM +0100, Ævar Arnfjörð Bjarmason wrote:

> in preceding commits the "column_count" and the "int*"'s we malloc()
> were changed to track their length with a size_t, so we're able to
> track as many "cost" items as malloc() will give us.
> 
> But we'd still segfault on relatively large range comparisons,
> e.g. this would segfault:
> 
>     git -P range-diff --creation-factor=50 origin/master...git-for-windows/main
> 
> The reason for that is that we'd still use integer types to compute an
> array index into the "cost" array, which would overflow. The result of
> a signed overflow in C is undefined, but on my system it'll result in
> a negative number, and a prompt segfault as we'll try to access a
> negative array index.

Note that this isn't just access. We'll first write to cost[i + n * j]
to start. In practice because of the iteration, and signed overflow
being implemented as it usually is, we'd always first write a single int
that's 2GB before the array. And that should segfault.

I do wonder if this can be turned into a heap overflow exploit. I think
you'd probably need to manage to get 2GB on the heap to avoid an
immediate segfault.

> Luckily we used the COST() macro in linear-assignment.c already for
> all of these lookups, and in a preceding commit we renamed "n" in
> "range-diff.c"'s get_correspondences() to "column_count" in
> preparation for using it here.
> 
> So let's use it for the three occurrences of "cost" indexing in
> range-diff.c, and have the COST() macro itself do overflow checking
> with st_mult() and st_add(). Due to the cast to "size_t" from "int"
> we'll avoid the segfault, and will end up correctly pointing to the
> relevant "int *".

Is it actually necessary to do bounds checking here? If we know the
arrays are sized correctly, and we use an appropriate integer type,
wouldn't we know that our computations are always in bounds?

(I saw your other discussion of the unreliability of ssize_t; if we
don't want to assume it's of the same magnitude as size_t, then intmax_t
would work).

The reason I ask in particular is that I wonder if these non-intrinsic
st_* helpers might introduce a measurable slowdown. When I suggested
them earlier it was because I was also suggesting that we'd have done
all of our bounds-checks up front, during the allocation.

> It's still possible for us to overflow even with this change, that's
> because the iteration variables (such as "i" and "j" in this diff
> context are all "int"), even if we changed those to "size_t" or
> "intmax_t" (not trivial, as we depend on them being negative in some
> places) the underlying "struct string_list"'s "nr" member is an
> "unsigned int", which would eventually overflow.

The string_list overflow is something I do think we ought to fix. But we
know from past experiments that it can't actually cause a heap overflow.
Can overflowing one of the ints, though?

If we're computing i*n+j, and j goes negative, then cast to a size_t
that will turn into a big number. But depending how negative it is, it
might not overflow a size_t. But it would still be well outside the
bounds of the allocated array. E.g., consider code like this:

        int j = INT_MAX;
        while (1) {
                printf("int = %d\n", j);
                printf("size_t = %"PRIuMAX"\n", (uintmax_t)st_add(0, j));
                j++;
        }

which shows what happens when i=0, but j approaches overflow. We wrap to
-2^31, which is a large but representable size_t. So st_add() does not
trigger, but I think we'd still be out of bounds.

I suspect it's OK in practice from a security perspective, because it's
so far out of bounds as to cause a segfault and not any kind of heap
overflow. But it really feels like the fix is incomplete. Whereas using
the correct types avoids the segfault.

> We're unlikely to encounter a 2-4 billion commit history on 32 bit
> platforms. Even if we did one of the types in the underlying object
> machinery would probably overflow before we overflowed here. So let's
> punt that for now. If we're ever going to solve that issue [1] to
> change the "struct string_list"'s "nr" member to a "size_t" might be a
> good start.

I'm less concerned about "unlikely" and more about "what can bad actors
trigger". 2 billion is probably out of reach in practice though
(typically I've seen things get untenable around a few hundred million
objects total).

Still, it feels a bit hand-wavy.

-Peff
