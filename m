Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8199DC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 23:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiGLXKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiGLXKh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 19:10:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D5B5D12
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:35 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a21so9437455qtw.10
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Gz853oxrMnlo9IcFjLnfmzhl+L3KoJMt4plt5FBr5I=;
        b=tM8f+OKekSwexIYwqXAAHnbUNLQU40IkYPWNuVNsgJrrjziBcVL1WyR1n3dHt+c9ko
         H2yZj9zpb+Qf6ea/Nvg/qOpij3zgeHN/4ry70DXHOtpnTEqBvYbWF785c1txngUbWAh1
         eXO47C5YJ7klNFhc+UF2Gef2T1QeQh+XRw3qVLhhe51Hpf8nIbo5nlqhw1esTcqWUE6x
         JJhGG0yYKmXA9rdeuQ7miDdvZa+mN68zxjxR/J0WnNpeFSBpQKWOimn5K6lgUnuFUMxY
         Vvdutuf+Z7uPPeARtZRDupX67+UL8he7yvjN3LdQdz7LT1zrYDfLteZJk1ou0/0xWK3m
         USQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Gz853oxrMnlo9IcFjLnfmzhl+L3KoJMt4plt5FBr5I=;
        b=d9pvNN9Z4UDiojqsRrNG4930k6q9idlRGKlpai+rBMacwkND1GErYRfZl9MuWAdH88
         txXGpOaZAO0qceFpsLk6VPE95enbBxzhau2luvAMyyxg2MZaJYwykQXoyhCkSwkebnsy
         m/VqIv6zFstv591t+TdBrjWiAqNSK18Gth+c7ZTtKIZfmA8kOVAlNrNwRpDSUbWNwzZR
         iJjgQywHdkJjqK3jsYJAZnjF1eN2PotrI2rRJrxebbXDimWvjKM2hZEsQsXujZSe7QpR
         6Hb1T4zew0QkHoHXuM+HHFRVH3o6k4iCcpTjKGSvmAsUjCflozSfUQK9x18tFkHPrcKA
         2tsw==
X-Gm-Message-State: AJIora+YSJA6wyHz04GkZSsCd3UQ4WHZ0LkHB87ZzyUB8S79QolgX5a4
        OIfX173jhnoaxKyvCM7X4cLF9RJISriQLw==
X-Google-Smtp-Source: AGRyM1vdrijecwgK0+pkMbpi0h9+8TmCRDWupZVCeGuoeq1bSm3i1lXimmwaYgPy0/YIE0eMo32T9A==
X-Received: by 2002:a05:622a:1453:b0:31d:4c06:4a04 with SMTP id v19-20020a05622a145300b0031d4c064a04mr385218qtx.432.1657667434604;
        Tue, 12 Jul 2022 16:10:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a44cd00b006b5a9e53105sm2139390qkp.91.2022.07.12.16.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:10:34 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:10:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net,
        ps@pks.im, wfc@wfchandler.org
Subject: [PATCH 3/3] commit-graph: fix corrupt upgrade from generation v1 to
 v2
Message-ID: <b39209718226b3e313ef4f610f02038c9faf0990.1657667404.git.me@ttaylorr.com>
References: <cover.1657667404.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1657667404.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit demonstrates a bug where a commit-graph using
generation v2 could enter a state where one of the GDA2 values has its
most-significant bit set (indicating that its value should be read from
the extended offset table in the GDO2 chunk) without having a GDO2 chunk
to read from.

This results in the following error message being displayed to the
caller:

    fatal: commit-graph requires overflow generation data but has none

This bug arises in the following scenario:

  - We decide to write a commit-graph using generation number v2, and
    decide (correctly) that no GDO2 chunk is necessary (e.g., because
    all of the commiter date offsets are no larger than 2^31-1).

  - The v2 generation numbers are stored in the `->generation` member of
    the commit slab holding `struct commit_graph_data`'s.

  - Later on, `load_commit_graph_info()` is called, overwriting the
    v2 generation data in the aforementioned slab with any existing v1
    generation data.

Then, when the commit-graph code goes to write the GDA2 chunk via
`write_graph_chunk_generation_data()`, we use the overwritten generation
v1 data in a place where we expect to use a v2 generation number:

    offset = commit_graph_data_at(c)->generation - c->date;

...because `commit_graph_data_at(c)->generation` used to hold the v2
generation data, but it was overwritten to contain the v1 generation
number via `load_commit_graph_info()`.

If the `offset` computation above overflows the v2 generation number
max, then `write_graph_chunk_generation_data()` will update its count of
large offsets and write the marker accordingly:

    if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
        offset = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_overflows;
        num_generation_data_overflows++;
    }

and reads will look for the GDO2 chunk containing the overflowing v2
generation number, *after* the commit-graph code decided that no such
chunk was necessary.

The main problem is that the slab containing `struct commit_graph_data`
has a dual purpose. It is used to hold data that we are about to write
to disk while generating a commit-graph, as well as hold data that was
read from an existing commit-graph.

When the two mix, namely when the result of reading the commit-graph has
a side-effect that mixes poorly with an in-progress commit-graph write,
we end up with corrupt data.

A complete fix might be to introduce a new slab that is used exclusively
for writing, and gate access between the two slabs based on context
provided by the caller (e.g., whether this computation is part of a
"read" or "write" operation).

But a more minimal fix addresses the only known path which overwrites
the slab data, which is `compute_bloom_filters()` ->
`get_or_compute_bloom_filter()` -> `load_commit_graph_info()` ->
`fill_commit_graph_info()` by avoiding the last call which clobbers the
data altogether.

This path only needs to learn the graph position of a given commit so
that it can be used in `load_bloom_filter_from_graph()`. By replacing
the last steps of the above with one that records the graph position
into a temporary variable which is then used to load the existing Bloom
data, we eliminate the clobbering, removing the corruption.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c                 | 10 +++++-----
 t/t5318-commit-graph.sh |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bloom.c b/bloom.c
index 5e297038bb..816f063dca 100644
--- a/bloom.c
+++ b/bloom.c
@@ -30,10 +30,9 @@ static inline unsigned char get_bitmask(uint32_t pos)
 
 static int load_bloom_filter_from_graph(struct commit_graph *g,
 					struct bloom_filter *filter,
-					struct commit *c)
+					uint32_t graph_pos)
 {
 	uint32_t lex_pos, start_index, end_index;
-	uint32_t graph_pos = commit_graph_position(c);
 
 	while (graph_pos < g->num_commits_in_base)
 		g = g->base_graph;
@@ -203,9 +202,10 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	filter = bloom_filter_slab_at(&bloom_filters, c);
 
 	if (!filter->data) {
-		load_commit_graph_info(r, c);
-		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
+		uint32_t graph_pos;
+		if (repo_find_commit_pos_in_graph(r, c, &graph_pos))
+			load_bloom_filter_from_graph(r->objects->commit_graph,
+						     filter, graph_pos);
 	}
 
 	if (filter->data && filter->len)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4d9f62f22d..f5f0895631 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -811,7 +811,7 @@ test_expect_success 'set up and verify repo with generation data overflow chunk'
 
 graph_git_behavior 'generation data overflow chunk repo' repo left right
 
-test_expect_failure 'overflow during generation version upgrade' '
+test_expect_success 'overflow during generation version upgrade' '
 	git init overflow-v2-upgrade &&
 	(
 		cd overflow-v2-upgrade &&
-- 
2.37.0.1.g1379af2e9d
