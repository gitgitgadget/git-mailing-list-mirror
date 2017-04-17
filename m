Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C2D1FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756814AbdDQWIv (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:51 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33330 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756864AbdDQWIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:47 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63so17801745pgh.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/DNHcYtE2IuXVPoSeJ9ZBcwvJgMHNRY9rL/HXUTJZM=;
        b=SdZUiw7KD33QZiFWiwhDPOQhNWGU4uXRTSU7EzGd6nx+Kh4TAfgCIKy9eGt52Cek0K
         axaCDtKbs/PJ+QYamh5u0WgTCAr1KeangZuZfdbvvCzmu4osTwyWZICQ9pLUve+zCqLL
         3aH7PELfHjGtn4UHYspAr1yA4rmMnrXvqBPxfr7r/pnenYMgjOY31XgNp8I4KZBqEJ6d
         y4tbzVwUcubzFCy+Uu3aYmX3jjiC2cDo7g+IJdqSwaM8Y+YgZnajAH44NO7kqXGpzcI0
         tWshVsmR/5dtIWpA9Q8gHCBmS0b4elUGBO8ZyWDEHkpqFi9ALgUs24OfOe62pSDWZwcl
         bKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/DNHcYtE2IuXVPoSeJ9ZBcwvJgMHNRY9rL/HXUTJZM=;
        b=iRu2+8IBXLzfXmTHYs8PuldvwtJt4zk30dbPGCgg+hHLb+Lio9+03ta+3DQZBeW//x
         WoQPZXo6mdZGpRArNCgxqOciqSVGGF7ZCd2cigezhPEnvVLQAZe91sEaK1+k+ttEh3R4
         LfR9WMGu0uqSfXhfYHg8Eank6m9vMHdVIdQc2NPZfLWUQYBBuPuXpZRv+8RvuKXDKzby
         ZqbwewWpZ7hEqetHDkPmIAI7/2cdVKLQa//I0PFrBRNeJJyXZpB/EtDFWjWrs5LR1E8Z
         Kn1aJpcK3TuCLVIUpOquMf+gh4SH+GzAQYMCuFAwfGRIVnE9sksdT7H6VhI+IXIEBu1v
         AM5A==
X-Gm-Message-State: AN3rC/4UFj5y6pELOBcFrsjlJhDuhUaGSuO23OzMkB3W2y2NBKxEYRtx
        t2JIElWL7a7FPDSX
X-Received: by 10.98.197.194 with SMTP id j185mr13910749pfg.239.1492466921558;
        Mon, 17 Apr 2017 15:08:41 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:40 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 09/10] run-command: add note about forking and threading
Date:   Mon, 17 Apr 2017 15:08:17 -0700
Message-Id: <20170417220818.44917-10-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
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
index bd6414283..c27c53bc5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -558,6 +558,15 @@ int start_command(struct child_process *cmd)
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

