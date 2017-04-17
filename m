Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6C41FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756806AbdDQWIo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:44 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33321 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbdDQWIk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:40 -0400
Received: by mail-pg0-f49.google.com with SMTP id 63so17801326pgh.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VdwKmb2KR9OQvD6wzkWRUkWQARzDcYJbymEl6pJEQ4M=;
        b=NPsrzkgcVD0VWFOyc5hRz71H+wLVV09IRp4XQza0EPKjXvTu23+NzIiwUjLbKfM1iq
         pxazJSL9K6gu/1tIunOcGaMLYoP/zIkFyE7A+2BzZMgh6zSo6oTYN8q0jatGwduMJ4cH
         ifqIUcsI4Bmsytp0bM+0QJ74jtke3BZTFB+MQOT4mrvMhP+RRKBJnGINT2AVtNxfzY+1
         7vbiEuxE5pwkhgrOMA+d+rnnUIlZQk4B2Q1MXQ+a4ij+XYE9FBhPMTPhRUoGx6AgxVv2
         Yw+z8+zT6/Sd1mu0kNCwnB+rP4yrz9um1FkWf4jqnkntjqWwBoUSbeA1Tae+EHhCE3gM
         nEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VdwKmb2KR9OQvD6wzkWRUkWQARzDcYJbymEl6pJEQ4M=;
        b=IlUdBOAFXTBKXNm/csbdweQc2YnxIqEsNCmyKaJkH6J+FVjdrtn5FT6xgp83XIrg9E
         WlJA6q9DqEyEJyGh7JUNylrFcLas5J85vUleDVkXxBr8C/tbw6GV+GC6AUwtarWIVtq1
         TXPK5VICzxbJM/Co+Iwwueoa340cdyJiHmKLDrZ6VIqaoqMuybyNqzEFEokMYy9m3I2j
         4Mp6Ub+vOWOslRsCUYVKXK5VtuTLon1yG4NbjReZw+MSwsBtLLhn059bGlfN/fYC382G
         YNT0NlNJOreMfyjb6TMbEHA8dUidbg9LYgiHcr0xH5Xl3fp2vG3QCVaHmYsmpbUMBJ/6
         S10g==
X-Gm-Message-State: AN3rC/6SZDQ/MPd/Z8UJIh5DZXx2wi0Hvf3L8jvRoyfWHiPHcXXzI5iZ
        v4fTTeZL0AK0W9Bj
X-Received: by 10.98.93.25 with SMTP id r25mr11766803pfb.103.1492466918781;
        Mon, 17 Apr 2017 15:08:38 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:37 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 07/10] run-command: eliminate calls to error handling functions in child
Date:   Mon, 17 Apr 2017 15:08:15 -0700
Message-Id: <20170417220818.44917-8-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of our standard error handling paths have the potential to
call malloc or take stdio locks; so we must avoid them inside
the forked child.

Instead, the child only writes an 8 byte struct atomically to
the parent through the notification pipe to propagate an error.
All user-visible error reporting happens from the parent;
even avoiding functions like atexit(3) and exit(3).

Helped-by: Eric Wong <e@80x24.org>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 121 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 32 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3aa8b7112..e1e8780ca 100644
--- a/run-command.c
+++ b/run-command.c
@@ -211,14 +211,82 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 #ifndef GIT_WINDOWS_NATIVE
 static int child_notifier = -1;
 
