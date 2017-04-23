Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0A7207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046201AbdDWVgr (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:47 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37380 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046126AbdDWVfs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C6249280C7;
        Sun, 23 Apr 2017 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983336;
        bh=lS58PaZesV7jbqBUJNRClGvJMh3nQRiDu2n9TAXsNTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtT/0nJ5whoUwalr+uDVOyb7GQS2sX0+U7RfUSEJuFyZ3s+XYIbnFU+JiHWUrXuLb
         A6ny8eEgTcTb31ELxPuFYjKI3OLYOVnte9hOXHVL6lNPL6CPaF8esmNtloKpIcVVfH
         NQQgdVPWIrEQu5ma0ND4fh1LXoVRQpNV9YFa3Kf9DVMeueNFtsgFzJd/XbM1kqXPSh
         Ef/n4LxfPv+ERcKY4HN+3TAuCzH/CBW3pcRwLPvcUH0Vh6kDUFh/5D87qz2HvWR5K4
         V2xSg6sIV4KX6Q9Rr0c2IL0R6nf66xh20UbQW5dj7WIAdD0xq2Dp98qPrq4lx3mGC4
         NV7k0mn9o9e52atUM/X8/l8uwOzBY56q2VnR28lRkocysfnWm5aShSAnoClg1smLQt
         6o4TcxkiZHJLa0/bg1r947cExIpITOGwy3mEPx3iu8LMDbOC5DeOvxX7xOGJhmK4iM
         i0GnWFYK9nlJnC9A5hCj7pBew2/5fM3Vm9QdZ8jitB1Ytn1aZZO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/53] pack: convert struct pack_idx_entry to struct object_id
Date:   Sun, 23 Apr 2017 21:34:26 +0000
Message-Id: <20170423213453.253425-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct pack_idx_entry to use struct object_id by changing the
definition and applying the following semantic patch, plus the standard
object_id transforms:

@@
struct pack_idx_entry E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct pack_idx_entry *E1;
@@
- E1->sha1
+ E1->oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c   | 33 +++++++++++++++-----------
 builtin/pack-objects.c | 63 +++++++++++++++++++++++++++++---------------------
 bulk-checkin.c         |  4 ++--
 fast-import.c          | 30 ++++++++++++------------
 pack-bitmap-write.c    |  8 ++++---
 pack-objects.c         |  8 ++++---
 pack-write.c           | 10 ++++----
 pack.h                 |  2 +-
 8 files changed, 89 insertions(+), 69 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4ff567db4..fef0025e4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -747,13 +747,13 @@ static int compare_objects(const unsigned char *buf, unsigned long size,
 		ssize_t len = read_istream(data->st, data->buf, size);
 		if (len == 0)
 			die(_("SHA1 COLLISION FOUND WITH %s !"),
-			    sha1_to_hex(data->entry->idx.sha1));
+			    oid_to_hex(&data->entry->idx.oid));
 		if (len < 0)
 			die(_("unable to read %s"),
-			    sha1_to_hex(data->entry->idx.sha1));
+			    oid_to_hex(&data->entry->idx.oid));
 		if (memcmp(buf, data->buf, len))
 			die(_("SHA1 COLLISION FOUND WITH %s !"),
-			    sha1_to_hex(data->entry->idx.sha1));
+			    oid_to_hex(&data->entry->idx.oid));
 		size -= len;
 		buf += len;
 	}
@@ -771,12 +771,12 @@ static int check_collison(struct object_entry *entry)
 
 	memset(&data, 0, sizeof(data));
 	data.entry = entry;
-	data.st = open_istream(entry->idx.sha1, &type, &size, NULL);
+	data.st = open_istream(entry->idx.oid.hash, &type, &size, NULL);
 	if (!data.st)
 		return -1;
 	if (size != entry->size || type != entry->type)
 		die(_("SHA1 COLLISION FOUND WITH %s !"),
-		    sha1_to_hex(entry->idx.sha1));
+		    oid_to_hex(&entry->idx.oid));
 	unpack_data(entry, compare_objects, &data);
 	close_istream(data.st);
 	free(data.buf);
