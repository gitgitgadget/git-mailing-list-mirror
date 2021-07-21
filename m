Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560EFC6377D
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2B6135A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbhGUJXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:23:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:52944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238404AbhGUJOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:14:18 -0400
Received: (qmail 1790 invoked by uid 109); 21 Jul 2021 09:54:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 09:54:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2732 invoked by uid 111); 21 Jul 2021 09:54:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 05:54:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 05:54:50 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 03/24] pack-bitmap-write.c: free existing bitmaps
Message-ID: <YPfu6rdpaisTEcRh@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <490d733d121e206ccdc335812c03f31c380bcd86.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <490d733d121e206ccdc335812c03f31c380bcd86.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:04PM -0400, Taylor Blau wrote:

> When writing a new bitmap, the bitmap writer code attempts to read the
> existing bitmap (if one is present). This is done in order to quickly
> permute the bits of any bitmaps for commits which appear in the existing
> bitmap, and were also selected for the new bitmap.
> 
> But since this code was added in 341fa34887 (pack-bitmap-write: use
> existing bitmaps, 2020-12-08), the resources associated with opening an
> existing bitmap were never released.
> 
> It's fine to ignore this, but it's bad hygiene. It will also cause a
> problem for the multi-pack-index builtin, which will be responsible not
> only for writing bitmaps, but also for expiring any old multi-pack
> bitmaps.
> 
> If an existing bitmap was reused here, it will also be expired. That
> will cause a problem on platforms which require file resources to be
> closed before unlinking them, like Windows. Avoid this by ensuring we
> close reused bitmaps with free_bitmap_index() before removing them.

I agree with all of that. But just "it's a memory leak" would have
contented me, too. :)

-Peff
