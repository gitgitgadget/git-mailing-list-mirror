From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] run-command: add env_array, an optional argv_array for
 env
Date: Sun, 19 Oct 2014 13:13:55 +0200
Message-ID: <54439CF3.8070305@web.de>
References: <54390DC0.8060302@web.de> <20141012015321.GA15272@peff.net> <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?UTF-8?B?Tmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 13:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfoRP-0000TL-Mo
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 13:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbaJSLOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 07:14:22 -0400
Received: from mout.web.de ([212.227.15.3]:53247 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbaJSLOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 07:14:18 -0400
Received: from [192.168.178.27] ([79.253.132.15]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MQvxm-1XZr7A3r70-00UJUW; Sun, 19 Oct 2014 13:14:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Xe6beVOwKQYBfNrJ7/AOqBh1NDS8TamP+kzOV4HgiB5I5eOY6Ie
 JQLnrwfA2NvqBqxSoM6S2XXoOQanICx6d5VgNndgiLyrYEujb34rSDc2ycMDf8hxyCf0gbZ
 m6UFWIYI63QXBvFkFzBy0MxQp2rB4y5VSFqSTFeH5hZN8cHrxM2LPZYSRvimQesElA27iST
 zrXV3VnpkD/FfjshgApqQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to args, add a struct argv_array member to struct child_process
that simplifies specifying the environment for children.  It is freed
automatically by finish_command() or if start_command() encounters an
error.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-run-command.txt | 5 +++++
 run-command.c                               | 6 ++++++
 run-command.h                               | 3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 842b838..3f12fcd 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -169,6 +169,11 @@ string pointers (NULL terminated) in .env:
 . If the string does not contain '=', it names an environment
   variable that will be removed from the child process's environment.
 
+If the .env member is NULL, `start_command` will point it at the
+.env_array `argv_array` (so you may use one or the other, but not both).
+The memory in .env_array will be cleaned up automatically during
+`finish_command` (or during `start_command` when it is unsuccessful).
+
 To specify a new initial working directory for the sub-process,
 specify it in the .dir member.
 
diff --git a/run-command.c b/run-command.c
index 761f0fd..46be513 100644
--- a/run-command.c
+++ b/run-command.c
@@ -12,6 +12,7 @@ void child_process_init(struct child_process *child)
 {
 	memset(child, 0, sizeof(*child));
 	argv_array_init(&child->args);
+	argv_array_init(&child->env_array);
 }
 
 struct child_to_clean {
@@ -287,6 +288,8 @@ int start_command(struct child_process *cmd)
 
 	if (!cmd->argv)
 		cmd->argv = cmd->args.argv;
+	if (!cmd->env)
+		cmd->env = cmd->env_array.argv;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
@@ -338,6 +341,7 @@ fail_pipe:
 			error("cannot create %s pipe for %s: %s",
 				str, cmd->argv[0], strerror(failed_errno));
 			argv_array_clear(&cmd->args);
+			argv_array_clear(&cmd->env_array);
 			errno = failed_errno;
 			return -1;
 		}
@@ -524,6 +528,7 @@ fail_pipe:
 		else if (cmd->err)
 			close(cmd->err);
 		argv_array_clear(&cmd->args);
+		argv_array_clear(&cmd->env_array);
 		errno = failed_errno;
 		return -1;
 	}
@@ -550,6 +555,7 @@ int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
 	argv_array_clear(&cmd->args);
+	argv_array_clear(&cmd->env_array);
 	return ret;
 }
 
diff --git a/run-command.h b/run-command.h
index 1b135d1..2137315 100644
--- a/run-command.h
+++ b/run-command.h
@@ -10,6 +10,7 @@
 struct child_process {
 	const char **argv;
 	struct argv_array args;
+	struct argv_array env_array;
 	pid_t pid;
 	/*
 	 * Using .in, .out, .err:
@@ -44,7 +45,7 @@ struct child_process {
 	unsigned clean_on_exit:1;
 };
 
-#define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT }
+#define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
 void child_process_init(struct child_process *);
 
 int start_command(struct child_process *);
-- 
2.1.2
