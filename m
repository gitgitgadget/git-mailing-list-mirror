Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4343AC25B06
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 18:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiHKSU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 14:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHKSUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 14:20:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921323B9
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 11:20:20 -0700 (PDT)
Received: (qmail 10271 invoked by uid 109); 11 Aug 2022 18:20:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Aug 2022 18:20:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24550 invoked by uid 111); 11 Aug 2022 18:20:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Aug 2022 14:20:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Aug 2022 14:20:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
Message-ID: <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
References: <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
 <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 07:35:33PM +0200, René Scharfe wrote:

> OK, but we can't just split anything up as we like: POSIX wants us to
> keep writes up to PIPE_BUF atomic.  When I read that name I mistakenly
> thought it was the size of the pipe buffer, but it's a different value.
> The minimum value according to POSIX is 512 bytes; on Linux it's 4KB.
> 
> And Windows doesn't seem to define it.  Bash's ulimit -p returns 8,
> which is in units of 512 bytes, so it's 4KB like on Linux.  But that's
> apparently not respected by Windows' write.
> 
> I just realized that we can interprete the situation slightly
> differently.  Windows has effectively PIPE_BUF = 2^32, which means all
> writes are atomic.  I don't see POSIX specifying a maximum allowed
> value, so this must be allowed.  Which means you cannot rely on write
> performing partial writes.  Makes sense?

Hmm, I'm not sure. POSIX does allow writing a single byte if that's all
the space there is, but only if the original _request_ was for more than
PIPE_BUF. Which I guess matches what you're saying.

If the original request is smaller than PIPE_BUF, it does seem to say
that EAGAIN is the correct output. But it also says:

  There is no exception regarding partial writes when O_NONBLOCK is set.
  With the exception of writing to an empty pipe, this volume of
  POSIX.1-2017 does not specify exactly when a partial write is
  performed since that would require specifying internal details of the
  implementation. Every application should be prepared to handle partial
  writes when O_NONBLOCK is set and the requested amount is greater than
  {PIPE_BUF}, just as every application should be prepared to handle
  partial writes on other kinds of file descriptors.

  The intent of forcing writing at least one byte if any can be written
  is to assure that each write makes progress if there is any room in
  the pipe. If the pipe is empty, {PIPE_BUF} bytes must be written; if
  not, at least some progress must have been made.

So they are clearly aware of the "we need to make forward progress"
problem. But how are you supposed to do that if you only have less than
PIPE_BUF bytes left to write? And likewise, even if it is technically
legal, having a PIPE_BUF of 2^32 seems like a quality-of-implementation
issue.

And that doesn't really match what poll() is saying. The response from
poll() told us we could write without blocking, which implies at least
PIPE_BUF bytes available. But clearly it isn't available, since the
write fails (with EAGAIN, but that is equivalent to blocking in POSIX's
view here).

Lawyering aside, I think it would be OK to move forward with cutting up
writes at least to a size of 512 bytes. Git runs on lots of platforms,
and none of the code can make an assumption that PIPE_BUF is larger than
that. I.e., we are reducing atomicity provided by Windows, but that's
OK.

I don't think that solves our problem fully, though. We might need to
write 5 bytes, and telling mingw_write() to do so means it's supposed to
abide by PIPE_BUF conventions. But again, we are in control of the
calling code here. I don't think there's any reason that we care about
PIPE_BUF atomicity. Certainly we don't get those atomicity guarantees on
the socket side, which is where much of our writing happens, and our
code is prepared to handle partial writes of any size. So we could just
ignore that guarantee here.

> If we accept that, then we need a special write function for
> non-blocking pipes that chops the data into small enough chunks.

I'm not sure what "small enough" we can rely on, though. Really it is
the interplay between poll() and write() that we care about here. We
would like to know at what point poll() will tell us it's OK to write().
But we don't know what the OS thinks of that.

Or maybe we do, since I think poll() is our own compat layer. But it
just seems to be based on select(). We do seem to use PeekNamedPipe()
there to look on the reading side, but I don't know if there's an
equivalent for writing.

> Another oddity: t3701 with yesterday's patch finishes fine with -i, but
> hangs without it (not just when running it via prove).  O_o

Yes, definitely strange. I'd expect weirdness with "-v", for example,
because of terminal stuff, but "-i" should have no impact on the running
environment.

-Peff
