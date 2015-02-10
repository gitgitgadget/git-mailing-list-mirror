From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] index-pack: reduce memory footprint a bit
Date: Tue, 10 Feb 2015 16:30:41 +0700
Message-ID: <20150210093041.GA30992@lanh>
References: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
 <1423487929-28019-1-git-send-email-pclouds@gmail.com>
 <xmqqfvaec2cm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msporleder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 10:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YL79b-0004T4-69
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 10:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbbBJJai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2015 04:30:38 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:46678 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbbBJJac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 04:30:32 -0500
Received: by pdjy10 with SMTP id y10so7268590pdj.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 01:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zIOvxcHPEndM8WZxFQhJ8YtVDjQifX6TqydGZfN2TKw=;
        b=woa7yxfEdhvJCcPLaiFfIFUn8p8sLZNF8MrzFoG4JGlkDvWROvLIo4x99np8skngIA
         yPLygoIrIbtycvElKyFLxj8f1VHSSgQ13LyUyjojZDhtUf8pSdc/1XGQZ3bgv3dQ+oph
         UAoyVpCKHlmwOdm8p8L2rk1X+RQCjwPH0HJMx/WdXhiToBAQAJnoJ+W5LsQEdVfkhjX3
         LFjbmTaAjgqsqCcmvIhqkrY53MsJdgzkC5GUWRnWHwSOvIp1E1vKHQQVFk5oHIcWfyda
         +lOHqzCEhWkvb+QE9g57YNbCneSRvSfeMBFT7QfeAAjb/bJY8fQXqyGmtX+Ta047vkMp
         NuZA==
X-Received: by 10.66.192.194 with SMTP id hi2mr3721952pac.57.1423560632036;
        Tue, 10 Feb 2015 01:30:32 -0800 (PST)
Received: from lanh ([115.73.221.27])
        by mx.google.com with ESMTPSA id hh2sm18885594pac.32.2015.02.10.01.30.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 01:30:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Feb 2015 16:30:41 +0700
Content-Disposition: inline
In-Reply-To: <xmqqfvaec2cm.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263626>

On Mon, Feb 09, 2015 at 11:27:21AM -0800, Junio C Hamano wrote:
> > On a 3.4M object repo that's about 53MB. The saving is less impress=
ive
> > compared to index-pack total memory use (about 400MB before delta
> > resolving, so the saving is just 13%)
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
> > ---
> >  I'm not sure if this patch is worth pursuing. It makes the code a
> >  little bit harder to read. I was just wondering how much memory co=
uld
> >  be saved..

(text reordered)

> I do not find the result all that harder to read.  I however think
> that the change would make it a lot harder to maintain, especially
> because the name "object-entry-extra" does not have any direct link
> to "show-stat" to hint us that this must be allocated when show-stat
> is in use and must never be looked at when show-stat is not in use.

Noted. To be fixed.

> I would say 13% is already impressive ;-).

The second patch makes the total saving 119MB, close to 30% (again on
x86-64, 32-bit platform number may be different). If we only compare
with the size of objects[] and deltas[], the saving percentage is 37%
(only for clone case) for this repo. Now it looks impressive to me :-D

The patch is larger than the previous one, but not really complex. And
the final index-pack.c is not hard to read either, probably becase we
already handle ofs-delta and ref-delta separately.

-- 8< --
Subject: [PATCH 2/2] index-pack: kill union delta_base to save memory

Once we know the number of objects in the input pack, we allocate an
array of nr_objects of struct delta_entry. On x86-64, this struct is
32 bytes long. The union delta_base, which is part of struct
delta_entry, provides enough space to store either ofs-delta (8 bytes)
or ref-delta (20 bytes).

Notice that with "recent" Git versions, ofs-delta objects are
preferred over ref-delta objects and ref-delta objects have no reason
to be present in a clone pack. So in clone case we waste
(20-8) * nr_objects bytes because of this union. That's about 38MB out
of 100MB for deltas[] with 3.4M objects, or 38%. deltas[] would be
around 62MB without the waste.

This patch attempts to eliminate that. deltas[] array is split into
two: one for ofs-delta and one for ref-delta. Many functions are also
duplicated because of this split. With this patch, ofs_delta_entry[]
array takes 38MB. ref_deltas[] should remain unallocated in clone case
(0 bytes). This array grows as we see ref-delta. We save more than
half in clone case, or 25% of total book keeping.

The saving is more than the calculation above because padding is
removed by __attribute__((packed)) on ofs_delta_entry. This attribute
should be ok to use, as we used to have it in our code base for some
time. The last use was removed because it may lead to incorrect
behavior when the struct is not packed, which is not the case in
index-pack.

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
index 07b2c0c..27e3c8b 100644
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
+} __attribute__((packed));
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
+{
+	int cmp =3D type1 - type2;
+	if (cmp)
+		return cmp;
+	return offset1 - offset2;
+}
+
+static int find_ofs_delta(const off_t offset, enum object_type type)
+{
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
+}
+
+static void find_ofs_delta_children(off_t offset,
+				    int *first_index, int *last_index,
+				    enum object_type type)
+{
+	int first =3D find_ofs_delta(offset, type);
+	int last =3D first;
+	int end =3D nr_ofs_deltas - 1;
+
+	if (first < 0) {
+		*first_index =3D 0;
+		*last_index =3D -1;
+		return;
+	}
+	while (first > 0 && ofs_deltas[first - 1].offset =3D=3D offset)
+		--first;
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
 {
 	int cmp =3D type1 - type2;
 	if (cmp)
 		return cmp;
-	return memcmp(base1, base2, UNION_BASE_SZ);
+	return hashcmp(sha1, sha2);
 }
=20
-static int find_delta(const union delta_base *base, enum object_type t=
ype)
+static int find_ref_delta(const unsigned char *sha1, enum object_type =
type)
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
 }
=20
-static void find_delta_children(const union delta_base *base,
-				int *first_index, int *last_index,
-				enum object_type type)
+static void find_ref_delta_children(const unsigned char *sha1,
+				    int *first_index, int *last_index,
+				    enum object_type type)
 {
-	int first =3D find_delta(base, type);
+	int first =3D find_ref_delta(sha1, type);
 	int last =3D first;
-	int end =3D nr_deltas - 1;
+	int end =3D nr_ref_deltas - 1;
=20
 	if (first < 0) {
 		*first_index =3D 0;
 		*last_index =3D -1;
 		return;
 	}
-	while (first > 0 && !memcmp(&deltas[first - 1].base, base, UNION_BASE=
_SZ))
+	while (first > 0 && !hashcmp(ref_deltas[first - 1].sha1, sha1))
 		--first;
-	while (last < end && !memcmp(&deltas[last + 1].base, base, UNION_BASE=
_SZ))
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
2.2.0.513.g477eb31

-- 8< --
