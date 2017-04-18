Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992F8207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757930AbdDRXSV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:21 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34641 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbdDRXSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:16 -0400
Received: by mail-pg0-f47.google.com with SMTP id s64so3363576pgb.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8RqJPy+hZPui+9Ow/bgZhIr+NzSPBhOXmrbt9YU8SSM=;
        b=Sr9WeWVSw+XIkln8uDR0yblYEy8yPzcF/Ou4Bc2gY7xqtwyc4jfVNQ6tT/XvKr8c11
         yubLQQvBvTEWtZgxuvituTFY8wPfrPk16nMwJHK0dWygAxlK7nu5fJ1YercYTEvFyf7a
         NYBW0zfR6jpG6B/JuUa+3TuK+CChy55q+1Yp0kNeN5LTNyR7z5GNZyWGF1C1Ts7sfuap
         7CxEnJvuJyDMncIQ2dCB/ckQXm3l6L14LXGbs/6TLpOr480s5wfiifYCoyQxNTYUDrdf
         YJ8gpcYAU5n92P22I9rUQwcdi9NSFvzXnmi9ncKhjLWrNZNizPns6ceeErNEnDod89zZ
         Q6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8RqJPy+hZPui+9Ow/bgZhIr+NzSPBhOXmrbt9YU8SSM=;
        b=SuMHnGqGVBx7xIZNYUufya6YGmTyitH4KlK13PhBpjrDcmVvveV2HnwniSk556Sjhg
         fHvsOLYCvxo3qRQvt4BOghi8CdBLA7zHvowKi1NnnfrG4zBhxrTKGmPyN2UNObeaVKzO
         R805PY8WRNUp0SRL26RXRN+hk+hA8A0FBx6L4+TAmfOsHN36aee/LbLfxKpF2z5vd8zF
         UYS7IqVAjOyyjiDnPwp5QsRxXhvujiEBpCh1obGf9PcXQUMCzYuaYw1P2nDeWewlemgT
         WxDJ1934TevbVW5pyZcz0HZsXo0p8+0NTzuZJyaTufGygMmf6I8Wbc+YpDQYcH6yUTvB
         b6pQ==
X-Gm-Message-State: AN3rC/47u5SYo3zgn39w0CNTcJapNVJJ03zRXbvfXwktQU6CIgxA8hJE
        TTK9jnUlTAP4voiY
X-Received: by 10.98.69.74 with SMTP id s71mr911675pfa.232.1492557495432;
        Tue, 18 Apr 2017 16:18:15 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:14 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 03/11] run-command: prepare command before forking
Date:   Tue, 18 Apr 2017 16:17:57 -0700
Message-Id: <20170418231805.61835-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
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

