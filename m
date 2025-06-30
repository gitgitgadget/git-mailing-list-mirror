Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCC1C8631
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309399; cv=none; b=KCC7DsYo8l46DdNRENNvVlMtNBIYDAv4klL3DTY2UFBCCVK98VlZPlZUKssWyIzCX46x+ewnCEWb67X9+W9rDRWEFYZ+y1Yg5B5jkQVYbeXtA0PXNHYbjfExq/zlAie36+PyhZID2OSPkQApVNO93cJDXN3GqFD1khoFjh5ZOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309399; c=relaxed/simple;
	bh=WLE6ON2+H/nlDUKk8yvkFsg7q4oFl8K5Y+kTVYiCELs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSmklTjQDLvq8QItdI4tU4CC4F8uFH7QCQiruGKkugmpxw6arvYxMCC8cOj1JNtKN9SEWkopiZrtCf8oLx+St89OqZNM9JF7Nfb1gdpm1rk/L+tG8thE6W2ildrzRWGhnwzhidW28OdZdJ+fZCbTXYrw2PTvlV9VR3ClpmxFIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mPA6p+24; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mPA6p+24"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1751309395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cy8eLlW/Ve3RpuLqucdD2uYEmvJEfX5f4gYUCRxOTeI=;
	b=mPA6p+24d954NWUARTVnVf7IhrcXmXEvSvZ1mXw1nEMToP3z6I9gA7h/RrD4XSgP5K9sq7
	MLRqZy0eEYYuFh8h0ATSw3hLOJJQaSmRmAG6DLpfie4EzqM2ZeyKr6+Gi/jra7uZ+9Tger
	x5s0j1U7jjidn+CC9BYlB7O/LR8wtlQ=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 30 Jun 2025 20:49:25 +0200
Subject: [PATCH RFC v3 3/3] last-modified: use Bloom filters when available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-toon-new-blame-tree-v3-3-3516025dc3bc@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
In-Reply-To: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>
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
 last-modified.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/last-modified.c b/last-modified.c
index 4904d00d2a..2097894c6e 100644
--- a/last-modified.c
+++ b/last-modified.c
@@ -1,7 +1,10 @@
 #include "git-compat-util.h"
+#include "bloom.h"
+#include "commit-graph.h"
 #include "commit.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "dir.h"
 #include "last-modified.h"
 #include "log-tree.h"
 #include "object.h"
@@ -11,6 +14,7 @@
 struct last_modified_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
+	struct bloom_key key;
 	const char path[FLEX_ARRAY];
 };
 
@@ -27,6 +31,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
+		if (lm->rev.bloom_filter_settings)
+			fill_bloom_key(path, strlen(path), &ent->key,
+				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
 	}
@@ -94,6 +101,13 @@ int last_modified_init(struct last_modified *lm,
 	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
 		return error(_("unknown last-modified argument: %s"), argv[1]);
 
+	/*
+	 * We're not interested in generation numbers here,
+	 * but calling this function to prepare the commit-graph.
+	 */
+	(void)generation_numbers_enabled(lm->rev.repo);
+	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+
 	if (populate_paths_from_revs(lm) < 0)
 		return error(_("unable to setup last-modified"));
 
@@ -102,6 +116,12 @@ int last_modified_init(struct last_modified *lm,
 
 void last_modified_release(struct last_modified *lm)
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
@@ -136,6 +156,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		data->callback(path, data->commit, data->callback_data);
 
 	hashmap_remove(data->paths, &ent->hashent, path);
+	clear_bloom_key(&ent->key);
 	free(ent);
 }
 
@@ -179,6 +200,27 @@ static void last_modified_diff(struct diff_queue_struct *q,
 	}
 }
 
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
 int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
 {
 	struct last_modified_callback_data data;
@@ -198,6 +240,9 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 		if (!data.commit)
 			break;
 
+		if (!maybe_changed_path(lm, data.commit))
+			continue;
+
 		if (data.commit->object.flags & BOUNDARY) {
 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 				       &data.commit->object.oid,

-- 
2.50.0.rc0.18.gfcfe60668e

