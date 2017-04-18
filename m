Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13AB7207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758076AbdDRXSh (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:37 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33156 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758067AbdDRXS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:26 -0400
Received: by mail-pf0-f180.google.com with SMTP id a188so3421833pfa.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0SDsN+zqkLsm+rTbC4y7ru2lS0h30r1n+1k5JCz66M=;
        b=DV6EFiKQgnyk94ifP+3NFn4rsfhAMuHQrkZD5LpCXtFNO5KwRCO7wMt8tPChTOr1KC
         sxiybtL+PnoAqQi7Hu1Ou6bsxyx1mYi5x53X8VzdEAC095IZ6oUIOG7NgxDBJFniV8y2
         VxwZeP/CQcdRCqXgoZpASOGTUZgSYcR9SHx9C10ht1BW+RO4npzfnLWb+SSOYKRQs6rI
         t3yiUijmc4O5+pUDycqg9FWE1j3LMHQ1GpB+of1lD1KWOFCc1r4tqTcBU6ZvqKqS/7wb
         yDOBl+tJ8am++d6EKgvbfu+RJLF255mdbJCbwomO4oiFgeivvFKXhl15Fb8jJf0PBBcA
         ATNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0SDsN+zqkLsm+rTbC4y7ru2lS0h30r1n+1k5JCz66M=;
        b=kb2knIDst3769FerjNsWBSBR871/ft49C145QmeqOnjAczxDwj8BXjoRoUmPQFhiz1
         njCcnlX9Fg4goce5LsLZQ53eef9bxEtxt+nXjh2WjDipQ/n3rnwrKd9Zvp1rgECY355S
         ax54R/xUUD8VBQhJIHbwYHad2EtaxXTjX0bvEIQIA71e3sSwUWR5b0NbAM+RlKQA/d+q
         sXAJn9+aF0vM/L+SRbighcMQt6ZyCrzz8OA8W/4Jo1RIS2qwfU9o+9VLZUsnVg8WUVwC
         q4GwTxqTw3qJPKaLqIPo04ZYXjyRX/y2CmqVcPj8tLYoymIXjJlizE9G7gPQS53dFB6Z
         ViJQ==
X-Gm-Message-State: AN3rC/4W1snjtstOW9RGdwEA+ihUTTXe0yI/BJY7vd9OK2i0pruGxmnt
        ubzU5YHAbrWRLj61
X-Received: by 10.84.215.16 with SMTP id k16mr6157983pli.58.1492557506082;
        Tue, 18 Apr 2017 16:18:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 10/11] run-command: add note about forking and threading
Date:   Tue, 18 Apr 2017 16:18:04 -0700
Message-Id: <20170418231805.61835-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All non-Async-Signal-Safe functions (e.g. malloc and die) were removed
between 'fork' and 'exec' in start_command in order to avoid potential
deadlocking when forking while multiple threads are running.  This
deadlocking is possible when a thread (other than the one forking) has
acquired a lock and didn't get around to releasing it before the fork.
This leaves the lock in a locked state in the resulting process with no
hope of it ever being released.

Add a note describing this potential pitfall before the call to 'fork()'
so people working in this section of the code know to only use
Async-Signal-Safe functions in the child process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/run-command.c b/run-command.c
index 615b6e9c9..df1edd963 100644
--- a/run-command.c
+++ b/run-command.c
@@ -537,6 +537,15 @@ int start_command(struct child_process *cmd)
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
 
+	/*
+	 * NOTE: In order to prevent deadlocking when using threads special
+	 * care should be taken with the function calls made in between the
+	 * fork() and exec() calls.  No calls should be made to functions which
+	 * require acquiring a lock (e.g. malloc) as the lock could have been
+	 * held by another thread at the time of forking, causing the lock to
+	 * never be released in the child process.  This means only
+	 * Async-Signal-Safe functions are permitted in the child.
+	 */
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
-- 
2.12.2.816.g2cccc81164-goog

