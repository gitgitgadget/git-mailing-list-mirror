Received: from mta0.migadu.com (out-144.mta0.migadu.com [91.218.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32571476682
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254992; cv=none; b=TEBy1hf/FFPUv97lMBvfWu9O4lfcCiMfBq0yRK0L1CNFkEaqT44vXvio0DjiYx50LXI68fFoag3WbVn4X0nDUG4i2I3q53uKutPvBhZiFA55g/zNgkanYuVpRFWkYk2tJdS3AQTRqR2zvTspHHBSdr25VxuNv510NqsGGw/BYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254992; c=relaxed/simple;
	bh=RSjlz6cn9wBO7zIOSXfnxEQBP5VKqMIDpeLVafGaCgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFPhC0585Y1XS6z6cgp2oDG6CY3iEgTTeMLi1h/hIMvBM9Ddq0PSsuebPsS/ouApliHV6hDahsGWevd2Nw3VdB1p/oKM4EhIvgtWt87/S/ERp3SnwLKM8c2StPq6ds9qalulW+pGwyT4ZTThezY6JCDH/k9twU3Pt9s6d6WXcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JheLgzQv; arc=none smtp.client-ip=91.218.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JheLgzQv"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RSjlz6cn9wBO7zIOSXfnxEQBP5VKqMIDpeLVafGaCgo=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254986; v=1; x=1788859786;
 b=JheLgzQvWPfBHtuwmtecBgmI79U/QPsnppVSaSKiOzTgIs0mYvcsRdje+Ge/eYT2C3KjHyyH
 BvP/RuUPwSvy+xJx/uDTEQW3u6K88UjyoNoJv59rqUQzoYw7Zowug6ooMYexsb7E0VOBMovh+WH
 ZimrgCrSKlMOfwXfG6BwgsjE=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id dbf785a091e2c594;
	Tue, 01 Sep 2026 09:29:46 +0000
X-Mizu-Trace-ID: dbf785a091e2c594
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Tue, 01 Sep 2026 11:10:26 +0200
Subject: [PATCH v4 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-toon-speed-up-last-modified-v4-6-a09949800404@iotcl.com>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

The last-modified builtin expands the pathspec to a set of literal paths
and builds a Bloom key for each. During the walk it looks those keys up
in the commit's filter to decide whether the commit is worth diffing.
These lookups need `bloom_filter_settings` for the key hashing.

prepare_revision_walk() runs prepare_to_use_bloom_filter() to build the
pathspec key vectors. For a pathspec that cannot be turned into a Bloom
key, such as a top-level wildcard like "*.c", that function gives up and
clears `bloom_filter_settings`.

Restore `bloom_filter_settings` after prepare_revision_walk() so the
per-path check keeps working for wildcard pathspecs.

This change isn't having any effect on the output, but only has an
impact on performance. Add a "bloom_queries" trace2 counter that records
how often the per-path Bloom check runs, and a test that asserts the
count increments as appropriate for a top-level wildcard pathspec.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  | 16 ++++++++++++++++
 t/t8020-last-modified.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 8ab7944314..bedccb3ace 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -18,6 +18,7 @@
 #include "quote.h"
 #include "repository.h"
 #include "revision.h"
+#include "trace2.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1 (1u<<16) /* used instead of SEEN */
@@ -63,6 +64,8 @@ struct last_modified {
 
 	/* 'scratch' to avoid allocating a bitmap every process_parent() */
 	struct bitmap *scratch;
+
+	unsigned int count_bloom_filter_queries;
 };
 
 static struct bitmap *active_paths_for(struct last_modified *lm, struct commit *c)
@@ -272,6 +275,8 @@ static bool maybe_changed_path(struct last_modified *lm,
 	if (!filter)
 		return true;
 
+	lm->count_bloom_filter_queries++;
+
 	/*
 	 * With --show-trees we also track the tree entries containing the
 	 * paths, so a change to any of those parent directories matters too.
@@ -370,6 +375,14 @@ static int last_modified_run(struct last_modified *lm)
 
 	prepare_revision_walk(&lm->rev);
 
+	/*
+	 * prepare_revision_walk() clears bloom_filter_settings for pathspecs
+	 * without a Bloom key. Restore it so the per-path check keeps working.
+	 */
+	if (!lm->rev.bloom_filter_settings)
+		lm->rev.bloom_filter_settings =
+			get_bloom_filter_settings(lm->rev.repo);
+
 	max_count = lm->rev.max_count;
 
 	init_active_paths_for_commit(&lm->active_paths);
@@ -479,6 +492,9 @@ static int last_modified_run(struct last_modified *lm)
 	if (hashmap_get_size(&lm->paths))
 		BUG("paths remaining beyond boundary in last-modified");
 
+	trace2_data_intmax("last-modified", lm->rev.repo, "bloom_queries",
+			   lm->count_bloom_filter_queries);
+
 	clear_prio_queue(&not_queue);
 	clear_prio_queue(&queue);
 	clear_active_paths_for_commit(&lm->active_paths);
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index e75437c18e..5be1d0f948 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -292,6 +292,32 @@ test_expect_success 'last-modified with Bloom filters and --show-trees' '
 	)
 '
 
+test_expect_success 'last-modified with Bloom filters and top-level wildcard' '
+	test_when_finished rm -rf wildcard &&
+	git init wildcard &&
+	(
+		cd wildcard &&
+		test_commit base-c a.c &&
+		test_commit base-h a.h &&
+		test_commit touch-c a.c &&
+		mkdir d &&
+		test_commit sub-c d/b.c &&
+
+		git commit-graph write --reachable --changed-paths &&
+		GIT_TEST_COMMIT_GRAPH=0 GIT_TRACE2_PERF="$(pwd)/off.perf" \
+			git -c core.commitGraph=false last-modified -r HEAD \
+			-- "*.c" >expect &&
+		test_grep "data .* bloom_queries:0$" off.perf &&
+
+		GIT_TEST_COMMIT_GRAPH=1 GIT_TRACE2_PERF="$(pwd)/on.perf" \
+			git -c core.commitGraph=true last-modified -r HEAD \
+			-- "*.c" >actual &&
+		test_grep "data .* bloom_queries:2$" on.perf &&
+
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'cannot run last-modified on two commits' '
 	test_must_fail git last-modified HEAD HEAD~1 2>err &&
 	test_grep "last-modified can only operate on one commit at a time" err

-- 
2.55.0.679.g6767b8d81c

