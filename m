Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3755420960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbdDJXtg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:49:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34943 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdDJXte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:49:34 -0400
Received: by mail-pf0-f180.google.com with SMTP id i5so40206864pfc.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/HZISRTpvYHYIp98Z09QG9oWLbCtF0AHFib4N/wAOUY=;
        b=g79QojF1MxFZPd4sqDvVzfiK057AwBKPPwouIMC6YkjY8/uAahudPYAlcxv5zyx0gs
         3uAS10hLRGz4zvrpFpKDsFkMRa1aTBw16qigxu/NKb8bCZVpukjXa6mzBOjhNVjuBlJ0
         0WvWjm6yBKd17eZ4KJhAVq5f9Z1BA5hh4a/MTu8UBlNkd8wQrcD7rMcJquoNMgHlnAhb
         kOZc78Ynj26kMJAEIA0T1HAvhaq7OejzniMAxfDZasqeRN0iB0YOitw3MlaUcdkNirku
         9LDS6BQvdSOcgxT5rwG42RwE26/4TBJxAVO67pbOrYkZmULDziV/7VX+zpJw3q/hnnvU
         G1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/HZISRTpvYHYIp98Z09QG9oWLbCtF0AHFib4N/wAOUY=;
        b=ntBPhWuCcxETulK+3L4yDTIEEK5BWt/32kfIXiNJYwXLf6Q51X6K4gXf35ypSkJXag
         SSe+v6/alZUeaNMfECgtErvJ8CO6AUpiWtjxWL2COQErfC8TQEsNqyo2LqaugW2Wd9rt
         ux+yam+kxDRD9hLy2RiQZWF/nvIcpy4XGpHMsDsRS1SrW+t1RbU3LM265FADLpIr/1U+
         loW8/GhfdMPXbpI/N5ippd5AAqQpiVEqhP3WJMdEvZPE1jkHIMTZ6DOkCz0wvexZLhfD
         g9mte9Bp9tYfL/7Cn18NCMJGlDAUoPPw/RnBEYfm2CRJ+iVqJt2/7Nk/CcrMLFg6n6CR
         C1ew==
X-Gm-Message-State: AFeK/H1XRjlNkiGhj8SGv9+Jmf7CSvDW9rtzpV1gScbNjjDqh24kEpEPHAoped1zu1WP4Uyh
X-Received: by 10.84.174.131 with SMTP id r3mr71966452plb.136.1491868173743;
        Mon, 10 Apr 2017 16:49:33 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x204sm26225132pgx.63.2017.04.10.16.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 16:49:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 5/5] run-command: add note about forking and threading
Date:   Mon, 10 Apr 2017 16:49:19 -0700
Message-Id: <20170410234919.34586-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allocation was pushed before forking in order to avoid potential
deadlocking when forking while multiple threads are running.  This
deadlocking is possible when a thread (other than the one forking) has
acquired a lock and didn't get around to releasing it before the fork.
This leaves the lock in a locked state in the resulting process with no
hope of it ever being released.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/run-command.c b/run-command.c
index 84c63b209..2b3249de4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -458,6 +458,14 @@ int start_command(struct child_process *cmd)
 		argv_array_pushv(&argv, cmd->argv);
 	}
 
+	/*
+	 * NOTE: In order to prevent deadlocking when using threads special
+	 * care should be taken with the function calls made in between the
+	 * fork() and exec() calls.  No calls should be made to functions which
+	 * require acquiring a lock (e.g. malloc) as the lock could have been
+	 * held by another thread at the time of forking, causing the lock to
+	 * never be released in the child process.
+	 */
 	cmd->pid = fork();
 	failed_errno = errno;
 	if (!cmd->pid) {
-- 
2.12.2.715.g7642488e1d-goog

