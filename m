Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC90C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 17:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiHGRlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 13:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRlG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 13:41:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF56418
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 10:41:03 -0700 (PDT)
Received: (qmail 21373 invoked by uid 109); 7 Aug 2022 17:41:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Aug 2022 17:41:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18031 invoked by uid 111); 7 Aug 2022 17:41:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 07 Aug 2022 13:41:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 7 Aug 2022 13:41:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
 <YulFTSTbVaTwuQtt@coredump.intra.peff.net>
 <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 07, 2022 at 12:15:06PM +0200, René Scharfe wrote:

> > This adds "error: pumping io failed: No space left on device" to output.
> > Which kinda makes sense: With the pipe no longer blocking, there can be
> > a moment when the buffer is full and writes have to be rejected.  This
> > condition should be reported with EAGAIN, though.
> >
> > Adding "if (len < 0 && errno == ENOSPC) continue;" after the xwrite()
> > call in pump_io_round() lets the test pass.
> >
> > Perhaps the translation from Windows error code to POSIX is wrong here?
> 
> So if we fix that with the patch below, t3701.57 still hangs, but this
> time it goes through wrapper.c::handle_nonblock() again and again.
> Replacing the "errno = EAGAIN" with a "return 0" to fake report a
> successful write of nothing instead lets the test pass.
> 
> This seems to make sense -- looping in xwrite() won't help, as we need
> to read from the other fd first, to allow the process on the other end
> of the pipe to make some progress first, as otherwise the pipe buffer
> will stay full in this scenario.  Shouldn't that be a problem on other
> systems as well?

It doesn't happen on Linux; I suspect there's something funny either
about partial writes, or about poll() on Windows. What's supposed to
happen is:

  1. pump_io() calls poll(), which tells us the descriptor is ready to
     write

  2. we call xwrite(), and our actual write() call returns a partial
     write (i.e., reports "ret" bytes < "len" we passed in)

  3. we return back to pump_io() do another round of poll(). If the
     other side consumed some bytes from the pipe, then we may get
     triggered to do another (possibly partial) write. If it didn't, and
     we'd get EAGAIN writing, then poll shouldn't trigger at all!

So it's weird that you'd see EAGAIN in this instance. Either the
underlying write() is refusing to do a partial write (and just returning
an error with EAGAIN in the first place), or the poll emulation is wrong
(telling us the descriptor is ready for writing when it isn't).

Can you instrument pump_io_round() (or use some strace equivalent, if
there is one) to see if we do a successful partial write first (which
implies poll() is wrong in telling us we can write more for the second
round), or if the very first write() is failing (which implies write()
is wrong for returning EAGAIN when it could do a partial write).

-Peff
