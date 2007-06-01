From: Geert Bosch <bosch@gnat.com>
Subject: [PATCH] Unify write_index_file functions
Date: Fri, 1 Jun 2007 15:18:05 -0400
Message-ID: <20070601194856.66DFB4D7206@potomac.gnat.com>
To: git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:49:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuD7U-00028E-Iw
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 21:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762694AbXFATsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762435AbXFATsx
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 15:48:53 -0400
Received: from nile.gnat.com ([205.232.38.5]:45462 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762763AbXFATsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 15:48:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 372C748CF71
	for <git@vger.kernel.org>; Fri,  1 Jun 2007 15:48:50 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 12252-01-6 for <git@vger.kernel.org>;
 Fri,  1 Jun 2007 15:48:50 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id D242E48CDD6
	for <git@vger.kernel.org>; Fri,  1 Jun 2007 15:48:49 -0400 (EDT)
Received: by potomac.gnat.com (Postfix, from userid 4190)
	id 66DFB4D7206; Fri,  1 Jun 2007 15:48:56 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48877>

This patch creates a new pack-idx.c file containing a unified version of
the write_index_file functions in builtin-pack-objects.c and index-pack.c.
As the name "index" is overloaded in git, move in the direction
of using "idx" and "pack idx" when refering to the pack index.
There should be no change in functionality.

Signed-off-by: Geert Bosch <bosch@gnat.com>
---
 Makefile               |    3 +-
 builtin-pack-objects.c |  143 ++++--------------------------------------
 index-pack.c           |  161 +++++-------------------------------------------
 pack-idx.c             |  144 +++++++++++++++++++++++++++++++++++++++++++
 pack.h                 |   15 +++++
 5 files changed, 190 insertions(+), 276 deletions(-)
 create mode 100644 pack-idx.c

diff --git a/Makefile b/Makefile
index 7527734..8e89cda 100644
--- a/Makefile
+++ b/Makefile
@@ -310,7 +310,8 @@ LIB_OBJS = \
 	interpolate.o \
 	lockfile.o \
 	patch-ids.o \
-	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
+	object.o pack-check.o pack-idx.o pack-write.o \
+	patch-delta.o path.o pkt-line.o \
 	sideband.o reachable.o reflog-walk.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e52332d..d4c5d2b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -24,9 +24,10 @@ git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
 
 struct object_entry {
 	unsigned char sha1[20];
-	uint32_t crc32;		/* crc of raw pack data for this object */
 	off_t offset;		/* offset into the final pack file */
 	unsigned long size;	/* uncompressed size */
+	uint32_t crc32;		/* crc of raw pack data for this object */
+
 	unsigned int hash;	/* name hint hash */
 	unsigned int depth;	/* delta depth */
 	struct packed_git *in_pack; 	/* already in pack */
@@ -584,8 +585,7 @@ static int open_object_dir_tmp(const char *path)
     return mkstemp(tmpname);
 }
 
-/* forward declarations for write_pack_file */
-static void write_index_file(off_t last_obj_offset, unsigned char *sha1);
+/* forward declaration for write_pack_file */
 static int adjust_perm(const char *path, mode_t mode);
 
 static void write_pack_file(void)
@@ -641,15 +641,17 @@ static void write_pack_file(void)
 		}
 
 		if (!pack_to_stdout) {
-			unsigned char object_list_sha1[20];
+			unsigned char sha1[20];
 			mode_t mode = umask(0);
 
 			umask(mode);
 			mode = 0444 & ~mode;
 
-			write_index_file(last_obj_offset, object_list_sha1);
+			hashcpy(sha1, pack_file_sha1);
+			idx_tmp_name = write_idx_file(NULL,
+				(struct idx_object_entry **) written_list, nr_written, sha1);
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
-				 base_name, sha1_to_hex(object_list_sha1));
+				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(pack_tmp_name, mode))
 				die("unable to make temporary pack file readable: %s",
 				    strerror(errno));
@@ -657,14 +659,14 @@ static void write_pack_file(void)
 				die("unable to rename temporary pack file: %s",
 				    strerror(errno));
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
-				 base_name, sha1_to_hex(object_list_sha1));
+				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(idx_tmp_name, mode))
 				die("unable to make temporary index file readable: %s",
 				    strerror(errno));
 			if (rename(idx_tmp_name, tmpname))
 				die("unable to rename temporary index file: %s",
 				    strerror(errno));
