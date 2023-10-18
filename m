Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76333450DB
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m3PbLkbC"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE2F7
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77897c4ac1fso45629085a.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697654003; x=1698258803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9CBGsuv3AIMIXyzwCHP/4s3XBu0GOLw1cw5IcyigcHM=;
        b=m3PbLkbCAQ7sp5k06/5UCsR/DM+e6SH8Ui4TLsHacHb23aWRpxRzfbMe7KxABoIakP
         9h/x3QVuToT2780SmNRiAlvOkmHDkyBCOut3eP7osu1zmm7Hr4rJ2jpW2dvo1nZJWjWy
         ST/S3Rfq7owDisAL2u4p0FoRnDqZOYCbStHMT83Kr78a/gkq8tUwPAAyuUovzAQHjPhI
         lXyyr4sUcSQoqgb2vtKFHrPlZj2kK5aEr+nd3w3WzaTKI7B5RejDijJ/r+Fkajy3MJte
         UjXJ2TJOV9dDhA1eI7g6hS8hRryglpPeZwD7kZ09/ihOcTiUbBGzk9+gXGQKCptddbjc
         V8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654003; x=1698258803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CBGsuv3AIMIXyzwCHP/4s3XBu0GOLw1cw5IcyigcHM=;
        b=RtGWOCAqoz5WUDWJ847xGaia5uRJyGlvIHx2vuRA96prnpNzGBRFLlf+wC5rOxIK5w
         gqYU++XkYaSBSVU5aC1TPAHh+kRs2y4UXW1eTNrNEqPOeZhsbyiZWvab+tbCKq2lPnew
         l8bMCqEFRD7Jxm/GRaWI1MSIY+SHAFFtXjNmBwHdcSTWF5sFDLs903xELvKEQ8ym9+Vm
         zimFzJExlnvm1+Sf8v0D8gBKQi0XykoHrlp66wLomlh79L2YZ3zfViW1JoIB0CU9JNjt
         4ZFcL9RbcdBzvnebFA4z/aneyF8fQlXthu/mKa17sC88DdciX479u7i0gg8ezRmuxY/R
         WevA==
X-Gm-Message-State: AOJu0YzqpRqH2PwAJ/LPlVjOD2ufD2SHu1aiXpdQRfY1XTyimxV1Zs/2
	nlr8GHANr7b1buNH7O/YlUKnhBLJUhpdpGBCjot4Xg==
X-Google-Smtp-Source: AGHT+IHDhKDwbarIXzF8MjmcA4UOtf0wkSDKhBCRV7gO7nATDcD+QuT/vq/2gHdoVW6hkUr1+67qXA==
X-Received: by 2002:a05:620a:1a0a:b0:775:681d:dc06 with SMTP id bk10-20020a05620a1a0a00b00775681ddc06mr7099704qkb.63.1697654003022;
        Wed, 18 Oct 2023 11:33:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a147c00b0077438383a07sm151162qkl.80.2023.10.18.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:22 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:33:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 16/17] commit-graph: reuse existing Bloom filters where
 possible
Message-ID: <6a12e39e7f5e2d68a23811a98276740646874662.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,
2023-08-01), a bug was described where it's possible for Git to produce
non-murmur3 hashes when the platform's "char" type is signed, and there
are paths with characters whose highest bit is set (i.e. all characters
>= 0x80).

That patch allows the caller to control which version of Bloom filters
are read and written. However, even on platforms with a signed "char"
type, it is possible to reuse existing Bloom filters if and only if
there are no changed paths in any commit's first parent tree-diff whose
characters have their highest bit set.

When this is the case, we can reuse the existing filter without having
to compute a new one. This is done by marking trees which are known to
have (or not have) any such paths. When a commit's root tree is verified
to not have any such paths, we mark it as such and declare that the
commit's Bloom filter is reusable.

Note that this heuristic only goes in one direction. If neither a commit
nor its first parent have any paths in their trees with non-ASCII
characters, then we know for certain that a path with non-ASCII
characters will not appear in a tree-diff against that commit's first
parent. The reverse isn't necessarily true: just because the tree-diff
doesn't contain any such paths does not imply that no such paths exist
in either tree.

So we end up recomputing some Bloom filters that we don't strictly have
to (i.e. their bits are the same no matter which version of murmur3 we
use). But culling these out is impossible, since we'd have to perform
the full tree-diff, which is the same effort as computing the Bloom
filter from scratch.

But because we can cache our results in each tree's flag bits, we can
often avoid recomputing many filters, thereby reducing the time it takes
to run

    $ git commit-graph write --changed-paths --reachable

when upgrading from v1 to v2 Bloom filters.

To benchmark this, let's generate a commit-graph in linux.git with v1
changed-paths in generation order[^1]:

    $ git clone git@github.com:torvalds/linux.git
    $ cd linux
    $ git commit-graph write --reachable --changed-paths
    $ graph=".git/objects/info/commit-graph"
    $ mv $graph{,.bak}

