Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C203C207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046101AbdDWVgJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:09 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37408 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046100AbdDWVfh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EED26280B8;
        Sun, 23 Apr 2017 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983331;
        bh=d51+wCdy7GJWLYryaTrzUZoeHHnP22vkgj3e+FrYlJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQ56jaLO6pQF7WeNtYhwirTB6MbxCinsqml3uYt8ynjb7ksoeCGO3Mb+e0WPB68x+
         mqD7A5+mDUoe9k2dLACFBq8GMIB7NB5a1GL9bvI3g2n1xNs1qQy4ZAf+i2xYVdOn1D
         mQt3UW5RN0+fXaZZYLw7N9djOS2g9JVXta2BEa2IfKYc1ugM8wngyVN6pzZD5sKJh/
         TQf0QJMpW5aC7pLlZY5fZ+33Gx8vi4xbpCqYL2UDlZESz3ApdDSdicB9+FAuT+820b
         gGSWfQ9IJWUYuYjX5i2QATGUvQUoRNYxWycCyvfdYWSNYJf9oH2fCg1LVJj5UK3wy3
         b2osGfsone6veVRycaKqTdr9KloPNipWhLtk+/uC+oWxB2nAfgGmcaEAx8T/1a//6S
         CZcfZPqlKP32JGAuju1gbArQJ7xGJTSk2AYbBi33wDJuVPu+mqTtOvVz5YK5+NOi7R
         b5sI8VZS4xBACdSW4+NKtVR+MscSPajNgZWjgDxy3jvQqEE2GYq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/53] fast-import: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:11 +0000
Message-Id: <20170423213453.253425-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining parts of fast-import.c to use struct object_id.
Convert several instances of get_sha1_hex to parse_oid_hex to avoid
needing to specify constants.  Convert other hardcoded values to named
constants.  Finally, use the is_empty_tree_oid function instead of a
direct comparison against a fixed string.

Note that the odd computation with GIT_MAX_HEXSZ is due to the insertion
of a slash between every two hex digits in the path, plus one for the
terminating NUL.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 327 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 161 insertions(+), 166 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 052c59d82..6b0117e51 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -391,10 +391,8 @@ static void write_branch_report(FILE *rpt, struct branch *b)
 	fputc('\n', rpt);
 
 	fprintf(rpt, "  tip commit  : %s\n", oid_to_hex(&b->oid));
-	fprintf(rpt, "  old tree    : %s\n",
-		oid_to_hex(&b->branch_tree.versions[0].oid));
-	fprintf(rpt, "  cur tree    : %s\n",
-		oid_to_hex(&b->branch_tree.versions[1].oid));
+	fprintf(rpt, "  old tree    : %s\n", oid_to_hex(&b->branch_tree.versions[0].oid));
+	fprintf(rpt, "  cur tree    : %s\n", oid_to_hex(&b->branch_tree.versions[1].oid));
 	fprintf(rpt, "  commit clock: %" PRIuMAX "\n", b->last_commit);
 
 	fputs("  last pack   : ", rpt);
@@ -557,7 +555,7 @@ static void alloc_objects(unsigned int cnt)
 	alloc_count += cnt;
 }
 
-static struct object_entry *new_object(unsigned char *sha1)
+static struct object_entry *new_object(struct object_id *oid)
 {
 	struct object_entry *e;
 
@@ -565,32 +563,32 @@ static struct object_entry *new_object(unsigned char *sha1)
 		alloc_objects(object_entry_alloc);
 
 	e = blocks->next_free++;
-	hashcpy(e->idx.sha1, sha1);
+	hashcpy(e->idx.sha1, oid->hash);
 	return e;
 }
 
-static struct object_entry *find_object(unsigned char *sha1)
+static struct object_entry *find_object(struct object_id *oid)
 {
-	unsigned int h = sha1[0] << 8 | sha1[1];
+	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
 	struct object_entry *e;
 	for (e = object_table[h]; e; e = e->next)
-		if (!hashcmp(sha1, e->idx.sha1))
+		if (!hashcmp(oid->hash, e->idx.sha1))
 			return e;
 	return NULL;
 }
 
