Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4B420970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbdDNQ7a (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:30 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33641 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbdDNQ7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:22 -0400
Received: by mail-pf0-f180.google.com with SMTP id s16so42777961pfs.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/6g9VpHXmaDXlake/EbJ9FCSUtnlVCEUGqmpFnsi0A=;
        b=VVjvgciNNy7InK21AYQQR0Mb9ML5MGd4vZKZ2YFPVJObG4h7ZT8PqeAkNtCYMkecT4
         KmnMURnMNJU3gQfeAtKoYed0zoJO1emqW1xFvQ2CM6IRYo7BgzlNUor3x+hzxEA0dtLg
         ISec4hbK7YuxaVIKx3dThOOygYw3dZCqvGSCNrc3AiC5jk9WjMmhGKSuw4YHsrn6NE40
         mHdZXN0uvyx7M/SUbBq/zKC+l5vJlMVngoFMY008ok+d9bGbFB7IcvU9+OyVC5fWK9Ye
         oWoLLEJ8ghAU0Yk/awjjTVQPKQUuAZeCj7hcejkPjX1UBfgTe/9re5YsFifDJ0j266Vi
         Kx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C/6g9VpHXmaDXlake/EbJ9FCSUtnlVCEUGqmpFnsi0A=;
        b=GgoHtK5YPmk99niEEk6JXmqhXYtTtpTEDDvHh8H8ViGlvlCe/5U0Sawa+cCbSAbfMS
         SaXUlSlptPP/FlxCHk0Zs9TE3ShLnsFx6Tt75cQ51WU8aXwrV0CC937WqxwmBWcJgus/
         c6biZiEVc3LBKSUOSJNpJhWylCn3df3ajDJDH1VumtCkprh6HQxe4OZBoIKKIiLJKMuW
         dMLMWHknElHDAvkoL5sjNzd+9EFU8YKSiTBKfKj/hOe2+YnCgRWKnZ3+qLHTzz8ppBIM
         U45XFFjG1XKXbydcXlarJORjJiPO2xifzpExKkMrgvENPGCjzNY/a0155GBek/NfhNZ5
         9pUw==
X-Gm-Message-State: AN3rC/6t+hqszIiNbNIHdj0p+UtAeZf2ZPTdfRowlG56wh3JKXi5/AkO
        tEr/OjQWa8ALTpL0
X-Received: by 10.98.58.3 with SMTP id h3mr8050338pfa.27.1492189161356;
        Fri, 14 Apr 2017 09:59:21 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 08/10] run-command: handle dup2 and close errors in child
Date:   Fri, 14 Apr 2017 09:59:00 -0700
Message-Id: <20170414165902.174167-9-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 58 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index 25b487c35..f36eafa8d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -213,6 +213,8 @@ static int child_notifier = -1;
 
 enum child_errcode {
 	CHILD_ERR_CHDIR,
+	CHILD_ERR_DUP2,
+	CHILD_ERR_CLOSE,
 	CHILD_ERR_ENOENT,
 	CHILD_ERR_SILENT,
 	CHILD_ERR_ERRNO,
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
@@ -547,35 +573,35 @@ int start_command(struct child_process *cmd)
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

