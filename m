Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C508C56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4692075A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbgKZB1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:27:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:43272 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbgKZB1a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:27:30 -0500
Received: (qmail 12506 invoked by uid 109); 26 Nov 2020 01:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 01:27:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12591 invoked by uid 111); 26 Nov 2020 01:27:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Nov 2020 20:27:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Nov 2020 20:27:28 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 0/2] midx: prevent against racily disappearing packs
Message-ID: <X78EgOPAVg1vQRo9@coredump.intra.peff.net>
References: <cover.1606324509.git.me@ttaylorr.com>
 <xmqqblfldts4.fsf@gitster.c.googlers.com>
 <X777dl3pqioME7uM@coredump.intra.peff.net>
 <X77/LEwWlz9fjbYM@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X77/LEwWlz9fjbYM@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 08:04:44PM -0500, Taylor Blau wrote:

> > So we could perhaps BUG() in find_revindex_entry() instead of returning
> > NULL. A quick segfault accomplishes mostly the same thing, though the
> > BUG() could distinguish the two cases more clearly.
> 
> Yeah, a find_revindex_entry() that returns NULL means that the caller is
> probably dead in the water.
> 
> FWIW, this function gets touched by a series that I'm working on here:
> [1]. There, I think "returning NULL" is equivalent to "returning -1",
> and the problem exists there, too.
> 
> We could return a different negative number, call BUG(), or do nothing
> other than what's written. I don't have any strong feelings, though.

Yeah, I was suggesting _never_ returning a failure, and just hitting a
BUG() within the function. So it does not matter then how you represent
the error return type, because there isn't one. :)

Looking over the callers, there are actually a few that check the return
value and handle it sanely. I suspect they can never trigger in
practice, given that the other callers would all segfault, and we have
not seen any reports in the 15 years during which that has been the
case. But perhaps some of them can be triggered by bogus pack data that
nobody has ever run into in the real world.

At any rate, I am content to ignore it until somebody feels like digging
into each caller. A BUG() is only marginally better than an immediate
segfault anyway, and I'd prefer not to disrupt more substantive
improvements in the area.

-Peff
