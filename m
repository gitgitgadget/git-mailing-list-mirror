Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6DAC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192BC61A0D
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhCZDRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:17:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:49386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhCZDQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 23:16:54 -0400
Received: (qmail 28361 invoked by uid 109); 26 Mar 2021 03:16:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 03:16:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6971 invoked by uid 111); 26 Mar 2021 03:16:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Mar 2021 23:16:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Mar 2021 23:16:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] csum-file: flush less often
Message-ID: <YF1SJRhb8hz7NP0/@coredump.intra.peff.net>
References: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
 <84ccabca-0bd3-d0cb-6b38-f96d75c0bbd6@gmail.com>
 <xmqq8s6bvzpf.fsf@gitster.g>
 <xmqq4kgzvzf6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kgzvzf6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 11:52:29AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> So, I'm of two minds here:
> >>
> >>  1. This is embarassing. I wasted everyone's time for nothing. I can retract
> >>     this patch.
> >>
> >>  2. This is embarassing. I overstated the problem here. But we might be able
> >>     to eke out a tiny performance boost here.
> >>
> >> I'm open to either. I think we should default to dropping this patch unless
> >> someone thinks the rewrite above is a better organization of the logic. (I
> >> can then send a v2 including that version and an updated commit message.)
> >
> > 3. The current code around "if (nr == sizeof(f->buffer))" might be a
> >    bit too clever for readers who try to understand what is going
> >    on, and the whole "while" loop may deserve a comment based on
> >    what you wrote before your replacement implementation.

Yes, my first thought on reading Stolee's post-image was: wait, how do
we know when data needed flushed from the buffer? But that is not new in
his patch. It is confusing before and after. :)

> Having said all that, comparing the original and the version updated
> with your "flush less often" patch, I find the latter quite easier
> to read, so as long as the update does not give us 1% slowdown, it
> may be worth adopting for the readability improvement alone.
> 
> Of course, if we were to go that route, the sales pitch in the log
> message needs to be updated.

Yeah, I am OK with either version, as long as it is justified correctly
in the commit message. IMHO the big difference is that the original is
using local data/offset variables in order to provide a layer of
indirection when we get to the hash+flush code. And Stolee's patch is
calling the same code in the two places instead.

It's quite possible that gives the compiler slightly more opportunity to
micro-optimize (which doesn't matter if you are feeding big blocks, but
may if you are feeding 4 bytes at a time as in the midx code; though in
that case it is entirely possible that the caller allocating a single
array, writing it, and then feeding it to hashwrite() would be faster
still, though a little more cumbersome).

-Peff
