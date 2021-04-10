Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F61C43461
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A05611C9
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhDJPWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58496 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234754AbhDJPWs (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 19F8360426;
        Sat, 10 Apr 2021 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068153;
        bh=vi3bbWnz2HPS7/axVhpa5eRjP7774GHHMKH5AeE6dE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sDupepxuonrsMTZ1toOHpCpD0TT0koh/PTC3fRWQb2NF4dTZ7hhtLKktyf+Ntf6uD
         51MLw63bu204CmYiW5w4I3+U/MnYnaCre9V9iEtgR3FjETW0y7wV/p6S2Q4UeK6Mib
         WgL42y82NdDflAqzCUpbsZI21uMitsp74oG+1ZfiHPTgEL80Tr+9CbzzidSdQpA4oZ
         z3H1EbmhNFjTvLcQIKyi0PCRcF0Qyt96DZ1TT9kA4Wq3Y+OIPRKL5CRmz+UghKCFw8
         0ve3xsq/xlK7mBqR8Ci95bPc1g3YV4WIRtWhGtEgQFuqD27VAZJPZVvk+jcI9yZoy3
         Q85O+ZNFRv8WowtK4R5D4Xse2f4O1T4viedWzaumuVQcmlzBw35qgf2KLAp2BZ23c2
         velEDNEWoqRbrTjeLCIlxHBJE6Vt0ziH3O1FW08CWs+52ssrwSFElQSn1DCYVdt/CB
         1f0FCQBELkVjL0g4joAcDqrb+pyEywWs4PyDfKtmjVLSBctifAJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 04/15] Always use oidread to read into struct object_id
Date:   Sat, 10 Apr 2021 15:21:29 +0000
Message-Id: <20210410152140.3525040-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll want oidread to automatically set the hash
algorithm member for an object ID we read into it, so ensure we use
oidread instead of hashcpy everywhere we're copying a hash value into a
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c                |  2 +-
 builtin/fast-import.c    |  4 ++--
 builtin/index-pack.c     |  4 ++--
 builtin/unpack-objects.c |  2 +-
 commit-graph.c           | 12 ++++++------
 dir.c                    |  4 ++--
 http-walker.c            |  2 +-
 match-trees.c            |  2 +-
 midx.c                   |  2 +-
 notes.c                  |  4 ++--
 read-cache.c             |  4 ++--
 split-index.c            |  2 +-
 tree-walk.c              |  2 +-
 13 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/archive.c b/archive.c
index 295615580d..6cfb9e42d6 100644
--- a/archive.c
+++ b/archive.c
@@ -203,7 +203,7 @@ static void queue_directory(const unsigned char *sha1,
 	d->mode	   = mode;
 	c->bottom  = d;
 	d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
-	hashcpy(d->oid.hash, sha1);
+	oidread(&d->oid, sha1);
 }
 
 static int write_directory(struct archiver_context *c)
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3afa81cf9a..9d2a058a66 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1276,8 +1276,8 @@ static void load_tree(struct tree_entry *root)
 		e->versions[0].mode = e->versions[1].mode;
 		e->name = to_atom(c, strlen(c));
 		c += e->name->str_len + 1;
-		hashcpy(e->versions[0].oid.hash, (unsigned char *)c);
-		hashcpy(e->versions[1].oid.hash, (unsigned char *)c);
+		oidread(&e->versions[0].oid, (unsigned char *)c);
+		oidread(&e->versions[1].oid, (unsigned char *)c);
 		c += the_hash_algo->rawsz;
 	}
 	free(buf);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 15507b5cff..41e2c240b8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -524,7 +524,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		hashcpy(ref_oid->hash, fill(the_hash_algo->rawsz));
