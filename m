Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA1C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 16:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiKMQoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 11:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKMQoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 11:44:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A120ADEF0
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 08:44:08 -0800 (PST)
Received: (qmail 9587 invoked by uid 109); 13 Nov 2022 16:44:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 13 Nov 2022 16:44:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 531 invoked by uid 111); 13 Nov 2022 16:44:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Nov 2022 11:44:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Nov 2022 11:44:06 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] pack-objects: fix handling of multiple --filter
 options
Message-ID: <Y3Ee1o82JS6Lxr71@coredump.intra.peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
 <Y2/QxOnM/7UI4R8c@coredump.intra.peff.net>
 <Y3B6PxNaZvmm5OD2@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3B6PxNaZvmm5OD2@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 13, 2022 at 12:01:51AM -0500, Taylor Blau wrote:

> > Yikes. I wondered how we managed to miss this in the tests. Surely we
> > have some examples that use multiple filters?
> >
> > I think the answer is that we do in t5616, but in practice they didn't
> > hit this bug because of the way filter-specs are treated server-sid3.
> > Even if we say "clone --filter=foo --filter=bar" on the client, the
> > server upload-pack coalesces that into a single "combine:foo+bar"
> > string, and that's what its pack-objects sees.
> 
> ...Or in other words, clients aren't broken here because we always send
> "combine" filters when multiple `--filter` arguments are passed to `git
> clone`, `git fetch`, etc.

Right.

> Is that always the case? I *think* so, but it would be nice to know if
> there was a way that clients would not send the `combine` filter with >1
> filter.

I think it's always the case at least with Git's code, because the
client-side send_filter() sends from list_objects_filter_spec(), which
takes the single-string spec of the top-level combine filter. It would
have to explicitly iterate over the sub-filters to come up with anything
else, and I don't think we even have a function for that (we do when
evaluating them, of course, but not for generically iterating or
producing a multi-string set of specs).

And on the server side, even if a client did send multiple "filter"
lines, I think we'd hit list_objects_filter_die_if_populated(), so we'd
complain.

I don't know of any other code paths that could hit this (can you filter
on an outgoing push?). But in the end I'm not sure it even matters. We
should be fixing the bug anyway, and this is all just understanding how
far-reaching its effects are (and the answer seems to be: not very).

-Peff
