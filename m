From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v2 2/3] git-remote-fd
Date: Thu, 30 Sep 2010 14:52:58 +0300
Message-ID: <1285847579-21954-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 13:48:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HcG-0003MB-6y
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab0I3Lry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:47:54 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:41417 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870Ab0I3Lrv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 07:47:51 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 2B255EF561
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:47:50 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07AE2EA95C; Thu, 30 Sep 2010 14:47:49 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 0E2302BD4F
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:47:48 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157645>

This remote helper reflects raw smart remote transport stream back to the
calling program. This is useful for example if some UI wants to handle
ssh itself and not use hacks via GIT_SSH.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-fd.txt |   57 +++++++++++++++++++++++++
 Makefile                        |    1 +
 builtin.h                       |    1 +
 builtin/remote-fd.c             |   88 +++++++++++++++++++++++++++++++++++++++
 git.c                           |    1 +
 5 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-fd.c

diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
new file mode 100644
index 0000000..12e588a
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
+This command uses specified file descriptors to connect to remote git server.
+
+If just <fd> is specified, <fd> is assumed to be socket that is
+transparently connected to git server program.
+
+If <infd> and <outfd> are specified, <infd> is assumed to be pipe from
+git server program and <outfd> is assumed to be pipe to git server program.
+
+It is assumed that any handshaking procedures have already been completed
+(such as sending service request for git://).
+
+<anything> can be any string. It is ignored. It is meant for provoding
+information to user in form of "URL".
+
+ENVIRONMENT VARIABLES:
+----------------------
+
+$GIT_TRANSLOOP_DEBUG (passed to git)::
+	If set, prints debugging information about various reads/writes.
+
+
+EXAMPLES:
+---------
+"fd::17"::
+	Connect using socket in file descriptor #17.
+
+"fd::17/foo"::
+	Same as above.
+
+"fd::7,8"::
+	Connect using pipes in file descriptors #7 and #8. The incoming
+	pipe is at fd #7 and the outgoing pipe at fd #8.
+
+"fd::7,8/bar"::
+	Same as above.
+
+Documentation
+--------------
+Documentation by Ilari Liusvaara.
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
index f2a25a0..748cc13 100644
--- a/builtin.h
+++ b/builtin.h
@@ -140,5 +140,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
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
index 50a1401..250ecc5 100644
--- a/git.c
+++ b/git.c
@@ -374,6 +374,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
+		{ "remote-fd", cmd_remote_fd, 0 },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
-- 
1.7.2.3.401.g919b6e
