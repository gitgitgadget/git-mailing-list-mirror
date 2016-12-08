Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C92D20259
	for <e@80x24.org>; Thu,  8 Dec 2016 21:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbcLHVEG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 16:04:06 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35560 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbcLHVEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 16:04:05 -0500
Received: by mail-pg0-f51.google.com with SMTP id p66so177696835pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 13:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zlueNzl2BqG2Wa5Drnr0Gy+U6KwIjo+x7IrRUfo8BYk=;
        b=MG3NpldRp1bZ33922xx33YxWQq6dia5jJNsUP++XL3A1zs6Qz1MrE0qg+jCOAMksDB
         z8f/FDY29fo88E+DTb27zdWEBCDEA+vj4yBKO1vCjSuD36cbg46tzsB3KwoSW8jXXKzM
         2MXZWSSuMgtzAVwo2Md3GHNhePX1ppHzcmm88gagNPrYHGxxaTvmr4prTA9xTmwIiKGj
         a1dLYZnkuLCRtreg+kUcGcZACdptm4AYQRGorEFhSgCPznFSTR8Q7c29gkB3BIOmGoiR
         +S0p4dUGFw6b00gHQcrSYw9/kWRB0zvrn9+o5H92/IVyfjWmP/cC3gP27dfzjuAfPWl8
         eBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zlueNzl2BqG2Wa5Drnr0Gy+U6KwIjo+x7IrRUfo8BYk=;
        b=MX4GGM+Ob/SeXx39bihhMiIwOvmXFVHVVXkKzP/c0zzrlvRHl9vnF873sB13exbaqL
         tTfz6hauUP18rK21Nv0fkvNiIH+w5xnh84k1DHHftVxd6DRfRavk3JSfejfok7Z2TAmS
         9jTI7fpLSSUqlHVOgpAQhCLzMcv0MmjbZc+K1LsYgia+5sDj0pnyNz+xfj86CzjvJhew
         x3vq/8sO+tohCM5JpMMqKtJy4pqchNnCLRSBVDM3FsJUajv+lZ7N3en83V7PA1/vcLqY
         zOEtlgVbi9zA3ClcuneTTC9yQNtzziOHoxtMsdJrfhlKhs2o1U486e1U0pPS17K6lRX1
         oqMA==
X-Gm-Message-State: AKaTC03hOgwYioscvASFuBQ7vvYRLF2/2UeV1xZgo8hxdvSmlFXDCz9RiWp+Y8Mr7yX5JVlm
X-Received: by 10.99.184.18 with SMTP id p18mr18310051pge.33.1481231014514;
        Thu, 08 Dec 2016 13:03:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6884:a3d1:aaf8:234b])
        by smtp.gmail.com with ESMTPSA id y29sm52199550pfd.63.2016.12.08.13.03.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 13:03:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 1/6] submodule: use absolute path for computing relative path connecting
Date:   Thu,  8 Dec 2016 13:03:24 -0800
Message-Id: <20161208210329.12919-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.29.g7c00390.dirty
In-Reply-To: <20161208210329.12919-1-sbeller@google.com>
References: <20161208210329.12919-1-sbeller@google.com>
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
---
 submodule.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..d4f7afe2f1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1223,27 +1223,28 @@ int merge_submodule(unsigned char result[20], const char *path,
 }
 
 /* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
+void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *git_dir = xstrdup(real_path(git_dir_));
+	char *work_tree = xstrdup(real_path(work_tree_));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(git_dir, work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
 	strbuf_addf(&file_name, "%s/config", git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
-					     &rel_path));
+			       relative_path(work_tree, git_dir, &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(work_tree);
+	free(git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.11.0.rc2.29.g7c00390.dirty

