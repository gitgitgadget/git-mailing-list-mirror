Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553AC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599222075B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1VTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:19:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:44200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1VTd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 17:19:33 -0400
Received: (qmail 29858 invoked by uid 109); 28 Aug 2020 21:19:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 21:19:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13919 invoked by uid 111); 28 Aug 2020 21:19:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 17:19:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 17:19:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2] midx: traverse the local MIDX first
Message-ID: <20200828211931.GA2190002@coredump.intra.peff.net>
References: <20200828180621.GA9036@nand.nand.local>
 <20200828202213.GA24009@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828202213.GA24009@nand.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 04:22:13PM -0400, Taylor Blau wrote:

> This patch addresses that by:
> 
>   - placing the local MIDX first in the chain when calling
>     'prepare_multi_pack_index_one()', and
> 
>   - introducing a new 'get_local_multi_pack_index()', which explicitly
>     returns the repository-local MIDX, if any.
> 
> Don't impose an additional order on the MIDX's '->next' pointer beyond
> that the first item in the chain must be local if one exists so that we
> avoid a quadratic insertion.

This version looks fine to me.

Thinking on it a bit more, we probably want this "local one is first"
behavior even without it fixing this bug. For normal packs, we always
prefer local copies over alternates, under the assumption that
alternates are likely to be more expensive to access (e.g., shared nfs).

Of course that somewhat goes out the window since we re-order lookups
these days based on where we've found previous objects (my mru stuff,
but even before that the single "last pack" variable). But it makes
sense to at least start with the local ones being given priority.

I don't think we do any mru tricks with the midx list, so it would stay
in local-first mode always, which is reasonable (you probably don't have
so many midx's that any reordering is worth it anyway).

It does mean we may consult an alternates midx before any local non-midx
packs, which _could_ be slower. But since this is all guesses and
heuristics anyway, I'd wait until somebody has a concrete case where
they can demonstrate a different ordering scheme works better.

-Peff
