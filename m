Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA5D20970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbdDNQ7U (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:20 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35791 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbdDNQ7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:15 -0400
Received: by mail-pg0-f47.google.com with SMTP id 72so37217867pge.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yUcQbVw7LALwG6lB/qa6GrCzpPAKTStqsCyemtGxTEg=;
        b=VFwNTTe547n1sEZGZ4I89FIAehF66pCNovbGfJJAQiF1IUtt/2Z+yXCTjZ3FxZlJ0j
         MzdVlds/eX5sTOyU3brj05sq/wRl/zI4cBVCavLCU8WwPVjfX4QQK7jcsSfr45lCgS9T
         RZCIb+iIhKx7233vmoGGe2Eb33V9erLh6O7e41V5o3eTvKnOLf3f7LL/CtiFPI1jjj5g
         pS2shilOxXkrLT4528tMRQsZci1Ss0L90ph59oZm0mNKWoHBszqIHAIbq5noNFuUSuBv
         g/KGQTto/xh0pLmGla8wXqj2MpgzAsSJMOr4opnDBdie3cZ2t1Kcm054L/Jgf+KYGiz2
         m/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yUcQbVw7LALwG6lB/qa6GrCzpPAKTStqsCyemtGxTEg=;
        b=FHD8yx97C2UCCaHMVTFcB9UVd/fAJZ1YAPKHjH6ykMnda9AtxqPWTWTUd+Dg8EMCDy
         Bw7J7fduIsQsJIn4Aws9+frhDbVIrnnFdA5V3JPiJPiwGOP/4jvAlzf/8QQD8ugCR7hD
         0CVPPHbHocHOMV8yKTB+UFLpa0XsN6+0acJ29OosJuKxdNtw4Nl3+pnjUhvBBUoevPH6
         EetsLNIn294teOGFeLZVReO7Hh/Sn4PiaO1QFUNo+ot/gBOv65fLYZtMY+cjCp03I+ON
         PKCqJ4nzCm6/8kIIQxpunAY4XCpCf6hTRpzwfYJOcHTjnChol3nMYmBOo8Jzp9GD+MNC
         P5vA==
X-Gm-Message-State: AN3rC/73aTjGHdWBmMT3pYE4Gbsn1i58bNR8W8Q1oJ+sqStp2jPJdX7Q
        bpiVL+a3iZ13M9Gf
X-Received: by 10.99.36.194 with SMTP id k185mr7974764pgk.201.1492189154369;
        Fri, 14 Apr 2017 09:59:14 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 03/10] run-command: prepare command before forking
Date:   Fri, 14 Apr 2017 09:58:55 -0700
Message-Id: <20170414165902.174167-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
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
2.12.2.762.g0e3151a226-goog

