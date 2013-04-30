From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/8] sha1_file: allow to select pack origin when looking up an object
Date: Tue, 30 Apr 2013 10:42:45 +0700
Message-ID: <1367293372-1958-2-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:42:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1SQ-0005if-9U
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617Ab3D3DmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:42:16 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:38252 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758543Ab3D3DmP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:42:15 -0400
Received: by mail-pb0-f41.google.com with SMTP id md4so52080pbc.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=65UvSpmgw64fXmsTHWYIvtWRCxBVsa9I3RssafSkEVI=;
        b=G4BhfKXGKbhayzWRAmhCS5FMnpsCQRD8t1SdcvFBq/+Cpm521S5wgv9a1Gcaw558xL
         TsHfS2RyLZDolAZG1SooGPN8bcx/CsR1xsJqOnhD1jIo8pZydfpBwHr1mBm4hYGYEv7J
         xhW6SJao6UlIcERUQXVSpwW5NdVRdjWnFDIQ9ZQ4UJsQ4sTu62XwCyxi5mZd0hMcRbND
         yiIU8x1uejTrWt2g6H8o9/ZMN0TwSQuJ4aeq1jLqgiAXj/+AlCX353IRyUbBrxjM6CUd
         8nuBZ+CCFbsQTyEywrQtZhkOCl8v7XE4fzDGjZvCRE48WwgSLfT2Q1k3IA/wJv/sx9AA
         yjDg==
X-Received: by 10.68.221.200 with SMTP id qg8mr73535419pbc.58.1367293334735;
        Mon, 29 Apr 2013 20:42:14 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id wi6sm26596890pbc.22.2013.04.29.20.42.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:42:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:43:03 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222895>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |  29 +++++++++--
 fast-import.c |   2 +-
 pack-check.c  |   2 +-
 sha1_file.c   | 165 +++++++++++++++++++++++++++++++++++++++-----------=
--------
 streaming.c   |   4 +-
 5 files changed, 141 insertions(+), 61 deletions(-)

diff --git a/cache.h b/cache.h
index 94ca1ac..bed403a 100644
--- a/cache.h
+++ b/cache.h
@@ -744,12 +744,33 @@ char *strip_path_suffix(const char *path, const c=
har *suffix);
 int daemon_avoid_alias(const char *path);
 int offset_1st_component(const char *path);
=20
+/*
+ * odb origin bit mask:
+ * - 8 low bits are for requested objects
+ * - 8 high bits are for their base objects
+ */
+#define ODB_LOCAL	1
+#define ODB_ALT		2
+#define ODB_CACHED	4
+/*
+ * This flag is used to track if the origin selection is from
+ * "odb_default" below. Not a real source, not to be passed to any
+ * function cals explicitly.
+ */
+#define ODB_DEFAULT	8
+
+extern unsigned int odb_default;
+
 /* object replacement */
 #define READ_SHA1_FILE_REPLACE 1
-extern void *read_sha1_file_extended(const unsigned char *sha1, enum o=
bject_type *type, unsigned long *size, unsigned flag);
+extern void *read_sha1_file_extended(const unsigned char *sha1,
+				     unsigned int origin,
+				     enum object_type *type,
+				     unsigned long *size,
+				     unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum obj=
ect_type *type, unsigned long *size)
 {
-	return read_sha1_file_extended(sha1, type, size, READ_SHA1_FILE_REPLA=
CE);
+	return read_sha1_file_extended(sha1, odb_default, type, size, READ_SH=
A1_FILE_REPLACE);
 }
 extern const unsigned char *do_lookup_replace_object(const unsigned ch=
ar *sha1);
 static inline const unsigned char *lookup_replace_object(const unsigne=
d char *sha1)
@@ -765,7 +786,7 @@ extern int hash_sha1_file(const void *buf, unsigned=
 long len, const char *type,
 extern int write_sha1_file(const void *buf, unsigned long len, const c=
har *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, =
unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime)=
;
-extern void *map_sha1_file(const unsigned char *sha1, unsigned long *s=
ize);
+extern void *map_sha1_file(const unsigned char *sha1, unsigned int, un=
signed long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map,=
 unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
=20
@@ -1091,7 +1112,7 @@ extern const unsigned char *nth_packed_object_sha=
1(struct packed_git *, uint32_t
 extern off_t nth_packed_object_offset(const struct packed_git *, uint3=
2_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_=
git *);
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type=
 *, unsigned long *);
+extern void *unpack_entry(struct packed_git *, unsigned int, off_t, en=
um object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *=
buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct p=
ack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_windo=
w **, off_t *, unsigned long *);
diff --git a/fast-import.c b/fast-import.c
index 5f539d7..8542786 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1303,7 +1303,7 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size =3D pack_size + 20;
 	}
-	return unpack_entry(p, oe->idx.offset, &type, sizep);
+	return unpack_entry(p, odb_default, oe->idx.offset, &type, sizep);
 }
