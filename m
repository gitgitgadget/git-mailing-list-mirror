Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290126C39F
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386478; cv=none; b=Jret+e0j6pIDTdoaW28QMrBVFe+37Bvsu2obaSBIv2JEmNg77wutbyVwFl/aNO3hZcAgZzWEsBOhh2LwXgE6SVegALDBJO8hkM/qI2fg0C1NYtgu/uqjk7HVivd2sKHc98pvmsm9vw4b7gNcUKbpYYapiin5DL7etp//5v4/5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386478; c=relaxed/simple;
	bh=0rW/fsKycWmPWXq5fSSUXB44LvneFJ/7UkeynyEDDSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQtU+IYHfV1Cms3hEzeu/cpGtJC7C8rczljoF49YV5G0O+YiJCW//PI/CjuEqkyWZGvySa6pcT+7Tb8FPiEEY4tteQbBfGIMmU0/jh2EEUl++Q2AuCYp8iavhXWMe1krFTqwEYUb58mvtCBw4ECJpjonjlA/fKVh2Ty30B8IT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pyAJl8oE; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pyAJl8oE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754386473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1wSBHI+8iSjU+dTLgHvYCkVLAT2xL+unjQiFrbhytw=;
	b=pyAJl8oE2lPuCYUlM5qL/35CcKrdeJnpolmXtRdqX2MPbngaR6lxDCxcQG+A5qeje6ayly
	s9wgMEm8iQPjsBGOGWRus1oglvPyjAV/ehTKR2Rmf9ZvVxvoVLq+un0VziQK8wvdcLowwi
	r1IMsscQNN9RBFN+0vpwvmHafgSwy5Q=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v7 3/3] last-modified: use Bloom filters when available
Date: Tue,  5 Aug 2025 11:33:58 +0200
Message-ID: <20250805093358.1791633-4-toon@iotcl.com>
In-Reply-To: <20250730175510.987383-1-toon@iotcl.com>
References: <20250730175510.987383-1-toon@iotcl.com>
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
 builtin/last-modified.c | 48 +++++++++++++++++++++++++++++++++++++++--
 commit-graph.c          |  7 +++++-
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 364493ac69..82c5739827 100644
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
@@ -18,6 +20,7 @@
 struct last_modified_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
+	struct bloom_key key;
 	const char path[FLEX_ARRAY];
 };
 
@@ -42,6 +45,12 @@ struct last_modified {
 
 static void last_modified_release(struct last_modified *lm)
 {
+	struct hashmap_iter iter;
+	struct last_modified_entry *ent;
+
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
+		bloom_key_clear(&ent->key);
+
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
 }
@@ -63,6 +72,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
+		if (lm->rev.bloom_filter_settings)
+			bloom_key_fill(&ent->key, path, strlen(path),
+				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
 	}
@@ -139,6 +151,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 	last_modified_emit(data->lm, path, data->commit);
 
 	hashmap_remove(&data->lm->paths, &ent->hashent, path);
+	bloom_key_clear(&ent->key);
 	free(ent);
 }
 
@@ -182,6 +195,30 @@ static void last_modified_diff(struct diff_queue_struct *q,
 	}
 }
 
+static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
+{
+	struct bloom_filter *filter;
+	struct last_modified_entry *ent;
+	struct hashmap_iter iter;
+
+	if (!lm->rev.bloom_filter_settings)
+		return true;
+
+	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
+		return true;
+
+	filter = get_bloom_filter(lm->rev.repo, origin);
+	if (!filter)
+		return true;
+
+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+		if (bloom_filter_contains(filter, &ent->key,
+					  lm->rev.bloom_filter_settings))
+			return true;
+	}
+	return false;
+}
+
 static int last_modified_run(struct last_modified *lm)
 {
 	struct last_modified_callback_data data = { .lm = lm };
@@ -202,9 +239,14 @@ static int last_modified_run(struct last_modified *lm)
 				      &data.commit->object.oid, "",
 				      &lm->rev.diffopt);
 			diff_flush(&lm->rev.diffopt);
-		} else {
-			log_tree_commit(&lm->rev, data.commit);
+
+			break;
 		}
+
+		if (!maybe_changed_path(lm, data.commit))
+			continue;
+
+		log_tree_commit(&lm->rev, data.commit);
 	}
 
 	return 0;
@@ -231,6 +273,8 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 		return argc;
 	}
 
+	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+
 	if (populate_paths_from_revs(lm) < 0)
 		return error(_("unable to setup last-modified"));
 
diff --git a/commit-graph.c b/commit-graph.c
index e0d92b816f..a74ac342b3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -821,7 +821,12 @@ int corrected_commit_dates_enabled(struct repository *r)
 
 struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 {
-	struct commit_graph *g = r->objects->commit_graph;
+	struct commit_graph *g;
+
+	if (!prepare_commit_graph(r))
+	       return NULL;
+
+	g = r->objects->commit_graph;
 	while (g) {
 		if (g->bloom_filter_settings)
 			return g->bloom_filter_settings;
-- 
2.50.1.327.g047016eb4a

