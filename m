Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA8C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDEA20771
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbgFSNcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:32:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:37164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgFSNcA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:32:00 -0400
Received: (qmail 2753 invoked by uid 109); 19 Jun 2020 13:32:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 13:32:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14691 invoked by uid 111); 19 Jun 2020 13:32:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 09:32:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 09:31:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-reach: plug minor memory leak after using
 is_descendant_of()
Message-ID: <20200619133159.GB2540897@coredump.intra.peff.net>
References: <ada13c16-d964-c6ee-80ac-626edbc5f52d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ada13c16-d964-c6ee-80ac-626edbc5f52d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 03:13:46PM +0200, René Scharfe wrote:

> ref_newer() builds a commit_list to pass a single potential ancestor to
> is_descendant_of().  The latter leaves the list intact.  Release the
> allocated memory after the call.

Looks obviously correct.

> ---
> We could allocate the commit_list on the stack, which would simplify such
> glue code quite a bit.  That would be dangerous in case is_descendant_of()
> or some other function that is handed such a list tries to consume/free()
> it.  How can we be tell a function is safe to be given a stack-allocated
> list?  Perhaps by marking its argument as const.  Or by converting all
> functions to arrays.

Yeah, if we're not worried about the performance implications of the
extra allocation, I think it's better to err on the side of safety.

I do agree that if we consistently passed an array (and length), some of
these functions would get less awkward. I tried a few years ago to
convert many of the commit_list uses to arrays, but it was a bit of a
yak shave, since often they get lists from callers, who get it from
rev_info, etc. And some of those callers _do_ like having lists, because
they want to do O(1) splicing, etc.

-Peff
