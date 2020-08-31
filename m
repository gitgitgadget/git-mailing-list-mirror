Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B969C433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 09:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9DF2073A
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 09:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgHaJ3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:29:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:45258 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgHaJ3t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 05:29:49 -0400
Received: (qmail 18423 invoked by uid 109); 31 Aug 2020 09:29:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 Aug 2020 09:29:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15227 invoked by uid 111); 31 Aug 2020 09:29:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Aug 2020 05:29:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Aug 2020 05:29:46 -0400
From:   Jeff King <peff@peff.net>
To:     ori@eigenstate.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
Message-ID: <20200831092946.GA2812764@coredump.intra.peff.net>
References: <A1CA9D499EDDACBA275BA61E114645F0@eigenstate.org>
 <59efeeab-49de-17e7-8b1c-355d6ef31b5d@web.de>
 <xmqqwo1gglf5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwo1gglf5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 30, 2020 at 09:15:10AM -0700, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> >> Will that work? I'd expect that modern pack files end up being
> >> offset deltas, rather than reference deltas.
> >
> > True, but going down all the way would work:
> 
> Perhaps, but I'd rather use pack-objects to prepare the repository
> with no-delta-base-offset to force ref deltas.

Yeah, that seems like a much better test setup.

It does raise an interesting question, though. I had imagined we would
limit the depth of all delta chains here, not just ref-deltas. But it is
true that ofs deltas can't cycle. Without cycles, neither type can go on
indefinitely (they are limited by the number of entries in the
packfile). I could see arguments going either way:

  - ofs deltas cannot cycle, so we do not need a counter that limits
    them (and which _could_ find a false positive). So we should not
    limit them.

  - a counter is preventing us from following cycles indefinitely, but
    also hardening us against misbehavior due to bugs or insanely large
    delta chains (intentional or not). So we should include ofs deltas
    in our limit.

A related point is that delta chains might be composed of both types. If
we don't differentiate between the two types, then the limit is clearly
total chain length. If we do, then is the limit the total number of
ref-deltas found in the current lookup, or is it the number of
consecutive ref-deltas? I guess it would have to be the former if our
goal is to catch cycles (since a cycle could include an ofs-delta, as
long as a ref-delta is the part that forms the loop).

-Peff
