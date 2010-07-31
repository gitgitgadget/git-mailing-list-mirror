From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [remote-fd RFC PATCH] Rewrite bidirectional traffic loop
Date: Sat, 31 Jul 2010 07:38:10 +0300
Message-ID: <1280551090-19189-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 06:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of3oY-0007T1-68
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 06:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121Ab0GaEge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 00:36:34 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:35479 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0GaEgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 00:36:33 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 0AC21C818B
	for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:36:32 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0483707A6D; Sat, 31 Jul 2010 07:36:32 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id D74D827D82
	for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:36:30 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152300>

Rewrite bidirectional traffic loop to be clearer, fix some logic
errors that could lead into push failing or unneeded CPU usage,
and support debugging mode (activated by setting $GIT_TRANSLOOP_DEBUG).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |  296 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 210 insertions(+), 86 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 3591e0d..0facf65 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -865,130 +865,254 @@ int transport_helper_init(struct transport *transport, const char *name)
 
 
 #define BUFFERSIZE 4096
+#define PBUFFERSIZE 8192
 
-/* Copy data from stdin to output and from input to stdout. */
-int bidirectional_transfer_loop(int input, int output)
+/* Print bidirectional transfer loop debug message. */
+static void transfer_debug(const char *fmt, ...)
 {
-	struct pollfd polls[4];
-	char in_buffer[BUFFERSIZE];
-	char out_buffer[BUFFERSIZE];
-	size_t in_buffer_use = 0;
-	size_t out_buffer_use = 0;
-	int in_hup = 0;
-	int out_hup = 0;
-	int socket_mode = 0;
-	int input_index = 2;
-	int output_index = 3;
-	int poll_count = 4;
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
 
-	if(input == output) {
-		output_index = input_index;
-		poll_count = 3;
-		socket_mode = 1;
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
 	}
 
-	while(in_buffer_use || out_buffer_use || !in_hup || !out_hup) {
-		int r, i;
-		/* Set up the poll and do it. */
-		polls[0].fd = 0;
-		polls[1].fd = 1;
-		polls[input_index].fd = input;
-		polls[output_index].fd = output;
-		for(i = 0; i < 4; i++)
-			polls[i].events = polls[i].revents = 0;
-
-		if(in_buffer_use > 0)
-			polls[output_index].events |= POLLOUT;
-		if(in_buffer_use < BUFFERSIZE && !in_hup)
-			polls[0].events |= POLLIN;
-		if(out_buffer_use > 0)
-			polls[1].events |= POLLOUT;
-		if(out_buffer_use < BUFFERSIZE && !out_hup)
-			polls[input_index].events |= POLLIN;
-		r = poll(polls, poll_count, -1);
-		if(r < 0) {
-			if(errno == EWOULDBLOCK || errno == EAGAIN ||
-				errno == EINTR)
-				continue;
-			perror("poll failed");
-			return 1;
-		} else if(r == 0)
-			continue;
+	for (i = 0; i < nextindex; i++)
+		polls[i].events = polls[i].revents = 0;
 
-		/* Something interesting has happened... */
-		if(polls[0].revents & (POLLIN | POLLHUP)) {
-			/* Stdin is readable. */
-			r = read(0, in_buffer + in_buffer_use, BUFFERSIZE -
-				in_buffer_use);
-			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
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
 				errno != EINTR) {
 				perror("read(git) failed");
 				return 1;
-			} else if(r == 0) {
-				in_hup = 1;
-				if(!in_buffer_use) {
-					if(socket_mode)
+			} else if (r == 0) {
+				transfer_debug("stdin EOF");
+				*in_hup = 1;
+				if (!*in_buffer_use) {
+					if (socket_mode)
 						shutdown(output, SHUT_WR);
 					else
 						close(output);
-				}
-			} else
-				in_buffer_use += r;
+					*in_closed = 1;
+					transfer_debug("Closed remote output");
+				} else
+					transfer_debug("Delaying remote output close because input buffer has data");
+			} else if (r > 0) {
+				*in_buffer_use += r;
+				transfer_debug("Read %i bytes from stdin (buffer now at %i)", r, (int)*in_buffer_use);
+			}
 		}
 
