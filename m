Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681847360
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CtYq1NL8"
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69595109
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:39 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so780761241.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653958; x=1698258758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUcQw7kAaQdhzODxXGXAyeWbNhclDHUqp1EG+fdzWqQ=;
        b=CtYq1NL8wRS0P5McWsjV/nK5QDmmH3W86YKk+QAvbEgObRp5VN8RorCKwi0/Y5JLPM
         5QJBA+yQaMODWoOQgICkubVXOwsB3vA/lWRFYZddQafjUkPbokg4WO0yTk7/lK7j4gxO
         Zfj2cahQBXPNrb0R/taHyixxhCWlhRX+2bH4b6AOjF992jTeNAPMEURjuRwRByuyzizk
         oivdKPe5A8SrSgsry7cHx2frIqYHSRh6wCg72gRxdpvvsYi+dmjSR6Qjm5HkfYsD/1mk
         RgbTr3ZhRdFvjja00UnR3nA3mklf7ma1ao8nVZiMppqm1paYI9FhlITIcdgMO/q0Ym4+
         NXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653958; x=1698258758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUcQw7kAaQdhzODxXGXAyeWbNhclDHUqp1EG+fdzWqQ=;
        b=E/rKkCm8ZxagnZikVtsSwiLHfiS3EX0Xh6qZ5LqDcL9u51iH+DIyvksSX19VQtxHEm
         KKbiiQvGdBji+chqQuEP0omoDF7+/60c+0bP+Waai/3C2JzyXVWNYMEd2pWPR5r/u5Id
         sals7Syksh8HVSHnmrdMMVgL5Y5s6CQsJ44Z7LBL9MkFBVwh8I2MOZf2j+xDs5XiPCi7
         7YJ7/cMGeZ41rkqLx3NKscSwGxIX/FVfzLiZ5I+egq7HJ0wdruQKH9aY709M5NFSp2bA
         3VpW/fvj5psl4GYEhPOq+hgOMfmI3Ddrc1EFAWiKnzcsm/USHZO5aUIlw9A/rxajMmCo
         dxSA==
X-Gm-Message-State: AOJu0YxPdWPaKjqFbL4Ct+zMfyPXRiVCXZlE1vwijBN5MY59Voldb+nC
	Nw5vpyI/0fTfxZH3J/RI2Gcxt5NnO2ZWRNyF+qm+ug==
X-Google-Smtp-Source: AGHT+IHrXa1BxQzwG5JNU+2LKvNrwS0ZL00lsBiZli93yCtseNoZMNzbbN8JY+0ZAR46zC4GkIXNiQ==
X-Received: by 2002:a05:6102:4755:b0:452:603b:3d8b with SMTP id ej21-20020a056102475500b00452603b3d8bmr6889012vsb.33.1697653958328;
        Wed, 18 Oct 2023 11:32:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h20-20020ac87774000000b004180fb5c6adsm148731qtu.25.2023.10.18.11.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:38 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 03/17] commit-graph: ensure Bloom filters are read with
 consistent settings
Message-ID: <46d8a41005a0431a4f03b5fced7e1bb3705d5ed9.1697653929.git.me@ttaylorr.com>
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

The changed-path Bloom filter mechanism is parameterized by a couple of
variables, notably the number of bits per hash (typically "m" in Bloom
filter literature) and the number of hashes themselves (typically "k").

It is critically important that filters are read with the Bloom filter
settings that they were written with. Failing to do so would mean that
each query is liable to compute different fingerprints, meaning that the
filter itself could return a false negative. This goes against a basic
assumption of using Bloom filters (that they may return false positives,
but never false negatives) and can lead to incorrect results.

We have some existing logic to carry forward existing Bloom filter
settings from one layer to the next. In `write_commit_graph()`, we have
something like:

    if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
        struct commit_graph *g = ctx->r->objects->commit_graph;

        /* We have changed-paths already. Keep them in the next graph */
        if (g && g->chunk_bloom_data) {
            ctx->changed_paths = 1;
            ctx->bloom_settings = g->bloom_filter_settings;
        }
    }

, which drags forward Bloom filter settings across adjacent layers.

This doesn't quite address all cases, however, since it is possible for
intermediate layers to contain no Bloom filters at all. For example,
suppose we have two layers in a commit-graph chain, say, {G1, G2}. If G1
contains Bloom filters, but G2 doesn't, a new G3 (whose base graph is
G2) may be written with arbitrary Bloom filter settings, because we only
check the immediately adjacent layer's settings for compatibility.

