Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2B620960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755945AbdDMSdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:33:11 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36062 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbdDMSdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:33:06 -0400
Received: by mail-pg0-f53.google.com with SMTP id g2so34005569pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nJA2RQj4WM7wdwa5wyyC1vvDRdbY6ATb4Lny7wtMg+g=;
        b=BqnK9/x+uXa9ifVYMlIJCdPyrmWhvlp8IN6X3D217h8KPXQLJWRnKRs73NZsvt/uGv
         q7ynfsOyCb4JkC3ha++3LMh07Jqud4domBF+IzMuMnD/aG4ZdrsPkzXJrzeiK7izbpfC
         WPlvlEpx3o62JmcC2KxO1nHohliqP2ERX2wlqspuOBGP99Qid7VtZiXOYzBcff3fWxkD
         0tJVSk6Oub3tKeM2a1N7bLbn9DGGP/qadfHVTBugQhRW3kH4F1QBdMHUHHo1bF6y1+gk
         P0dqcHHusgUMmlfAx9Tya/Yzv2EizUlSvC0HPHlz36EWD97AZuCZvZVSox7lFUoCm5E8
         BN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nJA2RQj4WM7wdwa5wyyC1vvDRdbY6ATb4Lny7wtMg+g=;
        b=GBnk9w09Ioq1Av2fIvdrJFTMXQUU5LNmIKMCAN/ixlOWPWYTYekpJFO+SInsrsLAOn
         VUnzMAI5KpGUjrHyfT3NjPTSa9DaC0bTSQifQI2+/OTsYfZKnHqNIBP040O1rW2vb9CK
         6YZFFLk+G8+bNf/6Mp5jmil3HvvvcH73/p7waqfJP8Gby8IP1e+d53hDZNPqLmVl5qnN
         NWMQxIsj/Tq8dQj8MpUVGXLeRdYtALxnOiJDKX9dh2YD+rzz9zjOZT/yaRtRkIDiKDZg
         iBuCAj2SyghN9JmU8Fq+bJIhS4ardTsCKGwXnUMpgBMITKX+okrMT5Ee0ifMraIgJ/0q
         s9fg==
X-Gm-Message-State: AN3rC/6b0/kgWp9hvYOxf5a6VGZvzmN6yQvh0IfA+r/Id+l5HdljIajc
        PDQeTTvycqgJyVfh
X-Received: by 10.99.218.69 with SMTP id l5mr4255017pgj.219.1492108385514;
        Thu, 13 Apr 2017 11:33:05 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 201sm43764654pfc.126.2017.04.13.11.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:33:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v2 3/6] run-command: prepare child environment before forking
Date:   Thu, 13 Apr 2017 11:32:49 -0700
Message-Id: <20170413183252.4713-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
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
 run-command.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 9ee9fde97..5e2a03145 100644
--- a/run-command.c
+++ b/run-command.c
@@ -261,6 +261,75 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
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
@@ -389,12 +458,14 @@ int start_command(struct child_process *cmd)
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
@@ -450,16 +521,9 @@ int start_command(struct child_process *cmd)
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
 
-		execv(argv.argv[0], (char *const *) argv.argv);
+		execve(argv.argv[0], (char *const *) argv.argv,
+		       (char *const *) childenv);
 
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
@@ -495,6 +559,7 @@ int start_command(struct child_process *cmd)
 	close(notify_pipe[0]);
 
 	argv_array_clear(&argv);
+	free(childenv);
 }
 #else
 {
-- 
2.12.2.762.g0e3151a226-goog

