Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4CEC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F5261166
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhDNHb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 03:31:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:52112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232891AbhDNHb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 03:31:29 -0400
Received: (qmail 3843 invoked by uid 109); 14 Apr 2021 07:31:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Apr 2021 07:31:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4917 invoked by uid 111); 14 Apr 2021 07:31:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Apr 2021 03:31:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Apr 2021 03:31:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] git-compat-util.h: clarify comment on GCC-specific
 code
Message-ID: <YHaaOoE8/BiVKhKt@coredump.intra.peff.net>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
 <YHVPAGVDjS1EH6L3@coredump.intra.peff.net>
 <xmqqblahlwqm.fsf@gitster.g>
 <YHZ72NVfEUXZmBoz@coredump.intra.peff.net>
 <877dl52y3x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dl52y3x.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 08:12:34AM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Apr 14 2021, Jeff King wrote:
> 
> > On Tue, Apr 13, 2021 at 02:07:13PM -0700, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> >> + * We restrict this trick to gcc, though, because while we rely on the
> >> >> + * presence of C99 variadic macros, this code also relies on the
> >> >> + * non-standard behavior of GCC's __VA_ARGS__, allowing error() to
> >> >> + * work even if no format specifiers are passed to error().
> >> 
> >> The last part of this comment is puzzlling.  Do we ever call error()
> >> without any format specifier?  There may be GCC-ism behaviour around
> >> the __VA_ARGS__ stuff, but are we relying on that GCC-ism?
> >
> > I took "format specifier" to mean the "%" code within the format. E.g.:
> >
> >   error("foo");
> >
> > has no format specifier, and thus no arguments after the format. But
> > every call will have at least the format string itself.
> >
> > AFAIK, portably using variadic macros means you need there to always be
> > at least one argument. Hence "error(fmt, ...)" is wrong (the "..." may
> > have no arguments) but "error(...)" is OK (you always have a format
> > string). I'm not sure if Ævar knows about some other portability gotcha,
> > or if he just didn't realize that this was written in the portable way.
> 
> No, I just read elsewhere that GCC had non-standard behavior, and didn't
> look carefully at your implementation, but since it explicitly depended
> on GNUC etc. understood it to mean it was GCC-specific, not just
> C99-specific.
> 
> So it can simply be changed to depend on HAVE_VARIADIC_MACROS instead?

I think it probably could be, yes.

The original predates HAVE_VARIADIC_MACROS (which we got in 2014); the
original error() macro is from e208f9cc75 (make error()'s constant
return value more visible, 2012-12-15).

The original also used the gcc-ism with the paste operator (see the
commit message for mention of it), but that was actually dropped later
by 9798f7e5f9 (Use __VA_ARGS__ for all of error's arguments,
2013-02-08), giving us the C99-portable version we have now.

All that said, I don't see much value in converting it to use
HAVE_VARIADIC_MACROS. It is mostly there to benefit gcc's warning code.

In theory making the return value visible could help other compilers
generate better code, too. If we care about doing that, we could switch
to making it unconditional. But aside from the variadic macros, it's
kind of a weird construct and I'd be worried about generating warnings
on other compilers or static analysis systems. E.g., see the hack from
87fe5df365 (inline constant return from error() function, 2014-05-06).

-Peff
