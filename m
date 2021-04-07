Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04138C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADF66121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDGVhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:37:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:43820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhDGVhu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 17:37:50 -0400
Received: (qmail 18200 invoked by uid 109); 7 Apr 2021 21:37:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 21:37:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23472 invoked by uid 111); 7 Apr 2021 21:37:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 17:37:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 17:37:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: There should have be git gc --repack-arguments
Message-ID: <YG4mImcQyTC1/S8X@coredump.intra.peff.net>
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
 <YG4J7vtTRVpGGLoo@coredump.intra.peff.net>
 <xmqq8s5tzv4f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s5tzv4f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 01:40:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> ... git repack ...  --max-pack-size=<desired pack size> to create split and
> >> smaller packs instead.
> > ...
> > You can also set pack.packSizeLimit for the latter, though I do not
> > recommend it. It will not help with memory usage (neither while
> > repacking nor for later commands).
> 
> In other words, passing --max-pack-size, whether it is done with a
> new --repack-arguments option or it is done with the existing
> pack.packSizeLimit configuration, would make things worse.

Right. I wish we didn't have --max-pack-size at all. I do not think it
is ever a good idea, and it complicates the packing code quite a bit.

These days we have index v2 to let us address more than 4GB in a
packfile. I suppose it's possible you could have a filesystem whose max
file size is smaller than your total packfile, but that seems pretty
unlikely these days (even 32-bit systems tend to have large file
support).

But that's all a tangent. :)

> So in conclusion:
> 
>  - attempting to repack everything into one pack on a memory starved
>    box would be helped with reduced window memory size.

Yes, though less than you might think. It is only trying to keep the
memory used by delta compression at bay. The per-object book-keeping
tends to be quite high by itself. If you are under memory pressure
during delta compression, you may also be better off reducing the number
of threads (since each thread is simultaneously using windowMemory
bytes).

>  - on a small box, it may make sense to avoid repacking everything
>    into one in the first place, but we do not want the number of
>    packs to grow unbounded.
> 
> Would the new geometric repack feature help here, especially for the
> latter?

Yes, I think it would. You'd perhaps want to generate a multi-pack-index
file, too, to avoid having to look for objects in multiple packs
sequentially (we have a "git repack --write-midx" option on the way, as
well).

-Peff
