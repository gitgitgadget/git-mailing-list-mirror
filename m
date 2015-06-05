From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Pack files, standards compliance, and efficiency
Date: Fri, 5 Jun 2015 01:41:21 +0000
Message-ID: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 03:41:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0gdZ-00034r-Em
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 03:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbFEBl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 21:41:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33375 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752849AbbFEBl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 21:41:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd0c:c3b:29e1:d998])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7C6682808F;
	Fri,  5 Jun 2015 01:41:24 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270811>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There was discussion sometime back about the object_id conversions and
handling direct offsets in pack files.  In some places in sha1_file.c,
we return direct pointers to the SHA-1 values in the mmap'd pack file
and use those in other parts of the code.

However, with the object_id conversion, we run into a problem: casting
those unsigned char * values into struct object_id * values is not
allowed by the C standard.  There are two possible solutions: copying;
and the just-do-it solution, where we cast and hope for the best.

It looks like we use the latter in nth_packed_object_offset, where we
cast an unsigned char * value to uint32_t *, which is clearly not
allowed.  I'm to the point where I need to make a decision on how to
proceed, and I've included a patch with the copying conversion of
nth_packed_object_sha1 below for comparison.  The casting solution is
obviously more straightforward.  I haven't tested either implementation
for performance.

People interested in the (still-to-change) state of the branch can see
it at https://github.com/bk2204/git object-id-part2.

------------8<------------------
=46rom 0f7a958ebbf6c25af526c5c46cc9b5f29f7caa15 Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Thu, 4 Jun 2015 01:26:10 +0000
Subject: [PATCH] Convert nth_packed_object_sha1 to object_id.

nth_packed_object_sha1 returned a pointer directly into the mmap'd
memory of the pack in question, but the C standard does not allow
converting a pointer to unsigned char directly into a pointer to struct
object_id, even though the data represented is exactly the same size.

Rename the function nth_packed_object_oid, and make it take an
additional argument of type pointer to struct object_id.  Copy the data,
even though this is less efficient, and adjust the callers to account
for the change in calling conventions.  Adjust get_delta_base_sha1
similarly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c | 22 +++++++-------
 cache.h                |  8 ++---
 pack-bitmap.c          | 24 +++++++--------
 pack-check.c           | 15 +++++-----
 sha1_file.c            | 81 +++++++++++++++++++++++++++-------------------=
----
 sha1_name.c            | 14 ++++-----
 6 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 870a266..9e12bd8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1329,6 +1329,7 @@ static void check_object(struct object_entry *entry)
 		struct packed_git *p =3D entry->in_pack;
 		struct pack_window *w_curs =3D NULL;
 		const unsigned char *base_ref =3D NULL;
+		struct object_id base_ref_oid;
 		struct object_entry *base_entry;
 		unsigned long used, used_0;
 		unsigned long avail;
@@ -1394,7 +1395,8 @@ static void check_object(struct object_entry *entry)
 				revidx =3D find_pack_revindex(p, ofs);
 				if (!revidx)
 					goto give_up;
-				base_ref =3D nth_packed_object_sha1(p, revidx->nr);
+				nth_packed_object_oid(p, &base_ref_oid, revidx->nr);
+				base_ref =3D base_ref_oid.hash;
 			}
 			entry->in_pack_header_size =3D used + used_0;
 			break;
@@ -2350,7 +2352,7 @@ static void add_objects_in_unpacked_packs(struct rev_=
info *revs)
 	memset(&in_pack, 0, sizeof(in_pack));
=20
 	for (p =3D packed_git; p; p =3D p->next) {
-		const unsigned char *sha1;
+		struct object_id oid;
 		struct object *o;
=20
 		if (!p->pack_local || p->pack_keep)
@@ -2363,8 +2365,8 @@ static void add_objects_in_unpacked_packs(struct rev_=
info *revs)
 			   in_pack.alloc);