Then let's time how long it takes to go from v1 to v2 filters (with and
without the upgrade path enabled), resetting the state of the
commit-graph each time:

    $ git config commitGraph.changedPathsVersion 2
    $ hyperfine -p 'cp -f $graph.bak $graph' -L v 0,1 \
        'GIT_TEST_UPGRADE_BLOOM_FILTERS={v} git.compile commit-graph write --reachable --changed-paths'

On linux.git (where there aren't any non-ASCII paths), the timings
indicate that this patch represents a speed-up over recomputing all
Bloom filters from scratch:

    Benchmark 1: GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit-graph write --reachable --changed-paths
      Time (mean ± σ):     124.873 s ±  0.316 s    [User: 124.081 s, System: 0.643 s]
      Range (min … max):   124.621 s … 125.227 s    3 runs

    Benchmark 2: GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths
      Time (mean ± σ):     79.271 s ±  0.163 s    [User: 74.611 s, System: 4.521 s]
      Range (min … max):   79.112 s … 79.437 s    3 runs

    Summary
      'GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths' ran
        1.58 ± 0.01 times faster than 'GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit-graph write --reachable --changed-paths'

On git.git, we do have some non-ASCII paths, giving us a more modest
improvement from 4.163 seconds to 3.348 seconds, for a 1.24x speed-up.
On my machine, the stats for git.git are:

  - 8,285 Bloom filters computed from scratch
  - 10 Bloom filters generated as empty
  - 4 Bloom filters generated as truncated due to too many changed paths
  - 65,114 Bloom filters were reused when transitioning from v1 to v2.

[^1]: Note that this is is important, since `--stdin-packs` or
  `--stdin-commits` orders commits in the commit-graph by their pack
  position (with `--stdin-packs`) or in the raw input (with
  `--stdin-commits`).

  Since we compute Bloom filters in the same order that commits appear
  in the graph, we must see a commit's (first) parent before we process
  the commit itself. This is only guaranteed to happen when sorting
  commits by their generation number.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c              | 90 ++++++++++++++++++++++++++++++++++++++++++--
 bloom.h              |  1 +
 commit-graph.c       |  5 +++
 object.h             |  1 +
 t/t4216-log-bloom.sh | 35 ++++++++++++++++-
 5 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/bloom.c b/bloom.c
index 739fa093ba..24dd874e46 100644
--- a/bloom.c
+++ b/bloom.c
@@ -7,6 +7,9 @@
 #include "commit-graph.h"
 #include "commit.h"
 #include "commit-slab.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "config.h"
 
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
 
@@ -250,6 +253,73 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
 	filter->version = version;
 }
 
+#define VISITED   (1u<<21)
+#define HIGH_BITS (1u<<22)
+
+static int has_entries_with_high_bit(struct repository *r, struct tree *t)
+{
+	if (parse_tree(t))
+		return 1;
+
+	if (!(t->object.flags & VISITED)) {
+		struct tree_desc desc;
+		struct name_entry entry;
+
+		init_tree_desc(&desc, t->buffer, t->size);
+		while (tree_entry(&desc, &entry)) {
+			size_t i;
+			for (i = 0; i < entry.pathlen; i++) {
+				if (entry.path[i] & 0x80) {
+					t->object.flags |= HIGH_BITS;
+					goto done;
+				}
+			}
+
+			if (S_ISDIR(entry.mode)) {
+				struct tree *sub = lookup_tree(r, &entry.oid);
+				if (sub && has_entries_with_high_bit(r, sub)) {
+					t->object.flags |= HIGH_BITS;
+					goto done;
+				}
+			}
+
+		}
+
+done:
+		t->object.flags |= VISITED;
+	}
+
+	return !!(t->object.flags & HIGH_BITS);
+}
+
+static int commit_tree_has_high_bit_paths(struct repository *r,
+					  struct commit *c)
+{
+	struct tree *t;
+	if (repo_parse_commit(r, c))
+		return 1;
+	t = repo_get_commit_tree(r, c);
+	if (!t)
+		return 1;
+	return has_entries_with_high_bit(r, t);
+}
+
+static struct bloom_filter *upgrade_filter(struct repository *r, struct commit *c,
+					   struct bloom_filter *filter,
+					   int hash_version)
+{
+	struct commit_list *p = c->parents;
+	if (commit_tree_has_high_bit_paths(r, c))
+		return NULL;
+
+	if (p && commit_tree_has_high_bit_paths(r, p->item))
+		return NULL;
+
+	filter->version = hash_version;
+
+	return filter;
+}
+
 struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
 {
 	struct bloom_filter *filter;
@@ -292,9 +362,23 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						     filter, graph_pos);
 	}
 
