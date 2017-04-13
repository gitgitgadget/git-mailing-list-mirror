Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55D920960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755667AbdDMSdY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:33:24 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36057 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755349AbdDMSdO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:33:14 -0400
Received: by mail-pg0-f44.google.com with SMTP id g2so34005269pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+2KDZ2k5QPt+lrnNPvWXbKpuKwAiW5rcqj7t5WcqydE=;
        b=WfFE9U5P8f8Wc2YPD3K8QnLmPJBHmf0pZandGYN2BwENejgHrYXVQ3bfaClZ9/EzmY
         o3u48LSPAPggL0IsUD98nIbbt9M0XnoOYfggI5I9+9S0py7CcBDMtOvz6WZdbnmX69+4
         M7DZx8RcHzSIxkdE+RLl1WCpRpjTojAElrSe6UfjRfBEwitf5jV3Xa98+CX8tIAm3Hx2
         sFtAex+C4cB/2jHjz6UIsehob0HMCzjjiZ8Hx5hX4w/TZrGWR2YPRyUb9eYdy3g6OiRY
         nBLSe1n/Rvzttxsi8n6AfNXsS7XCQbjxL1A5RytDNWjV8E4zY1erGftL9SZSTsXQazlC
         ShYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+2KDZ2k5QPt+lrnNPvWXbKpuKwAiW5rcqj7t5WcqydE=;
        b=itwLSacoV0riBpt3xw/+xQnByoj04uN1jZepdcgNjn2+bOXIWkg9t4bhTvWz1wV257
         6NaT/zsdnM5zWTJfNLRBKwJc+4IhXuKCN1Z70flniSIHiN4a23jPYSfanRSWOdIYPrch
         5/oTdCRgKDx0PNMFWSlCRd74Tk1EzOIYvvpAKLpZQMU2HtVyj6IuXI30i02u/QupfRWJ
         WbHtF2dcT1GYMEAZZ6XPHQTwiH/eBsPLJurqtTTu8SXYmpOQ/lACi+eFKCB4sYlwkF+c
         cBRUR0DHpL+vAcxq5/tph2cMbjPcYI/FZWF6uiGMALTYElRQ0rsfG6WIGkTwEHNWA8pI
         YskA==
X-Gm-Message-State: AN3rC/54RPQGgaotxVXzsDiw2UF6CVV1vcB1SSMgFBVL2dyCicZkAsWK
        uq1wxuJRJVpZqWx4
X-Received: by 10.99.37.1 with SMTP id l1mr4325696pgl.86.1492108383900;
        Thu, 13 Apr 2017 11:33:03 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 201sm43764654pfc.126.2017.04.13.11.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:33:02 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v2 2/6] run-command: prepare command before forking
Date:   Thu, 13 Apr 2017 11:32:48 -0700
Message-Id: <20170413183252.4713-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid allocation between 'fork()' and 'exec()' the argv
array used in the exec call is prepared prior to forking the process.

In addition to this, the function used to exec is changed from
'execvp()' to 'execv()' as the (p) variant of exec has the potential to
call malloc during the path resolution it performs.  Instead we simply
do the path resolution ourselves during the preparation stage prior to
forking.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 60 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/run-command.c b/run-command.c
index 574b81d3e..9ee9fde97 100644
--- a/run-command.c
+++ b/run-command.c
@@ -221,18 +221,6 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 }
 
 #ifndef GIT_WINDOWS_NATIVE
-static int execv_shell_cmd(const char **argv)
-{
-	struct argv_array nargv = ARGV_ARRAY_INIT;
-	prepare_shell_cmd(&nargv, argv);
-	trace_argv_printf(nargv.argv, "trace: exec:");
-	sane_execvp(nargv.argv[0], (char **)nargv.argv);
-	argv_array_clear(&nargv);
-	return -1;
-}
-#endif
-
-#ifndef GIT_WINDOWS_NATIVE
 static int child_notifier = -1;
 
 static void notify_parent(void)
@@ -244,6 +232,35 @@ static void notify_parent(void)
 	 */
 	xwrite(child_notifier, "", 1);
 }
+
+static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
+{
+	if (!cmd->argv[0])
+		die("BUG: command is empty");
+
+	if (cmd->git_cmd) {
+		argv_array_push(out, "git");
+		argv_array_pushv(out, cmd->argv);
+	} else if (cmd->use_shell) {
+		prepare_shell_cmd(out, cmd->argv);
+	} else {
+		argv_array_pushv(out, cmd->argv);
+	}
+
+	/*
+	 * If there are no '/' characters in the command then perform a path
+	 * lookup and use the resolved path as the command to exec.  If there
+	 * are no '/' characters or if the command wasn't found in the path,
+	 * have exec attempt to invoke the command directly.
+	 */
+	if (!strchr(out->argv[0], '/')) {
+		char *program = locate_in_PATH(out->argv[0]);
+		if (program) {
+			free((char *)out->argv[0]);
+			out->argv[0] = program;
+		}
+	}
+}
 #endif
 
 static inline void set_cloexec(int fd)
@@ -372,9 +389,13 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	prepare_cmd(&argv, cmd);
+
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
@@ -437,12 +458,9 @@ int start_command(struct child_process *cmd)
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->git_cmd)
-			execv_git_cmd(cmd->argv);
-		else if (cmd->use_shell)
-			execv_shell_cmd(cmd->argv);
-		else
-			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
+
+		execv(argv.argv[0], (char *const *) argv.argv);
+
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
 				error("cannot run %s: %s", cmd->argv[0],
@@ -458,7 +476,7 @@ int start_command(struct child_process *cmd)
 		mark_child_for_cleanup(cmd->pid, cmd);
 
 	/*
-	 * Wait for child's execvp. If the execvp succeeds (or if fork()
+	 * Wait for child's exec. If the exec succeeds (or if fork()
 	 * failed), EOF is seen immediately by the parent. Otherwise, the
 	 * child process sends a single byte.
 	 * Note that use of this infrastructure is completely advisory,
@@ -467,7 +485,7 @@ int start_command(struct child_process *cmd)
 	close(notify_pipe[1]);
 	if (read(notify_pipe[0], &notify_pipe[1], 1) == 1) {
 		/*
-		 * At this point we know that fork() succeeded, but execvp()
+		 * At this point we know that fork() succeeded, but exec()
 		 * failed. Errors have been reported to our stderr.
 		 */
 		wait_or_whine(cmd->pid, cmd->argv[0], 0);
@@ -475,6 +493,8 @@ int start_command(struct child_process *cmd)
 		cmd->pid = -1;
 	}
 	close(notify_pipe[0]);
+
+	argv_array_clear(&argv);
 }
 #else
 {
-- 
2.12.2.762.g0e3151a226-goog

