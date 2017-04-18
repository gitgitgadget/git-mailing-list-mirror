Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B949A207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758136AbdDRXSn (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:43 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33205 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757970AbdDRXSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:33 -0400
Received: by mail-pg0-f49.google.com with SMTP id 63so3628955pgh.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ArW/bnsroQS5acAe7nf+tOwm7zpQNUzBhLgyEgM10cE=;
        b=nGBDrn4gKPx9TyyVVf20CvekKfplMq7aKHswuHWMEVDFzEe+wf3ZjJGjG8FBEsvC3A
         q/uUSYPBNEckA84e3Whp0bGGJQoSfqTAMkiauCtQCI3WdNcyyPk96/JL1YjiXvenOcIS
         NsaIlKCUr4ShBKsK5Hh3nSezO98OC4q/k+KKa6R3oqC4yj1JilYrIxHKyKSzQ4V7n9gw
         T95svcqbZ7AA5EV/2UD5Q6ilv6ynW4hYcW+dyKhZfqHmskYCIcMop/y7bIE/fWcWI4yv
         2mS/CSwNIT5AWSYLIE9c8Q3jiwdCALdIL4qAUcLon4fssXOFWtNalT8LNgUiviDqyO11
         XItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ArW/bnsroQS5acAe7nf+tOwm7zpQNUzBhLgyEgM10cE=;
        b=rs+k/Xdetwj+qJKDB0V977snTYoX3LveCgGiWUoqwuZCmzUgQI7qo3sBS8R4LZIGH/
         UFNlTCoe8fGVEwd8a7i49+umgut1qCzMEGD1MGTtDV9eTmHIJXAPENmP51GuxtA67bFY
         mm29uvuFulRtrf90iMwJtIMfIR+tqGyPrDdp4yOkVln7dyXLbtXpmiiiWvQn8JSStHNc
         +DtCM7xszXgKBif+2HGqDCxM7lv/Jlxhte0uQE2nFLfSHexzvcDm//qypShFl4NXcyou
         G5TFIVLwUDc4AwSo0KP3uqtosEu14s6ZT94PR2NiOrrrU5AO2IksI3DcVx51BHaw1WlB
         ClbA==
X-Gm-Message-State: AN3rC/7tk4mL3RMsv7kEiTs1FtenfztGTB+gMhDLIqxSs3IGkkwiiauo
        /vsgkJjiL3r9+mc2
X-Received: by 10.99.231.17 with SMTP id b17mr20497620pgi.55.1492557507793;
        Tue, 18 Apr 2017 16:18:27 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 11/11] run-command: block signals between fork and execve
Date:   Tue, 18 Apr 2017 16:18:05 -0700
Message-Id: <20170418231805.61835-12-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Wong <e@80x24.org>

Signal handlers of the parent firing in the forked child may
have unintended side effects.  Rather than auditing every signal
handler we have and will ever have, block signals while forking
and restore default signal handlers in the child before execve.

Restoring default signal handlers is required because
execve does not unblock signals, it only restores default
signal handlers.  So we must restore them with sigprocmask
before execve, leaving a window when signal handlers
we control can fire in the child.  Continue ignoring
ignored signals, but reset the rest to defaults.

Similarly, disable pthread cancellation to future-proof our code
in case we start using cancellation; as cancellation is
implemented with signals in glibc.

Signed-off-by: Eric Wong <e@80x24.org>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/run-command.c b/run-command.c
index df1edd963..1f3c38e43 100644
--- a/run-command.c
+++ b/run-command.c
@@ -215,6 +215,7 @@ enum child_errcode {
 	CHILD_ERR_CHDIR,
 	CHILD_ERR_DUP2,
 	CHILD_ERR_CLOSE,
+	CHILD_ERR_SIGPROCMASK,
 	CHILD_ERR_ENOENT,
 	CHILD_ERR_SILENT,
 	CHILD_ERR_ERRNO
@@ -303,6 +304,9 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 	case CHILD_ERR_CLOSE:
 		error_errno("close() in child failed");
 		break;
+	case CHILD_ERR_SIGPROCMASK:
+		error_errno("sigprocmask failed restoring signals");
+		break;
 	case CHILD_ERR_ENOENT:
 		error_errno("cannot run %s", cmd->argv[0]);
 		break;
@@ -400,6 +404,53 @@ static char **prep_childenv(const char *const *deltaenv)
 }
 #endif
 
+struct atfork_state {
+#ifndef NO_PTHREADS
+	int cs;
+#endif
+	sigset_t old;
+};
+
+#ifndef NO_PTHREADS
+static void bug_die(int err, const char *msg)
+{
+	if (err) {
+		errno = err;
+		die_errno("BUG: %s", msg);
+	}
+}
+#endif
+
+static void atfork_prepare(struct atfork_state *as)
+{
+	sigset_t all;
+
+	if (sigfillset(&all))
+		die_errno("sigfillset");
+#ifdef NO_PTHREADS
+	if (sigprocmask(SIG_SETMASK, &all, &as->old))
+		die_errno("sigprocmask");
+#else
+	bug_die(pthread_sigmask(SIG_SETMASK, &all, &as->old),
+		"blocking all signals");
+	bug_die(pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &as->cs),
+		"disabling cancellation");
+#endif
+}
+
+static void atfork_parent(struct atfork_state *as)
+{
+#ifdef NO_PTHREADS
+	if (sigprocmask(SIG_SETMASK, &as->old, NULL))
+		die_errno("sigprocmask");
+#else
+	bug_die(pthread_setcancelstate(as->cs, NULL),
+		"re-enabling cancellation");
+	bug_die(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
+		"restoring signal mask");
+#endif
+}
+
 static inline void set_cloexec(int fd)
 {
 	int flags = fcntl(fd, F_GETFD);
@@ -523,6 +574,7 @@ int start_command(struct child_process *cmd)
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct child_err cerr;
+	struct atfork_state as;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -536,6 +588,7 @@ int start_command(struct child_process *cmd)
 
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
+	atfork_prepare(&as);
 
 	/*
 	 * NOTE: In order to prevent deadlocking when using threads special
@@ -549,6 +602,7 @@ int start_command(struct child_process *cmd)
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
+		int sig;
 		/*
 		 * Ensure the default die/error/warn routines do not get
 		 * called, they can take stdio locks and malloc.
@@ -597,6 +651,19 @@ int start_command(struct child_process *cmd)
 			child_die(CHILD_ERR_CHDIR);
 
 		/*
+		 * restore default signal handlers here, in case
+		 * we catch a signal right before execve below
+		 */
+		for (sig = 1; sig < NSIG; sig++) {
+			/* ignored signals get reset to SIG_DFL on execve */
+			if (signal(sig, SIG_DFL) == SIG_IGN)
+				signal(sig, SIG_IGN);
+		}
+
+		if (sigprocmask(SIG_SETMASK, &as.old, NULL) != 0)
+			child_die(CHILD_ERR_SIGPROCMASK);
+
+		/*
 		 * Attempt to exec using the command and arguments starting at
 		 * argv.argv[1].  argv.argv[0] contains SHELL_PATH which will
 		 * be used in the event exec failed with ENOEXEC at which point
@@ -616,6 +683,7 @@ int start_command(struct child_process *cmd)
 			child_die(CHILD_ERR_ERRNO);
 		}
 	}
+	atfork_parent(&as);
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-- 
2.12.2.816.g2cccc81164-goog