@@ -957,9 +957,10 @@ static void resolve_delta(struct object_entry *delta_obj,
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_sha1_file(result->data, result->size,
-		       typename(delta_obj->real_type), delta_obj->idx.sha1);
+		       typename(delta_obj->real_type),
+		       delta_obj->idx.oid.hash);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
-		    delta_obj->idx.sha1);
+		    delta_obj->idx.oid.hash);
 	counter_lock();
 	nr_resolved_deltas++;
 	counter_unlock();
@@ -989,7 +990,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
 	if (base->ref_last == -1 && base->ofs_last == -1) {
-		find_ref_delta_children(base->obj->idx.sha1,
+		find_ref_delta_children(base->obj->idx.oid.hash,
 					&base->ref_first, &base->ref_last,
 					OBJ_REF_DELTA);
 
@@ -1130,7 +1131,8 @@ static void parse_pack_objects(unsigned char *sha1)
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &ofs_delta->offset,
-					      ref_delta_sha1, obj->idx.sha1);
+					      ref_delta_sha1,
+					      obj->idx.oid.hash);
 		obj->real_type = obj->type;
 		if (obj->type == OBJ_OFS_DELTA) {
 			nr_ofs_deltas++;
@@ -1146,7 +1148,8 @@ static void parse_pack_objects(unsigned char *sha1)
 			obj->real_type = OBJ_BAD;
 			nr_delays++;
 		} else
-			sha1_object(data, NULL, obj->size, obj->type, obj->idx.sha1);
+			sha1_object(data, NULL, obj->size, obj->type,
+				    obj->idx.oid.hash);
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -1172,7 +1175,8 @@ static void parse_pack_objects(unsigned char *sha1)
 		if (obj->real_type != OBJ_BAD)
 			continue;
 		obj->real_type = obj->type;
-		sha1_object(NULL, obj, obj->size, obj->type, obj->idx.sha1);
+		sha1_object(NULL, obj, obj->size, obj->type,
+			    obj->idx.oid.hash);
 		nr_delays--;
 	}
 	if (nr_delays)
@@ -1330,7 +1334,7 @@ static struct object_entry *append_obj_to_pack(struct sha1file *f,
 	obj[1].idx.offset += write_compressed(f, buf, size);
 	obj[0].idx.crc32 = crc32_end(f);
 	sha1flush(f);
-	hashcpy(obj->idx.sha1, sha1);
+	hashcpy(obj->idx.oid.hash, sha1);
 	return obj;
 }
 
@@ -1581,13 +1585,14 @@ static void show_pack_info(int stat_only)
 		if (stat_only)
 			continue;
 		printf("%s %-6s %lu %lu %"PRIuMAX,
-		       sha1_to_hex(obj->idx.sha1),
+		       oid_to_hex(&obj->idx.oid),
 		       typename(obj->real_type), obj->size,
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
 			struct object_entry *bobj = &objects[obj_stat[i].base_object_no];
-			printf(" %u %s", obj_stat[i].delta_depth, sha1_to_hex(bobj->idx.sha1));
+			printf(" %u %s", obj_stat[i].delta_depth,
+			       oid_to_hex(&bobj->idx.oid));
 		}
 		putchar('\n');
 	}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 477070806..d76ff0542 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -106,12 +106,14 @@ static void *get_delta(struct object_entry *entry)
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 
-	buf = read_sha1_file(entry->idx.sha1, &type, &size);
+	buf = read_sha1_file(entry->idx.oid.hash, &type, &size);
 	if (!buf)
-		die("unable to read %s", sha1_to_hex(entry->idx.sha1));
-	base_buf = read_sha1_file(entry->delta->idx.sha1, &type, &base_size);
+		die("unable to read %s", oid_to_hex(&entry->idx.oid));
+	base_buf = read_sha1_file(entry->delta->idx.oid.hash, &type,
+				  &base_size);
 	if (!base_buf)
