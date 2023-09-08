Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD51EEB56E
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbjIHXMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344752AbjIHXMi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:12:38 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 16:12:32 PDT
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90825210B
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:12:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:35036)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeN-007R4u-IF; Fri, 08 Sep 2023 17:12:31 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeL-009u13-Qw; Fri, 08 Sep 2023 17:12:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:46 -0500
Message-Id: <20230908231049.2035003-29-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeL-009u13-Qw;;;mid=<20230908231049.2035003-29-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+RIArhl2iJZ4XaH6HK0Y0jJdmrgsXanEE=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 29/32] builtin/index-pack:  Compute the compatibility hash
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a pack is received encoded with the same algorithm as our
repository it is necessary to compute it's hash values and create it's
indexes.  That is the job of "git index-pack".  To compute the primary
hash values of the objects, the objects must be loaded in memory.
With the objects loaded into memory this is the perfect time to also
compute the compatiblity hash values of the objects as loading the
objects into memory is the primary cost of that operation.

This is limited by the the fact that to compute the compatiblity hash
for tree objects, commit objects, and tag objects the objects need to
encoded into their compatbiilty form which requires replacing
references to objects encoded with the primary hash to references to
the same objects encoded with the compatibility hash.

Which means that before the compatibility hash for a tree object,
commit object or tag object can be computed the compatibility hash
for all objects to which they refer must be computed first.

In general this requires an extra pass so that the dependencies between
objects can be resolved.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/index-pack.c | 335 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 328 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 75c2113e455c..f5da671ed82d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -18,12 +18,15 @@
 #include "thread-utils.h"
 #include "packfile.h"
 #include "pack-revindex.h"
+#include "pack-compat-map.h"
 #include "object-file.h"
 #include "object-store-ll.h"
 #include "oid-array.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "setup.h"
+#include "strbuf.h"
+#include "object-file-convert.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -124,6 +127,8 @@ static int nr_ofs_deltas;
 static int nr_ref_deltas;
 static int ref_deltas_alloc;
 static int nr_resolved_deltas;
+static int nr_pending_mappings;
+static int nr_resolved_mappings;
 static int nr_threads;
 
 static int32_t *oid_index;
@@ -505,28 +510,76 @@ static void prune_base_data(struct base_data *retain)
 	}
 }
 
+static int compat_hash_object_file(const void *buf, size_t len, enum object_type type,
+				   struct object_id *oid)
+{
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct object_file_convert_state state;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	convert_object_file_begin(&state, &out, algo, compat,
+				  buf, len, type);
+	for (;;) {
+		struct object_entry *pobj;
+		ret = convert_object_file_step(&state);
+		if (ret != 1)
+			break;
+
+		pobj = find_in_oid_index(&state.oid);
+
+		ret = -1;
+		if (pobj && pobj->idx.compat_oid.algo)
+			oidcpy(&state.mapped_oid, &pobj->idx.compat_oid);
+		else if (pobj)
+			break;
+		else if (repo_oid_to_algop(repo, &state.oid, compat,
+					   &state.mapped_oid))
+			break;
+	}
+	convert_object_file_end(&state, ret);
+	if (ret == 0) {
+		hash_object_file(compat, out.buf, out.len, type, oid);
+		strbuf_release(&out);
+	}
+	return ret;
+}
+
 static int is_delta_type(enum object_type type)
 {
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
 static void *unpack_entry_data(off_t offset, unsigned long size,
-			       enum object_type type, struct object_id *oid)
+			       enum object_type type, struct object_id *oid,
+			       struct object_id *compat_oid)
 {
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
 	static char fixed_buf[8192];
 	int status;
 	git_zstream stream;
 	void *buf;
-	git_hash_ctx c;
+	git_hash_ctx c, compat_c;
 	char hdr[32];
 	int hdrlen;
 
+	if (!compat)
+		compat_oid = NULL;
+
 	if (!is_delta_type(type)) {
 		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
 		the_hash_algo->init_fn(&c);
 		the_hash_algo->update_fn(&c, hdr, hdrlen);
-	} else
+		if (compat_oid && (type == OBJ_BLOB)) {
+			compat->init_fn(&compat_c);
+			compat->update_fn(&compat_c, hdr, hdrlen);
+		}
+	} else {
 		oid = NULL;
+		compat_oid = NULL;
+	}
 	if (type == OBJ_BLOB && size > big_file_threshold)
 		buf = fixed_buf;
 	else
@@ -545,6 +598,8 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		use(input_len - stream.avail_in);
 		if (oid)
 			the_hash_algo->update_fn(&c, last_out, stream.next_out - last_out);
