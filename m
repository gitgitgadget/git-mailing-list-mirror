From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v7 2/3] git-remote-fd
Date: Tue, 12 Oct 2010 19:39:42 +0300
Message-ID: <1286901583-30088-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 18:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5hmr-0005qQ-3u
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 18:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829Ab0JLQdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 12:33:06 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:60785 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757716Ab0JLQdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 12:33:05 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 2F4B48C25A
	for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:33:04 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04F522ACB3; Tue, 12 Oct 2010 19:33:04 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 112094033
	for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:33:03 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158862>

This remote helper reflects raw smart remote transport stream back to the
calling program. This is useful for example if some UI wants to handle
ssh itself and not use hacks via GIT_SSH.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 .gitignore                      |    1 +
 Documentation/git-remote-fd.txt |   59 +++++++++++++++++++++++++++++
 Makefile                        |    1 +
 builtin.h                       |    1 +
 builtin/remote-fd.c             |   79 +++++++++++++++++++++++++++++++++++++++
 git.c                           |    1 +
 6 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-fd.c

diff --git a/.gitignore b/.gitignore
index 20560b8..89f37f4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,6 +112,7 @@
 /git-remote-https
 /git-remote-ftp
 /git-remote-ftps
+/git-remote-fd
 /git-remote-testgit
 /git-repack
 /git-replace
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
new file mode 100644
index 0000000..1c1a179
--- /dev/null
+++ b/Documentation/git-remote-fd.txt
@@ -0,0 +1,59 @@
+git-remote-fd(1)
+=================
+
+NAME
+----
+git-remote-fd - Reflect smart transport stream back to caller
+
+SYNOPSIS
+--------
+"fd::<infd>[,<outfd>][/<anything>]" (as URL)
+
+DESCRIPTION
+-----------
+This helper uses specified file descriptors to connect to remote git server.
+This is not meant for end users but for programs and scripts calling git
+fetch, push or archive.
+
+If only <infd> is given, it is assumed to be bidirectional socket connected
+to remote git server (git-upload-pack, git-receive-pack or
+git-upload-achive). If both <infd> and <outfd> are given, they are assumed
+to be pipes connected to remote git server (<infd> being the inbound pipe
+and <outfd> being the outbound pipe.
+
+It is assumed that any handshaking procedures have already been completed
+(such as sending service request for git://) before this helper is started.
+
+<anything> can be any string. It is ignored. It is meant for provoding
+information to user in the URL in case that URL is displayed in some
+context.
+
+ENVIRONMENT VARIABLES:
+----------------------
+GIT_TRANSLOOP_DEBUG::
+	If set, prints debugging information about various reads/writes.
+
+EXAMPLES:
+---------
+git fetch fd::17 master::
+	Fetch master, using file descriptor #17 to communicate with
+	git-upload-pack.
+
+git fetch fd::17/foo master::
+	Same as above.
+
+git push fd::7,8 master (as URL)::
+	Push master, using file descriptor #7 to read data from
+	git-receive-pack and file descriptor #8 to write data to
+	same service.
+
+git push fd::7,8/bar master::
+	Same as above.
+
+Documentation
+--------------
+Documentation by Ilari Liusvaara and the git list <git@vger.kernel.org>
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 8a56b9a..7da54d7 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,7 @@ BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
+BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
diff --git a/builtin.h b/builtin.h
index f2a25a0..1a816e1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -108,6 +108,7 @@ extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
+extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
new file mode 100644
index 0000000..7517f24
--- /dev/null
+++ b/builtin/remote-fd.c
@@ -0,0 +1,79 @@
+#include "git-compat-util.h"
+#include "transport.h"
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
+#define MAXCOMMAND 4096
+
+static void command_loop(int input_fd, int output_fd)
+{
+	char buffer[MAXCOMMAND];
+
+	while (1) {
+		size_t i;
+		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
+			if (ferror(stdin))
+				die("Input error");
+			return;
+		}
+		/* Strip end of line characters. */
+		i = strlen(buffer);
+		while (isspace(buffer[i - 1]))
+			buffer[--i] = 0;
+
+		if (!strcmp(buffer, "capabilities")) {
+			printf("*connect\n\n");
+			fflush(stdout);
+		} else if (!strncmp(buffer, "connect ", 8)) {
+			printf("\n");
+			fflush(stdout);
+			if (bidirectional_transfer_loop(input_fd,
+				output_fd))
+				die("Copying data between file descriptors failed");
+			return;
+		} else {
+			die("Bad command: %s", buffer);
+		}
+	}
+}
+
+int cmd_remote_fd(int argc, const char **argv, const char *prefix)
+{
+	int input_fd = -1;
+	int output_fd = -1;
+	char *end;
+
+	if (argc < 3)
+		die("URL missing");
+
+	input_fd = (int)strtoul(argv[2], &end, 10);
+
+	if ((end == argv[2]) || (*end != ',' && *end != '/' && *end))
+		die("Bad URL syntax");
+
+	if (*end == '/' || !*end) {
+		output_fd = input_fd;
+	} else {
+		char *end2;
+		output_fd = (int)strtoul(end + 1, &end2, 10);
+
+		if ((end2 == end + 1) || (*end2 != '/' && *end2))
+			die("Bad URL syntax");
+	}
+
+	command_loop(input_fd, output_fd);
+	return 0;
+}
diff --git a/git.c b/git.c
index 50a1401..b7b96b0 100644
--- a/git.c
+++ b/git.c
@@ -374,6 +374,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
+		{ "remote-fd", cmd_remote_fd },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
-- 
1.7.3.1.53.g597b29.dirty
