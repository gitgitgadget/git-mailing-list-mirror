Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB08EC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 04:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiHBENM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 00:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHBENK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 00:13:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE8D18B16
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 21:13:09 -0700 (PDT)
Received: (qmail 1813 invoked by uid 109); 2 Aug 2022 04:13:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Aug 2022 04:13:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28101 invoked by uid 111); 2 Aug 2022 04:13:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Aug 2022 00:13:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Aug 2022 00:13:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our pipe_command() helper lets you both write to and read from a child
process on its stdin/stdout. It's supposed to work without deadlocks
because we use poll() to check when descriptors are ready for reading or
writing. But there's a bug: if both the data to be written and the data
to be read back exceed the pipe buffer, we'll deadlock.

The issue is that the code assumes that if you have, say, a 2MB buffer
to write and poll() tells you that the pipe descriptor is ready for
writing, that calling:

  write(cmd->in, buf, 2*1024*1024);

will do a partial write, filling the pipe buffer and then returning what
it did write. And that is what it would do on a socket, but not for a
pipe. When writing to a pipe, at least on Linux, it will block waiting
for the child process to read() more. And now we have a potential
deadlock, because the child may be writing back to us, waiting for us to
read() ourselves.

An easy way to trigger this is:

  git -c add.interactive.useBuiltin=true \
      -c interactive.diffFilter=cat \
      checkout -p HEAD~200

The diff against HEAD~200 will be big, and the filter wants to write all
of it back to us (obviously this is a dummy filter, but in the real
world something like diff-highlight would similarly stream back a big
output).

If you set add.interactive.useBuiltin to false, the problem goes away,
because now we're not using pipe_command() anymore (instead, that part
happens in perl). But this isn't a bug in the interactive code at all.
It's the underlying pipe_command() code which is broken, and has been
all along.

We presumably didn't notice because most calls only do input _or_
output, not both. And the few that do both, like gpg calls, may have
large inputs or outputs, but never both at the same time (e.g., consider
signing, which has a large payload but a small signature comes back).

The obvious fix is to put the descriptor into non-blocking mode, and
indeed, that makes the problem go away. Callers shouldn't need to
care, because they never see the descriptor (they hand us a buffer to
feed into it).

Signed-off-by: Jeff King <peff@peff.net>
---
+cc Dscho for two reasons:

  - this is a fallout of the builtin add-interactive, though I again
    emphasize that it's just triggering a lurking bug (which is mine, no
    less!). But I thought you'd want to know.

  - more importantly, I'm not sure of the portability implications of
    the fix. This is our first use of O_NONBLOCK outside of the
    compat/simple-ipc unix-socket code. Do we need to abstract this
    behind a compat/ layer for Windows?

 run-command.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/run-command.c b/run-command.c
index 14f17830f5..45bffb4b11 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1418,6 +1418,14 @@ static int pump_io(struct io_pump *slots, int nr)
 	return 0;
 }
 
+static int make_nonblock(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+	if (flags < 0)
+		return -1;
+	flags |= O_NONBLOCK;
+	return fcntl(fd, F_SETFL, flags);
+}
 
 int pipe_command(struct child_process *cmd,
 		 const char *in, size_t in_len,
@@ -1438,6 +1446,15 @@ int pipe_command(struct child_process *cmd,
 		return -1;
 
 	if (in) {
+		if (make_nonblock(cmd->in) < 0) {
+			error_errno("unable to make pipe non-blocking");
+			close(cmd->in);
+			if (out)
+				close(cmd->out);
+			if (err)
+				close(cmd->err);
+			return -1;
+		}
 		io[nr].fd = cmd->in;
 		io[nr].type = POLLOUT;
 		io[nr].u.out.buf = in;
-- 
2.37.1.804.g1775fa20e0

