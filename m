Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC0C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 22:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjBVWxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjBVWxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 17:53:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836739ED5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:52:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso8076154wmq.4
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy9PG4ymZttK7WhV8ZB6ueplODNVKldX8VCC8f6NrzE=;
        b=WrjXIIBndnlH+5S8Hu3qdbdC/dRT5Kz+7FFdsu9W0li025zsQr6jlLBF1NVLbftx8z
         Vo2qqusTJ+yDRHXwLwIIAEgk+Zl9VY39yLy2lN0rd561CKjf6e8f4Qg6C/zhZxRQKGo6
         MTGQ8Lkik7021mkUCHNP2K3xCjmy1UmOr11f7r+beHQXyPGspW7pPSw7L9m5vQPfNuZJ
         9tb+ZfbDsVrffiNaRqUQ+PHCAVk0PHnjXkvlreqOdRDioidGCTrFQ15CRHGycRQP70vO
         JDALhevSuuUi6mYvDN4JQqcdLrjYnai3lQCq4olEyF05huQKVpn9AOOOJbeCVbGmkXgu
         FDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy9PG4ymZttK7WhV8ZB6ueplODNVKldX8VCC8f6NrzE=;
        b=sk8iloz+y+UVm8buCgYXTgrXkmQEZ2Ic33wHvjoXRZ8Ex5/+CV8rV4lJM4rHudNxmJ
         CH+oTTyv2XglBO9/YGmV0iXMJIv6OYlhndUVZEyTso7HzChQtI1YY9C+w0JLKdsJnTez
         Kler2lCY1lmvEv+qEqbyT8bpU6uB+ZI03P/sXbbGSlg59Ylo9KvTkhjov7c0nlwOWmsU
         9GEcRY5jp8HBk1e/MWx4t6rQL4GYkcg7Z0SxHW+Xnzkfr53uZNZ/CvVPY4s5178Jr2Us
         W+qbqbM4NZqahfMNi1lak2g4XT51SB1jK7z7q8IhyH+mIWExp1zeR4UpHa0GqGBHlbgC
         5PFw==
X-Gm-Message-State: AO0yUKWXyn1+/3SX3Zakt+TFVSgp1Bk4wf+eXuMw5RjvoLeuykbEyTFd
        1zRwbWhYMGTQIhiPnuv47gFJdKwvn7I=
X-Google-Smtp-Source: AK7set8F+ALt3ERYbK9WOt2DEStMKHOL3x09wPWyCYYFUdohB/QcrcmmDG84nEIaJz2xL26/62HK6g==
X-Received: by 2002:a05:600c:a692:b0:3db:2858:db84 with SMTP id ip18-20020a05600ca69200b003db2858db84mr7281317wmb.34.1677106372926;
        Wed, 22 Feb 2023 14:52:52 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003e206cc7237sm10461168wms.24.2023.02.22.14.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:52:52 -0800 (PST)
Subject: [PATCH v4 1/3] branch: avoid unnecessary worktrees traversals
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Message-ID: <50dd7c7a-5656-e010-1c0b-819a40a1f1a0@gmail.com>
Date:   Wed, 22 Feb 2023 23:52:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
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

Considering that both functions are only called from within
copy_or_rename_branch() and each of them traverses all worktrees, which
might involve disk access and resolving multiple references, inlining
these two functions to do the traversing once, makes sense.

  1.- 14ace5b (branch: do not rename a branch under bisect or rebase,
      2016-04-22)

  2.- 70999e9 (branch -m: update all per-worktree HEADs, 2016-03-27)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c         | 27 --------------------
 branch.h         |  8 ------
 builtin/branch.c | 64 ++++++++++++++++++++++++++++--------------------
 3 files changed, 38 insertions(+), 61 deletions(-)

diff --git a/branch.c b/branch.c
index e5614b53b3..f64062be71 100644
--- a/branch.c
+++ b/branch.c
@@ -830,30 +830,3 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 
 	free_worktrees(worktrees);
 }
