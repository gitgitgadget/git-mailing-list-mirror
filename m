From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] Add commit cache to help speed up commit traversal
Date: Tue,  3 Apr 2012 13:55:08 +0700
Message-ID: <1333436109-16526-3-git-send-email-pclouds@gmail.com>
References: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 08:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SExfD-0004KR-4W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 08:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab2DCG4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 02:56:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52178 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab2DCG4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 02:56:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so5260485pbc.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 23:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=w2STlYRBrxKLX9BDj5YbeAcZ8DWDOwEq5uT5hwfeKqo=;
        b=0+MC/uzxE79UwvNEyn+Iz23vH6J7cZNOQFEMnmC3uzosD8XGLo8m//5KCBQ7FDaMXy
         WPMTfw61s3f7zjINr/XUHnFpYjeLQZlBk0v9R21JpPpsywuskCwJnWbbKhhhOKb3p4p+
         X4KjISDyTM0NRul6VqjA4IoyfXoXgRhTMjXtxCHLqzSwb33ygilcPCKi3Unlps0CPZnA
         UQsrDglYhAsvWrX3ZXohvIe+HwnQpAGbW8LHSzFAI50+5SH7aoQzF8xGVYs7RTz9tEUq
         bHJK/NwKqlJDyyp7bj50qHO+602hXoI5jHy5b/LrdfG+Pmzz+7odoELkc5Dvb6TVKxp8
         4MTw==
Received: by 10.68.132.69 with SMTP id os5mr26589807pbb.60.1333436176816;
        Mon, 02 Apr 2012 23:56:16 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id z5sm15690757pbn.35.2012.04.02.23.56.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 23:56:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 03 Apr 2012 13:55:32 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194598>

This patch extracts tree, parent sha-1 and committer date of packed
commits that have exactly one parent out. So that revision traversal
code can avoid inflating commit for these sha-1. The assumption is
commits with one parent dominate.

Two new files are created per pack: one file contains sha-1 and dates.
The other file contains commit sha-1 mapping to the offset in the forme=
r
file.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile             |    3 +
 builtin/index-pack.c |  113 ++++++++++++++++++++++++++++++++++-
 cache.h              |    9 +++
 pack-write.c         |   11 +++-
 pack.h               |    1 +
 sha1_cache.c         |  161 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 sha1_cache.h         |    6 ++
 sha1_file.c          |   12 ++++-
 test-sha1-cache.c    |   19 ++++++
 9 files changed, 331 insertions(+), 4 deletions(-)
 create mode 100644 sha1_cache.c
 create mode 100644 sha1_cache.h
 create mode 100644 test-sha1-cache.c

diff --git a/Makefile b/Makefile
index 87fb30a..fced758 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-sha1-cache
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -606,6 +607,7 @@ LIB_H +=3D run-command.h
 LIB_H +=3D sequencer.h
 LIB_H +=3D sha1-array.h
 LIB_H +=3D sha1-lookup.h
+LIB_H +=3D sha1_cache.h
 LIB_H +=3D sideband.h
 LIB_H +=3D sigchain.h
 LIB_H +=3D strbuf.h
@@ -722,6 +724,7 @@ LIB_OBJS +=3D setup.o
 LIB_OBJS +=3D sequencer.o
 LIB_OBJS +=3D sha1-array.o
 LIB_OBJS +=3D sha1-lookup.o
+LIB_OBJS +=3D sha1_cache.o
 LIB_OBJS +=3D sha1_file.o
 LIB_OBJS +=3D sha1_name.o
 LIB_OBJS +=3D shallow.o
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dd1c5c9..67673ef 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -15,6 +15,7 @@ static const char index_pack_usage[] =3D
=20
 struct object_entry {
 	struct pack_idx_entry idx;
+	off_t commit_offset;
 	unsigned long size;
 	unsigned int hdr_size;
 	enum object_type type;
@@ -63,6 +64,7 @@ static int nr_resolved_deltas;
 static int from_stdin;
 static int strict;
 static int verbose;
+static int write_cache =3D 1;
=20
 static struct progress *progress;
=20
@@ -75,6 +77,13 @@ static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
+static int cache_fd;
+static int cache_written;
+static uint32_t cache_nr;
+static char cache_filename[PATH_MAX];
+static const char *cache_idxname;
+static unsigned char cache_sha1[20];
+
 static int mark_link(struct object *obj, int type, void *data)
 {
 	if (!obj)
@@ -682,6 +691,58 @@ static int compare_delta_entry(const void *a, cons=
t void *b)
 				   objects[delta_b->obj_no].type);
 }
