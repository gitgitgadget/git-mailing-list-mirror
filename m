Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623021FE90
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756803AbdDQWIl (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:41 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33191 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbdDQWIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:35 -0400
Received: by mail-pf0-f170.google.com with SMTP id s16so71341864pfs.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hLX1+eiU/CSDb51wJjfyfM+E60ihMkotw4f79gIJTRM=;
        b=pq/Kwyrup0FhAoixWlsldtH2RslPwetOG8TgQgirup5XCtHW1HkzZylnFOelcVFYK7
         knFI4lc2uJ6YyrXVZin/GS1El/Y4637SWAglHbWP5njxvuAibWZnaMxePNkljqJAA9pb
         5rci5sgtbAMlCqVslOPpO87hNk+ZxoKPCUcakc2XyGMBF6UA+ZMwiXS4T0wVem4qqDEM
         eeftFOvXoVz8b3iBI0svmySb0gGKE2SvalpPI4ZvW7o42V77PB8vPRu4F8Ejcx5+Amdu
         9D8Jl6IDsFz8ISWIe/lAVkXBjcpjImO45U77nb+hchzDRxVc/AdxMV2ivQCtBlDrfZGH
         06zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hLX1+eiU/CSDb51wJjfyfM+E60ihMkotw4f79gIJTRM=;
        b=Sz0HmsDPv5ZYolivf1RJtXNoN3I+aH0xrWpHwzQbzW6cNQKgG6yaEykZwDbf2isZjl
         u3Sv2srkOnLu3kXqXMELQci2dCUInp1N6lRpjXkUT8xW/+ivabmrJvp22R0u3ikAmjP4
         qMo4wMadvus6mSjcYIwJz0H3waa+No4dG66zOV64OXqvIfq3L39WkhU6gNmTc/nW1Ipk
         E6u9G9a/1RtgewczTCGOQNIMHr5Eq37FWhAhKwiH82tLYE0MyndxFm3TuGtHTo7FMTT6
         FtP5yNT1JnWW04vkrPU6YCXvoowSYnr1r66zhXip8aMm+JKyAjmAaqSGFNlP1qPoGEcj
         S/Tw==
X-Gm-Message-State: AN3rC/5N+Z1A8bIGI5Bz/9eNvjoSuhWS4A5OI7XaRWVdbwHgfFMNSfTh
        xXeLDLn8INItOMgu
X-Received: by 10.84.241.65 with SMTP id u1mr17165548plm.28.1492466914252;
        Mon, 17 Apr 2017 15:08:34 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:33 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 04/10] run-command: use the async-signal-safe execv instead of execvp
Date:   Mon, 17 Apr 2017 15:08:12 -0700
Message-Id: <20170417220818.44917-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
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

