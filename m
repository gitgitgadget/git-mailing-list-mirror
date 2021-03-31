Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2AEC433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0486198A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhCaKnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:43:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:38430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234963AbhCaKnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 06:43:16 -0400
Received: (qmail 28439 invoked by uid 109); 31 Mar 2021 10:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Mar 2021 10:43:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2833 invoked by uid 111); 31 Mar 2021 10:43:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Mar 2021 06:43:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Mar 2021 06:43:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] improve reporting of unexpected objects
Message-ID: <YGRSQfMFS14Ksy0o@coredump.intra.peff.net>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <YGBL88lYheyFmwCg@coredump.intra.peff.net>
 <87r1jym6d0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1jym6d0.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 03:34:03PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > But I think it still has the "oops, somebody made a wrong reference much
> > earlier" problem. The actual bug is in some other object entirely, whose
> > identity is long forgotten. I think we would be much better off to say
> > something like "somebody expected X to be a commit, but now somebody
> > else expects it to be a blob", which is all that we can reliably say.
> > And the next step really ought to be running "git fsck" to figure out
> > what is going on (and we should perhaps even say so via advise()).
> 
> Yes I'm totally side-stepping the issue, but I don't see a way around
> that that doesn't make the whole object lookup code either much slower,
> or more complex.
> 
> I.e. the whole thing is an emergent effect of us seeing a tag object,
> and noting in-memory that we saw a given OID of type X, but we don't
> even know if we can look it up at that point, or that it's not type Y.
> 
> I don't think it's guaranteed that we're neatly in one single object
> traversal at that point (e.g. if we're looking at N tags, and only later
> dereferencing their "object" pointers). So passing a "object A which I
> have now says B is a X, assert!" wouldn't work.
> 
> We could eagerly get the object from disk when parsing tags (slow?), or
> have a void* in the object struct or whatever to say "this is the OID
> that claimed you were XYZ" (ew!).
> 
> Or, which I think makes sense here, just don't worry about it and error
> with the limited info we have at hand. Yes we can't report who the
> ultimate culprit is without an fsck, but that's not different than a lot
> of other error() and die() messages in the object code now.

Yes, that "don't worry too much about it" was where my line of thinking
is going. But then I do not see all that much point in your final patch
at all. I.e., I think just changing the message to more clearly say what
we do know in lookup_commit(), etc, would be sufficient.

> So if we're going to emit an advise() that seems generally useful for
> many of those error()/die() messages, and not something we should tack
> onto this incremental improvement to one error.

Yeah, I think doing an advise() is probably overkill. My next step would
always be "run fsck", and I was thinking only that we might point the
user in that direction. But it's probably fine to just emit the error.

-Peff