=20
+static unsigned long parse_commit_date(const char *buf, const char *ta=
il)
+{
+	const char *dateptr;
+
+	if (buf + 6 >=3D tail)
+		return 0;
+	if (memcmp(buf, "author", 6))
+		return 0;
+	while (buf < tail && *buf++ !=3D '\n')
+		/* nada */;
+	if (buf + 9 >=3D tail)
+		return 0;
+	if (memcmp(buf, "committer", 9))
+		return 0;
+	while (buf < tail && *buf++ !=3D '>')
+		/* nada */;
+	if (buf >=3D tail)
+		return 0;
+	dateptr =3D buf;
+	while (buf < tail && *buf++ !=3D '\n')
+		/* nada */;
+	if (buf >=3D tail)
+		return 0;
+	/* dateptr < buf && buf[-1] =3D=3D '\n', so strtoul will stop at buf-=
1 */
+	return strtoul(dateptr, NULL, 10);
+}
+
+static void write_commit_sha1(struct object_entry *obj, const char *da=
ta)
+{
+	unsigned char sha1[20];
+	if (!obj->commit_offset &&
+	    !memcmp(data, "tree ", 5) &&
+	    !memcmp(data + 45, "\nparent ", 8) &&
+	    memcmp(data + 45 + 48, "\nparent ", 8)) {
+		uint32_t date;
+		obj->commit_offset =3D cache_written;
+		cache_nr++;
+
+		get_sha1_hex(data + 5, sha1);
+		cache_written +=3D xwrite(cache_fd, sha1, 20);
+		get_sha1_hex(data + 5 + 48, sha1);
+		cache_written +=3D xwrite(cache_fd, sha1, 20);
+		date =3D parse_commit_date(data + 5 + 48 + 41, data + obj->size);
+		date =3D htonl(date);
+		cache_written +=3D xwrite(cache_fd, &date, 4);
+	}
+#if 0
+	hashclr(sha1);
+	cache_written +=3D xwrite(cache_fd, sha1, 20);
+#endif
+}
+
 /* Parse all objects and return the pack content SHA1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
@@ -707,8 +768,13 @@ static void parse_pack_objects(unsigned char *sha1=
)
 			nr_deltas++;
 			delta->obj_no =3D i;
 			delta++;
-		} else
+		} else {
 			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
+
+			/* We assume that commits are never deltified */
+			if (write_cache && obj->real_type =3D=3D OBJ_COMMIT)
+				write_commit_sha1(obj, data);
+		}
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -919,6 +985,18 @@ static void final(const char *final_pack_name, con=
st char *curr_pack_name,
 	} else if (from_stdin)
 		chmod(final_pack_name, 0444);
