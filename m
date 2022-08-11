Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF61C19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 08:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiHKIwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiHKIwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 04:52:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F0D915F8
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:52:35 -0700 (PDT)
Received: (qmail 8642 invoked by uid 109); 11 Aug 2022 08:52:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Aug 2022 08:52:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19955 invoked by uid 111); 11 Aug 2022 08:52:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Aug 2022 04:52:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Aug 2022 04:52:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YvTDUWjmJKK/6c1s@coredump.intra.peff.net>
References: <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <0e1b8066-3f67-cec6-675a-05d2cf54c119@web.de>
 <YvQMsMv3EhiI/rTb@coredump.intra.peff.net>
 <dee6cce5-6f95-ecbe-1dd3-dd54f9746c67@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dee6cce5-6f95-ecbe-1dd3-dd54f9746c67@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 12:35:02AM +0200, René Scharfe wrote:

> > The key thing is that pump_io() is careful never to initiate a write()
> > unless poll() has just told us that the descriptor is ready for writing.
> 
> Right, and Windows breaks it by refusing to write data bigger than the
> buffer even if it's empty.
> 
> What does "ready for writing" mean?  PIPE_BUF bytes are free, right?

According to POSIX, it is "a write() will not block". ;)

I think in practice for Unix systems it means that at least 1 byte is
available.

> > If something unexpected happens there (i.e., the descriptor is not
> > really ready), a blocking descriptor is going to be stuck. And with
> > xwrite(), we're similarly stuck (just looping instead of blocking).
> > Without xwrite(), a non-blocking one _could_ be better off, because that
> > EAGAIN would make it up to pump_io(). But what is it supposed to do? I
> > guess it could go back into its main loop and hope that whatever bug
> > caused the mismatch between poll() and write() goes away.
> 
> It should check other fds to let the other side make some progress on
> them, so that it eventually gets to drain the pipe we want to write to.

Yes, that "go back into its main loop" would do that. But that's not
guaranteed to produce progress any time soon. We may just busy-loop
between poll() and write() returning EAGAIN if another descriptor isn't
ready. And if the thing preventing further writes is something the
process on the other side of the pipe can't fix (and thus we in turn
can't help it fix things by doing a read()), then we'll loop forever.
Which (if I understand it) is exactly the case here because the
underlying code refused to do a partial write.

-Peff
