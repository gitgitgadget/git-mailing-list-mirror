From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/7] run_command: return exit code as positive value
Date: Sat,  4 Jul 2009 21:26:39 +0200
Message-ID: <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
 <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
 <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAui-0005PF-2k
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbZGDT1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbZGDT1k
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17679 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbZGDT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 04CFC1000B;
	Sat,  4 Jul 2009 21:27:34 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BF9C45B86D;
	Sat,  4 Jul 2009 21:27:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org>
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122727>

As a general guideline, functions in git's code return zero to indicate
success and negative values to indicate failure. The run_command family of
functions followed this guideline. But there are actually two different
kinds of failure:

- failures of system calls;

- non-zero exit code of the program that was run.

Usually, a non-zero exit code of the program is a failure and means a
failure to the caller. Except that sometimes it does not. For example, the
exit code of merge programs (e.g. external merge drivers) conveys
information about how the merge failed, and not all exit calls are
actually failures.

Furthermore, the return value of run_command is sometimes used as exit
code by the caller.

This change arranges that the exit code of the program is returned as a
positive value, which can now be regarded as the "result" of the function.
System call failures continue to be reported as negative values.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-merge.c        |    2 +-
 builtin-receive-pack.c |    4 ++--
 convert.c              |    2 +-
 git.c                  |    4 ++--
 ll-merge.c             |    4 ----
 run-command.c          |    9 +--------
 run-command.h          |    1 -
 7 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index af9adab..96ecaf4 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -594,7 +594,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		discard_cache();
 		if (read_cache() < 0)
 			die("failed to read the cache");
-		return -ret;
+		return ret;
 	}
 }
 
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 6ec1d05..6235903 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -143,8 +143,8 @@ static int run_status(int code, const char *cmd_name)
 	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
 		return error("%s died strangely", cmd_name);
 	default:
-		error("%s exited with error code %d", cmd_name, -code);
-		return -code;
+		error("%s exited with error code %d", cmd_name, code);
+		return code;
 	}
 }
 
diff --git a/convert.c b/convert.c
index 1816e97..491e714 100644
--- a/convert.c
+++ b/convert.c
@@ -267,7 +267,7 @@ static int filter_buffer(int fd, void *data)
 
 	status = finish_command(&child_process);
 	if (status)
-		error("external filter %s failed %d", params->cmd, -status);
+		error("external filter %s failed %d", params->cmd, status);
 	return (write_err || status);
 }
 
diff --git a/git.c b/git.c
index f4d53f4..662f21e 100644
--- a/git.c
+++ b/git.c
@@ -418,9 +418,9 @@ static void execv_dashed_external(const char **argv)
 	 */
 	status = run_command_v_opt(argv, 0);
 	if (status != -ERR_RUN_COMMAND_EXEC) {
-		if (IS_RUN_COMMAND_ERR(status))
+		if (status < 0)
 			die("unable to run '%s'", argv[0]);
-		exit(-status);
+		exit(status);
 	}
 	errno = ENOENT; /* as if we called execvp */
 
diff --git a/ll-merge.c b/ll-merge.c
index a2c13c4..31c7457 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -192,10 +192,6 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 
 	args[2] = cmd.buf;
 	status = run_command_v_opt(args, 0);
-	if (status < -ERR_RUN_COMMAND_FORK)
-		; /* failure in run-command */
-	else
-		status = -status;
 	fd = open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
diff --git a/run-command.c b/run-command.c
index eb2efc3..a4e309e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -241,14 +241,7 @@ static int wait_or_whine(pid_t pid)
 		if (!WIFEXITED(status))
 			return -ERR_RUN_COMMAND_WAITPID_NOEXIT;
 		code = WEXITSTATUS(status);
-		switch (code) {
-		case 127:
-			return -ERR_RUN_COMMAND_EXEC;
-		case 0:
-			return 0;
-		default:
-			return -code;
-		}
+		return code == 127 ? -ERR_RUN_COMMAND_EXEC : code;
 	}
 }
 
diff --git a/run-command.h b/run-command.h
index e345502..0211e1d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -10,7 +10,6 @@ enum {
 	ERR_RUN_COMMAND_WAITPID_SIGNAL,
 	ERR_RUN_COMMAND_WAITPID_NOEXIT,
 };
-#define IS_RUN_COMMAND_ERR(x) (-(x) >= ERR_RUN_COMMAND_FORK)
 
 struct child_process {
 	const char **argv;
-- 
1.6.3.17.g1665f
