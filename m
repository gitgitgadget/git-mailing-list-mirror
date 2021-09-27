Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF1C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96486103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhI0URg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:17:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236763AbhI0URb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:17:31 -0400
Received: (qmail 7342 invoked by uid 109); 27 Sep 2021 20:15:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Sep 2021 20:15:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19510 invoked by uid 111); 27 Sep 2021 20:15:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 16:15:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 16:15:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Message-ID: <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
 <xmqqa6k1slxe.fsf@gitster.g>
 <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net>
 <xmqqo88eq8um.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo88eq8um.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 09:30:41AM -0700, Junio C Hamano wrote:

> >> This asserts what? FOO=" bar"?
> >
> > Whoops, that should have been "envIs", asserting that $FOO contains
> > "bar".
> 
> Oh, "can we check with a literal with leading whitespace?" was what
> my question was about ;-)

My assumption was that nobody would really care about doing so. It is
true that it's less flexible, though (and is a decision we can't easily
take back later).

> > As I said, I think it matters more with the infix operators, as:
> >
> >   [includeIf "env:FOO == bar"]
> >
> > is more readable than:
> >
> >   [includeIf "env:FOO==bar"]
> 
> Sure, but at that point, we'd probably want some quoting mechanism
> for the literal to be compared, e.g.
> 
> 	[includeIf "env:PATH ~= \"(:|^)/usr/bin(:|$)\""]

Ick. The extra quoting of the internal double-quotes is pretty horrid to
look at. Also, how does one match a double-quote in the value? \\\"?

If it were optional, that would make the common cases easy (no dq, no
whitespace), and the hard ones possible.

I think this is getting into a bit of a digression, though. I'm willing
to defer to Ævar, who is doing the actual work, and I don't know if he
has found any of this compelling. ;)

> > But I do think:
> >
> >   [includeIf "envIs:FOO:bar"]
> >
> > is harder to read than even:
> >
> >   [includeIf "envIs:FOO: bar"]
> 
> Hmph, that's quite subjective, I am afraid.  When I see the latter
> in the configuration file, "do I have to have a single space before
> 'bar' in the value of $FOO" would be the first question that would
> come to my mind.

I think it's just the mashed-up colons that I find ugly in the first
one. But I agree the latter isn't that nice either, and introduces the
ambiguity you describe.

> With an understanding that our syntax is so limited that we cannot
> even write '=' and need to resort to Is: instead, I'd actually find
> that the former less confusing than the latter.

That I think is the most interesting question: is the "=" actually
out-of-bounds? I tend to think not, based on our responses earlier in
the thread.

-Peff
