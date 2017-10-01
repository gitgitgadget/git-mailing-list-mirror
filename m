Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E842120A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdJAWJw (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54166 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751092AbdJAWJB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D51E60DA9;
        Sun,  1 Oct 2017 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895740;
        bh=+o8vGP8ZFujcgGx8gJP4Y97LzFV3ElBGn9hLYhuuYvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAW1RKC2nucimWF/mjjzInf0NLQR4oG6i/8s8vRTzZiN2MPlcWB0WJMa267JSCvMh
         JDJ/JQz4q298MM4lfQLpVbBbhmEXtHfxAXCIko0+DE+n5rFPlVXA/oS9qdyIRYo1Xr
         rS8OdyEgHI+te76TkV708wFta+L8TezA18RVji0NZFYx5Y+HsZ7AZaekKjSfB79u3t
         ImsWOJC63GWTdro/04JdCq32oh/KFPjtwr88Q2se6RxyxRuwSkXrhBvjkaxupNRxUl
         pzZ8oaPnt+Jmb7sArpfkKENmb+yMLsMr8poso+dnWU6eTPPf63R7CCInpXdlymFzTd
         nRY7LeiT4nd7/FF31iGNdWNZXxI5yiDyx2IpNFNSo9+/oVaKOZg8U7gmgu+N6TQnJ3
         kGC7dgOh5CGNTAZKn+UsGaS7LzufEQslhfpAw0PqmjzdJDxqshivIRmDWZKE+UdGz7
         ReJt5qRedqZbCqwIRcDjD58uVWLrUFSVrriNrQvCU8y3b9Sg5lW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/24] builtin/pack-objects: convert to struct object_id
