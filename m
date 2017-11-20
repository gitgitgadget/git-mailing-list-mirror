Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA310202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 14:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdKTOUk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 09:20:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:34532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751194AbdKTOUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 09:20:38 -0500
Received: (qmail 22744 invoked by uid 109); 20 Nov 2017 14:20:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 14:20:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11652 invoked by uid 111); 20 Nov 2017 14:20:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 09:20:53 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 09:20:35 -0500
Date:   Mon, 20 Nov 2017 09:20:35 -0500
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through
 parallelization
Message-ID: <20171120142035.bfwu24oegw27ucs3@sigill.intra.peff.net>
References: <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
 <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
 <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
 <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
 <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
 <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com>
 <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
 <9ba23d2c-2198-55d7-5a02-69879fbbb3cb@gmail.com>
 <xmqq1sl017dw.fsf@gitster.mtv.corp.google.com>
 <92b0b0ff-6878-003a-b26f-3b4c2c857be3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92b0b0ff-6878-003a-b26f-3b4c2c857be3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 09:01:45AM -0500, Ben Peart wrote:

> Further testing has revealed that switching from the regular heap to a
> refactored version of the mem_pool in fast-import.c produces similar gains
> as parallelizing do_index_load().  This appears to be a much simpler patch
> for similar gains so we will be pursuing that path.

That sounds like a pretty easy win for index entries, which tend to
stick around in big clumps.

Out of curiosity, have you tried experimenting with any high-performance
3rd-party allocator libraries? I've often wondered if we could get a
performance improvement from dropping in a new allocator, but was never
able to measure any real benefit over glibc's ptmalloc2. The situation
might be different on Windows, though (i.e., if the libc allocator isn't
that great).

Most of the high-performance allocators are focused on concurrency,
which usually isn't a big deal for git. But tcmalloc, at least, claims
to be about 6x faster than glibc.

The reason I ask is that we could possibly get the same wins without
writing a single line of code. And it could apply across the whole
code-base, not just the index code. I don't know how close a general
purpose allocator could come to a pooled implementation, though. You're
inherently making a tradeoff with a pool in not being able to free
individual entries.

-Peff
