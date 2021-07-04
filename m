Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8EC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F0B6186A
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGDJEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:04:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:41096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGDJEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 05:04:04 -0400
Received: (qmail 8007 invoked by uid 109); 4 Jul 2021 09:01:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Jul 2021 09:01:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5880 invoked by uid 111); 4 Jul 2021 09:01:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Jul 2021 05:01:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 4 Jul 2021 05:01:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] khash: clarify that allocations never fail
Message-ID: <YOF46CU+SSDRE51/@coredump.intra.peff.net>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
 <87v95r8w86.fsf@evledraar.gmail.com>
 <5cc24582-ed96-453a-fbad-d3fb83c8f949@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cc24582-ed96-453a-fbad-d3fb83c8f949@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 03, 2021 at 02:56:50PM +0200, René Scharfe wrote:

> > If anything we might consider renaming it via coccinelle to
> > XALLOC_ARRAY(), XREALLOC_ARRAY() etc. to make it clear that they handle
> > any errors themselves.
> 
> I don't think there's any confusion in our internal code about the macros'
> handling of allocation errors.

Agreed.

> The following semantic patch finds a leery xmalloc() caller in
> compat/mmap.c, though:
> 
> @@
> expression PTR, SIZE, SIZE2;
> @@
> (
>   PTR = xmalloc(SIZE);
> |
>   PTR = xcalloc(SIZE, SIZE2);
> |
>   PTR = xrealloc(SIZE);
> |
>   ALLOC_ARRAY(PTR, SIZE);
> |
>   CALLOC_ARRAY(PTR, SIZE);
> |
>   REALLOC_ARRAY(PTR, SIZE);
> )
>   if (
> - PTR == NULL
> + 0
>   ) {...}

IMHO that should not be using xmalloc() at all. It is a replacement for
system mmap, which can fail with ENOMEM, and we should be able to do the
same. Using xmalloc here is probably losing an opportunity to close
another pack window to free up memory for a new one.

I doubt it matters that much in practice (most systems are not even
compiling or using this code, and it would only matter in a tight memory
situation). But as a general rule, I think compat/ wrappers should
behave as much like (sensible) system equivalents as possible.

-Peff
