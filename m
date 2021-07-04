Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E2C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 10:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475E2613F7
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 10:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGDKNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 06:13:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:41162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhGDKNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 06:13:40 -0400
Received: (qmail 8124 invoked by uid 109); 4 Jul 2021 10:11:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Jul 2021 10:11:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6486 invoked by uid 111); 4 Jul 2021 10:11:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Jul 2021 06:11:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 4 Jul 2021 06:11:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] khash: clarify that allocations never fail
Message-ID: <YOGJOO6l6bIsISkT@coredump.intra.peff.net>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
 <87v95r8w86.fsf@evledraar.gmail.com>
 <5cc24582-ed96-453a-fbad-d3fb83c8f949@web.de>
 <YOF46CU+SSDRE51/@coredump.intra.peff.net>
 <b2c9b072-b2ac-625b-4f0f-9ba1ca3321d7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2c9b072-b2ac-625b-4f0f-9ba1ca3321d7@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 04, 2021 at 11:41:23AM +0200, René Scharfe wrote:

> Btw. the found code is:
> 
> 	start = xmalloc(length);
> 	if (start == NULL) {
> 		errno = ENOMEM;
> 		return MAP_FAILED;
> 	}
> 
> start cannot be NULL, so the check is dead code.

Yep, so it's doubly silly.

> > IMHO that should not be using xmalloc() at all. It is a replacement for
> > system mmap, which can fail with ENOMEM, and we should be able to do the
> > same. Using xmalloc here is probably losing an opportunity to close
> > another pack window to free up memory for a new one.
> 
> Do you mean using malloc(3) directly instead of xmalloc() would no
> longer try to release pack windows?  xmalloc() hasn't done that anymore
> since 9827d4c185 (packfile: drop release_pack_memory(), 2019-08-12).

No, I meant that by using xmalloc() here, if the allocation fails, we'll
immediately die(). Whereas the caller of mmap() could get the ENOMEM
error, then unmap an in-use pack window and try again.

However, I forgot that we don't actually do that (yet). We unmap windows
if we go over our own packed_git_window_size counter, but not when mmap
fails. Eric posted a patch recently to change that, though (at which
point the die() in xmalloc() would be working against us).

(Actually, we did _try_ to do something like that in xmmap prior to
9827d4c185, but I don't think it actually worked since it was based on
our own internal limit, and not what the OS would allow).

> xmalloc() still brings support for zero-sized allocations on platforms
> whose malloc(3) doesn't like them, and it enforces GIT_ALLOC_LIMIT.
> mmap() is supposed give up with EINVAL if the length is 0, so the
> first feature is not actually helping.  And GIT_ALLOC_LIMIT is not
> documented and only useful for testing, right?

Yeah, I think failing on a 0-length mmap is OK, since that's what real
systems do (and this is a wrapper). Our xmmap_gently() handles this,
which is the right spot.

I don't think of GIT_ALLOC_LIMIT as something we're committed to
publicly supporting, though I have (ab)used it once or twice myself.
However, I'm not sure if it makes sense here. True, on a system without
mmap it is a heap allocation, but to me it's conceptually very different
than a normal allocation (and on a system with mmap, we have no problem
at all requesting arbitrarily large maps). If we did want to put a limit
here, I think we'd want to do it at the xmmap layer, using a separate
variable.

-Peff
