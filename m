From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] index-pack: produce pack index version 3
Date: Sun, 12 Aug 2012 19:01:29 +0700
Message-ID: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 14:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Wsd-0003zG-Pg
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 14:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab2HLMCq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Aug 2012 08:02:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37943 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab2HLMCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 08:02:44 -0400
Received: by pbbrr13 with SMTP id rr13so5574397pbb.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=JpZ0H4SmgVYOQqvtynmM6zJWn4nKhOOiHPAGgIF5wj0=;
        b=IFl4i7LuIn9243Fw3La+xi0EY5wShZnlci2d1M2TcrfAZcjaL+l2NLrjHapInyxcrW
         HMo/m5xjHyH8hFIaXNNtEufUZH/39LvvopsBdiGWUgzeUMZAUsQmiAmVIVM6WHbPvy2P
         Xg/hZkAROg7V8zvHASTzu9U0fLRGcLzsAaAB8dLbcIwTxYpKZMPAhO4AWZPu3l7+O3A2
         EptsBiBv5QXal3OsRdxPGwSGumkW5Gz1PiwVMhO57irCkKYedobkQYyxtoYcfPSQ+529
         PS14aspybBmuV+dV6OoLlhyfKQObx1OOAjCwSduWHgwhBv/sPGoHtQTwPrylLMabv7gn
         xiYg==
Received: by 10.68.222.136 with SMTP id qm8mr26823627pbc.116.1344772964142;
        Sun, 12 Aug 2012 05:02:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.147])
        by mx.google.com with ESMTPS id ro7sm3227619pbc.8.2012.08.12.05.02.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 05:02:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 12 Aug 2012 19:01:30 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203308>

The sha-1->offset table in v3 is sorted by object type first, then
sha-1 (as opposed to sorted by sha-1 only in v2). There are four
fan-out tables, one for each object type. So to look for the offset of
an object, we first locate the fan-out table based on object type,
then do binary search in that region. If we don't know object type, we
may need to try all object types (which might be slower than now)

Long term we might gain slight lookup speedup if we know object type
as search region is made smaller. But for that to happen, we need to
propagate object type hint down to find_pack_entry_one() and friends.
Possible thing to do, I think.

The main reason to group objects by type is to make it possible to
create another sha1->something mapping for a particular object type,
without wasting space for storing sha-1 keys again. For example, we
can store commit caches, tree caches... at the end of the index as
extensions.

Note that this is just one of v3 changes. The format is not fixed yet.
The intent is allow extensions add the end of the index. Extensions
are not covered by the trailer sha-1 that covers the entire index v2,
so big extensions cannot impact normal operations until they are used.
Extensions have their own sha-1 trailers.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Not compilable as it requires a couple other patches that I don't
 send. Just to get opinions on the format change. Shawn's connectivity
 bitmap cache or whatever cache can then be placed on this.

 builtin/index-pack.c |  8 ++++-
 pack-write.c         | 93 +++++++++++++++++++++++++++++++++++++++-----=
--------
 pack.h               |  1 +
 sha1_file.c          | 50 +++++++++++++++++++++-------
 4 files changed, 116 insertions(+), 36 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 68e2031..22c3cfa 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1574,7 +1574,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 			} else if (!prefixcmp(arg, "--index-version=3D")) {
 				char *c;
 				opts.version =3D strtoul(arg + 16, &c, 10);
-				if (opts.version > 2)
+				if (opts.version > 3)
 					die(_("bad %s"), arg);
 				if (*c =3D=3D ',')
 					opts.off32_limit =3D strtoul(c+1, &c, 0);
@@ -1650,6 +1650,12 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	for (i =3D 0; i < nr_objects; i++)
 		idx_objects[i] =3D &objects[i].idx;
 	opts.nr_objects =3D nr_objects;
+	if (opts.version >=3D 3) {
+		opts.nr_commits =3D nr_commits;
+		opts.nr_trees =3D nr_trees;
+		opts.nr_blobs =3D nr_blobs;
+		opts.nr_tags =3D nr_tags;
+	}
 	curr_index =3D write_idx_file(index_name, idx_objects, &opts, pack_sh=
a1);
 	free(idx_objects);
=20
diff --git a/pack-write.c b/pack-write.c
index 4643796..d4152b5 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -16,6 +16,15 @@ static int sha1_compare(const void *_a, const void *=
_b)
 	return hashcmp(a->sha1, b->sha1);
 }
