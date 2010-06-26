From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 1/2] New remote helper git-remote-fd
Date: Sat, 26 Jun 2010 17:20:16 +0300
Message-ID: <1277562017-3316-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 16:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSWEG-0008O2-EZ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 16:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab0FZOTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 10:19:25 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:37334 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab0FZOTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 10:19:24 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 312BB8C530
	for <git@vger.kernel.org>; Sat, 26 Jun 2010 17:19:22 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02D33C2324; Sat, 26 Jun 2010 17:19:21 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id DFC1F4035
	for <git@vger.kernel.org>; Sat, 26 Jun 2010 17:19:20 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149757>

This remote helper reflects the outgoing smart transport stream back to
caller. This is useful if some frontend wants to handle the transport
stream for some reason (e.g. offering more options for SSH).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Makefile            |    1 +
 builtin.h           |    1 +
 builtin/remote-fd.c |   88 ++++++++++++++++++++++++++++++++++
 git.c               |    1 +
 transport-helper.c  |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.h         |    1 +
 6 files changed, 222 insertions(+), 0 deletions(-)
 create mode 100644 builtin/remote-fd.c

diff --git a/Makefile b/Makefile
index 5fa893c..ad53b52 100644
--- a/Makefile
+++ b/Makefile
@@ -702,6 +702,7 @@ BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
+BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
diff --git a/builtin.h b/builtin.h
index 5c887ef..af60b28 100644
--- a/builtin.h
+++ b/builtin.h
@@ -138,5 +138,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
+extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
new file mode 100644
index 0000000..08ff522
--- /dev/null
+++ b/builtin/remote-fd.c
@@ -0,0 +1,88 @@
+#include "git-compat-util.h"
+#include "transport.h"
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+
+
+/*
+ * URL syntax:
+ *	'fd::<inoutfd>[/<anything>]'		Read/write socket pair
+ *						<inoutfd>.
+ *	'fd::<infd>,<outfd>[/<anything>]'	Read pipe <infd> and write
+ *						pipe <outfd>.
+ *	[foo] indicates 'foo' is optional. <anything> is any string.
+ *
+ * The data output to <outfd>/<inoutfd> should be passed unmolested to
+ * git-receive-pack/git-upload-pack/git-upload-archive and output of
+ * git-receive-pack/git-upload-pack/git-upload-archive should be passed
+ * unmolested to <infd>/<inoutfd>.
+ *
+ */
+
+int input_fd = -1;
+int output_fd = -1;
+
+#define MAXCOMMAND 4096
+
+static int command_loop()
+{
+	char buffer[MAXCOMMAND];
+
+	while (1) {
+		if (!fgets(buffer, MAXCOMMAND - 1, stdin))
+			exit(0);
+		//Strip end of line characters.
+		while (isspace((unsigned char)buffer[strlen(buffer) - 1]))
+			buffer[strlen(buffer) - 1] = 0;
+
+		if (!strcmp(buffer, "capabilities")) {
+			printf("*connect\n\n");
+			fflush(stdout);
+		} else if (!strncmp(buffer, "connect ", 8)) {
+			printf("\n");
+			fflush(stdout);
+			return bidirectional_transfer_loop(input_fd,
+				output_fd);
+		} else {
+			fprintf(stderr, "Bad command");
+			return 1;
+		}
+	}
+}
+
+int cmd_remote_fd(int argc, const char **argv, const char *prefix)
+{
+	char* end;
+	unsigned long r;
+
+	if (argc < 3) {
+		fprintf(stderr, "Error: URL missing");
+		exit(1);
+	}
+
+	r = strtoul(argv[2], &end, 10);
+	input_fd = (int)r;
+
+	if ((*end != ',' && *end !='/' && *end) || end == argv[2]) {
+		fprintf(stderr, "Error: Bad URL syntax");
+		exit(1);
+	}
+
+	if (*end == '/' || !*end) {
+		output_fd = input_fd;
+	} else {
+		char* end2;
+		r = strtoul(end + 1, &end2, 10);
+		output_fd = (int)r;
+
+		if ((*end2 !='/' && *end2) || end2 == end + 1) {
+			fprintf(stderr, "Error: Bad URL syntax");
+			exit(1);
+		}
+	}
+
+	return command_loop();
+}
diff --git a/git.c b/git.c
index 99f0363..91de3d6 100644
--- a/git.c
+++ b/git.c
@@ -368,6 +368,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
+		{ "remote-fd", cmd_remote_fd, 0 },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
diff --git a/transport-helper.c b/transport-helper.c
index 0381de5..e07aa40 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -862,3 +862,133 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->smart_options = &(data->transport_options);
 	return 0;
 }
