Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2873D1FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbdDQWIz (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:55 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36494 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756830AbdDQWIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:46 -0400
Received: by mail-pf0-f181.google.com with SMTP id 194so32087416pfv.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tznvzGIcit5/GX9ZuZ4CK7Tt4K2XZLv9x36VBGeRdXY=;
        b=FcYfzutnUgAuz6YZUU+sDWyjXDhlqBax+Oyct7wUFUM7MLjjjYHqRIDOOud7DhQ/gA
         ZM2vyENn/TfaUc+sUv/y+oiBA29lPImMzPYZkepR756lUG78ezJwndFfRMhHkUuk+kKq
         QLcZXNzSgD8DdqrLG0XNmuTSEspXvUkCrvO3F1+Tp/qW8SV+4GSn4S+F+HQ1adscaL+V
         BLN1uHHGXN5MpFP17rAq0xZpnY0RgvvirH8CDZG7EECQP4R/NmqTEoAm2Ew3devwNBTm
         YqOfLV0nB+KdXpxb5haSedhUAvAkY6aGwboSj2d8/U6Ec5/CglLAtUN5sRtCrd++NLAh
         gSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tznvzGIcit5/GX9ZuZ4CK7Tt4K2XZLv9x36VBGeRdXY=;
        b=CKnA+BWiR/R2kuLp9m603gV0uMPmPjeuILrqtSrc1JMLozMcfHlHcTwd0tUaB4h34L
         pg9hQLw71yYUhoBOQhh3PQZx72/9cA1dScpLd5RrAsL3Pl70BreLp0ZEFtwYZde25Uw2
         5iCZi26yJOF8mG/md7e9FZSFRatVAgQixCUqOF7WLhDcQBl04QQKuf2nF0C+y9RpJ7r/
         Tq7pInHg7RoeOw/4DPmZ0lE5I5S0V0KjP1KUYnNJl7YY8W47mUhS65J+IJLuuTKt9IkE
         QDp49Gc5uyX1ycMH3xmU8bbnUipKUFdpf+cwYCwh/J8lAW3Hk4cNwEq0sqdaGzm230wR
         uiIQ==
X-Gm-Message-State: AN3rC/674jStxV+OPEPr6f07PrVNAlaZlHCUojeizT8YPRCbsODglA7h
        dchAFVTvkvB7MJLP
X-Received: by 10.98.204.93 with SMTP id a90mr14090861pfg.6.1492466915806;
        Mon, 17 Apr 2017 15:08:35 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 05/10] run-command: prepare child environment before forking
Date:   Mon, 17 Apr 2017 15:08:13 -0700
Message-Id: <20170417220818.44917-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
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
 run-command.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1c7a3b611..2fff60a04 100644
--- a/run-command.c
+++ b/run-command.c
@@ -267,6 +267,76 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
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
+	extern char **environ;
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
@@ -395,12 +465,14 @@ int start_command(struct child_process *cmd)
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
@@ -456,14 +528,6 @@ int start_command(struct child_process *cmd)
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
@@ -471,9 +535,11 @@ int start_command(struct child_process *cmd)
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
@@ -509,6 +575,7 @@ int start_command(struct child_process *cmd)
 	close(notify_pipe[0]);
 
 	argv_array_clear(&argv);
+	free(childenv);
 }
 #else
 {
-- 
2.12.2.762.g0e3151a226-goog