-	if ((filter->data && filter->len) &&
-	    (!settings || settings->hash_version == filter->version))
-		return filter;
+	if (filter->data && filter->len) {
+		struct bloom_filter *upgrade;
+		if (!settings || settings->hash_version == filter->version)
+			return filter;
+
+		/* version mismatch, see if we can upgrade */
+		if (compute_if_not_present &&
+		    git_env_bool("GIT_TEST_UPGRADE_BLOOM_FILTERS", 1)) {
+			upgrade = upgrade_filter(r, c, filter,
+						 settings->hash_version);
+			if (upgrade) {
+				if (computed)
+					*computed |= BLOOM_UPGRADED;
+				return upgrade;
+			}
+		}
+	}
 	if (!compute_if_not_present)
 		return NULL;
 
diff --git a/bloom.h b/bloom.h
index bfe389e29c..e3a9b68905 100644
--- a/bloom.h
+++ b/bloom.h
@@ -102,6 +102,7 @@ enum bloom_filter_computed {
 	BLOOM_COMPUTED     = (1 << 1),
 	BLOOM_TRUNC_LARGE  = (1 << 2),
 	BLOOM_TRUNC_EMPTY  = (1 << 3),
+	BLOOM_UPGRADED     = (1 << 4),
 };
 
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
diff --git a/commit-graph.c b/commit-graph.c
index b70d57b085..50dcbb4d9b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1102,6 +1102,7 @@ struct write_commit_graph_context {
 	int count_bloom_filter_not_computed;
 	int count_bloom_filter_trunc_empty;
 	int count_bloom_filter_trunc_large;
+	int count_bloom_filter_upgraded;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1709,6 +1710,8 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 			   ctx->count_bloom_filter_trunc_empty);
 	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-large",
 			   ctx->count_bloom_filter_trunc_large);
+	trace2_data_intmax("commit-graph", ctx->r, "filter-upgraded",
+			   ctx->count_bloom_filter_upgraded);
 }
 
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
@@ -1750,6 +1753,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 				ctx->count_bloom_filter_trunc_empty++;
 			if (computed & BLOOM_TRUNC_LARGE)
 				ctx->count_bloom_filter_trunc_large++;
+		} else if (computed & BLOOM_UPGRADED) {
+			ctx->count_bloom_filter_upgraded++;
 		} else if (computed & BLOOM_NOT_COMPUTED)
 			ctx->count_bloom_filter_not_computed++;
 		ctx->total_bloom_filter_data_size += filter
diff --git a/object.h b/object.h
index db25714b4e..2e5e08725f 100644
--- a/object.h
+++ b/object.h
@@ -75,6 +75,7 @@ void object_array_init(struct object_array *array);
  * commit-reach.c:                                  16-----19
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
+ * bloom.c:                                                    2122
  * builtin/fsck.c:           0--3
  * builtin/gc.c:             0
  * builtin/index-pack.c:                                     2021
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 68066b7928..569f2b6f8b 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -221,6 +221,10 @@ test_filter_trunc_large () {
 	grep "\"key\":\"filter-trunc-large\",\"value\":\"$1\"" $2
 }
 
+test_filter_upgraded () {
+	grep "\"key\":\"filter-upgraded\",\"value\":\"$1\"" $2
+}
+
 test_expect_success 'correctly report changes over limit' '
 	git init limits &&
 	(
@@ -628,7 +632,13 @@ test_expect_success 'when writing another commit graph, preserve existing versio
 test_expect_success 'when writing commit graph, do not reuse changed-path of another version' '
 	git init doublewrite &&
 	test_commit -C doublewrite c "$CENT" &&
+
 	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C doublewrite commit-graph write --reachable --changed-paths &&
+	test_filter_computed 1 trace2.txt &&
+	test_filter_upgraded 0 trace2.txt &&
+
 	git -C doublewrite commit-graph write --reachable --changed-paths &&
 	for v in -2 3
 	do
@@ -639,8 +649,13 @@ test_expect_success 'when writing commit graph, do not reuse changed-path of ano
 		EOF
 		test_cmp expect err || return 1
 	done &&
+
 	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
-	git -C doublewrite commit-graph write --reachable --changed-paths &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C doublewrite commit-graph write --reachable --changed-paths &&
+	test_filter_computed 1 trace2.txt &&
+	test_filter_upgraded 0 trace2.txt &&
+
 	(
 		cd doublewrite &&
 		echo "c01f" >expect &&
@@ -649,4 +664,22 @@ test_expect_success 'when writing commit graph, do not reuse changed-path of ano
 	)
 '
 
+test_expect_success 'when writing commit graph, reuse changed-path of another version where possible' '
+	git init upgrade &&
+
+	test_commit -C upgrade base no-high-bits &&
+
+	git -C upgrade config --add commitgraph.changedPathsVersion 1 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C upgrade commit-graph write --reachable --changed-paths &&
+	test_filter_computed 1 trace2.txt &&
+	test_filter_upgraded 0 trace2.txt &&
+
+	git -C upgrade config --add commitgraph.changedPathsVersion 2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C upgrade commit-graph write --reachable --changed-paths &&
+	test_filter_computed 0 trace2.txt &&
+	test_filter_upgraded 1 trace2.txt
+'
+
 test_done
-- 
2.42.0.415.g8942f205c8

