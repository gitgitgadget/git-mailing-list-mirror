Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637DC6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 14:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBYOV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 09:21:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925D12877
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:21:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so4203589wmb.3
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677334913;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7nblxR5IqPkMDhIwUwGVspgEq0WwHbrjFMvIUf0fhU=;
        b=IvUOaEvUsIDq911X/r2thBMAl/zmrALblJfVgv8H1eYp+ThvV1o5/ngDxsQYdRSwpB
         3OUL3BFLODt12lmiGD0oDXvycrf06wa8MA4/ptJ2EVdSUFj2+r3G47hkfreDSG3kFE42
         tpUDpTG7GKRxKONg64ccPHi+I42cLVs6ryovD32/9QHFgalL8siLpq9WhZmQ0/9k27rH
         2YachitoVCQphWL9DojA/xbfw+u7vRhx7Tvj7pqq+z/UUkS0YerFLZj0CKdLxaHeE+8f
         oeusPWs2BBkr6skn7vh71JBMabk3BQ+JcRM6tVZpXY5E2uFPiSZ/+H78N7GVbqIJ6SGe
         TLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677334913;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7nblxR5IqPkMDhIwUwGVspgEq0WwHbrjFMvIUf0fhU=;
        b=J7Rxl/pjkap4VQqQRdaYntU2l/T4iLARTM/Cd7pvvK51roEvNh9db1VpwDEbqCKNxA
         r9O/m1NAvSbNgMA9mHT7DdS74meI5nV8XevspPTtW7xX2b9cTiktao9GMnhCKJJebfPM
         jKJbyuZArPlX2KLC45meUwaqOr0c5iDWse5Gj7AmBeFGGqTTSnDhtJ6S25zMCsXWiilM
         rFiwfUfz4VrAxQZFyHOwYDNHaT/NLUnwrAmworK59pGO/8SpS8kAySdyoRKTyFNCHOsl
         V/0/TnsvaatVf0vnqGiagimoNtODbqKg0giL9jVVLdc7UkR4NjeMEQRJySPkao+iGwA9
         +M6Q==
X-Gm-Message-State: AO0yUKWzKrwNbYqXKDzIakGktrWlyqH/A/vb13PRDqi1/HVp2v97ATQK
        vpMj7Gzg+y7RSUriPa8uLPA=
X-Google-Smtp-Source: AK7set/INNpbskzt4YdXsdF8E+JoVF83gGUVXqkqfiCtyuKLR8HM7xoSpph+4KUNLWQLxiyOcByMWg==
X-Received: by 2002:a05:600c:2e88:b0:3eb:38e6:f64d with SMTP id p8-20020a05600c2e8800b003eb38e6f64dmr793001wmn.39.1677334912911;
        Sat, 25 Feb 2023 06:21:52 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id r1-20020a1c2b01000000b003e9ae2a8cbfsm2867897wmr.2.2023.02.25.06.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 06:21:52 -0800 (PST)
Subject: [PATCH v4 1/4] worktree: introduce is_shared_symref()
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Message-ID: <d23997f9-240c-000d-a93e-7e0d0c5adbe6@gmail.com>
Date:   Sat, 25 Feb 2023 15:21:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
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
2.39.2
