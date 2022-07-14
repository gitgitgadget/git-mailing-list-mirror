Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B65FC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbiGNVyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGNVyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:54:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158B1C934
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:54:32 -0700 (PDT)
Received: (qmail 19512 invoked by uid 109); 14 Jul 2022 21:54:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jul 2022 21:54:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32458 invoked by uid 111); 14 Jul 2022 21:54:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jul 2022 17:54:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jul 2022 17:54:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
Message-ID: <YtCQl1oinrVnfa+6@coredump.intra.peff.net>
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
 <xmqq7d4kp8l6.fsf@gitster.g>
 <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
 <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
 <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
 <Ys0hhYjPExuNWynE@coredump.intra.peff.net>
 <220712.864jzm65mk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220712.864jzm65mk.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 11:16:10AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> I'm in favor of this. It would, of course, require extra
> >> special-casing for Apple's clang for which the version number bears no
> >> resemblance to reality since Apple invents their own version numbers.
> 
> FWIW I was imagining just providing that -Wno-* on clang versions <= 11,
> not special-casing Apple's in particular.

It's not about special-casing Apple in particular. It's that our
detect-compiler script does not understand which version of clang is
used for Apple's compiler. Their version numbers are totally mismatched.

So you either have to say "turn off this warning for clang totally", or
do the wrong thing when Apple's compiler is in use.

> I have a local patches that carry forward the idea I had in that thread,
> i.e. to drop all this version detection insanity and just compile a C
> program to detect the compiler.

Hmm. I prefer your earlier suggestion to use "$(CC) -E". This tool has
to run on every invocation of "make", so the lighter-weight it is, the
better. You say later...

> The compilation is then triggered by the include in config.mak.dev,
> which has a corresponding rule that creates the C program, then the
> generated *.mak, so once we do it once we're only ever including an
> already generated text file.

but that implies we don't have a dependency on the compiler itself.
You'd want to at least depend on the name of the compiler. But that
would also miss if running "clang" changes which version of clang you're
running. I know upgrading your compiler is rare-ish, but this is exactly
the kind of thing I expect to bite at the most annoying time (when
you're switching around versions to try to figure out how they behave).

> 	#ifdef __clang__
> 	#if __clang_major__ >= 7
> 		fn(util, "NEEDS_std-eq-gnu99", "1");
> 	#endif

This is still gross version detection, but I don't think we can avoid
it. However...

> 	#if __has_warning("-Wextra")
> 		fn(util, "HAS_Wextra", "1");
> 	#endif

...this is much nicer. It could still be implemented purely via "-E", as
far as I can see, like:

  #if __has_warning("-Wextra")
  HAS_Wextra = 1
  #endif

But then we end up having to do version comparisons for gcc anyway:

> 	#if __GNUC__ >= 6
> 		fn(util, "NEEDS_std-eq-gnu99", "1");
> 		fn(util, "HAS_Wextra", "1");

so it feels like we're back where we started. You've just encoded the
version checks in a different spot.

I dunno. I don't find this significantly less gross than the status quo.
I don't mind getting the version via "-E" rather than "-v", but whether
the policy logic is in cpp, or in shell, or in the Makefile, it still
needs to exist. Putting it in cpp allows using has_warning(), but since
that isn't available everywhere, I'm not sure it buys us much.

-Peff
