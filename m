Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2700420960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755510AbdDMSdV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:33:21 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36218 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755667AbdDMSdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:33:15 -0400
Received: by mail-pf0-f180.google.com with SMTP id o126so32061406pfb.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dyT4GXrCBfJ4OmkEnS5fTbyc07J4vqx5lmgVcIirqLg=;
        b=MP3qDfuZqUkfabQPI5hDyrWEtF1iSkhmzH/GWskJ7x9K1HFwvMjIcw3q1eRXbiHU+X
         ixeJwDIaQtbmoUx11+tTRFmjXXe79H8YAB1QekndejyceN4Iz+nXC+QlLlAnLIm62tgd
         ZpwXaK3k7vhy7hrSlw/7QzIF8xNLbuhcNrZ5EBmdarusX/gcWlPOmQjXHF5ek4zCNxIM
         e+1l/2NQOOq4HNhd9qngQsRwTnKINGumbNALXhr2XvSyBgS99TQvb4ofRnDYUdRQRfCP
         Ww5ZFKJwNfP4liz8GUunsCg4C7X4Nmh5olm5Znpb15wIlbHyuQ21jgI5vMkB6nCOMIJ4
         VNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dyT4GXrCBfJ4OmkEnS5fTbyc07J4vqx5lmgVcIirqLg=;
        b=juU3uvmRN52onhO3bLT6WqQ2NZAoO+niOKbTVpyA9wIKvw3bZfmm+oirITqrv7Tvk3
         kZ0fVx3DA8U0/8MK9tx/eW7sV7gZILgKrsAG2vH8k56R8oAqbsC/EjUE3Q+gXXEw2G31
         lX9GyKT6X9mmOZCmCbr+r/QyOv2C4EVGSXV4ceDaQQSGu/7c3gMxtjUaYWynLv0v9ELe
         6Ng0CwfYZgzMs1fUIcUfy6IN2osDvZfim6YtIMdl1aMB4d4J3ikK+OS0VekTKBlYIRAm
         YhjA5jNSuIoIgs96IJ1S7GtbpwGvdw1dDl0wm+XrvZKwIxZ5tl8kvjYqjGqHgi5cUl0Z
         AhYw==
X-Gm-Message-State: AN3rC/6SIwrEasGPINufYbQ5zxW8N+rAVBYkm1n0VkHv9xql5I75ikmq
        IOfC4zWEVDSMDs2N
X-Received: by 10.99.174.69 with SMTP id e5mr3111306pgp.161.1492108388643;
        Thu, 13 Apr 2017 11:33:08 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 201sm43764654pfc.126.2017.04.13.11.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:33:07 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v2 5/6] run-command: eliminate calls to error handling functions in child
Date:   Thu, 13 Apr 2017 11:32:51 -0700
Message-Id: <20170413183252.4713-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
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
index 6751b8319..4230c4933 100644
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
+	CHILD_ERR_ERRNO,
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
@@ -355,13 +423,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
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
@@ -449,6 +510,7 @@ int start_command(struct child_process *cmd)
 	int null_fd = -1;
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct child_err cerr;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -467,20 +529,16 @@ int start_command(struct child_process *cmd)
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
@@ -515,19 +573,17 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->dir && chdir(cmd->dir))
-			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
-			    cmd->dir);
+			child_die(CHILD_ERR_CHDIR);
 
 		execve(argv.argv[0], (char *const *) argv.argv,
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
@@ -538,17 +594,18 @@ int start_command(struct child_process *cmd)
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