+
+
+#define BUFFERSIZE 4096
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
+	int socket_mode = 0;
+	int input_index = 2;
+	int output_index = 3;
+	int poll_count = 4;
+
+	if(input == output) {
+		output_index = input_index;
+		poll_count = 3;
+		socket_mode = 1;
+	}
+
+	while(in_buffer_use || out_buffer_use || !in_hup || !out_hup) {
+		int r, i;
+		/* Set up the poll and do it. */
+		polls[0].fd = 0;
+		polls[1].fd = 1;
+		polls[input_index].fd = input;
+		polls[output_index].fd = output;
+		for(i = 0; i < 4; i++)
+			polls[i].events = polls[i].revents = 0;
+
+		if(in_buffer_use > 0)
+			polls[output_index].events |= POLLOUT;
+		if(in_buffer_use < BUFFERSIZE && !in_hup)
+			polls[0].events |= POLLIN;
+		if(out_buffer_use > 0)
+			polls[1].events |= POLLOUT;
+		if(out_buffer_use < BUFFERSIZE && !out_hup)
+			polls[input_index].events |= POLLIN;
+		r = poll(polls, poll_count, -1);
+		if(r < 0) {
+			if(errno == EWOULDBLOCK || errno == EAGAIN ||
+				errno == EINTR)
+				continue;
+			perror("poll failed");
+			return 1;
+		} else if(r == 0)
+			continue;
+
+		/* Something interesting has happened... */
+		if(polls[0].revents & (POLLIN | POLLHUP)) {
+			/* Stdin is readable. */
+			r = read(0, in_buffer + in_buffer_use, BUFFERSIZE -
+				in_buffer_use);
+			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("read(git) failed");
+				return 1;
+			} else if(r == 0) {
+				in_hup = 1;
+				if(!in_buffer_use) {
+					if(socket_mode)
+						shutdown(output, SHUT_WR);
+					else
+						close(output);
+				}
+			} else
+				in_buffer_use += r;
+		}
+
+		if(polls[input_index].revents & (POLLIN | POLLHUP)) {
+			/* Connection is readable. */
+			r = read(input, out_buffer + out_buffer_use,
+				BUFFERSIZE - out_buffer_use);
+			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("read(connection) failed");
+				return 1;
+			} else if(r == 0) {
+				out_hup = 1;
+				if(!out_buffer_use)
+					close(1);
+			} else
+				out_buffer_use += r;
+		}
+
+		if(polls[1].revents & POLLOUT) {
+			/* Stdout is writable. */
+			r = write(1, out_buffer, out_buffer_use);
+			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("write(git) failed");
+				return 1;
+			} else {
+				out_buffer_use -= r;
+				if(out_buffer_use > 0)
+					memmove(out_buffer, out_buffer + r,
+						out_buffer_use);
+				if(out_hup && !out_buffer_use)
+					close(1);
+			}
+		}
+
+		if(polls[output_index].revents & POLLOUT) {
+			/* Connection is writable. */
+			r = write(output, in_buffer, in_buffer_use);
+			if(r < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
+				errno != EINTR) {
+				perror("write(connection) failed");
+				return 1;
+			} else {
+				in_buffer_use -= r;
+				if(in_buffer_use > 0)
+					memmove(in_buffer, in_buffer + r,
+						in_buffer_use);
+				if(in_hup && !in_buffer_use) {
+					if(socket_mode)
+						shutdown(output, SHUT_WR);
+					else
+						close(output);
+				}
+			}
+		}
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
1.7.1
