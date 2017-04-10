Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC8920960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbdDJXtc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:49:32 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34645 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbdDJXta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:49:30 -0400
Received: by mail-pf0-f170.google.com with SMTP id c198so29096265pfc.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FRG8Yb1Nu/8/PhTMon06XX8JZweVZYe3xiODnU1ySps=;
        b=mrDDQvMiPkkpm+nvHsw83HxTOa106WIPW/tZ/bs63saZhr6Qhx9iQophjlCxSdVchO
         po8Dw2OEA6KTi4q0H6HVPI0LZooxRfA6NRq3hbiHXxNfq/vQF/NlOsNZ3lI8eT7kIF8d
         M3+1TzTeEjsdIVNy4BbdvFagueUeQVbaTI038OJNjcTIhOraL2moAHfy08qI+MIICn4K
         EvcV6S8Xii6R6TurZNBeo2sEmp4nRtl9XOE3Ul7Rt410nOmn80KQ3U79A/YNJhADpN1/
         Yy/1MH+62WdmzlS50J2wOd7UKNrv/BIH9bukvq7Fn1n0Qxl4gVYrCzwZTd+LzbsH+7gh
         flqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FRG8Yb1Nu/8/PhTMon06XX8JZweVZYe3xiODnU1ySps=;
        b=Aot16lqH009fGMj41t+my/pRrfJyS7Uzov1Ro/TrDPUc3sY/HmV3E2Tls19rU71XLV
         vkVRfNC55C5CRKBd1J02mIhG/i0oRoVFrjZ2gj47ndgjbEeJQ7mIjpwxwwjdph9UHKZa
         Lc1nZSMai/SRW0Zf9FEZ3VnNcIeKSDf6mWQYQjTSd5C+UxM3XdapHMwR4mS90pdebUKB
         cOmFa4BE7rZAmd4sK7K/l9guEwhMAvCN+EkcZWj3TwmjZ89VAPtKlZzR+6KnZfgOqVQo
         EKZPOm6KVklciyE6omHVFRtoMrSM7uEsXr7983biiR+qhq9IbGOoueXkeZqdjf1G4WKo
         5BtQ==
X-Gm-Message-State: AFeK/H3UAzrFBf5i42XJtQXL3XszjPXYJENFB/Xu5ToRN6JOwqdcUiG9oiEOdKBWBQ5vTBMy
X-Received: by 10.98.147.206 with SMTP id r75mr30813852pfk.98.1491868169670;
        Mon, 10 Apr 2017 16:49:29 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x204sm26225132pgx.63.2017.04.10.16.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 16:49:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/5] run-command: prepare argv before forking
Date:   Mon, 10 Apr 2017 16:49:16 -0700
Message-Id: <20170410234919.34586-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid allocation between 'fork()' and 'exec()' the argv
array used in the exec call is prepared prior to forking the process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/run-command.c b/run-command.c
index 682bc3ca5..2514b54bc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,18 +226,6 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 }
 
 #ifndef GIT_WINDOWS_NATIVE
-static int execv_shell_cmd(const char **argv)
-{
-	struct argv_array nargv = ARGV_ARRAY_INIT;
-	prepare_shell_cmd(&nargv, argv);
-	trace_argv_printf(nargv.argv, "trace: exec:");
-	sane_execvpe(nargv.argv[0], (char **)nargv.argv, NULL);
-	argv_array_clear(&nargv);
-	return -1;
-}
-#endif
-
-#ifndef GIT_WINDOWS_NATIVE
 static int child_notifier = -1;
 
 static void notify_parent(void)
@@ -377,9 +365,20 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	if (cmd->git_cmd) {
+		argv_array_push(&argv, "git");
+		argv_array_pushv(&argv, cmd->argv);
+	} else if (cmd->use_shell) {
+		prepare_shell_cmd(&argv, cmd->argv);
+	} else {
+		argv_array_pushv(&argv, cmd->argv);
+	}
+
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
@@ -442,12 +441,9 @@ int start_command(struct child_process *cmd)
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->git_cmd)
-			execv_git_cmd(cmd->argv);
-		else if (cmd->use_shell)
-			execv_shell_cmd(cmd->argv);
-		else
-			sane_execvpe(cmd->argv[0], (char *const*) cmd->argv, NULL);
+
+		sane_execvpe(argv.argv[0], (char *const*) argv.argv, NULL);
+
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
 				error("cannot run %s: %s", cmd->argv[0],
@@ -480,6 +476,8 @@ int start_command(struct child_process *cmd)
 		cmd->pid = -1;
 	}
 	close(notify_pipe[0]);
+
+	argv_array_clear(&argv);
 }
 #else
 {
-- 
2.12.2.715.g7642488e1d-goog

