From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v5 1/3] Add bidirectional_transfer_loop()
Date: Fri,  8 Oct 2010 21:39:58 +0300
Message-ID: <1286563200-7270-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 20:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4HlY-0002mx-2p
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 20:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab0JHSdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 14:33:51 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:37944 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0JHSdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 14:33:50 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id E8B30C7F74
	for <git@vger.kernel.org>; Fri,  8 Oct 2010 21:33:48 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A04008E5224; Fri, 08 Oct 2010 21:33:48 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id C2296E51A8
	for <git@vger.kernel.org>; Fri,  8 Oct 2010 21:33:47 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158522>

This helper function copies bidirectional stream of data between
stdin/stdout and specified file descriptors.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 compat/mingw.h     |    5 +
 transport-helper.c |  261 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.h        |    1 +
 3 files changed, 267 insertions(+), 0 deletions(-)

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
index acfc88e..a5732eb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -862,3 +862,264 @@ int transport_helper_init(struct transport *transport, const char *name)
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
+static int udt_do_read(struct unidirectional_transfer *t)
+{
+	int r;
+	transfer_debug("%s is readable", t->src_name);
+	r = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+	if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		errno != EINTR) {
+		error("read(%s) failed: %s", t->src_name, strerror(errno));
+		return -1;
+	} else if (r == 0) {
+		transfer_debug("%s EOF (with %i bytes in buffer)",
+			t->src_name, t->bufuse);
+		t->state = SSTATE_FLUSHING;
+	} else if (r > 0) {
+		t->bufuse += r;
+		transfer_debug("Read %i bytes from %s (buffer now at %i)",
+			r, t->src_name, (int)t->bufuse);
+	}
+	return 0;
+}
+
+static int udt_do_write(struct unidirectional_transfer *t)
+{
+	int r;
+	transfer_debug("%s is writable", t->dest_name);
+	r = write(t->dest, t->buf, t->bufuse);
+	if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		errno != EINTR) {
+		error("write(%s) failed: %s", t->dest_name, strerror(errno));
+		return -1;
+	} else if (r > 0) {
+		t->bufuse -= r;
+		if (t->bufuse)
+			memmove(t->buf, t->buf + r, t->bufuse);
+		transfer_debug("Wrote %i bytes to %s (buffer now at %i)",
+			r, t->dest_name, (int)t->bufuse);
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
+static void *udt_copy_thread_routine(void *udt)
+{
+	struct unidirectional_transfer *t = (struct unidirectional_transfer *)udt;
+	while(t->state != SSTATE_FINISHED) {
+		if (STATE_NEEDS_READING(t->state))
+			if (udt_do_read(t))
+				return NULL;
+		if (STATE_NEEDS_WRITING(t->state) && t->bufuse)
+			if (udt_do_write(t))
+				return NULL;
+		if (STATE_NEEDS_CLOSING(t->state))
+			udt_close_if_finished(t);
+	}
+	return udt;
+}
+
+#ifndef NO_PTHREADS
+static int transloop_with_threads(struct bidirectional_transfer_state *s)
+{
+	pthread_t gtp_thread;
+	pthread_t ptg_thread;
+	int err;
+	int ret = 0;
+	void *dummy;
+	err = pthread_create(&gtp_thread, NULL, udt_copy_thread_routine,
+		&s->gtp);
+	if (err)
+		die("Can't start thread for copying data: %s", strerror(err));
+	err = pthread_create(&ptg_thread, NULL, udt_copy_thread_routine,
+		&s->ptg);
+	if (err)
+		die("Can't start thread for copying data: %s", strerror(err));
+	err = pthread_join(gtp_thread, &dummy);
+	if (!dummy) {
+		error("Git to program copy thread failed");
+		ret = 1;
+	}
+	if (err) {
+		error("Error joining data copying thread: %s", strerror(err));
+		ret = 1;
+	}
+	err = pthread_join(ptg_thread, &dummy);
+	if (!dummy) {
+		error("Program to git copy thread failed");
+		ret = 1;
+	}
+	if (err) {
+		error("Error joining data copying thread: %s", strerror(err));
+		ret = 1;
+	}
+	return ret;
+}
+#else
+
+static void udt_kill_transfer(struct unidirectional_transfer *t)
+{
+	t->state = SSTATE_FINISHED;
+	close(t->src);
+	if (t->dest_is_sock)
+		shutdown(t->dest, SHUT_WR);
+	else
+		close(t->dest);
+}
+
+static int transloop_with_threads(struct bidirectional_transfer_state *s)
+{
+	int tret;
+	pid_t pid1, pid2;
+	int ret = 0;
+	int err;
+
+	/* Fork thread #1: git to program. */
+	pid1 = fork();
+	if (pid1 < 0)
+		die_errno("Can't start thread for copying data");
+	else if (pid1 == 0) {
+		udt_kill_transfer(&s->ptg);
+		exit(udt_copy_thread_routine(&s->gtp) ? 0 : 1);
+	}
+
+	/* Fork thread #2: program to git. */
+	pid2 = fork();
+	if (pid2 < 0)
+		die_errno("Can't start thread for copying data");
+	else if (pid2 == 0) {
+		udt_kill_transfer(&s->gtp);
+		exit(udt_copy_thread_routine(&s->ptg) ? 0 : 1);
+	}
+
+	udt_kill_transfer(&s->gtp);
+	udt_kill_transfer(&s->ptg);
+
+	/* There are two child processes, so wait both of them. */
+	err = waitpid(pid1, &tret, 0);
+	if (err < 0)
+		error("Error joining data copying thread: %s", strerror(errno));
+	if (err < 0 || !WIFEXITED(tret) || WEXITSTATUS(tret)) {
+		error("Git to program copy thread failed");
+		ret = 1;
+	}
+	err = waitpid(pid2, &tret, 0);
+	if (err < 0)
+		error("Error joining data copying thread: %s", strerror(errno));
+	if (err < 0 || !WIFEXITED(tret) || WEXITSTATUS(tret)) {
+		error("Program to git copy thread failed");
+		ret = 1;
+	}
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
+	state.ptg.dest_is_sock = 0;
+	state.ptg.state = SSTATE_TRANSFERING;
+	state.ptg.bufuse = 0;
+	state.ptg.src_name = "remote input";
+	state.ptg.dest_name = "stdout";
+
+	state.gtp.src = 0;
+	state.gtp.dest = output;
+	state.gtp.dest_is_sock = (input == output);
+	state.gtp.state = SSTATE_TRANSFERING;
+	state.gtp.bufuse = 0;
+	state.gtp.src_name = "stdin";
+	state.gtp.dest_name = "remote output";
+
+	return transloop_with_threads(&state);
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
1.7.3.1.53.gb58bd