-		die("unable to read %s", sha1_to_hex(entry->delta->idx.sha1));
+		die("unable to read %s",
+		    oid_to_hex(&entry->delta->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
 	if (!delta_buf || delta_size != entry->delta_size)
@@ -249,12 +251,14 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 	if (!usable_delta) {
 		if (entry->type == OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
-		    (st = open_istream(entry->idx.sha1, &type, &size, NULL)) != NULL)
+		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
-			buf = read_sha1_file(entry->idx.sha1, &type, &size);
+			buf = read_sha1_file(entry->idx.oid.hash, &type,
+					     &size);
 			if (!buf)
-				die(_("unable to read %s"), sha1_to_hex(entry->idx.sha1));
+				die(_("unable to read %s"),
+				    oid_to_hex(&entry->idx.oid));
 		}
 		/*
 		 * make sure no cached delta data remains from a
@@ -322,7 +326,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 			return 0;
 		}
 		sha1write(f, header, hdrlen);
-		sha1write(f, entry->delta->idx.sha1, 20);
+		sha1write(f, entry->delta->idx.oid.hash, 20);
 		hdrlen += 20;
 	} else {
 		if (limit && hdrlen + datalen + 20 >= limit) {
@@ -334,7 +338,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 		sha1write(f, header, hdrlen);
 	}
 	if (st) {
-		datalen = write_large_blob_data(st, f, entry->idx.sha1);
+		datalen = write_large_blob_data(st, f, entry->idx.oid.hash);
 		close_istream(st);
 	} else {
 		sha1write(f, buf, datalen);
@@ -369,7 +373,8 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 	datalen = revidx[1].offset - offset;
 	if (!pack_to_stdout && p->index_version > 1 &&
 	    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
-		error("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
+		error("bad packed object CRC for %s",
+		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
 		return write_no_reuse_object(f, entry, limit, usable_delta);
 	}
@@ -379,7 +384,8 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 
 	if (!pack_to_stdout && p->index_version == 1 &&
 	    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
-		error("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
+		error("corrupt packed object for %s",
+		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
 		return write_no_reuse_object(f, entry, limit, usable_delta);
 	}
@@ -404,7 +410,7 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 			return 0;
 		}
 		sha1write(f, header, hdrlen);
-		sha1write(f, entry->delta->idx.sha1, 20);
+		sha1write(f, entry->delta->idx.oid.hash, 20);
 		hdrlen += 20;
 		reused_delta++;
 	} else {
@@ -509,7 +515,7 @@ static enum write_one_status write_one(struct sha1file *f,
 	recursing = (e->idx.offset == 1);
 	if (recursing) {
 		warning("recursive delta detected for object %s",
-			sha1_to_hex(e->idx.sha1));
+			oid_to_hex(&e->idx.oid));
 		return WRITE_ONE_RECURSIVE;
 	} else if (e->idx.offset || e->preferred_base) {
 		/* offset is non zero if object is written already. */
@@ -1432,7 +1438,7 @@ static void check_object(struct object_entry *entry)
 				ofs += 1;
 				if (!ofs || MSB(ofs, 7)) {
 					error("delta base offset overflow in pack for %s",
-					      sha1_to_hex(entry->idx.sha1));
+					      oid_to_hex(&entry->idx.oid));
 					goto give_up;
 				}
 				c = buf[used_0++];
@@ -1441,7 +1447,7 @@ static void check_object(struct object_entry *entry)
 			ofs = entry->in_pack_offset - ofs;
 			if (ofs <= 0 || ofs >= entry->in_pack_offset) {
 				error("delta base offset out of bound for %s",
-				      sha1_to_hex(entry->idx.sha1));
+				      oid_to_hex(&entry->idx.oid));
 				goto give_up;
 			}
 			if (reuse_delta && !entry->preferred_base) {
@@ -1498,7 +1504,7 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->idx.sha1, &entry->size);
+	entry->type = sha1_object_info(entry->idx.oid.hash, &entry->size);
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1514,7 +1520,7 @@ static int pack_offset_sort(const void *_a, const void *_b)
 
 	/* avoid filesystem trashing with loose objects */
 	if (!a->in_pack && !b->in_pack)
-		return hashcmp(a->idx.sha1, b->idx.sha1);
+		return oidcmp(&a->idx.oid, &b->idx.oid);
 
 	if (a->in_pack < b->in_pack)
 		return -1;