This behavior has existed since the introduction of changed-path Bloom
filters. But in practice, this is not such a big deal, since the only
way up until this point to modify the Bloom filter settings at write
time is with the undocumented environment variables:

  - GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY
  - GIT_TEST_BLOOM_SETTINGS_NUM_HASHES
  - GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS

(it is still possible to tweak MAX_CHANGED_PATHS between layers, but
this does not affect reads, so is allowed to differ across multiple
graph layers).

But in future commits, we will introduce another parameter to change the
hash algorithm used to compute Bloom fingerprints itself. This will be
exposed via a configuration setting, making this foot-gun easier to use.

To prevent this potential issue, validate that all layers of a split
commit-graph have compatible settings with the newest layer which
contains Bloom filters.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Original-test-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c       | 25 +++++++++++++++++
 t/t4216-log-bloom.sh | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index fd2f700b2e..0ac79aff5a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -498,6 +498,30 @@ static int validate_mixed_generation_chain(struct commit_graph *g)
 	return 0;
 }
 
+static void validate_mixed_bloom_settings(struct commit_graph *g)
+{
+	struct bloom_filter_settings *settings = NULL;
+	for (; g; g = g->base_graph) {
+		if (!g->bloom_filter_settings)
+			continue;
+		if (!settings) {
+			settings = g->bloom_filter_settings;
+			continue;
+		}
+
+		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
+		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
+			g->chunk_bloom_indexes = NULL;
+			g->chunk_bloom_data = NULL;
+			FREE_AND_NULL(g->bloom_filter_settings);
+
+			warning(_("disabling Bloom filters for commit-graph "
+				  "layer '%s' due to incompatible settings"),
+				oid_to_hex(&g->oid));
+		}
+	}
+}
+
 static int add_graph_to_chain(struct commit_graph *g,
 			      struct commit_graph *chain,
 			      struct object_id *oids,
@@ -616,6 +640,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	}
 
 	validate_mixed_generation_chain(graph_chain);
+	validate_mixed_bloom_settings(graph_chain);
 
 	free(oids);
 	fclose(fp);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 322640feeb..2ea5e90955 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -420,4 +420,68 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+graph=.git/objects/info/commit-graph
+graphdir=.git/objects/info/commit-graphs
+chain=$graphdir/commit-graph-chain
+
+test_expect_success 'setup for mixed Bloom setting tests' '
+	repo=mixed-bloom-settings &&
+
+	git init $repo &&
+	for i in one two three
+	do
+		test_commit -C $repo $i file || return 1
+	done
+'
+
+test_expect_success 'ensure incompatible Bloom filters are ignored' '
+	# Compute Bloom filters with "unusual" settings.
+	git -C $repo rev-parse one >in &&
+	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
+		--stdin-commits --changed-paths --split <in &&
+	layer=$(head -n 1 $repo/$chain) &&
+
+	# A commit-graph layer without Bloom filters "hides" the layers
+	# below ...
+	git -C $repo rev-parse two >in &&
+	git -C $repo commit-graph write --stdin-commits --no-changed-paths \
+		--split=no-merge <in &&
+
+	# Another commit-graph layer that has Bloom filters, but with
+	# standard settings, and is thus incompatible with the base
+	# layer written above.
+	git -C $repo rev-parse HEAD >in &&
+	git -C $repo commit-graph write --stdin-commits --changed-paths \
+		--split=no-merge <in &&
+
+	test_line_count = 3 $repo/$chain &&
+
+	# Ensure that incompatible Bloom filters are ignored.
+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- file \
+		>expect 2>err &&
+	git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
+	test_cmp expect actual &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err
+'
+
+test_expect_success 'merge graph layers with incompatible Bloom settings' '
+	# Ensure that incompatible Bloom filters are ignored when
+	# merging existing layers.
+	git -C $repo commit-graph write --reachable --changed-paths 2>err &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
+
+	test_path_is_file $repo/$graph &&
+	test_dir_is_empty $repo/$graphdir &&
+
+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- \
+		file >expect &&
+	trace_out="$(pwd)/trace.perf" &&
+	GIT_TRACE2_PERF="$trace_out" \
+		git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
+
+	test_cmp expect actual &&
+	grep "statistics:{\"filter_not_present\":0," trace.perf &&
+	test_must_be_empty err
+'
+
 test_done
-- 
2.42.0.415.g8942f205c8

