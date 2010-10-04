From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v4 1/3] Add bidirectional_transfer_loop()
Date: Mon,  4 Oct 2010 14:04:16 +0300
Message-ID: <1286190258-12724-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 12:59:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2il7-0006jn-Ow
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 12:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab0JDK6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 06:58:44 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:46793 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab0JDK6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 06:58:41 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 14C86EF339
	for <git@vger.kernel.org>; Mon,  4 Oct 2010 13:58:39 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A039F010F77; Mon, 04 Oct 2010 13:58:39 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id D45902BD45
	for <git@vger.kernel.org>; Mon,  4 Oct 2010 13:58:37 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158029>

This helper function copies bidirectional stream of data between
stdin/stdout and specified file descriptors.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 compat/mingw.h     |    5 +
 transport-helper.c |  324 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.h        |    1 +
 3 files changed, 330 insertions(+), 0 deletions(-)

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
index acfc88e..1f7bad6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -862,3 +862,327 @@ int transport_helper_init(struct transport *transport, const char *name)
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
+struct unidirectional_transfer
+{
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
+static int udt_can_read(struct unidirectional_transfer *t)
+{
+	return (STATE_NEEDS_READING(t->state) && t->bufuse < BUFFERSIZE);
+}
+
+static int udt_can_write(struct unidirectional_transfer *t)
+{
+	return (STATE_NEEDS_WRITING(t->state) && t->bufuse > 0);
+}
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
+		if(t->bufuse)
+			memmove(t->buf, t->buf + r, t->bufuse);
+		transfer_debug("Wrote %i bytes to %s (buffer now at %i)",
+			r, t->dest_name, (int)t->bufuse);
+	}
+	return 0;
+}
+
+/* State of bidirectional transfer loop. */
+struct bidirectional_transfer_state
+{
+	/*
+	 * Current polls. Up to 4 because both read and write for both
+	 * directions possibly needs to poll, and all of these may occur
+	 * at once.
+	 */
+	struct pollfd polls[4];
+	/* Number of polls active. */
+	int polls_active;
+	/* Index for stdin in poll array, -1 if none. */
+	int stdin_index;
+	/* Index for stdout in poll array, -1 if none. */
+	int stdout_index;
+	/* Index for input descriptor in poll array, -1 if none. */
+	int input_index;
+	/* Index for output descrptor in poll array, -1 if none. */
+	int output_index;
+	/* Direction from program to git. */
+	struct unidirectional_transfer ptg;
+	/* Direction from git to program. */
+	struct unidirectional_transfer gtp;
+};
+
+/*
+ * Allocate individual poll array entry.
+ * polls -> The polls array. Must have at least *active + 1 entries.
+ * active -> Place for number of active polls. Value in this location is
+ * incremented.
+ * index -> Place to store index for newly allocated entry.
+ * fd -> The file descriptor to place there.
+ * name -> Name for fd to print. If NULL, no message is printed.
+ */
+static void allocate_poll_array_entry(struct pollfd* polls, int* active,
+	int* index, int fd, const char* name)
+{
+	*index = (*active)++;
+	polls[*index].fd = fd;
+	if (name)
+		transfer_debug("Adding %s to fds to wait for...", name);
+}
+
+
+/* Allocate indexes for file descriptors in poll array. */
+static void allocate_poll_indexes(struct bidirectional_transfer_state* s)
+{
+	/* Initialize fields like there was nothing waiting. */
+	s->stdin_index = -1;
+	s->stdout_index = -1;
+	s->input_index = -1;
+	s->output_index = -1;
+	s->polls_active = 0;
+
+	if (udt_can_read(&s->ptg))
+		allocate_poll_array_entry(s->polls, &s->polls_active,
+			&s->input_index, s->ptg.src, s->ptg.src_name);
+	if (udt_can_write(&s->ptg))
+		allocate_poll_array_entry(s->polls, &s->polls_active,
+			&s->stdout_index, s->ptg.dest, s->ptg.dest_name);
+	if (udt_can_read(&s->gtp))
+		allocate_poll_array_entry(s->polls, &s->polls_active,
+			&s->stdin_index, s->gtp.src, s->gtp.src_name);
+	if (udt_can_write(&s->gtp)) {
+		if (s->gtp.dest == s->ptg.src && s->input_index >= 0)
+			s->output_index = s->input_index;
+		else
+			allocate_poll_array_entry(s->polls, &s->polls_active,
+				&s->output_index, s->gtp.dest,
+				s->gtp.dest_name);
+		transfer_debug("Adding %s to fds to wait for",
+			s->gtp.dest_name);
+	}
+}
+
+/*
+ * Set specified event flags for specified poll array entry if index is
+ * valid. If msg is not null, it is printed as debug message.
+ */
+static void mark_for_wait(struct pollfd* polls, int index, int flags,
+	const char* msg)
+{
+	if (index < 0)
+		return;		/* Index not in use. */
+	polls[index].events |= flags;
+	transfer_debug("Setting fd wait flags: fd=%i, flags=%i, index=%i",
+		polls[index].fd, flags, index);
+	if (msg)
+		transfer_debug("%s", msg);
+}
+
+/*
+ * Load the parameters into poll array and related fields based on rest of
+ * fields.
+ */
+static void load_poll_params(struct bidirectional_transfer_state* s)
+{
+	int i;
+
+	allocate_poll_indexes(s);
+	for (i = 0; i < s->polls_active; i++)
+		s->polls[i].events = s->polls[i].revents = 0;
+
+	mark_for_wait(s->polls, s->stdin_index, POLLIN,
+		"Waiting for stdin to become readable");
+	mark_for_wait(s->polls, s->input_index, POLLIN,
+		"Waiting for remote input to become readable");
+	mark_for_wait(s->polls, s->stdout_index, POLLOUT,
+		"Waiting for stdout to become writable");
+	mark_for_wait(s->polls, s->output_index, POLLOUT,
+		"Waiting for remote output to become writable");
+}
+
+/* Call handler if ready. */
+static int call_handler_if(int r, struct bidirectional_transfer_state* s,
+	int index, int flagmask, const char* name,
+	int (*on_ready)(struct unidirectional_transfer *t),
+	struct unidirectional_transfer *transfer)
+{
+	if(r)
+		return r;
+	if(index < 0)
+		return 0;		/* This is not being waited. */
+	if(s->polls[index].revents & POLLNVAL) {
+		error("%s got unexpectedly closed", name);
+		return -1;
+	}
+	if(!(s->polls[index].revents & flagmask))
+		return 0;		/* No events returned. */
+	return on_ready(transfer);
+}
+
+/* Handle events occured during poll. Returns -1 on error, 0 on success. */
+static int transfer_handle_events(struct bidirectional_transfer_state* s)
+{
+	int r = 0;
+	r = call_handler_if(r, s, s->stdin_index, POLLIN | POLLHUP,
+		s->gtp.src_name, udt_do_read, &s->gtp);
+	r = call_handler_if(r, s, s->input_index, POLLIN | POLLHUP,
+		s->ptg.src_name, udt_do_read, &s->ptg);
+	r = call_handler_if(r, s, s->output_index, POLLOUT,
+		s->gtp.dest_name, udt_do_write, &s->gtp);
+	r = call_handler_if(r, s, s->stdout_index, POLLOUT,
+		s->ptg.dest_name, udt_do_write, &s->ptg);
+	udt_close_if_finished(&s->ptg);
+	udt_close_if_finished(&s->gtp);
+	return r;
+}
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
+	while (1) {
+		int r;
+		load_poll_params(&state);
+		if (!state.polls_active) {
+			transfer_debug("Transfer done");
+			break;
+		}
+		transfer_debug("Waiting for %i file descriptors",
+			state.polls_active);
+		r = poll(state.polls, state.polls_active, -1);
+		if (r < 0) {
+			if (errno == EWOULDBLOCK || errno == EAGAIN ||
+				errno == EINTR)
+				continue;
+			error("poll failed: %s", strerror(errno));
+			return -1;
+		} else if (r == 0)
+			continue;
+
+		r = transfer_handle_events(&state);
+		if (r)
+			return r;
+	}
+	return 0;
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
1.7.3.1.48.g63ac7.dirty