+		if (compat_oid && (type == OBJ_BLOB))
+			compat->update_fn(&compat_c, last_out, stream.next_out - last_out);
 		if (buf == fixed_buf) {
 			stream.next_out = buf;
 			stream.avail_out = sizeof(fixed_buf);
@@ -555,13 +610,20 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	git_inflate_end(&stream);
 	if (oid)
 		the_hash_algo->final_oid_fn(oid, &c);
+	if (compat_oid && (type == OBJ_BLOB))
+		compat->final_oid_fn(compat_oid, &compat_c);
+	else if (compat_oid &&
+		 compat_hash_object_file(buf, size, type, compat_oid)) {
+		nr_pending_mappings++;
+	}
 	return buf == fixed_buf ? NULL : buf;
 }
 
 static void *unpack_raw_entry(struct object_entry *obj,
 			      off_t *ofs_offset,
 			      struct object_id *ref_oid,
-			      struct object_id *oid)
+			      struct object_id *oid,
+			      struct object_id *compat_oid)
 {
 	unsigned char *p;
 	unsigned long size, c;
@@ -620,7 +682,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	}
 	obj->hdr_size = consumed_bytes - obj->idx.offset;
 
-	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, oid);
+	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, oid,
+				 compat_oid);
 	obj->idx.crc32 = input_crc32;
 	return data;
 }
@@ -1023,9 +1086,11 @@ static struct base_data *make_base(struct object_entry *obj,
 static struct base_data *resolve_delta(struct object_entry *delta_obj,
 				       struct base_data *base)
 {
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
 	void *delta_data, *result_data;
 	struct base_data *result;
 	unsigned long result_size;
+	int pending_map = 0;
 
 	if (show_stat) {
 		int i = delta_obj - objects;
@@ -1046,6 +1111,16 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_object_file(the_hash_algo, result_data, result_size,
 			 delta_obj->real_type, &delta_obj->idx.oid);
+	if (compat && (delta_obj->real_type == OBJ_BLOB))
+		hash_object_file(compat, result_data, result_size,
+				 delta_obj->real_type, &delta_obj->idx.compat_oid);
+	else if (compat &&
+		 compat_hash_object_file(result_data, result_size,
+					 delta_obj->real_type,
+					 &delta_obj->idx.compat_oid)) {
+		pending_map = 1;
+	}
+
 	place_in_oid_index(delta_obj);
 	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
@@ -1056,6 +1131,8 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 
 	counter_lock();
 	nr_resolved_deltas++;
+	if (pending_map)
+		nr_pending_mappings++;
 	counter_unlock();
 
 	return result;
@@ -1236,7 +1313,8 @@ static void parse_pack_objects(unsigned char *hash)
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &ofs_delta->offset,
 					      &ref_delta_oid,
-					      &obj->idx.oid);
+					      &obj->idx.oid,
+					      &obj->idx.compat_oid);
 		obj->real_type = obj->type;
 		if (obj->type == OBJ_OFS_DELTA) {
 			nr_ofs_deltas++;
@@ -1578,6 +1656,7 @@ static void rename_tmp_packfile(const char **final_name,
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *final_rev_index_name, const char *curr_rev_index_name,
+		  const char *final_compat_index_name, const char *curr_compat_index_name,
 		  const char *keep_msg, const char *promisor_msg,
 		  unsigned char *hash)
 {
@@ -1585,6 +1664,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf index_name = STRBUF_INIT;
 	struct strbuf rev_index_name = STRBUF_INIT;
+	struct strbuf compat_index_name = STRBUF_INIT;
 	int err;
 
 	if (!from_stdin) {
@@ -1608,6 +1688,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (curr_rev_index_name)
 		rename_tmp_packfile(&final_rev_index_name, curr_rev_index_name,
 				    &rev_index_name, hash, "rev", 1);
+	if (curr_compat_index_name)
+		rename_tmp_packfile(&final_compat_index_name, curr_compat_index_name,
+				    &compat_index_name, hash, "compat", 1);
 	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
 			    hash, "idx", 1);
 
@@ -1640,6 +1723,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		}
 	}
 
+	strbuf_release(&compat_index_name);
 	strbuf_release(&rev_index_name);
 	strbuf_release(&index_name);
 	strbuf_release(&pack_name);
@@ -1789,16 +1873,236 @@ static void show_pack_info(int stat_only)
 	free(chain_histogram);
 }
 
