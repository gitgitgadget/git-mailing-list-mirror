Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5EC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBFXGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBFXGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:06:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F39EFBA
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:06:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so173271wms.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pB4yR6vlDAzMbAnUQV5ZCEyJTO90c6Jn5v02t2eAIAs=;
        b=RYteJ3mdhQKFItpNdGbXthCBqMqsAUYatArSWUzRpSEAH5YedJrftwBCGWUgeiR57K
         +Xdzi/ci23CD1H1p7StlaxW68AAYsP8LcEjhZePeCKXV+hSyrdb5NO4nyYxBU1TWb1VX
         6utlLVKkAX5+gnNeOJ4h/Nw41WFwyLLKlfpk8Fco9m/wTnjMIgI7GVGayv6YEJA+w3h1
         LlVo/DRmbmfRVR9dcqX0I8a5JGpSjtBtaopJCzyvYqGf8YQnmpZUG32zdRPVpt5qYHgZ
         /jhMG8GjnnpE/hlayRzk+w+PA9/zA99FwG9G1bykSaqDVF/i1ganhhePWjklgRE2ww1F
         qkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pB4yR6vlDAzMbAnUQV5ZCEyJTO90c6Jn5v02t2eAIAs=;
        b=bbZGKyQ579VfmXHRbYuDpKEkYd2FKahLg4gJf7/69TS1sG+aBOkybPAs8Bn4DargSy
         KNlHY09c5obTFF+mv4UigHY9CNY0FLueXBaEtYsOefhR4SagRH8JqnzyuUeARJ50knqT
         Aa58EAmbH0T1oi+Yaa6PKbIDGoIXDnCI23k20C6DAj6Ge39KKz5Z39BcJbUSWAisffh7
         D8CNttTaJ1ASv/Qc6JcW3b2mdk3gUykJsJLh5236WxlDvYeLTCksBGLcLVbNtnXFS64d
         sBqMmKsAGQU6PgJ7r71LgVNopnALQuK11d/6aWBRnM8cyHWTzT7VfmavIt/PHJmjtCrm
         qVEQ==
X-Gm-Message-State: AO0yUKXc3xQp+7YR7hHMDU2KLpgJNwJw9jTRKWkLu+6Ll6AeXrGq2wAz
        g5qg1qu7d4NtE079yt8hy6E=
X-Google-Smtp-Source: AK7set+oG66oTUssY12Z0lJBB5MLm7Qnlkf4UDjcRXDpKuAfVFFSfUuqomMDLcDGgNWV2vRsfDyc4Q==
X-Received: by 2002:a05:600c:331c:b0:3dc:5ab8:7d74 with SMTP id q28-20020a05600c331c00b003dc5ab87d74mr1229167wmp.3.1675724774209;
        Mon, 06 Feb 2023 15:06:14 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b003d9aa76dc6asm18441017wms.0.2023.02.06.15.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 15:06:13 -0800 (PST)
Subject: [PATCH v3 1/3] branch: avoid unnecessary worktrees traversals
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Message-ID: <f284e163-5476-0c38-106c-094080340f71@gmail.com>
Date:   Tue, 7 Feb 2023 00:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"reject_rebase_or_bisect_branch()" was introduced [1] to prevent a
branch under bisect or rebase from being renamed or copied.  It
traverses all worktrees in the repository and dies if the specified
branch is being rebased or bisected in any of them.

"replace_each_worktree_head_symref()" was introduced [2] to adjust the
HEAD in all worktrees after a branch rename succeeded.  It traverses all
worktrees in the repository and if any of them have their HEAD pointing
to the renamed ref, it adjusts it.

If we could know in advance if the renamed branch is not HEAD in any
worktree we could avoid calling "replace_each_worktree_head_symref()",
and so avoid that unnecessary second traversing.

Let's rename "reject_rebase_or_bisect_branch()" to a more meaningful
name "die_if_branch_is_being_rebased_or_bisected()" and make it return,
if it does not die(), if the specified branch is HEAD in any worktree.
Use this new information to avoid unnecessary calls to
"replace_each_worktree_head_symref()".

  1.- 14ace5b (branch: do not rename a branch under bisect or rebase,
      2016-04-22)

  2.- 70999e9 (branch -m: update all per-worktree HEADs, 2016-03-27)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..89198fa5bf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -486,14 +486,21 @@ static void print_current_branch_name(void)
 		die(_("HEAD (%s) points outside of refs/heads/"), refname);
 }
 
-static void reject_rebase_or_bisect_branch(const char *target)
+/*
+ * Dies if the specified branch is being rebased or bisected.  Otherwise returns
+ * 0 or, if the branch is HEAD in any worktree, returns 1.
+ */
+static int die_if_branch_is_being_rebased_or_bisected(const char *target)
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
 
@@ -507,6 +514,7 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	}
 
 	free_worktrees(worktrees);
+	return ret;
 }
 
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
@@ -515,7 +523,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
-	int recovery = 0;
+	int recovery = 0, oldref_is_head;
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -544,7 +552,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	else
 		validate_new_branchname(newname, &newref, force);
 
-	reject_rebase_or_bisect_branch(oldref.buf);
+	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
 
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
@@ -574,7 +582,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 				interpreted_oldname);
 	}
 
-	if (!copy &&
+	if (!copy && oldref_is_head &&
 	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
-- 
2.39.0
