Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B217B20970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbdDNQ7g (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:36 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36768 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbdDNQ7a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:30 -0400
Received: by mail-pg0-f47.google.com with SMTP id g2so45464358pge.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rz72JUYOMhvPQkrSKQuJU/trilGlwfHXTjZVUYTgvRY=;
        b=SZCDvDbNBLHuKGn0/dY7OeobGkTFt8SnFn1RmX+SMCy1d5l0kJDFxEthkklqrnLntK
         S1PQcmGvDFVl0esoHxuuCaa6Z4H8QaNY+J4o+olH+/yrvXybBBUXziT7hGJta3bnn7k+
         SWlCt1A4AXIrSeEQldeg891KYNwBCLVNiZyRb5cMLciMJRaDguUR2XIK6brmjBebX9g5
         ppKB1B+zRE/rJRRzOamGsl86JY0mQQCR5tiiQiXyPUV720/2Z9+IQETrkYwvJaMlJylx
         uNDEdoR2WZGSVX3Yi7qszZ69sI5fPfsFKDGmiBvJGKY7fczagmL1avp6nhG70GunJbJE
         aojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rz72JUYOMhvPQkrSKQuJU/trilGlwfHXTjZVUYTgvRY=;
        b=LO25nSR2MEVIoWGx9xnUnkeAldPj2690CFpLCl/L7TyH9k2I2aePJ+u4Jz6tSBRZY3
         ZThrLKW+ZgbnduYS0q2Q+L7B69gTBDfKPZwpfPCAavMUT7jxIaKtTHOuNyqsfvi0GwKf
         qqEIqs1lXf7MRZmOA0swNovrFibWhgEBvRwVtzHbPkr9K3JeKw268F4bW7ZSNYPIeQ/E
         4jjfqjPtTw5d8zUp0yT3kL5mzeHIxyFu7T4+aVYmHEkSpLjcWxgBwejoI98pDcZ0JqVQ
         pO7e660LTwl+8GXzLaCrstQu74b6H/0L/4MBM9Cd7onKrHlDYcxYMuq5yKDFRHfitR+/
         aaew==
X-Gm-Message-State: AN3rC/5LrdXWzoD1/2FHTjWcWILEkWHwMjVPkH1fD2S6bmCOtlKiVhTI
        RrTYNoGe0YM9eLVA
X-Received: by 10.98.69.141 with SMTP id n13mr7894409pfi.216.1492189164169;
        Fri, 14 Apr 2017 09:59:24 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:23 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 10/10] run-command: block signals between fork and execve
Date:   Fri, 14 Apr 2017 09:59:02 -0700
Message-Id: <20170414165902.174167-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
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
 run-command.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/run-command.c b/run-command.c
index d3a32eab6..cbed3265f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -215,6 +215,7 @@ enum child_errcode {
 	CHILD_ERR_CHDIR,
 	CHILD_ERR_DUP2,
 	CHILD_ERR_CLOSE,
+	CHILD_ERR_SIGPROCMASK,
 	CHILD_ERR_ENOENT,
 	CHILD_ERR_SILENT,
 	CHILD_ERR_ERRNO,
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
@@ -420,6 +424,53 @@ static char **prep_childenv(const char *const *deltaenv)
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
@@ -543,6 +594,7 @@ int start_command(struct child_process *cmd)
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct child_err cerr;
+	struct atfork_state as;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -556,6 +608,7 @@ int start_command(struct child_process *cmd)
 
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
+	atfork_prepare(&as);
 
 	/*
 	 * NOTE: In order to prevent deadlocking when using threads special
@@ -569,6 +622,7 @@ int start_command(struct child_process *cmd)
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
+		int sig;
 		/*
 		 * Ensure the default die/error/warn routines do not get
 		 * called, they can take stdio locks and malloc.
@@ -617,6 +671,21 @@ int start_command(struct child_process *cmd)
 			child_die(CHILD_ERR_CHDIR);
 
 		/*
+		 * restore default signal handlers here, in case
+		 * we catch a signal right before execve below
+		 */
+		for (sig = 1; sig < NSIG; sig++) {
+			sighandler_t old = signal(sig, SIG_DFL);
+
+			/* ignored signals get reset to SIG_DFL on execve */
+			if (old == SIG_IGN)
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
@@ -636,6 +705,7 @@ int start_command(struct child_process *cmd)
 			child_die(CHILD_ERR_ERRNO);
 		}
 	}
+	atfork_parent(&as);
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-- 
2.12.2.762.g0e3151a226-goog