=20
+static int type_sha1_compare(const void *_a, const void *_b)
+{
+	struct pack_idx_entry *a =3D *(struct pack_idx_entry **)_a;
+	struct pack_idx_entry *b =3D *(struct pack_idx_entry **)_b;
+
+	assert(OBJ_COMMIT < OBJ_TREE && OBJ_TREE < OBJ_BLOB && OBJ_BLOB < OBJ=
_TAG);
+	return a->type =3D=3D b->type ? hashcmp(a->sha1, b->sha1) : a->type -=
 b->type;
+}
+
 static int cmp_uint32(const void *a_, const void *b_)
 {
 	uint32_t a =3D *((uint32_t *)a_);
@@ -37,6 +46,32 @@ static int need_large_offset(off_t offset, const str=
uct pack_idx_option *opts)
 			 sizeof(ofsval), cmp_uint32);
 }
=20
+static void make_fanout_table(struct pack_idx_entry **sorted_by_sha,
+			      unsigned long start, unsigned long end,
+			      uint32_t *array)
+{
+	struct pack_idx_entry **list =3D sorted_by_sha + start;
+	struct pack_idx_entry **last =3D sorted_by_sha + end;
+	int i;
+
+	/*
+	 * Write the first-level table (the list is sorted,
+	 * but we use a 256-entry lookup to be able to avoid
+	 * having to do eight extra binary search iterations).
+	 */
+	for (i =3D 0; i < 256; i++) {
+		struct pack_idx_entry **next =3D list;
+		while (next < last) {
+			struct pack_idx_entry *obj =3D *next;
+			if (obj->sha1[0] !=3D i)
+				break;
+			next++;
+		}
+		array[i] =3D htonl(next - sorted_by_sha);
+		list =3D next;
+	}
+}
+
 /*
  * On entry *sha1 contains the pack content SHA1 hash, on exit it is
  * the SHA1 hash of sorted object names. The objects array passed in
@@ -47,27 +82,23 @@ const char *write_idx_file(const char *index_name, =
struct pack_idx_entry **objec
 			   unsigned char *sha1)
 {
 	struct sha1file *f;
-	struct pack_idx_entry **sorted_by_sha, **list, **last;
+	struct pack_idx_entry **sorted_by_sha =3D NULL, **list;
 	off_t last_obj_offset =3D 0;
 	uint32_t array[256];
 	int fd;
 	git_SHA_CTX ctx;
-	uint32_t index_version;
+	uint32_t index_version =3D opts->version;
 	unsigned long i, nr_objects =3D opts->nr_objects;
=20
 	if (nr_objects) {
 		sorted_by_sha =3D objects;
-		list =3D sorted_by_sha;
-		last =3D sorted_by_sha + nr_objects;
 		for (i =3D 0; i < nr_objects; ++i) {
 			if (objects[i]->offset > last_obj_offset)
 				last_obj_offset =3D objects[i]->offset;
 		}
 		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
-		      sha1_compare);
+		      opts->version >=3D 3 ? type_sha1_compare : sha1_compare);
 	}
-	else
-		sorted_by_sha =3D list =3D last =3D NULL;
=20
 	if (opts->flags & WRITE_IDX_VERIFY) {
 		assert(index_name);
@@ -87,7 +118,8 @@ const char *write_idx_file(const char *index_name, s=
truct pack_idx_entry **objec
 	}
=20
 	/* if last object's offset is >=3D 2^31 we should use index V2 */
