Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D21C4332F
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbiBOQAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiBOQAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461C3C1CB8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j26so22058284wrb.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O9uSUdVmjl0GNVDtJppFKUNv7/uBemAS63Cuf7uBWG0=;
        b=bphIfmQCkFTz+JHHrzm9dXUpi0qcNkeEeleizjCbiN5MxvdNnV5wQPFYFM+HFKw4DZ
         8t8d/ObbrhAaZWOKNIznW9ORajvu3RmoPxKlr5cDliYAvfeqMgDyBduDXa/9Tbglx4TT
         UqSqL0gUzKr0t30s1Y3TxwvQG+WGu3+DeSemCPtVxTV3XOu4KtIf8QzWsqPNc+cAbwJD
         sZ08gtdXQTX4IoTtBTiY5yWNRkW1huLo1hA9WqV16HypWcZox3QtyR8rsspLASJaU75R
         Mr2jrSPgTAYJ/FC1NVaEZYv1Vw8AW2gqsSyDIvQyWzBplviH25l7/7QTWrLo89hEegwg
         72tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O9uSUdVmjl0GNVDtJppFKUNv7/uBemAS63Cuf7uBWG0=;
        b=1m10lhyYH7Fb+RO6wH1J8snY+q5ovJg3IP+TfdiwdoEl9C3H/Zm8EElGsx5U1Z0WEj
         v6rbebAmuXFF9tyVBkBdEWYncyN8eiAq5hav0a13meVt1/zM3O5bmUOhYJcZhjQuPWse
         A58eyEA5rdYhfTZmyu24ZZEMpeYqbq9KPqoDhhKJHGKZIFyD5BwScOvhl89pk8PRLXEc
         jkyTJLrGx93Khsfhs7OZBOvWSAqIsyzRuXrMX4j7LAVO5lv/IfVkvqiMAOFi9fMUpt4R
         daH7FgRpDhgeGahBsW7iUVBo0ypS5zSKGMG9C3chgNafMsEPiKh7itbH4Fx5+jp2lISw
         stYQ==
X-Gm-Message-State: AOAM5334eyZGqOjdZJjQNlxQg29RZgpdmoeRUFVIMqUEyD3pS4U9w/zQ
        XfaikW/Or/t/V9BNBlKGr465WmCssg8=
X-Google-Smtp-Source: ABdhPJys/vrUUZfQvhLMAkUD1Kjs1uAjytM+Br6kxgoZSrRHvkHeSeH97eZADz2zZJQcd8FCHbR30g==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr3680888wrw.289.1644940796166;
        Tue, 15 Feb 2022 07:59:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm18097689wru.37.2022.02.15.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:55 -0800 (PST)
Message-Id: <07a9c7542be79fb60861253848eca258bec87694.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:31 +0000
Subject: [PATCH 21/23] fsmonitor: optimize processing of directory events
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to perform binary search over the cache-entries for a directory
notification and then linearly scan forward to find the immediate children.

Previously, when the FSMonitor reported a modified directory Git would
perform a linear search on the entire cache-entry array for all
entries matching that directory prefix and invalidate them.  Since the
cache-entry array is already sorted, we can use a binary search to
find the first matching entry and then only linearly walk forward and
invalidate entries until the prefix changes.

Also, the original code would invalidate anything having the same
directory prefix.  Since a directory event should only be received for
items that are immediately within the directory (and not within
sub-directories of it), only invalidate those entries and not the
whole subtree.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 71 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 8e3499d0667..be08861a18e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -184,30 +184,68 @@ static int query_fsmonitor_hook(struct repository *r,
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int i, len = strlen(name);
-	if (name[len - 1] == '/') {
+	int pos = index_name_pos(istate, name, len);
+
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback '%s' (pos %d)",
+			 name, pos);
 
+	if (name[len - 1] == '/') {
 		/*
-		 * TODO We should binary search to find the first path with
-		 * TODO this directory prefix.  Then linearly update entries
-		 * TODO while the prefix matches.  Taking care to search without
-		 * TODO the trailing slash -- because '/' sorts after a few
-		 * TODO interesting special chars, like '.' and ' '.
+		 * The daemon can decorate directory events, such as
+		 * moves or renames, with a trailing slash if the OS
+		 * FS Event contains sufficient information, such as
+		 * MacOS.
+		 *
+		 * Use this to invalidate the entire cone under that
+		 * directory.
+		 *
+		 * We do not expect an exact match because the index
+		 * does not normally contain directory entries, so we
+		 * start at the insertion point and scan.
 		 */
+		if (pos < 0)
+			pos = -pos - 1;
 
 		/* Mark all entries for the folder invalid */
-		for (i = 0; i < istate->cache_nr; i++) {
-			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID &&
-			    starts_with(istate->cache[i]->name, name))
-				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
 		}
-		/* Need to remove the / from the path for the untracked cache */
+
+		/*
+		 * We need to remove the traling "/" from the path
+		 * for the untracked cache.
+		 */
 		name[len - 1] = '\0';
+	} else if (pos >= 0) {
+		/*
+		 * We have an exact match for this path and can just
+		 * invalidate it.
+		 */
+		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
 	} else {
-		int pos = index_name_pos(istate, name, strlen(name));
-
-		if (pos >= 0) {
-			struct cache_entry *ce = istate->cache[pos];
-			ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		/*
+		 * The path is not a tracked file -or- it is a
+		 * directory event on a platform that cannot
+		 * distinguish between file and directory events in
+		 * the event handler, such as Windows.
+		 *
+		 * Scan as if it is a directory and invalidate the
+		 * cone under it.  (But remember to ignore items
+		 * between "name" and "name/", such as "name-" and
+		 * "name.".
+		 */
+		pos = -pos - 1;
+
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			if ((unsigned char)istate->cache[i]->name[len] > '/')
+				break;
+			if (istate->cache[i]->name[len] == '/')
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
 		}
 	}
 
@@ -215,7 +253,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	 * Mark the untracked cache dirty even if it wasn't found in the index
 	 * as it could be a new untracked file.
 	 */
-	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", name);
 	untracked_cache_invalidate_path(istate, name, 0);
 }
 
-- 
gitgitgadget

