Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B8E20970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbdDNQ71 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:27 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33907 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbdDNQ7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:18 -0400
Received: by mail-pf0-f172.google.com with SMTP id c198so42771106pfc.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpWW0ddC89qAjy8dXkbJH6lMJnT2y30AWlTiSHnSgro=;
        b=p3pkYrZeC1rHB15zDVQYAwyw0R8b5Yv1SfRNBINjd/PSxTjLPzLhXPh1jF3/B+Dt1z
         jMmS8MnxN2WAmMXVlYZU2TH0NGKIRAGAlHZFyu3FsfixSMrPy0oNuraSqNiGvTaKFuQB
         y3KKc/I/3lXLYepJGmLFOd0xWTeKo1OIVw14JeSehXZpZ8nmGZd1SBqYGV7+ZZih6wMJ
         dop13gJtkJSxDA4JWi8QMHF3dNyEuYHvIzMne3yE0aFo3J078daEPmMgkQZV+2M4jkDV
         /Fzt1rjeDrqDoEu8HCuU1zz6VaAoTwEwnrhGxN9Uxjgg/1VnavsDoGda6qY4tAeuGWfU
         eSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpWW0ddC89qAjy8dXkbJH6lMJnT2y30AWlTiSHnSgro=;
        b=oiDISHSrNaC4vm1Tc+WfzvVAKp9/s/ycNZXu82RU8Hw7JVI/sqcGT30SftBIdQdbhq
         Fbq9iRGuPGdgejo4//fd/LZRH0BWjWxKCfa6Bl7eD3+yMgHwvsXL3U+9GuUjPt/ioKca
         OanP0jOy7HnFXI2lJv4pA6cXURG7DzUxHb2thbL2+NqQe72eHp0/FL4B7bIeOsTieAtA
         VU2V12r1IV9KCucntrqo4kzbgozI0AKlbygpUtJWqKlEFPQijX0luM5bc5BCHnLA7StF
         a+VQacz8YfjirffxeisemHBDKnr4Jmt/6gxRmt+tSG6ev2e41fLtYOEVrekx1q1fhMpb
         Z8jw==
X-Gm-Message-State: AN3rC/6YGHkNj/bpAnH3WA+QTWNG8F+gMghLBxnXYnpMtmjltdUlQAFd
        CKHMr0RnM/KeUvWK
X-Received: by 10.84.238.9 with SMTP id u9mr10085170plk.174.1492189157174;
        Fri, 14 Apr 2017 09:59:17 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 05/10] run-command: prepare child environment before forking
Date:   Fri, 14 Apr 2017 09:58:57 -0700
Message-Id: <20170414165902.174167-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid allocation between 'fork()' and 'exec()' prepare the
environment to be used in the child process prior to forking.

Switch to using 'execve()' so that the construct child environment can
used in the exec'd process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1c7a3b611..5864b5ff3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -267,6 +267,75 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 		}
 	}
 }
+
+static int env_isequal(const char *e1, const char *e2)
+{
+	for (;;) {
+		char c1 = *e1++;
+		char c2 = *e2++;
+		c1 = (c1 == '=') ? '\0' : tolower(c1);
+		c2 = (c2 == '=') ? '\0' : tolower(c2);
+
+		if (c1 != c2)
+			return 0;
+		if (c1 == '\0')
+			return 1;
+	}
+}
+
+static int searchenv(char **env, const char *name)
+{
+	int pos = 0;
+
+	for (; env[pos]; pos++)
+		if (env_isequal(env[pos], name))
+			break;
+
+	return pos;
+}
+
+static int do_putenv(char **env, int env_nr, const char *name)
+{
+	int pos = searchenv(env, name);
+
+	if (strchr(name, '=')) {
+		/* ('key=value'), insert of replace entry */
+		if (pos >= env_nr)
+			env_nr++;
+		env[pos] = (char *) name;
+	} else if (pos < env_nr) {
+		/* otherwise ('key') remove existing entry */
+		env_nr--;
+		memmove(&env[pos], &env[pos + 1],
+			(env_nr - pos) * sizeof(char *));
+		env[env_nr] = NULL;
+	}
+
+	return env_nr;
+}
+
+static char **prep_childenv(const char *const *deltaenv)
+{
+	char **childenv;
+	int childenv_nr = 0, childenv_alloc = 0;
+	int i;
+
+	for (i = 0; environ[i]; i++)
+		childenv_nr++;
+	for (i = 0; deltaenv && deltaenv[i]; i++)
+		childenv_alloc++;
+	/* Add one for the NULL termination */
+	childenv_alloc += childenv_nr + 1;
+
+	childenv = xcalloc(childenv_alloc, sizeof(char *));
+	memcpy(childenv, environ, childenv_nr * sizeof(char *));
+
+	/* merge in deltaenv */
+	for (i = 0; deltaenv && deltaenv[i]; i++)
+		childenv_nr = do_putenv(childenv, childenv_nr, deltaenv[i]);
+
+	return childenv;
+}
 #endif
 
 static inline void set_cloexec(int fd)
@@ -395,12 +464,14 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
 	prepare_cmd(&argv, cmd);
+	childenv = prep_childenv(cmd->env);
 
 	cmd->pid = fork();
 	failed_errno = errno;
@@ -456,14 +527,6 @@ int start_command(struct child_process *cmd)
 		if (cmd->dir && chdir(cmd->dir))
 			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
 			    cmd->dir);
-		if (cmd->env) {
-			for (; *cmd->env; cmd->env++) {
-				if (strchr(*cmd->env, '='))
-					putenv((char *)*cmd->env);
-				else
-					unsetenv(*cmd->env);
-			}
-		}
 
 		/*
 		 * Attempt to exec using the command and arguments starting at
@@ -471,9 +534,11 @@ int start_command(struct child_process *cmd)
 		 * be used in the event exec failed with ENOEXEC at which point
 		 * we will try to interpret the command using 'sh'.
 		 */
-		execv(argv.argv[1], (char *const *) argv.argv + 1);
+		execve(argv.argv[1], (char *const *) argv.argv + 1,
+		       (char *const *) childenv);
 		if (errno == ENOEXEC)
-			execv(argv.argv[0], (char *const *) argv.argv);
+			execve(argv.argv[0], (char *const *) argv.argv,
+			       (char *const *) childenv);
 
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
@@ -509,6 +574,7 @@ int start_command(struct child_process *cmd)
 	close(notify_pipe[0]);
 
 	argv_array_clear(&argv);
+	free(childenv);
 }
 #else
 {
-- 
2.12.2.762.g0e3151a226-goog

