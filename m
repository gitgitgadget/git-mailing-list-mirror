From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] strbuf: introduce strbuf_read_cmd helper
Date: Sun, 22 Mar 2015 06:07:25 -0400
Message-ID: <20150322100724.GC11615@peff.net>
References: <20150322095924.GA24651@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 11:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZcnA-0003UB-0u
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 11:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbCVKHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 06:07:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:36706 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751693AbbCVKH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 06:07:27 -0400
Received: (qmail 32569 invoked by uid 102); 22 Mar 2015 10:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 05:07:27 -0500
Received: (qmail 6983 invoked by uid 107); 22 Mar 2015 10:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 06:07:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 06:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20150322095924.GA24651@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266061>

Something as simple as reading the stdout from a command
turns out to be rather hard to do right. Doing:

  if (!run_command(&cmd))
        strbuf_read(&buf, cmd.out, 0);

can result in deadlock if the child process produces a large
amount of output. What happens is:

  1. The parent spawns the child with its stdout connected
     to a pipe, of which the parent is the sole reader.

  2. The parent calls wait(), blocking until the child exits.

  3. The child writes to stdout. If it writes more data than
     the OS pipe buffer can hold, the write() call will
     block.

This is a deadlock; the parent is waiting for the child to
exit, and the child is waiting for the parent to call
read().

So we should do instead:

  if (!start_command(&cmd)) {
        strbuf_read(&buf, cmd.out, 0);
        finish_command(&cmd);
  }

But note that this leaks cmd.out (which must be closed). And
there's no error handling for strbuf_read. We probably want
to know whether the operation succeeded, but we must make
sure to always run finish_command even if the read failed
(or else we leave a zombie child process).

Let's introduce a strbuf helper that can make this a bit
simpler for callers to do right.

Signed-off-by: Jeff King <peff@peff.net>
---
This is really at the intersection of the strbuf and
run-command APIs, so you could argue for it being part of
either It is logically quite like the strbuf_read_file()
function, so I put it there.

 strbuf.c | 17 +++++++++++++++++
 strbuf.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 88cafd4..9d1d48f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "utf8.h"
+#include "run-command.h"
 
 int starts_with(const char *str, const char *prefix)
 {
@@ -414,6 +415,22 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 	return -1;
 }
 
+int strbuf_read_cmd(struct strbuf *sb, struct child_process *cmd, size_t hint)
+{
+	cmd->out = -1;
+	if (start_command(cmd) < 0)
+		return -1;
+
+	if (strbuf_read(sb, cmd->out, hint) < 0) {
+		close(cmd->out);
+		finish_command(cmd); /* throw away exit code */
+		return -1;
+	}
+
+	close(cmd->out);
+	return finish_command(cmd);
+}
+
 int strbuf_getcwd(struct strbuf *sb)
 {
 	size_t oldalloc = sb->alloc;
diff --git a/strbuf.h b/strbuf.h
index 1883494..93a50da 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+struct child_process;
+
 /**
  * strbuf's are meant to be used with all the usual C string and memory
  * APIs. Given that the length of the buffer is known, it's often better to
@@ -373,6 +375,14 @@ extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
+ * Execute the given command, capturing its stdout in the given strbuf.
+ * Returns -1 if starting the command fails or reading fails, and otherwise
+ * returns the exit code of the command. The output collected in the
+ * buffer is kept even if the command returns a non-zero exit.
+ */
+int strbuf_read_cmd(struct strbuf *sb, struct child_process *cmd, size_t hint);
+
+/**
  * Read a line from a FILE *, overwriting the existing contents
  * of the strbuf. The second argument specifies the line
  * terminator character, typically `'\n'`.
-- 
2.3.3.618.ga041503
