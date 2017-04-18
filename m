Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66503207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758089AbdDRXSf (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:35 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33147 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757695AbdDRXS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id a188so3421475pfa.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3/vsuCtII62oQVUvF9oxddpx1fkjNIe5U4p1l1gQrE=;
        b=nYyOhkZYEz3Pkf540J8wtTVMfT+rJpHW5GdbetSNxmFVj6xfuTUerQDP5H8F0zm0As
         jB65wbsd2Z1uF6rxtz1CANypSjoSE9AhUBSxsiX7vJsYyuPet9wiA1pfBBukMffmakKN
         hx62SJ55gG+ciT+kpBKuzhyiSDiEbvR7WSIAiQZipcgvbhqHh1ztaarQkgrMyatMmJSd
         Eta53wGnpxxFh7U8tzI2oLMEBTVaG9Ny9Z3keEqJqU+6ZMQuXfcKfpjTzDoV59r6jl9G
         BIHvUPVnLVA5p6B4cgVgfcSMzOPLNZ40O3G3sWVMQ7MZqtGCgc3+gMq6vHXUaFqaVDYy
         ER9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3/vsuCtII62oQVUvF9oxddpx1fkjNIe5U4p1l1gQrE=;
        b=Yg+i8l26AFYAGQwkPrgyiF53xuijvJF5GuA613VojZV3lvzENcAkafIdErLiZG2jpM
         5Lasr52YrbWZq3IGkotBcBJapqRjeeTk6xXRuSYzD7qcxeyAGJsLdCIA8smYcT9Wz51V
         UbIPxdFSCPjNeIBYrUbaumSrEG5TOhMBl1sUlHfmZjb1B+lPvIlfw8m/0TkF9Spp1LxL
         JhK2rhABy6Hg/1ADZzfm9fApN51Vlxq0qZDaO8YYVvP0qbVtuAb57FJ3Fdc/4RgPvaEi
         l1v1N5fiWQ+r780iSo6hT7PVYTFJFk5S/29WMcwXLhsFTVcCdQ+HEMm7jL8p4r7qGgBz
         eQuw==
X-Gm-Message-State: AN3rC/7WCuIpU8o7GIrCpMBtvHDKlZpx6bzwlZx2hv+r29rk9m3S7maR
        DO1AyfejyW6rnaqr
X-Received: by 10.84.143.195 with SMTP id 61mr26307647plz.158.1492557503304;
        Tue, 18 Apr 2017 16:18:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 08/11] run-command: eliminate calls to error handling functions in child
Date:   Tue, 18 Apr 2017 16:18:02 -0700
Message-Id: <20170418231805.61835-9-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
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
index b3a35dd82..1f15714b1 100644
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
@@ -341,13 +409,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
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
@@ -435,6 +496,7 @@ int start_command(struct child_process *cmd)
 	int null_fd = -1;
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct child_err cerr;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -453,20 +515,16 @@ int start_command(struct child_process *cmd)
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
@@ -501,8 +559,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->dir && chdir(cmd->dir))
-			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
-			    cmd->dir);
+			child_die(CHILD_ERR_CHDIR);
 
 		/*
 		 * Attempt to exec using the command and arguments starting at
@@ -517,12 +574,11 @@ int start_command(struct child_process *cmd)
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
@@ -533,17 +589,18 @@ int start_command(struct child_process *cmd)
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
2.12.2.816.g2cccc81164-goog

