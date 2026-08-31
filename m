Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6ED5355A3
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189567; cv=none; b=IGx+s3vPyZ1hRI7w+J1aiC/SrYZLj7JB9I7tAjxas6KykEHORuLBXm7+wRpi6UzaJAY1jgQ0d5Zis6GJPBbFrTukDfTY32K2+8IeENyN6Rl5pb/zeTjMcb8uGzIV7syGQpyZ4LJDWdFS8Fzd8f+nOGNxrAbrjD3MBQA6mBurPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189567; c=relaxed/simple;
	bh=8uIHnUzpY2KEZa065LgC2CQGvJSyZ9tUHUiqFx64O2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MS7P09NfisskcxpE9TOqhSPYFnjpp42Nq8niSTncdXI23KOcLoCNiY1QtOFDrmwta/J6wM3hkkzUjES+J6Vl7gXD8O7Si2H9byxEsthwupBhHBcya7+W4r/IUEAn23d7R3Jr8qOyRVutIFYfBCqiCRlpOlE8BV7ic8rXpJ/leWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4VeW511F; arc=none smtp.client-ip=91.218.175.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4VeW511F"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8uIHnUzpY2KEZa065LgC2CQGvJSyZ9tUHUiqFx64O2A=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788189563; v=1; x=1788794363;
 b=4VeW511FKWtuxurSIVIM303sEYJffWhgto63vX17GUOjJn3Xo0nNPZMgViIBpFq5OBh7lc71
 bSSeCNDcyMBZOZc0doNKTg6Ezw+Zu6ctmayrouQtJBLWZFxwB+o7wTqxpHJnUHNhWcLm0mim/on
 eejlQjuYJKZ/WdGsckBr+XiQ=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id bf312aa8e8f969d2;
	Mon, 31 Aug 2026 15:19:23 +0000
X-Mizu-Trace-ID: bf312aa8e8f969d2
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Mon, 31 Aug 2026 17:18:46 +0200
Subject: [PATCH v3 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-toon-speed-up-last-modified-v3-6-2bbb864acf93@iotcl.com>
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
In-Reply-To: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
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
index df73c7d0d0..75b18ee83b 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -290,6 +290,32 @@ test_expect_success 'last-modified with Bloom filters and --show-trees' '
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
+		GIT_TRACE2_PERF="$(pwd)/off.perf" \
+			git -c core.commitGraph=false last-modified -r HEAD \
+			-- "*.c" >expect &&
+		test_grep "data .* bloom_queries:0$" off.perf &&
+
+		GIT_TRACE2_PERF="$(pwd)/on.perf" \
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

