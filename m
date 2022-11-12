Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4385AC433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 16:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiKLQ6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 11:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLQ6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 11:58:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AC15A11
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 08:58:45 -0800 (PST)
Received: (qmail 5318 invoked by uid 109); 12 Nov 2022 16:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 12 Nov 2022 16:58:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21810 invoked by uid 111); 12 Nov 2022 16:58:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 12 Nov 2022 11:58:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 12 Nov 2022 11:58:44 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] pack-objects: fix handling of multiple --filter
 options
Message-ID: <Y2/QxOnM/7UI4R8c@coredump.intra.peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 11:44:00AM +0100, René Scharfe wrote:

> Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
> leak, 2022-03-28) --filter options given to git pack-objects overrule
> earlier ones, letting only the leftmost win and leaking the memory
> allocated for earlier ones.  Fix that by only initializing the rev_info
> struct once.

Yikes. I wondered how we managed to miss this in the tests. Surely we
have some examples that use multiple filters?

I think the answer is that we do in t5616, but in practice they didn't
hit this bug because of the way filter-specs are treated server-sid3.
Even if we say "clone --filter=foo --filter=bar" on the client, the
server upload-pack coalesces that into a single "combine:foo+bar"
string, and that's what its pack-objects sees.

Your test here triggers it by invoking pack-objects directly, which
makes sense. That's a little different from how pack-objects is invoked
by the rest of Git in practice, but it's definitely something that
_should_ work. It's conceivable that somebody outside of Git could be
driving pack-objects directly, but also it's just a trap waiting to
spring for future developers.

-Peff
