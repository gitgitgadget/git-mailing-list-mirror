Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB0EC77B60
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCZWdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZWdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:33:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718B5B95
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r29so6790166wra.13
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679869992;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3eEDgVMjqRKrLoyBhLp9klTbhEdzKp+KDFdtTVEKDQ=;
        b=cpFJ0BcY0yPOkbCl8+rBwZ4MATBW1QvKDJ5Avf7PQr6pqJKutMWFxKTdzD5AS6QDra
         TBKW505KbGt/PAm+N+NM8KBB8FcR2xjQjyEZNrtDy9cMjQubLDdsRgVspEdFWEbw06iW
         RhiPLwBi/2mqUCRRq78/ZpIhwj83/Y1wlZpwBkCEHSx1X2UhvZsVOG3my/4UZukuP+f5
         AQuw0OLrcgUfhRos8x5C5u40CnG1lmXkhj/+CF8OtKeihei4vrVtYEAReKQt1TnOgFqx
         4zkxiV7gTVOoCM1C/4jrQuv5D/gQSFvvTDQSDBdjEr5evCMvYWZjCyujg/Va996oHV3l
         lrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679869992;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3eEDgVMjqRKrLoyBhLp9klTbhEdzKp+KDFdtTVEKDQ=;
        b=3gJbtRysYKdKB9NB4asWhLGSiMjasUTd1Km+hU4+SZeLNitW7vEY8dv12NGBeWnFgn
         NuOiLOP/YXiX5vNYuAvZ3uHlgE2CNlk7uHFRLnTnJhFbPa7sg3XLk74H134vUYLL7TAC
         jHPWwpmU8njfQ6EyqFXINVIqSs5lP2Pj8E9mOb1XMq8SvhSqpcC+MwS++H0kajZQ5zav
         A1D7/IPWJHQYvhOE5yJgMy+v6eFLXsEEz4jslzdagybhLecUN9kcPHozQwW1YvYyHZgb
         NHBuCpmoc4mvL+uiqt5gkthdnZjyBy+S3WRHPq2b3bBXPyIaEpiWK6U4smO8qRFK5T6H
         i2JQ==
X-Gm-Message-State: AAQBX9eqYmnbLQPxvDu/ioM1bFNOrgBAT7CX61w38t+d408BrRj8DLcQ
        nmBNX8ZbZ1R3y1P3YjiHSYI=
X-Google-Smtp-Source: AKy350YBIFr6gdPNPRq4Y5vx7s5+xo3j2YW5PG5K0VI+OngoWJsUQR0IU8wMs4XrD9OZeDyPgRZIbA==
X-Received: by 2002:adf:fa92:0:b0:2ce:9e0a:10ae with SMTP id h18-20020adffa92000000b002ce9e0a10aemr8105818wrr.53.1679869992125;
        Sun, 26 Mar 2023 15:33:12 -0700 (PDT)
Received: from [192.168.2.52] (96.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.96])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000008600b002cde25fba30sm23574729wrx.1.2023.03.26.15.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:33:11 -0700 (PDT)
Subject: [PATCH v5 2/5] branch: use get_worktrees() in copy_or_rename_branch()
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
 <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Message-ID: <4b1386fd-1bf7-6fdf-5c0b-49b564b1a7f4@gmail.com>
Date:   Mon, 27 Mar 2023 00:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Obtaining the list of worktrees, using get_worktrees(), is not a
lightweight operation, because it involves reading from disk.

Let's stop calling get_worktrees() in reject_rebase_or_bisect_branch()
and in replace_each_worktree_head_symref().  Make them receive the list
of worktrees from their only caller, copy_or_rename_branch().

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c7ace2f2da..bac67c27d5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -486,9 +486,9 @@ static void print_current_branch_name(void)
 		die(_("HEAD (%s) points outside of refs/heads/"), refname);
 }
 
-static void reject_rebase_or_bisect_branch(const char *target)
+static void reject_rebase_or_bisect_branch(struct worktree **worktrees,
+					   const char *target)
 {
-	struct worktree **worktrees = get_worktrees();
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
@@ -505,8 +505,6 @@ static void reject_rebase_or_bisect_branch(const char *target)
 			die(_("Branch %s is being bisected at %s"),
 			    target, wt->path);
 	}
-
-	free_worktrees(worktrees);
 }
 
 /*
@@ -514,11 +512,11 @@ static void reject_rebase_or_bisect_branch(const char *target)
  * This will be used when renaming a branch. Returns 0 if successful, non-zero
  * otherwise.
  */
-static int replace_each_worktree_head_symref(const char *oldref, const char *newref,
+static int replace_each_worktree_head_symref(struct worktree **worktrees,
+					     const char *oldref, const char *newref,
 					     const char *logmsg)
 {
 	int ret = 0;
-	struct worktree **worktrees = get_worktrees();
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
@@ -537,7 +535,6 @@ static int replace_each_worktree_head_symref(const char *oldref, const char *new
 				    worktrees[i]->path);
 	}
 
-	free_worktrees(worktrees);
 	return ret;
 }
 
@@ -548,6 +545,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
 	int recovery = 0;
+	struct worktree **worktrees = get_worktrees();
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -576,7 +574,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	else
 		validate_new_branchname(newname, &newref, force);
 
-	reject_rebase_or_bisect_branch(oldref.buf);
+	reject_rebase_or_bisect_branch(worktrees, oldref.buf);
 
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
@@ -607,7 +605,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	}
 
 	if (!copy &&
-	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
+	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
+					      logmsg.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
 	strbuf_release(&logmsg);
@@ -622,6 +621,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	strbuf_release(&newref);
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
+	free_worktrees(worktrees);
 }
 
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
-- 
2.39.2
