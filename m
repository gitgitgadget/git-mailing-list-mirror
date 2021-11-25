Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6791C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhKYW5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbhKYWzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:55:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B75CC06173E
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l16so14594782wrp.11
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jW4wAt/AkW1rBXADqj0gqMV7SlS31UouBJBUkvPxdro=;
        b=PgZoLvo0oFzFxSwLsDrnaZAr1Ne2j+WhykG+pQPu6rtgMGjtF81r+ZDoCLDc/algaA
         SWRuyy5khaipE/jLmr9m0TPsH4aeLbfNDiXYxGJ+B5ADHfQLG6sCjzKzWBtqZ5exwqim
         RvRUpYqdy40v5jZzjbhG48mmwDSZTrnysBXWuSRmL7dWLTWvSS6eGj3aM4DP1PnaPdix
         74+s9XjN6/9hmeI8IJY/FYAs900yCpWMfu66jLv+kPumBI8cz7HS23sCmT5l+RDghiT6
         Z0Csc0JZXMNdhLO9gkqpBzHpr4NqweecllqBBK7WtOUQB6irySThwSNN1472b4R8wVsq
         IK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jW4wAt/AkW1rBXADqj0gqMV7SlS31UouBJBUkvPxdro=;
        b=0AohEaDU4+ql47fClILfPZ1/o+ltlkQjrtAU8YBFn/8G3AnJx59rF98pGAbjC3Ohyf
         1tXftJgqqGkZkGJML8jz9aX0mZ+IBDBKd8AVgoCx3aqqwGXC9Hzek0fGPJzayVEL3fFa
         A34JQQ92nbXuMPlQnKXlrK8kQCUQYYEeNBc4w0jIBaGTrEJlgGlJvo+yP66xedxeiBzl
         AciqvyflYDfahjWQ5a4NSygOX7UBGr4LebwTh0hQznIMVuHhwkDM2vY0i2Ebl5EQkq0d
         kuFqjRJYe4luQGh+0U7Ls3pFKEPplyp+/C6pQHfQNu4+n6a0tqz5jCJ6MAOHjETPBKDo
         12Xw==
X-Gm-Message-State: AOAM530hHYIYzu4kcE+Wf6iEkbSstzqAgqPQabszk4GqNxid9F4ghat5
        eJ2mMkjVDt4KA8SF6zGg0CZhuJ8/ydRZoA==
X-Google-Smtp-Source: ABdhPJz6JpmH0OEr5RyMNGO7h6P142Av0PPyvQEZxokbroldE8sGAaAxldCicyzP2fg7nuNHP1cFew==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr10027658wra.557.1637880748769;
        Thu, 25 Nov 2021 14:52:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] worktree: stop being overly intimate with run_command() internals
Date:   Thu, 25 Nov 2021 23:52:16 +0100
Message-Id: <patch-v3-1.9-1c3f9de33ad-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

add_worktree() reuses a `child_process` for three run_command()
invocations, but to do so, it has overly-intimate knowledge of
run-command.c internals. In particular, it knows that it must reset
child_process::argv to NULL for each subsequent invocation[*] in order
for start_command() to latch the newly-populated child_process::args for
each invocation, even though this behavior is not a part of the
documented API. Beyond having overly-intimate knowledge of run-command.c
internals, the reuse of one `child_process` for three run_command()
invocations smells like an unnecessary micro-optimization. Therefore,
stop sharing one `child_process` and instead use a new one for each
run_command() call.

[*] If child_process::argv is not reset to NULL, then subsequent
run_command() invocations will instead incorrectly access a dangling
pointer to freed memory which had been allocated by child_process::args
on the previous run. This is due to the following code in
start_command():

    if (!cmd->argv)
        cmd->argv = cmd->args.v;

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1a..9edd3e2829b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -355,8 +355,8 @@ static int add_worktree(const char *path, const char *refname,
 		goto done;
 
 	if (opts->checkout) {
-		cp.argv = NULL;
-		strvec_clear(&cp.args);
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
@@ -385,12 +385,11 @@ static int add_worktree(const char *path, const char *refname,
 		const char *hook = find_hook("post-checkout");
 		if (hook) {
 			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
-			cp.git_cmd = 0;
+			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.no_stdin = 1;
 			cp.stdout_to_stderr = 1;
 			cp.dir = path;
 			cp.env = env;
-			cp.argv = NULL;
 			cp.trace2_hook_name = "post-checkout";
 			strvec_pushl(&cp.args, absolute_path(hook),
 				     oid_to_hex(null_oid()),
-- 
2.34.1.838.g779e9098efb