=20
 static const char *get_mode(const char *str, uint16_t *modep)
diff --git a/pack-check.c b/pack-check.c
index 63a595c..981dc98 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -116,7 +116,7 @@ static int verify_packfile(struct packed_git *p,
 					    sha1_to_hex(entries[i].sha1),
 					    p->pack_name, (uintmax_t)offset);
 		}
-		data =3D unpack_entry(p, entries[i].offset, &type, &size);
+		data =3D unpack_entry(p, odb_default, entries[i].offset, &type, &siz=
e);
 		if (!data)
 			err =3D error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    sha1_to_hex(entries[i].sha1), p->pack_name,
diff --git a/sha1_file.c b/sha1_file.c
index 99ead7c..d1f44c9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -37,6 +37,12 @@ static inline uintmax_t sz_fmt(size_t s) { return s;=
 }
 const unsigned char null_sha1[20];
=20
 /*
+ * clear_delta_base_cache() may be needed if odb_default is changed to
+ * a narrower origin set.
+ */
+unsigned int odb_default =3D ODB_DEFAULT | ODB_LOCAL | ODB_ALT | ODB_C=
ACHED;
+
+/*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
  * to write them into the object store (e.g. a browse-only
@@ -59,11 +65,15 @@ static struct cached_object empty_tree =3D {
=20
 static struct packed_git *last_found_pack;
=20
-static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
+static struct cached_object *find_cached_object(const unsigned char *s=
ha1,
+						unsigned int origin)
 {
 	int i;
 	struct cached_object *co =3D cached_objects;
=20
+	if (!(origin & ODB_CACHED))
+		return NULL;
+
 	for (i =3D 0; i < cached_object_nr; i++, co++) {
 		if (!hashcmp(co->sha1, sha1))
 			return co;
@@ -404,6 +414,12 @@ void foreach_alt_odb(alt_odb_fn fn, void *cb)
 			return;
 }
=20
+static inline int match_origin(unsigned int origin, int pack_local)
+{
+	return (pack_local && (origin & ODB_LOCAL)) ||
+		(!pack_local && (origin & ODB_ALT));
+}
+
 void prepare_alt_odb(void)
 {
 	const char *alt;
@@ -420,28 +436,31 @@ void prepare_alt_odb(void)
 	read_info_alternates(get_object_directory(), 0);
 }
=20
-static int has_loose_object_local(const unsigned char *sha1)
+static int has_loose_object_extended(const unsigned char *sha1,
+				     unsigned int origin)
 {
-	char *name =3D sha1_file_name(sha1);
-	return !access(name, F_OK);
-}
-
-int has_loose_object_nonlocal(const unsigned char *sha1)
-{
-	struct alternate_object_database *alt;
-	prepare_alt_odb();
-	for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
-		fill_sha1_path(alt->name, sha1);
-		if (!access(alt->base, F_OK))
+	if (origin & ODB_LOCAL) {
+		char *name =3D sha1_file_name(sha1);
+		if (!access(name, F_OK))
 			return 1;
 	}
+
+	if (origin & ODB_ALT) {
+		struct alternate_object_database *alt;
+		prepare_alt_odb();
+		for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
+			fill_sha1_path(alt->name, sha1);
+			if (!access(alt->base, F_OK))
+				return 1;
+		}
+	}
 	return 0;
 }
=20
-static int has_loose_object(const unsigned char *sha1)
+int has_loose_object_nonlocal(const unsigned char *sha1)
 {
-	return has_loose_object_local(sha1) ||
-	       has_loose_object_nonlocal(sha1);
+	unsigned int origin =3D ODB_ALT;
+	return has_loose_object_extended(sha1, origin);
 }
=20
 static unsigned int pack_used_ctr;
@@ -1303,16 +1322,21 @@ static int git_open_noatime(const char *name)
 	}
 }
=20
-static int open_sha1_file(const unsigned char *sha1)
+static int open_sha1_file(const unsigned char *sha1, unsigned int orig=
in)
 {
 	int fd;
 	char *name =3D sha1_file_name(sha1);
 	struct alternate_object_database *alt;
=20
-	fd =3D git_open_noatime(name);
-	if (fd >=3D 0)
+	if ((origin & ODB_LOCAL) &&
+	    (fd =3D git_open_noatime(name)) >=3D 0)
 		return fd;
=20
+	if (!(origin & ODB_ALT)) {
+		errno =3D ENOENT;
+		return -1;
+	}
+
 	prepare_alt_odb();
 	errno =3D ENOENT;
 	for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
@@ -1325,12 +1349,14 @@ static int open_sha1_file(const unsigned char *=
sha1)
 	return -1;
 }
=20
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(const unsigned char *sha1,
+		    unsigned int origin,
+		    unsigned long *size)
 {
 	void *map;
 	int fd;
=20
-	fd =3D open_sha1_file(sha1);
+	fd =3D open_sha1_file(sha1, origin);
 	map =3D NULL;
 	if (fd >=3D 0) {
 		struct stat st;
@@ -1872,7 +1898,8 @@ static void clear_delta_base_cache_entry(struct d=
elta_base_cache_entry *ent)
 	delta_base_cached -=3D ent->size;
 }
=20
-static void *cache_or_unpack_entry(struct packed_git *p, off_t base_of=
fset,
+static void *cache_or_unpack_entry(struct packed_git *p,
+				   unsigned int origin, off_t base_offset,
 	unsigned long *base_size, enum object_type *type, int keep_cache)
 {
 	struct delta_base_cache_entry *ent;
@@ -1880,8 +1907,9 @@ static void *cache_or_unpack_entry(struct packed_=
git *p, off_t base_offset,
=20
 	ent =3D get_delta_base_cache_entry(p, base_offset);
=20
-	if (!eq_delta_base_cache_entry(ent, p, base_offset))
-		return unpack_entry(p, base_offset, type, base_size);
+	if (!(origin & ODB_DEFAULT) || /* only cache the default case */
+	    !eq_delta_base_cache_entry(ent, p, base_offset))
+		return unpack_entry(p, origin, base_offset, type, base_size);
=20
 	ret =3D ent->data;