Date:   Sun,  1 Oct 2017 22:08:20 +0000
Message-Id: <20171001220831.214705-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is one of the last unconverted callers to peel_ref.  While we're
fixing that, convert the rest of the file, since it will need to be
converted at some point anyway.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c | 131 +++++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 65 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 180c17904b..cde4c96f3d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -151,7 +151,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 }
 
 static unsigned long write_large_blob_data(struct git_istream *st, struct sha1file *f,
-					   const unsigned char *sha1)
+					   const struct object_id *oid)
 {
 	git_zstream stream;
 	unsigned char ibuf[1024 * 16];
@@ -165,7 +165,7 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct sha1fi
 		int zret = Z_OK;
 		readlen = read_istream(st, ibuf, sizeof(ibuf));
 		if (readlen == -1)
-			die(_("unable to read %s"), sha1_to_hex(sha1));
+			die(_("unable to read %s"), oid_to_hex(oid));
 
 		stream.next_in = ibuf;
 		stream.avail_in = readlen;
@@ -339,7 +339,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 		sha1write(f, header, hdrlen);
 	}
 	if (st) {
-		datalen = write_large_blob_data(st, f, entry->idx.oid.hash);
+		datalen = write_large_blob_data(st, f, &entry->idx.oid);
 		close_istream(st);
 	} else {
 		sha1write(f, buf, datalen);
@@ -557,13 +557,13 @@ static enum write_one_status write_one(struct sha1file *f,
 static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 		       void *cb_data)
 {
-	unsigned char peeled[20];
+	struct object_id peeled;
 	struct object_entry *entry = packlist_find(&to_pack, oid->hash, NULL);
 
 	if (entry)
 		entry->tagged = 1;
-	if (!peel_ref(path, peeled)) {
-		entry = packlist_find(&to_pack, peeled, NULL);
+	if (!peel_ref(path, peeled.hash)) {
+		entry = packlist_find(&to_pack, peeled.hash, NULL);
 		if (entry)
 			entry->tagged = 1;
 	}
@@ -792,7 +792,7 @@ static void write_pack_file(void)
 	write_order = compute_write_order();
 
 	do {
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *pack_tmp_name = NULL;
 
 		if (pack_to_stdout)
@@ -823,13 +823,13 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			sha1close(f, sha1, CSUM_CLOSE);
+			sha1close(f, oid.hash, CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			sha1close(f, sha1, CSUM_FSYNC);
+			sha1close(f, oid.hash, CSUM_FSYNC);
 		} else {
-			int fd = sha1close(f, sha1, 0);
-			fixup_pack_header_footer(fd, sha1, pack_tmp_name,
-						 nr_written, sha1, offset);
+			int fd = sha1close(f, oid.hash, 0);
+			fixup_pack_header_footer(fd, oid.hash, pack_tmp_name,
+						 nr_written, oid.hash, offset);
 			close(fd);
 			if (write_bitmap_index) {
 				warning(_(no_split_warning));
@@ -863,16 +863,16 @@ static void write_pack_file(void)
 			strbuf_addf(&tmpname, "%s-", base_name);
 
 			if (write_bitmap_index) {
-				bitmap_writer_set_checksum(sha1);
+				bitmap_writer_set_checksum(oid.hash);
 				bitmap_writer_build_type_index(written_list, nr_written);
 			}
 
 			finish_tmp_packfile(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, sha1);
+					    &pack_idx_opts, oid.hash);
 
 			if (write_bitmap_index) {
-				strbuf_addf(&tmpname, "%s.bitmap", sha1_to_hex(sha1));
+				strbuf_addf(&tmpname, "%s.bitmap", oid_to_hex(&oid));
 
 				stop_progress(&progress_state);
 
@@ -887,7 +887,7 @@ static void write_pack_file(void)
 
 			strbuf_release(&tmpname);
 			free(pack_tmp_name);
-			puts(sha1_to_hex(sha1));
+			puts(oid_to_hex(&oid));
 		}
 
 		/* mark written objects as written to previous pack */
@@ -928,13 +928,13 @@ static int no_try_delta(const char *path)
  * found the item, since that saves us from having to look it up again a
  * few lines later when we want to add the new entry.
  */
-static int have_duplicate_entry(const unsigned char *sha1,
+static int have_duplicate_entry(const struct object_id *oid,
 				int exclude,
 				uint32_t *index_pos)
 {
 	struct object_entry *entry;
 
-	entry = packlist_find(&to_pack, sha1, index_pos);
+	entry = packlist_find(&to_pack, oid->hash, index_pos);
 	if (!entry)
 		return 0;
 
@@ -990,7 +990,7 @@ static int want_found_object(int exclude, struct packed_git *p)
  * function finds if there is any pack that has the object and returns the pack
  * and its offset in these variables.
  */
-static int want_object_in_pack(const unsigned char *sha1,
+static int want_object_in_pack(const struct object_id *oid,
 			       int exclude,
 			       struct packed_git **found_pack,
 			       off_t *found_offset)
@@ -998,7 +998,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 	struct mru_entry *entry;
 	int want;
 
-	if (!exclude && local && has_loose_object_nonlocal(sha1))
+	if (!exclude && local && has_loose_object_nonlocal(oid->hash))
 		return 0;
 
 	/*
@@ -1019,7 +1019,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 		if (p == *found_pack)
 			offset = *found_offset;
 		else
-			offset = find_pack_entry_one(sha1, p);
+			offset = find_pack_entry_one(oid->hash, p);
 
 		if (offset) {
 			if (!*found_pack) {
@@ -1039,7 +1039,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 	return 1;
 }
 
-static void create_object_entry(const unsigned char *sha1,
+static void create_object_entry(const struct object_id *oid,
 				enum object_type type,
 				uint32_t hash,
 				int exclude,
@@ -1050,7 +1050,7 @@ static void create_object_entry(const unsigned char *sha1,
 {
 	struct object_entry *entry;
 
-	entry = packlist_alloc(&to_pack, sha1, index_pos);
+	entry = packlist_alloc(&to_pack, oid->hash, index_pos);
 	entry->hash = hash;
 	if (type)
 		entry->type = type;
@@ -1070,17 +1070,17 @@ static const char no_closure_warning[] = N_(
 "disabling bitmap writing, as some objects are not being packed"
 );
 
-static int add_object_entry(const unsigned char *sha1, enum object_type type,
+static int add_object_entry(const struct object_id *oid, enum object_type type,
 			    const char *name, int exclude)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
-	if (have_duplicate_entry(sha1, exclude, &index_pos))
+	if (have_duplicate_entry(oid, exclude, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
+	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			warning(_(no_closure_warning));
@@ -1089,7 +1089,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		return 0;
 	}
 
-	create_object_entry(sha1, type, pack_name_hash(name),
+	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
 
@@ -1104,20 +1104,20 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 {
 	uint32_t index_pos;
 
-	if (have_duplicate_entry(oid->hash, 0, &index_pos))
+	if (have_duplicate_entry(oid, 0, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(oid->hash, 0, &pack, &offset))
+	if (!want_object_in_pack(oid, 0, &pack, &offset))
 		return 0;
 
-	create_object_entry(oid->hash, type, name_hash, 0, 0, index_pos, pack, offset);
+	create_object_entry(oid, type, name_hash, 0, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, nr_result);
 	return 1;
 }
 
 struct pbase_tree_cache {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int ref;
 	int temporary;
 	void *tree_data;
@@ -1125,9 +1125,9 @@ struct pbase_tree_cache {
 };
 
 static struct pbase_tree_cache *(pbase_tree_cache[256]);
-static int pbase_tree_cache_ix(const unsigned char *sha1)
+static int pbase_tree_cache_ix(const struct object_id *oid)
 {
-	return sha1[0] % ARRAY_SIZE(pbase_tree_cache);
+	return oid->hash[0] % ARRAY_SIZE(pbase_tree_cache);
 }
 static int pbase_tree_cache_ix_incr(int ix)
 {
@@ -1144,14 +1144,14 @@ static struct pbase_tree {
 	struct pbase_tree_cache pcache;
 } *pbase_tree;
 
-static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
+static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 {
 	struct pbase_tree_cache *ent, *nent;
 	void *data;
 	unsigned long size;
 	enum object_type type;
 	int neigh;
-	int my_ix = pbase_tree_cache_ix(sha1);
+	int my_ix = pbase_tree_cache_ix(oid);
 	int available_ix = -1;
 
 	/* pbase-tree-cache acts as a limited hashtable.
@@ -1160,7 +1160,7 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 	 */
 	for (neigh = 0; neigh < 8; neigh++) {
 		ent = pbase_tree_cache[my_ix];
-		if (ent && !hashcmp(ent->sha1, sha1)) {
+		if (ent && !oidcmp(&ent->oid, oid)) {
 			ent->ref++;
 			return ent;
 		}
@@ -1176,7 +1176,7 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 	/* Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
-	data = read_sha1_file(sha1, &type, &size);
+	data = read_sha1_file(oid->hash, &type, &size);
 	if (!data)
 		return NULL;
 	if (type != OBJ_TREE) {
@@ -1202,7 +1202,7 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 		free(ent->tree_data);
 		nent = ent;
 	}
-	hashcpy(nent->sha1, sha1);
+	oidcpy(&nent->oid, oid);
 	nent->tree_data = data;
 	nent->tree_size = size;
 	nent->ref = 1;
@@ -1247,7 +1247,7 @@ static void add_pbase_object(struct tree_desc *tree,
 		if (cmp < 0)
 			return;
 		if (name[cmplen] != '/') {
-			add_object_entry(entry.oid->hash,
+			add_object_entry(entry.oid,
 					 object_type(entry.mode),
 					 fullname, 1);
 			return;
@@ -1258,7 +1258,7 @@ static void add_pbase_object(struct tree_desc *tree,
 			const char *down = name+cmplen+1;
 			int downlen = name_cmp_len(down);
 
-			tree = pbase_tree_get(entry.oid->hash);
+			tree = pbase_tree_get(entry.oid);
 			if (!tree)
 				return;
 			init_tree_desc(&sub, tree->tree_data, tree->tree_size);
@@ -1317,7 +1317,7 @@ static void add_preferred_base_object(const char *name)
 	cmplen = name_cmp_len(name);
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			add_object_entry(it->pcache.sha1, OBJ_TREE, NULL, 1);
+			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1);
 		}
 		else {
 			struct tree_desc tree;
@@ -1327,22 +1327,22 @@ static void add_preferred_base_object(const char *name)
 	}
 }
 
-static void add_preferred_base(unsigned char *sha1)
+static void add_preferred_base(struct object_id *oid)
 {
 	struct pbase_tree *it;
 	void *data;
 	unsigned long size;
-	unsigned char tree_sha1[20];
+	struct object_id tree_oid;
 
 	if (window <= num_preferred_base++)
 		return;
 
-	data = read_object_with_reference(sha1, tree_type, &size, tree_sha1);
+	data = read_object_with_reference(oid->hash, tree_type, &size, tree_oid.hash);
 	if (!data)
 		return;
 
 	for (it = pbase_tree; it; it = it->next) {
-		if (!hashcmp(it->pcache.sha1, tree_sha1)) {
+		if (!oidcmp(&it->pcache.oid, &tree_oid)) {
 			free(data);
 			return;
 		}
@@ -1352,7 +1352,7 @@ static void add_preferred_base(unsigned char *sha1)
 	it->next = pbase_tree;
 	pbase_tree = it;
 
-	hashcpy(it->pcache.sha1, tree_sha1);
+	oidcpy(&it->pcache.oid, &tree_oid);
 	it->pcache.tree_data = data;
 	it->pcache.tree_size = size;
 }
@@ -2357,7 +2357,7 @@ static void add_tag_chain(const struct object_id *oid)
 			die("unable to pack objects reachable from tag %s",
 			    oid_to_hex(oid));
 
-		add_object_entry(tag->object.oid.hash, OBJ_TAG, NULL, 0);
+		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0);
 
 		if (tag->tagged->type != OBJ_TAG)
 			return;
@@ -2505,8 +2505,9 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 
 static void read_object_list_from_stdin(void)
 {
-	char line[40 + 1 + PATH_MAX + 2];
-	unsigned char sha1[20];
+	char line[GIT_MAX_HEXSZ + 1 + PATH_MAX + 2];
+	struct object_id oid;
+	const char *p;
 
 	for (;;) {
 		if (!fgets(line, sizeof(line), stdin)) {
@@ -2520,17 +2521,17 @@ static void read_object_list_from_stdin(void)
 			continue;
 		}
 		if (line[0] == '-') {
-			if (get_sha1_hex(line+1, sha1))
+			if (get_oid_hex(line+1, &oid))
 				die("expected edge sha1, got garbage:\n %s",
 				    line);
-			add_preferred_base(sha1);
+			add_preferred_base(&oid);
 			continue;
 		}
-		if (get_sha1_hex(line, sha1))
+		if (parse_oid_hex(line, &oid, &p))
 			die("expected sha1, got garbage:\n %s", line);
 
-		add_preferred_base_object(line+41);
-		add_object_entry(sha1, 0, line+41, 0);
+		add_preferred_base_object(p + 1);
+		add_object_entry(&oid, 0, p + 1, 0);
 	}
 }
 
@@ -2538,7 +2539,7 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit, void *data)
 {
-	add_object_entry(commit->object.oid.hash, OBJ_COMMIT, NULL, 0);
+	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0);
 	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
@@ -2548,13 +2549,13 @@ static void show_commit(struct commit *commit, void *data)
 static void show_object(struct object *obj, const char *name, void *data)
 {
 	add_preferred_base_object(name);
-	add_object_entry(obj->oid.hash, obj->type, name, 0);
+	add_object_entry(&obj->oid, obj->type, name, 0);
 	obj->flags |= OBJECT_ADDED;
 }
 
 static void show_edge(struct commit *commit)
 {
-	add_preferred_base(commit->object.oid.hash);
+	add_preferred_base(&commit->object.oid);
 }
 
 struct in_pack_object {
@@ -2601,7 +2602,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 	memset(&in_pack, 0, sizeof(in_pack));
 
 	for (p = packed_git; p; p = p->next) {
-		const unsigned char *sha1;
+		struct object_id oid;
 		struct object *o;
 
 		if (!p->pack_local || p->pack_keep)
@@ -2614,8 +2615,8 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 			   in_pack.alloc);
 
 		for (i = 0; i < p->num_objects; i++) {
-			sha1 = nth_packed_object_sha1(p, i);
-			o = lookup_unknown_object(sha1);
+			nth_packed_object_oid(&oid, p, i);
+			o = lookup_unknown_object(oid.hash);
 			if (!(o->flags & OBJECT_ADDED))
 				mark_in_pack_object(o, p, &in_pack);
 			o->flags |= OBJECT_ADDED;
@@ -2626,7 +2627,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		QSORT(in_pack.array, in_pack.nr, ofscmp);
 		for (i = 0; i < in_pack.nr; i++) {
 			struct object *o = in_pack.array[i].object;
-			add_object_entry(o->oid.hash, o->type, "", 0);
+			add_object_entry(&o->oid, o->type, "", 0);
 		}
 	}
 	free(in_pack.array);
@@ -2642,7 +2643,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 		return 0;
 	}
 
-	add_object_entry(oid->hash, type, "", 0);
+	add_object_entry(oid, type, "", 0);
 	return 0;
 }
 
@@ -2658,7 +2659,7 @@ static void add_unreachable_loose_objects(void)
 				      NULL, NULL, NULL);
 }
 
-static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
+static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 {
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
@@ -2667,7 +2668,7 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep) &&
-			find_pack_entry_one(sha1, p)) {
+			find_pack_entry_one(oid->hash, p)) {
 			last_found = p;
 			return 1;
 		}
@@ -2718,7 +2719,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_oid(&oid, p, i);
 			if (!packlist_find(&to_pack, oid.hash, NULL) &&
-			    !has_sha1_pack_kept_or_nonlocal(oid.hash) &&
+			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime))
 				if (force_object_loose(oid.hash, p->mtime))
 					die("unable to force loose object");
-- 
2.14.2.822.g60be5d43e6