-static struct object_entry *insert_object(unsigned char *sha1)
+static struct object_entry *insert_object(struct object_id *oid)
 {
-	unsigned int h = sha1[0] << 8 | sha1[1];
+	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
 	struct object_entry *e = object_table[h];
 
 	while (e) {
-		if (!hashcmp(sha1, e->idx.sha1))
+		if (!hashcmp(oid->hash, e->idx.sha1))
 			return e;
 		e = e->next;
 	}
 
-	e = new_object(sha1);
+	e = new_object(oid);
 	e->next = object_table[h];
 	e->idx.offset = 0;
 	object_table[h] = e;
@@ -1007,17 +1005,17 @@ static void end_packfile(void)
 	clear_delta_base_cache();
 	if (object_count) {
 		struct packed_git *new_p;
-		unsigned char cur_pack_sha1[20];
+		struct object_id cur_pack_oid;
 		char *idx_name;
 		int i;
 		struct branch *b;
 		struct tag *t;
 
 		close_pack_windows(pack_data);
-		sha1close(pack_file, cur_pack_sha1, 0);
+		sha1close(pack_file, cur_pack_oid.hash, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
 				    pack_data->pack_name, object_count,
-				    cur_pack_sha1, pack_size);
+				    cur_pack_oid.hash, pack_size);
 
 		if (object_count <= unpack_limit) {
 			if (!loosen_small_pack(pack_data)) {
@@ -1083,13 +1081,13 @@ static int store_object(
 	enum object_type type,
 	struct strbuf *dat,
 	struct last_object *last,
-	unsigned char *sha1out,
+	struct object_id *oidout,
 	uintmax_t mark)
 {
 	void *out, *delta;
 	struct object_entry *e;
 	unsigned char hdr[96];
-	unsigned char sha1[20];
+	struct object_id oid;
 	unsigned long hdrlen, deltalen;
 	git_SHA_CTX c;
 	git_zstream s;
@@ -1099,17 +1097,17 @@ static int store_object(
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, hdrlen);
 	git_SHA1_Update(&c, dat->buf, dat->len);
-	git_SHA1_Final(sha1, &c);
-	if (sha1out)
-		hashcpy(sha1out, sha1);
+	git_SHA1_Final(oid.hash, &c);
+	if (oidout)
+		oidcpy(oidout, &oid);
 
-	e = insert_object(sha1);
+	e = insert_object(&oid);
 	if (mark)
 		insert_mark(mark, e);
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_sha1_pack(sha1, packed_git)) {
+	} else if (find_sha1_pack(oid.hash, packed_git)) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1222,13 +1220,13 @@ static void truncate_pack(struct sha1file_checkpoint *checkpoint)
 	pack_size = checkpoint->offset;
 }
 
-static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
+static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 {
 	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
 	unsigned char *in_buf = xmalloc(in_sz);
 	unsigned char *out_buf = xmalloc(out_sz);
 	struct object_entry *e;
-	unsigned char sha1[20];
+	struct object_id oid;
 	unsigned long hdrlen;
 	off_t offset;
 	git_SHA_CTX c;
@@ -1291,12 +1289,12 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		}
 	}
 	git_deflate_end(&s);
-	git_SHA1_Final(sha1, &c);
+	git_SHA1_Final(oid.hash, &c);
 
-	if (sha1out)
-		hashcpy(sha1out, sha1);
+	if (oidout)
+		oidcpy(oidout, &oid);
 
-	e = insert_object(sha1);
+	e = insert_object(&oid);
 
 	if (mark)
 		insert_mark(mark, e);
@@ -1305,7 +1303,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_sha1_pack(sha1, packed_git)) {
+	} else if (find_sha1_pack(oid.hash, packed_git)) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1389,7 +1387,7 @@ static const char *get_mode(const char *str, uint16_t *modep)
 
 static void load_tree(struct tree_entry *root)
 {
-	unsigned char *sha1 = root->versions[1].oid.hash;
+	struct object_id *oid = &root->versions[1].oid;
 	struct object_entry *myoe;
 	struct tree_content *t;
 	unsigned long size;
@@ -1397,22 +1395,22 @@ static void load_tree(struct tree_entry *root)
 	const char *c;
 
 	root->tree = t = new_tree_content(8);
-	if (is_null_sha1(sha1))
+	if (is_null_oid(oid))
 		return;
 
-	myoe = find_object(sha1);
+	myoe = find_object(oid);
 	if (myoe && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
-			die("Not a tree: %s", sha1_to_hex(sha1));
+			die("Not a tree: %s", oid_to_hex(oid));
 		t->delta_depth = myoe->depth;
 		buf = gfi_unpack_entry(myoe, &size);
 		if (!buf)
-			die("Can't load tree %s", sha1_to_hex(sha1));
+			die("Can't load tree %s", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		buf = read_sha1_file(sha1, &type, &size);
+		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf || type != OBJ_TREE)
-			die("Can't load tree %s", sha1_to_hex(sha1));
+			die("Can't load tree %s", oid_to_hex(oid));
 	}
 
 	c = buf;
@@ -1426,13 +1424,13 @@ static void load_tree(struct tree_entry *root)
 		e->tree = NULL;
 		c = get_mode(c, &e->versions[1].mode);
 		if (!c)
-			die("Corrupt mode in %s", sha1_to_hex(sha1));
+			die("Corrupt mode in %s", oid_to_hex(oid));
 		e->versions[0].mode = e->versions[1].mode;
 		e->name = to_atom(c, strlen(c));
 		c += e->name->str_len + 1;
 		hashcpy(e->versions[0].oid.hash, (unsigned char *)c);
 		hashcpy(e->versions[1].oid.hash, (unsigned char *)c);
-		c += 20;
+		c += GIT_SHA1_RAWSZ;
 	}
 	free(buf);
 }
@@ -1479,7 +1477,7 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 		strbuf_addf(b, "%o %s%c",
 			(unsigned int)(e->versions[v].mode & ~NO_DELTA),
 			e->name->str_dat, '\0');