=20
@@ -1951,7 +1979,9 @@ add_delta_base_cache(struct packed_git *p, off_t =
base_offset,
 	return ent;
 }
=20
-static void *read_object(const unsigned char *sha1, enum object_type *=
type,
+static void *read_object(const unsigned char *sha1,
+			 unsigned int origin,
+			 enum object_type *type,
 			 unsigned long *size);
=20
 static void write_pack_access_log(struct packed_git *p, off_t obj_offs=
et)
@@ -1981,7 +2011,8 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
=20
-void *unpack_entry(struct packed_git *p, off_t obj_offset,
+void *unpack_entry(struct packed_git *p,
+		   unsigned int origin, off_t obj_offset,
 		   enum object_type *final_type, unsigned long *final_size)
 {
 	struct pack_window *w_curs =3D NULL;
@@ -2093,7 +2124,7 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
=20
 		data =3D NULL;
=20
-		if (base)
+		if (base && (origin & ODB_DEFAULT))
 			ent =3D add_delta_base_cache(p, obj_offset, base, base_size, type);
=20
 		if (!base) {
@@ -2113,7 +2144,7 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_sha1);
-				base =3D read_object(base_sha1, &type, &base_size);
+				base =3D read_object(base_sha1, origin, &type, &base_size);
 			}
 		}
=20
@@ -2277,11 +2308,15 @@ int is_pack_valid(struct packed_git *p)
 }
=20
 static int fill_pack_entry(const unsigned char *sha1,
+			   unsigned int origin,
 			   struct pack_entry *e,
 			   struct packed_git *p)
 {
 	off_t offset;
=20
+	if (!match_origin(origin, p->pack_local))
+		return 0;
+
 	if (p->num_bad_objects) {
 		unsigned i;
 		for (i =3D 0; i < p->num_bad_objects; i++)
@@ -2310,7 +2345,9 @@ static int fill_pack_entry(const unsigned char *s=
ha1,
 	return 1;
 }
=20
-static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
+static int find_pack_entry(const unsigned char *sha1,
+			   unsigned int origin,
+			   struct pack_entry *e)
 {
 	struct packed_git *p;
=20
@@ -2318,11 +2355,12 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
=20
-	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
+	if (last_found_pack &&
+	    fill_pack_entry(sha1, origin, e, last_found_pack))
 		return 1;
=20
 	for (p =3D packed_git; p; p =3D p->next) {
-		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p))
+		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, origin, e, p)=
)
 			continue;
