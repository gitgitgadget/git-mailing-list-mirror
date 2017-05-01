Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10921FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642369AbdEACad (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35796 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642309AbdEACaL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2793B280B7;
        Mon,  1 May 2017 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605805;
        bh=vFlDiWrcodB2zeY0v+JjO1pYfYDjseC7Ajktfk+1vAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBKf0TOSgWyfBd7BlVfpGtffUmKE2NPrEla57AtaeFNHKnM9lVGoUIIFRTWijMcj+
         NMyWBuLnpx7sxHiflr532Eem9bur/zed7Trfq707llWctD3STMLhFV9GpRZiMHCt7q
         jxyp4Q5ijPMGAYG9fhT8G3K3uZApruzxogje9/55eJRbE4CesAyc2QVrmhyp/sgw03
         79PKoomwuBPybYRSth5+gU1EpVCHoXAfXKpJLHnqkZuk0l6FMwH4zPdNAus46jS6+7
         Vd/ET/JrR5gMCG6JH05/MfXlvvVKhHfpuW/nQqHSFSbgLaNTcWUosaU6KyIMmeTRQl
         aMKiryUP6WrP7OpONHV9rJ7L6nf4EoNpEY4GgcIVsVZDOvof5/6wT9u2cC/vu0RrLZ
         Ekk2qwL5I8Dt1DLKSPqVo4uJTgwfghGHq01U+iqTaFOHzP1RobGwjjfh22ruj44Hg4
         yc+6SJQ/IkXXogm/yTFfEBJc9ug0hv1V0ySYyUdlKTe6oxYHZRF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/53] fast-import: convert internal structs to struct object_id
Date:   Mon,  1 May 2017 02:29:03 +0000
Message-Id: <20170501022946.258735-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct tree_entry_ms, struct branch, struct tag, and struct
hash_list to use struct object_id by changing the definition and
applying the following semantic patch, plus the standard object_id
transforms:

@@
struct tree_entry_ms E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct tree_entry_ms *E1;
@@
- E1->sha1
+ E1->oid.hash

@@
struct branch E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct branch *E1;
@@
- E1->sha1
+ E1->oid.hash

@@
struct tag E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct tag *E1;
@@
- E1->sha1
+ E1->oid.hash

@@
struct hash_list E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct hash_list *E1;
@@
- E1->sha1
+ E1->oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 182 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 96 insertions(+), 86 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cf58f875b..0212635dd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -226,7 +226,7 @@ struct tree_entry {
 	struct atom_str *name;
 	struct tree_entry_ms {
 		uint16_t mode;
-		unsigned char sha1[20];
+		struct object_id oid;
 	} versions[2];
 };
 
