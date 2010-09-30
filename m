From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v3 2/3] git-remote-fd
Date: Thu, 30 Sep 2010 20:07:01 +0300
Message-ID: <1285866422-23964-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1285866422-23964-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 19:02:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1MWe-00075D-D3
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 19:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab0I3RBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 13:01:55 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:59823 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab0I3RBx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 13:01:53 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 4C67618D21A
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 20:01:52 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01F5D48A54; Thu, 30 Sep 2010 20:01:52 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 3161927D84
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 20:01:51 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1285866422-23964-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157691>

This remote helper reflects raw smart remote transport stream back to the
calling program. This is useful for example if some UI wants to handle
ssh itself and not use hacks via GIT_SSH.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 .gitignore                      |    1 +
 Documentation/git-remote-fd.txt |   57 +++++++++++++++++++++++++++++
 Makefile                        |    1 +
 builtin.h                       |    1 +
 builtin/remote-fd.c             |   76 +++++++++++++++++++++++++++++++++++++++
 git.c                           |    1 +
 6 files changed, 137 insertions(+), 0 deletions(-)
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
index 0000000..c4c0da1
--- /dev/null
+++ b/Documentation/git-remote-fd.txt
@@ -0,0 +1,57 @@
+git-remote-fd(1)
+=================
+
+NAME
+----
+git-remote-fd - Reflect smart transport back to caller.
+
+
+SYNOPSIS
+--------
+"fd::<fd>[/<anything>]" or "fd::<infd>,<outfd>[/<anything>]" (as URL)
+
+DESCRIPTION
+-----------
+This helper uses specified file descriptors to connect to remote git server.
+
+Data written to <fd> or <outfd> is assumed to make it unmolested to
+git-upload-pack/git-receive-pack/git-upload-archive, and data from that
+program is assumed to be readable unmolested from <fd> or <infd>.
+
+If just <fd> is specified, <fd> is assumed to be socket. Otherwise both
+<infd> and <outfd> are assumed to be pipes.
+
+It is assumed that any handshaking procedures have already been completed
+(such as sending service request for git://) before this helper is started.
+
+<anything> can be any string. It is ignored. It is meant for provoding
+information to user in the "URL".
+
+ENVIRONMENT VARIABLES:
+----------------------
+
+$GIT_TRANSLOOP_DEBUG (passed to git)::
+	If set, prints debugging information about various reads/writes.
+
+EXAMPLES:
+---------
+"fd::17" (as URL)::
+	Connect using socket in file descriptor #17.
+
+"fd::17/foo" (as URL)::
+	Same as above.
+
+"fd::7,8" (as URL)::
+	Connect using pipes in file descriptors #7 and #8. The incoming
+	pipe is at fd #7 and the outgoing pipe at fd #8.
+
+"fd::7,8/bar" (as URL)::
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
index 0000000..44c174b
--- /dev/null
+++ b/builtin/remote-fd.c
@@ -0,0 +1,76 @@
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
+		/* Strip end of line characters. */
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
+	if (argc < 3)
+		die("URL missing");
+
+	r = strtoul(argv[2], &end, 10);
+	input_fd = (int)r;
+
+	if ((*end != ',' && *end !='/' && *end) || end == argv[2])
+		die("Bad URL syntax");
+
+	if (*end == '/' || !*end) {
+		output_fd = input_fd;
+	} else {
+		char* end2;
+		r = strtoul(end + 1, &end2, 10);
+		output_fd = (int)r;
+
+		if ((*end2 !='/' && *end2) || end2 == end + 1)
+			die("Bad URL syntax");
+	}
+
+	return command_loop();
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
1.7.3.1.48.g4fe83