-		if(polls[input_index].revents & (POLLIN | POLLHUP)) {
-			/* Connection is readable. */
-			r = read(input, out_buffer + out_buffer_use,
-				BUFFERSIZE - out_buffer_use);
-			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		/* Handle remote end input. */
+		if (polls[i].fd == input &&
+			polls[i].revents & (POLLIN | POLLHUP)) {
+			transfer_debug("remote input is readable");
+			r = read(input, out_buffer + *out_buffer_use,
+				BUFFERSIZE - *out_buffer_use);
+			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
 				errno != EINTR) {
 				perror("read(connection) failed");
 				return 1;
-			} else if(r == 0) {
-				out_hup = 1;
-				if(!out_buffer_use)
+			} else if (r == 0) {
+				transfer_debug("remote input EOF");
+				*out_hup = 1;
+				if (!*out_buffer_use) {
 					close(1);
-			} else
-				out_buffer_use += r;
+					*out_closed = 1;
+					transfer_debug("Closed stdout");
+				} else
+					transfer_debug("Delaying stdout close because output buffer has data");
+
+			} else if (r > 0) {
+				*out_buffer_use += r;
+				transfer_debug("Read %i bytes from remote input (buffer now at %i)", r, (int)*out_buffer_use);
+			}
 		}
 
-		if(polls[1].revents & POLLOUT) {
-			/* Stdout is writable. */
-			r = write(1, out_buffer, out_buffer_use);
-			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		/* Handle stdout. */
+		if (polls[i].fd == 1 && polls[i].revents & POLLNVAL) {
+			error("Write pipe to Git unexpectedly closed.");
+			return 1;
+		}
+		if (polls[i].fd == 1 && polls[i].revents & POLLOUT) {
+			transfer_debug("stdout is writable");
+			r = write(1, out_buffer, *out_buffer_use);
+			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
 				errno != EINTR) {
 				perror("write(git) failed");
 				return 1;
-			} else {
-				out_buffer_use -= r;
-				if(out_buffer_use > 0)
+			} else if (r > 0){
+				*out_buffer_use -= r;
+				transfer_debug("Wrote %i bytes to stdout (buffer now at %i)", r, (int)*out_buffer_use);
+				if (*out_buffer_use > 0)
 					memmove(out_buffer, out_buffer + r,
-						out_buffer_use);
-				if(out_hup && !out_buffer_use)
+						*out_buffer_use);
+				if (*out_hup && !*out_buffer_use) {
 					close(1);
+					*out_closed = 1;
+					transfer_debug("Closed stdout");
+				}
 			}
 		}
 
-		if(polls[output_index].revents & POLLOUT) {
-			/* Connection is writable. */
-			r = write(output, in_buffer, in_buffer_use);
-			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+		/* Handle remote end output. */
+		if (polls[i].fd == output && polls[i].revents & POLLNVAL) {
+			error("Write pipe to remote end unexpectedly closed.");
+			return 1;
+		}
+		if (polls[i].fd == output && polls[i].revents & POLLOUT) {
+			transfer_debug("remote output is writable");
+			r = write(output, in_buffer, *in_buffer_use);
+			if (r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
 				errno != EINTR) {
 				perror("write(connection) failed");
 				return 1;
-			} else {
-				in_buffer_use -= r;
-				if(in_buffer_use > 0)
+			} else if (r > 0) {
+				*in_buffer_use -= r;
+				transfer_debug("Wrote %i bytes to remote output (buffer now at %i)", r, (int)*in_buffer_use);
+				if (*in_buffer_use > 0)
 					memmove(in_buffer, in_buffer + r,
-						in_buffer_use);
-				if(in_hup && !in_buffer_use) {
-					if(socket_mode)
+						*in_buffer_use);
+				if (*in_hup && !*in_buffer_use) {
+					if (socket_mode)
 						shutdown(output, SHUT_WR);
 					else
 						close(output);
+					*in_closed = 1;
+					transfer_debug("Closed remote output");
 				}
 			}
 		}
 	}
 	return 0;
 }
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
-- 
1.7.2.1.9.g1ccab
