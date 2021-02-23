Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E46C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754B664E22
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhBWSwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:52:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:41994 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhBWSwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:52:21 -0500
Received: (qmail 26841 invoked by uid 109); 23 Feb 2021 18:51:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 18:51:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2509 invoked by uid 111); 23 Feb 2021 18:51:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 13:51:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 13:51:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH v4 3/8] builtin/pack-objects.c: add '--stdin-packs' option
Message-ID: <YDVOuwMTBoQ57Omk@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
 <649cf9020bfdae9f48e3efbfbc52429cefd31432.1614047097.git.me@ttaylorr.com>
 <xmqqsg5n436v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg5n436v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:07:52AM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > (I found it convenient while developing this patch to have 'git
> > pack-objects' report the number of objects which were visited and got
> > their namehash fields filled in during traversal. This is also included
> > in the below patch via trace2 data lines).
> 
> It does sound like a well thought out strategy to give name-hash to
> entries that we may have to find good delta bases afresh, while
> stopping upon hitting parts of the history we won't have to (either
> because they are in "excluded" packs, which you did here, or because
> they can take advantage of the "reuse existing delta base" logic [*],
> which we may want to look further into in future follow-on topics).
> 
> [Footnote]
> 
> * I presume that such a logic may, instead of stopping at an object
>   that is in an excluded pack, stop at an object that is stored in
>   the current pack as a delta and its base is also going to be
>   packed (and the latter by definition is always true, I presume, as
>   everything in the included pack would be packed)

I'm not sure if using deltas as a heuristic for stopping traversal makes
sense. They don't necessarily correspond to the history graph, or to
what was pushed. E.g., if I see that tree X is a delta against tree Y,
then we might say: if Y is not excluded by being in one of the base
packs, then we will reuse the delta. We do not need the namehash of X,
since we already know its delta.

But that does not tell us anything about the subtrees and blobs
contained in X. We still want to traverse X in order to find out _their_
name hashes, because it is likely that we will need to delta some of
those.

Of course if you see a blob that is a delta that you plan to reuse, you
know you can stop there. But by the time you get to it, you already know
its namehash, and there is nothing left to traverse. :)

-Peff
