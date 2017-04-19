Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E801FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940322AbdDSXOK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:14:10 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33989 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940316AbdDSXOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:14:08 -0400
Received: by mail-io0-f180.google.com with SMTP id a103so42692047ioj.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0SDsN+zqkLsm+rTbC4y7ru2lS0h30r1n+1k5JCz66M=;
        b=rXVK432udUeCvYYnFCFmCKTUGmk/17MYRbFay3ODsribc9wbvNQvgYkOfgue0FTOBJ
         Q9vEU52MPzcY4g90ChSlJ6XCmkpzvB6poF/z/3F6VVdneCzeHKJhs0rRwEXvGqCTv6Bd
         MIiRzlHyZtvJZEIi0pMwehbJuiWnchvbxORbd2tu5VVC7yFxs4sytlhrsRNKQcxRAPud
         FBc1qw+TFq316qQ6tay+Qzpxl/nBUrJv+25kg+UYO3G8BJ8NqKxrVULQiyON9QsArF7t
         maY7d6/lm4a6yLPT9gm7faMkQRVlLUtmKpSbMGaeuy8m4Wzn1NbOV1I8a1tINDqvsdyf
         dVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0SDsN+zqkLsm+rTbC4y7ru2lS0h30r1n+1k5JCz66M=;
        b=ZBHBXMQfCWOPzxVRLRyt14wpXn8Q3zA04VGieJjPxIckiidCBlmeZBaErgTW763+Cz
         hcHYCV2d4SYt4cZHCXojYUHT8sNndkf26t8edFcK4Ytz16f0p/M5Icqkldlwf5sqi4BE
         Si3MFSCvG7p3RO/lBLVtKizA2OzK3ZxGR4+bMNqg0sDHvsfon0JxDBxaOSk3sHzF4LbI
         W0N8SdCPXmNPfR0qXf4lFekHVzWJSjfqsafVamGEAVtF/jMyUUka20m7rwX3W7btvL4g
         g9XMpJLqXZkMjv1G95IkmVMUw1Vm5pFZkTO4neUbUDwUrOtxKa7fUnpBG6TAOwcqxuth
         3Mnw==
X-Gm-Message-State: AN3rC/5hED2Ob5oIAHvaocnQOvXzd7hxGr1wpn9eu/v0K2/8FWwN3PIp
        DyQLy2xbp25cpgFw
X-Received: by 10.84.169.67 with SMTP id g61mr6780539plb.51.1492643629496;
        Wed, 19 Apr 2017 16:13:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 10/11] run-command: add note about forking and threading
Date:   Wed, 19 Apr 2017 16:13:26 -0700
Message-Id: <20170419231327.49895-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170419231327.49895-1-bmwill@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
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