-			puts(sha1_to_hex(object_list_sha1));
+			puts(sha1_to_hex(sha1));
 		}
 
 		/* mark written objects as written to previous pack */
@@ -693,123 +695,6 @@ static void write_pack_file(void)
 		die("wrote %u objects as expected but %u unwritten", written, j);
 }
 
-static int sha1_sort(const void *_a, const void *_b)
-{
-	const struct object_entry *a = *(struct object_entry **)_a;
-	const struct object_entry *b = *(struct object_entry **)_b;
-	return hashcmp(a->sha1, b->sha1);
-}
-
-static uint32_t index_default_version = 1;
-static uint32_t index_off32_limit = 0x7fffffff;
-
-static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
-{
-	struct sha1file *f;
-	struct object_entry **sorted_by_sha, **list, **last;
-	uint32_t array[256];
-	uint32_t i, index_version;
-	SHA_CTX ctx;
-
-	int fd = open_object_dir_tmp("tmp_idx_XXXXXX");
-	if (fd < 0)
-		die("unable to create %s: %s\n", tmpname, strerror(errno));
-	idx_tmp_name = xstrdup(tmpname);
-	f = sha1fd(fd, idx_tmp_name);
-
-	if (nr_written) {
-		sorted_by_sha = written_list;
-		qsort(sorted_by_sha, nr_written, sizeof(*sorted_by_sha), sha1_sort);
-		list = sorted_by_sha;
-		last = sorted_by_sha + nr_written;
-	} else
-		sorted_by_sha = list = last = NULL;
-
-	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (last_obj_offset >> 31) ? 2 : index_default_version;
-
-	/* index versions 2 and above need a header */
-	if (index_version >= 2) {
-		struct pack_idx_header hdr;
-		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
-		hdr.idx_version = htonl(index_version);
-		sha1write(f, &hdr, sizeof(hdr));
-	}
-
-	/*
-	 * Write the first-level table (the list is sorted,
-	 * but we use a 256-entry lookup to be able to avoid
-	 * having to do eight extra binary search iterations).
-	 */
-	for (i = 0; i < 256; i++) {
-		struct object_entry **next = list;
-		while (next < last) {
-			struct object_entry *entry = *next;
-			if (entry->sha1[0] != i)
-				break;
-			next++;
-		}
-		array[i] = htonl(next - sorted_by_sha);
-		list = next;
-	}
-	sha1write(f, array, 256 * 4);
-
-	/* Compute the SHA1 hash of sorted object names. */
-	SHA1_Init(&ctx);
-
-	/* Write the actual SHA1 entries. */
-	list = sorted_by_sha;
-	for (i = 0; i < nr_written; i++) {
-		struct object_entry *entry = *list++;
-		if (index_version < 2) {
-			uint32_t offset = htonl(entry->offset);
-			sha1write(f, &offset, 4);
-		}
-		sha1write(f, entry->sha1, 20);
-		SHA1_Update(&ctx, entry->sha1, 20);
-	}
-
-	if (index_version >= 2) {
-		unsigned int nr_large_offset = 0;
-
-		/* write the crc32 table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_written; i++) {
-			struct object_entry *entry = *list++;
-			uint32_t crc32_val = htonl(entry->crc32);
-			sha1write(f, &crc32_val, 4);
-		}
-
-		/* write the 32-bit offset table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_written; i++) {
-			struct object_entry *entry = *list++;
-			uint32_t offset = (entry->offset <= index_off32_limit) ?
-				entry->offset : (0x80000000 | nr_large_offset++);
-			offset = htonl(offset);
-			sha1write(f, &offset, 4);
-		}
-
-		/* write the large offset table */
-		list = sorted_by_sha;
-		while (nr_large_offset) {
-			struct object_entry *entry = *list++;
-			uint64_t offset = entry->offset;
-			if (offset > index_off32_limit) {
-				uint32_t split[2];
-				split[0]        = htonl(offset >> 32);
-				split[1] = htonl(offset & 0xffffffff);
-				sha1write(f, split, 8);
-				nr_large_offset--;
-			}
-		}
-	}
-
-	sha1write(f, pack_file_sha1, 20);
-	sha1close(f, NULL, 1);
-	SHA1_Final(sha1, &ctx);
-}
-
 static int locate_object_entry_hash(const unsigned char *sha1)
 {
 	int i;
@@ -1825,12 +1710,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 		if (!prefixcmp(arg, "--index-version=")) {
 			char *c;
-			index_default_version = strtoul(arg + 16, &c, 10);
-			if (index_default_version > 2)
+			pack_idx_default_version = strtoul(arg + 16, &c, 10);
+			if (pack_idx_default_version > 2)
 				die("bad %s", arg);
 			if (*c == ',')
-				index_off32_limit = strtoul(c+1, &c, 0);
-			if (*c || index_off32_limit & 0x80000000)
+				pack_idx_off32_limit = strtoul(c+1, &c, 0);
+			if (*c || pack_idx_off32_limit & 0x80000000)
 				die("bad %s", arg);
 			continue;
 		}
diff --git a/index-pack.c b/index-pack.c
index 58c4a9c..ed6ff9c 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -13,13 +13,14 @@ static const char index_pack_usage[] =
 
 struct object_entry
 {
+	unsigned char sha1[20];
 	off_t offset;
 	unsigned long size;
-	unsigned int hdr_size;
 	uint32_t crc32;
+
+	unsigned int hdr_size;
 	enum object_type type;
 	enum object_type real_type;
-	unsigned char sha1[20];
 };
 
 union delta_base {
@@ -602,145 +603,6 @@ static void fix_unresolved_deltas(int nr_unresolved)
 	free(sorted_by_pos);
 }
 
-static uint32_t index_default_version = 1;
-static uint32_t index_off32_limit = 0x7fffffff;
-
-static int sha1_compare(const void *_a, const void *_b)
-{
-	struct object_entry *a = *(struct object_entry **)_a;
-	struct object_entry *b = *(struct object_entry **)_b;
-	return hashcmp(a->sha1, b->sha1);
-}
-
-/*
- * On entry *sha1 contains the pack content SHA1 hash, on exit it is
- * the SHA1 hash of sorted object names.
- */
-static const char *write_index_file(const char *index_name, unsigned char *sha1)
-{
-	struct sha1file *f;
-	struct object_entry **sorted_by_sha, **list, **last;
-	uint32_t array[256];
-	int i, fd;
-	SHA_CTX ctx;
-	uint32_t index_version;
-
-	if (nr_objects) {
-		sorted_by_sha =
-			xcalloc(nr_objects, sizeof(struct object_entry *));
-		list = sorted_by_sha;
-		last = sorted_by_sha + nr_objects;
-		for (i = 0; i < nr_objects; ++i)
-			sorted_by_sha[i] = &objects[i];
-		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
-		      sha1_compare);
-	}
-	else
-		sorted_by_sha = list = last = NULL;
-
-	if (!index_name) {
-		static char tmpfile[PATH_MAX];
-		snprintf(tmpfile, sizeof(tmpfile),
-			 "%s/tmp_idx_XXXXXX", get_object_directory());
-		fd = mkstemp(tmpfile);
-		index_name = xstrdup(tmpfile);
-	} else {
-		unlink(index_name);
-		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-	}
-	if (fd < 0)
-		die("unable to create %s: %s", index_name, strerror(errno));
-	f = sha1fd(fd, index_name);
-
-	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (objects[nr_objects-1].offset >> 31) ? 2 : index_default_version;
-
-	/* index versions 2 and above need a header */
-	if (index_version >= 2) {
-		struct pack_idx_header hdr;
-		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
-		hdr.idx_version = htonl(index_version);
-		sha1write(f, &hdr, sizeof(hdr));
-	}
-
-	/*
-	 * Write the first-level table (the list is sorted,
-	 * but we use a 256-entry lookup to be able to avoid
-	 * having to do eight extra binary search iterations).
-	 */
-	for (i = 0; i < 256; i++) {
-		struct object_entry **next = list;
-		while (next < last) {
-			struct object_entry *obj = *next;
-			if (obj->sha1[0] != i)
-				break;
-			next++;
-		}
-		array[i] = htonl(next - sorted_by_sha);
-		list = next;
-	}
-	sha1write(f, array, 256 * 4);
-
-	/* compute the SHA1 hash of sorted object names. */
-	SHA1_Init(&ctx);
-
-	/*
-	 * Write the actual SHA1 entries..
-	 */
-	list = sorted_by_sha;
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *obj = *list++;
-		if (index_version < 2) {
-			uint32_t offset = htonl(obj->offset);
-			sha1write(f, &offset, 4);
-		}
-		sha1write(f, obj->sha1, 20);
-		SHA1_Update(&ctx, obj->sha1, 20);
-	}
-
-	if (index_version >= 2) {
-		unsigned int nr_large_offset = 0;
-
-		/* write the crc32 table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
-			struct object_entry *obj = *list++;
-			uint32_t crc32_val = htonl(obj->crc32);
-			sha1write(f, &crc32_val, 4);
-		}
-
-		/* write the 32-bit offset table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
-			struct object_entry *obj = *list++;
-			uint32_t offset = (obj->offset <= index_off32_limit) ?
-				obj->offset : (0x80000000 | nr_large_offset++);
-			offset = htonl(offset);
-			sha1write(f, &offset, 4);
-		}
-
-		/* write the large offset table */
-		list = sorted_by_sha;
-		while (nr_large_offset) {
-			struct object_entry *obj = *list++;
-			uint64_t offset = obj->offset;
-			if (offset > index_off32_limit) {
-				uint32_t split[2];
-				split[0]	= htonl(offset >> 32);
-				split[1] = htonl(offset & 0xffffffff);
-				sha1write(f, split, 8);
-				nr_large_offset--;
-			}
-		}
-	}
-
-	sha1write(f, sha1, 20);
-	sha1close(f, NULL, 1);
-	free(sorted_by_sha);
-	SHA1_Final(sha1, &ctx);
-	return index_name;
-}
-
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *keep_name, const char *keep_msg,
@@ -830,6 +692,7 @@ int main(int argc, char **argv)
 	const char *curr_index, *index_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