-
-int replace_each_worktree_head_symref(const char *oldref, const char *newref,
-				      const char *logmsg)
-{
-	int ret = 0;
-	struct worktree **worktrees = get_worktrees();
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
-		struct ref_store *refs;
-
-		if (worktrees[i]->is_detached)
-			continue;
-		if (!worktrees[i]->head_ref)
-			continue;
-		if (strcmp(oldref, worktrees[i]->head_ref))
-			continue;
-
-		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_create_symref(refs, "HEAD", newref, logmsg))
-			ret = error(_("HEAD of working tree %s is not updated"),
-				    worktrees[i]->path);
-	}
-
-	free_worktrees(worktrees);
-	return ret;
-}
diff --git a/branch.h b/branch.h
index ef56103c05..30c01aed73 100644
--- a/branch.h
+++ b/branch.h
@@ -155,12 +155,4 @@ int read_branch_desc(struct strbuf *, const char *branch_name);
  */
 void die_if_checked_out(const char *branch, int ignore_current_worktree);
 
-/*
- * Update all per-worktree HEADs pointing at the old ref to point the new ref.
- * This will be used when renaming a branch. Returns 0 if successful, non-zero
- * otherwise.
- */
-int replace_each_worktree_head_symref(const char *oldref, const char *newref,
-				      const char *logmsg);
-
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..a32ae64006 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -486,28 +486,6 @@ static void print_current_branch_name(void)
 		die(_("HEAD (%s) points outside of refs/heads/"), refname);
 }
 
-static void reject_rebase_or_bisect_branch(const char *target)
-{
-	struct worktree **worktrees = get_worktrees();
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
-		struct worktree *wt = worktrees[i];
-
-		if (!wt->is_detached)
-			continue;
-
-		if (is_worktree_being_rebased(wt, target))
-			die(_("Branch %s is being rebased at %s"),
-			    target, wt->path);
-
-		if (is_worktree_being_bisected(wt, target))
-			die(_("Branch %s is being bisected at %s"),
-			    target, wt->path);
-	}
-
-	free_worktrees(worktrees);
-}
 
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
@@ -516,6 +494,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
 	int recovery = 0;
+	struct worktree **worktrees = get_worktrees();
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -544,7 +523,20 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	else
 		validate_new_branchname(newname, &newref, force);
 
-	reject_rebase_or_bisect_branch(oldref.buf);
+	for (int i = 0; worktrees[i]; i++) {
+		struct worktree *wt = worktrees[i];
+
+		if (!wt->is_detached)
+			continue;
+
+		if (is_worktree_being_rebased(wt, oldref.buf))
+			die(_("Branch %s is being rebased at %s"),
+			    oldref.buf, wt->path);
+
+		if (is_worktree_being_bisected(wt, oldref.buf))
+			die(_("Branch %s is being bisected at %s"),
+			    oldref.buf, wt->path);
+	}
 
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
@@ -574,9 +566,29 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 				interpreted_oldname);
 	}
 
-	if (!copy &&
-	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+	if (!copy) {
+		/*
+		 * Update all per-worktree HEADs pointing at the old ref to
+		 * point the new ref.
+		 */
+		for (int i = 0; worktrees[i]; i++) {
+			struct ref_store *refs;
+
+			if (worktrees[i]->is_detached)
+				continue;
+			if (!worktrees[i]->head_ref)
+				continue;
+			if (strcmp(oldref.buf, worktrees[i]->head_ref))
+				continue;
+
+			refs = get_worktree_ref_store(worktrees[i]);
+			if (refs_create_symref(refs, "HEAD", newref.buf, logmsg.buf))
+				die(_("Branch renamed to %s, but HEAD is not updated!"),
+					newname);
+		}
+	}
+
+	free_worktrees(worktrees);
 
 	strbuf_release(&logmsg);
 
-- 
2.34.1
