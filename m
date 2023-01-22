Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A8BC38142
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 01:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjAVBX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 20:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVBX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 20:23:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB25F768
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:23:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b7so7891706wrt.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiuRXkPtYEgYeeosA0eVtt8bqpWzKX0V6qTRosIZ76w=;
        b=D+IC2PZcIZatg8+b9ZXRnlNMFNINES4qSS9EYyeKPjWraEmQNGOGr41GOc/FID/uQ0
         pAdgJ4WIi0XlcNka2OCXD1ZtcB8/q9IKqKh+Q2vNfTndtIpMkTDPO2ys3yeqh4HsWvO6
         6mtOsH7bsFSq9Njc6t4rrstWSLsJuCDY1mDfPkcAikvaXt5fnBl6KraahJlHau2he+LV
         ipkuKmvkhcC6R/wD5j+4Id5XM3HyE9KnqwgySaXeZX3vporIc3fHI+VBEHBHwGWP6USB
         kfEwzuQjpJ5n6p0dtNJNOQcwv4Fhhcfj0ShUFmh4k2+Rk3REbzfLjLZ3uqhrRymtWKFQ
         7JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiuRXkPtYEgYeeosA0eVtt8bqpWzKX0V6qTRosIZ76w=;
        b=kePB3HCNAy57FHvrRwj4aNIw5e7wRksqnl28yni5qmxQKjtEtmUmgbGlP9YYn5ifA0
         gpG4v9ITKjLFhxcnxnWD9cCV0xSPVxZBAkUcizB4SuBsH6Cz1KgAdNHmSZGmiuXfgw4W
         K1Pa2WfIOWWFHU94l1VUARrmr0Z4PLMXJoYOADZuVVZlfC7YaSlxG4cZH/DbIXmv2j1G
         jv6q14lBk3DRWbE5YReN5eQ4LMi0N3tI07z4/V8lFnD5GoyqsupRfW5Jhck3+1rqv0NG
         PbSbiI23LLY1hHdqTT0N32KMC3kAHAAmp2jKh5qS7dhnEUYBjJch9T0SVX9CgSi3yJsE
         8p0Q==
X-Gm-Message-State: AFqh2kq0TGf7wzeGbkl7MOPb22ohU/pwVMZesZjqbkMLk0gNHcF5QyAj
        FxkBh5QXRQfqUBHyryjftEA=
X-Google-Smtp-Source: AMrXdXuf8LE14PGVWx4h+opeaV37BHmad/XZyJgml4ngtaFKv1syud2Ndnq7xl0fZgk3EvL1ZUiyAQ==
X-Received: by 2002:adf:de0f:0:b0:2bb:de14:a18 with SMTP id b15-20020adfde0f000000b002bbde140a18mr11510206wrm.14.1674350634694;
        Sat, 21 Jan 2023 17:23:54 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id k5-20020adfd845000000b002bdd96d88b4sm24205349wrl.75.2023.01.21.17.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 17:23:54 -0800 (PST)
Subject: [PATCH v2 1/3] branch: fix die_if_checked_out() when
 ignore_current_worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Message-ID: <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com>
Date:   Sun, 22 Jan 2023 02:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8d9fdd7 (worktree.c: check whether branch is rebased in another
worktree, 2016-04-22) die_if_checked_out() learned a new
option ignore_current_worktree, to modify the operation from "die() if
the branch is checked out in any worktree" to "die() if the branch
is checked out in any worktree other than the current one".

Unfortunately we implemented it by checking the flag is_current in the
worktree that find_shared_symref() returns.

When the same branch is checked out in several worktrees simultaneously,
find_shared_symref() will return the first matching worktree in the list
composed by get_worktrees().  If one of the worktrees with the checked
out branch is the current worktree, find_shared_symref() may or may not
return it, depending on the order of the list.

Let's stop using find_shared_symref() in die_if_checked_out(), to handle
correctly ignore_current_worktree.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c   | 16 +++++++++++-----
 worktree.c | 54 +++++++++++++++++++++++++++++-------------------------
 worktree.h |  6 ++++++
 3 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/branch.c b/branch.c
index d182756827..2378368415 100644
--- a/branch.c
+++ b/branch.c
@@ -820,12 +820,18 @@ void remove_branch_state(struct repository *r, int verbose)
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
 	struct worktree **worktrees = get_worktrees();
-	const struct worktree *wt;
+	int i;
+
+	for (i = 0; worktrees[i]; i++)
+	{
+		if (worktrees[i]->is_current && ignore_current_worktree)
+			continue;
 
-	wt = find_shared_symref(worktrees, "HEAD", branch);
-	if (wt && (!ignore_current_worktree || !wt->is_current)) {
-		skip_prefix(branch, "refs/heads/", &branch);
-		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
+		if (is_shared_symref(worktrees[i], "HEAD", branch)) {
+			skip_prefix(branch, "refs/heads/", &branch);
+			die(_("'%s' is already checked out at '%s'"),
+				branch, worktrees[i]->path);
+		}
 	}
 
 	free_worktrees(worktrees);
diff --git a/worktree.c b/worktree.c
index aa43c64119..d500d69e4c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -403,6 +403,33 @@ int is_worktree_being_bisected(const struct worktree *wt,
  * bisect). New commands that do similar things should update this
  * function as well.
  */
+int is_shared_symref(const struct worktree *wt, const char *symref,
+		     const char *target)
+{
+	const char *symref_target;
+	struct ref_store *refs;
+	int flags;
+
+	if (wt->is_bare)
+		return 0;
+
+	if (wt->is_detached && !strcmp(symref, "HEAD")) {
+		if (is_worktree_being_rebased(wt, target))
+			return 1;
+		if (is_worktree_being_bisected(wt, target))
+			return 1;
+	}
+
+	refs = get_worktree_ref_store(wt);
+	symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
+						NULL, &flags);
+	if ((flags & REF_ISSYMREF) &&
+	    symref_target && !strcmp(symref_target, target))
+		return 1;
+
+	return 0;
+}
+
 const struct worktree *find_shared_symref(struct worktree **worktrees,
 					  const char *symref,
 					  const char *target)
@@ -411,31 +438,8 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 	int i = 0;
 
 	for (i = 0; worktrees[i]; i++) {
-		struct worktree *wt = worktrees[i];
-		const char *symref_target;
-		struct ref_store *refs;
-		int flags;
-
-		if (wt->is_bare)
-			continue;
-
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
-
-		refs = get_worktree_ref_store(wt);
-		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
-							NULL, &flags);
-		if ((flags & REF_ISSYMREF) &&
-		    symref_target && !strcmp(symref_target, target)) {
-			existing = wt;
+		if (is_shared_symref(worktrees[i], symref, target)) {
+			existing = worktrees[i];
 			break;
 		}
 	}
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
