From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v3 1/3] Add bidirectional_transfer_loop()
Date: Thu, 30 Sep 2010 20:07:00 +0300
Message-ID: <1285866422-23964-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1285866422-23964-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 19:02:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1MWd-00075D-Lr
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 19:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232Ab0I3RBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 13:01:54 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:52090 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248Ab0I3RBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 13:01:52 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 1E2FDC7BA8
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 20:01:51 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01F571A922; Thu, 30 Sep 2010 20:01:51 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id F05FF158A64
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 20:01:48 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1285866422-23964-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157693>

This helper function copies bidirectional stream of data between
stdin/stdout and specified file descriptors.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 compat/mingw.h     |    5 +
 transport-helper.c |  254 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.h        |    1 +
 3 files changed, 260 insertions(+), 0 deletions(-)

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
index acfc88e..1ebcebc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -862,3 +862,257 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->smart_options = &(data->transport_options);
 	return 0;
 }
+
+
+#define BUFFERSIZE 4096
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
+	sprintf(msgbuf, "Transfer loop debugging: ");
+	va_start(args, fmt);
+	vsprintf(msgbuf + strlen(msgbuf), fmt, args);
+	va_end(args);
+	fprintf(stderr, "%s\n", msgbuf);
+}
+
+/* Load the parameters into poll structure. Return number of entries loaded */
+static int load_poll_params(struct pollfd *polls, size_t inbufuse,
+	size_t outbufuse, int in_hup, int out_hup, int in_closed,
+	int out_closed, int socket_mode, int input_fd, int output_fd)
+{
+	int stdin_index = -1;
+	int stdout_index = -1;
+	int input_index = -1;
+	int output_index = -1;
+	int nextindex = 0;
+	int i;
+
+	/*
+	 * Inputs can't be waited at all if buffer is full since we can't
+	 * do read on 0 bytes as it could do strange things.
+	 */
+	if (!in_hup && inbufuse < BUFFERSIZE) {
+		stdin_index = nextindex++;
+		polls[stdin_index].fd = 0;
+		transfer_debug("Adding stdin to fds to wait for");
+	}
+	if (!out_hup && outbufuse < BUFFERSIZE) {
+		input_index = nextindex++;
+		polls[input_index].fd = input_fd;
+		transfer_debug("Adding remote input to fds to wait for");
+	}
+	if (!out_closed && outbufuse > 0) {
+		stdout_index = nextindex++;
+		polls[stdout_index].fd = 1;
+		transfer_debug("Adding stdout to fds to wait for");
+	}
+	if (!in_closed && inbufuse > 0) {
+		if (socket_mode && input_index >= 0)
+			output_index = input_index;
+		else {
+			output_index = nextindex++;
+			polls[output_index].fd = output_fd;
+		}
+		transfer_debug("Adding remote output to fds to wait for");
+	}
+
+	for (i = 0; i < nextindex; i++)
+		polls[i].events = polls[i].revents = 0;
+
+	if (stdin_index >= 0) {
+		polls[stdin_index].events |= POLLIN;
+		transfer_debug("Waiting for stdin to become readable");
+	}
+	if (input_index >= 0) {
+		polls[input_index].events |= POLLIN;
+		transfer_debug("Waiting for remote input to become readable");
+	}
+	if (stdout_index >= 0) {
+		polls[stdout_index].events |= POLLOUT;
+		transfer_debug("Waiting for stdout to become writable");
+	}
+	if (output_index >= 0) {
+		polls[output_index].events |= POLLOUT;
+		transfer_debug("Waiting for remote output to become writable");
+	}
+
+	/* Return number of indexes assigned. */
+	return nextindex;
+}
+
+static int transfer_handle_events(struct pollfd* polls, char *in_buffer,
+	char *out_buffer, size_t *in_buffer_use, size_t *out_buffer_use,
+	int *in_hup, int *out_hup, int *in_closed, int *out_closed,
+	int socket_mode, int poll_count, int input, int output)
+{
+	int i, r;
+	for(i = 0; i < poll_count; i++) {
+		/* Handle stdin. */
+		if (polls[i].fd == 0 && polls[i].revents & (POLLIN | POLLHUP)) {
+			transfer_debug("stdin is readable");
+			r = read(0, in_buffer + *in_buffer_use, BUFFERSIZE -
+				*in_buffer_use);
+			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("read(git) failed");
+				return 1;
+			} else if (r == 0) {
+				transfer_debug("stdin EOF");
+				*in_hup = 1;
+				if (!*in_buffer_use) {
+					if (socket_mode)
+						shutdown(output, SHUT_WR);
+					else
+						close(output);
+					*in_closed = 1;
+					transfer_debug("Closed remote output");
+				} else
+					transfer_debug("Delaying remote output close because input buffer has data");
+			} else if (r > 0) {
+				*in_buffer_use += r;
+				transfer_debug("Read %i bytes from stdin (buffer now at %i)", r, (int)*in_buffer_use);
+			}
+		}
+
+		/* Handle remote end input. */
+		if (polls[i].fd == input &&
+			polls[i].revents & (POLLIN | POLLHUP)) {
+			transfer_debug("remote input is readable");
+			r = read(input, out_buffer + *out_buffer_use,
+				BUFFERSIZE - *out_buffer_use);
+			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("read(connection) failed");
+				return 1;
+			} else if (r == 0) {
+				transfer_debug("remote input EOF");
+				*out_hup = 1;
+				if (!*out_buffer_use) {
+					close(1);
+					*out_closed = 1;
+					transfer_debug("Closed stdout");
+				} else
+					transfer_debug("Delaying stdout close because output buffer has data");
+
+			} else if (r > 0) {
+				*out_buffer_use += r;
+				transfer_debug("Read %i bytes from remote input (buffer now at %i)", r, (int)*out_buffer_use);
+			}
+		}
+
+		/* Handle stdout. */
+		if (polls[i].fd == 1 && polls[i].revents & POLLNVAL) {
+			error("Write pipe to Git unexpectedly closed.");
+			return 1;
+		}
+		if (polls[i].fd == 1 && polls[i].revents & POLLOUT) {
+			transfer_debug("stdout is writable");
+			r = write(1, out_buffer, *out_buffer_use);
+			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("write(git) failed");
+				return 1;
+			} else if (r > 0){
+				*out_buffer_use -= r;
+				transfer_debug("Wrote %i bytes to stdout (buffer now at %i)", r, (int)*out_buffer_use);
+				if (*out_buffer_use > 0)
+					memmove(out_buffer, out_buffer + r,
+						*out_buffer_use);
+				if (*out_hup && !*out_buffer_use) {
+					close(1);
+					*out_closed = 1;
+					transfer_debug("Closed stdout");
+				}
+			}
+		}
+
+		/* Handle remote end output. */
+		if (polls[i].fd == output && polls[i].revents & POLLNVAL) {
+			error("Write pipe to remote end unexpectedly closed.");
+			return 1;
+		}
+		if (polls[i].fd == output && polls[i].revents & POLLOUT) {
+			transfer_debug("remote output is writable");
+			r = write(output, in_buffer, *in_buffer_use);
+			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("write(connection) failed");
+				return 1;
+			} else if (r > 0) {
+				*in_buffer_use -= r;
+				transfer_debug("Wrote %i bytes to remote output (buffer now at %i)", r, (int)*in_buffer_use);
+				if (*in_buffer_use > 0)
+					memmove(in_buffer, in_buffer + r,
+						*in_buffer_use);
+				if (*in_hup && !*in_buffer_use) {
+					if (socket_mode)
+						shutdown(output, SHUT_WR);
+					else
+						close(output);
+					*in_closed = 1;
+					transfer_debug("Closed remote output");
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+/* Copy data from stdin to output and from input to stdout. */
+int bidirectional_transfer_loop(int input, int output)
+{
+	struct pollfd polls[4];
+	char in_buffer[BUFFERSIZE];
+	char out_buffer[BUFFERSIZE];
+	size_t in_buffer_use = 0;
+	size_t out_buffer_use = 0;
+	int in_hup = 0;
+	int out_hup = 0;
+	int in_closed = 0;
+	int out_closed = 0;
+	int socket_mode = 0;
+	int poll_count = 4;
+
+	if (input == output)
+		socket_mode = 1;
+
+	while (1) {
+		int r;
+		poll_count = load_poll_params(polls, in_buffer_use,
+			out_buffer_use, in_hup, out_hup, in_closed, out_closed,
+			socket_mode, input, output);
+		if (!poll_count) {
+			transfer_debug("Transfer done");
+			break;
+		}
+		transfer_debug("Waiting for %i file descriptors", poll_count);
+		r = poll(polls, poll_count, -1);
+		if (r < 0) {
+			if (errno == EWOULDBLOCK || errno == EAGAIN ||
+				errno == EINTR)
+				continue;
+			perror("poll failed");
+			return 1;
+		} else if (r == 0)
+			continue;
+
+		r = transfer_handle_events(polls, in_buffer, out_buffer,
+			&in_buffer_use, &out_buffer_use, &in_hup, &out_hup,
+			&in_closed, &out_closed, socket_mode, poll_count,
+			input, output);
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
1.7.3.1.48.g4fe83
