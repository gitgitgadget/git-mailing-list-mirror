Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEE61FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756873AbdDQWIt (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:49 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36516 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756804AbdDQWIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:44 -0400
Received: by mail-pf0-f177.google.com with SMTP id 194so32088519pfv.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bs3qzd1ZABg7oTH3un8yysoXhLT9G8Gb73n4dG2SWQY=;
        b=DRr+HvCP7MIViGVXGe0RZBhIBGaIKsdli+WN/FKECU/85nBvybCcho5PECPfVcJbd9
         UYtqHsl7hIOT1mdKJ3icpcgSkAGch4cosiU5aDt7eQH56mpIU0/nNutDQaBlr8kd2nND
         +tvMNsgF0dZRmf4EiEH+RC4iZC/SkbUfXFrDlSVLkIQJ4l418ZgdwIBPvxfcsMBElq1Q
         1ZmtFVzyt6wQjZDj9g+/sJAhNaBGeIbx89zoRnMH5oblowaaF64+8ZVTXOByb7iV0Ca9
         zpwQ0ctKjMvDKN0SjEKQs1BaviZaVrl/UNyRFcfj205G7YpjwbFSppvP51FrfkdE3sAV
         8eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bs3qzd1ZABg7oTH3un8yysoXhLT9G8Gb73n4dG2SWQY=;
        b=TgZAp0/rn8aOwojOiQLCnDDwhAgRyUSSaL46wHroYBus6EQAPA9De8m7h8864Xq+fN
         2GH8Kb6RvBofGt92YlbfrSPQdF56xazNS3SFTAlt8oJTZUu1laZIwp+hwixJFhwqIjUL
         YvaDXIQ/0e6puBIFcdTcdfBINYqeRIx0y7mvZ4Tz09RINteTfqVBbsbo5B+raoaPWDaO
         0ewSExvsb0uyUL2qWhCcDxEAxcvMkUd6ygMQW9m68B2ytoKmvdbidQmRkfWXmI0iDn1N
         wB+cjQgnOcts9EW8+1uRQ0yz5BmpVQZOJ4hYzssENv70pe46JIpSyOxZqbiLO7dta62c
         80bw==
X-Gm-Message-State: AN3rC/75X0jI3Ow8YNDnXC7h4HNrIcjrlIk0L3ENaaajmDRtD5cauHQ9
        BKRy5tkOkac/R6IG
X-Received: by 10.98.196.154 with SMTP id h26mr13952445pfk.265.1492466923072;
        Mon, 17 Apr 2017 15:08:43 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:42 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 10/10] run-command: block signals between fork and execve
Date:   Mon, 17 Apr 2017 15:08:18 -0700
Message-Id: <20170417220818.44917-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
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
index c27c53bc5..c2d15310b 100644
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
@@ -421,6 +425,53 @@ static char **prep_childenv(const char *const *deltaenv)
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
@@ -544,6 +595,7 @@ int start_command(struct child_process *cmd)
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct child_err cerr;
+	struct atfork_state as;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -557,6 +609,7 @@ int start_command(struct child_process *cmd)
 
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
+	atfork_prepare(&as);
 
 	/*
 	 * NOTE: In order to prevent deadlocking when using threads special
@@ -570,6 +623,7 @@ int start_command(struct child_process *cmd)
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
+		int sig;
 		/*
 		 * Ensure the default die/error/warn routines do not get
 		 * called, they can take stdio locks and malloc.
@@ -618,6 +672,19 @@ int start_command(struct child_process *cmd)
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
@@ -637,6 +704,7 @@ int start_command(struct child_process *cmd)
 			child_die(CHILD_ERR_ERRNO);
 		}
 	}
+	atfork_parent(&as);
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-- 
2.12.2.762.g0e3151a226-goog

