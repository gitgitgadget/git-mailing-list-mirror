From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] index-pack: kill union delta_base to save memory
Date: Thu, 26 Feb 2015 17:52:08 +0700
Message-ID: <1424947928-19396-3-git-send-email-pclouds@gmail.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
 <1424947928-19396-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, msporleder@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 11:52:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQw3B-0004Xv-Oj
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 11:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbbBZKwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2015 05:52:08 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40327 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbbBZKwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 05:52:06 -0500
Received: by paceu11 with SMTP id eu11so13091963pac.7
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tGNrm+trqB5jr90YGWfEP2Mi0rcFUZy9SR+KbMLMHd4=;
        b=UMFkaMhbhgIg9stbkZx2UTbCGXNZ9DbNYH/VYx/AmFl0eyz7K/HoQ1xTDqan+bN4vw
         JgNMgpKE9huurTlTNGlyFfP/26Ze2N2TfFxxxnlPIlFTSqT5TRZdW1NvLSpGVw9THQJW
         8vIMA3Ro4LMIMOodt+XSJzwSWLyCwfav8/RGPeuTxeMLwoKOr67/ijuygWZ8EZuOcEfs
         /JfIkE+nkT70yCkJOGkRI8dKxHwyQzEyND9yVWQs2ng7/Bq1Nc4WZ/VIXrunNv/5e8ZY
         c6go/os2Nl/HQaUjAWtC8TAXfaswu4/eis2FM7p13RadNymY0kSzp4wcN6PSWoGJwmIJ
         0DgQ==
X-Received: by 10.68.205.227 with SMTP id lj3mr13576731pbc.143.1424947926512;
        Thu, 26 Feb 2015 02:52:06 -0800 (PST)
Received: from lanh ([115.73.213.171])
        by mx.google.com with ESMTPSA id dr5sm627184pdb.48.2015.02.26.02.52.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 02:52:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 26 Feb 2015 17:52:30 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1424947928-19396-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264431>

Once we know the number of objects in the input pack, we allocate an
array of nr_objects of struct delta_entry. On x86-64, this struct is
32 bytes long. The union delta_base, which is part of struct
delta_entry, provides enough space to store either ofs-delta (8 bytes)
or ref-delta (20 bytes).

Notice that with "recent" Git versions, ofs-delta objects are
preferred over ref-delta objects and ref-delta objects have no reason
to be present in a clone pack. So in clone case we waste (20-8) *
nr_objects bytes because of this union. That's about 38MB out of 100MB
for deltas[] with 3.4M objects, or 38%. deltas[] would be around 62MB
without the waste.

This patch attempts to eliminate that. deltas[] array is split into
two: one for ofs-delta and one for ref-delta. Many functions are also
duplicated because of this split. With this patch, ofs_deltas[] array
takes 51MB. ref_deltas[] should remain unallocated in clone case (0
bytes). This array grows as we see ref-delta. We save about half in
clone case, or 25% of total bookkeeping.

The saving is more than the calculation above because some padding in
the old delta_entry struct is removed. ofs_delta_entry is 16 bytes,
including the 4 bytes padding. That's 13MB for padding, but packing
the struct could break platforms that do not support unaligned
access. If someone on 32-bit is really low on memory and only deals
with packs smaller than 2G, using 32-bit off_t would eliminate the
padding and save 27MB on top.

A note about ofs_deltas allocation. We could use ref_deltas memory
allocation strategy for ofs_deltas. But that probably just adds more
overhead on top. ofs-deltas are generally the majority (1/2 to 2/3) in
any pack. Incremental realloc may lead to too many memcpy. And if we
preallocate, say 1/2 or 2/3 of nr_objects initially, the growth rate
of ALLOC_GROW() could make this array larger than nr_objects, wasting
more memory.

Brought-up-by: Matthew Sporleder <msporleder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 260 +++++++++++++++++++++++++++++++------------=
--------
 1 file changed, 160 insertions(+), 100 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9d854fb..3ed53e3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -28,11 +28,6 @@ struct object_stat {
 	int base_object_no;
 };
