Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F018C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 05:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiK1FN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 00:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiK1FNz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 00:13:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A1FF00C
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 21:13:54 -0800 (PST)
Received: (qmail 7040 invoked by uid 109); 28 Nov 2022 05:13:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Nov 2022 05:13:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 339 invoked by uid 111); 28 Nov 2022 05:13:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Nov 2022 00:13:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Nov 2022 00:13:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Kyle Zhao <kylezhao@tencent.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t5516: fail to run in verbose mode
Message-ID: <Y4RDkGZE3cZFS25d@coredump.intra.peff.net>
References: <20221121134040.12260-1-worldhello.net@gmail.com>
 <xmqqo7szsjs4.fsf@gitster.g>
 <Y30eK/mNYeLNtOi2@coredump.intra.peff.net>
 <xmqqwn7mo4eu.fsf@gitster.g>
 <Y37F1nxifC8o8qEQ@coredump.intra.peff.net>
 <xmqqzgcfeik0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgcfeik0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2022 at 01:58:55PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One thing I'd worry about is buffering. One of the nice things about
> > "-v" is that there is nothing between you and the running programs, so
> > you are much less likely to be fooled about the order of events in the
> > output. Or wondering why nothing is happening because real-time output
> > seems to have stalled. But piping through "cat" may end up with weird
> > pauses while it fills up a 4k buffer. Using stdbuf could help, but
> > that's far from portable.
> 
> We could pipe to "dd bs=1 conv=fsync" (tongue-in-cheek---I think
> conv=fsync is a GNU thing).

We don't need the fsync; we are just worried about in-process buffering,
not kernel-level flushing. So bs=1 is sufficient, in that it would
use syscalls to read/write single bytes. It would just be horribly
inefficient.

We really just want immediate partial read()/write() but with sensible
buffer sizes. It would be easy to write a 5-line C program that did this
if we really wanted to. I'm not entirely convinced it's worth worrying
too much about, though.

-Peff