-		strbuf_add(b, e->versions[v].oid.hash, 20);
+		strbuf_add(b, e->versions[v].oid.hash, GIT_SHA1_RAWSZ);
 	}
 }
 
@@ -1503,7 +1501,7 @@ static void store_tree(struct tree_entry *root)
 	}
 
 	if (!(root->versions[0].mode & NO_DELTA))
-		le = find_object(root->versions[0].oid.hash);
+		le = find_object(&root->versions[0].oid);
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
@@ -1512,7 +1510,7 @@ static void store_tree(struct tree_entry *root)
 	}
 
 	mktree(t, 1, &new_tree);
-	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].oid.hash, 0);
+	store_object(OBJ_TREE, &new_tree, &lo, &root->versions[1].oid, 0);
 
 	t->delta_depth = lo.depth;
 	for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
@@ -1531,14 +1529,14 @@ static void store_tree(struct tree_entry *root)
 
 static void tree_content_replace(
 	struct tree_entry *root,
-	const unsigned char *sha1,
+	const struct object_id *oid,
 	const uint16_t mode,
 	struct tree_content *newtree)
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
 	oidclr(&root->versions[0].oid);
-	hashcpy(root->versions[1].oid.hash, sha1);
+	oidcpy(&root->versions[1].oid, oid);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
 	root->tree = newtree;
