Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6992E1C4C
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898158; cv=none; b=g8RAuAndJF1L1oCtgE7Q163RpQLmd1Kijycu60rtyNsz7dLX9rE7holake4nY/tWW1Qci8yh0NttxUGJXewaDJL1hA13qK2myEjVwQtJcMlUJYGBzam8ZIKEHUDNbI54jWYIw4xUR+Ia6bOz+m62UXTU23752ZTt7bs5Nt0hSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898158; c=relaxed/simple;
	bh=a42KxDsurofkqPV0Ig+A82y/4RXNe95IC8/KJUI603g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUlXRj6wB5NsrkAgThuLUX4hrmwZKWthmPH+yjYXWI3D709aJ4NYi8qEejl0Dmxi0k2xlnEZiJyuw7BJE8TKxcleX/zX6x5UdnFs6ES0+uNhq7HORYbGkJZILNY5HEmQA+EUjH8H1S6Uz32YxSB1Se6nCwWp7/s9OBizuv9WTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=iwtCMT4g; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="iwtCMT4g"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753898153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQxUOrQ8EzREhYgogr/N/nzKpRI/elW8U8M+k+zjZoQ=;
	b=iwtCMT4g6ONNTJ42RENBM4Kbth4GCN8qvfgNeQ5jG866Hh2oryVT8G7zq/pGdqRHAhw66s
	8oW4RSyRSfcY6YB7Lx6Ui3AinOmH+CQ//hFcXF94MlHTmX+v5TPXdVjlEekV9kqzC8TeY2
	6qmb4rrmwqnAURtRAmvKoTT6Uz5XglI=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v6 4/4] last-modified: use Bloom filters when available
Date: Wed, 30 Jul 2025 19:55:10 +0200
Message-ID: <20250730175510.987383-5-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
References: <20250716133206.1787549-1-toon@iotcl.com>
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
 builtin/last-modified.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index e4c73464c7..19bf25f8a5 100644
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
 
@@ -41,6 +44,12 @@ struct last_modified {
 
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
@@ -62,6 +71,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
+		if (lm->rev.bloom_filter_settings)
+			bloom_key_fill(&ent->key, path, strlen(path),
+				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
 	}
@@ -136,6 +148,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 	last_modified_emit(data->lm, path, data->commit);
 
 	hashmap_remove(&data->lm->paths, &ent->hashent, path);
+	bloom_key_clear(&ent->key);
 	free(ent);
 }
 
@@ -179,6 +192,27 @@ static void last_modified_diff(struct diff_queue_struct *q,
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
 static int last_modified_run(struct last_modified *lm)
 {
 	struct last_modified_callback_data data = { .lm = lm };
@@ -194,6 +228,9 @@ static int last_modified_run(struct last_modified *lm)
 		if (!data.commit)
 			break;
 
+		if (!maybe_changed_path(lm, data.commit))
+			continue;
+
 		if (data.commit->object.flags & BOUNDARY) {
 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 				      &data.commit->object.oid, "",
@@ -227,6 +264,9 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 		return argc;
 	}
 
+	prepare_commit_graph(lm->rev.repo);
+	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+
 	if (populate_paths_from_revs(lm) < 0)
 		return error(_("unable to setup last-modified"));
 
-- 
2.50.1.327.g047016eb4a

