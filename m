Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2843AC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 19:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiHJTxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiHJTxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 15:53:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA58C00E
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 12:53:22 -0700 (PDT)
Received: (qmail 6726 invoked by uid 109); 10 Aug 2022 19:53:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 19:53:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15162 invoked by uid 111); 10 Aug 2022 19:53:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 15:53:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 15:53:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YvQMsMv3EhiI/rTb@coredump.intra.peff.net>
References: <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <0e1b8066-3f67-cec6-675a-05d2cf54c119@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e1b8066-3f67-cec6-675a-05d2cf54c119@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 07:39:34AM +0200, René Scharfe wrote:

> > So it's weird that you'd see EAGAIN in this instance. Either the
> > underlying write() is refusing to do a partial write (and just returning
> > an error with EAGAIN in the first place), or the poll emulation is wrong
> > (telling us the descriptor is ready for writing when it isn't).
> 
> You're right, Windows' write needs two corrections.  The helper below
> reports what happens when we feed a pipe with writes of different sizes.
> On Debian on WSL 2 (Windows Subsystem for Linux) it says:
> [...]

Thanks for digging into this further. What you found makes sense to me
and explains what we're seeing.

> The two corrections mentioned above together with the enable_nonblock()
> implementation for Windows (and the removal of "false") suffice to let
> t3701 pass when started directly, but it still hangs when running the
> whole test suite using prove.

Interesting. I wish there was an easy way for me to poke at this, too. I
tried installing the Git for Windows SDK under wine, but unsurprisingly
it did not get very far.

Possibly I could try connecting to a running CI instance, but the test
did not seem to fail there! (Plus I'd have to figure out how to do
that... ;) ).

> I don't have time to investigate right now, but I still don't
> understand how xwrite() can possibly work against a non-blocking pipe.
> It loops on EAGAIN, which is bad if the only way forward is to read
> from a different fd to allow the other process to drain the pipe
> buffer so that xwrite() can write again.  I suspect pump_io_round()
> must not use xwrite() and should instead handle EAGAIN by skipping to
> the next fd.

Right, it's susceptible to looping forever in such a case. _But_ a
blocking write is likewise susceptible to blocking forever. In either
case, we're relying on the reading side to pull some bytes out of the
pipe so we can make forward progress.

The key thing is that pump_io() is careful never to initiate a write()
unless poll() has just told us that the descriptor is ready for writing.

If something unexpected happens there (i.e., the descriptor is not
really ready), a blocking descriptor is going to be stuck. And with
xwrite(), we're similarly stuck (just looping instead of blocking).
Without xwrite(), a non-blocking one _could_ be better off, because that
EAGAIN would make it up to pump_io(). But what is it supposed to do? I
guess it could go back into its main loop and hope that whatever bug
caused the mismatch between poll() and write() goes away.

But even that would not have fixed the problem here on Windows. From my
understanding, mingw_write() in this case would never write _any_ bytes.
So we'd never make forward progress, and just loop writing 0 bytes and
returning EAGAIN over and over.

So I dunno. We could try to be a bit more defensive about non-blocking
descriptors by avoiding xwrite() in this instance, but it only helps for
a particular class of weird OS behavior/bugs. I'd prefer to see a real
case that it would help before moving in that direction.

-Peff
