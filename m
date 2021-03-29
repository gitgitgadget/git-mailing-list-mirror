Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D71C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655F461922
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhC2M7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:59:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:35546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231570AbhC2M7O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:59:14 -0400
Received: (qmail 10837 invoked by uid 109); 29 Mar 2021 12:59:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 12:59:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13638 invoked by uid 111); 29 Mar 2021 12:59:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 08:59:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 08:59:12 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 16/16] midx.c: improve cache locality in
 midx_pack_order_cmp()
Message-ID: <YGHPINrwIZ1mKK+y@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <550e785f10ba14f166958501c007b75a04052a0d.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <550e785f10ba14f166958501c007b75a04052a0d.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:05:42PM -0500, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> There is a lot of pointer dereferencing in the pre-image version of
> 'midx_pack_order_cmp()', which this patch gets rid of.
> 
> Instead of comparing the pack preferred-ness and then the pack id, both
> of these checks are done at the same time by using the high-order bit of
> the pack id to represent whether it's preferred. Then the pack id and
> offset are compared as usual.
> 
> This produces the same result so long as there are less than 2^31 packs,
> which seems like a likely assumption to make in practice.

Obviously this patch is brilliant. ;)

Did we record any numbers to show the improvement here? I don't think it
can be demonstrated with this series (since most of the code is dead),
but I recall that this was motivated by a noticeable slowdown.

I briefly wondered whether the complicated midx_pack_order_cmp() in
pack-revindex.c, which is used for the bsearch() there, could benefit
from the same speedup. It's only log(n), of course, instead of n*log(n),
but one might imagine making "n" calls to it. I don't think it makes
sense, though. The pointer dereferencing there is into the midx mmap
itself. Creating an auxiliary array would defeat the purpose.

-Peff
