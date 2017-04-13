Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B861E20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755777AbdDMSfc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:35:32 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35081 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755942AbdDMSdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:33:11 -0400
Received: by mail-pg0-f50.google.com with SMTP id 72so25751431pge.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oiyhAc/tXIhOEvI1cZrdltp1R2WyuHcIsAwiatgWBfc=;
        b=VJR86Esb8EMKnMKiObXpHsL5QlKtEVoZ6Dg703tSADJ6oHCM/oOP4twhSBaxuhy7UF
         fuLLgLTOoZ1B3xafp97BtugcH3GJHHkvRoGHeV8NoxICtaZwe0TVkM6f87co73aLGfz8
         6JGgKxBpOvPmUrWDtWPDHEaybc3PgQm73ekq9fxWx6iUPCg+ab2Kh9/UKM3mBIq4Wij1
         ZgG/bm42y6VJiT/bA8qdg6956aTekQ9AOXMKHcQAgzMZTfQXTCpsbvdf1sKc32Tj3Hzq
         kGS8PgcG6JNfjQYVf/6K1NmUnIC0MdVg6lJmw2SsYzj74VH/mw8U+te4FeV7p6d1NdjU
         hB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oiyhAc/tXIhOEvI1cZrdltp1R2WyuHcIsAwiatgWBfc=;
        b=mp/OqAI2TS77e495OCMgWYsBxYUCahgG4FjiTn/gmNHBWQ3VUyL8+QE9X0FC4UD3bz
         THuOln90cYnuhR3KHHATBh/g0hJZTABxy2JUN3/WS1IiDs9iK9Um1ICD5AbHj+MiIOcj
         egl1YjmnDI2HC0t5+1b4nAo3h1w3JJaEaounBU/u3X1hDxv4iuVh3gsCjH7ullnVtXRC
         qv2s4mIv+tWj6Mvi7cG8inguvYentuxdpf33Ioa1AxifEiTWh+xL5qZjX7uNm8NqxcAi
         s1ml+2fnfHLM0F4Da9wBry5llOxD5drZ2BX/tl8KHuC1Gby5xvlq7PP0cG9fyMaD3Xs1
         7icw==
X-Gm-Message-State: AN3rC/4cNrY4zw76zNaO9Q7fGU2hmZsZOasto35iXL2po6IbFp86+w/Y
        gS/tO4qEKs3PSsSs
X-Received: by 10.98.46.134 with SMTP id u128mr4164985pfu.264.1492108390358;
        Thu, 13 Apr 2017 11:33:10 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 201sm43764654pfc.126.2017.04.13.11.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:33:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v2 6/6] run-command: add note about forking and threading
Date:   Thu, 13 Apr 2017 11:32:52 -0700
Message-Id: <20170413183252.4713-7-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
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
index 4230c4933..1c36e692d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -525,6 +525,15 @@ int start_command(struct child_process *cmd)
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

