Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE832C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 03:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiHCDxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 23:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHCDxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 23:53:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B27F1E3F7
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 20:53:02 -0700 (PDT)
Received: (qmail 6518 invoked by uid 109); 3 Aug 2022 03:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Aug 2022 03:53:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8583 invoked by uid 111); 3 Aug 2022 03:53:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Aug 2022 23:53:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Aug 2022 23:53:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
 <YulFTSTbVaTwuQtt@coredump.intra.peff.net>
 <xmqq5yjahb8u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yjahb8u.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 02, 2022 at 09:16:17AM -0700, Junio C Hamano wrote:

> > But I'm not sure what should go on the Windows side of that #ifdef.
> > Unlike some other spots, I don't think we can just make it a noop, or
> > Windows will be subject to the same deadlock (unless for some reason its
> > write() does behave differently?).
> 
> Let them deadlock so that they can fix it, and until then leave it a
> noop?  That may break the CI tests for them so we could hide the
> known-to-be-broken test behind prerequisite to buy them time,
> perhaps?

I was skeptical of including a test, but I was able to come up with a
reproduction that triggers for me on Linux, but isn't too expensive to
keep around.

Much to my surprise (and delight), it passes on the Windows CI with the
noop! So I guess their pipes behave in the way we want by default.

It does feel like a bit of a landmine to have an enable_nonblock()
function which might do nothing. I'm not sure if other descriptor types
might behave differently on Windows. But hopefully the comment above the
function is sufficient to make people think twice.

-- >8 --
Subject: [PATCH] pipe_command(): mark stdin descriptor as non-blocking

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

Unfortunately O_NONBLOCK isn't available everywhere, especially on
Windows. However, the included test seems to work fine there, which
implies that pipes there do not behave in the same way (they will do the
partial write by default, which is what we want). This is true even if I
size up the diff for a larger pipe buffer (the value chosen here
triggers the deadlock on Linux, but isn't too expensive to keep as a
regression test).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                   |  1 +
 compat/nonblock.c          | 22 ++++++++++++++++++++++
 compat/nonblock.h          | 10 ++++++++++
 run-command.c              | 10 ++++++++++
 t/t3701-add-interactive.sh | 14 ++++++++++++++
 5 files changed, 57 insertions(+)
 create mode 100644 compat/nonblock.c
 create mode 100644 compat/nonblock.h

diff --git a/Makefile b/Makefile
index 1624471bad..78bedf26e0 100644
--- a/Makefile
+++ b/Makefile
@@ -918,6 +918,7 @@ LIB_OBJS += combine-diff.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += commit.o
+LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compat/zlib-uncompress2.o
diff --git a/compat/nonblock.c b/compat/nonblock.c
new file mode 100644
index 0000000000..897c099010
--- /dev/null
+++ b/compat/nonblock.c
@@ -0,0 +1,22 @@
+#include "git-compat-util.h"
+#include "nonblock.h"
+
+#ifdef O_NONBLOCK
+
+int enable_nonblock(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+	if (flags < 0)
+		return -1;
+	flags |= O_NONBLOCK;
+	return fcntl(fd, F_SETFL, flags);
+}
+
+#else
+
+int enable_nonblock(int fd)
+{
+	return 0;
+}
+
+#endif
diff --git a/compat/nonblock.h b/compat/nonblock.h
new file mode 100644
index 0000000000..2721f72187
--- /dev/null
+++ b/compat/nonblock.h
@@ -0,0 +1,10 @@
+#ifndef COMPAT_NONBLOCK_H
+#define COMPAT_NONBLOCK_H
+
+/*
+ * Enable non-blocking I/O for the passed-in descriptor. Note that this is a
+ * noop on systems without O_NONBLOCK, like Windows! Use with caution.
+ */
+int enable_nonblock(int fd);
+
+#endif
diff --git a/run-command.c b/run-command.c
index 14f17830f5..ed99503b22 100644
--- a/run-command.c
+++ b/run-command.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "packfile.h"
 #include "hook.h"
+#include "compat/nonblock.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1438,6 +1439,15 @@ int pipe_command(struct child_process *cmd,
 		return -1;
 
 	if (in) {
+		if (enable_nonblock(cmd->in) < 0) {
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
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b354fb39de..01d6ce9c83 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -766,6 +766,20 @@ test_expect_success 'detect bogus diffFilter output' '
 	force_color test_must_fail git add -p <y
 '
 
+test_expect_success 'handle very large filtered diff' '
+	git reset --hard &&
+	# The specific number here is not important, but it must
+	# be large enough that the output of "git diff --color"
+	# fills up the pipe buffer. 10,000 results in ~200k of
+	# colored output.
+	test_seq 10000 >test &&
+	false &&
+	test_config interactive.diffFilter cat &&
+	printf y >y &&
+	force_color git add -p >output 2>&1 <y &&
+	git diff-files --exit-code -- test
+'
+
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
 	git reset --hard &&
 
-- 
2.37.1.810.g8c5f98b46b


