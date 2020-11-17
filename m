Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3B8C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44547204EC
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKQWaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:30:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:33042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgKQWaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 17:30:13 -0500
Received: (qmail 19015 invoked by uid 109); 17 Nov 2020 22:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 22:30:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4848 invoked by uid 111); 17 Nov 2020 22:30:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 17:30:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 17:30:11 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: fix cast in compare_tasks_by_selection()
Message-ID: <20201117223011.GA642234@coredump.intra.peff.net>
References: <d80423b7-c89d-99a2-ce49-8308822f7769@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d80423b7-c89d-99a2-ce49-8308822f7769@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 10:59:49PM +0100, René Scharfe wrote:

> compare_tasks_by_selection() is used with QSORT and gets passed pointers
> to the elements of "static struct maintenance_task tasks[]".  It casts
> the *addresses* of these passed pointers to element pointers, though,
> and thus effectively compares some unrelated values from the stack.  Fix
> the casts to actually compare array elements.
> 
> Detected by USan (make SANITIZE=undefined test).

I checked the caller here, and indeed, it's passing an array-of-struct
so your patch is doing the right thing (not that I doubted it, but
that's what review is for).

This qsort void-pointer convention seems to create a lot of confusion
(not just the lack of type-safety, but the fact that it's getting a
pointer to the element). I felt like we had a discussion about this a
while ago, and indeed, I found:

  https://lore.kernel.org/git/7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de/

The whole sub-thread is worth reading, but the macro you arrived at in:

  https://lore.kernel.org/git/c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de/

seems pretty reasonable.

-Peff
