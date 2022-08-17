Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A674C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiHQGKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbiHQGKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:10:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F19329CB4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:10:23 -0700 (PDT)
Received: (qmail 6659 invoked by uid 109); 17 Aug 2022 06:10:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:10:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13764 invoked by uid 111); 17 Aug 2022 06:10:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:10:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:10:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 6/6] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YvyGTmlVZlXwV4kF@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
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

The included test fails reliably on Linux without this patch. Curiously,
it doesn't fail in our Windows CI environment, but has been reported to
do so for individual developers. It should pass in any environment after
this patch (courtesy of the compat/ layers added in the last few
commits).

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before, minus the compat/ bits which were already done, and we
can now claim victory on Windows, too.

 run-command.c              | 10 ++++++++++
 t/t3701-add-interactive.sh | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/run-command.c b/run-command.c
index 5fbaa8b5ac..5ec3a46dcc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "packfile.h"
 #include "hook.h"
+#include "compat/nonblock.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1451,6 +1452,15 @@ int pipe_command(struct child_process *cmd,
 		return -1;
 
 	if (in) {
+		if (enable_pipe_nonblock(cmd->in) < 0) {
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
index b354fb39de..3b7df9bed5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -766,6 +766,19 @@ test_expect_success 'detect bogus diffFilter output' '
 	force_color test_must_fail git add -p <y
 '
 
+test_expect_success 'handle very large filtered diff' '
+	git reset --hard &&
+	# The specific number here is not important, but it must
+	# be large enough that the output of "git diff --color"
+	# fills up the pipe buffer. 10,000 results in ~200k of
+	# colored output.
+	test_seq 10000 >test &&
+	test_config interactive.diffFilter cat &&
+	printf y >y &&
+	force_color git add -p >output 2>&1 <y &&
+	git diff-files --exit-code -- test
+'
+
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
 	git reset --hard &&
 
-- 
2.37.2.881.gb57357660c
