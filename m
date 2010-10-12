From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v7 1/3] Add bidirectional_transfer_loop()
Date: Tue, 12 Oct 2010 19:39:41 +0300
Message-ID: <1286901583-30088-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 18:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5hmr-0005qQ-MR
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 18:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401Ab0JLQdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 12:33:10 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:46738 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0JLQdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 12:33:04 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 026E5EBC3F
	for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:33:03 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A071E8EC27B; Tue, 12 Oct 2010 19:33:02 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id CA3BB158A69
	for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:33:01 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158861>

This helper function copies bidirectional stream of data between
stdin/stdout and specified file descriptors.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 compat/mingw.h     |    5 +
 transport-helper.c |  311 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.h        |    1 +
 3 files changed, 317 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 3b2477b..f27a7b6 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -23,6 +23,9 @@ typedef int pid_t;
 #define WEXITSTATUS(x) ((x) & 0xff)
 #define WTERMSIG(x) SIGTERM
 
+#define EWOULDBLOCK EAGAIN
+#define SHUT_WR SD_SEND
+
 #define SIGHUP 1
 #define SIGQUIT 3
 #define SIGKILL 9
@@ -50,6 +53,8 @@ struct pollfd {
 };
 #define POLLIN 1
 #define POLLHUP 2
+#define POLLOUT 4
+#define POLLNVAL 8
 #endif
 
 typedef void (__cdecl *sig_handler_t)(int);
diff --git a/transport-helper.c b/transport-helper.c
index acfc88e..0c094d6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -862,3 +862,314 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->smart_options = &(data->transport_options);
 	return 0;
 }
