Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A221F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 07:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfJMHix (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 03:38:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:46910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728198AbfJMHix (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 03:38:53 -0400
Received: (qmail 6148 invoked by uid 109); 13 Oct 2019 07:38:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Oct 2019 07:38:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16007 invoked by uid 111); 13 Oct 2019 07:41:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Oct 2019 03:41:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Oct 2019 03:38:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
Message-ID: <20191013073851.GA7001@sigill.intra.peff.net>
References: <20190913130226.7449-11-chriscool@tuxfamily.org>
 <20191010235952.174426-1-jonathantanmy@google.com>
 <20191011180125.GA20601@sigill.intra.peff.net>
 <xmqqsgnyg76d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgnyg76d.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 12, 2019 at 09:04:58AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The current code does so by creating a new entry in the reused_chunks
> > array. In the worst case that can grow to have the same number of
> > entries as we have objects. So this code was an attempt to pad the
> > header of a shrunken entry to keep it the same size. I don't remember
> > all the problems we ran into with that, but in the end we found that it
> > didn't actually help much, because in practice we don't end up with a
> > lot of chunks anyway.
> 
> Hmm, I am kind of surprised that the decoding side allowed such a
> padding.

IIRC, the "padding" is just a sequence of 0-length-plus-continuation-bit
varint bytes. And for some reason it worked for the size but not for the
delta offset value. So the decoder wasn't aware of it, but simply hadn't
explicitly enforced that there weren't pointless bytes.

But yeah, it seems like a pretty hacky thing to rely on. I don't think
we ever even ran that code in production, and the if(0) was just
leftover experimental cruft.

> > I think the original code may simply have been buggy and nobody noticed.
> > Here's what I wrote when this line was added in our fork:
> [...]
> Impressed by the careful thinking here.

It's unfortunate that the reasoning there wasn't part of the earlier
submission. I'm not sure how to reconcile that. The patches as
originally written can't be applied now (they were munged over the years
during merges with upstream). And some of them are just "oops, fix this
dumb bug" trash that we wouldn't want to take anyway.

So I think at best they're something for somebody to manually look at
and try to incorporate into the commit messages of the revised patch
series. But I didn't give them to Christian to work with because it's
hard to even figure out which patches are still relevant. I wish I had a
better tooling there. I've been playing with something that looks at a
diff and then tries to blame each of the touched lines. Which is sort of
like the "-L" line-log, I guess, but for a very non-contiguous set of
lines.

-Peff