-	index_version =3D need_large_offset(last_obj_offset, opts) ? 2 : opts=
->version;
+	if (opts->version <=3D 2 && need_large_offset(last_obj_offset, opts))
+		index_version =3D 2;
=20
 	/* index versions 2 and above need a header */
 	if (index_version >=3D 2) {
@@ -97,23 +129,38 @@ const char *write_idx_file(const char *index_name,=
 struct pack_idx_entry **objec
 		sha1write(f, &hdr, sizeof(hdr));
 	}
=20
-	/*
-	 * Write the first-level table (the list is sorted,
-	 * but we use a 256-entry lookup to be able to avoid
-	 * having to do eight extra binary search iterations).
-	 */
-	for (i =3D 0; i < 256; i++) {
-		struct pack_idx_entry **next =3D list;
-		while (next < last) {
-			struct pack_idx_entry *obj =3D *next;
-			if (obj->sha1[0] !=3D i)
-				break;
-			next++;
+	if (index_version >=3D 3) {
+		unsigned long ub[OBJ_MAX], lb[OBJ_MAX];
+		/* we heavily rely on the actual enum constants.. */
+		assert(OBJ_COMMIT + 1 =3D=3D OBJ_TREE &&
+		       OBJ_TREE   + 1 =3D=3D OBJ_BLOB &&
+		       OBJ_BLOB   + 1 =3D=3D OBJ_TAG);
+		lb[OBJ_COMMIT] =3D 0;
+		ub[OBJ_COMMIT] =3D opts->nr_commits;
+		lb[OBJ_TREE]   =3D ub[OBJ_COMMIT];
+		ub[OBJ_TREE]   =3D lb[OBJ_TREE] + opts->nr_trees;
+		lb[OBJ_BLOB]   =3D ub[OBJ_TREE];
+		ub[OBJ_BLOB]   =3D lb[OBJ_BLOB] + opts->nr_blobs;
+		lb[OBJ_TAG]    =3D ub[OBJ_BLOB];
+		ub[OBJ_TAG]    =3D lb[OBJ_TAG]  + opts->nr_tags;
+
+		/* make sure nr_{commits,trees,objects,tags} match */
+		for (i =3D OBJ_COMMIT; i <=3D OBJ_TAG; i++)
+			if (ub[i] > lb[i] &&
+			    (objects[lb[i]]->type !=3D i ||
+			     objects[ub[i]-1]->type !=3D i))
+				die(_("expected to have %lu %s, but not so"),
+				    ub[i] - lb[i], typename(i));
+
+		/* v3 has four fanout tables instead of one */
+		for (i =3D OBJ_COMMIT; i <=3D OBJ_TAG; i++) {
+			make_fanout_table(sorted_by_sha, lb[i], ub[i], array);
+			sha1write(f, array, 256 * 4);
 		}
-		array[i] =3D htonl(next - sorted_by_sha);
-		list =3D next;
+	} else {
+		make_fanout_table(sorted_by_sha, 0, opts->nr_objects, array);
+		sha1write(f, array, 256 * 4);
 	}
-	sha1write(f, array, 256 * 4);
=20
 	/* compute the SHA1 hash of sorted object names. */
 	git_SHA1_Init(&ctx);
diff --git a/pack.h b/pack.h
index f94e6c4..1a26f65 100644
--- a/pack.h
+++ b/pack.h
@@ -45,6 +45,7 @@ struct pack_idx_option {
 	uint32_t off32_limit;
=20
 	unsigned long nr_objects;
+	unsigned long nr_commits, nr_trees, nr_tags, nr_blobs;
=20
 	/*
 	 * List of offsets that would fit within off32_limit but
diff --git a/sha1_file.c b/sha1_file.c
index af5cfbd..66cc38a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -480,7 +480,7 @@ static int check_packed_git_idx(const char *path,  =
struct packed_git *p)
 	void *idx_map;
 	struct pack_idx_header *hdr;
 	size_t idx_size;
-	uint32_t version, nr, i, *index;
+	uint32_t version, nr, i, *index, nr_fanout;
 	int fd =3D git_open_noatime(path);
 	struct stat st;
=20
@@ -501,7 +501,7 @@ static int check_packed_git_idx(const char *path,  =
struct packed_git *p)
 	hdr =3D idx_map;
 	if (hdr->idx_signature =3D=3D htonl(PACK_IDX_SIGNATURE)) {
 		version =3D ntohl(hdr->idx_version);
-		if (version < 2 || version > 2) {
+		if (version < 2 || version > 3) {
 			munmap(idx_map, idx_size);
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
@@ -515,7 +515,8 @@ static int check_packed_git_idx(const char *path,  =
struct packed_git *p)
 	index =3D idx_map;
 	if (version > 1)
 		index +=3D 2;  /* skip index header */
-	for (i =3D 0; i < 256; i++) {
+	nr_fanout =3D version <=3D 2 ? 256 : 4 * 256;
+	for (i =3D 0; i < nr_fanout; i++) {
 		uint32_t n =3D ntohl(index[i]);
 		if (n < nr) {
 			munmap(idx_map, idx_size);
@@ -536,11 +537,11 @@ static int check_packed_git_idx(const char *path,=
  struct packed_git *p)
 			munmap(idx_map, idx_size);
 			return error("wrong index v1 file size in %s", path);
 		}
-	} else if (version =3D=3D 2) {
+	} else if (version =3D=3D 2 || version =3D=3D 3) {
 		/*
 		 * Minimum size:
 		 *  - 8 bytes of header
-		 *  - 256 index entries 4 bytes each
+		 *  - 256 index entries 4 bytes each (1024 entries in v3)
 		 *  - 20-byte sha1 entry * nr
 		 *  - 4-byte crc entry * nr
 		 *  - 4-byte offset entry * nr
@@ -552,6 +553,8 @@ static int check_packed_git_idx(const char *path,  =
struct packed_git *p)
 		 */
 		unsigned long min_size =3D 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
 		unsigned long max_size =3D min_size;
+		if (version =3D=3D 3)
+			min_size +=3D 3 * 4*256;
 		if (nr)
 			max_size +=3D (nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size) {
@@ -1945,7 +1948,7 @@ const unsigned char *nth_packed_object_sha1(struc=
t packed_git *p,
 	}
 	if (n >=3D p->num_objects)
 		return NULL;
-	index +=3D 4 * 256;
+	index +=3D p->index_version >=3D 3 ? 4 * 4 * 256 : 4 * 256;
 	if (p->index_version =3D=3D 1) {
 		return index + 24 * n + 4;
 	} else {
@@ -1957,7 +1960,7 @@ const unsigned char *nth_packed_object_sha1(struc=
t packed_git *p,
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index =3D p->index_data;
-	index +=3D 4 * 256;
+	index +=3D p->index_version >=3D 3 ? 4 * 4 * 256 : 4 * 256;
 	if (p->index_version =3D=3D 1) {
 		return ntohl(*((uint32_t *)(index + 24 * n)));
 	} else {
@@ -1972,8 +1975,9 @@ off_t nth_packed_object_offset(const struct packe=
d_git *p, uint32_t n)
 	}
 }
=20
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+static off_t find_pack_entry_one_by_type(const unsigned char *sha1,
+					 struct packed_git *p,
+					 enum object_type type)
 {
 	const uint32_t *level1_ofs =3D p->index_data;
 	const unsigned char *index =3D p->index_data;
@@ -1994,9 +1998,19 @@ off_t find_pack_entry_one(const unsigned char *s=
ha1,
 		level1_ofs +=3D 2;
 		index +=3D 8;
 	}
-	index +=3D 4 * 256;
-	hi =3D ntohl(level1_ofs[*sha1]);
-	lo =3D ((*sha1 =3D=3D 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	if (p->index_version > 2) {
+		level1_ofs +=3D (type - OBJ_COMMIT) * 256;
+		index +=3D 4 * 4 * 256;
+		hi =3D ntohl(level1_ofs[*sha1]);
+		if (*sha1 =3D=3D 0)
+			lo =3D type =3D=3D OBJ_COMMIT ? 0 : ntohl(level1_ofs[-1]);
+		else
+			lo =3D ntohl(level1_ofs[*sha1 - 1]);
+	} else {
+		index +=3D 4 * 256;
+		hi =3D ntohl(level1_ofs[*sha1]);
+		lo =3D ((*sha1 =3D=3D 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	}
 	if (p->index_version > 1) {
 		stride =3D 20;
 	} else {
@@ -2035,6 +2049,18 @@ off_t find_pack_entry_one(const unsigned char *s=
ha1,
 	return 0;
 }
=20
+off_t find_pack_entry_one(const unsigned char *sha1,
+				  struct packed_git *p)
+{
+	off_t off;
+	if ((off =3D find_pack_entry_one_by_type(sha1, p, OBJ_COMMIT)) !=3D 0=
 ||
+	    (off =3D find_pack_entry_one_by_type(sha1, p, OBJ_TREE)) !=3D 0 |=
|
+	    (off =3D find_pack_entry_one_by_type(sha1, p, OBJ_BLOB)) !=3D 0 |=
|
+	    (off =3D find_pack_entry_one_by_type(sha1, p, OBJ_TAG)) !=3D 0)
+		return off;
+	return 0;
+}
+
 int is_pack_valid(struct packed_git *p)
 {
 	/* An already open pack is known to be valid. */
--=20
1.7.12.rc2.18.g61b472e
