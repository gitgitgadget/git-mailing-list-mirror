From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 1/2] run-command: Add checks after execvp fails with EACCES
Date: Tue, 13 Dec 2011 16:08:36 +0100
Message-ID: <1323788917-4141-2-git-send-email-fransklaver@gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
 <1323788917-4141-1-git-send-email-fransklaver@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 16:09:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaTz3-0005mh-3j
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 16:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab1LMPJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 10:09:28 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56943 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1LMPJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 10:09:27 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2162976eek.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BPH7JT9+JQNvKZb3ES/4EMzZYBqsd0x8Qe3fbdbiHzg=;
        b=tbZaJznN9T/xPtIsfjJ46wdM5ahmFTZujnH9LlelF6WY24NQz1KPGbEc6AOsbT6705
         d6fRrgXxW4Hmm/YgjAIsEtrvHi2S7vWHU1b65rBIAmJA0qkPyl6QChetTuJcVdchSHmZ
         B4OrJJ4rRHGB6A7Uakgp9subkxfJj3shq+n2Q=
Received: by 10.14.11.89 with SMTP id 65mr4273932eew.158.1323788957397;
        Tue, 13 Dec 2011 07:09:17 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x12sm90027005eef.9.2011.12.13.07.09.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 07:09:14 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323788917-4141-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187027>

execvp returns ENOENT if a command was not found after searching PATH.
If path contains a directory that current user has insufficient
privileges to, EACCES is returned. This may still mean the program
wasn't found and may cause confusion to the user, especially when the
file mentioned doesn't exist -- that is, the user would expect NOENT to
be returned -- and the user was actually hoping for an alias to be executed.

To help users track down the core issue more easily, perform some checks
on the path and file permissions involved. Output errors when paths or
files don't have enough permissions.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 run-command.c          |   79 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0061-run-command.sh |   16 +++++++++-
 2 files changed, 94 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1c51043..3f136f4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,6 +2,7 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "argv-array.h"
+#include "dir.h"
 
 static inline void close_pair(int fd[2])
 {
@@ -134,6 +135,80 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	return code;
 }
 
+#ifndef WIN32
+static int have_read_execute_permissions(const char *path)
+{
+	if (access(path, R_OK|X_OK) == 0)
+		return 1;
+
+	if (errno == EACCES)
+		return 0;
+
+	trace_printf("could not determine permissions for '%s': %s\n", path,
+				strerror(errno));
+	return 0;
+}
+
+static void diagnose_execvp_eacces(const char *cmd, const char **argv)
+{
+	/*
+	 * man 2 execve states that EACCES is returned for:
+	 * - Search permission is denied on a component of the path prefix
+	 *   of cmd or the name of a script interpreter
+	 * - The file or script interpreter is not a regular file
+	 * - Execute permission is denied for the file, script or ELF
+	 *   interpreter
+	 * - The file system is mounted noexec
+	 */
+	struct strbuf sb = STRBUF_INIT;
+	char *path;
+	char *next;
+
+	if (strchr(cmd, '/')) {
+		if (!have_read_execute_permissions(cmd))
+			error("no read/execute permissions on '%s'\n", cmd);
+		return;
+	}
+
+	path = getenv("PATH");
+	while (path) {
+		next = strchrnul(path, ':');
+		if (path < next)
+			strbuf_add(&sb, path, next - path);
+		else
+			strbuf_addch(&sb, '.');
+
+		if (!*next)
+			path = NULL;
+		else
+			path = next + 1;
+
+		if (!have_read_execute_permissions(sb.buf)) {
+			error("no read/execute permissions on '%s'\n", sb.buf);
+			strbuf_release(&sb);
+			continue;
+		}
+
+		if (sb.len && sb.buf[sb.len - 1] != '/')
+			strbuf_addch(&sb, '/');
+		strbuf_addstr(&sb, cmd);
+
+		if (file_exists(sb.buf)) {
+			if (!have_read_execute_permissions(sb.buf))
+				error("no read/execute permissions on '%s'\n",
+						sb.buf);
+			else
+				warning("file '%s' exists and permissions "
+				"seem OK.\nIf this is a script, see if you "
+				"have sufficient privileges to run the "
+				"interpreter", sb.buf);
+		}
+
+		strbuf_release(&sb);
+	}
+}
+#endif
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -285,6 +360,10 @@ fail_pipe:
 				error("cannot run %s: %s", cmd->argv[0],
 					strerror(ENOENT));
 			exit(127);
+		} else if (errno == EACCES) {
+			diagnose_execvp_eacces(cmd->argv[0], cmd->argv);
+			die("cannot exec '%s': %s", cmd->argv[0],
+				strerror(EACCES));
 		} else {
 			die_errno("cannot exec '%s'", cmd->argv[0]);
 		}
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 8d4938f..b39bd16 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -26,7 +26,7 @@ test_expect_success 'run_command can run a command' '
 	test_cmp empty err
 '
 
-test_expect_success POSIXPERM 'run_command reports EACCES' '
+test_expect_success POSIXPERM 'run_command reports EACCES, file permissions' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
 	test_must_fail test-run-command run-command ./hello.sh 2>err &&
@@ -34,4 +34,18 @@ test_expect_success POSIXPERM 'run_command reports EACCES' '
 	grep "fatal: cannot exec.*hello.sh" err
 '
 
+test_expect_success POSIXPERM 'run_command reports EACCES, search path permisions' '
+	mkdir -p inaccessible &&
+	PATH=$(pwd)/inaccessible:$PATH &&
+	export PATH &&
+
+	cat hello-script >inaccessible/hello.sh &&
+	chmod 400 inaccessible &&
+	test_must_fail test-run-command run-command hello.sh 2>err &&
+	chmod 755 inaccessible &&
+
+	grep "fatal: cannot exec.*hello.sh" err &&
+	grep "no read/execute permissions on" err
+'
+
 test_done
-- 
1.7.8
