Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9EAC61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 23:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBDXZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 18:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBDXZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 18:25:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CAE21A3C
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 15:25:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso6325974wms.4
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYtFSzEGfzzrCxiWW05PuL5+G1crhD/FYztyx3bFnms=;
        b=pDpIZLVfTcmmy/xH/xqKXFqnW7ASjM6FKmY4azqvN2ku9cY6+y0duXklwzdjVXVZgI
         mTVdPnN5Y4JaZMpO1aF1p22zv/ONlF+jVUyWZlbkx9IBsO2tqjmeX+Am8dBDrU56rHQ6
         lMz+iSc6xQUm4djR9oq0bPovWDD/3HnyQ/LDZwRqa0WLiqWVKe72zDhjBWbUy0xquZwU
         9lrb6Odl0uIGiap4Iw5lx5URWbkOUy4GpIr9ijcoV8Q048b1m2wLxgxlThE+FcMTzHMn
         vOEIq+OTGaBVINjXeBGGUjkMS2bhEe19M3KQwdlZ8jGHgH+G6LPTJPbAaalREWBj+30F
         cOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYtFSzEGfzzrCxiWW05PuL5+G1crhD/FYztyx3bFnms=;
        b=3A/UXpAzKqIDegouwwdSA0gl49LMJR3KsmqV3lE+7pR9ruwSYMrBQcBizOU+Oy7Kt2
         5SpfVxioTqPqq3EqNQwc08wLxgdWMozI/6+X1oyc/3HjFZgsJtre6TJEKiTQsh1W7Csk
         tJvTAi6KTbA3kNkP7ccT7xT5iG2MX0V3X3SWsj22Cg7mwCWlplTMTI5f0LZI46hYe9F+
         jqMDjycvOKH90LR6KTo63rkinSFgNhmB+E+xtYdL4NLE2bTISzTNcA5ZzJD8/IVUOP8a
         fW/WzipQnQy8GL8TJGSubC37DC/LjzblJIq43C6TWnQInWtoiWFHFra/HpuhcmQPNcFd
         /u3g==
X-Gm-Message-State: AO0yUKVn8RWlkURsKYngklxcLii8mScFQMK8Z57IWRunh+w7rLtVmrXA
        A8JhYoSIJZ3xTrwUsK0cgS8=
X-Google-Smtp-Source: AK7set+blkXu1LCABflO5jwQ9PL1fw7OSCxR+iJ4tP86uRPaQLnLmiFoiUe5iQRmN3dwbdmQfEQktg==
X-Received: by 2002:a05:600c:1ca0:b0:3dc:4042:5c30 with SMTP id k32-20020a05600c1ca000b003dc40425c30mr13776871wms.10.1675553145004;
        Sat, 04 Feb 2023 15:25:45 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003dc47d458cdsm7023705wmo.15.2023.02.04.15.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 15:25:44 -0800 (PST)
Subject: [PATCH v3 1/4] worktree: introduce is_shared_symref()
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
Message-ID: <d62842c2-1b27-4a40-f5bb-fc1dca5d2d77@gmail.com>
Date:   Sun, 5 Feb 2023 00:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new function, is_shared_symref(), which contains the heart of
find_shared_symref().  Refactor find_shared_symref() to use the new
function is_shared_symref().

Soon, we will use is_shared_symref() to search for symref beyond
the first worktree that matches.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 worktree.c | 62 +++++++++++++++++++++++++++---------------------------
 worktree.h |  6 ++++++
 2 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/worktree.c b/worktree.c
index aa43c64119..40cb9874b7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -403,44 +403,44 @@ int is_worktree_being_bisected(const struct worktree *wt,
  * bisect). New commands that do similar things should update this
  * function as well.
  */
-const struct worktree *find_shared_symref(struct worktree **worktrees,
-					  const char *symref,
-					  const char *target)
+int is_shared_symref(const struct worktree *wt, const char *symref,
+		     const char *target)
 {
-	const struct worktree *existing = NULL;
-	int i = 0;
+	const char *symref_target;
+	struct ref_store *refs;
+	int flags;
 
-	for (i = 0; worktrees[i]; i++) {
-		struct worktree *wt = worktrees[i];
-		const char *symref_target;
-		struct ref_store *refs;
-		int flags;
+	if (wt->is_bare)
+		return 0;
 
-		if (wt->is_bare)
-			continue;
+	if (wt->is_detached && !strcmp(symref, "HEAD")) {
+		if (is_worktree_being_rebased(wt, target))
+			return 1;
+		if (is_worktree_being_bisected(wt, target))
+			return 1;
+	}
 
-		if (wt->is_detached && !strcmp(symref, "HEAD")) {
-			if (is_worktree_being_rebased(wt, target)) {
-				existing = wt;
-				break;
-			}
-			if (is_worktree_being_bisected(wt, target)) {
-				existing = wt;
-				break;
-			}
-		}
+	refs = get_worktree_ref_store(wt);
+	symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
+						NULL, &flags);
+	if ((flags & REF_ISSYMREF) &&
+	    symref_target && !strcmp(symref_target, target))
+		return 1;
 
-		refs = get_worktree_ref_store(wt);
-		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
-							NULL, &flags);
-		if ((flags & REF_ISSYMREF) &&
-		    symref_target && !strcmp(symref_target, target)) {
-			existing = wt;
-			break;
-		}
+	return 0;
+}
+
+const struct worktree *find_shared_symref(struct worktree **worktrees,
+					  const char *symref,
+					  const char *target)
+{
+
+	for (int i = 0; worktrees[i]; i++) {
+		if (is_shared_symref(worktrees[i], symref, target))
+			return worktrees[i];
 	}
 
-	return existing;
+	return NULL;
 }
 
 int submodule_uses_worktrees(const char *path)
diff --git a/worktree.h b/worktree.h
index 9dcea6fc8c..7889c4761d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -149,6 +149,12 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 					  const char *symref,
 					  const char *target);
 
+/*
+ * Returns true if a symref points to a ref in a worktree.
+ */
+int is_shared_symref(const struct worktree *wt,
+		     const char *symref, const char *target);
+
 /*
  * Similar to head_ref() for all HEADs _except_ one from the current
  * worktree, which is covered by head_ref().
-- 
2.39.0
