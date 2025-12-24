Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF552C11C9
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595817; cv=none; b=ak/1qISr/vOWsTArLSwX1nFBKsJlsLcQWXnjxJLos7/vVEUTSljvvkaLJxDUgOu2JceoaQvIF7bocubh4+vzkZwJ4MM5fsOW14FeDznhu62xZaK4ko+dFtZcJt3P5yJdb9pA2uWoJIJEx38P07RWK3D2ZOliVy3aP9Yv66XCtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595817; c=relaxed/simple;
	bh=qPUT0s+MKLYRgo4jQF7DsNB1NP5+HmxE1YUr6eSKyVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaANIvEHfJFdNEJYv6C1bKNBrqP96SoqXJImXxhVsK+KvRemlRh7aB299DtOSVd7rDEM/AXDseRDRrRxf7UtPBJ6/Qi9o0/BE5VuMvWPtGxSG5UbPb48AqSl2W2bBobMr6Vdk+/Ruuo6ITXfHg/mCb8Q3+91J9HcV2Aemc/vE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=MEg7VskZ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MEg7VskZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=HpEoV1zTmJLCGe52l0Q7EjKYvMb3ZOJ7AMmT8UAEVw4=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MEg7VskZ/a/hSVicHCqxDwoASbLo7nCcWLIqJLPEBd0ZY3+X2O1TL1oGWaKBHh2l
	 SfgZBaFxHOo4Pu/i1C6ilt5SLYLSJOpLxBKYyrdyiDDF0jb4BhjTLggyyIX5yl/bV
	 3o4Cyy+NI0q9iSpmaRw5+ZkglSCFhwnqNQso1nosG9zhSOP/J8HrAIsxE+1eWpfLA
	 4ks2BenXLowqPWq/UdY7GW+q3VH2Wla7qytb00awcfQl3V3aH20RCk/JBZpfvPELy
	 FzBTmlrfFrYdBb4na9v64XqRO+3yN37jvf+FceGgGC2J5sliwdw7NFa7akI9i2I1c
	 xHWG1LK/0Fg0gHvHww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MXGKA-1vRNdv2meU-00Y2lp for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 13/14] commit-graph: use commit_stack
Date: Wed, 24 Dec 2025 18:03:26 +0100
Message-ID: <20251224170327.68049-14-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224170327.68049-1-l.s.r@web.de>
References: <20251224170327.68049-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xrAsRbXNq+EroU8gCmQySRuhELMY6awkXovZ5z/PLLcor5yoy2B
 u99A/r74w9VFvcxImK0W/kgCX/VsjrisGPJsjp8nx18nncuAga5bdpUB2LstNDpKNH1IwD2
 rSvvIFYO0TkftBM9vAxamXX+RILGSv6i2FjQN3D+V0Mr5+EAoHS1cZkaNcKNqbIzjMYMoZ3
 cKpHHHVb4ZfPnJG2nHxEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fA2/6OGMcss=;u9De4vQiVvpMjFR9bPNrea9tiHp
 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

Replace a commit array implementation with commit_stack.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-graph.c | 86 +++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 80be2ff2c3..00e8193adc 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -1127,18 +1127,12 @@ struct tree *get_commit_tree_in_graph(struct repos=
itory *r, const struct commit
 	return get_commit_tree_in_graph_one(r->objects->commit_graph, c);
 }
