Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B4820970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbdDNQ72 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:28 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35939 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbdDNQ7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:23 -0400
Received: by mail-pf0-f170.google.com with SMTP id 194so3445868pfv.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c2jyEKEjB2pQU5WHCONXpJE2aVqvt72O4i+YtVqzuAU=;
        b=euV0dNAoqEQriPMaUzR9vVxslH4Cq67rWZoOfjEv6ZfX8efiUGZkD2GJ+MML2cKq11
         56jEw7MhAzyx4b3eWcRBLFHCseHK5KJ8Zju21SlumAHXJ1CXs49ksC1OL+nVjduTmbTi
         aQn2wUj3q5ihocvD2g43J2FfWzFzcOL8cm47OH8At0H0B6iWRKF7/7UcP3B3uigHYYSy
         VewDjbHC1KWbzkVd1mB1mWHsvpRRn38ccB9VC0eri8TyGbXv7KHrnHp3HLxM2b+EUPMd
         hRochoeQpXCZJxeJk1GfKkK2dZOL7Ossuij0Fp084A6/BxulWyxhrsrajD46n69mYeVm
         O7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c2jyEKEjB2pQU5WHCONXpJE2aVqvt72O4i+YtVqzuAU=;
        b=ObAODVv0BLhXIx8HHofwlpF4SJmvkDlYaIby8HcR4HryavqnPy95tR2yoRZDRIvz9+
         zP8M744c/qun9Lzqyfv5AML2oypCZRDFo1UgXQ2afZmoM3pVY61et/f+cq99M6z2Gzrk
         cMZA/4AoNCyQlmTZBQY0zNvitPTBFryryZElrv0b0uRewSndmKSepOduPfGbh84fHVr8
         XVVPiJLxp9irgts65PR52+WsB2J/HpZJcPgC65NpKmfmbF9r4tukru94QoA+VYizLCMh
         oMMjMWXjGVx7b53twP5AXKdF4SdyrP7N8ZQhPMJmhDbiPKWH8g13d4sRjGjGZiCMPymx
         TWAg==
X-Gm-Message-State: AN3rC/5RIuuLcNJuA8z2USOhV7Yn+3OMvFejIITbO+VTSJUrb6v4Evdd
        1LqSUd1wVoE9GHIB
X-Received: by 10.98.61.91 with SMTP id k88mr7920790pfa.62.1492189162750;
        Fri, 14 Apr 2017 09:59:22 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 09/10] run-command: add note about forking and threading
Date:   Fri, 14 Apr 2017 09:59:01 -0700
Message-Id: <20170414165902.174167-10-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
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
index f36eafa8d..d3a32eab6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -557,6 +557,15 @@ int start_command(struct child_process *cmd)
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
2.12.2.762.g0e3151a226-goog

