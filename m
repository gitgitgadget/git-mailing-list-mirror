Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57C41FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 23:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbcLBXnU (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 18:43:20 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33160 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbcLBXnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 18:43:17 -0500
Received: by mail-pg0-f47.google.com with SMTP id 3so112516719pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/JNBCg6xMHvh1EnQXYuezIJ9QYZVemyhEwVTaRaJdxg=;
        b=OOHKK6F9CXlzyX9//KXbBaMRdMfp2nEQdqShWRWsXcXV/OUI9G9Rg7ZwgMeP03N5/j
         /39wW3M//4fKHK5Q1tPn7D0ULw/wV9c06zabt7UJ1jl7P65ojVAn3PnViQORtOow5kA3
         HcR+bXKd7G13IqRNsSI/UEDZuehnvbt1OMLtRWUCQWfLUw0qMb3vxFDG8qClGpOiax/D
         J2FVxbO7aVXv8HcnIHHrbK1gFogICGc1dVPBroQW6eiGZ9WNABNOt6uDjYcGWGWIjBQq
         vszx3kAiSIfAPHXbJPJmkXjAr5LxBj0Bor7fAjK8LBsFqWsUvYCIBgh1JHEMixqQQcCW
         41hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/JNBCg6xMHvh1EnQXYuezIJ9QYZVemyhEwVTaRaJdxg=;
        b=Rdy27bSRofNLjl+/Q6YemPNHIwQbD6h6K74aY/os8fIwM4xHbds41v/IFRKJNhoxpB
         O88OeCyxMb4mflPyU3EAdf61MakdD6U02Cn81QpmimhLr+Y6B/kKDX1pW02Qt1tOBbFd
         LTN2zho8fweoGjOEIhUlHFnIYCqob2tpgLfbXwbbPCtrS6RTEdypSMqVI46L1sUZ3Ie/
         iWWWfr6Xm3tiDFC1yVnchxG75o/vsxpSDbBw2ZYsHL04BJ/mfXbqXWl2NYT0ALXSqM3r
         7OLCOc/2bulLn+K6XPF145HNoyhpTayUisl9wXLheAUeT6Qvn0pHpcpqluRM9RJa2Ozi
         xshQ==
X-Gm-Message-State: AKaTC023M5wgJLPkW+jw0ku1EMWZUsvyWNrQeJTKZ5SdAh0rqI7Hh6WKSNHPZacvxArRVPiT
X-Received: by 10.98.61.152 with SMTP id x24mr46736854pfj.88.1480722145358;
        Fri, 02 Dec 2016 15:42:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id a68sm10142655pgc.31.2016.12.02.15.42.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 15:42:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/5] submodule: use absolute path for computing relative path connecting
Date:   Fri,  2 Dec 2016 15:42:16 -0800
Message-Id: <20161202234220.24664-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161202234220.24664-1-sbeller@google.com>
References: <20161202234220.24664-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current caller of connect_work_tree_and_git_dir passes
an absolute path for the `git_dir` parameter. In the future patch
we will also pass in relative path for `git_dir`. Extend the functionality
of connect_work_tree_and_git_dir to take relative paths for parameters.

We could work around this in the future patch by computing the absolute
path for the git_dir in the calling site, however accepting relative
paths for either parameter makes the API for this function much harder
to misuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..66c5ce5a24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
+			       relative_path(real_work_tree, real_git_dir,
 					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(real_work_tree);
+	free(real_git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.11.0.rc2.28.g2673dad