=20
 		last_found_pack =3D p;
@@ -2352,7 +2390,7 @@ static int sha1_loose_object_info(const unsigned =
char *sha1, unsigned long *size
 	git_zstream stream;
 	char hdr[32];
=20
-	map =3D map_sha1_file(sha1, &mapsize);
+	map =3D map_sha1_file(sha1, odb_default, &mapsize);
 	if (!map)
 		return error("unable to find %s", sha1_to_hex(sha1));
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
@@ -2373,8 +2411,9 @@ int sha1_object_info_extended(const unsigned char=
 *sha1, struct object_info *oi)
 	struct cached_object *co;
 	struct pack_entry e;
 	int status, rtype;
+	unsigned int origin =3D odb_default;
=20
-	co =3D find_cached_object(sha1);
+	co =3D find_cached_object(sha1, origin);
 	if (co) {
 		if (oi->sizep)
 			*(oi->sizep) =3D co->size;
@@ -2382,7 +2421,7 @@ int sha1_object_info_extended(const unsigned char=
 *sha1, struct object_info *oi)
 		return co->type;
 	}
=20
-	if (!find_pack_entry(sha1, &e)) {
+	if (!find_pack_entry(sha1, origin, &e)) {
 		/* Most likely it's a loose object. */
 		status =3D sha1_loose_object_info(sha1, oi->sizep);
 		if (status >=3D 0) {
@@ -2392,7 +2431,7 @@ int sha1_object_info_extended(const unsigned char=
 *sha1, struct object_info *oi)
=20
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
-		if (!find_pack_entry(sha1, &e))
+		if (!find_pack_entry(sha1, origin, &e))
 			return status;
 	}
=20
@@ -2422,15 +2461,26 @@ int sha1_object_info(const unsigned char *sha1,=
 unsigned long *sizep)
 }
=20
 static void *read_packed_sha1(const unsigned char *sha1,
+			      unsigned int origin,
 			      enum object_type *type, unsigned long *size)
 {
 	struct pack_entry e;
 	void *data;
=20
-	if (!find_pack_entry(sha1, &e))
+	if (!find_pack_entry(sha1, origin, &e))
 		return NULL;
-	data =3D cache_or_unpack_entry(e.p, e.offset, size, type, 1);
-	if (!data) {
+	data =3D cache_or_unpack_entry(e.p, origin, e.offset, size, type, 1);
+	if (!data &&
+	    /*
+	     * If a user attempts to read from a single source via
+	     * read_sha1_file_extended and the object has base in
+	     * another source, it'll come here. It's not as bad as the
+	     * corrupted pack we're handling in the below block
+	     * because the user asked to do so and must be able to
+	     * deal with the consequences. Just return NULL in this
+	     * case without marking the sha-1 "bad".
+	     */
+	    !(origin & ODB_DEFAULT)) {
 		/*
 		 * We're probably in deep shit, but let's try to fetch
 		 * the required object anyway from another pack or loose.
@@ -2440,7 +2490,7 @@ static void *read_packed_sha1(const unsigned char=
 *sha1,
 		error("failed to read object %s at offset %"PRIuMAX" from %s",
 		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
 		mark_bad_packed_object(e.p, sha1);
-		data =3D read_object(sha1, type, size);
+		data =3D read_object(sha1, origin, type, size);
 	}
 	return data;
 }
@@ -2451,7 +2501,7 @@ int pretend_sha1_file(void *buf, unsigned long le=
n, enum object_type type,
 	struct cached_object *co;
=20
 	hash_sha1_file(buf, len, typename(type), sha1);
-	if (has_sha1_file(sha1) || find_cached_object(sha1))
+	if (has_sha1_file(sha1) || find_cached_object(sha1, odb_default))
 		return 0;
 	if (cached_object_alloc <=3D cached_object_nr) {
 		cached_object_alloc =3D alloc_nr(cached_object_alloc);
@@ -2468,31 +2518,33 @@ int pretend_sha1_file(void *buf, unsigned long =
len, enum object_type type,
 	return 0;
 }
=20
-static void *read_object(const unsigned char *sha1, enum object_type *=
type,
+static void *read_object(const unsigned char *sha1,
+			 unsigned int origin,
+			 enum object_type *type,
 			 unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
 	struct cached_object *co;
=20
-	co =3D find_cached_object(sha1);
+	co =3D find_cached_object(sha1, origin);
 	if (co) {
 		*type =3D co->type;
 		*size =3D co->size;
 		return xmemdupz(co->buf, co->size);
 	}
=20
-	buf =3D read_packed_sha1(sha1, type, size);
+	buf =3D read_packed_sha1(sha1, origin, type, size);
 	if (buf)
 		return buf;
-	map =3D map_sha1_file(sha1, &mapsize);
+	map =3D map_sha1_file(sha1, origin, &mapsize);
 	if (map) {
 		buf =3D unpack_sha1_file(map, mapsize, type, size, sha1);
 		munmap(map, mapsize);
 		return buf;
 	}
 	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	return read_packed_sha1(sha1, origin, type, size);
 }
=20
 /*
@@ -2501,6 +2553,7 @@ static void *read_object(const unsigned char *sha=
1, enum object_type *type,
  * messages themselves.
  */
 void *read_sha1_file_extended(const unsigned char *sha1,
+			      unsigned int origin,
 			      enum object_type *type,
 			      unsigned long *size,
 			      unsigned flag)
@@ -2512,7 +2565,7 @@ void *read_sha1_file_extended(const unsigned char=
 *sha1,
 		? lookup_replace_object(sha1) : sha1;
=20
 	errno =3D 0;
-	data =3D read_object(repl, type, size);
+	data =3D read_object(repl, origin, type, size);
 	if (data)
 		return data;
=20
@@ -2524,7 +2577,7 @@ void *read_sha1_file_extended(const unsigned char=
 *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
=20
-	if (has_loose_object(repl)) {
+	if (has_loose_object_extended(repl, origin)) {
 		path =3D sha1_file_name(sha1);
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
@@ -2809,9 +2862,9 @@ int force_object_loose(const unsigned char *sha1,=
 time_t mtime)
 	int hdrlen;
 	int ret;
=20
-	if (has_loose_object(sha1))
+	if (has_loose_object_extended(sha1, odb_default))
 		return 0;
-	buf =3D read_packed_sha1(sha1, &type, &len);
+	buf =3D read_packed_sha1(sha1, odb_default, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen =3D sprintf(hdr, "%s %lu", typename(type), len) + 1;
@@ -2832,16 +2885,22 @@ int has_pack_index(const unsigned char *sha1)
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
+	return find_pack_entry(sha1, odb_default, &e);
 }
=20
-int has_sha1_file(const unsigned char *sha1)
+static int has_sha1_file_extended(const unsigned char *sha1,
+				  unsigned origin)
 {
 	struct pack_entry e;
=20
-	if (find_pack_entry(sha1, &e))
+	if (find_pack_entry(sha1, origin, &e))
 		return 1;
-	return has_loose_object(sha1);
+	return has_loose_object_extended(sha1, origin);
+}
+
+int has_sha1_file(const unsigned char *sha1)
+{
+	return has_sha1_file_extended(sha1, odb_default);
 }
=20
 static void check_tree(const void *buf, size_t size)
diff --git a/streaming.c b/streaming.c
index cabcd9d..975002c 100644
--- a/streaming.c
+++ b/streaming.c
@@ -332,7 +332,7 @@ static struct stream_vtbl loose_vtbl =3D {
=20
 static open_method_decl(loose)
 {
-	st->u.loose.mapped =3D map_sha1_file(sha1, &st->u.loose.mapsize);
+	st->u.loose.mapped =3D map_sha1_file(sha1, odb_default, &st->u.loose.=
mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if (unpack_sha1_header(&st->z,
@@ -483,7 +483,7 @@ static struct stream_vtbl incore_vtbl =3D {
=20
 static open_method_decl(incore)
 {
-	st->u.incore.buf =3D read_sha1_file_extended(sha1, type, &st->size, 0=
);
+	st->u.incore.buf =3D read_sha1_file_extended(sha1, odb_default, type,=
 &st->size, 0);
 	st->u.incore.read_ptr =3D 0;
 	st->vtbl =3D &incore_vtbl;
=20
--=20
1.8.2.83.gc99314b
