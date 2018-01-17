Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8361F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeAQWJF (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:09:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:47132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753059AbeAQWJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:09:04 -0500
Received: (qmail 20854 invoked by uid 109); 17 Jan 2018 22:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 22:09:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6202 invoked by uid 111); 17 Jan 2018 22:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 17:09:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 17:09:02 -0500
Date:   Wed, 17 Jan 2018 17:09:02 -0500
From:   Jeff King <peff@peff.net>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3] packed_ref_cache: don't use mmap() for small files
Message-ID: <20180117220902.GA14952@sigill.intra.peff.net>
References: <20180115235251.GA21900@sigill.intra.peff.net>
 <20180116193815.4568-1-kgybels@infogroep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180116193815.4568-1-kgybels@infogroep.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 08:38:15PM +0100, Kim Gybels wrote:

> Take a hint from commit ea68b0ce9f8 (hash-object: don't use mmap() for
> small files, 2010-02-21) and use read() instead of mmap() for small
> packed-refs files.
> 
> This also fixes the problem[1] where xmmap() returns NULL for zero
> length[2], for which munmap() later fails.
> 
> Alternatively, we could simply check for NULL before munmap(), or
> introduce xmunmap() that could be used together with xmmap(). However,
> always setting snapshot->buf to a valid pointer, by relying on
> xmalloc(0)'s fallback to 1-byte allocation, makes using snapshots
> easier.
> 
> [1] https://github.com/git-for-windows/git/issues/1410
> [2] Logic introduced in commit 9130ac1e196 (Better error messages for
>     corrupt databases, 2007-01-11)
> 
> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> ---
> 
> Change since v2: removed separate case for zero length as suggested by Peff,
> ensuring that snapshot->buf is always a valid pointer.

Thanks, this looks fine to me (I'd be curious to hear from Michael if
this eliminates the need for the other patches).

-Peff