=20
+	if (write_cache) {
+		snprintf(name, sizeof(name), "%s/pack/pack-%s.sha1",
+			 get_object_directory(), sha1_to_hex(sha1));
+		if (move_temp_to_file(cache_filename, name))
+			die("cannot store commit cache file");
+
+		snprintf(name, sizeof(name), "%s/pack/pack-%s.sidx",
+			 get_object_directory(), sha1_to_hex(sha1));
+		if (move_temp_to_file(cache_idxname, name))
+			die("cannot store commit cache file");
+	}
+
 	if (final_index_name !=3D curr_index_name) {
 		if (!final_index_name) {
 			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
@@ -1120,6 +1198,8 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 				keep_msg =3D "";
 			} else if (!prefixcmp(arg, "--keep=3D")) {
 				keep_msg =3D arg + 7;
+			} else if (!strcmp(arg, "--no-cache")) {
+				write_cache =3D 0;
 			} else if (!prefixcmp(arg, "--pack_header=3D")) {
 				struct pack_header *hdr;
 				char *c;
@@ -1191,6 +1271,17 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	if (strict)
 		opts.flags |=3D WRITE_IDX_STRICT;
=20
+	if (verify)
+		write_cache =3D 0;
+	if (write_cache) {
+		unsigned char sha1[20];
+		cache_fd =3D odb_mkstemp(cache_filename,
+				       sizeof(cache_filename),
+				       "pack/tmp_sha1_XXXXXX");
+		hashclr(sha1);
+		cache_written =3D xwrite(cache_fd, sha1, 20);
+	}
+
 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
@@ -1243,6 +1334,26 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	curr_index =3D write_idx_file(index_name, idx_objects, nr_objects, &o=
pts, pack_sha1);
 	free(idx_objects);
=20
+	if (write_cache) {
+		int nr;
+		struct pack_idx_entry **idx;
+
+		close(cache_fd);
+
+		idx =3D idx_objects =3D xmalloc((cache_nr) * sizeof(struct pack_idx_=
entry *));
+		for (nr =3D i =3D 0; i < nr_objects; i++) {
+			if (objects[i].commit_offset) {
+				objects[i].idx.offset =3D objects[i].commit_offset;
+				*idx++ =3D &objects[i].idx;
+				nr++;
+			}
+		}
+		assert(nr =3D=3D cache_nr);
+		opts.flags |=3D WRITE_IDX_SHA1_CACHE;
+		cache_idxname =3D write_idx_file(NULL, idx_objects, cache_nr, &opts,=
 cache_sha1);
+		free(idx_objects);
+	}
+
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
diff --git a/cache.h b/cache.h
index 9bd8c2d..fd3953f 100644
--- a/cache.h
+++ b/cache.h
@@ -972,6 +972,14 @@ struct pack_window {
 	unsigned int inuse_cnt;
 };
=20
+struct sha1_cache {
+	const void *idx;
+	const void *data;
+	size_t idx_size;
+	size_t data_size;
+	uint32_t nr;
+};
+
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
@@ -984,6 +992,7 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
+	struct sha1_cache commit_cache;
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 do_not_close:1;
diff --git a/pack-write.c b/pack-write.c
index ca9e63b..6da977a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -85,8 +85,11 @@ const char *write_idx_file(const char *index_name, s=
truct pack_idx_entry **objec
 		f =3D sha1fd(fd, index_name);
 	}
=20
-	/* if last object's offset is >=3D 2^31 we should use index V2 */
-	index_version =3D need_large_offset(last_obj_offset, opts) ? 2 : opts=
->version;
+	if (opts->flags & WRITE_IDX_SHA1_CACHE)
+		index_version =3D 2;
+	else
+		/* if last object's offset is >=3D 2^31 we should use index V2 */
+		index_version =3D need_large_offset(last_obj_offset, opts) ? 2 : opt=
s->version;
=20
 	/* index versions 2 and above need a header */
 	if (index_version >=3D 2) {
@@ -138,6 +141,9 @@ const char *write_idx_file(const char *index_name, =
struct pack_idx_entry **objec
 	if (index_version >=3D 2) {
 		unsigned int nr_large_offset =3D 0;
=20
+		if (opts->flags & WRITE_IDX_SHA1_CACHE)
+			goto skip_crc32;
+
 		/* write the crc32 table */
 		list =3D sorted_by_sha;
 		for (i =3D 0; i < nr_objects; i++) {
@@ -146,6 +152,7 @@ const char *write_idx_file(const char *index_name, =
struct pack_idx_entry **objec
 			sha1write(f, &crc32_val, 4);
 		}
=20
+skip_crc32:
 		/* write the 32-bit offset table */
 		list =3D sorted_by_sha;
 		for (i =3D 0; i < nr_objects; i++) {
diff --git a/pack.h b/pack.h
index aa6ee7d..f002b6a 100644
--- a/pack.h
+++ b/pack.h
@@ -40,6 +40,7 @@ struct pack_idx_option {
 	/* flag bits */
 #define WRITE_IDX_VERIFY 01 /* verify only, do not write the idx file =
*/
 #define WRITE_IDX_STRICT 02
+#define WRITE_IDX_SHA1_CACHE 04
=20
 	uint32_t version;
 	uint32_t off32_limit;
diff --git a/sha1_cache.c b/sha1_cache.c
new file mode 100644
index 0000000..3f244bb
--- /dev/null
+++ b/sha1_cache.c
@@ -0,0 +1,161 @@
+#include "cache.h"
+#include "pack.h"
+#include "sha1_cache.h"
+
+static int git_open_noatime(const char *name)
+{
+	static int sha1_file_open_flag =3D O_NOATIME;
+
+	for (;;) {
+		int fd =3D open(name, O_RDONLY | sha1_file_open_flag);
+		if (fd >=3D 0)
+			return fd;
+
+		/* Might the failure be due to O_NOATIME? */
+		if (errno !=3D ENOENT && sha1_file_open_flag) {
+			sha1_file_open_flag =3D 0;
+			continue;
+		}
+
+		return -1;
+	}
+}
+
+/*
+ * Commit cache format is basically pack index v2 except that:
+ * - no crc32 table
+ * - no large offset support
+ * - offset table contains offset in _this_ file, in the commit
+ *   cache section
+ * - the commit cache section follows offset table, each entry
+ *   consists of tree sha1, parent sha1 if any, and terminated
+ *   by null sha-1.
+ */
+
+int open_sha1_cache(struct sha1_cache *cache,
+		    const char *data_path, const char *idx_path)
+{
+	void *idx_map, *data;
+	struct pack_idx_header *hdr;
+	size_t idx_size, data_size;
+	uint32_t nr, i, *index;
+	int fd =3D git_open_noatime(idx_path);
+	struct stat st;
+
+	if (fd < 0)
+		return -1;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+	idx_size =3D xsize_t(st.st_size);
+	if (idx_size < 4 * 256 + 20 + 20) {
+		close(fd);
+		return error("index file %s is too small", idx_path);
+	}
+	idx_map =3D xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	fd =3D git_open_noatime(data_path);
+	if (fd < 0)
+		return -1;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+	data_size =3D xsize_t(st.st_size);
+	data =3D xmmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	hdr =3D idx_map;
+	if (hdr->idx_signature !=3D htonl(PACK_IDX_SIGNATURE))
+		return error("not a commit cache file %s", idx_path);
+	if (ntohl(hdr->idx_version) !=3D 2)
+		return error("wrong version %s %d", idx_path, ntohl(hdr->idx_version=
));
+
+	nr =3D 0;
+	index =3D idx_map;
+	index +=3D 2;  /* skip index header */
+	for (i =3D 0; i < 256; i++) {
+		uint32_t n =3D ntohl(index[i]);
+		if (n < nr) {
+			munmap(idx_map, idx_size);
+			return error("non-monotonic index %s", idx_path);
+		}
+		nr =3D n;
+	}
+
+	cache->idx =3D idx_map;
+	cache->idx_size =3D idx_size;
+	cache->nr =3D nr;
+	cache->data =3D data;
+	cache->data_size =3D data_size;
+	return 0;
+}
+
+static const void *object_offset(const struct sha1_cache *cache, uint3=
2_t n)
+{
+	const unsigned char *index =3D cache->idx;
+	uint32_t off;
+	index +=3D 4 * 256;
+	index +=3D 8 + cache->nr * 20;
+	off =3D ntohl(*((uint32_t *)(index + 4 * n)));
+	return (const char *)cache->data + off;
+}
+
+const void *find_sha1_in_cache(const unsigned char *sha1)
+{
+	const uint32_t *level1_ofs;
+	const unsigned char *index;
+	unsigned hi, lo, stride;
+
+	struct packed_git *p =3D find_sha1_pack(sha1, packed_git);
+	if (!p)
+		return 0;
+
+	open_pack_index(p);
+	if (!p->commit_cache.nr)
+		return 0;
+
+	level1_ofs =3D p->commit_cache.idx;
+	index =3D p->commit_cache.idx;
+
+	/* skip header */
+	level1_ofs +=3D 2;
+	index +=3D 8;
+
+	/* fanout table */
+	index +=3D 4 * 256;
+	hi =3D ntohl(level1_ofs[*sha1]);
+	lo =3D ((*sha1 =3D=3D 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	stride =3D 20;
+
+	do {
+		unsigned mi =3D (lo + hi) / 2;
+		int cmp =3D hashcmp(index + mi * stride, sha1);
+
+		if (!cmp)
+			return object_offset(&p->commit_cache, mi);
+		if (cmp > 0)
+			hi =3D mi;
+		else
+			lo =3D mi+1;
+	} while (lo < hi);
+	return NULL;
+}
+
+int has_commit_cache(const unsigned char *sha1,
+		     unsigned char *tree,
+		     unsigned char *parent,
+		     unsigned long *date)
+{
+	const unsigned char *data;
+	data =3D find_sha1_in_cache(sha1);
+	if (!data)
+		return 0;
+
+	hashcpy(tree, data);
+	hashcpy(parent, data + 20);
+	*date =3D ntohl(*((uint32_t*)(data + 40)));
+	return 1;
+}
diff --git a/sha1_cache.h b/sha1_cache.h
new file mode 100644
index 0000000..59823cf
--- /dev/null
+++ b/sha1_cache.h
@@ -0,0 +1,6 @@
+extern int open_sha1_cache(struct sha1_cache *cache,
+			   const char *data_path, const char *idx_path);
+extern const void *find_sha1_in_cache(const unsigned char *sha1);
+extern int has_commit_cache(const unsigned char *sha1,
+			    unsigned char *tree, unsigned char *parent,
+			    unsigned long *date);
diff --git a/sha1_file.c b/sha1_file.c
index 88f2151..fc2f460 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -19,6 +19,7 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "sha1_cache.h"
=20
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -578,14 +579,23 @@ static int check_packed_git_idx(const char *path,=
  struct packed_git *p)
 int open_pack_index(struct packed_git *p)
 {
 	char *idx_name;
+	int baselen =3D strlen(p->pack_name) - strlen(".pack");
 	int ret;
=20
 	if (p->index_data)
 		return 0;
=20
 	idx_name =3D xstrdup(p->pack_name);
-	strcpy(idx_name + strlen(idx_name) - strlen(".pack"), ".idx");
+	strcpy(idx_name + baselen, ".idx");
 	ret =3D check_packed_git_idx(idx_name, p);
+	if (!ret) {
+		char *cache_name;
+		cache_name =3D xstrdup(p->pack_name);
+		strcpy(idx_name + baselen, ".sidx");
+		strcpy(cache_name + baselen, ".sha1");
+		open_sha1_cache(&p->commit_cache, cache_name, idx_name);
+		free(cache_name);
+	}
 	free(idx_name);
 	return ret;
 }
diff --git a/test-sha1-cache.c b/test-sha1-cache.c
new file mode 100644
index 0000000..7b7f32c
--- /dev/null
+++ b/test-sha1-cache.c
@@ -0,0 +1,19 @@
+#include "cache.h"
+#include "sha1_cache.h"
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1[20];
+	unsigned char tree[20];
+	unsigned char parent[20];
+	unsigned long date;
+
+	setup_git_directory();
+	prepare_packed_git();
+	get_sha1_hex(argv[1], sha1);
+	if (!has_commit_cache(sha1, tree, parent, &date))
+		return 1;
+	printf("tree %s\nparent %s\ndate %ld\n",
+	       sha1_to_hex(tree), sha1_to_hex(parent), date);
+	return 0;
+}
--=20
1.7.3.1.256.g2539c.dirty
