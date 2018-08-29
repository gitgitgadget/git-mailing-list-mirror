Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5ECC1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeH3BpO (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:45:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:32986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727086AbeH3BpO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:45:14 -0400
Received: (qmail 21793 invoked by uid 109); 29 Aug 2018 21:46:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 21:46:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19341 invoked by uid 111); 29 Aug 2018 21:46:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 17:46:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 17:46:21 -0400
Date:   Wed, 29 Aug 2018 17:46:21 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        pclouds@gmail.com, johannes.schindelin@gmx.de, nico@cam.org
Subject: Re: [PATCH 2/3] t/helper/test-delta: segfault on OOB access
Message-ID: <20180829214621.GD29880@sigill.intra.peff.net>
References: <20180829205857.77340-1-jannh@google.com>
 <20180829205857.77340-2-jannh@google.com>
 <20180829213433.GC29880@sigill.intra.peff.net>
 <CAG48ez2BL1fgP_FkUi=6EYAuA+ja3ujZFFqKkPQN50tRCEUJiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2BL1fgP_FkUi=6EYAuA+ja3ujZFFqKkPQN50tRCEUJiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 11:40:41PM +0200, Jann Horn wrote:

> > If we want to detect this kind of thing in tests, we should probably be
> > relying on tools like ASan, which would cover all mmaps.
> >
> > It would be nice if there was a low-cost way to detect this in
> > production use, but it looks like this replaces mmap with
> > read_in_full(), which I think is a non-starter for most uses.
> 
> I think even with ASAN, you'd still need read_in_full() or an mmap()
> wrapper that fiddles with the ASAN shadow, because mmap() always maps
> whole pages:
> 
> $ cat mmap-read-asan-blah.c
> #include <sys/mman.h>
> #include <stdlib.h>
> int main(void) {
>   volatile char *p = mmap(NULL, 1, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>   p[200] = 1;
> }
> $ gcc -o mmap-read-asan-blah mmap-read-asan-blah.c -fsanitize=address
> $ ./mmap-read-asan-blah
> $

Yeah, I was just trying to run your tests with ASan and couldn't
convince it to complain. I also tried MSan, but no luck.

> But that aside, you do have a point about having some custom hack for
> a single patch.

I'm also not sure how portable it is. Looks like we have a Windows
wrapper for getpagesize(), but I don't see any other uses of mprotect().

-Peff