+static int compare_ofs_delta_entry_obj_no(const void *a, const void *b)
+{
+	const struct ofs_delta_entry *delta_a = a;
+	const struct ofs_delta_entry *delta_b = b;
+
+	return delta_a->obj_no < delta_b->obj_no ? -1 :
+	       delta_a->obj_no > delta_b->obj_no ?  1 :
+	       0;
+}
+
+static int compare_ref_delta_entry_obj_no(const void *a, const void *b)
+{
+	const struct ref_delta_entry *delta_a = a;
+	const struct ref_delta_entry *delta_b = b;
+
+	return delta_a->obj_no < delta_b->obj_no ? -1 :
+	       delta_a->obj_no > delta_b->obj_no ?  1 :
+	       0;
+}
+
+static struct ofs_delta_entry *find_ofs_delta_obj_no(int obj_no)
+{
+	int first = 0, last = nr_ofs_deltas;
+
+	while (first < last) {
+		int next = first + (last - first) / 2;
+		struct ofs_delta_entry *entry = &ofs_deltas[next];
+
+		if (obj_no == entry->obj_no)
+			return entry;
+		if (obj_no < entry->obj_no) {
+			last = next;
+			continue;
+		}
+		first = next + 1;
+	}
+	return NULL;
+}
+
+static struct ref_delta_entry *find_ref_delta_obj_no(int obj_no)
+{
+	int first = 0, last = nr_ref_deltas;
+
+	while (first < last) {
+		int next = first + (last - first) / 2;
+		struct ref_delta_entry *entry = &ref_deltas[next];
+
+		if (obj_no == entry->obj_no)
+			return entry;
+		if (obj_no < entry->obj_no) {
+			last = next;
+			continue;
+		}
+		first = next + 1;
+	}
+	return NULL;
+}
+
+static struct object_entry *find_obj_offset(off_t offset)
+{
+	int first = 0, last = nr_objects;
+
+	while (first < last) {
+		int next = first + (last - first) / 2;
+		struct object_entry *entry = &objects[next];
+
+		if (offset == entry->idx.offset)
+			return entry;
+		if (offset < entry->idx.offset) {
+			last = next;
+			continue;
+		}
+		first = next + 1;
+	}
+	return NULL;
+}
+
+static void *get_object_data(struct object_entry *obj, size_t *result_size)
+{
+	/* Allow random reading objects */
+	void *data;
+
+	if (!is_delta_type(obj->type)) {
+		data = get_data_from_pack(obj);
+		*result_size = obj->size;
+		return data;
+	}
+	if (obj->type == OBJ_OFS_DELTA) {
+		struct ofs_delta_entry *delta;
+		struct object_entry *bobj;
+		size_t base_size;
+		void *base, *raw;
+
+		delta = find_ofs_delta_obj_no(obj - objects);
+		if (!delta)
+			BUG("Delta object without ofs_delta entry");
+
+		bobj = find_obj_offset(delta->offset);
+		if (!bobj)
+			BUG("Delta object without object entry");
+
+		base = get_object_data(bobj, &base_size);
+		raw = get_data_from_pack(obj);
+		data = patch_delta(
+			base, base_size,
+			raw, obj->size,
+			result_size);
+		if (!data)
+			BUG("patch_delta failed");
+		free(raw);
+		free(base);
+		return data;
+	}
+	if (obj->type == OBJ_REF_DELTA) {
+		struct ref_delta_entry *delta;
+		enum object_type base_type;
+		size_t base_size;
+		void *base, *raw;
+
+		delta = find_ref_delta_obj_no(obj - objects);
+		if (!delta)
+			BUG("Delta object without ref_delta entry");
+
+		base = repo_read_object_file(the_repository, &delta->oid,
+					     &base_type, &base_size);
+		if (!base)
+			BUG("ref_delta oid %s not present in repository",
+			    oid_to_hex(&delta->oid));
+		raw = get_data_from_pack(obj);
+		data = patch_delta(
+			base, base_size,
+			raw, obj->size,
+			result_size);
+		if (!data)
+			BUG("patch_delta failed");
+		free(raw);
+		free(base);
+		return data;
+	}
+	return NULL; /* The code never reaches here */
+}
+
+static void compute_compat_oid(struct object_entry *obj)
+{
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct object_file_convert_state state;
+	struct strbuf out = STRBUF_INIT;
+	size_t data_size;
+	void *data;
+	int ret;
+
+	if (obj->idx.compat_oid.algo)
+		return;
+
+	if (obj->real_type == OBJ_BLOB)
+		die("Blob object not converted");
+
+	data = get_object_data(obj, &data_size);
+
+	convert_object_file_begin(&state, &out, algo, compat,
+				  data, data_size, obj->real_type);
+
+	for (;;) {
+		struct object_entry *pobj;
+		ret = convert_object_file_step(&state);
+		if (ret != 1)
+			break;
+		/* Does it name an object in the pack? */
+		pobj = find_in_oid_index(&state.oid);
+		if (pobj) {
+			compute_compat_oid(pobj);
+			oidcpy(&state.mapped_oid, &pobj->idx.compat_oid);
+		} else if (repo_oid_to_algop(repo, &state.oid, compat,
+					     &state.mapped_oid))
+			die(_("No mapping for oid %s to %s\n"),
+			    oid_to_hex(&state.oid), compat->name);
+	}
+	convert_object_file_end(&state, ret);
+	if (ret != 0)
+		die(_("Bad object %s\n"), oid_to_hex(&obj->idx.oid));
+	hash_object_file(compat, out.buf, out.len, obj->real_type,
+			 &obj->idx.compat_oid);
+	strbuf_release(&out);
+
+	free(data);
+
+	nr_resolved_mappings++;
+	display_progress(progress, nr_resolved_mappings);
+}
+
+static void compute_compat_oids(void)
+{
+	unsigned i;
+
+	if (verbose)
+		progress = start_progress(_("Mapping objects"),
+			nr_pending_mappings);
+
+	/* Sort deltas by obj_no for fast searching */
+	QSORT(ofs_deltas, nr_ofs_deltas, compare_ofs_delta_entry_obj_no);
+	QSORT(ref_deltas, nr_ref_deltas, compare_ref_delta_entry_obj_no);
+
+	for (i = 0; i < nr_objects; i++) {
+		struct object_entry *obj = &objects[i];
+		if (obj->idx.compat_oid.algo)
+			continue;
+		if (is_delta_type(obj->real_type))
+			continue;
+		compute_compat_oid(obj);
+	}
+
+	stop_progress(&progress);
+}
+
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
 	const char *curr_index;
 	const char *curr_rev_index = NULL;
