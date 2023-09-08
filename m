Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0BEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbjIHXMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344757AbjIHXMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:12:36 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765FBE45
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:12:27 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39866)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeI-006MyQ-MU; Fri, 08 Sep 2023 17:12:26 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeH-009u13-FR; Fri, 08 Sep 2023 17:12:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:44 -0500
Message-Id: <20230908231049.2035003-27-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeH-009u13-FR;;;mid=<20230908231049.2035003-27-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19AlIWH+EqBgyrJW6jAEONR7qdP73lVEBg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 27/32] builtin/fast-import: compute compatibility hashs for imported objects
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the code is in dual hash mode for every object fast-import
creates compute the standard oid and it's compatibility mapping.  The
compatibility mapping is stored in struct pack_idx_entry so that it
can be used when an index is created.

For fast-import the code needs to be careful because when a new object
only refers to other newly created objects the compatibility mapping
for those new objects is not stored anywhere permanently.  So have the
code first look the the compatibility oid in the newly created
objects, and then look for the compatibilty oid in the standard
mapping tables.

As fast-import requires objects to be specified before the
objects that reference them nothing special needs to happen
to deal with out of order objects.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/fast-import.c | 89 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2c645fcfbe3f..f1c250dd3c8f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -26,6 +26,8 @@
 #include "commit-reach.h"
 #include "khash.h"
 #include "date.h"
+#include "object-file-convert.h"
+#include "pack-compat-map.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -775,9 +777,14 @@ static void start_packfile(void)
 	all_packs[pack_id] = p;
 }
 
-static const char *create_index(void)
+struct pack_index_names {
+	const char *index_name;
+	const char *compat_name;
+};
+
+static struct pack_index_names create_index(void)
 {
-	const char *tmpfile;
+	struct pack_index_names tmp = {};
 	struct pack_idx_entry **idx, **c, **last;
 	struct object_entry *e;
 	struct object_entry_pool *o;
@@ -793,13 +800,15 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
-				 pack_data->hash);
+	tmp.index_name = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
+					pack_data->hash);
+	tmp.compat_name = write_compat_map_file(NULL, idx, object_count,
+						pack_data->hash);
 	free(idx);
-	return tmpfile;
+	return tmp;
 }
 
-static char *keep_pack(const char *curr_index_name)
+static char *keep_pack(struct pack_index_names curr)
 {
 	static const char *keep_msg = "fast-import";
 	struct strbuf name = STRBUF_INIT;
@@ -818,9 +827,17 @@ static char *keep_pack(const char *curr_index_name)
 		die("cannot store pack file");
 
 	odb_pack_name(&name, pack_data->hash, "idx");
-	if (finalize_object_file(curr_index_name, name.buf))
+	if (finalize_object_file(curr.index_name, name.buf))
 		die("cannot store index file");
-	free((void *)curr_index_name);
+
+	if (curr.compat_name) {
+		odb_pack_name(&name, pack_data->hash, "compat");
+		if (finalize_object_file(curr.compat_name, name.buf))
+			die("cannot store compatibility map file");
+	}
+
+	free((void *)curr.index_name);
+	free((void *)curr.compat_name);
 	return strbuf_detach(&name, NULL);
 }
 
@@ -943,6 +960,8 @@ static int store_object(
 	struct object_id *oidout,
 	uintmax_t mark)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	void *out, *delta;
 	struct object_entry *e;
 	unsigned char hdr[96];
@@ -966,8 +985,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_sha1_pack(oid.hash,
-				  get_all_packs(the_repository))) {
+	} else if (find_sha1_pack(oid.hash, get_all_packs(repo))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1026,6 +1044,42 @@ static int store_object(
 	e->type = type;
 	e->pack_id = pack_id;
 	e->idx.offset = pack_size;
+	if (compat && (type == OBJ_BLOB)) {
+		compat->init_fn(&c);
+		compat->update_fn(&c, hdr, hdrlen);
+		compat->update_fn(&c, dat->buf, dat->len);
+		compat->final_oid_fn(&e->idx.compat_oid, &c);
+	} else if (compat) {
+		struct object_file_convert_state state;
+		struct strbuf out = STRBUF_INIT;
+		int ret;
+
+		convert_object_file_begin(&state, &out, the_hash_algo, compat,
+					  dat->buf, dat->len, type);
+		for (;;) {
+			struct object_entry *pobj;
+
+			convert_object_file_step(&state);
+			if (ret != 1)
+				break;
+
+			ret = -1;
+			pobj = find_object(&state.oid);
+			if (pobj && pobj->idx.compat_oid.algo)
+				oidcpy(&state.mapped_oid, &pobj->idx.compat_oid);
+			else if (pobj)
+				break;
+			else if (repo_oid_to_algop(repo, &state.oid, compat,
+						   &state.mapped_oid))
+				break;
+		}
+		convert_object_file_end(&state, ret);
+		if (ret)
+			die(_("No mapping for %s to %s\n"),
+			    oid_to_hex(&state.oid), compat->name);
+		hash_object_file(compat, out.buf, out.len, type, &e->idx.compat_oid);
+		strbuf_release(&out);
+	}
 	object_count++;
 	object_count_by_type[type]++;
 
@@ -1084,14 +1138,15 @@ static void truncate_pack(struct hashfile_checkpoint *checkpoint)
 
 static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 {
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
 	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
 	unsigned char *in_buf = xmalloc(in_sz);
 	unsigned char *out_buf = xmalloc(out_sz);
 	struct object_entry *e;
-	struct object_id oid;
+	struct object_id oid, compat_oid;
 	unsigned long hdrlen;
 	off_t offset;
-	git_hash_ctx c;
+	git_hash_ctx c, compat_c;
 	git_zstream s;
 	struct hashfile_checkpoint checkpoint;
 	int status = Z_OK;
@@ -1109,6 +1164,10 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, out_buf, hdrlen);
+	if (compat) {
+		compat->init_fn(&compat_c);
+		compat->update_fn(&compat_c, out_buf, hdrlen);
+	}
 
 	crc32_begin(pack_file);
 
@@ -1127,6 +1186,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
 
 			the_hash_algo->update_fn(&c, in_buf, n);
+			if (compat)
+				compat->update_fn(&compat_c, in_buf, n);
 			s.next_in = in_buf;
 			s.avail_in = n;
 			len -= n;
@@ -1153,6 +1214,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	}
 	git_deflate_end(&s);
 	the_hash_algo->final_oid_fn(&oid, &c);
+	if (compat)
+		compat->final_oid_fn(&compat_oid, &compat_c);
 
 	if (oidout)
 		oidcpy(oidout, &oid);
@@ -1180,6 +1243,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		e->pack_id = pack_id;
 		e->idx.offset = offset;
 		e->idx.crc32 = crc32_end(pack_file);
+		if (compat)
+			oidcpy(&e->idx.compat_oid, &compat_oid);
 		object_count++;
 		object_count_by_type[OBJ_BLOB]++;
 	}
-- 
2.41.0