-static void notify_parent(void)
+enum child_errcode {
+	CHILD_ERR_CHDIR,
+	CHILD_ERR_ENOENT,
+	CHILD_ERR_SILENT,
+	CHILD_ERR_ERRNO
+};
+
+struct child_err {
+	enum child_errcode err;
+	int syserr; /* errno */
+};
+
+static void child_die(enum child_errcode err)
 {
-	/*
-	 * execvp failed.  If possible, we'd like to let start_command
-	 * know, so failures like ENOENT can be handled right away; but
-	 * otherwise, finish_command will still report the error.
-	 */
-	xwrite(child_notifier, "", 1);
+	struct child_err buf;
+
+	buf.err = err;
+	buf.syserr = errno;
+
+	/* write(2) on buf smaller than PIPE_BUF (min 512) is atomic: */
+	xwrite(child_notifier, &buf, sizeof(buf));
+	_exit(1);
+}
+
+/*
+ * parent will make it look like the child spewed a fatal error and died
+ * this is needed to prevent changes to t0061.
+ */
+static void fake_fatal(const char *err, va_list params)
+{
+	vreportf("fatal: ", err, params);
+}
+
+static void child_error_fn(const char *err, va_list params)
+{
+	const char msg[] = "error() should not be called in child\n";
+	xwrite(2, msg, sizeof(msg) - 1);
+}
+
+static void child_warn_fn(const char *err, va_list params)
+{
+	const char msg[] = "warn() should not be called in child\n";
+	xwrite(2, msg, sizeof(msg) - 1);
+}
+
+static void NORETURN child_die_fn(const char *err, va_list params)
+{
+	const char msg[] = "die() should not be called in child\n";
+	xwrite(2, msg, sizeof(msg) - 1);
+	_exit(2);
+}
+
+/* this runs in the parent process */
+static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
+{
+	static void (*old_errfn)(const char *err, va_list params);
+
+	old_errfn = get_error_routine();
+	set_error_routine(fake_fatal);
+	errno = cerr->syserr;
+
+	switch (cerr->err) {
+	case CHILD_ERR_CHDIR:
+		error_errno("exec '%s': cd to '%s' failed",
+			    cmd->argv[0], cmd->dir);
+		break;
+	case CHILD_ERR_ENOENT:
+		error_errno("cannot run %s", cmd->argv[0]);
+		break;
+	case CHILD_ERR_SILENT:
+		break;
+	case CHILD_ERR_ERRNO:
+		error_errno("cannot exec '%s'", cmd->argv[0]);
+		break;
+	}
+	set_error_routine(old_errfn);
 }
 
 static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
@@ -362,13 +430,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 		code += 128;
 	} else if (WIFEXITED(status)) {
 		code = WEXITSTATUS(status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (code == 127) {
-			code = -1;
-			failed_errno = ENOENT;
-		}
 	} else {
 		error("waitpid is confused (%s)", argv0);
 	}
@@ -456,6 +517,7 @@ int start_command(struct child_process *cmd)
 	int null_fd = -1;
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct child_err cerr;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -474,20 +536,16 @@ int start_command(struct child_process *cmd)
 	failed_errno = errno;
 	if (!cmd->pid) {
 		/*
-		 * Redirect the channel to write syscall error messages to
-		 * before redirecting the process's stderr so that all die()
-		 * in subsequent call paths use the parent's stderr.
+		 * Ensure the default die/error/warn routines do not get
+		 * called, they can take stdio locks and malloc.
 		 */
-		if (cmd->no_stderr || need_err) {
-			int child_err = dup(2);
-			set_cloexec(child_err);
-			set_error_handle(fdopen(child_err, "w"));
-		}
+		set_die_routine(child_die_fn);
+		set_error_routine(child_error_fn);
+		set_warn_routine(child_warn_fn);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
 		child_notifier = notify_pipe[1];
-		atexit(notify_parent);
 
 		if (cmd->no_stdin)
 			dup2(null_fd, 0);
@@ -522,8 +580,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->dir && chdir(cmd->dir))
-			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
-			    cmd->dir);
+			child_die(CHILD_ERR_CHDIR);
 
 		/*
 		 * Attempt to exec using the command and arguments starting at
@@ -538,12 +595,11 @@ int start_command(struct child_process *cmd)
 			       (char *const *) childenv);
 
 		if (errno == ENOENT) {
-			if (!cmd->silent_exec_failure)
-				error("cannot run %s: %s", cmd->argv[0],
-					strerror(ENOENT));
-			exit(127);
+			if (cmd->silent_exec_failure)
+				child_die(CHILD_ERR_SILENT);
+			child_die(CHILD_ERR_ENOENT);
 		} else {
-			die_errno("cannot exec '%s'", cmd->argv[0]);
+			child_die(CHILD_ERR_ERRNO);
 		}
 	}
 	if (cmd->pid < 0)
@@ -554,17 +610,18 @@ int start_command(struct child_process *cmd)
 	/*
 	 * Wait for child's exec. If the exec succeeds (or if fork()
 	 * failed), EOF is seen immediately by the parent. Otherwise, the
-	 * child process sends a single byte.
+	 * child process sends a child_err struct.
 	 * Note that use of this infrastructure is completely advisory,
 	 * therefore, we keep error checks minimal.
 	 */
 	close(notify_pipe[1]);
-	if (read(notify_pipe[0], &notify_pipe[1], 1) == 1) {
+	if (xread(notify_pipe[0], &cerr, sizeof(cerr)) == sizeof(cerr)) {
 		/*
 		 * At this point we know that fork() succeeded, but exec()
 		 * failed. Errors have been reported to our stderr.
 		 */
 		wait_or_whine(cmd->pid, cmd->argv[0], 0);
+		child_err_spew(cmd, &cerr);
 		failed_errno = errno;
 		cmd->pid = -1;
 	}
-- 
2.12.2.762.g0e3151a226-goog

