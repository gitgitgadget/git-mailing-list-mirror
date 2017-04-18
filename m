Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4237C207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758117AbdDRXSk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:40 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34592 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757974AbdDRXSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:25 -0400
Received: by mail-pf0-f179.google.com with SMTP id c198so3404134pfc.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nd9bFHK/fnDq9QqH2iRwDl8rdpxDYuviKcMEWTteinY=;
        b=FWORJ0Z6yuSZBIlF8tdGFY/SjKmKnE09/h3jcj6dltKWVSf/vNw+veS5HeHCb7rhO9
         Hh4SXpCogg0PF2zkEUBULyvW1SmhQeBgpuf8Y/7mNQLRju52zvd60FRLJ7gq1H6WwgTS
         NOnQdhJZnZVjb+MJv8VclxnlFHtVB1M7Kr4U+hDFIcfMp+CDAQGB86QBNDp+rnjczUWv
         FTb2CZ/haeINV2xD6ine11HYhgBN/D/mJwUOGZjFNkYsbgPbWnGzbZZqNuqDx8lhyvYe
         k4+WN8NVquqW9Cs0HFAfr+8ASBaltGBLhxcy3muodqBLOwv+4SHIrMxa7k/IxkJtx6Ow
         w4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nd9bFHK/fnDq9QqH2iRwDl8rdpxDYuviKcMEWTteinY=;
        b=cbUTYL91WcXMryVsn7v1u1rSQob85rSBymbmOKh23hLgeu7MSV6UeJcl7eHMChbmjy
         tt4Zrv9mDh+G8YQVu4uM1xHOQa3IPx5wzCHUbI2f4kSdnOQRFOt2ShZq+cvHXePWQK5H
         TpNyrjK8hTeSvL+SYulmaP5Hm/NZUgu7BN9DYe7Osbn5MeZ02DNTGjIU/KrkW8kRsAoJ
         BUNEFjjQ9HohjQpgXN0YfxWkq6MaBuAYJRtzTiFn1x8w3K2gjCXMzM3zeAhKUZ/B0Vof
         4uKRgiCZn5HcXrekj1CIK+1SDRr5Fjps2zs1ZD9tICltbMQWXfnyeVnEWA4mHvsxbDQ8
         5Z7w==
X-Gm-Message-State: AN3rC/5gYvOjwnQHoQcG/Ochv12bkvd4ptUdFQ9BWJTOhWHh2SDPgziH
        h1Umgfi+t3XsfAzN
X-Received: by 10.98.63.85 with SMTP id m82mr20446080pfa.143.1492557499749;
        Tue, 18 Apr 2017 16:18:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 06/11] run-command: prepare child environment before forking
Date:   Tue, 18 Apr 2017 16:18:00 -0700
Message-Id: <20170418231805.61835-7-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
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
 run-command.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1c7a3b611..15e2e74a7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -267,6 +267,55 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 		}
 	}
 }
+
+static char **prep_childenv(const char *const *deltaenv)
+{
+	extern char **environ;
+	char **childenv;
+	struct string_list env = STRING_LIST_INIT_DUP;
+	struct strbuf key = STRBUF_INIT;
+	const char *const *p;
+	int i;
+
+	/* Construct a sorted string list consisting of the current environ */
+	for (p = (const char *const *) environ; p && *p; p++) {
+		const char *equals = strchr(*p, '=');
+
+		if (equals) {
+			strbuf_reset(&key);
+			strbuf_add(&key, *p, equals - *p);
+			string_list_append(&env, key.buf)->util = (void *) *p;
+		} else {
+			string_list_append(&env, *p)->util = (void *) *p;
+		}
+	}
+	string_list_sort(&env);
+
+	/* Merge in 'deltaenv' with the current environ */
+	for (p = deltaenv; p && *p; p++) {
+		const char *equals = strchr(*p, '=');
+
+		if (equals) {
+			/* ('key=value'), insert or replace entry */
+			strbuf_reset(&key);
+			strbuf_add(&key, *p, equals - *p);
+			string_list_insert(&env, key.buf)->util = (void *) *p;
+		} else {
+			/* otherwise ('key') remove existing entry */
+			string_list_remove(&env, *p, 0);
+		}
+	}
+
+	/* Create an array of 'char *' to be used as the childenv */
+	childenv = xmalloc((env.nr + 1) * sizeof(char *));
+	for (i = 0; i < env.nr; i++)
+		childenv[i] = env.items[i].util;
+	childenv[env.nr] = NULL;
+
+	string_list_clear(&env, 0);
+	strbuf_release(&key);
+	return childenv;
+}
 #endif
 
 static inline void set_cloexec(int fd)
@@ -395,12 +444,14 @@ int start_command(struct child_process *cmd)
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
@@ -456,14 +507,6 @@ int start_command(struct child_process *cmd)
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
@@ -471,9 +514,11 @@ int start_command(struct child_process *cmd)
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
@@ -509,6 +554,7 @@ int start_command(struct child_process *cmd)
 	close(notify_pipe[0]);
 
 	argv_array_clear(&argv);
+	free(childenv);
 }
 #else
 {
-- 
2.12.2.816.g2cccc81164-goog

