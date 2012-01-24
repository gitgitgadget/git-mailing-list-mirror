From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 3/5] run-command: Elaborate execvp error checking
Date: Tue, 24 Jan 2012 23:32:24 +0100
Message-ID: <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 23:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpovQ-0005Nz-T5
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab2AXWdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:33:08 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab2AXWdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:33:06 -0500
Received: by mail-ey0-f174.google.com with SMTP id c13so1306974eaa.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OceGokrBMlth/rPLlTa26V8NFlR0v01Lj9gK0B7Qx2Q=;
        b=dJ2vk8z4qs5xynHEJ6z7YjvgHSNTxriGnwmozGhdb70/NzfBYiDzVAzSsCorPvQm+t
         lzO841EQYMsQlrBHMn0fe1i3uvY1OJXTGo7ofai2ZkvTzXohZlw8ehNzatUNJeNFV9J+
         upaVpa0WxiEoxzWU9AjgNFaaZ6EJQoFEbkrAs=
Received: by 10.213.7.136 with SMTP id d8mr306323ebd.102.1327444386052;
        Tue, 24 Jan 2012 14:33:06 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c37sm18739220eec.10.2012.01.24.14.33.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:33:05 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1
In-Reply-To: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189075>

The interpretation of errors from execvp was rather terse. For user
convenience communication of the nature of the error can be improved.

This patch introduces a function with more elaborate investigation of
the errors encountered. After a failure occurs on a program or script,
inspect_failure will run through the PATH entries if necessary, and if
the file exists, perform some tests on the file. If nothing is found,
ENOENT is returned.

The function inspect_file() will try to find out if the file itself or
an interpreter caused the issue. Some scripts don't have the hash-bang
and will not be reported as scripts. If the interpreter cannot be found,
the existing behavior is kept -- i.e. ENOENT will be reported to the
parent process.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 run-command.c          |  144 +++++++++++++++++++++++++++++++++++++++++++++---
 t/t0061-run-command.sh |    6 +-
 2 files changed, 140 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1c51043..17a65fe 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,6 +2,7 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "argv-array.h"
+#include "dir.h"
 
 static inline void close_pair(int fd[2])
 {
@@ -134,6 +135,140 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	return code;
 }
 
+#ifndef WIN32
+static int is_executable_file(const char *path)
+{
+	return access(path, X_OK) == 0 && !is_directory(path);
+}
+
+static int is_searchable(const char *path)
+{
+	return access(path, X_OK) == 0 && is_directory(path);
+}
+
+static void die_file_error(const char *file, int err)
+{
+	die("cannot exec '%s': %s", file, strerror(err));
+}
+
+static char *get_interpreter(const char *first_line)
+{
+	struct strbuf sb = STRBUF_INIT;
+	size_t start = strspn(first_line + 2, " \t") + 2;
+	size_t end = strcspn(first_line + start, " \t\r\n") + start;
+
+	if (start >= end)
+		return NULL;
+
+	strbuf_add(&sb, first_line + start, end - start);
+	return strbuf_detach(&sb, NULL);
+}
+
+static void inspect_file(struct strbuf *fn, int err, const char *argv0)
+{
+	/*
+	 * Typical line length of 80. BSD only allows 32 bytes, but that
+	 * won't really make a difference.
+	 */
+	char buf[80];
+	size_t read;
+	FILE *file;
+	if (!is_executable_file(fn->buf)) {
+		strbuf_release(fn);
+		die_file_error(argv0, err);
+	}
+
+	file = fopen(fn->buf, "r");
+	if (!file) {
+		strbuf_release(fn);
+		die_file_error(argv0, err);
+	}
+
+	read = fread(buf, 1, sizeof(buf), file);
+	fclose(file);
+	if (read > 2 && buf[0] == '#' && buf[1] == '!') {
+		char *i = get_interpreter(buf);
+		char es[1024];
+		if (i) {
+			sprintf(es, "cannot exec '%s': "
+					"bad interpreter '%s': %s",
+					argv0, i,
+					strerror(err));
+		} else {
+			sprintf(es, "cannot exec '%s': "
+					"bad interpreter: %s",
+					argv0, strerror(err));
+		}
+		free(i);
+		strbuf_release(fn);
+		if (err == ENOENT) {
+			error("%s", es);
+			exit(127);
+		} else {
+			die("%s", es);
+		}
+	}
+
+	strbuf_release(fn);
+	die_file_error(argv0, err);
+}
+
+static void inspect_failure(const char *argv0, int silent_exec_failure)
+{
+	int err = errno;
+	struct strbuf sb = STRBUF_INIT;
+
+	/* errors not related to path */
+	if (errno == E2BIG || errno == ENOMEM)
+		die_file_error(argv0, err);
+
+	if (strchr(argv0, '/')) {
+		if (file_exists(argv0)) {
+			strbuf_add(&sb, argv0, strlen(argv0));
+			inspect_file(&sb, err, argv0);
+		}
+	} else {
+		char *path, *next;
+		path = getenv("PATH");
+		while (path) {
+			next = strchrnul(path, ':');
+			if (path < next)
+				strbuf_add(&sb, path, next - path);
+			else
+				strbuf_addch(&sb, '.');
+
+			if (!*next)
+				path = NULL;
+			else
+				path = next + 1;
+
+			if (!is_searchable(sb.buf)) {
+				strbuf_release(&sb);
+				continue;
+			}
+
+			if (sb.len && sb.buf[sb.len - 1] != '/')
+				strbuf_addch(&sb, '/');
+			strbuf_addstr(&sb, argv0);
+
+			if (file_exists(sb.buf))
+				inspect_file(&sb, err, argv0);
+
+			strbuf_release(&sb);
+		}
+	}
+
+	if (err == ENOENT) {
+		if (!silent_exec_failure)
+			error("cannot exec '%s': %s", argv0,
+					strerror(ENOENT));
+		exit(127);
+	} else {
+		die_file_error(argv0, err);
+	}
+}
+#endif
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -280,14 +415,7 @@ fail_pipe:
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		if (errno == ENOENT) {
-			if (!cmd->silent_exec_failure)
-				error("cannot run %s: %s", cmd->argv[0],
-					strerror(ENOENT));
-			exit(127);
-		} else {
-			die_errno("cannot exec '%s'", cmd->argv[0]);
-		}
+		inspect_failure(cmd->argv[0], cmd->silent_exec_failure);
 	}
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 31eb3c3..14b4ea6 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -71,7 +71,8 @@ test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
 	chmod -x someinterpreter &&
 	test_must_fail test-run-command run-command ./hello.sh 2>err &&
 
-	grep "fatal: cannot exec.*hello.sh" err
+	grep "fatal: cannot exec.*hello.sh" err &&
+	grep "bad interpreter" err
 '
 
 test_expect_failure POSIXPERM 'run_command reports ENOENT, interpreter' '
@@ -79,7 +80,8 @@ test_expect_failure POSIXPERM 'run_command reports ENOENT, interpreter' '
 	chmod +x hello.sh &&
 	test_must_fail test-run-command start-command-ENOENT ./hello.sh 2>err &&
 
-	grep "error: cannot exec.*hello.sh" err
+	grep "error: cannot exec.*hello.sh" err &&
+	grep "bad interpreter" err
 '
 
 test_done
-- 
1.7.8.1