+	const char *curr_compat_index = NULL;
 	const char *index_name = NULL, *pack_name = NULL, *rev_index_name = NULL;
+	const char *compat_index_name = NULL;
 	const char *keep_msg = NULL;
 	const char *promisor_msg = NULL;
 	struct strbuf index_name_buf = STRBUF_INIT;
 	struct strbuf rev_index_name_buf = STRBUF_INIT;
+	struct strbuf compat_index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_hash[GIT_MAX_RAWSZ];
@@ -1946,6 +2250,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 							 "idx", "rev",
 							 &rev_index_name_buf);
 	}
+	if (compat) {
+		if (index_name)
+			compat_index_name = derive_filename(index_name,
+							    "idx", "compat",
+							    &compat_index_name_buf);
+	}
 
 	if (verify) {
 		if (!index_name)
@@ -1989,6 +2299,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		write_in_full(2, "\0", 1);
 	resolve_deltas();
 	conclude_pack(fix_thin_pack, curr_pack, pack_hash);
+	if (compat)
+		compute_compat_oids();
 	free(ofs_deltas);
 	free(ref_deltas);
 	if (strict)
@@ -1999,18 +2311,24 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
-		idx_objects[i] = &objects[i].idx;
+		idx_objects[i] = (struct pack_idx_entry *)&objects[i].idx;
 	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_hash);
 	if (rev_index)
 		curr_rev_index = write_rev_file(rev_index_name, idx_objects,
 						nr_objects, pack_hash,
 						opts.flags);
+
+	if (compat)
+		curr_compat_index = write_compat_map_file(
+			(opts.flags & WRITE_IDX_VERIFY) ? compat_index_name : NULL,
+			idx_objects, nr_objects, pack_hash);
 	free(idx_objects);
 
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
 		      rev_index_name, curr_rev_index,
+		      compat_index_name, curr_compat_index,
 		      keep_msg, promisor_msg,
 		      pack_hash);
 	else
@@ -2023,12 +2341,15 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	free(objects);
 	strbuf_release(&index_name_buf);
 	strbuf_release(&rev_index_name_buf);
+	strbuf_release(&compat_index_name_buf);
 	if (!pack_name)
 		free((void *) curr_pack);
 	if (!index_name)
 		free((void *) curr_index);
 	if (!rev_index_name)
 		free((void *) curr_rev_index);
+	if (!compat_index_name)
+		free((void *) curr_compat_index);
 
 	/*
 	 * Let the caller know this pack is not self contained
-- 
2.41.0

