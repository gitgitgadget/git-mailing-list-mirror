Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC83C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJKNIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJKNIt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:08:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296417FFAB
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:08:48 -0700 (PDT)
Received: (qmail 32272 invoked by uid 109); 11 Oct 2022 13:08:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 13:08:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22240 invoked by uid 111); 11 Oct 2022 13:08:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Oct 2022 09:08:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Oct 2022 09:08:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta <edecosta@mathworks.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #03; Mon, 10)
Message-ID: <Y0Vq3iGifYeBxPbn@coredump.intra.peff.net>
References: <xmqqlepnz1vu.fsf@gitster.g>
 <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net>
 <xmqqczazx7dn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczazx7dn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 10:21:40PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's a tiny leak in this one. Here's a fix that can go on top.
> >
> > -- >8 --
> > Subject: [PATCH] fsmonitor: fix leak of warning message
> >
> > The fsm_settings__get_incompatible_msg() function returns an allocated
> > string.  So we can't pass its result directly to warning(); we must hold
> > on to the pointer and free it to avoid a leak.
> >
> > The leak here is small and fixed size, but Coverity complained, and
> > presumably SANITIZE=leaks would eventually.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  fsmonitor.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Is there anybody else who is reading Coverity reports, I wonder.
> This one is a clear positive.

I doubt it. My personal fork still has the coverity github-action which
I showed last year[1]. We could merge that, but giving access to the
project is a minor pain. And of course the full list is full of false
positives. One nice thing about coverity is that it marks each defect by
date, and tells you how many new ones there are. So when I push up my
next+personal branches build, I usually just skim over any new ones it
reports. I'd say about 10% of them are actionable.

-Peff

[1] https://lore.kernel.org/git/YV5dmkkuCqAY2qqG@coredump.intra.peff.net/
