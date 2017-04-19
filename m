Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919441FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938370AbdDSXN5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:13:57 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33149 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940293AbdDSXNx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:13:53 -0400
Received: by mail-io0-f175.google.com with SMTP id k87so42190060ioi.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8RqJPy+hZPui+9Ow/bgZhIr+NzSPBhOXmrbt9YU8SSM=;
        b=CoXuSnHLWJ+2GKhbkOb6F8myWyJ5k1pzI9Q0SydI7o53XPlqfr0DK1Wtng0Sdoi3UG
         bto7+oJ5uO2h6NQLDG2oVWcMS0KoZP7cRBtAc7H8SgOemwxBRmsKKfswUQ8TQorcdj+X
         7fAK8gJ3zqMJfq4HM8AwCheWsqSKNEi0PfYEqLVeS5PlxQ+zcNwz7Bvpm+2r6xbMg1Cc
         PAkRvUWZuf2Zm0UKP1dgPkYPzRHwzE5YcmH6S4A3pRY/K0iTY0p6Bzgf+qPT5pzvLrpU
         2JctxvQOtLiPxnXfMNsK0TL2fotjxZnzWZW3F7lkOBs5cMLkaU5jp1UUpxlbiAizAcQr
         rjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8RqJPy+hZPui+9Ow/bgZhIr+NzSPBhOXmrbt9YU8SSM=;
        b=AVV9ZSW2GoRinKitZhbgtHhX8xHjQo2s+540i2k2EhDGFzJgMP3t7qHSW7567Cs3O8
         EsUOpSSgErevruEZeQI3Nlb7vyuXDqKjCJNw2akzSbujAnb+V1sd7PQe2Gj0Qjhw3z3B
         FjR9zNp55hnUNvaEcywAapW+kOHN8Q7Uj3h8NE561f4lIDpmXaz2oE1ftHQycSAGDBKx
         r+3DZ6V/C29pSp8P8SgWhrQ+w/YDdQ8GpM4pAhQj854eEQAjIfrWqY5Kwbh0+aUNt+VP
         rPt50TEyOhu2qqF2MDSbw3nf2Tykf2NkJfEjGXqQ2A8XN7YHvb/WqTgofV//FLhSohLY
         doNQ==
X-Gm-Message-State: AN3rC/72Xxf81UvCYa8QeY/YY4VzBOgq+QtH+iHfXtQsh7dwmI1OCYU+
        nuq2v3TuoHPkNbfz
X-Received: by 10.98.153.216 with SMTP id t85mr5306242pfk.178.1492643619332;
        Wed, 19 Apr 2017 16:13:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 03/11] run-command: prepare command before forking
Date:   Wed, 19 Apr 2017 16:13:19 -0700
Message-Id: <20170419231327.49895-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170419231327.49895-1-bmwill@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to [1] we need to only call async-signal-safe operations between fork
and exec.  Using malloc to build the argv array isn't async-signal-safe.

In order to avoid allocation between 'fork()' and 'exec()' prepare the
argv array used in the exec call prior to forking the process.

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/fork.html

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/run-command.c b/run-command.c
index 574b81d3e..d8d143795 100644
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
@@ -244,6 +232,21 @@ static void notify_parent(void)
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
+}
 #endif
 
 static inline void set_cloexec(int fd)
@@ -372,9 +375,13 @@ int start_command(struct child_process *cmd)
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
@@ -437,12 +444,9 @@ int start_command(struct child_process *cmd)
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
+		sane_execvp(argv.argv[0], (char *const *) argv.argv);
+
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
 				error("cannot run %s: %s", cmd->argv[0],
@@ -458,7 +462,7 @@ int start_command(struct child_process *cmd)
 		mark_child_for_cleanup(cmd->pid, cmd);
 
 	/*
-	 * Wait for child's execvp. If the execvp succeeds (or if fork()
+	 * Wait for child's exec. If the exec succeeds (or if fork()
 	 * failed), EOF is seen immediately by the parent. Otherwise, the
 	 * child process sends a single byte.
 	 * Note that use of this infrastructure is completely advisory,
@@ -467,7 +471,7 @@ int start_command(struct child_process *cmd)
 	close(notify_pipe[1]);
 	if (read(notify_pipe[0], &notify_pipe[1], 1) == 1) {
 		/*
-		 * At this point we know that fork() succeeded, but execvp()
+		 * At this point we know that fork() succeeded, but exec()
 		 * failed. Errors have been reported to our stderr.
 		 */
 		wait_or_whine(cmd->pid, cmd->argv[0], 0);
@@ -475,6 +479,8 @@ int start_command(struct child_process *cmd)
 		cmd->pid = -1;
 	}
 	close(notify_pipe[0]);
+
+	argv_array_clear(&argv);
 }
 #else
 {
-- 
2.12.2.816.g2cccc81164-goog

