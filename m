Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6D9207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758132AbdDRXSl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:41 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33197 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757500AbdDRXSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:25 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63so3628523pgh.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vm4YBgeCrznh0CTSQB1jQ1GbGAqhpalIp4apG2ZdftM=;
        b=sZ0COyM7GA2aiAqu0eFVw6fdmlEBhpwlYuzi9OLIddIt3N/U2qOULxwyp33fx7MRIz
         GsJan75MCDrRUp4UFQcF69JUxTMXGWulPz0clwcbadrQNFSNUYZ+UYSo+oAr9d6hlsBg
         xnDd59Bh/efORy2C4Ktla+A4d2p9UoE5dhc2drHIRIm7vJlCqZGWxeW68c9J/pDmsQCC
         12LFCo4WYP8p8RtqCqYRiJDoJe8/w6Wnb8l2xSb4Danj0ZoudtrjClWSLSIPcdSbD31y
         HkI1oxRTGWB9l90QttYfLxx+pkqoeFRK4/Dw8Cr+O7rHmcl+3jd4JkNiayqjVzbgw6To
         XFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vm4YBgeCrznh0CTSQB1jQ1GbGAqhpalIp4apG2ZdftM=;
        b=Kwwi2YlIU8hlu+G3QeGq9FAtr5YMsQEX0IWP6YAGKFflHodoMPNXqw6Z9wH3CwAn3l
         5RbyqCzg5OzteIfNVHvimmgvyc5LJXkp4l4UHsGxSWM8sH5YhODuuIr7AP220HfpA+QG
         yZFNeaSElXsPJC+p36PAYeYDkuBiQw6+lcQeX1rfz2hlim7sLetr1OW4kzQD7anV8fdw
         SsxZVbd5dVEp7KzXSJRGulwaFSF7qmErnKclmFUbv7PDwL8thHfqxn0BGPjTuhAVuCyU
         XwdyQK3aoBufHc+11uHaw754wu7Yv3JdLsqS1gI59tRJi9o4X65ANQvmndDm5b4OuzVt
         JMoQ==
X-Gm-Message-State: AN3rC/4Wez2N+rIWmJW3YpqWBWVoj21O+RCW86+YjjATQ929dTVos5O1
        wsK4usJQTxJmcLF4
X-Received: by 10.84.217.136 with SMTP id p8mr26954794pli.47.1492557504714;
        Tue, 18 Apr 2017 16:18:24 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:23 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 09/11] run-command: handle dup2 and close errors in child
Date:   Tue, 18 Apr 2017 16:18:03 -0700
Message-Id: <20170418231805.61835-10-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 58 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1f15714b1..615b6e9c9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -213,6 +213,8 @@ static int child_notifier = -1;
 
 enum child_errcode {
 	CHILD_ERR_CHDIR,
+	CHILD_ERR_DUP2,
+	CHILD_ERR_CLOSE,
 	CHILD_ERR_ENOENT,
 	CHILD_ERR_SILENT,
 	CHILD_ERR_ERRNO
@@ -235,6 +237,24 @@ static void child_die(enum child_errcode err)
 	_exit(1);
 }
 
+static void child_dup2(int fd, int to)
+{
+	if (dup2(fd, to) < 0)
+		child_die(CHILD_ERR_DUP2);
+}
+
+static void child_close(int fd)
+{
+	if (close(fd))
+		child_die(CHILD_ERR_CLOSE);
+}
+
+static void child_close_pair(int fd[2])
+{
+	child_close(fd[0]);
+	child_close(fd[1]);
+}
+
 /*
  * parent will make it look like the child spewed a fatal error and died
  * this is needed to prevent changes to t0061.
@@ -277,6 +297,12 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 		error_errno("exec '%s': cd to '%s' failed",
 			    cmd->argv[0], cmd->dir);
 		break;
+	case CHILD_ERR_DUP2:
+		error_errno("dup2() in child failed");
+		break;
+	case CHILD_ERR_CLOSE:
+		error_errno("close() in child failed");
+		break;
 	case CHILD_ERR_ENOENT:
 		error_errno("cannot run %s", cmd->argv[0]);
 		break;
@@ -527,35 +553,35 @@ int start_command(struct child_process *cmd)
 		child_notifier = notify_pipe[1];
 
 		if (cmd->no_stdin)
-			dup2(null_fd, 0);
+			child_dup2(null_fd, 0);
 		else if (need_in) {
-			dup2(fdin[0], 0);
-			close_pair(fdin);
+			child_dup2(fdin[0], 0);
+			child_close_pair(fdin);
 		} else if (cmd->in) {
-			dup2(cmd->in, 0);
-			close(cmd->in);
+			child_dup2(cmd->in, 0);
+			child_close(cmd->in);
 		}
 
 		if (cmd->no_stderr)
-			dup2(null_fd, 2);
+			child_dup2(null_fd, 2);
 		else if (need_err) {
-			dup2(fderr[1], 2);
-			close_pair(fderr);
+			child_dup2(fderr[1], 2);
+			child_close_pair(fderr);
 		} else if (cmd->err > 1) {
-			dup2(cmd->err, 2);
-			close(cmd->err);
+			child_dup2(cmd->err, 2);
+			child_close(cmd->err);
 		}
 
 		if (cmd->no_stdout)
-			dup2(null_fd, 1);
+			child_dup2(null_fd, 1);
 		else if (cmd->stdout_to_stderr)
-			dup2(2, 1);
+			child_dup2(2, 1);
 		else if (need_out) {
-			dup2(fdout[1], 1);
-			close_pair(fdout);
+			child_dup2(fdout[1], 1);
+			child_close_pair(fdout);
 		} else if (cmd->out > 1) {
-			dup2(cmd->out, 1);
-			close(cmd->out);
+			child_dup2(cmd->out, 1);
+			child_close(cmd->out);
 		}
 
 		if (cmd->dir && chdir(cmd->dir))
-- 
2.12.2.816.g2cccc81164-goog