@@ -252,19 +252,19 @@ struct branch {
 	unsigned active : 1;
 	unsigned delete : 1;
 	unsigned pack_id : PACK_ID_BITS;
-	unsigned char sha1[20];
+	struct object_id oid;
 };
 
 struct tag {
 	struct tag *next_tag;
 	const char *name;
 	unsigned int pack_id;
-	unsigned char sha1[20];
+	struct object_id oid;
 };
 
 struct hash_list {
 	struct hash_list *next;
-	unsigned char sha1[20];
+	struct object_id oid;
 };
 
 typedef enum {
@@ -386,13 +386,15 @@ static void write_branch_report(FILE *rpt, struct branch *b)
 		fputs(" active", rpt);
 	if (b->branch_tree.tree)
 		fputs(" loaded", rpt);
-	if (is_null_sha1(b->branch_tree.versions[1].sha1))
+	if (is_null_oid(&b->branch_tree.versions[1].oid))
 		fputs(" dirty", rpt);
 	fputc('\n', rpt);
 
-	fprintf(rpt, "  tip commit  : %s\n", sha1_to_hex(b->sha1));
-	fprintf(rpt, "  old tree    : %s\n", sha1_to_hex(b->branch_tree.versions[0].sha1));
-	fprintf(rpt, "  cur tree    : %s\n", sha1_to_hex(b->branch_tree.versions[1].sha1));
+	fprintf(rpt, "  tip commit  : %s\n", oid_to_hex(&b->oid));
+	fprintf(rpt, "  old tree    : %s\n",
+		oid_to_hex(&b->branch_tree.versions[0].oid));
+	fprintf(rpt, "  cur tree    : %s\n",
+		oid_to_hex(&b->branch_tree.versions[1].oid));
 	fprintf(rpt, "  commit clock: %" PRIuMAX "\n", b->last_commit);
 
 	fputs("  last pack   : ", rpt);
@@ -470,7 +472,7 @@ static void write_crash_report(const char *err)
 		fputs("Annotated Tags\n", rpt);
 		fputs("--------------\n", rpt);
 		for (tg = first_tag; tg; tg = tg->next_tag) {
-			fputs(sha1_to_hex(tg->sha1), rpt);
+			fputs(oid_to_hex(&tg->oid), rpt);
 			fputc(' ', rpt);
 			fputs(tg->name, rpt);
 			fputc('\n', rpt);
@@ -876,7 +878,7 @@ static struct tree_content *dup_tree_content(struct tree_content *s)
 		a = s->entries[i];
 		b = new_tree_entry();
 		memcpy(b, a, sizeof(*a));
-		if (a->tree && is_null_sha1(b->versions[1].sha1))
+		if (a->tree && is_null_oid(&b->versions[1].oid))
 			b->tree = dup_tree_content(a->tree);
 		else
 			b->tree = NULL;
@@ -1041,12 +1043,14 @@ static void end_packfile(void)
 			for (i = 0; i < branch_table_sz; i++) {
 				for (b = branch_table[i]; b; b = b->table_next_branch) {
 					if (b->pack_id == pack_id)
-						fprintf(pack_edges, " %s", sha1_to_hex(b->sha1));
+						fprintf(pack_edges, " %s",
+							oid_to_hex(&b->oid));
 				}
 			}
 			for (t = first_tag; t; t = t->next_tag) {
 				if (t->pack_id == pack_id)
-					fprintf(pack_edges, " %s", sha1_to_hex(t->sha1));
+					fprintf(pack_edges, " %s",
+						oid_to_hex(&t->oid));
 			}
 			fputc('\n', pack_edges);
 			fflush(pack_edges);
@@ -1385,7 +1389,7 @@ static const char *get_mode(const char *str, uint16_t *modep)
 
 static void load_tree(struct tree_entry *root)
 {
-	unsigned char *sha1 = root->versions[1].sha1;
+	unsigned char *sha1 = root->versions[1].oid.hash;
 	struct object_entry *myoe;
 	struct tree_content *t;
 	unsigned long size;
@@ -1426,8 +1430,8 @@ static void load_tree(struct tree_entry *root)
 		e->versions[0].mode = e->versions[1].mode;
 		e->name = to_atom(c, strlen(c));
 		c += e->name->str_len + 1;
-		hashcpy(e->versions[0].sha1, (unsigned char *)c);
-		hashcpy(e->versions[1].sha1, (unsigned char *)c);
+		hashcpy(e->versions[0].oid.hash, (unsigned char *)c);
+		hashcpy(e->versions[1].oid.hash, (unsigned char *)c);
 		c += 20;
 	}
 	free(buf);
@@ -1475,7 +1479,7 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 		strbuf_addf(b, "%o %s%c",
 			(unsigned int)(e->versions[v].mode & ~NO_DELTA),
 			e->name->str_dat, '\0');
-		strbuf_add(b, e->versions[v].sha1, 20);
+		strbuf_add(b, e->versions[v].oid.hash, 20);
 	}
 }
 
@@ -1486,7 +1490,7 @@ static void store_tree(struct tree_entry *root)
 	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
 	struct object_entry *le = NULL;
 
-	if (!is_null_sha1(root->versions[1].sha1))
+	if (!is_null_oid(&root->versions[1].oid))
 		return;
 
 	if (!root->tree)
@@ -1499,7 +1503,7 @@ static void store_tree(struct tree_entry *root)
 	}
 
 	if (!(root->versions[0].mode & NO_DELTA))
