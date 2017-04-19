Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5661FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940310AbdDSXN7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:13:59 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33939 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940290AbdDSXNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:13:50 -0400
Received: by mail-io0-f170.google.com with SMTP id a103so42689535ioj.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ar72qPy8QBS1Abtf2FZUNFKRCioNzWk/L2qpfhUhfw4=;
        b=X8R8ey4+L9eEZpSJyQnhiCU7aMm+rBcf1t4gMZFCEvxvjX/RZWeB41FEjbkqrz+hl2
         vcFfBpmg3yLHG2xdUz1WmnW5SGjq2ZTBLC8G2zDEl3bh3TDsptaTZixi86YIRrXJVVdE
         S1GdjquBVEfxgqVuIxjUAUpfYNizLnXjpnhmImkjYiTG5Jl9nWWxE3+2tnGzTT3wu61T
         dOmR8Zjdzjq4GrLBuS+tKnvgtI+zRgHqsRzxco/S/173Dh37xkaBDIqgKVF6sV6pGEI6
         ez1iHbWdr6elbgyu0CxQWnWlCC/248vQfo5JS23Kgs2kkZMVuJSstwkW7buoRsv9Nt9i
         kzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ar72qPy8QBS1Abtf2FZUNFKRCioNzWk/L2qpfhUhfw4=;
        b=jS6P7cqafXtIXOu2u7D/96vIi0R3Pd+jh4rD4zsTUEsf3nge9GeSWzXRT5Qq4cf0MF
         /oZ2u692QOxFzlhlHvgq5gDp3W1lnEMIs0R3QogDCk/tq5sIYH9aqwIbzEarvthXCLQg
         bhpUv7AZMcKrYWtYomdvXFPrJnqmurZkbvAnMzQBZab9L1xbKggPjkVS8SPX17JlGaEl
         zge1sbS7WI1xcJCi5Q262UBY2Az4CR7afjEYCJfuiGgF7GmhVvgem2NeQ6gI8SvHPb0q
         5CUrcgp1kLU3QVk4fhmy3OE2/SgQC5yNARcuhUVa6nPccWXiV4pD+YJjTdMx/Zxv/sWy
         T+Yw==
X-Gm-Message-State: AN3rC/6LwLQcg7QIpNBg7kJztO/xddjGK6SuTpNi91RR/Im/5bYl+4nM
        49hT3Hgh9peCLJiS
X-Received: by 10.99.163.98 with SMTP id v34mr5285447pgn.228.1492643625201;
        Wed, 19 Apr 2017 16:13:45 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 07/11] run-command: don't die in child when duping /dev/null
Date:   Wed, 19 Apr 2017 16:13:23 -0700
Message-Id: <20170419231327.49895-8-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170419231327.49895-1-bmwill@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/run-command.c b/run-command.c
index 15e2e74a7..b3a35dd82 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,18 +117,6 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-#ifndef GIT_WINDOWS_NATIVE
-static inline void dup_devnull(int to)
-{
-	int fd = open("/dev/null", O_RDWR);
-	if (fd < 0)
-		die_errno(_("open /dev/null failed"));
-	if (dup2(fd, to) < 0)
-		die_errno(_("dup2(%d,%d) failed"), fd, to);
-	close(fd);
-}
-#endif
-
 static char *locate_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
@@ -444,12 +432,20 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	int null_fd = -1;
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
+		null_fd = open("/dev/null", O_RDWR | O_CLOEXEC);
+		if (null_fd < 0)
+			die_errno(_("open /dev/null failed"));
+		set_cloexec(null_fd);
+	}
+
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
 
@@ -473,7 +469,7 @@ int start_command(struct child_process *cmd)
 		atexit(notify_parent);
 
 		if (cmd->no_stdin)
-			dup_devnull(0);
+			dup2(null_fd, 0);
 		else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
@@ -483,7 +479,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stderr)
-			dup_devnull(2);
+			dup2(null_fd, 2);
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
@@ -493,7 +489,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stdout)
-			dup_devnull(1);
+			dup2(null_fd, 1);
 		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
@@ -553,6 +549,8 @@ int start_command(struct child_process *cmd)
 	}
 	close(notify_pipe[0]);
 
+	if (null_fd >= 0)
+		close(null_fd);
 	argv_array_clear(&argv);
 	free(childenv);
 }
-- 
2.12.2.816.g2cccc81164-goog