@@ -1560,7 +1566,8 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in entry->type
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = sha1_object_info(entry->idx.sha1, &entry->size);
+		entry->type = sha1_object_info(entry->idx.oid.hash,
+					       &entry->size);
 	}
 }
 
@@ -1852,26 +1859,29 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/* Load data if not already done */
 	if (!trg->data) {
 		read_lock();
-		trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
+		trg->data = read_sha1_file(trg_entry->idx.oid.hash, &type,
+					   &sz);
 		read_unlock();
 		if (!trg->data)
 			die("object %s cannot be read",
-			    sha1_to_hex(trg_entry->idx.sha1));
+			    oid_to_hex(&trg_entry->idx.oid));
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
-			    sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
+			    oid_to_hex(&trg_entry->idx.oid), sz,
+			    trg_size);
 		*mem_usage += sz;
 	}
 	if (!src->data) {
 		read_lock();
-		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
+		src->data = read_sha1_file(src_entry->idx.oid.hash, &type,
+					   &sz);
 		read_unlock();
 		if (!src->data) {
 			if (src_entry->preferred_base) {
 				static int warned = 0;
 				if (!warned++)
 					warning("object %s cannot be read",
-						sha1_to_hex(src_entry->idx.sha1));
+						oid_to_hex(&src_entry->idx.oid));
 				/*
 				 * Those objects are not included in the
 				 * resulting pack.  Be resilient and ignore
@@ -1881,11 +1891,12 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 				return 0;
 			}
 			die("object %s cannot be read",
-			    sha1_to_hex(src_entry->idx.sha1));
+			    oid_to_hex(&src_entry->idx.oid));
 		}
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
-			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
+			    oid_to_hex(&src_entry->idx.oid), sz,
+			    src_size);
 		*mem_usage += sz;
 	}
 	if (!src->index) {
@@ -2406,7 +2417,7 @@ static void prepare_pack(int window, int depth)
 			nr_deltas++;
 			if (entry->type < 0)
 				die("unable to get type of object %s",
-				    sha1_to_hex(entry->idx.sha1));
+				    oid_to_hex(&entry->idx.oid));
 		} else {
 			if (entry->type < 0) {
 				/*
diff --git a/bulk-checkin.c b/bulk-checkin.c
index ddb6070c4..5be7ce5c7 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -69,7 +69,7 @@ static int already_written(struct bulk_checkin_state *state, unsigned char sha1[
 
 	/* Might want to keep the list sorted */
 	for (i = 0; i < state->nr_written; i++)
-		if (!hashcmp(state->written[i]->sha1, sha1))
+		if (!hashcmp(state->written[i]->oid.hash, sha1))
 			return 1;
 
 	/* This is a new object we need to keep */
@@ -242,7 +242,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		state->offset = checkpoint.offset;
 		free(idx);
 	} else {
-		hashcpy(idx->sha1, result_sha1);
+		hashcpy(idx->oid.hash, result_sha1);
 		ALLOC_GROW(state->written,
 			   state->nr_written + 1,
 			   state->alloc_written);
diff --git a/fast-import.c b/fast-import.c
index 0aa81d522..d517b7536 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -563,7 +563,7 @@ static struct object_entry *new_object(struct object_id *oid)
 		alloc_objects(object_entry_alloc);
 
 	e = blocks->next_free++;
-	hashcpy(e->idx.sha1, oid->hash);
+	oidcpy(&e->idx.oid, oid);
 	return e;
 }
 
@@ -572,7 +572,7 @@ static struct object_entry *find_object(struct object_id *oid)
 	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
 	struct object_entry *e;
 	for (e = object_table[h]; e; e = e->next)
-		if (!hashcmp(oid->hash, e->idx.sha1))
+		if (!oidcmp(oid, &e->idx.oid))
 			return e;
 	return NULL;
 }
@@ -583,7 +583,7 @@ static struct object_entry *insert_object(struct object_id *oid)
 	struct object_entry *e = object_table[h];
 
 	while (e) {
-		if (!hashcmp(oid->hash, e->idx.sha1))
+		if (!oidcmp(oid, &e->idx.oid))
 			return e;
 		e = e->next;
 	}
