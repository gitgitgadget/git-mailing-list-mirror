Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F961FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbcFQXiu (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:38:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:56477 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753158AbcFQXit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:38:49 -0400
Received: (qmail 8222 invoked by uid 102); 17 Jun 2016 23:38:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:49 -0400
Received: (qmail 30310 invoked by uid 107); 17 Jun 2016 23:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:39:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:38:47 -0400
Date:	Fri, 17 Jun 2016 19:38:47 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/7] run-command: add pipe_command helper
Message-ID: <20160617233846.GD31958@sigill.intra.peff.net>
References: <20160617233819.GA31909@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160617233819.GA31909@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We already have capture_command(), which captures the stdout
of a command in a way that avoids deadlocks. But sometimes
we need to do more I/O, like capturing stderr as well, or
sending data to stdin. It's easy to write code that
deadlocks racily in these situations depending on how fast
the command reads its input, or in which order it writes its
output.

Let's give callers an easy interface for doing this the
right way, similar to what capture_command() did for the
simple case.

The whole thing is backed by a generic poll() loop that can
feed an arbitrary number of buffers to descriptors, and fill
an arbitrary number of strbufs from other descriptors. This
seems like overkill, but the resulting code is actually a
bit cleaner than just handling the three descriptors
(because the output code for stdout/stderr is effectively
duplicated, so being able to loop is a benefit).

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 run-command.h |  31 +++++++++---
 2 files changed, 171 insertions(+), 12 deletions(-)

diff --git a/run-command.c b/run-command.c
index af0c8a1..33bc63a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -864,19 +864,161 @@ int run_hook_le(const char *const *env, const char *name, ...)
 	return ret;
 }
 
-int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
+struct io_pump {
+	/* initialized by caller */
+	int fd;
+	int type; /* POLLOUT or POLLIN */
+	union {
+		struct {
+			const char *buf;
+			size_t len;
+		} out;
+		struct {
+			struct strbuf *buf;
+			size_t hint;
+		} in;
+	} u;
+
+	/* returned by pump_io */
+	int error; /* 0 for success, otherwise errno */
+
+	/* internal use */
+	struct pollfd *pfd;
+};
+
+static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
+{
+	int pollsize = 0;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		struct io_pump *io = &slots[i];
+		if (io->fd < 0)
+			continue;
+		pfd[pollsize].fd = io->fd;
+		pfd[pollsize].events = io->type;
+		io->pfd = &pfd[pollsize++];
+	}
+
+	if (!pollsize)
+		return 0;
+
+	if (poll(pfd, pollsize, -1) < 0) {
+		if (errno == EINTR)
+			return 1;
+		die_errno("poll failed");
+	}
+
+	for (i = 0; i < nr; i++) {
+		struct io_pump *io = &slots[i];
+
+		if (io->fd < 0)
+			continue;
+
+		if (!(io->pfd->revents & (POLLOUT|POLLIN|POLLHUP|POLLERR|POLLNVAL)))
+			continue;
+
+		if (io->type == POLLOUT) {
+			ssize_t len = xwrite(io->fd,
+					     io->u.out.buf, io->u.out.len);
+			if (len < 0) {
+				io->error = errno;
+				close(io->fd);
+				io->fd = -1;
+			} else {
+				io->u.out.buf += len;
+				io->u.out.len -= len;
+				if (!io->u.out.len) {
+					close(io->fd);
+					io->fd = -1;
+				}
+			}
+		}
+
+		if (io->type == POLLIN) {
+			ssize_t len = strbuf_read_once(io->u.in.buf,
+						       io->fd, io->u.in.hint);
+			if (len < 0)
+				io->error = errno;
+			if (len <= 0) {
+				close(io->fd);
+				io->fd = -1;
+			}
+		}
+	}
+
+	return 1;
+}
+
+static int pump_io(struct io_pump *slots, int nr)
+{
+	struct pollfd *pfd;
+	int i;
+
+	for (i = 0; i < nr; i++)
+		slots[i].error = 0;
+
+	ALLOC_ARRAY(pfd, nr);
+	while (pump_io_round(slots, nr, pfd))
+		; /* nothing */
+	free(pfd);
+
+	/* There may be multiple errno values, so just pick the first. */
+	for (i = 0; i < nr; i++) {
+		if (slots[i].error) {
+			errno = slots[i].error;
+			return -1;
+		}
+	}
+	return 0;
+}
+
+
+int pipe_command(struct child_process *cmd,
+		 const char *in, size_t in_len,
+		 struct strbuf *out, size_t out_hint,
+		 struct strbuf *err, size_t err_hint)
 {
-	cmd->out = -1;
+	struct io_pump io[3];
+	int nr = 0;
+
+	if (in)
+		cmd->in = -1;
+	if (out)
+		cmd->out = -1;
+	if (err)
+		cmd->err = -1;
+
 	if (start_command(cmd) < 0)
 		return -1;
 
-	if (strbuf_read(buf, cmd->out, hint) < 0) {
-		close(cmd->out);
+	if (in) {
+		io[nr].fd = cmd->in;
+		io[nr].type = POLLOUT;
+		io[nr].u.out.buf = in;
+		io[nr].u.out.len = in_len;
+		nr++;
+	}
+	if (out) {
+		io[nr].fd = cmd->out;
+		io[nr].type = POLLIN;
+		io[nr].u.in.buf = out;
+		io[nr].u.in.hint = out_hint;
+		nr++;
+	}
+	if (err) {
+		io[nr].fd = cmd->err;
+		io[nr].type = POLLIN;
+		io[nr].u.in.buf = err;
+		io[nr].u.in.hint = err_hint;
+		nr++;
+	}
+
+	if (pump_io(io, nr) < 0) {
 		finish_command(cmd); /* throw away exit code */
 		return -1;
 	}
 
-	close(cmd->out);
 	return finish_command(cmd);
 }
 
diff --git a/run-command.h b/run-command.h
index 11f76b0..5066649 100644
--- a/run-command.h
+++ b/run-command.h
@@ -79,17 +79,34 @@ int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 
 /**
- * Execute the given command, capturing its stdout in the given strbuf.
+ * Execute the given command, sending "in" to its stdin, and capturing its
+ * stdout and stderr in the "out" and "err" strbufs. Any of the three may
+ * be NULL to skip processing.
+ *
  * Returns -1 if starting the command fails or reading fails, and otherwise
- * returns the exit code of the command. The output collected in the
- * buffer is kept even if the command returns a non-zero exit. The hint field
- * gives a starting size for the strbuf allocation.
+ * returns the exit code of the command. Any output collected in the
+ * buffers is kept even if the command returns a non-zero exit. The hint fields
+ * gives starting sizes for the strbuf allocations.
  *
  * The fields of "cmd" should be set up as they would for a normal run_command
- * invocation. But note that there is no need to set cmd->out; the function
- * sets it up for the caller.
+ * invocation. But note that there is no need to set the in, out, or err
+ * fields; pipe_command handles that automatically.
+ */
+int pipe_command(struct child_process *cmd,
+		 const char *in, size_t in_len,
+		 struct strbuf *out, size_t out_hint,
+		 struct strbuf *err, size_t err_hint);
+
+/**
+ * Convenience wrapper around pipe_command for the common case
+ * of capturing only stdout.
  */
-int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint);
+static inline int capture_command(struct child_process *cmd,
+				  struct strbuf *out,
+				  size_t hint)
+{
+	return pipe_command(cmd, NULL, 0, out, hint, NULL, 0);
+}
 
 /*
  * The purpose of the following functions is to feed a pipe by running
-- 
2.9.0.165.g4aacdc3

