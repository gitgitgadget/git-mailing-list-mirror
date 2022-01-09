Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50717C433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 04:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiAIE56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 23:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiAIE5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 23:57:51 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB20C06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 20:57:50 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id v7so7395581qtw.13
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 20:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CAJp0L3aMCH73wWlH4GtWtBZ5t56tIczk2Q8WG2BGQo=;
        b=Z262xTh7mt/HzzZygen1yMczS6a0Po8K2SUvm4LXooPjPY01L+nW1Z2hQASpmJkLh+
         052Xgjzryt/kCZimkJlZaGrn4536FHLzwDHkn4VwyqrJDcS3V5z5oAylFI9Wa+9g6609
         BivkMbSdlEToa/oZl1PDYVwMA2qDLZDn0l0Qhqj+Q0D84esZSmUQiIC5qNpJCQhO7lR4
         3qBi8xk6nbYVHpGQk+pRK+cL0sDe/o+PhD3z1L7MnqXmVBA0IM6uIgXW+WCGnoimeZWr
         T2FNbHRpsii6rQNP8kbX9iN0DvXDVkJEP+3w29Pc7esXh1F7AGGQ/bLTkgpeXpL533ZN
         AiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAJp0L3aMCH73wWlH4GtWtBZ5t56tIczk2Q8WG2BGQo=;
        b=BVjwCnHxYOqsmdHwwWPOI00OyxhSwKRN8NFUGM4VexTxGyM83OFhLdJZiwtB7TKJMW
         t8eTIDj3cWCFqVg2oc1oW3mJDiv6/25XDGhqQUEEwJ7o/+reVP854f4Gd2PLPH7vj8AX
         M31xEK1cxq+SAPmm1KaIjyTRO+TqWPwcr4Xxnq1dLR08dfHNYiy5/fgZE+Dd4pxTIpIK
         BAOwhLwxRcGNctFhiq7WuJK6mvsq29O1MmVJ9g4HJPz8Sz8bjFowfK/WuvIlDBaFC+gY
         Tv8P1qUuDj6ulQ5/IawcBtz1gPTWd4mT9ZI7HlCySmhma5z1YFHdExPiRe/ylr2jVUzX
         rGLQ==
X-Gm-Message-State: AOAM531VR9VJoBJoudD69O4XMWeQy+p3T0gTJtQsoQj4lNRmmjEuIhkU
        CDdxbfz9PLyPIH7QfF4xLoFTQCzxhKIMJg==
X-Google-Smtp-Source: ABdhPJzvObjeExwEEAdc6DArh2GlHFadMN00XrRY4fbc7ANa0JVo2yUHfFQAknsS8mUY7yQRQj7E0Q==
X-Received: by 2002:ac8:5993:: with SMTP id e19mr60666593qte.568.1641704269802;
        Sat, 08 Jan 2022 20:57:49 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::1b])
        by smtp.gmail.com with ESMTPSA id t5sm2118915qtp.60.2022.01.08.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 20:57:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 5/5] Accelerate ensure_skip_worktree_means_skip_worktree by caching
Date:   Sat,  8 Jan 2022 20:57:32 -0800
Message-Id: <20220109045732.2497526-6-newren@gmail.com>
X-Mailer: git-send-email 2.34.1.442.ge63c19bdd2.dirty
In-Reply-To: <20220109045732.2497526-1-newren@gmail.com>
References: <20220109045732.2497526-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than lstat()'ing every SKIP_WORKTREE path, take advantage of the
fact that entire directories will often be missing, especially for cone
mode and even more so ever since commit 55dfcf9591 ("sparse-checkout:
clear tracked sparse dirs", 2021-09-08).  If we have already determined
that the parent directory of a file (or any other previous ancestor)
does not exist, then we already know the file cannot exist and do not
need to lstat() it separately.

Granted, the cost of ensure_skip_worktree_means_skip_worktree() might
be considered a bit high for non-cone mode since it might now lstat()
every SKIP_WORKTREE path when the index is loaded (an O(N) cost, with
N the number of SKIP_WORKTREE paths), but non-cone mode users already
have to deal with the O(N*M) cost (with N=the number of tracked files
and M=the number of sparsity patterns), so this should be reasonable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sparse-index.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 79d50e444c..608782e255 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -341,18 +341,117 @@ void ensure_correct_sparsity(struct index_state *istate)
 		ensure_full_index(istate);
 }
 
