Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726CCC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 00:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjAPAAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 19:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjAPAAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 19:00:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00918151
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:00:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay40so18933311wmb.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rp2aNyp3RxwrYorEwTV9dJWrc3b6Bu5vsepqF+mMrAA=;
        b=BLJP1kxzxi3xg+ja98CEJoHcjKwoKBuPT4JcV1k2vF6wgiprS4DwEXQ2eQ+EYUDX1f
         SYw70chVzGMv65IBupi1r8eH/YCLWEF7z594t9gBkc3jYNBH4LBynqyedBgegHcQDwb3
         RnClVzzIRGfQceTXWrzFDZhi5jFGJXWJIkezZRm3j7xzTb3S01GCYG2wLZrqp/zKcmlR
         00UB7PCIqx77ureMxVVpoQWTODh1G+ZItZp9TahKfAwMKDr4IQBKa/EMEw4Ff9GgocVg
         +WpHjYMFXRQ5vdtKI8ejlG3wxywP1l1G3Yf0GGFYlrkX7GkVrMC9UjcMlc9bPA+E34jz
         p/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp2aNyp3RxwrYorEwTV9dJWrc3b6Bu5vsepqF+mMrAA=;
        b=vasiVRboEtYM4ebiu9P/EHHpLHoyX+vVdpbMBwiVbaGsjx7a7jewzlH+J2VAFBRRSF
         rmYWUT55ZhZvz+0g4xMGold0/ZdHUHYhQY3K/mQ8I2geTFe12mwgb8nb9zk+SSr7ldww
         WK0kP3DYORm9o5scslxD1yib8zmkiX9/uUX7HdHnA4U26huVxr0/U5286NCdLJHZCOTH
         sOC8UyVt5x3XUKT7PuaHFqMPzOYoTYKZusyXqW3956PNDZxg7gDtxsxlfOdZqeYrrxJ7
         TKRssnLMWwIjjVnwisRfvApgQRoC/92IhTh5JwIY1KU4ujfTNBS189TlHHKslFnRmAoA
         EU7A==
X-Gm-Message-State: AFqh2krufusho2bg32xX8EYUUAPZBZls2Z+zr4MDsDjgh4lpVLd2fxkl
        PVe+/EgKFHEYbwSYna22oU7ztVS15zA=
X-Google-Smtp-Source: AMrXdXsAWnVI70wd3/0F3aa0oH5tJQq81xoKaZwdFRxbbfnSSAAHRy7xqLdLP57jQVgD+yY24UODnw==
X-Received: by 2002:a05:600c:3d10:b0:3da:939:34e9 with SMTP id bh16-20020a05600c3d1000b003da093934e9mr14911198wmb.34.1673827211544;
        Sun, 15 Jan 2023 16:00:11 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003b4cba4ef71sm42573215wmb.41.2023.01.15.16.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 16:00:11 -0800 (PST)
Subject: [PATCH v2 1/3] avoid unnecessary worktrees traversing
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Message-ID: <bc82dd95-c968-146d-0dea-f82631b74765@gmail.com>
Date:   Mon, 16 Jan 2023 01:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"reject_rebase_or_bisect_branch()" was introduced [1] to prevent a
branch under bisect or rebase from being renamed or copied.  It
traverses all worktrees in the repository and dies if the specified
branch is being rebased or bisected in any them.

"replace_each_worktree_head_symref()" was introduced [2] to adjust the
HEAD in all worktrees after a branch rename succeeded.  It traverses all
worktrees in the repository and if any of them have their HEAD pointing
to the renamed ref, it adjusts it.

If we could know in advance if the renamed branch is not HEAD in any
worktree we could avoid calling "replace_each_worktree_head_symref()".

Let's have "reject_rebase_or_bisect_branch()" check and return whether
the specified branch is HEAD in any worktree, and use this information
to avoid unnecessary calls to "replace_each_worktree_head_symref()".

  1.- 14ace5b (branch: do not rename a branch under bisect or rebase,
      2016-04-22)

  2.- 70999e9 (branch -m: update all per-worktree HEADs, 2016-03-27)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..a1ee728ca3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -486,14 +486,17 @@ static void print_current_branch_name(void)
 		die(_("HEAD (%s) points outside of refs/heads/"), refname);
 }
 
-static void reject_rebase_or_bisect_branch(const char *target)
+static int ishead_and_reject_rebase_or_bisect_branch(const char *target)
 {
 	struct worktree **worktrees = get_worktrees();
-	int i;
+	int i, ret = 0;
 
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
 
+		if (wt->head_ref && !strcmp(target, wt->head_ref))
+			ret = 1;
+
 		if (!wt->is_detached)
 			continue;
 
@@ -507,6 +510,7 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	}
 
 	free_worktrees(worktrees);
+	return ret;
 }
 
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
@@ -515,7 +519,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
-	int recovery = 0;
+	int recovery = 0, ishead;
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -544,7 +548,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	else
 		validate_new_branchname(newname, &newref, force);
 
-	reject_rebase_or_bisect_branch(oldref.buf);
+	ishead = ishead_and_reject_rebase_or_bisect_branch(oldref.buf);
 
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
@@ -574,7 +578,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 				interpreted_oldname);
 	}
 
-	if (!copy &&
+	if (!copy && ishead &&
 	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
-- 
2.39.0

