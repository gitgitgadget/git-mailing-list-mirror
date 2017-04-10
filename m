Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBBB920960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbdDJXt5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:49:57 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36100 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753309AbdDJXti (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:49:38 -0400
Received: by mail-pg0-f52.google.com with SMTP id g2so111803726pge.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=koqVjJetV3u4PMCf0qvek2eMJSSl0cfTfTbNgjd0kzM=;
        b=UpgJ01oayQJMPLeLWVKQFONHwyf5XkUORBMt5Czlue1nsgqA3o9j+d8Kkl7UrJnLXc
         oDekGKc5G3Q0iy8fsRSxUiXimIkmJnzk7uVW8iBymxyuYJV/ogmarDmRFK9C67ESwacr
         17JoHMJ+rmZMo+oef+be90gxCch2hY+HER/aCHjXyU5RqVnb2/jk0e51KahMas2htT9l
         GGhH875ZgKofEJf6t3S46yM9Ap1wy333uPJQBYuJ8jtqpqVGxTTKHZzuvoZLHrRrh6+1
         XbaZytyIMyAbOtEiDgcOQgrmWUr9FSYahP4D4vswUgO8eQvXMwm9NRLpBDZy3QAr+SA5
         V8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=koqVjJetV3u4PMCf0qvek2eMJSSl0cfTfTbNgjd0kzM=;
        b=jecVC//hjzOlJcnOdd2Qfw1LMGTc46DYKGjsdTglksuldF6ZzIbr1GNydLjIdFBQ+G
         QKEOcLezp+t3L5HiwncZc8CNuO2lcyuY6VkMSIyf+7ZtPPegXe1sKkwzkUWGEixBYq/5
         FfXR++xpRkJgZPvvQAc0yHKtJI5DjJZZZjj6MK8rBqArvSPJvjby3Xg+cMAOy0GPzpP1
         zlLV9AhuZ3kugw8ara9IZdNecIKMLeRtoY+517uK/erYH0FZK0aFk6sf5aq+CSL3122g
         ZK6fb9cKaLTIJ2A0EGCo+N5G9/bJ+mR0Crr3piQiyOixEIJ8dLvxXE5U1BNkMaAtvEJt
         B9tQ==
X-Gm-Message-State: AFeK/H3edrGTrwYkEXsWsCbA3PLB0Owc4mx4Q4Yq2pyjomDSgXOoU73UknWVLDK9yaWYJGJt
X-Received: by 10.98.101.7 with SMTP id z7mr57311363pfb.81.1491868171049;
        Mon, 10 Apr 2017 16:49:31 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x204sm26225132pgx.63.2017.04.10.16.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 16:49:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/5] run-command: allocate child_err before forking
Date:   Mon, 10 Apr 2017 16:49:17 -0700
Message-Id: <20170410234919.34586-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid allocation between 'fork()' and 'exec()' open the
stream used for the child's error handeling prior to forking.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2514b54bc..029d41463 100644
--- a/run-command.c
+++ b/run-command.c
@@ -365,11 +365,18 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	FILE *child_err = NULL;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	if (cmd->no_stderr || need_err) {
+		int child_err_fd = dup(2);
+		set_cloexec(child_err_fd);
+		child_err = fdopen(child_err_fd, "w");
+	}
+
 	if (cmd->git_cmd) {
 		argv_array_push(&argv, "git");
 		argv_array_pushv(&argv, cmd->argv);
@@ -387,11 +394,8 @@ int start_command(struct child_process *cmd)
 		 * before redirecting the process's stderr so that all die()
 		 * in subsequent call paths use the parent's stderr.
 		 */
-		if (cmd->no_stderr || need_err) {
-			int child_err = dup(2);
-			set_cloexec(child_err);
-			set_error_handle(fdopen(child_err, "w"));
-		}
+		if (child_err)
+			set_error_handle(child_err);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
@@ -477,6 +481,8 @@ int start_command(struct child_process *cmd)
 	}
 	close(notify_pipe[0]);
 
+	if (child_err)
+		fclose(child_err);
 	argv_array_clear(&argv);
 }
 #else
-- 
2.12.2.715.g7642488e1d-goog