@@ -1847,7 +1847,7 @@ static void dump_marks_helper(FILE *f,
 		for (k = 0; k < 1024; k++) {
 			if (m->data.marked[k])
 				fprintf(f, ":%" PRIuMAX " %s\n", base + k,
-					sha1_to_hex(m->data.marked[k]->idx.sha1));
+					oid_to_hex(&m->data.marked[k]->idx.oid));
 		}
 	}
 }
@@ -2385,7 +2385,7 @@ static void file_change_m(const char *p, struct branch *b)
 
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
-		hashcpy(oid.hash, oe->idx.sha1);
+		oidcpy(&oid, &oe->idx.oid);
 	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
@@ -2551,7 +2551,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	/* <dataref> or 'inline' */
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
-		hashcpy(oid.hash, oe->idx.sha1);
+		oidcpy(&oid, &oe->idx.oid);
 	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
@@ -2574,7 +2574,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		struct object_entry *commit_oe = find_mark(commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
-		hashcpy(commit_oid.hash, commit_oe->idx.sha1);
+		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!get_oid(p, &commit_oid)) {
 		unsigned long size;
 		char *buf = read_object_with_reference(commit_oid.hash,
@@ -2679,8 +2679,8 @@ static int parse_from(struct branch *b)
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
-		if (hashcmp(b->oid.hash, oe->idx.sha1)) {
-			hashcpy(b->oid.hash, oe->idx.sha1);
+		if (oidcmp(&b->oid, &oe->idx.oid)) {
+			oidcpy(&b->oid, &oe->idx.oid);
 			if (oe->pack_id != MAX_PACK_ID) {
 				unsigned long size;
 				char *buf = gfi_unpack_entry(oe, &size);
@@ -2723,7 +2723,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
-			hashcpy(n->oid.hash, oe->idx.sha1);
+			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!get_oid(from, &n->oid)) {
 			unsigned long size;
 			char *buf = read_object_with_reference(n->oid.hash,
@@ -2878,7 +2878,7 @@ static void parse_new_tag(const char *arg)
 		from_mark = parse_mark_ref_eol(from);
 		oe = find_mark(from_mark);
 		type = oe->type;
-		hashcpy(oid.hash, oe->idx.sha1);
+		oidcpy(&oid, &oe->idx.oid);
 	} else if (!get_oid(from, &oid)) {
 		struct object_entry *oe = find_object(&oid);
 		if (!oe) {
@@ -3008,7 +3008,7 @@ static void parse_get_mark(const char *p)
 	if (!oe)
 		die("Unknown mark: %s", command_buf.buf);
 
-	xsnprintf(output, sizeof(output), "%s\n", sha1_to_hex(oe->idx.sha1));
+	xsnprintf(output, sizeof(output), "%s\n", oid_to_hex(&oe->idx.oid));
 	cat_blob_write(output, GIT_SHA1_HEXSZ + 1);
 }
 
@@ -3022,7 +3022,7 @@ static void parse_cat_blob(const char *p)
 		oe = find_mark(parse_mark_ref_eol(p));
 		if (!oe)
 			die("Unknown mark: %s", command_buf.buf);
-		hashcpy(oid.hash, oe->idx.sha1);
+		oidcpy(&oid, &oe->idx.oid);
 	} else {
 		if (parse_oid_hex(p, &oid, &p))
 			die("Invalid dataref: %s", command_buf.buf);
@@ -3094,7 +3094,7 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 		e = find_mark(parse_mark_ref_space(p));
 		if (!e)
 			die("Unknown mark: %s", command_buf.buf);
-		hashcpy(oid.hash, e->idx.sha1);
+		oidcpy(&oid, &e->idx.oid);
 	} else {	/* <sha1> */
 		if (parse_oid_hex(*p, &oid, p))
 			die("Invalid dataref: %s", command_buf.buf);
@@ -3148,7 +3148,7 @@ static void parse_ls(const char *p, struct branch *b)
 	} else {
 		struct object_entry *e = parse_treeish_dataref(&p);
 		root = new_tree_entry();
-		hashcpy(root->versions[1].oid.hash, e->idx.sha1);
+		oidcpy(&root->versions[1].oid, &e->idx.oid);
 		if (!is_null_oid(&root->versions[1].oid))
 			root->versions[1].mode = S_IFDIR;
 		load_tree(root);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e313f4f2b..8e47a96b3 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -73,7 +73,8 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 			break;
 
 		default:
-			real_type = sha1_object_info(entry->idx.sha1, NULL);
+			real_type = sha1_object_info(entry->idx.oid.hash,
+						     NULL);
 			break;
 		}
 
@@ -96,7 +97,8 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 
 		default:
 			die("Missing type information for %s (%d/%d)",
-			    sha1_to_hex(entry->idx.sha1), real_type, entry->type);
+			    oid_to_hex(&entry->idx.oid), real_type,
+			    entry->type);
 		}
 	}
 }
@@ -459,7 +461,7 @@ static inline void dump_bitmap(struct sha1file *f, struct ewah_bitmap *bitmap)
 static const unsigned char *sha1_access(size_t pos, void *table)
 {
 	struct pack_idx_entry **index = table;
-	return index[pos]->sha1;
+	return index[pos]->oid.hash;
 }
 
 static void write_selected_commits_v1(struct sha1file *f,
diff --git a/pack-objects.c b/pack-objects.c
index 6398a8aa9..9558d1383 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -14,7 +14,7 @@ static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 	while (pdata->index[i] > 0) {
 		uint32_t pos = pdata->index[i] - 1;
 
-		if (!hashcmp(sha1, pdata->objects[pos].idx.sha1)) {
+		if (!hashcmp(sha1, pdata->objects[pos].idx.oid.hash)) {
 			*found = 1;
 			return i;
 		}
@@ -53,7 +53,9 @@ static void rehash_objects(struct packing_data *pdata)
 
 	for (i = 0; i < pdata->nr_objects; i++) {
 		int found;
-		uint32_t ix = locate_object_entry_hash(pdata, entry->idx.sha1, &found);
+		uint32_t ix = locate_object_entry_hash(pdata,
+						       entry->idx.oid.hash,
+						       &found);
 
 		if (found)
 			die("BUG: Duplicate object in hash");
@@ -98,7 +100,7 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	new_entry = pdata->objects + pdata->nr_objects++;
 
 	memset(new_entry, 0, sizeof(*new_entry));
-	hashcpy(new_entry->idx.sha1, sha1);
+	hashcpy(new_entry->idx.oid.hash, sha1);
 
 	if (pdata->index_size * 3 <= pdata->nr_objects * 4)
 		rehash_objects(pdata);
diff --git a/pack-write.c b/pack-write.c
index fa97b7255..a333ec675 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -13,7 +13,7 @@ static int sha1_compare(const void *_a, const void *_b)
 {
 	struct pack_idx_entry *a = *(struct pack_idx_entry **)_a;
 	struct pack_idx_entry *b = *(struct pack_idx_entry **)_b;
-	return hashcmp(a->sha1, b->sha1);
+	return oidcmp(&a->oid, &b->oid);
 }
 
 static int cmp_uint32(const void *a_, const void *b_)
@@ -103,7 +103,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		struct pack_idx_entry **next = list;
 		while (next < last) {
 			struct pack_idx_entry *obj = *next;
-			if (obj->sha1[0] != i)
+			if (obj->oid.hash[0] != i)
 				break;
 			next++;
 		}
@@ -122,11 +122,11 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 			uint32_t offset = htonl(obj->offset);
 			sha1write(f, &offset, 4);
 		}
-		sha1write(f, obj->sha1, 20);
+		sha1write(f, obj->oid.hash, 20);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
-		    (i && !hashcmp(list[-2]->sha1, obj->sha1)))
+		    (i && !oidcmp(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
-			    sha1_to_hex(obj->sha1));
+			    oid_to_hex(&obj->oid));
 	}
 
 	if (index_version >= 2) {
diff --git a/pack.h b/pack.h
index 5c2158746..c7de42ef3 100644
--- a/pack.h
+++ b/pack.h
@@ -67,7 +67,7 @@ struct pack_idx_header {
  * Common part of object structure used for write_idx_file
  */
 struct pack_idx_entry {
-	unsigned char sha1[20];
+	struct object_id oid;
 	uint32_t crc32;
 	off_t offset;
 };
