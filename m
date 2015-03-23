From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/7] run-command: introduce capture_command helper
Date: Sun, 22 Mar 2015 23:53:43 -0400
Message-ID: <20150323035343.GC30337@peff.net>
References: <20150323035302.GA30279@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:53:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZtR0-0004uD-74
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 04:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbCWDxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 23:53:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:37016 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751985AbbCWDxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 23:53:45 -0400
Received: (qmail 14585 invoked by uid 102); 23 Mar 2015 03:53:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 22:53:45 -0500
Received: (qmail 12221 invoked by uid 107); 23 Mar 2015 03:53:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 23:53:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 23:53:43 -0400
Content-Disposition: inline
In-Reply-To: <20150323035302.GA30279@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266118>

Something as simple as reading the stdout from a command
turns out to be rather hard to do right. Doing:

  cmd.out = -1;
  run_command(&cmd);
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

So we might try instead:

  start_command(&cmd);
  strbuf_read(&buf, cmd.out, 0);
  finish_command(&cmd);

But that is not quite right either. We are examining cmd.out
and running finish_command whether start_command succeeded
or not, which is wrong. Moreover, these snippets do not do
any error handling. If our read() fails, we must make sure
to still call finish_command (to reap the child process).
And both snippets failed to close the cmd.out descriptor,
which they must do (provided start_command succeeded).

Let's introduce a run-command helper that can make this a
bit simpler for callers to get right.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 16 ++++++++++++++++
 run-command.h | 13 +++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/run-command.c b/run-command.c
index 3afb124..e591d2c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -829,3 +829,19 @@ int run_hook_le(const char *const *env, const char *name, ...)
 
 	return ret;
 }
+
+int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
+{
+	cmd->out = -1;
+	if (start_command(cmd) < 0)
+		return -1;
+
+	if (strbuf_read(buf, cmd->out, hint) < 0) {
+		close(cmd->out);
+		finish_command(cmd); /* throw away exit code */
+		return -1;
+	}
+
+	close(cmd->out);
+	return finish_command(cmd);
+}
diff --git a/run-command.h b/run-command.h
index d6868dc..263b966 100644
--- a/run-command.h
+++ b/run-command.h
@@ -71,6 +71,19 @@ int run_command_v_opt(const char **argv, int opt);
  */
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 
+/**
+ * Execute the given command, capturing its stdout in the given strbuf.
+ * Returns -1 if starting the command fails or reading fails, and otherwise
+ * returns the exit code of the command. The output collected in the
+ * buffer is kept even if the command returns a non-zero exit. The hint field
+ * gives a starting size for the strbuf allocation.
+ *
+ * The fields of "cmd" should be set up as they would for a normal run_command
+ * invocation. But note that there is no need to set cmd->out; the function
+ * sets it up for the caller.
+ */
+int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint);
+
 /*
  * The purpose of the following functions is to feed a pipe by running
  * a function asynchronously and providing output that the caller reads.
-- 
2.3.3.618.ga041503
