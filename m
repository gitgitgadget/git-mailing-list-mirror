Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0FAC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC3561185
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhFPLpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 07:45:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhFPLpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 07:45:52 -0400
Received: (qmail 12693 invoked by uid 109); 16 Jun 2021 11:43:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 11:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25855 invoked by uid 111); 16 Jun 2021 11:43:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 07:43:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 07:43:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
Message-ID: <YMnj7+nWQHSY6fTS@coredump.intra.peff.net>
References: <xmqqa6nqsd2i.fsf@gitster.g>
 <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
 <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
 <87pmwmxd6f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmwmxd6f.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 11:49:20AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > [...] Still, I kind of like the "set -f" version because it doesn't need
> > the extra directory which could cause problems with "ls-files -o", etc,
> > as you mentioned. You could also create the empty directory on the fly,
> > though if "set -f" works portably, that seems less complicated to me.
> 
> Yeah, in isolation I'd agree, but given the desire (with existing code
> and other in-flight code) to have a scratch are for the test library
> code itself simply creating such a directory seems like a good thing to
> have in general, and once we have it we can use the subshell trick, or
> just "set -f" I suppose and use the scratch dir for other stuff.

I don't have much of an opinion on other uses of the scratch dir, not
having seen them. I agree if we do have one and are paying the cost for
it already, then using it here isn't a big deal.

> I am a bit wary of this being our first ever use of "set -f", but maybe
> it's sufficiently portable.

Yep, me too. The nice thing about it is that we can swap out the
solution pretty easily if it turns out not to be. I don't know how good
our coverage of obscure shells is in CI, though (e.g., on your gcc
build-farm stuff, are we mostly using system shells?).

> > Whatever the expansion mechanism, I do think it's worth having callers
> > quote "$GIT_SKIP_TESTS" and then performing the expansion within
> > match_pattern_list. Then the nasty mechanics are all in that one place.
> 
> I think it's rather clean to not quote it, i.e. to have the loop get a
> list of item and then things to match, it would also make it easier to
> e.g. port it to a native C program.

My main complaint is that it's a real gotcha for the callers. They have
to remember to do this cd-to-scratch (or whatever technique we use).
That's cumbersome, and if they forget, their call is wrong in a really
subtle way that basic testing isn't likely to uncover.

-Peff
