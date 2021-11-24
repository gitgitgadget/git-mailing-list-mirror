Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B29BC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 15:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbhKXPyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:54:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:37740 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242021AbhKXPyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 10:54:12 -0500
Received: (qmail 28649 invoked by uid 109); 24 Nov 2021 15:51:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Nov 2021 15:51:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14607 invoked by uid 111); 24 Nov 2021 15:51:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Nov 2021 10:51:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Nov 2021 10:51:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <YZ5fZGyMj/lAuy7i@coredump.intra.peff.net>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <20211122145222.m2zrmtbaeu5kzbtt@cyberdelia>
 <xmqqczmsi0i5.fsf@gitster.g>
 <20211123164015.6zkbf3xmnofykedz@cyberdelia>
 <211124.865ysie2br.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211124.865ysie2br.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 02:55:20AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I do wonder re [2] and [3] if a simpler and self-contained/isolated
> patch in this area might not be a mirage of sorts. I.e. to know whether
> the approach in [2] and [3] is safe we basically have to reason about
> all the callers of this API anyway, which is what my larger series does.

After thinking on the various solutions, the original snippet I posted
to just re-initialize the struct in each run seems like the best fit[1].
It's true that this "args/argv" thing is the source of the actual
segfault, so any cleanup changes there would address that. But the root
of the confusion in setup_pager() is that it inits the child only once,
but then uses it multiple times. There could be similar confusion over
other fields in the struct (though I don't think there is currently). So
this seems like the most direct fix, and applies regardless of any
args/argv cleanup.

It would become moot if we start to die() on pager setup, which I'd be
in favor of. But I think we should fix the segfault bug first, which
allows us to worry about the larger behavior change separately.

-Peff

[1] https://lore.kernel.org/git/YZhVA8DOjHu90gzs@coredump.intra.peff.net/
