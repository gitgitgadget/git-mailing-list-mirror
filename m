Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE5C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AD664E2A
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhA3JIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:08:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:41430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhA3JHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:07:55 -0500
Received: (qmail 16676 invoked by uid 109); 30 Jan 2021 08:50:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Jan 2021 08:50:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23317 invoked by uid 111); 30 Jan 2021 08:50:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jan 2021 03:50:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jan 2021 03:50:47 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?6Zi/5b6354OI?= via GitGitGadget 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf.c: optimize program logic
Message-ID: <YBUd504cLUJTLEQY@coredump.intra.peff.net>
References: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
 <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
 <YBBeLIhd+VHS25CE@coredump.intra.peff.net>
 <CAOLTT8RroMdaty-SwAfK3OSeuFA7PE6ZhPCL4vgrxFxNihdGbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8RroMdaty-SwAfK3OSeuFA7PE6ZhPCL4vgrxFxNihdGbQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 02:09:12PM +0800, 胡哲宁 wrote:

> > I'm not sure that strbuf_grow() is safe, though. It relies on
> > ALLOC_GROW, which does not use st_add(), etc.
> >
> I want to say is that `strbuf_grow()` have checked overflow before
>  `ALLOC_GROW`,so that `strbuf_grow()`is maybe also safe too? :)
> void strbuf_grow(struct strbuf *sb, size_t extra)
> {
>        int new_buf = !sb->alloc;
>        if (unsigned_add_overflows(extra, 1) ||
>            unsigned_add_overflows(sb->len, extra + 1))
>                die("you want to use way too much memory");
>        ...

Oh, you're right. I misread it as checking only "extra", but of course
the second line there is making sure our total requested size does not
overflow.

I do think ALLOC_GROW() could still overflow internally as it sizes
larger than sb->len + extra. But this is quite unlikely on a 64-bit
system, as it would imply we're using on the order of 2^63 bytes of RAM
before we enter the function. It potentially could be a problem on a
32-bit system, though I'm not sure how much in practice (the numbers are
small enough to be reasonable, but I'm not sure it's realistic that a
single strbuf could already be using half of the available address
space).

-Peff
