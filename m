Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201FC19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 08:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiHKIrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiHKIrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 04:47:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C49910B6
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:47:30 -0700 (PDT)
Received: (qmail 8614 invoked by uid 109); 11 Aug 2022 08:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Aug 2022 08:47:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19923 invoked by uid 111); 11 Aug 2022 08:47:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Aug 2022 04:47:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Aug 2022 04:47:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
Message-ID: <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
References: <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 12:34:46AM +0200, René Scharfe wrote:

> > OK, so we call GetNamedPipeInfo() to find the size of the pipe buffer.
> > It's unclear to me from Microsoft's docs if that is the _total_ size, or
> > if it's the remaining available size. Hopefully the latter, since none
> > of this works otherwise. ;)
> >
> > But two corner cases:
> >
> >   - If we fail to get the size, we guess that it's the maximum. Is this
> >     dangerous? I'm not sure why the call would fail, but if for some
> >     reason it did fail and we can't make forward progress, would we
> >     enter an infinite recursion of mingw_write()? Would it be safer to
> >     bail with EAGAIN in such a case (through granted, that probably just
> >     puts us into an infinite loop in xwrite())?
> 
> AFAIU it's the total size, not the available space.  I think I confused
> it with PIPE_BUF, which we should use instead.

Hmm. If it's giving us the total size, that seems like it may fail in a
case like this:

  - we write a smaller amount to the pipe, say 7168 bytes. That leaves
    1024 bytes in the buffer. The reader reads nothing yet.

  - now we try to write another 4096 bytes. That's too big, so we get
    ENOSPC. But when we ask for the pipe size, it tells us 8192. So we
    _don't_ try to do a partial write of the remaining size, and return
    EAGAIN. But now we've made no forward progress (i.e., even though
    poll() said we could write, we don't, and we end up in the xwrite
    loop).

So we really do want to try to get a partial write. Even a single byte
means we are making forward progress.

> Alternatively we could retry with ever smaller sizes, down to one byte,
> to avoid EAGAIN as much as possible.  Sounds costly, though.

It's definitely not optimal, but it may not be too bad. If we cut the
size in half each time, then at worst we make log2(N) extra write
attempts, and we end up with a partial write within 50% of the optimal
size.

-Peff
