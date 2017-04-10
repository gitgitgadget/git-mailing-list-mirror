Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E04020960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbdDJXtp (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:49:45 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36857 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbdDJXtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:49:43 -0400
Received: by mail-pf0-f172.google.com with SMTP id o126so40232810pfb.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3NTEAMXQYR215vEO1mIiE+PIk3xH/Waf6+s4UsnppE=;
        b=UVgx61ZLupYmzu6cp3aRTTesvIKWg0rLyo5QF4C84SpH8mnZgiGA+f2EGkXSkN0LPr
         UYlNeS/TpUGpugg77MiGzU1texfsVDW7zqZ3dZKbeuta7jWHHmV1WJqSr41kU/UAySPd
         ImtF/ScYoDTym2TgxLVq913TfGHcGimzYI1aPwJj+yew7aLFySz+GzSWT8L61xhPuqxn
         FjUw27psszB9ri6oz+8skj6CF8DkllDslfrw9p6c65q1VHsq/LVwDu7uDX7YeXc2EOaY
         XXN3arwbokNospsehCPSB4KL3JrzdEIqdFLpUYOwVRmQgRt+ALAkTaDgn+YzGze0K90l
         5B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3NTEAMXQYR215vEO1mIiE+PIk3xH/Waf6+s4UsnppE=;
        b=BVldue81yjjtAfkoUXNqX6Wy7M9A/RPMrOWbT1N7tXjfgiP+1/Bh+SO+O8k9ZShrHB
         q+gp+5s8YgC5UPGwY9gnJW8Flj1Hmhj76ozwAxtUV6wtU2Qw8EalJNdSYXO03xWR8xxZ
         cscl25PQtS/NaTEqlQ9+EjmMsl+rB0weoIGAwR0MkMZ0w2FEhT/Mdny6YdRv7iXBVcXE
         P9FMji8FliP8dA1GzREnQkGMaiC3gTxnVlyymiIUoHR0AxNLbISjvPSVj0Gdr6q9/5LY
         6pJd72ZbCuBLOJjgQ2OTwd5Wje4N84AUSwAHXly/Zzh50GDahIhAtpRnD0FyGLBHb++c
         3DCg==
X-Gm-Message-State: AFeK/H2Bkew469yUDgyoAK+QkJuZb2JqOLba5lLMtTmUctet/DLY9TsC1MryQH6pSGcoDjY5
X-Received: by 10.98.9.29 with SMTP id e29mr58048898pfd.101.1491868172296;
        Mon, 10 Apr 2017 16:49:32 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x204sm26225132pgx.63.2017.04.10.16.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 16:49:31 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 4/5] run-command: prepare child environment before forking
Date:   Mon, 10 Apr 2017 16:49:18 -0700
Message-Id: <20170410234919.34586-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid allocation between 'fork()' and 'exec()' prepare the
environment to be used in the child process prior to forking.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 029d41463..84c63b209 100644
--- a/run-command.c
+++ b/run-command.c
@@ -291,6 +291,75 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	return code;
 }
 
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
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -365,12 +434,15 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	char **childenv;
 	FILE *child_err = NULL;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	childenv = prep_childenv(cmd->env);
+
 	if (cmd->no_stderr || need_err) {
 		int child_err_fd = dup(2);
 		set_cloexec(child_err_fd);
@@ -437,16 +509,9 @@ int start_command(struct child_process *cmd)
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
 
-		sane_execvpe(argv.argv[0], (char *const*) argv.argv, NULL);
+		sane_execvpe(argv.argv[0], (char *const*) argv.argv,
+			     (char *const*) childenv);
 
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
@@ -483,6 +548,7 @@ int start_command(struct child_process *cmd)
 
 	if (child_err)
 		fclose(child_err);
+	free(childenv);
 	argv_array_clear(&argv);
 }
 #else
-- 
2.12.2.715.g7642488e1d-goog

