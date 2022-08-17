Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE8C32772
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiHQGIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiHQGIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:08:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D1B1E5
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:08:08 -0700 (PDT)
Received: (qmail 6625 invoked by uid 109); 17 Aug 2022 06:08:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:08:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13721 invoked by uid 111); 17 Aug 2022 06:08:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:08:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:08:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 4/6] pipe_command(): avoid xwrite() for writing to pipe
Message-ID: <YvyFxry9+2x05Di3@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If xwrite() sees an EAGAIN response, it will loop forever until the
write succeeds (or encounters a real error). This is due to ef1cf0167a
(xwrite: poll on non-blocking FDs, 2016-06-26), with the idea that we
won't be surprised by a descriptor unexpectedly set as non-blocking.

But that will make things awkward when we do want a non-blocking
descriptor, and a future patch will switch pipe_command() to using one.
In that case, looping on EAGAIN is bad, because the process on the other
end of the pipe may be waiting on us before doing another read() on the
pipe, which would mean we deadlock.

In practice we're not supposed to ever see EAGAIN here, since poll()
will have just told us the descriptor is ready for writing. But our
Windows emulation of poll() will always return "ready" for writing to a
pipe descriptor! This is due to 94f4d01932 (mingw: workaround for hangs
when sending STDIN, 2020-02-17).

Our best bet in that case is to keep handling other descriptors, as any
read() we do may allow the child command to make forward progress (i.e.,
its write() finishes, and then it read()s from its stdin, freeing up
space in the pipe buffer). This means we might busy-loop between poll()
and write() on Windows if the child command is slow to read our input,
but it's much better than the alternative of deadlocking.

In practice, this busy-looping should be rare:

  - for small inputs, we'll just write the whole thing in a single
    write() anyway, non-blocking or not

  - for larger inputs where the child reads input and then processes it
    before writing (e.g., gpg verifying a signature), we may make a few
    extra write() calls that get EAGAIN during the initial write, but
    once it has taken in the whole input, we'll correctly block waiting
    to read back the data.

  - for larger inputs where the child process is streaming output back
    (like a diff filter), we'll likewise see some extra EAGAINs, but
    most of them will be followed immediately by a read(), which will
    let the child command make forward progress.

Of course it won't happen at all for now, since we don't yet use a
non-blocking pipe. This is just preparation for when we do.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index 14f17830f5..e078c3046f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1364,12 +1364,24 @@ static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 			continue;
 
 		if (io->type == POLLOUT) {
-			ssize_t len = xwrite(io->fd,
-					     io->u.out.buf, io->u.out.len);
+			ssize_t len;
+
+			/*
+			 * Don't use xwrite() here. It loops forever on EAGAIN,
+			 * and we're in our own poll() loop here.
+			 *
+			 * Note that we lose xwrite()'s handling of MAX_IO_SIZE
+			 * and EINTR, so we have to implement those ourselves.
+			 */
+			len = write(io->fd, io->u.out.buf,
+				    io->u.out.len <= MAX_IO_SIZE ?
+				    io->u.out.len : MAX_IO_SIZE);
 			if (len < 0) {
-				io->error = errno;
-				close(io->fd);
-				io->fd = -1;
+				if (errno != EINTR && errno != EAGAIN) {
+					io->error = errno;
+					close(io->fd);
+					io->fd = -1;
+				}
 			} else {
 				io->u.out.buf += len;
 				io->u.out.len -= len;
-- 
2.37.2.881.gb57357660c