@@ -1547,7 +1545,7 @@ static void tree_content_replace(
 static int tree_content_set(
 	struct tree_entry *root,
 	const char *p,
-	const unsigned char *sha1,
+	const struct object_id *oid,
 	const uint16_t mode,
 	struct tree_content *subtree)
 {
@@ -1572,10 +1570,10 @@ static int tree_content_set(
 			if (!*slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
-						&& !hashcmp(e->versions[1].oid.hash, sha1))
+						&& !oidcmp(&e->versions[1].oid, oid))
 					return 0;
 				e->versions[1].mode = mode;
-				hashcpy(e->versions[1].oid.hash, sha1);
+				oidcpy(&e->versions[1].oid, oid);
 				if (e->tree)
 					release_tree_content_recursive(e->tree);
 				e->tree = subtree;
@@ -1605,7 +1603,7 @@ static int tree_content_set(
 			}
 			if (!e->tree)
 				load_tree(e);
-			if (tree_content_set(e, slash1 + 1, sha1, mode, subtree)) {
+			if (tree_content_set(e, slash1 + 1, oid, mode, subtree)) {
 				oidclr(&root->versions[1].oid);
 				return 1;
 			}
@@ -1623,11 +1621,11 @@ static int tree_content_set(
 	if (*slash1) {
 		e->tree = new_tree_content(8);
 		e->versions[1].mode = S_IFDIR;
-		tree_content_set(e, slash1 + 1, sha1, mode, subtree);
+		tree_content_set(e, slash1 + 1, oid, mode, subtree);
 	} else {
 		e->tree = subtree;
 		e->versions[1].mode = mode;
-		hashcpy(e->versions[1].oid.hash, sha1);
+		oidcpy(&e->versions[1].oid, oid);
 	}
 	oidclr(&root->versions[1].oid);
 	return 1;
@@ -1750,7 +1748,7 @@ static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
 	struct ref_transaction *transaction;
-	unsigned char old_sha1[20];
+	struct object_id old_oid;
 	struct strbuf err = STRBUF_INIT;
 
 	if (is_null_oid(&b->oid)) {
@@ -1758,12 +1756,12 @@ static int update_branch(struct branch *b)
 			delete_ref(NULL, b->name, NULL, 0);
 		return 0;
 	}
-	if (read_ref(b->name, old_sha1))
-		hashclr(old_sha1);
-	if (!force_update && !is_null_sha1(old_sha1)) {
+	if (read_ref(b->name, old_oid.hash))
+		oidclr(&old_oid);
+	if (!force_update && !is_null_oid(&old_oid)) {
 		struct commit *old_cmit, *new_cmit;
 
-		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
+		old_cmit = lookup_commit_reference_gently(old_oid.hash, 0);
 		new_cmit = lookup_commit_reference_gently(b->oid.hash, 0);
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
@@ -1772,13 +1770,13 @@ static int update_branch(struct branch *b)
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, oid_to_hex(&b->oid),
-				sha1_to_hex(old_sha1));
+				oid_to_hex(&old_oid));
 			return -1;
 		}
 	}
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, b->name, b->oid.hash, old_sha1,
+	    ref_transaction_update(transaction, b->name, b->oid.hash, old_oid.hash,
 				   0, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1898,7 +1896,7 @@ static void read_marks(void)
 	while (fgets(line, sizeof(line), f)) {
 		uintmax_t mark;
 		char *end;
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct object_entry *e;
 
 		end = strchr(line, '\n');
@@ -1907,14 +1905,14 @@ static void read_marks(void)
 		*end = 0;
 		mark = strtoumax(line + 1, &end, 10);
 		if (!mark || end == line + 1
-			|| *end != ' ' || get_sha1_hex(end + 1, sha1))
+			|| *end != ' ' || get_oid_hex(end + 1, &oid))
 			die("corrupt mark line: %s", line);
-		e = find_object(sha1);
+		e = find_object(&oid);
 		if (!e) {
-			enum object_type type = sha1_object_info(sha1, NULL);
+			enum object_type type = sha1_object_info(oid.hash, NULL);
 			if (type < 0)
-				die("object not found: %s", sha1_to_hex(sha1));
-			e = insert_object(sha1);
+				die("object not found: %s", oid_to_hex(&oid));
+			e = insert_object(&oid);
 			e->type = type;
 			e->pack_id = MAX_PACK_ID;
 			e->idx.offset = 1; /* just not zero! */
@@ -2122,21 +2120,21 @@ static char *parse_ident(const char *buf)
 
 static void parse_and_store_blob(
 	struct last_object *last,
-	unsigned char *sha1out,
+	struct object_id *oidout,
 	uintmax_t mark)
 {
 	static struct strbuf buf = STRBUF_INIT;
 	uintmax_t len;
 
 	if (parse_data(&buf, big_file_threshold, &len))
-		store_object(OBJ_BLOB, &buf, last, sha1out, mark);
+		store_object(OBJ_BLOB, &buf, last, oidout, mark);
 	else {
 		if (last) {
 			strbuf_release(&last->data);
 			last->offset = 0;
 			last->depth = 0;
 		}
-		stream_blob(len, sha1out, mark);
+		stream_blob(len, oidout, mark);
 		skip_optional_lf();
 	}
 }
@@ -2212,21 +2210,21 @@ static void construct_path_with_fanout(const char *hex_sha1,
 		path[i++] = '/';
 		fanout--;
 	}
-	memcpy(path + i, hex_sha1 + j, 40 - j);
-	path[i + 40 - j] = '\0';
+	memcpy(path + i, hex_sha1 + j, GIT_SHA1_HEXSZ - j);
+	path[i + GIT_SHA1_HEXSZ - j] = '\0';
 }
 
 static uintmax_t do_change_note_fanout(
 		struct tree_entry *orig_root, struct tree_entry *root,
-		char *hex_sha1, unsigned int hex_sha1_len,
+		char *hex_oid, unsigned int hex_oid_len,
 		char *fullpath, unsigned int fullpath_len,
 		unsigned char fanout)
 {
 	struct tree_content *t;
 	struct tree_entry *e, leaf;
-	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
+	unsigned int i, tmp_hex_oid_len, tmp_fullpath_len;
 	uintmax_t num_notes = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char realpath[60];
 
 	if (!root->tree)
@@ -2235,7 +2233,7 @@ static uintmax_t do_change_note_fanout(
 
 	for (i = 0; t && i < t->entry_count; i++) {
 		e = t->entries[i];
-		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
+		tmp_hex_oid_len = hex_oid_len + e->name->str_len;
 		tmp_fullpath_len = fullpath_len;
 
 		/*
@@ -2247,12 +2245,12 @@ static uintmax_t do_change_note_fanout(
 		 * of 2 chars.
 		 */
 		if (!e->versions[1].mode ||
-		    tmp_hex_sha1_len > 40 ||
+		    tmp_hex_oid_len > GIT_SHA1_HEXSZ ||
 		    e->name->str_len % 2)
 			continue;
 
 		/* This _may_ be a note entry, or a subdir containing notes */
-		memcpy(hex_sha1 + hex_sha1_len, e->name->str_dat,
+		memcpy(hex_oid + hex_oid_len, e->name->str_dat,
 		       e->name->str_len);
 		if (tmp_fullpath_len)
 			fullpath[tmp_fullpath_len++] = '/';
@@ -2261,14 +2259,14 @@ static uintmax_t do_change_note_fanout(
 		tmp_fullpath_len += e->name->str_len;
 		fullpath[tmp_fullpath_len] = '\0';
 
-		if (tmp_hex_sha1_len == 40 && !get_sha1_hex(hex_sha1, sha1)) {
+		if (tmp_hex_oid_len == GIT_SHA1_HEXSZ && !get_oid_hex(hex_oid, &oid)) {
 			/* This is a note entry */
 			if (fanout == 0xff) {
 				/* Counting mode, no rename */
 				num_notes++;
 				continue;
 			}
-			construct_path_with_fanout(hex_sha1, fanout, realpath);
+			construct_path_with_fanout(hex_oid, fanout, realpath);
 			if (!strcmp(fullpath, realpath)) {
 				/* Note entry is in correct location */
 				num_notes++;
@@ -2279,13 +2277,13 @@ static uintmax_t do_change_note_fanout(
 			if (!tree_content_remove(orig_root, fullpath, &leaf, 0))
 				die("Failed to remove path %s", fullpath);
 			tree_content_set(orig_root, realpath,
-				leaf.versions[1].oid.hash,
+				&leaf.versions[1].oid,
 				leaf.versions[1].mode,
 				leaf.tree);
 		} else if (S_ISDIR(e->versions[1].mode)) {
 			/* This is a subdir that may contain note entries */
 			num_notes += do_change_note_fanout(orig_root, e,
-				hex_sha1, tmp_hex_sha1_len,
+				hex_oid, tmp_hex_oid_len,
 				fullpath, tmp_fullpath_len, fanout);
 		}
 
@@ -2298,8 +2296,12 @@ static uintmax_t do_change_note_fanout(
 static uintmax_t change_note_fanout(struct tree_entry *root,
 		unsigned char fanout)
 {
-	char hex_sha1[40], path[60];
-	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
+	/*
+	 * The size of path is due to one slash between every two hex digits,
+	 * plus the terminating NUL.
+	 */
+	char hex_oid[GIT_MAX_HEXSZ], path[GIT_MAX_HEXSZ * 3 / 2];
+	return do_change_note_fanout(root, root, hex_oid, 0, path, 0, fanout);
 }
 
 /*
@@ -2360,7 +2362,7 @@ static void file_change_m(const char *p, struct branch *b)
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
 	struct object_entry *oe;
-	unsigned char sha1[20];
+	struct object_id oid;
 	uint16_t mode, inline_data = 0;
 
 	p = get_mode(p, &mode);
@@ -2383,15 +2385,14 @@ static void file_change_m(const char *p, struct branch *b)
 
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
-		hashcpy(sha1, oe->idx.sha1);
+		hashcpy(oid.hash, oe->idx.sha1);
 	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
-		if (get_sha1_hex(p, sha1))
+		if (parse_oid_hex(p, &oid, &p))
 			die("Invalid dataref: %s", command_buf.buf);
-		oe = find_object(sha1);
-		p += 40;
+		oe = find_object(&oid);
 		if (*p++ != ' ')
 			die("Missing space after SHA1: %s", command_buf.buf);
 	}
@@ -2404,7 +2405,7 @@ static void file_change_m(const char *p, struct branch *b)
 	}
 
 	/* Git does not track empty, non-toplevel directories. */
-	if (S_ISDIR(mode) && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN) && *p) {
+	if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *p) {
 		tree_content_remove(&b->branch_tree, p, NULL, 0);
 		return;
 	}
@@ -2431,12 +2432,12 @@ static void file_change_m(const char *p, struct branch *b)
 			p = uq.buf;
 		}
 		read_next_command();
-		parse_and_store_blob(&last_blob, sha1, 0);
+		parse_and_store_blob(&last_blob, &oid, 0);
 	} else {
 		enum object_type expected = S_ISDIR(mode) ?
 						OBJ_TREE: OBJ_BLOB;
 		enum object_type type = oe ? oe->type :
-					sha1_object_info(sha1, NULL);
+					sha1_object_info(oid.hash, NULL);
 		if (type < 0)
 			die("%s not found: %s",
 					S_ISDIR(mode) ?  "Tree" : "Blob",
@@ -2448,10 +2449,10 @@ static void file_change_m(const char *p, struct branch *b)
 	}
 
 	if (!*p) {
-		tree_content_replace(&b->branch_tree, sha1, mode, NULL);
+		tree_content_replace(&b->branch_tree, &oid, mode, NULL);
 		return;
 	}
-	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);
+	tree_content_set(&b->branch_tree, p, &oid, mode, NULL);
 }
 
 static void file_change_d(const char *p, struct branch *b)
@@ -2509,13 +2510,13 @@ static void file_change_cr(const char *s, struct branch *b, int rename)
 		die("Path %s not in branch", s);
 	if (!*d) {	/* C "path/to/subdir" "" */
 		tree_content_replace(&b->branch_tree,
-			leaf.versions[1].oid.hash,
+			&leaf.versions[1].oid,
 			leaf.versions[1].mode,
 			leaf.tree);
 		return;
 	}
 	tree_content_set(&b->branch_tree, d,
-		leaf.versions[1].oid.hash,
+		&leaf.versions[1].oid,
 		leaf.versions[1].mode,
 		leaf.tree);
 }
@@ -2525,7 +2526,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	static struct strbuf uq = STRBUF_INIT;
 	struct object_entry *oe;
 	struct branch *s;
-	unsigned char sha1[20], commit_sha1[20];
+	struct object_id oid, commit_oid;
 	char path[60];
 	uint16_t inline_data = 0;
 	unsigned char new_fanout;
@@ -2550,15 +2551,14 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	/* <dataref> or 'inline' */
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
-		hashcpy(sha1, oe->idx.sha1);
+		hashcpy(oid.hash, oe->idx.sha1);
 	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
-		if (get_sha1_hex(p, sha1))
+		if (parse_oid_hex(p, &oid, &p))
 			die("Invalid dataref: %s", command_buf.buf);
-		oe = find_object(sha1);
-		p += 40;
+		oe = find_object(&oid);
 		if (*p++ != ' ')
 			die("Missing space after SHA1: %s", command_buf.buf);
 	}
@@ -2568,17 +2568,17 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	if (s) {
 		if (is_null_oid(&s->oid))
 			die("Can't add a note on empty branch.");
-		hashcpy(commit_sha1, s->oid.hash);
+		oidcpy(&commit_oid, &s->oid);
 	} else if (*p == ':') {
 		uintmax_t commit_mark = parse_mark_ref_eol(p);
 		struct object_entry *commit_oe = find_mark(commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
-		hashcpy(commit_sha1, commit_oe->idx.sha1);
-	} else if (!get_sha1(p, commit_sha1)) {
+		hashcpy(commit_oid.hash, commit_oe->idx.sha1);
+	} else if (!get_oid(p, &commit_oid)) {
 		unsigned long size;
-		char *buf = read_object_with_reference(commit_sha1,
-			commit_type, &size, commit_sha1);
+		char *buf = read_object_with_reference(commit_oid.hash,
+			commit_type, &size, commit_oid.hash);
 		if (!buf || size < 46)
 			die("Not a valid commit: %s", p);
 		free(buf);
@@ -2591,13 +2591,13 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			p = uq.buf;
 		}
 		read_next_command();
-		parse_and_store_blob(&last_blob, sha1, 0);
+		parse_and_store_blob(&last_blob, &oid, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
 				typename(oe->type), command_buf.buf);
-	} else if (!is_null_sha1(sha1)) {
-		enum object_type type = sha1_object_info(sha1, NULL);
+	} else if (!is_null_oid(&oid)) {
+		enum object_type type = sha1_object_info(oid.hash, NULL);
 		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
 		if (type != OBJ_BLOB)
@@ -2605,17 +2605,17 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			    typename(type), command_buf.buf);
 	}
 
-	construct_path_with_fanout(sha1_to_hex(commit_sha1), *old_fanout, path);
+	construct_path_with_fanout(oid_to_hex(&commit_oid), *old_fanout, path);
 	if (tree_content_remove(&b->branch_tree, path, NULL, 0))
 		b->num_notes--;
 
-	if (is_null_sha1(sha1))
+	if (is_null_oid(&oid))
 		return; /* nothing to insert */
 
 	b->num_notes++;
 	new_fanout = convert_num_notes_to_fanout(b->num_notes);
-	construct_path_with_fanout(sha1_to_hex(commit_sha1), new_fanout, path);
-	tree_content_set(&b->branch_tree, path, sha1, S_IFREG | 0644, NULL);
+	construct_path_with_fanout(oid_to_hex(&commit_oid), new_fanout, path);
+	tree_content_set(&b->branch_tree, path, &oid, S_IFREG | 0644, NULL);
 }
 
 static void file_change_deleteall(struct branch *b)
@@ -2629,10 +2629,10 @@ static void file_change_deleteall(struct branch *b)
 
 static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 {
-	if (!buf || size < 46)
+	if (!buf || size < GIT_SHA1_HEXSZ + 6)
 		die("Not a valid commit: %s", oid_to_hex(&b->oid));
 	if (memcmp("tree ", buf, 5)
-		|| get_sha1_hex(buf + 5, b->branch_tree.versions[1].oid.hash))
+		|| get_oid_hex(buf + 5, &b->branch_tree.versions[1].oid))
 		die("The commit %s is corrupt", oid_to_hex(&b->oid));
 	oidcpy(&b->branch_tree.versions[0].oid,
 	       &b->branch_tree.versions[1].oid);
@@ -2659,21 +2659,21 @@ static int parse_from(struct branch *b)
 {
 	const char *from;
 	struct branch *s;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (!skip_prefix(command_buf.buf, "from ", &from))
 		return 0;
 
-	hashcpy(sha1, b->branch_tree.versions[1].oid.hash);
+	oidcpy(&oid, &b->branch_tree.versions[1].oid);
 
 	s = lookup_branch(from);
 	if (b == s)
 		die("Can't create a branch from itself: %s", b->name);
 	else if (s) {
-		unsigned char *t = s->branch_tree.versions[1].oid.hash;
+		struct object_id *t = &s->branch_tree.versions[1].oid;
 		oidcpy(&b->oid, &s->oid);
-		hashcpy(b->branch_tree.versions[0].oid.hash, t);
-		hashcpy(b->branch_tree.versions[1].oid.hash, t);
+		oidcpy(&b->branch_tree.versions[0].oid, t);
+		oidcpy(&b->branch_tree.versions[1].oid, t);
 	} else if (*from == ':') {
 		uintmax_t idnum = parse_mark_ref_eol(from);
 		struct object_entry *oe = find_mark(idnum);
@@ -2689,7 +2689,7 @@ static int parse_from(struct branch *b)
 			} else
 				parse_from_existing(b);
 		}
-	} else if (!get_sha1(from, b->oid.hash)) {
+	} else if (!get_oid(from, &b->oid)) {
 		parse_from_existing(b);
 		if (is_null_oid(&b->oid))
 			b->delete = 1;
@@ -2697,7 +2697,7 @@ static int parse_from(struct branch *b)
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
 
-	if (b->branch_tree.tree && hashcmp(sha1, b->branch_tree.versions[1].oid.hash)) {
+	if (b->branch_tree.tree && oidcmp(&oid, &b->branch_tree.versions[1].oid)) {
 		release_tree_content_recursive(b->branch_tree.tree);
 		b->branch_tree.tree = NULL;
 	}
@@ -2724,12 +2724,10 @@ static struct hash_list *parse_merge(unsigned int *count)
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			hashcpy(n->oid.hash, oe->idx.sha1);
-		} else if (!get_sha1(from, n->oid.hash)) {
+		} else if (!get_oid(from, &n->oid)) {
 			unsigned long size;
 			char *buf = read_object_with_reference(n->oid.hash,
-							       commit_type,
-							       &size,
-							       n->oid.hash);
+				commit_type, &size, n->oid.hash);
 			if (!buf || size < 46)
 				die("Not a valid commit: %s", from);
 			free(buf);
@@ -2823,12 +2821,10 @@ static void parse_new_commit(const char *arg)
 	strbuf_addf(&new_data, "tree %s\n",
 		oid_to_hex(&b->branch_tree.versions[1].oid));
 	if (!is_null_oid(&b->oid))
-		strbuf_addf(&new_data, "parent %s\n",
-			    oid_to_hex(&b->oid));
+		strbuf_addf(&new_data, "parent %s\n", oid_to_hex(&b->oid));
 	while (merge_list) {
 		struct hash_list *next = merge_list->next;
-		strbuf_addf(&new_data, "parent %s\n",
-			    oid_to_hex(&merge_list->oid));
+		strbuf_addf(&new_data, "parent %s\n", oid_to_hex(&merge_list->oid));
 		free(merge_list);
 		merge_list = next;
 	}
@@ -2841,7 +2837,7 @@ static void parse_new_commit(const char *arg)
 	free(author);
 	free(committer);
 
-	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->oid.hash, next_mark))
+	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
 		b->pack_id = pack_id;
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
@@ -2854,7 +2850,7 @@ static void parse_new_tag(const char *arg)
 	struct branch *s;
 	struct tag *t;
 	uintmax_t from_mark = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 	enum object_type type;
 	const char *v;
 
@@ -2875,18 +2871,18 @@ static void parse_new_tag(const char *arg)
 	if (s) {
 		if (is_null_oid(&s->oid))
 			die("Can't tag an empty branch.");
-		hashcpy(sha1, s->oid.hash);
+		oidcpy(&oid, &s->oid);
 		type = OBJ_COMMIT;
 	} else if (*from == ':') {
 		struct object_entry *oe;
 		from_mark = parse_mark_ref_eol(from);
 		oe = find_mark(from_mark);
 		type = oe->type;
-		hashcpy(sha1, oe->idx.sha1);
-	} else if (!get_sha1(from, sha1)) {
-		struct object_entry *oe = find_object(sha1);
+		hashcpy(oid.hash, oe->idx.sha1);
+	} else if (!get_oid(from, &oid)) {
+		struct object_entry *oe = find_object(&oid);
 		if (!oe) {
-			type = sha1_object_info(sha1, NULL);
+			type = sha1_object_info(oid.hash, NULL);
 			if (type < 0)
 				die("Not a valid object: %s", from);
 		} else
@@ -2912,7 +2908,7 @@ static void parse_new_tag(const char *arg)
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n",
-		    sha1_to_hex(sha1), typename(type), t->name);
+		    oid_to_hex(&oid), typename(type), t->name);
 	if (tagger)
 		strbuf_addf(&new_data,
 			    "tagger %s\n", tagger);
@@ -2920,7 +2916,7 @@ static void parse_new_tag(const char *arg)
 	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
 
-	if (store_object(OBJ_TAG, &new_data, NULL, t->oid.hash, 0))
+	if (store_object(OBJ_TAG, &new_data, NULL, &t->oid, 0))
 		t->pack_id = MAX_PACK_ID;
 	else
 		t->pack_id = pack_id;
@@ -2954,7 +2950,7 @@ static void cat_blob_write(const char *buf, unsigned long size)
 		die_errno("Write to frontend failed");
 }
 
