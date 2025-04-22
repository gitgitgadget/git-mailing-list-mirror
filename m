Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B461E1C22
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344022; cv=none; b=kV8UGM0WLhlFa/ewAZeI0t+moTzjk577dmsXBLEu2HN35+zVBy/eloJ2/9RL6NHhjEQTm7J97UV69rVzOFw7HLYliExYYNQbG6WwTWG4hQkVt2hh3Yysg6LF/tlV/YkTvj1CsILZL82FLQszlNT/PD8y2GoD2owcpA7Rt28hwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344022; c=relaxed/simple;
	bh=DpiYteQE5D4IxRv/lPNVRQ1kxmg+Pp3ob3FPoeI/ZhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tk6VjwCw6AFgBAYH3nWzY3x4NcQVBXpHIbZ4C8cMSTtoclBq+IDtaX5BtygbFyiVryOPyy+xXrGH/RxSTJu5MUrGYjZcccl9FO2hDtfjpEj5nCrkDrA68FeAcKFu3k3Q+G0ny++M6dlmq1O7pnyONOmloECDA8hCsY8i9SzUf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=B1ibLsr1; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="B1ibLsr1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745344017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sq61O8niaHYRbixYdtTXCBdwYy7EHemY0CMnROCi+yo=;
	b=B1ibLsr1dw9RborccZo75JDF1Ro8ezla4PE2MZ5bndQHbf+rbGOrdhQWL6YwJCpLoL1WLO
	/Xu0wdfO2Uj7E7c9rYHOOiJQ46aCg/m3BZM1qy3IA7oMEjKNP6GIqZTJBRCijGjSAa8KGm
	rjpo5VWQxRUX1S9IWSdeaX+qJ6DVMJg=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 22 Apr 2025 19:46:26 +0200
Subject: [PATCH RFC 3/5] blame-tree: use Bloom filters when available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-toon-new-blame-tree-v1-3-fdb51b8a394a@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

From: Taylor Blau <me@ttaylorr.com>

Our 'git blame-tree' performs a revision walk, and computes a diff at
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

This results in a substantial performance speed-up in common cases of
'git blame-tree'. In the kernel, here is the before and after (all times
computed with best-of-five):

With commit-graphs (but no Bloom filters):

    real	0m5.133s
    user	0m4.942s
    sys	0m0.180s

...and with Bloom filters:

    real	0m0.936s
    user	0m0.842s
    sys	0m0.092s

These times are with my development-version of Git, so it's compiled
without optimizations. Compiling instead with `-O3`, the results look
even better:

    real	0m0.754s
    user	0m0.661s
    sys	0m0.092s

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 blame-tree.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/blame-tree.c b/blame-tree.c
index ce57db2cfc..47354557a7 100644
--- a/blame-tree.c
+++ b/blame-tree.c
@@ -7,11 +7,15 @@
 #include "revision.h"
 #include "repository.h"
 #include "log-tree.h"
+#include "dir.h"
+#include "commit-graph.h"
+#include "bloom.h"
 
 struct blame_tree_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
 	struct commit *commit;
+	struct bloom_key key;
 	const char path[FLEX_ARRAY];
 };
 
@@ -28,6 +32,9 @@ static void add_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
+		if (bt->rev.bloom_filter_settings)
+			fill_bloom_key(path, strlen(path), &ent->key,
+				       bt->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&bt->paths, &ent->hashent);
 	}
@@ -92,12 +99,21 @@ void blame_tree_init(struct blame_tree *bt,
 	if (setup_revisions(argc, argv, &bt->rev, NULL) > 1)
 		die(_("unknown blame-tree argument: %s"), argv[1]);
 
+	(void)generation_numbers_enabled(bt->rev.repo);
+	bt->rev.bloom_filter_settings = get_bloom_filter_settings(bt->rev.repo);
+
 	if (add_from_revs(bt) < 0)
 		die(_("unable to setup blame-tree"));
 }
 
 void blame_tree_release(struct blame_tree *bt)
 {
+	struct hashmap_iter iter;
+	struct blame_tree_entry *ent;
+
+	hashmap_for_each_entry(&bt->paths, &iter, ent, hashent) {
+		clear_bloom_key(&ent->key);
+	}
 	hashmap_clear_and_free(&bt->paths, struct blame_tree_entry, hashent);
 	release_revisions(&bt->rev);
 }
@@ -137,6 +153,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		data->callback(path, data->commit, data->callback_data);
 
 	hashmap_remove(data->paths, &ent->hashent, path);
+	clear_bloom_key(&ent->key);
 	free(ent);
 }
 
@@ -180,6 +197,30 @@ static void blame_diff(struct diff_queue_struct *q,
 	}
 }
 
+static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
+{
+	struct bloom_filter *filter;
+	struct blame_tree_entry *e;
+	struct hashmap_iter iter;
+
+	if (!bt->rev.bloom_filter_settings)
+		return 1;
+
+	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
+		return 1;
+
+	filter = get_bloom_filter(bt->rev.repo, origin);
+	if (!filter)
+		return 1;
+
+	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
+		if (bloom_filter_contains(filter, &e->key,
+					  bt->rev.bloom_filter_settings))
+			return 1;
+	}
+	return 0;
+}
+
 int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 {
 	struct blame_tree_callback_data data;
@@ -199,6 +240,9 @@ int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 		if (!data.commit)
 			break;
 
+		if (!maybe_changed_path(bt, data.commit))
+			continue;
+
 		if (data.commit->object.flags & BOUNDARY) {
 			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
 				       &data.commit->object.oid,

-- 
2.49.0.rc2

