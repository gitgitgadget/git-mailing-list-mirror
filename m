Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E91A1FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757077AbdDQWJD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:09:03 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33325 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757022AbdDQWJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:09:00 -0400
Received: by mail-pg0-f49.google.com with SMTP id 63so17801546pgh.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eY2E4vW6Z8+VUZ3RCjg7huhtvkAlNRWnGxceQG63Yzg=;
        b=VqGyLWmGzh6LoXRk7BwT5i5mQV8SzYSCn+oxY3WlqNnTNQaO3kcXy/WVcSr+Hx1NN6
         ZRn8IaZXd3FCh5tyqn5/vqm2nOA99/W0HRBDpRX7XL4luAoKgsigeKBiI0wsLMqJNrMi
         NvbvlXIUje2GWvyIeM6SrbD7PN1yTdJgYMtuwJ1I2i7miA0wtU5zfTT1vwAV39Y1BClA
         nzo51j/yb9b9FFiHAeV2zei/OW94dNI77YtI1g1Ah+8bzdf0bnsk50K8PoOrECQF/xP5
         Rxb2QnJzI17UeiILguuyZBZDUjvLikP8Mu6AsT0BxCxDaBrNRN5C8Va2CyTHJJtuJipf
         En6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eY2E4vW6Z8+VUZ3RCjg7huhtvkAlNRWnGxceQG63Yzg=;
        b=KI9HCgWTMqVZEFchGNmPSFsy9llgcV50njfxIMRilbEiCGX6B7nDXu+CdYl2OOj9+1
         co/fhxpCGdTqpWKnYSvqS9fyXAONpArVXO1Ox8nMmcnlrDVlszxdwLHY/xtCnegJPaPS
         WwK17ix4ylDuSEpfrFl+AAhhplFVZISd2seON9Wt64pQO4/kWNBpP4glK6+bBsVGymqg
         XKE7QrcTdX7dZ+3F4w0zCSuRPnn1VQU4tsdfL3IJrGwdavEwMg4s1zT/PxDVXPWv07/v
         sDMZjQlK2KEGUfnkC5S9bikNV+j49zdMZUmlwtMNeNDhQVXBnI5o1sv5k4r++qyzNQxK
         mX+A==
X-Gm-Message-State: AN3rC/6HuxI59xxlCJSwZH1qUuMav0+R26wVw485A3tpXZzXKA/duqTN
        qLZYnHZwsMACTMTN
X-Received: by 10.98.18.137 with SMTP id 9mr14242395pfs.75.1492466920193;
        Mon, 17 Apr 2017 15:08:40 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 08/10] run-command: handle dup2 and close errors in child
Date:   Mon, 17 Apr 2017 15:08:16 -0700
Message-Id: <20170417220818.44917-9-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 58 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index e1e8780ca..bd6414283 100644
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
@@ -548,35 +574,35 @@ int start_command(struct child_process *cmd)
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
2.12.2.762.g0e3151a226-goog

