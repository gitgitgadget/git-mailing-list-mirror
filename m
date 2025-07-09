Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA92E7BB6
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074813; cv=none; b=AT3KYQfFf46U+jjDI+nAxLg9jFJ5v99UJK316DnyKf1KQxv+t750jABXWUwPBD9UhrlyAbGg6F9oaijqmT1o860b61yNsha0VGtIog9CEy9SzO6QcNYLUF+m8SwFidWgY2dOBK3PHqqi++O1ZplM7Q74hwQlWOLjX/2LUTjLqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074813; c=relaxed/simple;
	bh=240sd7ENOVhEHARw4KC8OsEJtkAiebyxurnJj7A6JKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGyR4nGaxzz2fC+DdpBNk4/1KHTQH6kqbja+UEyVncLp/xI4CNbg5Z3zv91UyUInLjBJS3yRyFAaO9tQNWrGQIeZUvgSKqjE6z1Gum73IfKXVGyBDKL0b+U0OwNKao5T3B1jfHW0TK4ZqYkl6x5shouva8YQn8+8rERgiqz9dnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TrwVF+O9; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TrwVF+O9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752074809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEC4Yjl+0W/ofQ5Ade078o/MKUaeh9LeSilg45Ay164=;
	b=TrwVF+O9VMta+bL5LbK8SzLxr3/YylpaBlrBbq+Bt7UxOJz9J9JRHYRkWi1/Zbjob+Pcg/
	BV8gVUP2K3wuA8Xz0SJoQ4KGMUOgeWkjc+XJ3Nz3lcFPAQDHdNgzEycPHHT8JRHk7oCxYb
	M5e+OICvCFblXIA36rJ6gJg4UBjeuOs=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 3/3] last-modified: use Bloom filters when available
Date: Wed,  9 Jul 2025 17:26:28 +0200
Message-ID: <20250709152628.1644521-4-toon@iotcl.com>
In-Reply-To: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Our 'git last-modified' performs a revision walk, and computes a diff at
each point in the walk to figure out whether a given revision changed
any of the paths it considers interesting.

When changed-path Bloom filters are available, we can avoid computing
many such diffs. Before computing a diff, we first check if any of the
remaining paths of interest were possibly changed at a given commit by
consulting its Bloom filter. If any of them are, we are resigned to
compute the diff.

If none of those queries returned "maybe", we know that the given commit
doesn't contain any changed paths which are interesting to us. So, we
can avoid computing it in this case.

Comparing the perf test results on git.git:

    Test                                        HEAD~             HEAD
    ------------------------------------------------------------------------------------
    8020.1: top-level last-modified             4.49(4.34+0.11)   2.22(2.05+0.09) -50.6%
    8020.2: top-level recursive last-modified   5.64(5.45+0.11)   5.62(5.30+0.11) -0.4%
    8020.3: subdir last-modified                0.11(0.06+0.04)   0.07(0.03+0.04) -36.4%

Based-on-patch-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 63993bc1c9..466df04fba 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -1,5 +1,7 @@
 #include "git-compat-util.h"
+#include "bloom.h"
 #include "builtin.h"
+#include "commit-graph.h"
 #include "commit.h"
 #include "config.h"
 #include "diff.h"
@@ -17,6 +19,7 @@
 struct last_modified_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
+	struct bloom_key key;
 	const char path[FLEX_ARRAY];
 };
 
@@ -40,6 +43,12 @@ struct last_modified {
 
 static void last_modified_release(struct last_modified *lm)
 {
+	struct hashmap_iter iter;
+	struct last_modified_entry *ent;
+
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
+		clear_bloom_key(&ent->key);
+
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
 }
@@ -67,6 +76,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
+		if (lm->rev.bloom_filter_settings)
+			fill_bloom_key(path, strlen(path), &ent->key,
+				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
 	}
@@ -126,6 +138,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		data->callback(path, data->commit, data->callback_data);
 
 	hashmap_remove(data->paths, &ent->hashent, path);
+	clear_bloom_key(&ent->key);
 	free(ent);
 }
 
@@ -169,6 +182,28 @@ static void last_modified_diff(struct diff_queue_struct *q,
 	}
 }
 
+
+static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
+{
+	struct bloom_filter *filter;
+	struct last_modified_entry *ent;
+	struct hashmap_iter iter;
+
+	if (!lm->rev.bloom_filter_settings)
+		return 1;
+
+	filter = get_bloom_filter(lm->rev.repo, origin);
+	if (!filter)
+		return 1;
+
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+		if (bloom_filter_contains(filter, &ent->key,
+					  lm->rev.bloom_filter_settings))
+			return 1;
+	}
+	return 0;
+}
+
 static int last_modified_run(struct last_modified *lm,
 			     last_modified_callback cb, void *cbdata)
 {
@@ -189,6 +224,9 @@ static int last_modified_run(struct last_modified *lm,
 		if (!data.commit)
 			break;
 
+		if (!maybe_changed_path(lm, data.commit))
+			continue;
+
 		if (data.commit->object.flags & BOUNDARY) {
 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 				      &data.commit->object.oid, "",
@@ -238,6 +276,13 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 		return argc;
 	}
 
+	/*
+	 * We're not interested in generation numbers here,
+	 * but calling this function to prepare the commit-graph.
+	 */
+	(void)generation_numbers_enabled(lm->rev.repo);
+	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+
 	if (populate_paths_from_revs(lm) < 0)
 		return error(_("unable to setup last-modified"));
 
-- 
2.50.0.rc0.18.gfcfe60668e