+
+/*
+ * Linux pipes can buffer 65536 bytes at once (and most platforms can
+ * buffer less), so attempt reads and writes with up to that size.
+ */
+#define BUFFERSIZE 65536
+/* This should be enough to hold debugging message. */
+#define PBUFFERSIZE 8192
+
+/* Print bidirectional transfer loop debug message. */
+static void transfer_debug(const char *fmt, ...)
+{
+	va_list args;
+	char msgbuf[PBUFFERSIZE];
+	static int debug_enabled = -1;
+
+	if (debug_enabled < 0)
+		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
+	if (!debug_enabled)
+		return;
+
+	va_start(args, fmt);
+	vsnprintf(msgbuf, PBUFFERSIZE, fmt, args);
+	va_end(args);
+	fprintf(stderr, "Transfer loop debugging: %s\n", msgbuf);
+}
+
+/* Stream state: More data may be coming in this direction. */
+#define SSTATE_TRANSFERING 0
+/*
+ * Stream state: No more data coming in this direction, flushing rest of
+ * data.
+ */
+#define SSTATE_FLUSHING 1
+/* Stream state: Transfer in this direction finished. */
+#define SSTATE_FINISHED 2
+
+#define STATE_NEEDS_READING(state) ((state) <= SSTATE_TRANSFERING)
+#define STATE_NEEDS_WRITING(state) ((state) <= SSTATE_FLUSHING)
+#define STATE_NEEDS_CLOSING(state) ((state) == SSTATE_FLUSHING)
+
+/* Unidirectional transfer. */
+struct unidirectional_transfer {
+	/* Source */
+	int src;
+	/* Destination */
+	int dest;
+	/* Is source socket? */
+	int src_is_sock;
+	/* Is destination socket? */
+	int dest_is_sock;
+	/* Transfer state (TRANSFERING/FLUSHING/FINISHED) */
+	int state;
+	/* Buffer. */
+	char buf[BUFFERSIZE];
+	/* Buffer used. */
+	size_t bufuse;
+	/* Name of source. */
+	const char *src_name;
+	/* Name of destination. */
+	const char *dest_name;
+};
+
+/* Closes the target (for writing) if transfer has finished. */
+static void udt_close_if_finished(struct unidirectional_transfer *t)
+{
+	if (STATE_NEEDS_CLOSING(t->state) && !t->bufuse) {
+		t->state = SSTATE_FINISHED;
+		if (t->dest_is_sock)
+			shutdown(t->dest, SHUT_WR);
+		else
+			close(t->dest);
+		transfer_debug("Closed %s.", t->dest_name);
+	}
+}
+
+/*
+ * Tries to read read data from source into buffer. If buffer is full,
+ * no data is read. Returns 0 on success, -1 on error.
+ */
+static int udt_do_read(struct unidirectional_transfer *t)
+{
+	ssize_t bytes;
+
+	if (t->bufuse == BUFFERSIZE)
+		return 0;	/* No space for more. */
+
+	transfer_debug("%s is readable", t->src_name);
+	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		errno != EINTR) {
+		error("read(%s) failed: %s", t->src_name, strerror(errno));
+		return -1;
+	} else if (bytes == 0) {
+		transfer_debug("%s EOF (with %i bytes in buffer)",
+			t->src_name, t->bufuse);
+		t->state = SSTATE_FLUSHING;
+	} else if (bytes > 0) {
+		t->bufuse += bytes;
+		transfer_debug("Read %i bytes from %s (buffer now at %i)",
+			(int)bytes, t->src_name, (int)t->bufuse);
+	}
+	return 0;
+}
+
+/* Tries to write data from buffer into destination. If buffer is empty,
+ * no data is written. Returns 0 on success, -1 on error.
+ */
+static int udt_do_write(struct unidirectional_transfer *t)
+{
+	size_t bytes;
+
+	if (t->bufuse == 0)
+		return 0;	/* Nothing to write. */
+
+	transfer_debug("%s is writable", t->dest_name);
+	bytes = write(t->dest, t->buf, t->bufuse);
+	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		errno != EINTR) {
+		error("write(%s) failed: %s", t->dest_name, strerror(errno));
+		return -1;
+	} else if (bytes > 0) {
+		t->bufuse -= bytes;
+		if (t->bufuse)
+			memmove(t->buf, t->buf + bytes, t->bufuse);
+		transfer_debug("Wrote %i bytes to %s (buffer now at %i)",
+			(int)bytes, t->dest_name, (int)t->bufuse);
+	}
+	return 0;
+}
+
+
+/* State of bidirectional transfer loop. */
+struct bidirectional_transfer_state {
+	/* Direction from program to git. */
+	struct unidirectional_transfer ptg;
+	/* Direction from git to program. */
+	struct unidirectional_transfer gtp;
+};
+
+static void *udt_copy_task_routine(void *udt)
+{
+	struct unidirectional_transfer *t = (struct unidirectional_transfer *)udt;
+	while (t->state != SSTATE_FINISHED) {
+		if (STATE_NEEDS_READING(t->state))
+			if (udt_do_read(t))
+				return NULL;
+		if (STATE_NEEDS_WRITING(t->state))
+			if (udt_do_write(t))
+				return NULL;
+		if (STATE_NEEDS_CLOSING(t->state))
+			udt_close_if_finished(t);
+	}
+	return udt;	/* Just some non-NULL value. */
+}
+
+#ifndef NO_PTHREADS
+
+/*
+ * Join thread, with apporiate errors on failure. Name is name for the
+ * thread (for error messages). Returns 0 on success, 1 on failure.
+ */
+static int tloop_join(pthread_t thread, const char *name)
+{
+	int err;
+	void *tret;
+	err = pthread_join(thread, &tret);
+	if (!tret) {
+		error("%s thread failed", name);
+		return 1;
+	}
+	if (err) {
+		error("%s thread failed to join: %s", name, strerror(err));
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Spawn the transfer tasks and then wait for them. Returns 0 on success,
+ * -1 on failure.
+ */
+static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
+{
+	pthread_t gtp_thread;
+	pthread_t ptg_thread;
+	int err;
+	int ret = 0;
+	err = pthread_create(&gtp_thread, NULL, udt_copy_task_routine,
+		&s->gtp);
+	if (err)
+		die("Can't start thread for copying data: %s", strerror(err));
+	err = pthread_create(&ptg_thread, NULL, udt_copy_task_routine,
+		&s->ptg);
+	if (err)
+		die("Can't start thread for copying data: %s", strerror(err));
+
+	ret |= tloop_join(gtp_thread, "Git to program copy");
+	ret |= tloop_join(ptg_thread, "Program to git copy");
+	return ret;
+}
+#else
+
+/* Close the source and target (for writing) for transfer. */
+static void udt_kill_transfer(struct unidirectional_transfer *t)
+{
+	t->state = SSTATE_FINISHED;
+	/*
+	 * Socket read end left open isn't a disaster if nobody
+	 * attempts to read from it (mingw compat headers do not
+	 * have SHUT_RD)...
+	 *
+	 * We can't fully close the socket since otherwise gtp
+	 * task would first close the socket it sends data to
+	 * while closing the ptg file descriptors.
+	 */
+	if (!t->src_is_sock)
+		close(t->src);
+	if (t->dest_is_sock)
+		shutdown(t->dest, SHUT_WR);
+	else
+		close(t->dest);
+}
+
+/*
+ * Join process, with apporiate errors on failure. Name is name for the
+ * process (for error messages). Returns 0 on success, 1 on failure.
+ */
+static int tloop_join(pid_t pid, const char *name)
+{
+	int tret;
+	if (waitpid(pid, &tret, 0) < 0) {
+		error("%s process failed to wait: %s", name, strerror(errno));
+		return 1;
+	}
+	if (!WIFEXITED(tret) || WEXITSTATUS(tret)) {
+		error("%s process failed", name);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Spawn the transfer tasks and then wait for them. Returns 0 on success,
+ * -1 on failure.
+ */
+static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
+{
+	pid_t pid1, pid2;
+	int ret = 0;
+
+	/* Fork thread #1: git to program. */
+	pid1 = fork();
+	if (pid1 < 0)
+		die_errno("Can't start thread for copying data");
+	else if (pid1 == 0) {
+		udt_kill_transfer(&s->ptg);
+		exit(udt_copy_task_routine(&s->gtp) ? 0 : 1);
+	}
+
+	/* Fork thread #2: program to git. */
+	pid2 = fork();
+	if (pid2 < 0)
+		die_errno("Can't start thread for copying data");
+	else if (pid2 == 0) {
+		udt_kill_transfer(&s->gtp);
+		exit(udt_copy_task_routine(&s->ptg) ? 0 : 1);
+	}
+
+	/*
+	 * Close both streams in parent as to not interfere with
+	 * end of file detection and wait for both tasks to finish.
+	 */
+	udt_kill_transfer(&s->gtp);
+	udt_kill_transfer(&s->ptg);
+	ret |= tloop_join(pid1, "Git to program copy");
+	ret |= tloop_join(pid2, "Program to git copy");
+	return ret;
+}
+#endif
+
+/*
+ * Copies data from stdin to output and from input to stdout simultaneously.
+ * Additionally filtering through given filter. If filter is NULL, uses
+ * identity filter.
+ */
+int bidirectional_transfer_loop(int input, int output)
+{
+	struct bidirectional_transfer_state state;
+
+	/* Fill the state fields. */
+	state.ptg.src = input;
+	state.ptg.dest = 1;
+	state.ptg.src_is_sock = (input == output);
+	state.ptg.dest_is_sock = 0;
+	state.ptg.state = SSTATE_TRANSFERING;
+	state.ptg.bufuse = 0;
+	state.ptg.src_name = "remote input";
+	state.ptg.dest_name = "stdout";
+
+	state.gtp.src = 0;
+	state.gtp.dest = output;
+	state.gtp.src_is_sock = 0;
+	state.gtp.dest_is_sock = (input == output);
+	state.gtp.state = SSTATE_TRANSFERING;
+	state.gtp.bufuse = 0;
+	state.gtp.src_name = "stdin";
+	state.gtp.dest_name = "remote output";
+
+	return tloop_spawnwait_tasks(&state);
+}
diff --git a/transport.h b/transport.h
index c59d973..e803c0e 100644
--- a/transport.h
+++ b/transport.h
@@ -154,6 +154,7 @@ int transport_connect(struct transport *transport, const char *name,
 
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
+int bidirectional_transfer_loop(int input, int output);
 
 /* common methods used by transport.c and builtin-send-pack.c */
 void transport_verify_remote_names(int nr_heads, const char **heads);
-- 
1.7.3.1.53.g597b29.dirty
