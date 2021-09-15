Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99188C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAD96121F
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhIOQaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:30:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:48062 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhIOQaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:30:15 -0400
Received: (qmail 32351 invoked by uid 109); 15 Sep 2021 16:28:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:28:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25087 invoked by uid 111); 15 Sep 2021 16:28:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:28:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:28:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 09/11] serve: reject bogus v2 "command=ls-refs=foo"
Message-ID: <YUIfR5yLiXeprhvL@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1ym1dALRQLztq@coredump.intra.peff.net>
 <87wnnin0ix.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnnin0ix.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 02:27:35AM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Sep 14 2021, Jeff King wrote:
> 
> > When we see a line from the client like "command=ls-refs", we parse
> > everything after the equals sign as a capability, which we check against
> > our capabilities table. If we don't recognize the command (e.g.,
> > "command=foo"), we'll reject it. But we use the same parser that checks
> > for regular capabilities like "object-format=sha256". And so we'll
> > accept "ls-refs=foo", even though everything after the equals is bogus,
> > and simply ignored.
> >
> > This isn't really hurting anything, but the request does violate the
> > spec. Let's tighten it up to prevent any surprising behavior.
> 
> Doesn't need a re-roll, but just for my own sanity:
> 
> By violating the spec you mean it doesn't coform to the "key" in the
> "Capability Advertisement" section of protocol-v2.txt, one might skim
> this and think values with "=" in them are OK, but a command=WHATEVER
> has a WHATEVER as a "key", not a "value", that's for other parts of the
> dialog.
> 
> But you could also have meant that it violates the spec because there's
> no such command as "ls-refs=whatever", just like there isn't "foobar",
> but I don't think that's what you mean...

Both, I think. :) The line "command=foo=bar" is obvious nonsense by the
spec, no matter which way you interpret it:

  - "foo" is a command name, but adding a value does not make sense when
    it is used in this context, so it's invalid

  - "foo=bar" is not a command name

Our parser does pick out "foo", so in terms of the code it is more like
the former. But since it is invalid either way, I'm not sure the
distinction matters.

-Peff
