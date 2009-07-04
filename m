From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 6/7] run_command: report failure to execute the program, but optionally don't
Date: Sat,  4 Jul 2009 21:26:42 +0200
Message-ID: <87ce2ffef09004ca19acd491b9374283f06c98c2.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
 <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
 <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org>
 <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org>
 <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
 <195a33e7de20a4b52df8cb8861998fbbbed0b311.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAuj-0005PF-KU
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZGDT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZGDT1o
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:44 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17694 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbZGDT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 81FB3CDF87;
	Sat,  4 Jul 2009 21:27:34 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 15B387DFEA;
	Sat,  4 Jul 2009 21:27:34 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <195a33e7de20a4b52df8cb8861998fbbbed0b311.1246734159.git.j6t@kdbg.org>
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122729>

In the case where a program was not found, it was still the task of the
caller to report an error to the user. Usually, this is an interesting case
but only few callers actually reported a specific error (though many call
sites report a generic error message regardless of the cause).

With this change the error is reported by run_command, but since there is
one call site in git.c that does not want that, an option is added to
struct child_process, which is used to turn the error off.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-receive-pack.c |    4 +---
 git.c                  |    2 +-
 run-command.c          |   12 ++++++++----
 run-command.h          |    2 ++
 transport.c            |    6 +-----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 1dcdb1a..c85507b 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -125,9 +125,7 @@ static const char post_receive_hook[] = "hooks/post-receive";
 
 static int run_status(int code, const char *cmd_name)
 {
-	if (code < 0 && errno == ENOENT)
-		return error("execute of %s failed", cmd_name);
-	else if (code > 0)
+	if (code > 0)
 		error("%s exited with error code %d", cmd_name, code);
 	return code;
 }
diff --git a/git.c b/git.c
index 2fb7093..4a977f5 100644
--- a/git.c
+++ b/git.c
@@ -416,7 +416,7 @@ static void execv_dashed_external(const char **argv)
 	 * if we fail because the command is not found, it is
 	 * OK to return. Otherwise, we just pass along the status code.
 	 */
-	status = run_command_v_opt(argv, 0);
+	status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE);
 	if (status >= 0 || errno != ENOENT)
 		exit(status & 0xff);
 
diff --git a/run-command.c b/run-command.c
index 146a8ea..ddf3dd3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -184,7 +184,7 @@ fail_pipe:
 	}
 
 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
-	if (cmd->pid < 0 && errno != ENOENT)
+	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error("cannot spawn %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
 
@@ -233,7 +233,7 @@ fail_pipe:
 	return 0;
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0)
+static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 {
 	int status, code = -1;
 	pid_t waiting;
@@ -264,6 +264,9 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		if (code == 127) {
 			code = -1;
 			failed_errno = ENOENT;
+			if (!silent_exec_failure)
+				error("cannot run %s: %s", argv0,
+					strerror(ENOENT));
 		}
 	} else {
 		error("waitpid is confused (%s)", argv0);
@@ -274,7 +277,7 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0]);
+	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->silent_exec_failure);
 }
 
 int run_command(struct child_process *cmd)
@@ -294,6 +297,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+	cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
 }
 
 int run_command_v_opt(const char **argv, int opt)
@@ -358,7 +362,7 @@ int start_async(struct async *async)
 int finish_async(struct async *async)
 {
 #ifndef __MINGW32__
-	int ret = wait_or_whine(async->pid, "child process");
+	int ret = wait_or_whine(async->pid, "child process", 0);
 #else
 	DWORD ret = 0;
 	if (WaitForSingleObject(async->tid, INFINITE) != WAIT_OBJECT_0)
diff --git a/run-command.h b/run-command.h
index ac6c09c..0c00b25 100644
--- a/run-command.h
+++ b/run-command.h
@@ -31,6 +31,7 @@ struct child_process {
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
+	unsigned silent_exec_failure:1;
 	unsigned stdout_to_stderr:1;
 	void (*preexec_cb)(void);
 };
@@ -44,6 +45,7 @@ extern int run_hook(const char *index_file, const char *name, ...);
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
+#define RUN_SILENT_EXEC_FAILURE 8
 int run_command_v_opt(const char **argv, int opt);
 
 /*
diff --git a/transport.c b/transport.c
index 0885801..802ce7f 100644
--- a/transport.c
+++ b/transport.c
@@ -396,7 +396,6 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 {
 	const char **argv;
 	int argc;
-	int err;
 
 	if (flags & TRANSPORT_PUSH_MIRROR)
 		return error("http transport does not support mirror mode");
@@ -416,10 +415,7 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	while (refspec_nr--)
 		argv[argc++] = *refspec++;
 	argv[argc] = NULL;
-	err = run_command_v_opt(argv, RUN_GIT_CMD);
-	if (err < 0 && errno == ENOENT)
-		error("unable to exec %s", argv[0]);
-	return !!err;
+	return !!run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
 static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
-- 
1.6.3.17.g1665f