=20
-struct packed_commit_list {
-	struct commit **list;
-	size_t nr;
-	size_t alloc;
-};
-
 struct write_commit_graph_context {
 	struct repository *r;
 	struct odb_source *odb_source;
 	char *graph_name;
 	struct oid_array oids;
-	struct packed_commit_list commits;
+	struct commit_stack commits;
 	int num_extra_edges;
 	int num_generation_data_overflows;
 	unsigned long approx_nr_objects;
@@ -1180,7 +1174,7 @@ static int write_graph_chunk_fanout(struct hashfile =
*f,
 {
 	struct write_commit_graph_context *ctx =3D data;
 	int i, count =3D 0;
-	struct commit **list =3D ctx->commits.list;
+	struct commit **list =3D ctx->commits.items;
=20
 	/*
 	 * Write the first-level table (the list is sorted,
@@ -1206,7 +1200,7 @@ static int write_graph_chunk_oids(struct hashfile *f=
,
 				  void *data)
 {
 	struct write_commit_graph_context *ctx =3D data;
-	struct commit **list =3D ctx->commits.list;
+	struct commit **list =3D ctx->commits.items;
 	int count;
 	for (count =3D 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1226,8 +1220,8 @@ static int write_graph_chunk_data(struct hashfile *f=
,
 				  void *data)
 {
 	struct write_commit_graph_context *ctx =3D data;
-	struct commit **list =3D ctx->commits.list;
-	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
+	struct commit **list =3D ctx->commits.items;
+	struct commit **last =3D ctx->commits.items + ctx->commits.nr;
 	uint32_t num_extra_edges =3D 0;
=20
 	while (list < last) {
@@ -1249,7 +1243,7 @@ static int write_graph_chunk_data(struct hashfile *f=
,
 			edge_value =3D GRAPH_PARENT_NONE;
 		else {
 			edge_value =3D oid_pos(&parent->item->object.oid,
-					     ctx->commits.list,
+					     ctx->commits.items,
 					     ctx->commits.nr,
 					     commit_to_oid);
=20
@@ -1280,7 +1274,7 @@ static int write_graph_chunk_data(struct hashfile *f=
,
 			edge_value =3D GRAPH_EXTRA_EDGES_NEEDED | num_extra_edges;
 		else {
 			edge_value =3D oid_pos(&parent->item->object.oid,
-					     ctx->commits.list,
+					     ctx->commits.items,
 					     ctx->commits.nr,
 					     commit_to_oid);
=20
@@ -1332,7 +1326,7 @@ static int write_graph_chunk_generation_data(struct =
hashfile *f,
 	int i, num_generation_data_overflows =3D 0;
=20
 	for (i =3D 0; i < ctx->commits.nr; i++) {
-		struct commit *c =3D ctx->commits.list[i];
+		struct commit *c =3D ctx->commits.items[i];
 		timestamp_t offset;
 		repo_parse_commit(ctx->r, c);
 		offset =3D commit_graph_data_at(c)->generation - c->date;
@@ -1355,7 +1349,7 @@ static int write_graph_chunk_generation_data_overflo=
w(struct hashfile *f,
 	struct write_commit_graph_context *ctx =3D data;
 	int i;
 	for (i =3D 0; i < ctx->commits.nr; i++) {
-		struct commit *c =3D ctx->commits.list[i];
+		struct commit *c =3D ctx->commits.items[i];
 		timestamp_t offset =3D commit_graph_data_at(c)->generation - c->date;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
=20
@@ -1372,8 +1366,8 @@ static int write_graph_chunk_extra_edges(struct hash=
file *f,
 					 void *data)
 {
 	struct write_commit_graph_context *ctx =3D data;
-	struct commit **list =3D ctx->commits.list;
-	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
+	struct commit **list =3D ctx->commits.items;
+	struct commit **last =3D ctx->commits.items + ctx->commits.nr;
 	struct commit_list *parent;
=20
 	while (list < last) {
@@ -1393,7 +1387,7 @@ static int write_graph_chunk_extra_edges(struct hash=
file *f,
 		/* Since num_parents > 2, this initializer is safe. */
 		for (parent =3D (*list)->parents->next; parent; parent =3D parent->next=
) {
 			int edge_value =3D oid_pos(&parent->item->object.oid,
-						 ctx->commits.list,
+						 ctx->commits.items,
 						 ctx->commits.nr,
 						 commit_to_oid);
=20
@@ -1427,8 +1421,8 @@ static int write_graph_chunk_bloom_indexes(struct ha=
shfile *f,
 					   void *data)
 {
 	struct write_commit_graph_context *ctx =3D data;
-	struct commit **list =3D ctx->commits.list;
-	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
+	struct commit **list =3D ctx->commits.items;
+	struct commit **last =3D ctx->commits.items + ctx->commits.nr;
 	uint32_t cur_pos =3D 0;
=20
 	while (list < last) {
@@ -1463,8 +1457,8 @@ static int write_graph_chunk_bloom_data(struct hashf=
ile *f,
 					void *data)
 {
 	struct write_commit_graph_context *ctx =3D data;
-	struct commit **list =3D ctx->commits.list;
-	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
+	struct commit **list =3D ctx->commits.items;
+	struct commit **last =3D ctx->commits.items + ctx->commits.nr;
=20
 	trace2_bloom_filter_settings(ctx);
=20
@@ -1585,7 +1579,7 @@ static void close_reachable(struct write_commit_grap=
h_context *ctx)
=20
 struct compute_generation_info {
 	struct repository *r;
-	struct packed_commit_list *commits;
+	struct commit_stack *commits;
 	struct progress *progress;
 	int progress_cnt;
=20
@@ -1622,7 +1616,7 @@ static void compute_reachable_generation_numbers(
 	struct commit_list *list =3D NULL;
=20
 	for (i =3D 0; i < info->commits->nr; i++) {
-		struct commit *c =3D info->commits->list[i];
+		struct commit *c =3D info->commits->items[i];
 		timestamp_t gen;
 		repo_parse_commit(info->r, c);
 		gen =3D info->get_generation(c, info->data);
@@ -1729,7 +1723,7 @@ static void compute_generation_numbers(struct write_=
commit_graph_context *ctx)
=20
 	if (!ctx->trust_generation_numbers) {
 		for (i =3D 0; i < ctx->commits.nr; i++) {
-			struct commit *c =3D ctx->commits.list[i];
+			struct commit *c =3D ctx->commits.items[i];
 			repo_parse_commit(ctx->r, c);
 			commit_graph_data_at(c)->generation =3D GENERATION_NUMBER_ZERO;
 		}
@@ -1738,7 +1732,7 @@ static void compute_generation_numbers(struct write_=
commit_graph_context *ctx)
 	compute_reachable_generation_numbers(&info, 2);
=20
 	for (i =3D 0; i < ctx->commits.nr; i++) {
-		struct commit *c =3D ctx->commits.list[i];
+		struct commit *c =3D ctx->commits.items[i];
 		timestamp_t offset =3D commit_graph_data_at(c)->generation - c->date;
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
 			ctx->num_generation_data_overflows++;
@@ -1760,8 +1754,8 @@ void ensure_generations_valid(struct repository *r,
 			      struct commit **commits, size_t nr)
 {
 	int generation_version =3D get_configured_generation_version(r);
-	struct packed_commit_list list =3D {
-		.list =3D commits,
+	struct commit_stack list =3D {
+		.items =3D commits,
 		.alloc =3D nr,
 		.nr =3D nr,
 	};
@@ -1804,7 +1798,7 @@ static void compute_bloom_filters(struct write_commi=
t_graph_context *ctx)
 			_("Computing commit changed paths Bloom filters"),
 			ctx->commits.nr);
=20
-	DUP_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
+	DUP_ARRAY(sorted_commits, ctx->commits.items, ctx->commits.nr);
=20
 	if (ctx->order_by_pack)
 		QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
@@ -1992,26 +1986,26 @@ static void copy_oids_to_commits(struct write_comm=
it_graph_context *ctx)
 	oid_array_sort(&ctx->oids);
 	for (i =3D 0; i < ctx->oids.nr; i =3D oid_array_next_unique(&ctx->oids, =
i)) {
 		unsigned int num_parents;
+		struct commit *commit;
=20
 		display_progress(ctx->progress, i + 1);
=20
-		ALLOC_GROW(ctx->commits.list, ctx->commits.nr + 1, ctx->commits.alloc);
-		ctx->commits.list[ctx->commits.nr] =3D lookup_commit(ctx->r, &ctx->oids=
.oid[i]);
+		commit =3D lookup_commit(ctx->r, &ctx->oids.oid[i]);
=20
 		if (ctx->split && flags !=3D COMMIT_GRAPH_SPLIT_REPLACE &&
-		    commit_graph_position(ctx->commits.list[ctx->commits.nr]) !=3D COMM=
IT_NOT_FROM_GRAPH)
+		    commit_graph_position(commit) !=3D COMMIT_NOT_FROM_GRAPH)
 			continue;
=20
 		if (ctx->split && flags =3D=3D COMMIT_GRAPH_SPLIT_REPLACE)
-			repo_parse_commit(ctx->r, ctx->commits.list[ctx->commits.nr]);
+			repo_parse_commit(ctx->r, commit);
 		else
-			repo_parse_commit_no_graph(ctx->r, ctx->commits.list[ctx->commits.nr])=
;
+			repo_parse_commit_no_graph(ctx->r, commit);
=20
-		num_parents =3D commit_list_count(ctx->commits.list[ctx->commits.nr]->p=
arents);
+		num_parents =3D commit_list_count(commit->parents);
 		if (num_parents > 2)
 			ctx->num_extra_edges +=3D num_parents - 1;
=20
-		ctx->commits.nr++;
+		commit_stack_push(&ctx->commits, commit);
 	}
 	stop_progress(&ctx->progress);
 }
@@ -2330,7 +2324,7 @@ static void merge_commit_graph(struct write_commit_g=
raph_context *ctx,
 		    oid_to_hex(&g->oid),
 		    (uintmax_t)st_add(ctx->commits.nr, g->num_commits));
=20
-	ALLOC_GROW(ctx->commits.list, ctx->commits.nr + g->num_commits, ctx->com=
mits.alloc);
+	commit_stack_grow(&ctx->commits, g->num_commits);
=20
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct object_id oid;
@@ -2343,10 +2337,8 @@ static void merge_commit_graph(struct write_commit_=
graph_context *ctx,
 		/* only add commits if they still exist in the repo */
 		result =3D lookup_commit_reference_gently(ctx->r, &oid, 1);
=20
-		if (result) {
-			ctx->commits.list[ctx->commits.nr] =3D result;
-			ctx->commits.nr++;
-		}
+		if (result)
+			commit_stack_push(&ctx->commits, result);
 	}
 }
=20
@@ -2367,14 +2359,14 @@ static void sort_and_scan_merged_commits(struct wr=
ite_commit_graph_context *ctx)
 					_("Scanning merged commits"),
 					ctx->commits.nr);
=20
-	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
+	QSORT(ctx->commits.items, ctx->commits.nr, commit_compare);
=20
 	ctx->num_extra_edges =3D 0;
 	for (i =3D 0; i < ctx->commits.nr; i++) {
 		display_progress(ctx->progress, i + 1);
=20
-		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
-			  &ctx->commits.list[i]->object.oid)) {
+		if (i && oideq(&ctx->commits.items[i - 1]->object.oid,
+			  &ctx->commits.items[i]->object.oid)) {
 			/*
 			 * Silently ignore duplicates. These were likely
 			 * created due to a commit appearing in multiple
@@ -2385,10 +2377,10 @@ static void sort_and_scan_merged_commits(struct wr=
ite_commit_graph_context *ctx)
 		} else {
 			unsigned int num_parents;
=20
-			ctx->commits.list[dedup_i] =3D ctx->commits.list[i];
+			ctx->commits.items[dedup_i] =3D ctx->commits.items[i];
 			dedup_i++;
=20
-			num_parents =3D commit_list_count(ctx->commits.list[i]->parents);
+			num_parents =3D commit_list_count(ctx->commits.items[i]->parents);
 			if (num_parents > 2)
 				ctx->num_extra_edges +=3D num_parents - 1;
 		}
@@ -2666,7 +2658,7 @@ int write_commit_graph(struct odb_source *source,
 cleanup:
 	free(ctx.graph_name);
 	free(ctx.base_graph_name);
-	free(ctx.commits.list);
+	commit_stack_clear(&ctx.commits);
 	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
=20
=2D-=20
2.52.0

