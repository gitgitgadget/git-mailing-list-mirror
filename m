From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH js/daemon-log] receive-pack: do not send error details to the client
Date: Sun, 21 Jun 2009 23:16:09 +0200
Message-ID: <200906212316.09149.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 23:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIUOm-0008Tg-PG
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 23:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbZFUVQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 17:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbZFUVQL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 17:16:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:22073 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbZFUVQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 17:16:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4368B2C4003;
	Sun, 21 Jun 2009 23:16:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A6FBC42763;
	Sun, 21 Jun 2009 23:16:09 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121993>

If the objects that a client pushes to the server cannot be processed for
any reason, an error is reported back to the client via the git protocol.
We used to send quite detailed information if a system call failed if
unpack-objects is run. This can be regarded as an information leak. Now we
do not send any error details like we already do in the case where
index-pack failed.

Errors in system calls as well as the exit code of unpack-objects and
index-pack are now reported to stderr; in the case of a local push or via
ssh these messages still go to the client, but that is OK since these forms
of access to the server assume that the client can be trusted. If
receive-pack is run from git-daemon, then the daemon should put the error
messages into the syslog.

With this reasoning a new status report is added for the post-update-hook;
untrusted (i.e. daemon's) clients cannot observe its status anyway, others
may want to know failure details.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Does this make sense?

 The motivation of this change is to ultimately get rid of error codes
 for system call failures in start/finish/run_command functions and call
 error() in these functions.

 -- Hannes

 builtin-receive-pack.c |   53 +++++++++++++++++++----------------------------
 1 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 33d345d..6ec1d05 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -123,27 +123,27 @@ static struct command *commands;
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
-static int hook_status(int code, const char *hook_name)
+static int run_status(int code, const char *cmd_name)
 {
 	switch (code) {
 	case 0:
 		return 0;
 	case -ERR_RUN_COMMAND_FORK:
-		return error("hook fork failed");
+		return error("fork of %s failed", cmd_name);
 	case -ERR_RUN_COMMAND_EXEC:
-		return error("hook execute failed");
+		return error("execute of %s failed", cmd_name);
 	case -ERR_RUN_COMMAND_PIPE:
-		return error("hook pipe failed");
+		return error("pipe failed");
 	case -ERR_RUN_COMMAND_WAITPID:
 		return error("waitpid failed");
 	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
 		return error("waitpid is confused");
 	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		return error("%s died of signal", hook_name);
+		return error("%s died of signal", cmd_name);
 	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		return error("%s died strangely", hook_name);
+		return error("%s died strangely", cmd_name);
 	default:
-		error("%s exited with error code %d", hook_name, -code);
+		error("%s exited with error code %d", cmd_name, -code);
 		return -code;
 	}
 }
@@ -174,7 +174,7 @@ static int run_receive_hook(const char *hook_name)
 
 	code = start_command(&proc);
 	if (code)
-		return hook_status(code, hook_name);
+		return run_status(code, hook_name);
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
@@ -186,7 +186,7 @@ static int run_receive_hook(const char *hook_name)
 		}
 	}
 	close(proc.in);
-	return hook_status(finish_command(&proc), hook_name);
+	return run_status(finish_command(&proc), hook_name);
 }
 
 static int run_update_hook(struct command *cmd)
@@ -203,7 +203,7 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
-	return hook_status(run_command_v_opt(argv, RUN_COMMAND_NO_STDIN |
+	return run_status(run_command_v_opt(argv, RUN_COMMAND_NO_STDIN |
 					RUN_COMMAND_STDOUT_TO_STDERR),
 			update_hook);
 }
@@ -394,7 +394,7 @@ static char update_post_hook[] = "hooks/post-update";
 static void run_update_post_hook(struct command *cmd)
 {
 	struct command *cmd_p;
-	int argc;
+	int argc, status;
 	const char **argv;
 
 	for (argc = 0, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
@@ -417,8 +417,9 @@ static void run_update_post_hook(struct command *cmd)
 		argc++;
 	}
 	argv[argc] = NULL;
-	run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
-		| RUN_COMMAND_STDOUT_TO_STDERR);
+	status = run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
+			| RUN_COMMAND_STDOUT_TO_STDERR);
+	run_status(status, update_post_hook);
 }
 
 static void execute_commands(const char *unpacker_error)
@@ -534,24 +535,10 @@ static const char *unpack(void)
 		unpacker[i++] = hdr_arg;
 		unpacker[i++] = NULL;
 		code = run_command_v_opt(unpacker, RUN_GIT_CMD);
-		switch (code) {
-		case 0:
+		if (!code)
 			return NULL;
-		case -ERR_RUN_COMMAND_FORK:
-			return "unpack fork failed";
-		case -ERR_RUN_COMMAND_EXEC:
-			return "unpack execute failed";
-		case -ERR_RUN_COMMAND_WAITPID:
-			return "waitpid failed";
-		case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-			return "waitpid is confused";
-		case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-			return "unpacker died of signal";
-		case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-			return "unpacker died strangely";
-		default:
-			return "unpacker exited with error code";
-		}
+		run_status(code, unpacker[0]);
+		return "unpack-objects abnormal exit";
 	} else {
 		const char *keeper[7];
 		int s, status, i = 0;
@@ -574,8 +561,11 @@ static const char *unpack(void)
 		ip.argv = keeper;
 		ip.out = -1;
 		ip.git_cmd = 1;
-		if (start_command(&ip))
+		status = start_command(&ip);
+		if (status) {
+			run_status(status, keeper[0]);
 			return "index-pack fork failed";
+		}
 		pack_lockfile = index_pack_lockfile(ip.out);
 		close(ip.out);
 		status = finish_command(&ip);
@@ -583,6 +573,7 @@ static const char *unpack(void)
 			reprepare_packed_git();
 			return NULL;
 		}
+		run_status(status, keeper[0]);
 		return "index-pack abnormal exit";
 	}
 }
-- 
1.6.3.17.g1665f
