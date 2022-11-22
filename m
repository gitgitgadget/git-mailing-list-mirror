Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB04FC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiKVTDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiKVTDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:03:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88604FC7
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:02:59 -0800 (PST)
Received: (qmail 18791 invoked by uid 109); 22 Nov 2022 19:02:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 19:02:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5799 invoked by uid 111); 22 Nov 2022 19:02:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 14:02:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 14:02:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 0/3] pack-objects: fix and simplify --filter handling
Message-ID: <Y30c4YYGb5bOaZae@coredump.intra.peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2022 at 11:03:35AM +0100, René Scharfe wrote:

> Fix a regression that prevents using multiple --filter options, simplify
> the option parsing code and avoid relying on undefined behavior in it.
> 
> Patch 3 conflicts with cc/filtered-repack in seen, but not semantically.
> 
> Changes since v1:
> - Added patch 1 to fix an issue with existing tests.
> - Separate patch 2 for new tests.
> - Test using blob size filters, only, which is a bit simpler.
> - Test both combinations to also catch not just the current
>   last-one-wins regression, but also a possible future first-one-wins
>   issue.
> - Actually revert 5cb28270a1 (pack-objects: lazily set up
>   "struct rev_info", don't leak, 2022-03-28) instead of having a
>   minimal fix and then adding some kind of middle ground by using a
>   separate struct list_objects_filter_options.

Thanks, this looks good to me. The new test is a little funny in that
it's somewhat-nonsensical input, but I find it unlikely that we'd ever
add code to treat two instances of the same filter type specially.
Compared to something that produces two distinct effects (like a blob
and tree-depth filter combined), it also requires the "test in both
directions" trick to cover everything.

But I do like that it's easier to reason about what the output _should_
be. So I don't feel too strongly about it either way.

-Peff