+		oidread(ref_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
 		break;
 	case OBJ_OFS_DELTA:
@@ -1358,7 +1358,7 @@ static struct object_entry *append_obj_to_pack(struct hashfile *f,
 	obj[1].idx.offset += write_compressed(f, buf, size);
 	obj[0].idx.crc32 = crc32_end(f);
 	hashflush(f);
-	hashcpy(obj->idx.oid.hash, sha1);
+	oidread(&obj->idx.oid, sha1);
 	return obj;
 }
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a70b17f8f..a8b73ecf43 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -355,7 +355,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	struct object_id base_oid;
 
 	if (type == OBJ_REF_DELTA) {
-		hashcpy(base_oid.hash, fill(the_hash_algo->rawsz));
+		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
 		delta_data = get_data(delta_size);
 		if (dry_run || !delta_data) {
diff --git a/commit-graph.c b/commit-graph.c
index f18380b922..23fef56d31 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -425,7 +425,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
-	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
+	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_len);
 
 	if (verify_commit_graph_lite(graph))
 		goto free_and_return;
@@ -746,7 +746,7 @@ static void load_oid_from_graph(struct commit_graph *g,
 
 	lex_index = pos - g->num_commits_in_base;
 
-	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * lex_index);
+	oidread(oid, g->chunk_oid_lookup + g->hash_len * lex_index);
 }
 
 static struct commit_list **insert_parent_or_die(struct repository *r,
@@ -939,7 +939,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 	commit_data = g->chunk_commit_data +
 			GRAPH_DATA_WIDTH * (graph_pos - g->num_commits_in_base);
 
-	hashcpy(oid.hash, commit_data);
+	oidread(&oid, commit_data);
 	set_commit_tree(c, lookup_tree(r, &oid));
 
 	return c->maybe_tree;
@@ -2322,7 +2322,7 @@ int write_commit_graph(struct object_directory *odb,
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
-			hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+			oidread(&oid, g->chunk_oid_lookup + g->hash_len * i);
 			oid_array_append(&ctx->oids, &oid);
 		}
 	}
@@ -2453,7 +2453,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
 
-		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+		oidread(&cur_oid, g->chunk_oid_lookup + g->hash_len * i);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
 			graph_report(_("commit-graph has incorrect OID order: %s then %s"),
@@ -2501,7 +2501,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		timestamp_t generation;
 
 		display_progress(progress, i + 1);
-		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+		oidread(&cur_oid, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
 		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
diff --git a/dir.c b/dir.c
index 3474e67e8f..813dd7ba53 100644
--- a/dir.c
+++ b/dir.c
@@ -3344,7 +3344,7 @@ static void read_oid(size_t pos, void *cb)
 		rd->data = rd->end + 1;
 		return;
 	}
-	hashcpy(ud->exclude_oid.hash, rd->data);
+	oidread(&ud->exclude_oid, rd->data);
 	rd->data += the_hash_algo->rawsz;
 }
 
@@ -3352,7 +3352,7 @@ static void load_oid_stat(struct oid_stat *oid_stat, const unsigned char *data,
 			  const unsigned char *sha1)
 {
 	stat_data_from_disk(&oid_stat->stat, data);
-	hashcpy(oid_stat->oid.hash, sha1);
+	oidread(&oid_stat->oid, sha1);
 	oid_stat->valid = 1;
 }
 
diff --git a/http-walker.c b/http-walker.c
index 4fb1235cd4..90d8ecb57e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -155,7 +155,7 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 
 	newreq = xmalloc(sizeof(*newreq));
 	newreq->walker = walker;
-	hashcpy(newreq->oid.hash, sha1);
+	oidread(&newreq->oid, sha1);
 	newreq->repo = data->alt;
 	newreq->state = WAITING;
 	newreq->req = NULL;
diff --git a/match-trees.c b/match-trees.c
index f6c194c1cc..df413989fa 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -226,7 +226,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		    oid_to_hex(oid1));
 	if (*subpath) {
 		struct object_id tree_oid;
-		hashcpy(tree_oid.hash, rewrite_here);
+		oidread(&tree_oid, rewrite_here);
 		status = splice_tree(&tree_oid, subpath, oid2, &subtree);
 		if (status)
 			return status;
diff --git a/midx.c b/midx.c
index 9e86583172..21d6a05e88 100644
--- a/midx.c
+++ b/midx.c
@@ -247,7 +247,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	if (n >= m->num_objects)
 		return NULL;
 
-	hashcpy(oid->hash, m->chunk_oid_lookup + m->hash_len * n);
+	oidread(oid, m->chunk_oid_lookup + m->hash_len * n);
 	return oid;
 }
 
diff --git a/notes.c b/notes.c
index a19e4ad794..a44b25858f 100644
--- a/notes.c
+++ b/notes.c
@@ -352,7 +352,7 @@ static void add_non_note(struct notes_tree *t, char *path,
 	n->next = NULL;
 	n->path = path;
 	n->mode = mode;
-	hashcpy(n->oid.hash, sha1);
+	oidread(&n->oid, sha1);
 	t->prev_non_note = n;
 
 	if (!t->first_non_note) {
@@ -1134,7 +1134,7 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
-	hashcpy(l.key_oid.hash, object_sha1);
+	oidread(&l.key_oid, object_sha1);
 	oidclr(&l.val_oid);
 	note_tree_remove(t, t->root, 0, &l);
 	if (is_null_oid(&l.val_oid)) /* no note was removed */
diff --git a/read-cache.c b/read-cache.c
index 5a907af2fb..2944146545 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1845,7 +1845,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	ce->index = 0;
-	hashcpy(ce->oid.hash, ondisk->data);
+	oidread(&ce->oid, ondisk->data);
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
 
@@ -2195,7 +2195,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
-	hashcpy(istate->oid.hash, (const unsigned char *)hdr + mmap_size - the_hash_algo->rawsz);
+	oidread(&istate->oid, (const unsigned char *)hdr + mmap_size - the_hash_algo->rawsz);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
diff --git a/split-index.c b/split-index.c
index 94937d21a3..4d6e52d46f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -21,7 +21,7 @@ int read_link_extension(struct index_state *istate,
 	if (sz < the_hash_algo->rawsz)
 		return error("corrupt link extension (too short)");
 	si = init_split_index(istate);
-	hashcpy(si->base_oid.hash, data);
+	oidread(&si->base_oid, data);
 	data += the_hash_algo->rawsz;
 	sz -= the_hash_algo->rawsz;
 	if (!sz)
diff --git a/tree-walk.c b/tree-walk.c
index 2d6226d5f1..3a94959d64 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -49,7 +49,7 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 	desc->entry.path = path;
 	desc->entry.mode = canon_mode(mode);
 	desc->entry.pathlen = len - 1;
-	hashcpy(desc->entry.oid.hash, (const unsigned char *)path + len);
+	oidread(&desc->entry.oid, (const unsigned char *)path + len);
 
 	return 0;
 }