-static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
+static void cat_blob(struct object_entry *oe, struct object_id *oid)
 {
 	struct strbuf line = STRBUF_INIT;
 	unsigned long size;
@@ -2962,7 +2958,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	char *buf;
 
 	if (!oe || oe->pack_id == MAX_PACK_ID) {
-		buf = read_sha1_file(sha1, &type, &size);
+		buf = read_sha1_file(oid->hash, &type, &size);
 	} else {
 		type = oe->type;
 		buf = gfi_unpack_entry(oe, &size);
@@ -2973,19 +2969,19 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	 */
 	if (type <= 0) {
 		strbuf_reset(&line);
-		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
+		strbuf_addf(&line, "%s missing\n", oid_to_hex(oid));
 		cat_blob_write(line.buf, line.len);
 		strbuf_release(&line);
 		free(buf);
 		return;
 	}
 	if (!buf)
-		die("Can't read object %s", sha1_to_hex(sha1));
+		die("Can't read object %s", oid_to_hex(oid));
 	if (type != OBJ_BLOB)
 		die("Object %s is a %s but a blob was expected.",
-		    sha1_to_hex(sha1), typename(type));
+		    oid_to_hex(oid), typename(type));
 	strbuf_reset(&line);
-	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+	strbuf_addf(&line, "%s %s %lu\n", oid_to_hex(oid),
 						typename(type), size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
@@ -3002,7 +2998,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 static void parse_get_mark(const char *p)
 {
 	struct object_entry *oe = oe;
-	char output[42];
+	char output[GIT_MAX_HEXSZ + 2];
 
 	/* get-mark SP <object> LF */
 	if (*p != ':')
@@ -3013,42 +3009,42 @@ static void parse_get_mark(const char *p)
 		die("Unknown mark: %s", command_buf.buf);
 
 	xsnprintf(output, sizeof(output), "%s\n", sha1_to_hex(oe->idx.sha1));
-	cat_blob_write(output, 41);
+	cat_blob_write(output, GIT_SHA1_HEXSZ + 1);
 }
 
 static void parse_cat_blob(const char *p)
 {
 	struct object_entry *oe = oe;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	/* cat-blob SP <object> LF */
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_eol(p));
 		if (!oe)
 			die("Unknown mark: %s", command_buf.buf);
-		hashcpy(sha1, oe->idx.sha1);
+		hashcpy(oid.hash, oe->idx.sha1);
 	} else {
-		if (get_sha1_hex(p, sha1))
+		if (parse_oid_hex(p, &oid, &p))
 			die("Invalid dataref: %s", command_buf.buf);
-		if (p[40])
+		if (*p)
 			die("Garbage after SHA1: %s", command_buf.buf);
-		oe = find_object(sha1);
+		oe = find_object(&oid);
 	}
 
-	cat_blob(oe, sha1);
+	cat_blob(oe, &oid);
 }
 
 static struct object_entry *dereference(struct object_entry *oe,
-					unsigned char sha1[20])
+					struct object_id *oid)
 {
 	unsigned long size;
 	char *buf = NULL;
 	if (!oe) {
-		enum object_type type = sha1_object_info(sha1, NULL);
+		enum object_type type = sha1_object_info(oid->hash, NULL);
 		if (type < 0)
-			die("object not found: %s", sha1_to_hex(sha1));
+			die("object not found: %s", oid_to_hex(oid));
 		/* cache it! */
-		oe = insert_object(sha1);
+		oe = insert_object(oid);
 		oe->type = type;
 		oe->pack_id = MAX_PACK_ID;
 		oe->idx.offset = 1;
@@ -3067,49 +3063,48 @@ static struct object_entry *dereference(struct object_entry *oe,
 		buf = gfi_unpack_entry(oe, &size);
 	} else {
 		enum object_type unused;
-		buf = read_sha1_file(sha1, &unused, &size);
+		buf = read_sha1_file(oid->hash, &unused, &size);
 	}
 	if (!buf)
-		die("Can't load object %s", sha1_to_hex(sha1));
+		die("Can't load object %s", oid_to_hex(oid));
 
 	/* Peel one layer. */
 	switch (oe->type) {
 	case OBJ_TAG:
-		if (size < 40 + strlen("object ") ||
-		    get_sha1_hex(buf + strlen("object "), sha1))
+		if (size < GIT_SHA1_HEXSZ + strlen("object ") ||
+		    get_oid_hex(buf + strlen("object "), oid))
 			die("Invalid SHA1 in tag: %s", command_buf.buf);
 		break;
 	case OBJ_COMMIT:
-		if (size < 40 + strlen("tree ") ||
-		    get_sha1_hex(buf + strlen("tree "), sha1))
+		if (size < GIT_SHA1_HEXSZ + strlen("tree ") ||
+		    get_oid_hex(buf + strlen("tree "), oid))
 			die("Invalid SHA1 in commit: %s", command_buf.buf);
 	}
 
 	free(buf);
-	return find_object(sha1);
+	return find_object(oid);
 }
 
 static struct object_entry *parse_treeish_dataref(const char **p)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct object_entry *e;
 
 	if (**p == ':') {	/* <mark> */
 		e = find_mark(parse_mark_ref_space(p));
 		if (!e)
 			die("Unknown mark: %s", command_buf.buf);
-		hashcpy(sha1, e->idx.sha1);
+		hashcpy(oid.hash, e->idx.sha1);
 	} else {	/* <sha1> */
-		if (get_sha1_hex(*p, sha1))
+		if (parse_oid_hex(*p, &oid, p))
 			die("Invalid dataref: %s", command_buf.buf);
-		e = find_object(sha1);
-		*p += 40;
+		e = find_object(&oid);
 		if (*(*p)++ != ' ')
 			die("Missing space after tree-ish: %s", command_buf.buf);
 	}
 
 	while (!e || e->type != OBJ_TREE)
-		e = dereference(e, sha1);
+		e = dereference(e, &oid);
 	return e;
 }
 
