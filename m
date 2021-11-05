Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D772CC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF28611EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKEXmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 19:42:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:54124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhKEXmb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 19:42:31 -0400
Received: (qmail 12831 invoked by uid 109); 5 Nov 2021 23:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 23:39:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23803 invoked by uid 111); 5 Nov 2021 23:39:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 19:39:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 19:39:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <YYXAwxmhrLLMBqa+@coredump.intra.peff.net>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org>
 <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
 <xmqqk0hmxyw0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0hmxyw0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 11:04:15AM -0700, Junio C Hamano wrote:

> > This is sort of a side note to your main issue, but I think that relying
> > on a lazy_prereq for side effects is an anti-pattern. We make no
> > promises about when or how often the prereqs might be run, and we try to
> > insulate them from the main tests (by putting them in a subshell and
> > switching their cwd).
> >
> > It does happen to work here because the prereq script writes directly to
> > $GNUPGHOME, and we run the lazy prereqs about when you'd expect. So I
> > don't think it's really in any danger of breaking, but it is definitely
> > not using the feature as it was intended. :)
> 
> This merely imitates what GPG lazy-prerequisite started and imitated
> by other existing signature backends.

Ah, you're right. I should have checked the other GPG ones. It looks
like that happened recently-ish in b417ec5f22 (tests: turn GPG, GPGSM
and RFC1991 into lazy prereqs, 2020-03-26).

Before that the code was run outside of any test block at all, which I
think is even worse.

> I'd expect that you need some "initialization" for a feature X as
> part of asking "is feature X usable in this environment?".  Reusing
> the result of the initialization for true tests is probably an
> optimization worth making.  As long as the question is answered for
> the true tests, that is [*].

Yes, though if it's possible, I think doing less work in the prereq
check might be a good approach (like say, just checking gpg or openssh
version if we can). It results in flakier prereqs that may say "yes, we
have feature X" when we don't. But it gets a human's attention when
it fails, rather than quietly skipping tests (which is the same point
Adam is making downthread).

It definitely is not something to fiddle with at this point in the -rc
cycle, though.

> > Again, that's mostly a tangent to your issue, and maybe not worth
> > futzing with at this point in the release cycle. I'm mostly just
> > registering my surprise. ;)
> 
> My purist side is with you and share the surprise.  But my practical
> side says this is probably an optimization worth taking.  If prereq
> only checks "if we initialize the keys right way, we can use ssh
> signing" and then removes the key and the equivalent to .ssh/
> directory, and a real test does "Ok, prereq passes so we know ssh
> signing is to be tested.  Now initialize the .ssh/ equivalent and
> create key", a fix like Adam came up with must be duplicated in two
> (or more) places, one for the prereq that initializes the keys
> "right way", and one for each test script that prepares the key used
> for it.

To be clear, I wasn't suggesting doing the key setup twice. I was just
suggesting moving it out of a lazy prereq into a real test_expect block
that sets the prereq flag as a side effect. That just makes the timing
and the fact of running it more deliberate on the part of the test
scripts.

It's probably not worth the effort, though. I think my line of thinking
is coming from the "purist" side, and doesn't have any practical
benefit.

-Peff
