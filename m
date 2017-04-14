Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5232220970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbdDNQ7n (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:43 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35394 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbdDNQ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:16 -0400
Received: by mail-pf0-f173.google.com with SMTP id i5so42726781pfc.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hLX1+eiU/CSDb51wJjfyfM+E60ihMkotw4f79gIJTRM=;
        b=JLKh0Vt6UJj1o5pOhx1e1QwSD4/1eEzXKmJDrQXy99Z/ZPmokPpAN5cPH0rQ23Ceba
         cIj3+0g2xtRv0UvSxRDtQq8SFxeA6hJuhb9ZtdBhyw/LWtwYK0bjiidG4yIsXYfGtbT6
         lXzDQh/bL+C/tdqLbcJ6c+3CLS3HG0vICYNgv1MoQMhaowVZy0e/f4oQVX350jjbPk6U
         r6a0fbue5uPvhB8glv+DyID11gfwVbcm8wCZ3fEAacJPkyYeLP9NV0m3VYGLivU60qIt
         i+mhubda3oiKuAD1ac38w+q1NHs946mfHAQA5zzMiGRQyiaitUHcksnwWELRL/Jx0G5H
         oU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hLX1+eiU/CSDb51wJjfyfM+E60ihMkotw4f79gIJTRM=;
        b=iTEzxyWrs9jMPJ+MHe02xHLr1657gFZ+kPKZn6uOAT4LocwKnkSnFXJOUjWvb6rLg+
         T8NO5YfzUBfsY1nv3Z1fFIGSXx+WvtTCkxSU7VLE3BcR6U+sJHplsvxCY5C+/vVqpZUa
         FzDZ2ezlekPRncy8vf+y0kX2m/+abktyPTFzLR0oBee1GY4+0i8YGimleiYObUe+eUk8
         ara+FhZo2FxjHZJmCDiBBGckPG1al0/dKmaiZ4SQDlALSQSC6p1mZQQxY6b/njLw1Lw7
         yBTmaYUd1SXX/NB7cjNayEKY4d2MrvjlLwZHThP7hjsClv3+e83+jZUwDO0ztgPVpbHF
         tUug==
X-Gm-Message-State: AN3rC/5+lh0DDjn7qqPCw6a3FM5Pvd/DvKmxNGUWz0JDi/62OiUcrdEj
        EZtzlMvBF0A6/GfD
X-Received: by 10.99.134.193 with SMTP id x184mr7966717pgd.43.1492189155797;
        Fri, 14 Apr 2017 09:59:15 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:14 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 04/10] run-command: use the async-signal-safe execv instead of execvp
Date:   Fri, 14 Apr 2017 09:58:56 -0700
Message-Id: <20170414165902.174167-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the function used to exec from 'execvp()' to 'execv()' as the (p)
variant of exec isn't async-signal-safe and has the potential to call malloc
during the path resolution it performs.  Instead we simply do the path
resolution ourselves during the preparation stage prior to forking.  There also
don't exist any portable (p) variants which also take in an environment to use
in the exec'd process.  This allows easy migration to using 'execve()' in a
future patch.

Also, as noted in [1], in the event of an ENOEXEC the (p) variants of
exec will attempt to execute the command by interpreting it with the
'sh' utility.  To maintain this functionality, if 'execv()' fails with
ENOEXEC, start_command will atempt to execute the command by
interpreting it with 'sh'.

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/exec.html

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index d8d143795..1c7a3b611 100644
--- a/run-command.c
+++ b/run-command.c
@@ -238,6 +238,12 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	if (!cmd->argv[0])
 		die("BUG: command is empty");
 
+	/*
+	 * Add SHELL_PATH so in the event exec fails with ENOEXEC we can
+	 * attempt to interpret the command with 'sh'.
+	 */
+	argv_array_push(out, SHELL_PATH);
+
 	if (cmd->git_cmd) {
 		argv_array_push(out, "git");
 		argv_array_pushv(out, cmd->argv);
@@ -246,6 +252,20 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	} else {
 		argv_array_pushv(out, cmd->argv);
 	}
+
+	/*
+	 * If there are no '/' characters in the command then perform a path
+	 * lookup and use the resolved path as the command to exec.  If there
+	 * are no '/' characters or if the command wasn't found in the path,
+	 * have exec attempt to invoke the command directly.
+	 */
+	if (!strchr(out->argv[1], '/')) {
+		char *program = locate_in_PATH(out->argv[1]);
+		if (program) {
+			free((char *)out->argv[1]);
+			out->argv[1] = program;
+		}
+	}
 }
 #endif
 
@@ -445,7 +465,15 @@ int start_command(struct child_process *cmd)
 			}
 		}
 
-		sane_execvp(argv.argv[0], (char *const *) argv.argv);
+		/*
+		 * Attempt to exec using the command and arguments starting at
+		 * argv.argv[1].  argv.argv[0] contains SHELL_PATH which will
+		 * be used in the event exec failed with ENOEXEC at which point
+		 * we will try to interpret the command using 'sh'.
+		 */
+		execv(argv.argv[1], (char *const *) argv.argv + 1);
+		if (errno == ENOEXEC)
+			execv(argv.argv[0], (char *const *) argv.argv);
 
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
-- 
2.12.2.762.g0e3151a226-goog