=20
-union delta_base {
-	unsigned char sha1[20];
-	off_t offset;
-};
-
 struct base_data {
 	struct base_data *base;
 	struct base_data *child;
@@ -52,26 +47,28 @@ struct thread_local {
 	int pack_fd;
 };
=20
-/*
- * Even if sizeof(union delta_base) =3D=3D 24 on 64-bit archs, we real=
ly want
- * to memcmp() only the first 20 bytes.
- */
-#define UNION_BASE_SZ	20
-
 #define FLAG_LINK (1u<<20)
 #define FLAG_CHECKED (1u<<21)
=20
-struct delta_entry {
-	union delta_base base;
+struct ofs_delta_entry {
+	off_t offset;
+	int obj_no;
+};
+
+struct ref_delta_entry {
+	unsigned char sha1[20];
 	int obj_no;
 };
=20
 static struct object_entry *objects;
 static struct object_stat *obj_stat;
-static struct delta_entry *deltas;
+static struct ofs_delta_entry *ofs_deltas;
+static struct ref_delta_entry *ref_deltas;
 static struct thread_local nothread_data;
 static int nr_objects;
-static int nr_deltas;
+static int nr_ofs_deltas;
+static int nr_ref_deltas;
+static int ref_deltas_alloc;
 static int nr_resolved_deltas;
 static int nr_threads;
=20
@@ -480,7 +477,8 @@ static void *unpack_entry_data(unsigned long offset=
, unsigned long size,
 }
=20
 static void *unpack_raw_entry(struct object_entry *obj,
-			      union delta_base *delta_base,
+			      off_t *ofs_offset,
+			      unsigned char *ref_sha1,
 			      unsigned char *sha1)
 {
 	unsigned char *p;
@@ -509,11 +507,10 @@ static void *unpack_raw_entry(struct object_entry=
 *obj,
=20
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		hashcpy(delta_base->sha1, fill(20));
+		hashcpy(ref_sha1, fill(20));
 		use(20);
 		break;
 	case OBJ_OFS_DELTA:
-		memset(delta_base, 0, sizeof(*delta_base));
 		p =3D fill(1);
 		c =3D *p;
 		use(1);
@@ -527,8 +524,8 @@ static void *unpack_raw_entry(struct object_entry *=
obj,
 			use(1);
 			base_offset =3D (base_offset << 7) + (c & 127);
 		}
-		delta_base->offset =3D obj->idx.offset - base_offset;
-		if (delta_base->offset <=3D 0 || delta_base->offset >=3D obj->idx.of=
fset)
+		*ofs_offset =3D obj->idx.offset - base_offset;
+		if (*ofs_offset <=3D 0 || *ofs_offset >=3D obj->idx.offset)
 			bad_object(obj->idx.offset, _("delta base offset is out of bound"))=
;
 		break;
 	case OBJ_COMMIT:
@@ -612,55 +609,108 @@ static void *get_data_from_pack(struct object_en=
try *obj)
 	return unpack_data(obj, NULL, NULL);
 }
=20
-static int compare_delta_bases(const union delta_base *base1,
-			       const union delta_base *base2,
-			       enum object_type type1,
-			       enum object_type type2)
+static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
+				   enum object_type type1,
+				   enum object_type type2)
 {
 	int cmp =3D type1 - type2;
 	if (cmp)
 		return cmp;
-	return memcmp(base1, base2, UNION_BASE_SZ);
+	return offset1 - offset2;
 }
=20
-static int find_delta(const union delta_base *base, enum object_type t=
ype)
+static int find_ofs_delta(const off_t offset, enum object_type type)
 {
-	int first =3D 0, last =3D nr_deltas;
-
-        while (first < last) {
-                int next =3D (first + last) / 2;
-                struct delta_entry *delta =3D &deltas[next];
-                int cmp;
-
-		cmp =3D compare_delta_bases(base, &delta->base,
-					  type, objects[delta->obj_no].type);
-                if (!cmp)
-                        return next;
-                if (cmp < 0) {
-                        last =3D next;
-                        continue;
-                }
-                first =3D next+1;
-        }
-        return -first-1;
+	int first =3D 0, last =3D nr_ofs_deltas;
+
+	while (first < last) {
+		int next =3D (first + last) / 2;
+		struct ofs_delta_entry *delta =3D &ofs_deltas[next];
+		int cmp;
+
+		cmp =3D compare_ofs_delta_bases(offset, delta->offset,
+					      type, objects[delta->obj_no].type);
+		if (!cmp)
+			return next;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+	return -first-1;
 }
=20
-static void find_delta_children(const union delta_base *base,
-				int *first_index, int *last_index,
-				enum object_type type)
+static void find_ofs_delta_children(off_t offset,
+				    int *first_index, int *last_index,
+				    enum object_type type)
 {
-	int first =3D find_delta(base, type);
+	int first =3D find_ofs_delta(offset, type);
 	int last =3D first;
-	int end =3D nr_deltas - 1;
+	int end =3D nr_ofs_deltas - 1;
=20
 	if (first < 0) {
 		*first_index =3D 0;
 		*last_index =3D -1;
 		return;
 	}
-	while (first > 0 && !memcmp(&deltas[first - 1].base, base, UNION_BASE=
_SZ))
+	while (first > 0 && ofs_deltas[first - 1].offset =3D=3D offset)
 		--first;
-	while (last < end && !memcmp(&deltas[last + 1].base, base, UNION_BASE=
_SZ))
+	while (last < end && ofs_deltas[last + 1].offset =3D=3D offset)
+		++last;
+	*first_index =3D first;
+	*last_index =3D last;
+}
+
+static int compare_ref_delta_bases(const unsigned char *sha1,
+				   const unsigned char *sha2,
+				   enum object_type type1,
+				   enum object_type type2)
+{
+	int cmp =3D type1 - type2;
+	if (cmp)
+		return cmp;
+	return hashcmp(sha1, sha2);
+}
+
+static int find_ref_delta(const unsigned char *sha1, enum object_type =
type)
+{
+	int first =3D 0, last =3D nr_ref_deltas;
+
+	while (first < last) {
+		int next =3D (first + last) / 2;
+		struct ref_delta_entry *delta =3D &ref_deltas[next];
+		int cmp;
+
+		cmp =3D compare_ref_delta_bases(sha1, delta->sha1,
+					      type, objects[delta->obj_no].type);
+		if (!cmp)
+			return next;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+	return -first-1;
+}
+
+static void find_ref_delta_children(const unsigned char *sha1,
+				    int *first_index, int *last_index,
+				    enum object_type type)
+{
+	int first =3D find_ref_delta(sha1, type);
+	int last =3D first;
+	int end =3D nr_ref_deltas - 1;
+
+	if (first < 0) {
+		*first_index =3D 0;
+		*last_index =3D -1;
+		return;
+	}
+	while (first > 0 && !hashcmp(ref_deltas[first - 1].sha1, sha1))
+		--first;
+	while (last < end && !hashcmp(ref_deltas[last + 1].sha1, sha1))
 		++last;
 	*first_index =3D first;
 	*last_index =3D last;
@@ -927,16 +977,13 @@ static struct base_data *find_unresolved_deltas_1=
(struct base_data *base,
 						  struct base_data *prev_base)
 {
 	if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
-		union delta_base base_spec;
-
-		hashcpy(base_spec.sha1, base->obj->idx.sha1);
-		find_delta_children(&base_spec,
-				    &base->ref_first, &base->ref_last, OBJ_REF_DELTA);
+		find_ref_delta_children(base->obj->idx.sha1,
+					&base->ref_first, &base->ref_last,
+					OBJ_REF_DELTA);
=20
-		memset(&base_spec, 0, sizeof(base_spec));
-		base_spec.offset =3D base->obj->idx.offset;
-		find_delta_children(&base_spec,
-				    &base->ofs_first, &base->ofs_last, OBJ_OFS_DELTA);
+		find_ofs_delta_children(base->obj->idx.offset,
+					&base->ofs_first, &base->ofs_last,
+					OBJ_OFS_DELTA);
=20
 		if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
 			free(base->data);
@@ -947,7 +994,7 @@ static struct base_data *find_unresolved_deltas_1(s=
truct base_data *base,
 	}
=20
 	if (base->ref_first <=3D base->ref_last) {
-		struct object_entry *child =3D objects + deltas[base->ref_first].obj=
_no;
+		struct object_entry *child =3D objects + ref_deltas[base->ref_first]=
=2Eobj_no;
 		struct base_data *result =3D alloc_base_data();
=20
 		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
@@ -963,7 +1010,7 @@ static struct base_data *find_unresolved_deltas_1(=
struct base_data *base,
 	}
=20
 	if (base->ofs_first <=3D base->ofs_last) {
-		struct object_entry *child =3D objects + deltas[base->ofs_first].obj=
_no;
+		struct object_entry *child =3D objects + ofs_deltas[base->ofs_first]=
=2Eobj_no;
 		struct base_data *result =3D alloc_base_data();
=20
 		assert(child->real_type =3D=3D OBJ_OFS_DELTA);
@@ -999,15 +1046,20 @@ static void find_unresolved_deltas(struct base_d=
ata *base)
 	}
 }
=20
-static int compare_delta_entry(const void *a, const void *b)
+static int compare_ofs_delta_entry(const void *a, const void *b)
+{
+	const struct ofs_delta_entry *delta_a =3D a;
+	const struct ofs_delta_entry *delta_b =3D b;
+
+	return delta_a->offset - delta_b->offset;
+}
+
+static int compare_ref_delta_entry(const void *a, const void *b)
 {
-	const struct delta_entry *delta_a =3D a;
-	const struct delta_entry *delta_b =3D b;
+	const struct ref_delta_entry *delta_a =3D a;
+	const struct ref_delta_entry *delta_b =3D b;
=20
-	/* group by type (ref vs ofs) and then by value (sha-1 or offset) */
-	return compare_delta_bases(&delta_a->base, &delta_b->base,
-				   objects[delta_a->obj_no].type,
-				   objects[delta_b->obj_no].type);
+	return hashcmp(delta_a->sha1, delta_b->sha1);
 }
=20
 static void resolve_base(struct object_entry *obj)
@@ -1053,7 +1105,8 @@ static void *threaded_second_pass(void *data)
 static void parse_pack_objects(unsigned char *sha1)
 {
 	int i, nr_delays =3D 0;
-	struct delta_entry *delta =3D deltas;
+	struct ofs_delta_entry *ofs_delta =3D ofs_deltas;
+	unsigned char ref_delta_sha1[20];
 	struct stat st;
=20
 	if (verbose)
@@ -1062,12 +1115,18 @@ static void parse_pack_objects(unsigned char *s=
ha1)
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		void *data =3D unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
+		void *data =3D unpack_raw_entry(obj, &ofs_delta->offset,
+					      ref_delta_sha1, obj->idx.sha1);
 		obj->real_type =3D obj->type;
-		if (is_delta_type(obj->type)) {
-			nr_deltas++;
-			delta->obj_no =3D i;
-			delta++;
+		if (obj->type =3D=3D OBJ_OFS_DELTA) {
+			nr_ofs_deltas++;
+			ofs_delta->obj_no =3D i;
+			ofs_delta++;
+		} else if (obj->type =3D=3D OBJ_REF_DELTA) {
+			ALLOC_GROW(ref_deltas, nr_ref_deltas + 1, ref_deltas_alloc);
+			hashcpy(ref_deltas[nr_ref_deltas].sha1, ref_delta_sha1);
+			ref_deltas[nr_ref_deltas].obj_no =3D i;
+			nr_ref_deltas++;
 		} else if (!data) {
 			/* large blobs, check later */
 			obj->real_type =3D OBJ_BAD;
@@ -1118,15 +1177,18 @@ static void resolve_deltas(void)
 {
 	int i;
=20
-	if (!nr_deltas)
+	if (!nr_ofs_deltas && !nr_ref_deltas)
 		return;
=20
 	/* Sort deltas by base SHA1/offset for fast searching */
-	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
-	      compare_delta_entry);
+	qsort(ofs_deltas, nr_ofs_deltas, sizeof(struct ofs_delta_entry),
+	      compare_ofs_delta_entry);
+	qsort(ref_deltas, nr_ref_deltas, sizeof(struct ref_delta_entry),
+	      compare_ref_delta_entry);
=20
 	if (verbose)
-		progress =3D start_progress(_("Resolving deltas"), nr_deltas);
+		progress =3D start_progress(_("Resolving deltas"),
+					  nr_ref_deltas + nr_ofs_deltas);
=20
 #ifndef NO_PTHREADS
 	nr_dispatched =3D 0;
@@ -1164,7 +1226,7 @@ static void resolve_deltas(void)
 static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolve=
d);
 static void conclude_pack(int fix_thin_pack, const char *curr_pack, un=
signed char *pack_sha1)
 {
-	if (nr_deltas =3D=3D nr_resolved_deltas) {
+	if (nr_ref_deltas + nr_ofs_deltas =3D=3D nr_resolved_deltas) {
 		stop_progress(&progress);
 		/* Flush remaining pack final 20-byte SHA1. */
 		flush();
@@ -1175,7 +1237,7 @@ static void conclude_pack(int fix_thin_pack, cons=
t char *curr_pack, unsigned cha
 		struct sha1file *f;
 		unsigned char read_sha1[20], tail_sha1[20];
 		struct strbuf msg =3D STRBUF_INIT;
-		int nr_unresolved =3D nr_deltas - nr_resolved_deltas;
+		int nr_unresolved =3D nr_ofs_deltas + nr_ref_deltas - nr_resolved_de=
ltas;
 		int nr_objects_initial =3D nr_objects;
 		if (nr_unresolved <=3D 0)
 			die(_("confusion beyond insanity"));
@@ -1197,11 +1259,11 @@ static void conclude_pack(int fix_thin_pack, co=
nst char *curr_pack, unsigned cha
 			die(_("Unexpected tail checksum for %s "
 			      "(disk corruption?)"), curr_pack);
 	}
-	if (nr_deltas !=3D nr_resolved_deltas)
+	if (nr_ofs_deltas + nr_ref_deltas !=3D nr_resolved_deltas)
 		die(Q_("pack has %d unresolved delta",
 		       "pack has %d unresolved deltas",
-		       nr_deltas - nr_resolved_deltas),
-		    nr_deltas - nr_resolved_deltas);
+		       nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas),
+		    nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas);
 }
=20
 static int write_compressed(struct sha1file *f, void *in, unsigned int=
 size)
@@ -1261,14 +1323,14 @@ static struct object_entry *append_obj_to_pack(=
struct sha1file *f,
=20
 static int delta_pos_compare(const void *_a, const void *_b)
 {
-	struct delta_entry *a =3D *(struct delta_entry **)_a;
-	struct delta_entry *b =3D *(struct delta_entry **)_b;
+	struct ref_delta_entry *a =3D *(struct ref_delta_entry **)_a;
+	struct ref_delta_entry *b =3D *(struct ref_delta_entry **)_b;
 	return a->obj_no - b->obj_no;
 }
=20
 static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolve=
d)
 {
-	struct delta_entry **sorted_by_pos;
+	struct ref_delta_entry **sorted_by_pos;
 	int i, n =3D 0;
=20
 	/*
@@ -1282,28 +1344,25 @@ static void fix_unresolved_deltas(struct sha1fi=
le *f, int nr_unresolved)
 	 * resolving deltas in the same order as their position in the pack.
 	 */
 	sorted_by_pos =3D xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
-	for (i =3D 0; i < nr_deltas; i++) {
-		if (objects[deltas[i].obj_no].real_type !=3D OBJ_REF_DELTA)
-			continue;
-		sorted_by_pos[n++] =3D &deltas[i];
-	}
+	for (i =3D 0; i < nr_ref_deltas; i++)
+		sorted_by_pos[n++] =3D &ref_deltas[i];
 	qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_compare);
=20
 	for (i =3D 0; i < n; i++) {
-		struct delta_entry *d =3D sorted_by_pos[i];
+		struct ref_delta_entry *d =3D sorted_by_pos[i];
 		enum object_type type;
 		struct base_data *base_obj =3D alloc_base_data();
=20
 		if (objects[d->obj_no].real_type !=3D OBJ_REF_DELTA)
 			continue;
-		base_obj->data =3D read_sha1_file(d->base.sha1, &type, &base_obj->si=
ze);
+		base_obj->data =3D read_sha1_file(d->sha1, &type, &base_obj->size);
 		if (!base_obj->data)
 			continue;
=20
-		if (check_sha1_signature(d->base.sha1, base_obj->data,
+		if (check_sha1_signature(d->sha1, base_obj->data,
 				base_obj->size, typename(type)))
-			die(_("local object %s is corrupt"), sha1_to_hex(d->base.sha1));
-		base_obj->obj =3D append_obj_to_pack(f, d->base.sha1,
+			die(_("local object %s is corrupt"), sha1_to_hex(d->sha1));
+		base_obj->obj =3D append_obj_to_pack(f, d->sha1,
 					base_obj->data, base_obj->size, type);
 		find_unresolved_deltas(base_obj);
 		display_progress(progress, nr_resolved_deltas);
@@ -1495,7 +1554,7 @@ static void read_idx_option(struct pack_idx_optio=
n *opts, const char *pack_name)
=20
 static void show_pack_info(int stat_only)
 {
-	int i, baseobjects =3D nr_objects - nr_deltas;
+	int i, baseobjects =3D nr_objects - nr_ref_deltas - nr_ofs_deltas;
 	unsigned long *chain_histogram =3D NULL;
=20
 	if (deepest_delta)
@@ -1680,11 +1739,12 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	if (show_stat)
 		obj_stat =3D xcalloc(nr_objects + 1, sizeof(struct object_stat));
-	deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
+	ofs_deltas =3D xcalloc(nr_objects, sizeof(struct ofs_delta_entry));
 	parse_pack_objects(pack_sha1);
 	resolve_deltas();
 	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
-	free(deltas);
+	free(ofs_deltas);
+	free(ref_deltas);
 	if (strict)
 		foreign_nr =3D check_objects();
=20
--=20
2.3.0.rc1.137.g477eb31