-		le = find_object(root->versions[0].sha1);
+		le = find_object(root->versions[0].oid.hash);
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
@@ -1508,14 +1512,14 @@ static void store_tree(struct tree_entry *root)
 	}
 
 	mktree(t, 1, &new_tree);
-	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, 0);
+	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].oid.hash, 0);
 
 	t->delta_depth = lo.depth;
 	for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
 		struct tree_entry *e = t->entries[i];
 		if (e->versions[1].mode) {
 			e->versions[0].mode = e->versions[1].mode;
-			hashcpy(e->versions[0].sha1, e->versions[1].sha1);
+			oidcpy(&e->versions[0].oid, &e->versions[1].oid);
 			t->entries[j++] = e;
 		} else {
 			release_tree_entry(e);
@@ -1533,8 +1537,8 @@ static void tree_content_replace(
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
-	hashclr(root->versions[0].sha1);
-	hashcpy(root->versions[1].sha1, sha1);
+	oidclr(&root->versions[0].oid);
+	hashcpy(root->versions[1].oid.hash, sha1);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
 	root->tree = newtree;
@@ -1568,10 +1572,10 @@ static int tree_content_set(
 			if (!*slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
-						&& !hashcmp(e->versions[1].sha1, sha1))
+						&& !hashcmp(e->versions[1].oid.hash, sha1))
 					return 0;
 				e->versions[1].mode = mode;
-				hashcpy(e->versions[1].sha1, sha1);
+				hashcpy(e->versions[1].oid.hash, sha1);
 				if (e->tree)
 					release_tree_content_recursive(e->tree);
 				e->tree = subtree;
@@ -1592,7 +1596,7 @@ static int tree_content_set(
 				if (S_ISDIR(e->versions[0].mode))
 					e->versions[0].mode |= NO_DELTA;
 
-				hashclr(root->versions[1].sha1);
+				oidclr(&root->versions[1].oid);
 				return 1;
 			}
 			if (!S_ISDIR(e->versions[1].mode)) {
@@ -1602,7 +1606,7 @@ static int tree_content_set(
 			if (!e->tree)
 				load_tree(e);
 			if (tree_content_set(e, slash1 + 1, sha1, mode, subtree)) {
-				hashclr(root->versions[1].sha1);
+				oidclr(&root->versions[1].oid);
 				return 1;
 			}
 			return 0;
@@ -1614,7 +1618,7 @@ static int tree_content_set(
 	e = new_tree_entry();
 	e->name = to_atom(p, n);
 	e->versions[0].mode = 0;
-	hashclr(e->versions[0].sha1);
+	oidclr(&e->versions[0].oid);
 	t->entries[t->entry_count++] = e;
 	if (*slash1) {
 		e->tree = new_tree_content(8);
@@ -1623,9 +1627,9 @@ static int tree_content_set(
 	} else {
 		e->tree = subtree;
 		e->versions[1].mode = mode;
-		hashcpy(e->versions[1].sha1, sha1);
+		hashcpy(e->versions[1].oid.hash, sha1);
 	}
-	hashclr(root->versions[1].sha1);
+	oidclr(&root->versions[1].oid);
 	return 1;
 }
 
@@ -1670,7 +1674,7 @@ static int tree_content_remove(
 			if (tree_content_remove(e, slash1 + 1, backup_leaf, 0)) {
 				for (n = 0; n < e->tree->entry_count; n++) {
 					if (e->tree->entries[n]->versions[1].mode) {
-						hashclr(root->versions[1].sha1);
+						oidclr(&root->versions[1].oid);
 						return 1;
 					}
 				}
@@ -1689,8 +1693,8 @@ static int tree_content_remove(
 		release_tree_content_recursive(e->tree);
 	e->tree = NULL;
 	e->versions[1].mode = 0;
-	hashclr(e->versions[1].sha1);
-	hashclr(root->versions[1].sha1);
+	oidclr(&e->versions[1].oid);
+	oidclr(&root->versions[1].oid);
 	return 1;
 }
 
@@ -1735,7 +1739,7 @@ static int tree_content_get(
 
 found_entry:
 	memcpy(leaf, e, sizeof(*leaf));
-	if (e->tree && is_null_sha1(e->versions[1].sha1))
+	if (e->tree && is_null_oid(&e->versions[1].oid))
 		leaf->tree = dup_tree_content(e->tree);
 	else
 		leaf->tree = NULL;
@@ -1749,7 +1753,7 @@ static int update_branch(struct branch *b)
 	unsigned char old_sha1[20];
 	struct strbuf err = STRBUF_INIT;
 
-	if (is_null_sha1(b->sha1)) {
+	if (is_null_oid(&b->oid)) {
 		if (b->delete)
 			delete_ref(NULL, b->name, NULL, 0);
 		return 0;
@@ -1760,20 +1764,21 @@ static int update_branch(struct branch *b)
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
-		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
+		new_cmit = lookup_commit_reference_gently(b->oid.hash, 0);
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
-				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
+				b->name, oid_to_hex(&b->oid),
+				sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+	    ref_transaction_update(transaction, b->name, b->oid.hash, old_sha1,
 				   0, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1815,7 +1820,7 @@ static void dump_tags(void)
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name.buf,
-					   t->sha1, NULL, 0, msg, &err)) {
+					   t->oid.hash, NULL, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
@@ -2274,7 +2279,7 @@ static uintmax_t do_change_note_fanout(
 			if (!tree_content_remove(orig_root, fullpath, &leaf, 0))
 				die("Failed to remove path %s", fullpath);
 			tree_content_set(orig_root, realpath,
-				leaf.versions[1].sha1,
+				leaf.versions[1].oid.hash,
 				leaf.versions[1].mode,
 				leaf.tree);
 		} else if (S_ISDIR(e->versions[1].mode)) {
@@ -2504,13 +2509,13 @@ static void file_change_cr(const char *s, struct branch *b, int rename)
 		die("Path %s not in branch", s);
 	if (!*d) {	/* C "path/to/subdir" "" */
 		tree_content_replace(&b->branch_tree,
-			leaf.versions[1].sha1,
+			leaf.versions[1].oid.hash,
 			leaf.versions[1].mode,
 			leaf.tree);
 		return;
 	}
 	tree_content_set(&b->branch_tree, d,
-		leaf.versions[1].sha1,
+		leaf.versions[1].oid.hash,
 		leaf.versions[1].mode,
 		leaf.tree);
 }
@@ -2561,9 +2566,9 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	/* <commit-ish> */
 	s = lookup_branch(p);
 	if (s) {
-		if (is_null_sha1(s->sha1))
+		if (is_null_oid(&s->oid))
 			die("Can't add a note on empty branch.");
-		hashcpy(commit_sha1, s->sha1);
+		hashcpy(commit_sha1, s->oid.hash);
 	} else if (*p == ':') {
 		uintmax_t commit_mark = parse_mark_ref_eol(p);
 		struct object_entry *commit_oe = find_mark(commit_mark);
@@ -2616,8 +2621,8 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 static void file_change_deleteall(struct branch *b)
 {
 	release_tree_content_recursive(b->branch_tree.tree);
-	hashclr(b->branch_tree.versions[0].sha1);
-	hashclr(b->branch_tree.versions[1].sha1);
+	oidclr(&b->branch_tree.versions[0].oid);
+	oidclr(&b->branch_tree.versions[1].oid);
 	load_tree(&b->branch_tree);
 	b->num_notes = 0;
 }
@@ -2625,25 +2630,26 @@ static void file_change_deleteall(struct branch *b)
 static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 {
 	if (!buf || size < 46)
-		die("Not a valid commit: %s", sha1_to_hex(b->sha1));
+		die("Not a valid commit: %s", oid_to_hex(&b->oid));
 	if (memcmp("tree ", buf, 5)
-		|| get_sha1_hex(buf + 5, b->branch_tree.versions[1].sha1))
-		die("The commit %s is corrupt", sha1_to_hex(b->sha1));
-	hashcpy(b->branch_tree.versions[0].sha1,
-		b->branch_tree.versions[1].sha1);
+		|| get_sha1_hex(buf + 5, b->branch_tree.versions[1].oid.hash))
+		die("The commit %s is corrupt", oid_to_hex(&b->oid));
+	oidcpy(&b->branch_tree.versions[0].oid,
+	       &b->branch_tree.versions[1].oid);
 }
 
 static void parse_from_existing(struct branch *b)
 {
-	if (is_null_sha1(b->sha1)) {
-		hashclr(b->branch_tree.versions[0].sha1);
-		hashclr(b->branch_tree.versions[1].sha1);
+	if (is_null_oid(&b->oid)) {
+		oidclr(&b->branch_tree.versions[0].oid);
+		oidclr(&b->branch_tree.versions[1].oid);
 	} else {
 		unsigned long size;
 		char *buf;
 
-		buf = read_object_with_reference(b->sha1,
-			commit_type, &size, b->sha1);
+		buf = read_object_with_reference(b->oid.hash,
+						 commit_type, &size,
+						 b->oid.hash);
 		parse_from_commit(b, buf, size);
 		free(buf);
 	}
@@ -2658,23 +2664,23 @@ static int parse_from(struct branch *b)
 	if (!skip_prefix(command_buf.buf, "from ", &from))
 		return 0;
 
-	hashcpy(sha1, b->branch_tree.versions[1].sha1);
+	hashcpy(sha1, b->branch_tree.versions[1].oid.hash);
 
 	s = lookup_branch(from);
 	if (b == s)
 		die("Can't create a branch from itself: %s", b->name);
 	else if (s) {
-		unsigned char *t = s->branch_tree.versions[1].sha1;
-		hashcpy(b->sha1, s->sha1);
-		hashcpy(b->branch_tree.versions[0].sha1, t);
-		hashcpy(b->branch_tree.versions[1].sha1, t);
+		unsigned char *t = s->branch_tree.versions[1].oid.hash;
+		oidcpy(&b->oid, &s->oid);
+		hashcpy(b->branch_tree.versions[0].oid.hash, t);
+		hashcpy(b->branch_tree.versions[1].oid.hash, t);
 	} else if (*from == ':') {
 		uintmax_t idnum = parse_mark_ref_eol(from);
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
-		if (hashcmp(b->sha1, oe->idx.sha1)) {
-			hashcpy(b->sha1, oe->idx.sha1);
+		if (hashcmp(b->oid.hash, oe->idx.sha1)) {
+			hashcpy(b->oid.hash, oe->idx.sha1);
 			if (oe->pack_id != MAX_PACK_ID) {
 				unsigned long size;
 				char *buf = gfi_unpack_entry(oe, &size);
@@ -2683,15 +2689,15 @@ static int parse_from(struct branch *b)
 			} else
 				parse_from_existing(b);
 		}
-	} else if (!get_sha1(from, b->sha1)) {
+	} else if (!get_sha1(from, b->oid.hash)) {
 		parse_from_existing(b);
-		if (is_null_sha1(b->sha1))
+		if (is_null_oid(&b->oid))
 			b->delete = 1;
 	}
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
 
-	if (b->branch_tree.tree && hashcmp(sha1, b->branch_tree.versions[1].sha1)) {
+	if (b->branch_tree.tree && hashcmp(sha1, b->branch_tree.versions[1].oid.hash)) {
 		release_tree_content_recursive(b->branch_tree.tree);
 		b->branch_tree.tree = NULL;
 	}
@@ -2711,17 +2717,19 @@ static struct hash_list *parse_merge(unsigned int *count)
 		n = xmalloc(sizeof(*n));
 		s = lookup_branch(from);
 		if (s)
-			hashcpy(n->sha1, s->sha1);
+			oidcpy(&n->oid, &s->oid);
 		else if (*from == ':') {
 			uintmax_t idnum = parse_mark_ref_eol(from);
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
-			hashcpy(n->sha1, oe->idx.sha1);
-		} else if (!get_sha1(from, n->sha1)) {
+			hashcpy(n->oid.hash, oe->idx.sha1);
+		} else if (!get_sha1(from, n->oid.hash)) {
 			unsigned long size;
-			char *buf = read_object_with_reference(n->sha1,
-				commit_type, &size, n->sha1);
+			char *buf = read_object_with_reference(n->oid.hash,
+							       commit_type,
+							       &size,
+							       n->oid.hash);
 			if (!buf || size < 46)
 				die("Not a valid commit: %s", from);
 			free(buf);
@@ -2808,17 +2816,19 @@ static void parse_new_commit(const char *arg)
 
 	/* build the tree and the commit */
 	store_tree(&b->branch_tree);
-	hashcpy(b->branch_tree.versions[0].sha1,
-		b->branch_tree.versions[1].sha1);
+	oidcpy(&b->branch_tree.versions[0].oid,
+	       &b->branch_tree.versions[1].oid);
 
 	strbuf_reset(&new_data);
 	strbuf_addf(&new_data, "tree %s\n",
-		sha1_to_hex(b->branch_tree.versions[1].sha1));
-	if (!is_null_sha1(b->sha1))
-		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
+		oid_to_hex(&b->branch_tree.versions[1].oid));
+	if (!is_null_oid(&b->oid))
+		strbuf_addf(&new_data, "parent %s\n",
+			    oid_to_hex(&b->oid));
 	while (merge_list) {
 		struct hash_list *next = merge_list->next;
-		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));
+		strbuf_addf(&new_data, "parent %s\n",
+			    oid_to_hex(&merge_list->oid));
 		free(merge_list);
 		merge_list = next;
 	}
@@ -2831,7 +2841,7 @@ static void parse_new_commit(const char *arg)
 	free(author);
 	free(committer);
 
-	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark))
+	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->oid.hash, next_mark))
 		b->pack_id = pack_id;
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
@@ -2863,9 +2873,9 @@ static void parse_new_tag(const char *arg)
 		die("Expected from command, got %s", command_buf.buf);
 	s = lookup_branch(from);
 	if (s) {
-		if (is_null_sha1(s->sha1))
+		if (is_null_oid(&s->oid))
 			die("Can't tag an empty branch.");
-		hashcpy(sha1, s->sha1);
+		hashcpy(sha1, s->oid.hash);
 		type = OBJ_COMMIT;
 	} else if (*from == ':') {
 		struct object_entry *oe;
@@ -2910,7 +2920,7 @@ static void parse_new_tag(const char *arg)
 	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
 
-	if (store_object(OBJ_TAG, &new_data, NULL, t->sha1, 0))
+	if (store_object(OBJ_TAG, &new_data, NULL, t->oid.hash, 0))
 		t->pack_id = MAX_PACK_ID;
 	else
 		t->pack_id = pack_id;
@@ -2922,9 +2932,9 @@ static void parse_reset_branch(const char *arg)
 
 	b = lookup_branch(arg);
 	if (b) {
-		hashclr(b->sha1);
-		hashclr(b->branch_tree.versions[0].sha1);
-		hashclr(b->branch_tree.versions[1].sha1);
+		oidclr(&b->oid);
+		oidclr(&b->branch_tree.versions[0].oid);
+		oidclr(&b->branch_tree.versions[1].oid);
 		if (b->branch_tree.tree) {
 			release_tree_content_recursive(b->branch_tree.tree);
 			b->branch_tree.tree = NULL;
@@ -3143,8 +3153,8 @@ static void parse_ls(const char *p, struct branch *b)
 	} else {
 		struct object_entry *e = parse_treeish_dataref(&p);
 		root = new_tree_entry();
-		hashcpy(root->versions[1].sha1, e->idx.sha1);
-		if (!is_null_sha1(root->versions[1].sha1))
+		hashcpy(root->versions[1].oid.hash, e->idx.sha1);
+		if (!is_null_oid(&root->versions[1].oid))
 			root->versions[1].mode = S_IFDIR;
 		load_tree(root);
 	}
@@ -3166,7 +3176,7 @@ static void parse_ls(const char *p, struct branch *b)
 	if (S_ISDIR(leaf.versions[1].mode))
 		store_tree(&leaf);
 
-	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
+	print_ls(leaf.versions[1].mode, leaf.versions[1].oid.hash, p);
 	if (leaf.tree)
 		release_tree_content_recursive(leaf.tree);
 	if (!b || root != &b->branch_tree)