+struct path_cache_entry {
+	struct hashmap_entry ent;
+	const char *path;
+	int path_length;
+	int is_present;
+};
+
+static int path_cache_cmp(const void *unused,
+			  const struct hashmap_entry *entry1,
+			  const struct hashmap_entry *entry2,
+			  const void *also_unused)
+{
+	const struct path_cache_entry *e1, *e2;
+
+	e1 = container_of(entry1, const struct path_cache_entry, ent);
+	e2 = container_of(entry2, const struct path_cache_entry, ent);
+	if (e1->path_length != e2->path_length)
+		return e1->path_length - e2->path_length;
+	return memcmp(e1->path, e2->path, e1->path_length);
+}
+
+static struct path_cache_entry *find_path_cache_entry(struct hashmap *map,
+						      const char *str,
+						      int str_length)
+{
+	struct path_cache_entry entry;
+	hashmap_entry_init(&entry.ent, memhash(str, str_length));
+	entry.path = str;
+	entry.path_length = str_length;
+	return hashmap_get_entry(map, &entry, ent, NULL);
+}
+
+static void record(struct hashmap *path_cache,
+		   struct mem_pool *pool,
+		   const char *path,
+		   int path_length,
+		   int found)
+{
+	struct path_cache_entry *entry;
+
+	entry = mem_pool_alloc(pool, sizeof(*entry));
+	hashmap_entry_init(&entry->ent, memhash(path, path_length));
+	entry->path = path;
+	entry->path_length = path_length;
+	entry->is_present = found;
+	hashmap_add(path_cache, &entry->ent);
+}
+
+static int path_found(struct hashmap *path_cache, struct mem_pool *pool,
+		      const char *path, int path_length)
+{
+	struct stat st;
+	int found;
+	const char *dirsep = path + path_length - 1;
+	const char *tmp;
+
+	/* Find directory separator; memrchr is sadly glibc-specific */
+	while (dirsep > path && *dirsep != '/')
+		dirsep--;
+
+	/* If parent of path doesn't exist, no point lstat'ing path... */
+	if (dirsep > path) {
+		struct path_cache_entry *entry;
+		int new_length, parent_found;
+
+		/* First, check if path's parent's existence was cached */
+		new_length = dirsep - path;
+		entry = find_path_cache_entry(path_cache, path, new_length);
+		if (entry)
+			parent_found = entry->is_present;
+		else
+			parent_found = path_found(path_cache, pool,
+						  path, new_length);
+
+		if (!parent_found) {
+			/* path can't exist if parent dir doesn't */
+			record(path_cache, pool, path, path_length, 0);
+			return 0;
+		} /* else parent was found so must check path itself too... */
+	}
+
+	/* Okay, parent dir exists, so we have to check original path */
+
+	/* Make sure we have a NUL-terminated string to pass to lstat */
+	tmp = path;
+	if (path[path_length])
+		tmp = mem_pool_strndup(pool, path, path_length);
+	/* Determine if path exists */
+	found = !lstat(tmp, &st);
+
+	record(path_cache, pool, path, path_length, found);
+	return found;
+}
+
 void ensure_skip_worktree_means_skip_worktree(struct index_state *istate)
 {
+	struct hashmap path_cache = HASHMAP_INIT(path_cache_cmp, NULL);
+	struct mem_pool pool;
+
 	int i;
+
 	if (!core_apply_sparse_checkout)
 		return;
 
+	mem_pool_init(&pool, 32*1024);
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		struct stat st;
 
-		if (ce_skip_worktree(ce) && !lstat(ce->name, &st)) {
+		if (ce_skip_worktree(ce) &&
+		    path_found(&path_cache, &pool, ce->name, strlen(ce->name))) {
 			if (S_ISSPARSEDIR(ce->ce_mode)) {
 				ensure_full_index(istate);
 				goto restart;
@@ -360,6 +459,8 @@ void ensure_skip_worktree_means_skip_worktree(struct index_state *istate)
 			ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		}
 	}
+	hashmap_clear(&path_cache);
+	mem_pool_discard(&pool, 0);
 }
 
 
-- 
2.34.1.442.ge63c19bdd2.dirty

