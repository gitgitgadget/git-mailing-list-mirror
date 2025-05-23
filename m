Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0A226CF0
	for <git@vger.kernel.org>; Fri, 23 May 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992863; cv=none; b=nMMsRpYQDu3IK/WMrw96vtJDD7Wye3sK0P+7OG+Jmws7OvrSAGVcG7JPYSHe4820tCRQ1OwOgZ573aednswwdCVTg+Hun7ScmDAjURlK7vpzTfGH07bRJrseLTlh3BRwZm5dadPFY3UnBFuFUQRDqv9/RC268ksvVpgdflwEz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992863; c=relaxed/simple;
	bh=5SySUNS0HHbRt2to7N7oX4hLL7cs6JFlyLyEEtmPYvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eKcP1hq+ffTlBunGpCVtWO5iE134eMkH6JflnVSjm7R/k3WnB+VVpA6CxcIeZSexE2zlS5KgCFaRPcQezZsmWqmp3qZgB6edwNc6hnzML6h2To+8Zxy2W6TtsXrY69moaSE6NMt7ZiMs+uP8FDdpXuhCQkwx4uLTeZpFmfwBN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=LZC2ogjL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="LZC2ogjL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747992854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9bKNe7UGU3ixbU+iSk890a9obY4Ife18pZT0XueRjzU=;
	b=LZC2ogjLhcO2hjF6WSKw210t43bl3g5hRamtIM5KMpPaCwZBryBWhNy10Oe87ZAVPBt6KQ
	/B18ttL+sWCiJAC0aOzIsIEmm8ZzwF7YpUZqMPiT7H6sRckZziEXw0r/Dp3+ojuwr3M1+l
	ywGSq2Ryl4Vz3UP9wSVh6bigm8en+E0=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 23 May 2025 11:33:50 +0200
Subject: [PATCH RFC v2 3/5] last-modified: use Bloom filters when available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-toon-new-blame-tree-v2-3-101e4ca4c1c9@iotcl.com>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
In-Reply-To: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>
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

This results in a substantial performance speed-up in common cases of
'git last-modified'. In the kernel, here is the before and after (all
times computed with best-of-five):

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
 last-modified.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/last-modified.c b/last-modified.c
index 9283f8fcae..f628434929 100644
--- a/last-modified.c
+++ b/last-modified.c
@@ -7,11 +7,15 @@
 #include "revision.h"
 #include "repository.h"
 #include "log-tree.h"
+#include "dir.h"
+#include "commit-graph.h"
+#include "bloom.h"
 
 struct last_modified_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
 	struct commit *commit;
+	struct bloom_key key;
 	const char path[FLEX_ARRAY];
 };
 
@@ -28,6 +32,9 @@ static void add_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
+		if (lm->rev.bloom_filter_settings)
+			fill_bloom_key(path, strlen(path), &ent->key,
+				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
 	}
@@ -92,12 +99,21 @@ void last_modified_init(struct last_modified *lm,
 	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
 		die(_("unknown last-modified argument: %s"), argv[1]);
 
+	(void)generation_numbers_enabled(lm->rev.repo);
+	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+
 	if (add_from_revs(lm) < 0)
 		die(_("unable to setup last-modified"));
 }
 
 void last_modified_release(struct last_modified *lm)
 {
+	struct hashmap_iter iter;
+	struct last_modified_entry *ent;
+
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+		clear_bloom_key(&ent->key);
+	}
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
 }
@@ -137,6 +153,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		data->callback(path, data->commit, data->callback_data);
 
 	hashmap_remove(data->paths, &ent->hashent, path);
+	clear_bloom_key(&ent->key);
 	free(ent);
 }
 
@@ -180,6 +197,30 @@ static void last_modified_diff(struct diff_queue_struct *q,
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
+	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
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
@@ -199,6 +240,9 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 		if (!data.commit)
 			break;
 
+		if (!maybe_changed_path(lm, data.commit))
+			continue;
+
 		if (data.commit->object.flags & BOUNDARY) {
 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 				       &data.commit->object.oid,

-- 
2.49.0

