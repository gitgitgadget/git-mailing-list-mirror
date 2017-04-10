Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C69520960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbdDJXta (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:49:30 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34929 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbdDJXt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:49:29 -0400
Received: by mail-pf0-f175.google.com with SMTP id i5so40206139pfc.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2epHS2u8Mw1nlS05LPnhf61Q/NJAEs0l5s6C5yylrsE=;
        b=jQECuU6yZSmqhUYANKsRfGqHuVBWe97VyeDNXR6RAUYpe95uG6gQAgmcf2oBPjcCXH
         A7lo08L3xKtUrDKcm4lgsIMiMAQgGLvvBKggDWMgwoO9btpBV/zjMAwbgfQKGJxyf/uj
         0RuADEWpEeRHKloOKwou5/HET3R/iu9zKtx6F0eBw9u44kLSJUJ1cIgm09Jf51XnUdNw
         CKsC7WCpbsEps2fswmJdkKI5e35tWHszqOxwPhfRC4+ApbC9bZbpG/WHGQ4DsJ+t5TCa
         ugmY0V8scCScRXZd6zXLfHE//SRe2tPRy8B2kM7zroPecgFgPOvZ/BegbJmPyy0cR5CT
         ozCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2epHS2u8Mw1nlS05LPnhf61Q/NJAEs0l5s6C5yylrsE=;
        b=YXI123LUa1ypVG7ddnoQoJHBtwKBkgCwepV7649enYofH2qWU9biPWG8JItBx2EbyI
         CZWJcmmDmNdtGGNyz6kf0E2l6QB1jF9KXFWu4w7DxevgFq+YOSM4FDGBetQZU+ZUw9m2
         rhsHllOgiNe+zuitifjPHgaYO8wsrkQiX2dMdWtL/z2OQjAaR6GyYn1HQCWhZE8Qq2cT
         jQtNvDB3fk5w9zSLl/q3FP5Cz76z9Z2QBsMCC2J7tTVk68zP92V3phlqX89piUvZkUZW
         za4PAaPvAHp4RQivIpc21Dva/Pmt2fMiZMMdfB2bOzBBil2O869zfdytn/QBl5ejOHJ4
         Ii9g==
X-Gm-Message-State: AN3rC/5SI7W7I/dHcaj1WOt2UeAyLf7j1c2++yHNzfyMf0iCjX7ZuccoKBFwoDG/X5Mpj4ak
X-Received: by 10.84.196.129 with SMTP id l1mr21652041pld.21.1491868168283;
        Mon, 10 Apr 2017 16:49:28 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x204sm26225132pgx.63.2017.04.10.16.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 16:49:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/5] run-command: convert sane_execvp to sane_execvpe
Date:   Mon, 10 Apr 2017 16:49:15 -0700
Message-Id: <20170410234919.34586-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'sane_execvp()' to 'sane_execvpe()' which optionally takes a
pointer to an array of 'char *' which should be used as the environment
for the process being exec'd.  If no environment is provided (by passing
NULL instead) then the already existing environment, as stored in
'environ', will be used.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h       |  3 +--
 exec_cmd.c    |  2 +-
 run-command.c | 15 ++++++++++-----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 5c8078291..10d40ecae 100644
--- a/cache.h
+++ b/cache.h
@@ -2185,8 +2185,7 @@ int checkout_fast_forward(const unsigned char *from,
 			  const unsigned char *to,
 			  int overwrite_ignore);
 
-
-int sane_execvp(const char *file, char *const argv[]);
+int sane_execvpe(const char *file, char *const argv[], char *const envp[]);
 
 /*
  * A struct to encapsulate the concept of whether a file has changed
diff --git a/exec_cmd.c b/exec_cmd.c
index fb94aeba9..c375f354d 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -118,7 +118,7 @@ int execv_git_cmd(const char **argv) {
 	trace_argv_printf(nargv.argv, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	sane_execvp("git", (char **)nargv.argv);
+	sane_execvpe("git", (char **)nargv.argv, NULL);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
diff --git a/run-command.c b/run-command.c
index 574b81d3e..682bc3ca5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -168,10 +168,15 @@ static int exists_in_PATH(const char *file)
 	return r != NULL;
 }
 
-int sane_execvp(const char *file, char * const argv[])
+int sane_execvpe(const char *file, char * const argv[], char *const envp[])
 {
-	if (!execvp(file, argv))
-		return 0; /* cannot happen ;-) */
+	if (envp) {
+		if (!execvpe(file, argv, envp))
+			return 0; /* cannot happen ;-) */
+	} else {
+		if (!execvp(file, argv))
+			return 0; /* cannot happen ;-) */
+	}
 
 	/*
 	 * When a command can't be found because one of the directories
@@ -226,7 +231,7 @@ static int execv_shell_cmd(const char **argv)
 	struct argv_array nargv = ARGV_ARRAY_INIT;
 	prepare_shell_cmd(&nargv, argv);
 	trace_argv_printf(nargv.argv, "trace: exec:");
-	sane_execvp(nargv.argv[0], (char **)nargv.argv);
+	sane_execvpe(nargv.argv[0], (char **)nargv.argv, NULL);
 	argv_array_clear(&nargv);
 	return -1;
 }
@@ -442,7 +447,7 @@ int start_command(struct child_process *cmd)
 		else if (cmd->use_shell)
 			execv_shell_cmd(cmd->argv);
 		else
-			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
+			sane_execvpe(cmd->argv[0], (char *const*) cmd->argv, NULL);
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
 				error("cannot run %s: %s", cmd->argv[0],
-- 
2.12.2.715.g7642488e1d-goog