+	struct idx_object_entry **idx_objects;
 	unsigned char sha1[20];
 
 	for (i = 1; i < argc; i++) {
@@ -865,12 +728,12 @@ int main(int argc, char **argv)
 				index_name = argv[++i];
 			} else if (!prefixcmp(arg, "--index-version=")) {
 				char *c;
-				index_default_version = strtoul(arg + 16, &c, 10);
-				if (index_default_version > 2)
+				pack_idx_default_version = strtoul(arg + 16, &c, 10);
+				if (pack_idx_default_version > 2)
 					die("bad %s", arg);
 				if (*c == ',')
-					index_off32_limit = strtoul(c+1, &c, 0);
-				if (*c || index_off32_limit & 0x80000000)
+					pack_idx_off32_limit = strtoul(c+1, &c, 0);
+				if (*c || pack_idx_off32_limit & 0x80000000)
 					die("bad %s", arg);
 			} else
 				usage(index_pack_usage);
@@ -940,7 +803,13 @@ int main(int argc, char **argv)
 			    nr_deltas - nr_resolved_deltas);
 	}
 	free(deltas);
-	curr_index = write_index_file(index_name, sha1);
+
+	idx_objects = xmalloc((nr_objects) * sizeof(struct idx_object_entry *));
+	for (i = 0; i < nr_objects; i++)
+		idx_objects[i] = (struct idx_object_entry *) &objects[i];
+	curr_index = write_idx_file(index_name, idx_objects, nr_objects, sha1);
+	free(idx_objects);
+
 	final(pack_name, curr_pack,
 		index_name, curr_index,
 		keep_name, keep_msg,
diff --git a/pack-idx.c b/pack-idx.c
new file mode 100644
index 0000000..ccf232e
--- /dev/null
+++ b/pack-idx.c
@@ -0,0 +1,144 @@
+#include "cache.h"
+#include "pack.h"
+#include "csum-file.h"
+
+uint32_t pack_idx_default_version = 1;
+uint32_t pack_idx_off32_limit = 0x7fffffff;
+
+static int sha1_compare(const void *_a, const void *_b)
+{
+	struct idx_object_entry *a = *(struct idx_object_entry **)_a;
+	struct idx_object_entry *b = *(struct idx_object_entry **)_b;
+	return hashcmp(a->sha1, b->sha1);
+}
+
+/*
+ * On entry *sha1 contains the pack content SHA1 hash, on exit it is
+ * the SHA1 hash of sorted object names. The objects array passed in
+ * will be sorted by SHA1 on exit.
+ */
+const char *write_idx_file(const char *index_name, struct idx_object_entry **objects, int nr_objects, unsigned char *sha1)
+{
+	struct sha1file *f;
+	struct idx_object_entry **sorted_by_sha, **list, **last;
+	off_t last_obj_offset = 0;
+	uint32_t array[256];
+	int i, fd;
+	SHA_CTX ctx;
+	uint32_t index_version;
+
+	if (nr_objects) {
+		sorted_by_sha = objects;
+		list = sorted_by_sha;
+		last = sorted_by_sha + nr_objects;
+		for (i = 0; i < nr_objects; ++i) {
+			if (objects[i]->offset > last_obj_offset)
+				last_obj_offset = objects[i]->offset;
+		}
+		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
+		      sha1_compare);
+	}
+	else
+		sorted_by_sha = list = last = NULL;
+
+	if (!index_name) {
+		static char tmpfile[PATH_MAX];
+		snprintf(tmpfile, sizeof(tmpfile),
+			 "%s/tmp_idx_XXXXXX", get_object_directory());
+		fd = mkstemp(tmpfile);
+		index_name = xstrdup(tmpfile);
+	} else {
+		unlink(index_name);
+		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	}
+	if (fd < 0)
+		die("unable to create %s: %s", index_name, strerror(errno));
+	f = sha1fd(fd, index_name);
+
+	/* if last object's offset is >= 2^31 we should use index V2 */
+	index_version = (last_obj_offset >> 31) ? 2 : pack_idx_default_version;
+
+	/* index versions 2 and above need a header */
+	if (index_version >= 2) {
+		struct pack_idx_header hdr;
+		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
+		hdr.idx_version = htonl(index_version);
+		sha1write(f, &hdr, sizeof(hdr));
+	}
+
+	/*
+	 * Write the first-level table (the list is sorted,
+	 * but we use a 256-entry lookup to be able to avoid
+	 * having to do eight extra binary search iterations).
+	 */
+	for (i = 0; i < 256; i++) {
+		struct idx_object_entry **next = list;
+		while (next < last) {
+			struct idx_object_entry *obj = *next;
+			if (obj->sha1[0] != i)
+				break;
+			next++;
+		}
+		array[i] = htonl(next - sorted_by_sha);
+		list = next;
+	}
+	sha1write(f, array, 256 * 4);
+
+	/* compute the SHA1 hash of sorted object names. */
+	SHA1_Init(&ctx);
+
+	/*
+	 * Write the actual SHA1 entries..
+	 */
+	list = sorted_by_sha;
+	for (i = 0; i < nr_objects; i++) {
+		struct idx_object_entry *obj = *list++;
+		if (index_version < 2) {
+			uint32_t offset = htonl(obj->offset);
+			sha1write(f, &offset, 4);
+		}
+		sha1write(f, obj->sha1, 20);
+		SHA1_Update(&ctx, obj->sha1, 20);
+	}
+
+	if (index_version >= 2) {
+		unsigned int nr_large_offset = 0;
+
+		/* write the crc32 table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct idx_object_entry *obj = *list++;
+			uint32_t crc32_val = htonl(obj->crc32);
+			sha1write(f, &crc32_val, 4);
+		}
+
+		/* write the 32-bit offset table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct idx_object_entry *obj = *list++;
+			uint32_t offset = (obj->offset <= pack_idx_off32_limit) ?
+				obj->offset : (0x80000000 | nr_large_offset++);
+			offset = htonl(offset);
+			sha1write(f, &offset, 4);
+		}
+
+		/* write the large offset table */
+		list = sorted_by_sha;
+		while (nr_large_offset) {
+			struct idx_object_entry *obj = *list++;
+			uint64_t offset = obj->offset;
+			if (offset > pack_idx_off32_limit) {
+				uint32_t split[2];
+				split[0]	= htonl(offset >> 32);
+				split[1] = htonl(offset & 0xffffffff);
+				sha1write(f, split, 8);
+				nr_large_offset--;
+			}
+		}
+	}
+
+	sha1write(f, sha1, 20);
+	sha1close(f, NULL, 1);
+	SHA1_Final(sha1, &ctx);
+	return index_name;
+}
diff --git a/pack.h b/pack.h
index d667fb8..f6c5f2c 100644
--- a/pack.h
+++ b/pack.h
@@ -34,6 +34,10 @@ struct pack_header {
  */
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
+/* These may be overridden by command-line parameters */
+extern uint32_t pack_idx_default_version;
+extern uint32_t pack_idx_off32_limit;
+
 /*
  * Packed object index header
  */
@@ -42,6 +46,17 @@ struct pack_idx_header {
 	uint32_t idx_version;
 };
 
+/*
+ * Common part of object structure used for write_idx_file
+ */
+struct idx_object_entry {
+	unsigned char sha1[20];
+	off_t offset;
+	unsigned long size;
+	uint32_t crc32;
+};
+
+extern const char *write_idx_file(const char *index_name, struct idx_object_entry **objects, int nr_objects, unsigned char *sha1);
 
 extern int verify_pack(struct packed_git *, int);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t);
-- 
1.5.1
