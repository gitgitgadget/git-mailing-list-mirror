From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] run-command: add "use shell" option
Date: Wed, 30 Dec 2009 05:53:16 -0500
Message-ID: <20091230105316.GA22959@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 11:53:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwBA-0002Fc-RM
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 11:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZL3KxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 05:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbZL3KxT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 05:53:19 -0500
Received: from peff.net ([208.65.91.99]:37122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbZL3KxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 05:53:19 -0500
Received: (qmail 5121 invoked by uid 107); 30 Dec 2009 10:58:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 05:58:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 05:53:16 -0500
Content-Disposition: inline
In-Reply-To: <20091230095634.GA16349@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135881>

Many callsites run "sh -c $CMD" to run $CMD. We can make it
a little simpler for them by factoring out the munging of
argv.

For simple cases with no arguments, this doesn't help much, but:

  1. For cases with arguments, we save the caller from
     having to build the appropriate shell snippet.

  2. We can later optimize to avoid the shell when
     there are no metacharacters in the program.

Signed-off-by: Jeff King <peff@peff.net>
---
I made the matching tweak to the Windows half of run-command, but I
don't actually have a box to test it on.

I modeled this after execv_git_cmd. Like that function, I try to release
the allocated argv on error. However, we do actually leak the strbuf
memory in one case. I'm not sure how much we care. On unix, this will
always happen in a forked process which will either exec or die. On
Windows, we seem to already be leaking the prepared argv for the git_cmd
case (and now we leak the shell_cmd case, too).

 run-command.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 run-command.h |    2 ++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index cf2d8f7..dc65903 100644
--- a/run-command.c
+++ b/run-command.c
@@ -15,6 +15,46 @@ static inline void dup_devnull(int to)
 	close(fd);
 }
 
+static const char **prepare_shell_cmd(const char **argv)
+{
+	int argc, nargc = 0;
+	const char **nargv;
+
+	for (argc = 0; argv[argc]; argc++)
+		; /* just counting */
+	/* +1 for NULL, +3 for "sh -c" plus extra $0 */
+	nargv = xmalloc(sizeof(*nargv) * (argc + 1 + 3));
+
+	if (argc < 1)
+		die("BUG: shell command is empty");
+
+	nargv[nargc++] = "sh";
+	nargv[nargc++] = "-c";
+
+	if (argc < 2)
+		nargv[nargc++] = argv[0];
+	else {
+		struct strbuf arg0 = STRBUF_INIT;
+		strbuf_addf(&arg0, "%s \"$@\"", argv[0]);
+		nargv[nargc++] = strbuf_detach(&arg0, NULL);
+	}
+
+	for (argc = 0; argv[argc]; argc++)
+		nargv[nargc++] = argv[argc];
+	nargv[nargc] = NULL;
+
+	return nargv;
+}
+
+static int execv_shell_cmd(const char **argv)
+{
+	const char **nargv = prepare_shell_cmd(argv);
+	trace_argv_printf(nargv, "trace: exec:");
+	execvp(nargv[0], (char **)nargv);
+	free(nargv);
+	return -1;
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -123,6 +163,8 @@ fail_pipe:
 			cmd->preexec_cb();
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
+		} else if (cmd->use_shell) {
+			execv_shell_cmd(cmd->argv);
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
@@ -179,6 +221,8 @@ fail_pipe:
 
 	if (cmd->git_cmd) {
 		cmd->argv = prepare_git_cmd(cmd->argv);
+	} else if (cmd->use_shell) {
+		cmd->argv = prepare_shell_cmd(cmd->argv);
 	}
 
 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
@@ -297,6 +341,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
 	cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
+	cmd->use_shell = opt & RUN_USING_SHELL ? 1 : 0;
 }
 
 int run_command_v_opt(const char **argv, int opt)
diff --git a/run-command.h b/run-command.h
index fb34209..967ba8c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -33,6 +33,7 @@ struct child_process {
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned silent_exec_failure:1;
 	unsigned stdout_to_stderr:1;
+	unsigned use_shell:1;
 	void (*preexec_cb)(void);
 };
 
@@ -46,6 +47,7 @@ extern int run_hook(const char *index_file, const char *name, ...);
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 #define RUN_SILENT_EXEC_FAILURE 8
+#define RUN_USING_SHELL 16
 int run_command_v_opt(const char **argv, int opt);
 
 /*
-- 
1.6.6.65.g050d2.dirty
