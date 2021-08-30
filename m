Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F463C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D7160ED6
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhH3UuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:50:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:34260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhH3UuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:50:21 -0400
Received: (qmail 1474 invoked by uid 109); 30 Aug 2021 20:49:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 20:49:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10287 invoked by uid 111); 30 Aug 2021 20:49:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 16:49:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 16:49:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
Message-ID: <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local>
 <xmqqeeaa6fey.fsf@gitster.g>
 <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 08:22:25PM +0200, René Scharfe wrote:

> > It however may not be a bad idea to catch these code paths where a
> > local variable masks 'ignore_case' (and possibly other globals) and
> > rename these local ones to avoid a mistake like this.
> 
> The name itself is OK, I think, but using it at global scope is
> confusing.  -Wshadow can help find such cases, but not this one, as
> test-hashmap.c doesn't include the global declaration.  Moving the
> global into a struct to provide a poor man's namespace would fix this
> for all namesakes, assisted by the compiler.  We'd then access it as
> the_config.ignore_case or even the_config.core.ignore_case.
> 
> Moving all config-related variables would be quite noisy, I guess,
> and probably conflict with lots of in-flight patches, but might be
> worth it.

Really most of these ought to be in the repository struct anyway, I
would think. The value of ignore_case comes from core.ignorecase, which
is going to be repository-specific. We are probably doing the wrong
thing already by looking at the parent core.ignorecase value when
operating in an in-process submodule, but nobody noticed because it's
quite unlikely for a submodule to have a different setting than the
parent.

-Peff