=20
 		for (i =3D 0; i < p->num_objects; i++) {
-			sha1 =3D nth_packed_object_sha1(p, i);
-			o =3D lookup_unknown_object(sha1);
+			nth_packed_object_oid(p, &oid, i);
+			o =3D lookup_unknown_object(oid.hash);
 			if (!(o->flags & OBJECT_ADDED))
 				mark_in_pack_object(o, p, &in_pack);
 			o->flags |=3D OBJECT_ADDED;
@@ -2430,7 +2432,7 @@ static void loosen_unused_packed_objects(struct rev_i=
nfo *revs)
 {
 	struct packed_git *p;
 	uint32_t i;
-	const unsigned char *sha1;
+	struct object_id oid;
=20
 	for (p =3D packed_git; p; p =3D p->next) {
 		if (!p->pack_local || p->pack_keep)
@@ -2440,11 +2442,11 @@ static void loosen_unused_packed_objects(struct rev=
_info *revs)
 			die("cannot open pack index");
=20
 		for (i =3D 0; i < p->num_objects; i++) {
-			sha1 =3D nth_packed_object_sha1(p, i);
-			if (!packlist_find(&to_pack, sha1, NULL) &&
-			    !has_sha1_pack_kept_or_nonlocal(sha1) &&
-			    !loosened_object_can_be_discarded(sha1, p->mtime))
-				if (force_object_loose(sha1, p->mtime))
+			nth_packed_object_oid(p, &oid, i);
+			if (!packlist_find(&to_pack, oid.hash, NULL) &&
+			    !has_sha1_pack_kept_or_nonlocal(oid.hash) &&
+			    !loosened_object_can_be_discarded(oid.hash, p->mtime))
+				if (force_object_loose(oid.hash, p->mtime))
 					die("unable to force loose object");
 		}
 	}
diff --git a/cache.h b/cache.h
index 661ab72..4c51b08 100644
--- a/cache.h
+++ b/cache.h
@@ -1281,12 +1281,10 @@ extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
=20
 /*
- * Return the SHA-1 of the nth object within the specified packfile.
- * Open the index if it is not already open.  The return value points
- * at the SHA-1 within the mmapped index.  Return NULL if there is an
- * error.
+ * Store the object ID of the nth object within the specified packfile.
+ * Open the index if it is not already open.  Return 0 on success.
  */
-extern const unsigned char *nth_packed_object_sha1(struct packed_git *, ui=
nt32_t n);
+extern int nth_packed_object_oid(struct packed_git *, struct object_id *oi=
d, uint32_t n);
=20
 /*
  * Return the offset of the nth object within the specified packfile.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e49340a..e39f8c6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -223,13 +223,13 @@ static int load_bitmap_entries_v1(struct bitmap_index=
 *index)
 		struct ewah_bitmap *bitmap =3D NULL;
 		struct stored_bitmap *xor_bitmap =3D NULL;
 		uint32_t commit_idx_pos;
-		const unsigned char *sha1;
+		struct object_id oid;
=20
 		commit_idx_pos =3D read_be32(index->map, &index->map_pos);
 		xor_offset =3D read_u8(index->map, &index->map_pos);
 		flags =3D read_u8(index->map, &index->map_pos);
=20
-		sha1 =3D nth_packed_object_sha1(index->pack, commit_idx_pos);
+		nth_packed_object_oid(index->pack, &oid, commit_idx_pos);
=20
 		bitmap =3D read_bitmap_1(index);
 		if (!bitmap)
@@ -246,7 +246,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *=
index)
 		}
=20
 		recent_bitmaps[i % MAX_XOR_OFFSET] =3D store_bitmap(
-			index, bitmap, sha1, xor_bitmap, flags);
+			index, bitmap, oid.hash, xor_bitmap, flags);
 	}
=20
 	return 0;
@@ -625,7 +625,7 @@ static void show_objects_for_type(
 		eword_t word =3D objects->words[i] & filter;
=20
 		for (offset =3D 0; offset < BITS_IN_WORD; ++offset) {
-			const unsigned char *sha1;
+			struct object_id oid;
 			struct revindex_entry *entry;
 			uint32_t hash =3D 0;
=20
@@ -638,12 +638,12 @@ static void show_objects_for_type(
 				continue;
=20
 			entry =3D &bitmap_git.reverse_index->revindex[pos + offset];
-			sha1 =3D nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+			nth_packed_object_oid(bitmap_git.pack, &oid, entry->nr);
=20
 			if (bitmap_git.hashes)
 				hash =3D ntohl(bitmap_git.hashes[entry->nr]);
=20
-			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
+			show_reach(oid.hash, object_type, 0, hash, bitmap_git.pack, entry->offs=
et);
 		}
=20
 		pos +=3D BITS_IN_WORD;
@@ -783,15 +783,15 @@ int reuse_partial_packfile_from_bitmap(struct packed_=
git **packfile,
=20
 #ifdef GIT_BITMAP_DEBUG
 	{
-		const unsigned char *sha1;
+		struct object_id oid;
 		struct revindex_entry *entry;
=20
 		entry =3D &bitmap_git.reverse_index->revindex[reuse_objects];
-		sha1 =3D nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+		nth_packed_object_oid(bitmap_git.pack, &oid, entry->nr);
=20
 		fprintf(stderr, "Failed to reuse at %d (%016llx)\n",
 			reuse_objects, result->words[i]);
-		fprintf(stderr, " %s\n", sha1_to_hex(sha1));
+		fprintf(stderr, " %s\n", oid_to_hex(&oid));
 	}
 #endif
=20
@@ -1041,13 +1041,13 @@ int rebuild_existing_bitmaps(struct packing_data *m=
apping,
 	reposition =3D xcalloc(num_objects, sizeof(uint32_t));
=20
 	for (i =3D 0; i < num_objects; ++i) {
-		const unsigned char *sha1;
+		struct object_id oid;
 		struct revindex_entry *entry;
 		struct object_entry *oe;
=20
 		entry =3D &bitmap_git.reverse_index->revindex[i];
-		sha1 =3D nth_packed_object_sha1(bitmap_git.pack, entry->nr);
-		oe =3D packlist_find(mapping, sha1, NULL);
+		nth_packed_object_oid(bitmap_git.pack, &oid, entry->nr);
+		oe =3D packlist_find(mapping, oid.hash, NULL);
=20
 		if (oe)
 			reposition[i] =3D oe->in_pack_pos + 1;
diff --git a/pack-check.c b/pack-check.c
index 63a595c..f06a227 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -5,7 +5,7 @@
=20
 struct idx_entry {
 	off_t                offset;
-	const unsigned char *sha1;
+	struct object_id oid;
 	unsigned int nr;
 };
=20
@@ -93,8 +93,7 @@ static int verify_packfile(struct packed_git *p,
 	entries[nr_objects].offset =3D pack_sig_ofs;
 	/* first sort entries by pack offset, since unpacking them is more effici=
ent that way */
 	for (i =3D 0; i < nr_objects; i++) {
-		entries[i].sha1 =3D nth_packed_object_sha1(p, i);
-		if (!entries[i].sha1)
+		if (nth_packed_object_oid(p, &entries[i].oid, i))
 			die("internal error pack-check nth-packed-object");
 		entries[i].offset =3D nth_packed_object_offset(p, i);
 		entries[i].nr =3D i;
@@ -113,20 +112,20 @@ static int verify_packfile(struct packed_git *p,
 			if (check_pack_crc(p, w_curs, offset, len, nr))
 				err =3D error("index CRC mismatch for object %s "
 					    "from %s at offset %"PRIuMAX"",
-					    sha1_to_hex(entries[i].sha1),
+					    oid_to_hex(&entries[i].oid),
 					    p->pack_name, (uintmax_t)offset);
 		}
 		data =3D unpack_entry(p, entries[i].offset, &type, &size);
 		if (!data)
 			err =3D error("cannot unpack %s from %s at offset %"PRIuMAX"",
-				    sha1_to_hex(entries[i].sha1), p->pack_name,
+				    oid_to_hex(&entries[i].oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_sha1_signature(entries[i].sha1, data, size, typename(type=
)))
+		else if (check_sha1_signature(entries[i].oid.hash, data, size, typename(=
type)))
 			err =3D error("packed %s from %s is corrupt",
-				    sha1_to_hex(entries[i].sha1), p->pack_name);
+				    oid_to_hex(&entries[i].oid), p->pack_name);
 		else if (fn) {
 			int eaten =3D 0;
-			fn(entries[i].sha1, type, size, data, &eaten);
+			fn(entries[i].oid.hash, type, size, data, &eaten);
 			if (eaten)
 				data =3D NULL;
 		}
diff --git a/sha1_file.c b/sha1_file.c
index 346f468..ff06ec5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1810,35 +1810,39 @@ static off_t get_delta_base(struct packed_git *p,
 }
=20
 /*
- * Like get_delta_base above, but we return the sha1 instead of the pack
- * offset. This means it is cheaper for REF deltas (we do not have to do
- * the final object lookup), but more expensive for OFS deltas (we
- * have to load the revidx to convert the offset back into a sha1).
+ * Like get_delta_base above, but we store the base into base instead of t=
he
+ * pack offset. This means it is cheaper for REF deltas (we do not have to
+ * do the final object lookup), but more expensive for OFS deltas (we have
+ * to load the revidx to convert the offset back into a sha1).  Return 0 on
+ * success.
  */
-static const unsigned char *get_delta_base_sha1(struct packed_git *p,
+static int get_delta_base_oid(struct packed_git *p, struct object_id *base,
 						struct pack_window **w_curs,
 						off_t curpos,
 						enum object_type type,
 						off_t delta_obj_offset)
 {
 	if (type =3D=3D OBJ_REF_DELTA) {
-		unsigned char *base =3D use_pack(p, w_curs, curpos, NULL);
-		return base;
+		unsigned char *sha1 =3D use_pack(p, w_curs, curpos, NULL);
+		if (!sha1)
+			return -1;
+		hashcpy(base->hash, sha1);
+		return 0;
 	} else if (type =3D=3D OBJ_OFS_DELTA) {
 		struct revindex_entry *revidx;
 		off_t base_offset =3D get_delta_base(p, w_curs, &curpos,
 						   type, delta_obj_offset);
=20
 		if (!base_offset)
-			return NULL;
+			return -1;
=20
 		revidx =3D find_pack_revindex(p, base_offset);
 		if (!revidx)
-			return NULL;
+			return -1;
=20
-		return nth_packed_object_sha1(p, revidx->nr);
+		return nth_packed_object_oid(p, base, revidx->nr);
 	} else
-		return NULL;
+		return -1;
 }
=20
 int unpack_object_header(struct packed_git *p,
@@ -1871,13 +1875,13 @@ static int retry_bad_packed_offset(struct packed_gi=
t *p, off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
-	const unsigned char *sha1;
+	struct object_id oid;
 	revidx =3D find_pack_revindex(p, obj_offset);
 	if (!revidx)
 		return OBJ_BAD;
-	sha1 =3D nth_packed_object_sha1(p, revidx->nr);
-	mark_bad_packed_object(p, sha1);
-	type =3D sha1_object_info(sha1, NULL);
+	nth_packed_object_oid(p, &oid, revidx->nr);
+	mark_bad_packed_object(p, oid.hash);
+	type =3D sha1_object_info(oid.hash, NULL);
 	if (type <=3D OBJ_NONE)
 		return OBJ_BAD;
 	return type;
@@ -2000,16 +2004,15 @@ static int packed_object_info(struct packed_git *p,=
 off_t obj_offset,
=20
 	if (oi->delta_base_sha1) {
 		if (type =3D=3D OBJ_OFS_DELTA || type =3D=3D OBJ_REF_DELTA) {
-			const unsigned char *base;
+			struct object_id base;
=20
-			base =3D get_delta_base_sha1(p, &w_curs, curpos,
-						   type, obj_offset);
-			if (!base) {
+			if (get_delta_base_oid(p, &base, &w_curs, curpos,
+						type, obj_offset)) {
 				type =3D OBJ_BAD;
 				goto out;
 			}
=20
-			hashcpy(oi->delta_base_sha1, base);
+			hashcpy(oi->delta_base_sha1, base.hash);
 		} else
 			hashclr(oi->delta_base_sha1);
 	}
@@ -2239,11 +2242,11 @@ void *unpack_entry(struct packed_git *p, off_t obj_=
offset,
 			struct revindex_entry *revidx =3D find_pack_revindex(p, obj_offset);
 			unsigned long len =3D revidx[1].offset - obj_offset;
 			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
-				const unsigned char *sha1 =3D
-					nth_packed_object_sha1(p, revidx->nr);
+				struct object_id oid;
+				nth_packed_object_oid(p, &oid, revidx->nr);
 				error("bad packed object CRC for %s",
-				      sha1_to_hex(sha1));
-				mark_bad_packed_object(p, sha1);
+				      oid_to_hex(&oid));
+				mark_bad_packed_object(p, oid.hash);
 				unuse_pack(&w_curs);
 				return NULL;
 			}
@@ -2325,16 +2328,17 @@ void *unpack_entry(struct packed_git *p, off_t obj_=
offset,
 			 * of a corrupted pack, and is better than failing outright.
 			 */
 			struct revindex_entry *revidx;
-			const unsigned char *base_sha1;
 			revidx =3D find_pack_revindex(p, obj_offset);
 			if (revidx) {
-				base_sha1 =3D nth_packed_object_sha1(p, revidx->nr);
+				struct object_id base_oid;
+
+				nth_packed_object_oid(p, &base_oid, revidx->nr);
 				error("failed to read delta base object %s"
 				      " at offset %"PRIuMAX" from %s",
-				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
+				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
 				      p->pack_name);
-				mark_bad_packed_object(p, base_sha1);
-				base =3D read_object(base_sha1, &type, &base_size);
+				mark_bad_packed_object(p, base_oid.hash);
+				base =3D read_object(base_oid.hash, &type, &base_size);
 			}
 		}
=20
@@ -2385,24 +2389,25 @@ void *unpack_entry(struct packed_git *p, off_t obj_=
offset,
 	return data;
 }
=20
-const unsigned char *nth_packed_object_sha1(struct packed_git *p,
-					    uint32_t n)
+int nth_packed_object_oid(struct packed_git *p, struct object_id *oid,
+			  uint32_t n)
 {
 	const unsigned char *index =3D p->index_data;
 	if (!index) {
 		if (open_pack_index(p))
-			return NULL;
+			return -1;
 		index =3D p->index_data;
 	}
 	if (n >=3D p->num_objects)
-		return NULL;
+		return -1;
 	index +=3D 4 * 256;
 	if (p->index_version =3D=3D 1) {
-		return index + 24 * n + 4;
+		hashcpy(oid->hash, index + 24 * n + 4);
 	} else {
 		index +=3D 8;
-		return index + 20 * n;
+		hashcpy(oid->hash, index + 20 * n);
 	}
+	return 0;
 }
=20
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
@@ -3555,13 +3560,13 @@ static int for_each_object_in_pack(struct packed_gi=
t *p, each_packed_object_fn c
 	int r =3D 0;
=20
 	for (i =3D 0; i < p->num_objects; i++) {
-		const unsigned char *sha1 =3D nth_packed_object_sha1(p, i);
+		struct object_id oid;
=20
-		if (!sha1)
+		if (nth_packed_object_oid(p, &oid, i))
 			return error("unable to get sha1 of object %u in %s",
 				     i, p->pack_name);
=20
-		r =3D cb(sha1, p, i, data);
+		r =3D cb(oid.hash, p, i, data);
 		if (r)
 			break;
 	}
diff --git a/sha1_name.c b/sha1_name.c
index f542dba..680b1b9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -140,18 +140,18 @@ static void unique_in_pack(int len,
 			   struct disambiguate_state *ds)
 {
 	uint32_t num, last, i, first =3D 0;
-	const unsigned char *current =3D NULL;
+	struct object_id current;
=20
 	open_pack_index(p);
 	num =3D p->num_objects;
 	last =3D num;
 	while (first < last) {
 		uint32_t mid =3D (first + last) / 2;
-		const unsigned char *current;
+		struct object_id current;
 		int cmp;
=20
-		current =3D nth_packed_object_sha1(p, mid);
-		cmp =3D hashcmp(bin_pfx, current);
+		nth_packed_object_oid(p, &current, mid);
+		cmp =3D hashcmp(bin_pfx, current.hash);
 		if (!cmp) {
 			first =3D mid;
 			break;
@@ -169,10 +169,10 @@ static void unique_in_pack(int len,
 	 * 0, 1 or more objects that actually match(es).
 	 */
 	for (i =3D first; i < num && !ds->ambiguous; i++) {
-		current =3D nth_packed_object_sha1(p, i);
-		if (!match_sha(len, bin_pfx, current))
+		nth_packed_object_oid(p, &current, i);
+		if (!match_sha(len, bin_pfx, current.hash))
 			break;
-		update_candidates(ds, current);
+		update_candidates(ds, current.hash);
 	}
 }
=20
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVcP5AAAoJEL9TXYEfUvaLi/cQAMj+T3WCy7E1+tO0PI/UknSc
xu632RqMuMms8vu5VVksIIje1KGUICpD/oxsaFSNXfL0pqoGdJsZycq9RjcgebNo
CFGT8Qfp51MK5FLCM0FQWiZezRU9v3QBiv5BGuy23MduD2l96VghNtdARt4v9eOq
umREcqMJnS1v4yieLao9loFTsvhpfmqModqPmROQr59t6zyeXY9wb0WlkB5bokNR
C/qjC6uUiqhb5XTuy4Hr6YUh9P5UTtpWArgZ0GdQA2C7IlLahIcYTl7b5EmcHFTd
gl64luXp1jbYjTMvqmLImr2rAsXGQuZQCoumyiyzu9LTQ+XUyvAKa/wFiDlx6/H8
dSs7scBnBwexsE7TFZuHba7u0BhwIXSCRdemhxPZdO5QJF7h/IYxdjTj57TPlnuS
1w8lo7ecbkAPqFSmLA6ORxJFtheKw54ll8pV3n1SD8QpfvrlYCjlWOyBwrHIp7p3
iqqCckMG8fgpA406f4cuFIy1ZQcjI+0NlCsPnbICbNY3WQxuaoPHiQ28OQRqiJ2s
TpkH4qq1UsGW42lBOvaZByh9pg7XxUVTdItdN1/hIaXk3ZpnBSxv037cYhr/Zei0
fV0Zlzc1crzsy3MFmQ0jhIfm3sAyIoZC1XPoHdpb4KqiByynyybG60wrPjWZVYh4
FQKANKyieI01H1qs3Ygv
=u6p0
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
