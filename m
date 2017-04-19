Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1D01FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940315AbdDSXOF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:14:05 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34884 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938306AbdDSXN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:13:58 -0400
Received: by mail-io0-f180.google.com with SMTP id r16so41078189ioi.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vm4YBgeCrznh0CTSQB1jQ1GbGAqhpalIp4apG2ZdftM=;
        b=tYGm/HoXk6AiCbARZqqbQW7gX+2+k3Wv5BvzIPNapELXSrgulT4EIffZGgVGG7BsuH
         JKnakS/RKG9j4/kVmLVj5nKvlOtpV+UHJhaR/WxlEVPsH2bCnI9wz0kilCp/Frhh/voq
         EvIZSC4Qkmyq7h8pHryzM6m7B8tYtMuryVjWDrQlF+hPuh2uWBYWT/xsD+IrJeOBeVlv
         fgV1AQdhyMEE366hclnEczMxXlkd8PdjhvrWFqkmwM2m7Iox8bgq2bqYcZTYU13HEb9P
         Rr3bK+nVYuwNJ3eltdVzEtfr2zy3Gwc4aW3Ecfg7z0d8xhZOHqWvaKzPxLMqbjGa8pte
         kb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vm4YBgeCrznh0CTSQB1jQ1GbGAqhpalIp4apG2ZdftM=;
        b=BmCHfIdM7+2VhLjMgPSRf9lYtUkROTU6ke6Myf8/tKg3nIdMRFYPXYV0tOibsX1ci5
         wVHRnheh8mdx2jLkREwdsIBrWd0RToxDLe19R0j8UY4rdrPWCKgjbKNdKBl0fRfGTx6+
         ks+DF3Um0/4bqmT1e/oHKWFRYIE9o6vSuDUZakEwHva94hAISMEywaO1JuYFALZjE7ER
         dnsn+MMajOWqc0bitTCjPYmpUUbV2GyzbnBqp9Z4attgaJzwI4017VadaYitKGAkjo8W
         bwpCSHGHFBbMuoPTUX4dO18TATg7GsdZ/rvKzItywLtliQOGs0mrqJZMEJKveo0kzxIs
         81CA==
X-Gm-Message-State: AN3rC/6pAQwjTSUs239+XYcQ/PDqFoY8oFQgNvMfDy/FUIyYv/Ribsp4
        Os8Ckl3/eAebDArM
X-Received: by 10.99.231.17 with SMTP id b17mr5235125pgi.55.1492643628099;
        Wed, 19 Apr 2017 16:13:48 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:47 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 09/11] run-command: handle dup2 and close errors in child
Date:   Wed, 19 Apr 2017 16:13:25 -0700
Message-Id: <20170419231327.49895-10-bmwill@google.com>
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

