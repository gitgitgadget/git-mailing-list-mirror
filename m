From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 03/24] read-cache: move index v2 specific functions to their own file
Date: Wed, 27 Nov 2013 13:00:38 +0100
Message-ID: <1385553659-9928-4-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldoN-0001kc-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab3K0MBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:36 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:64350 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab3K0MBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:34 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so3355957lam.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNgk1FgKWapxC9dyWlwtVUDs5ViLbsSClaeC+bC1v2w=;
        b=e7SnsqezjqFyBwFS6FLT7sQ6lAsDTdvLHgDnTPJ2tUbCt9yaAJYJB2QLQl5vSweNDx
         AZAB59El43pGjOcrY5cj29OYbH9fDDWRjwdhDMqDJ87iLNiBv+lqhaIpbAKer5Ab5q5c
         cMxbp4fgmS7hlfNGbdqPTHsU0aReRnlro9qIE9qdl0iv5SMvYGdhYM55x5m7r8EkGvmf
         rwXO0XJiYBcRNUPgXCnq5lTdVpWHq9a7AbeZPmZLKSY4KUe4XGcKlm2QYFi25GRdipPL
         gvNeRiCwN2v6zr9J/NLQmqCaNMqbdeK8WX46bS230pH/KvPNqVymK+rC39U41JblPilC
         GR9g==
X-Received: by 10.152.204.39 with SMTP id kv7mr13297lac.42.1385553692715;
        Wed, 27 Nov 2013 04:01:32 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id mq10sm44230010lbb.12.2013.11.27.04.01.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:31 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238419>

Move index version 2 specific functions to their own file. The non-index
specific functions will be in read-cache.c, while the index version 2
specific functions will be in read-cache-v2.c.

Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile               |   2 +
 builtin/apply.c        |   2 +
 builtin/update-index.c |   2 +-
 cache.h                |  13 +-
 read-cache-v2.c        | 553 ++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.c           | 585 +++++--------------------------------------------
 read-cache.h           |  63 ++++++
 test-index-version.c   |   6 +
 unpack-trees.c         |   3 +-
 9 files changed, 683 insertions(+), 546 deletions(-)
 create mode 100644 read-cache-v2.c
 create mode 100644 read-cache.h

diff --git a/Makefile b/Makefile
index af847f8..5c28777 100644
--- a/Makefile
+++ b/Makefile
@@ -705,6 +705,7 @@ LIB_H += progress.h
 LIB_H += prompt.h
 LIB_H += quote.h
 LIB_H += reachable.h
+LIB_H += read-cache.h
 LIB_H += reflog-walk.h
 LIB_H += refs.h
 LIB_H += remote.h
@@ -849,6 +850,7 @@ LIB_OBJS += prompt.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
+LIB_OBJS += read-cache-v2.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
diff --git a/builtin/apply.c b/builtin/apply.c
index ef32e4f..a954147 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3682,6 +3682,8 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			die ("Could not add %s to temporary index", name);
 	}
 
+	if (!result.initialized)
+		initialize_index(&result, 0);
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0 || write_index(&result, fd) || close(fd))
 		die ("Could not write temporary index to %s", filename);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e3a10d7..c5bb889 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -863,7 +863,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 		if (the_index.version != preferred_index_format)
 			active_cache_changed = 1;
-		the_index.version = preferred_index_format;
+		change_cache_version(preferred_index_format);
 	}
 
 	if (read_from_stdin) {
diff --git a/cache.h b/cache.h
index ce377e1..290e26d 100644
--- a/cache.h
+++ b/cache.h
@@ -95,16 +95,8 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
  */
 #define DEFAULT_GIT_PORT 9418
 
-/*
- * Basic data structures for the directory cache
- */
 
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
-struct cache_header {
-	uint32_t hdr_signature;
-	uint32_t hdr_version;
-	uint32_t hdr_entries;
-};
 
 #define INDEX_FORMAT_LB 2
 #define INDEX_FORMAT_UB 4
@@ -279,6 +271,7 @@ struct index_state {
 		 initialized : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
+	struct index_ops *ops;
 };
 
 extern struct index_state the_index;
@@ -296,6 +289,8 @@ extern void free_name_hash(struct index_state *istate);
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
 
+#define initialize_cache() initialize_index(&the_index, 0)
+#define change_cache_version(version) change_index_version(&the_index, (version))
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
 #define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
@@ -455,6 +450,8 @@ extern void sanitize_stdfds(void);
 	} while (0)
 
 /* Initialize and use the cache information */
+extern void initialize_index(struct index_state *istate, int version);
+extern void change_index_version(struct index_state *istate, int version);
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
 extern int read_index_from(struct index_state *, const char *path);
diff --git a/read-cache-v2.c b/read-cache-v2.c
new file mode 100644
index 0000000..a7d076c
--- /dev/null
+++ b/read-cache-v2.c
@@ -0,0 +1,553 @@
+#include "cache.h"
+#include "read-cache.h"
+#include "resolve-undo.h"
+#include "cache-tree.h"
+#include "varint.h"
+
+/* Mask for the name length in ce_flags in the on-disk index */
+#define CE_NAMEMASK  (0x0fff)
+
+/*****************************************************************
+ * Index File I/O
+ *****************************************************************/
+
+/*
+ * dev/ino/uid/gid/size are also just tracked to the low 32 bits
+ * Again - this is just a (very strong in practice) heuristic that
+ * the inode hasn't changed.
+ *
+ * We save the fields in big-endian order to allow using the
+ * index file over NFS transparently.
+ */
+struct ondisk_cache_entry {
+	struct cache_time ctime;
+	struct cache_time mtime;
+	uint32_t dev;
+	uint32_t ino;
+	uint32_t mode;
+	uint32_t uid;
+	uint32_t gid;
+	uint32_t size;
+	unsigned char sha1[20];
+	uint16_t flags;
+	char name[FLEX_ARRAY]; /* more */
+};
+
+/*
+ * This struct is used when CE_EXTENDED bit is 1
+ * The struct must match ondisk_cache_entry exactly from
+ * ctime till flags
+ */
+struct ondisk_cache_entry_extended {
+	struct cache_time ctime;
+	struct cache_time mtime;
+	uint32_t dev;
+	uint32_t ino;
+	uint32_t mode;
+	uint32_t uid;
+	uint32_t gid;
+	uint32_t size;
+	unsigned char sha1[20];
+	uint16_t flags;
+	uint16_t flags2;
+	char name[FLEX_ARRAY]; /* more */
+};
+
+/* These are only used for v3 or lower */
+#define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
+#define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
+#define ondisk_cache_entry_extended_size(len) align_flex_name(ondisk_cache_entry_extended,len)
+#define ondisk_ce_size(ce) (((ce)->ce_flags & CE_EXTENDED) ? \
+			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
+			    ondisk_cache_entry_size(ce_namelen(ce)))
+
+static int verify_hdr(void *mmap, unsigned long size)
+{
+	git_SHA_CTX c;
+	unsigned char sha1[20];
+
+	if (size < + sizeof(struct cache_header) + 20)
+		die("index file smaller than expected");
+
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, mmap, size - 20);
+	git_SHA1_Final(sha1, &c);
+	if (hashcmp(sha1, (unsigned char *)mmap + size - 20))
+		return error("bad index file sha1 signature");
+	return 0;
+}
+
+static int match_stat_basic(const struct cache_entry *ce,
+			    struct stat *st, int changed)
+{
+	changed |= match_stat_data(&ce->ce_stat_data, st);
+
+	/* Racily smudged entry? */
+	if (!ce->ce_stat_data.sd_size) {
+		if (!is_empty_blob_sha1(ce->sha1))
+			changed |= DATA_CHANGED;
+	}
+	return changed;
+}
+
+static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
+						   unsigned int flags,
+						   const char *name,
+						   size_t len)
+{
+	struct cache_entry *ce = xmalloc(cache_entry_size(len));
+
+	ce->ce_stat_data.sd_ctime.sec = ntoh_l(ondisk->ctime.sec);
+	ce->ce_stat_data.sd_mtime.sec = ntoh_l(ondisk->mtime.sec);
+	ce->ce_stat_data.sd_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
+	ce->ce_stat_data.sd_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
+	ce->ce_stat_data.sd_dev   = ntoh_l(ondisk->dev);
+	ce->ce_stat_data.sd_ino   = ntoh_l(ondisk->ino);
+	ce->ce_mode  = ntoh_l(ondisk->mode);
+	ce->ce_stat_data.sd_uid   = ntoh_l(ondisk->uid);
+	ce->ce_stat_data.sd_gid   = ntoh_l(ondisk->gid);
+	ce->ce_stat_data.sd_size  = ntoh_l(ondisk->size);
+	ce->ce_flags = flags & ~CE_NAMEMASK;
+	ce->ce_namelen = len;
+	hashcpy(ce->sha1, ondisk->sha1);
+	memcpy(ce->name, name, len);
+	ce->name[len] = '\0';
+	return ce;
+}
+
+/*
+ * Adjacent cache entries tend to share the leading paths, so it makes
+ * sense to only store the differences in later entries.  In the v4
+ * on-disk format of the index, each on-disk cache entry stores the
+ * number of bytes to be stripped from the end of the previous name,
+ * and the bytes to append to the result, to come up with its name.
+ */
+static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
+{
+	const unsigned char *ep, *cp = (const unsigned char *)cp_;
+	size_t len = decode_varint(&cp);
+
+	if (name->len < len)
+		die("malformed name field in the index");
+	strbuf_remove(name, name->len - len, len);
+	for (ep = cp; *ep; ep++)
+		; /* find the end */
+	strbuf_add(name, cp, ep - cp);
+	return (const char *)ep + 1 - cp_;
+}
+
+static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
+					    unsigned long *ent_size,
+					    struct strbuf *previous_name)
+{
+	struct cache_entry *ce;
+	size_t len;
+	const char *name;
+	unsigned int flags;
+
+	/* On-disk flags are just 16 bits */
+	flags = ntoh_s(ondisk->flags);
+	len = flags & CE_NAMEMASK;
+
+	if (flags & CE_EXTENDED) {
+		struct ondisk_cache_entry_extended *ondisk2;
+		int extended_flags;
+		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
+		extended_flags = ntoh_s(ondisk2->flags2) << 16;
+		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
+		if (extended_flags & ~CE_EXTENDED_FLAGS)
+			die("Unknown index entry format %08x", extended_flags);
+		flags |= extended_flags;
+		name = ondisk2->name;
+	}
+	else
+		name = ondisk->name;
+
+	if (!previous_name) {
+		/* v3 and earlier */
+		if (len == CE_NAMEMASK)
+			len = strlen(name);
+		ce = cache_entry_from_ondisk(ondisk, flags, name, len);
+
+		*ent_size = ondisk_ce_size(ce);
+	} else {
+		unsigned long consumed;
+		consumed = expand_name_field(previous_name, name);
+		ce = cache_entry_from_ondisk(ondisk, flags,
+					     previous_name->buf,
+					     previous_name->len);
+
+		*ent_size = (name - ((char *)ondisk)) + consumed;
+	}
+	return ce;
+}
+
+static int read_index_extension(struct index_state *istate,
+				const char *ext, void *data, unsigned long sz)
+{
+	switch (CACHE_EXT(ext)) {
+	case CACHE_EXT_TREE:
+		istate->cache_tree = cache_tree_read(data, sz);
+		break;
+	case CACHE_EXT_RESOLVE_UNDO:
+		istate->resolve_undo = resolve_undo_read(data, sz);
+		break;
+	default:
+		if (*ext < 'A' || 'Z' < *ext)
+			return error("index uses %.4s extension, which we do not understand",
+				     ext);
+		fprintf(stderr, "ignoring %.4s extension\n", ext);
+		break;
+	}
+	return 0;
+}
+
+static int read_index_v2(struct index_state *istate, void *mmap,
+			 unsigned long mmap_size)
+{
+	int i;
+	unsigned long src_offset;
+	struct cache_header *hdr;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+
+	hdr = mmap;
+	istate->cache_nr = ntohl(hdr->hdr_entries);
+	istate->cache_alloc = alloc_nr(istate->cache_nr);
+	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
+
+	if (istate->version == 4)
+		previous_name = &previous_name_buf;
+	else
+		previous_name = NULL;
+
+	src_offset = sizeof(*hdr);
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct ondisk_cache_entry *disk_ce;
+		struct cache_entry *ce;
+		unsigned long consumed;
+
+		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		ce = create_from_disk(disk_ce, &consumed, previous_name);
+		set_index_entry(istate, i, ce);
+
+		src_offset += consumed;
+	}
+	strbuf_release(&previous_name_buf);
+
+	while (src_offset <= mmap_size - 20 - 8) {
+		/* After an array of active_nr index entries,
+		 * there can be arbitrary number of extended
+		 * sections, each of which is prefixed with
+		 * extension name (4-byte) and section length
+		 * in 4-byte network byte order.
+		 */
+		uint32_t extsize;
+		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
+		extsize = ntohl(extsize);
+		if (read_index_extension(istate,
+					(const char *) mmap + src_offset,
+					(char *) mmap + src_offset + 8,
+					extsize) < 0)
+			goto unmap;
+		src_offset += 8;
+		src_offset += extsize;
+	}
+	return 0;
+unmap:
+	munmap(mmap, mmap_size);
+	die("index file corrupt");
+}
+
+#define WRITE_BUFFER_SIZE 8192
+static unsigned char write_buffer[WRITE_BUFFER_SIZE];
+static unsigned long write_buffer_len;
+
+static int ce_write_flush(git_SHA_CTX *context, int fd)
+{
+	unsigned int buffered = write_buffer_len;
+	if (buffered) {
+		git_SHA1_Update(context, write_buffer, buffered);
+		if (write_in_full(fd, write_buffer, buffered) != buffered)
+			return -1;
+		write_buffer_len = 0;
+	}
+	return 0;
+}
+
+static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
+{
+	while (len) {
+		unsigned int buffered = write_buffer_len;
+		unsigned int partial = WRITE_BUFFER_SIZE - buffered;
+		if (partial > len)
+			partial = len;
+		memcpy(write_buffer + buffered, data, partial);
+		buffered += partial;
+		if (buffered == WRITE_BUFFER_SIZE) {
+			write_buffer_len = buffered;
+			if (ce_write_flush(context, fd))
+				return -1;
+			buffered = 0;
+		}
+		write_buffer_len = buffered;
+		len -= partial;
+		data = (char *) data + partial;
+	}
+	return 0;
+}
+
+static int write_index_ext_header(git_SHA_CTX *context, int fd,
+				  unsigned int ext, unsigned int sz)
+{
+	ext = htonl(ext);
+	sz = htonl(sz);
+	return ((ce_write(context, fd, &ext, 4) < 0) ||
+		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
+}
+
+static int ce_flush(git_SHA_CTX *context, int fd)
+{
+	unsigned int left = write_buffer_len;
+
+	if (left) {
+		write_buffer_len = 0;
+		git_SHA1_Update(context, write_buffer, left);
+	}
+
+	/* Flush first if not enough space for SHA1 signature */
+	if (left + 20 > WRITE_BUFFER_SIZE) {
+		if (write_in_full(fd, write_buffer, left) != left)
+			return -1;
+		left = 0;
+	}
+
+	/* Append the SHA1 signature at the end */
+	git_SHA1_Final(write_buffer + left, context);
+	left += 20;
+	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
+}
+
+static void ce_smudge_racily_clean_entry(struct index_state *istate, struct cache_entry *ce)
+{
+	/*
+	 * The only thing we care about in this function is to smudge the
+	 * falsely clean entry due to touch-update-touch race, so we leave
+	 * everything else as they are.  We are called for entries whose
+	 * ce_stat_data.sd_mtime match the index file mtime.
+	 *
+	 * Note that this actually does not do much for gitlinks, for
+	 * which ce_match_stat_basic() always goes to the actual
+	 * contents.  The caller checks with is_racy_timestamp() which
+	 * always says "no" for gitlinks, so we are not called for them ;-)
+	 */
+	struct stat st;
+
+	if (lstat(ce->name, &st) < 0)
+		return;
+	if (ce_match_stat_basic(istate, ce, &st))
+		return;
+	if (ce_modified_check_fs(ce, &st)) {
+		/* This is "racily clean"; smudge it.  Note that this
+		 * is a tricky code.  At first glance, it may appear
+		 * that it can break with this sequence:
+		 *
+		 * $ echo xyzzy >frotz
+		 * $ git-update-index --add frotz
+		 * $ : >frotz
+		 * $ sleep 3
+		 * $ echo filfre >nitfol
+		 * $ git-update-index --add nitfol
+		 *
+		 * but it does not.  When the second update-index runs,
+		 * it notices that the entry "frotz" has the same timestamp
+		 * as index, and if we were to smudge it by resetting its
+		 * size to zero here, then the object name recorded
+		 * in index is the 6-byte file but the cached stat information
+		 * becomes zero --- which would then match what we would
+		 * obtain from the filesystem next time we stat("frotz").
+		 *
+		 * However, the second update-index, before calling
+		 * this function, notices that the cached size is 6
+		 * bytes and what is on the filesystem is an empty
+		 * file, and never calls us, so the cached size information
+		 * for "frotz" stays 6 which does not match the filesystem.
+		 */
+		ce->ce_stat_data.sd_size = 0;
+	}
+}
+
+/* Copy miscellaneous fields but not the name */
+static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
+				       struct cache_entry *ce)
+{
+	short flags;
+
+	ondisk->ctime.sec = htonl(ce->ce_stat_data.sd_ctime.sec);
+	ondisk->mtime.sec = htonl(ce->ce_stat_data.sd_mtime.sec);
+	ondisk->ctime.nsec = htonl(ce->ce_stat_data.sd_ctime.nsec);
+	ondisk->mtime.nsec = htonl(ce->ce_stat_data.sd_mtime.nsec);
+	ondisk->dev  = htonl(ce->ce_stat_data.sd_dev);
+	ondisk->ino  = htonl(ce->ce_stat_data.sd_ino);
+	ondisk->mode = htonl(ce->ce_mode);
+	ondisk->uid  = htonl(ce->ce_stat_data.sd_uid);
+	ondisk->gid  = htonl(ce->ce_stat_data.sd_gid);
+	ondisk->size = htonl(ce->ce_stat_data.sd_size);
+	hashcpy(ondisk->sha1, ce->sha1);
+
+	flags = ce->ce_flags;
+	flags |= (ce_namelen(ce) >= CE_NAMEMASK ? CE_NAMEMASK : ce_namelen(ce));
+	ondisk->flags = htons(flags);
+	if (ce->ce_flags & CE_EXTENDED) {
+		struct ondisk_cache_entry_extended *ondisk2;
+		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
+		ondisk2->flags2 = htons((ce->ce_flags & CE_EXTENDED_FLAGS) >> 16);
+		return ondisk2->name;
+	}
+	else {
+		return ondisk->name;
+	}
+}
+
+static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
+			  struct strbuf *previous_name)
+{
+	int size;
+	struct ondisk_cache_entry *ondisk;
+	char *name;
+	int result;
+
+	if (!previous_name) {
+		size = ondisk_ce_size(ce);
+		ondisk = xcalloc(1, size);
+		name = copy_cache_entry_to_ondisk(ondisk, ce);
+		memcpy(name, ce->name, ce_namelen(ce));
+	} else {
+		int common, to_remove, prefix_size;
+		unsigned char to_remove_vi[16];
+		for (common = 0;
+		     (ce->name[common] &&
+		      common < previous_name->len &&
+		      ce->name[common] == previous_name->buf[common]);
+		     common++)
+			; /* still matching */
+		to_remove = previous_name->len - common;
+		prefix_size = encode_varint(to_remove, to_remove_vi);
+
+		if (ce->ce_flags & CE_EXTENDED)
+			size = offsetof(struct ondisk_cache_entry_extended, name);
+		else
+			size = offsetof(struct ondisk_cache_entry, name);
+		size += prefix_size + (ce_namelen(ce) - common + 1);
+
+		ondisk = xcalloc(1, size);
+		name = copy_cache_entry_to_ondisk(ondisk, ce);
+		memcpy(name, to_remove_vi, prefix_size);
+		memcpy(name + prefix_size, ce->name + common, ce_namelen(ce) - common);
+
+		strbuf_splice(previous_name, common, to_remove,
+			      ce->name + common, ce_namelen(ce) - common);
+	}
+
+	result = ce_write(c, fd, ondisk, size);
+	free(ondisk);
+	return result;
+}
+
+static int write_index_v2(struct index_state *istate, int newfd)
+{
+	git_SHA_CTX c;
+	struct cache_header hdr;
+	int i, err, removed, extended, hdr_version;
+	struct cache_entry **cache = istate->cache;
+	int entries = istate->cache_nr;
+	struct stat st;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+
+	for (i = removed = extended = 0; i < entries; i++) {
+		if (cache[i]->ce_flags & CE_REMOVE)
+			removed++;
+
+		/* reduce extended entries if possible */
+		cache[i]->ce_flags &= ~CE_EXTENDED;
+		if (cache[i]->ce_flags & CE_EXTENDED_FLAGS) {
+			extended++;
+			cache[i]->ce_flags |= CE_EXTENDED;
+		}
+	}
+
+	if (!istate->version)
+		istate->version = INDEX_FORMAT_DEFAULT;
+
+	/* demote version 3 to version 2 when the latter suffices */
+	if (istate->version == 3 || istate->version == 2)
+		istate->version = extended ? 3 : 2;
+
+	hdr_version = istate->version;
+
+	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
+	hdr.hdr_version = htonl(hdr_version);
+	hdr.hdr_entries = htonl(entries - removed);
+
+	git_SHA1_Init(&c);
+	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
+		return -1;
+
+	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = cache[i];
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
+			ce_smudge_racily_clean_entry(istate, ce);
+		if (is_null_sha1(ce->sha1)) {
+			static const char msg[] = "cache entry has null sha1: %s";
+			static int allow = -1;
+
+			if (allow < 0)
+				allow = git_env_bool("GIT_ALLOW_NULL_SHA1", 0);
+			if (allow)
+				warning(msg, ce->name);
+			else
+				return error(msg, ce->name);
+		}
+		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
+			return -1;
+	}
+	strbuf_release(&previous_name_buf);
+
+	/* Write extension data here */
+	if (istate->cache_tree) {
+		struct strbuf sb = STRBUF_INIT;
+
+		cache_tree_write(&sb, istate->cache_tree);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
+	if (istate->resolve_undo) {
+		struct strbuf sb = STRBUF_INIT;
+
+		resolve_undo_write(&sb, istate->resolve_undo);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+					     sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
+
+	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+		return -1;
+	istate->timestamp.sec = (unsigned int)st.st_mtime;
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	return 0;
+}
+
+struct index_ops v2_ops = {
+	match_stat_basic,
+	verify_hdr,
+	read_index_v2,
+	write_index_v2
+};
diff --git a/read-cache.c b/read-cache.c
index 5a8f405..e081084 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "read-cache.h"
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
@@ -17,26 +18,9 @@
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 
-/* Mask for the name length in ce_flags in the on-disk index */
-
-#define CE_NAMEMASK  (0x0fff)
-
-/* Index extensions.
- *
- * The first letter should be 'A'..'Z' for extensions that are not
- * necessary for a correct operation (i.e. optimization data).
- * When new extensions are added that _needs_ to be understood in
- * order to correctly interpret the index file, pick character that
- * is outside the range, to cause the reader to abort.
- */
-
-#define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
-#define CACHE_EXT_TREE 0x54524545	/* "TREE" */
-#define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
-
 struct index_state the_index;
 
-static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
 	istate->cache[nr] = ce;
 	add_name_hash(istate, ce);
@@ -190,7 +174,7 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	return hashcmp(sha1, ce->sha1);
 }
 
-static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
+int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
 {
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
@@ -210,7 +194,18 @@ static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
+/*
+ * Check if the reading/writing operations are set and set them
+ * to the correct version
+ */
+static void set_istate_ops(struct index_state *istate)
+{
+	if (istate->version >= 2 && istate->version <= 4)
+		istate->ops = &v2_ops;
+}
+
+int ce_match_stat_basic(const struct index_state *istate,
+			const struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
 
@@ -243,19 +238,13 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
 
-	changed |= match_stat_data(&ce->ce_stat_data, st);
-
-	/* Racily smudged entry? */
-	if (!ce->ce_stat_data.sd_size) {
-		if (!is_empty_blob_sha1(ce->sha1))
-			changed |= DATA_CHANGED;
-	}
-
+	changed = istate->ops->match_stat_basic(ce, st, changed);
 	return changed;
 }
 
-static int is_racy_timestamp(const struct index_state *istate,
-			     const struct cache_entry *ce)
+
+int is_racy_timestamp(const struct index_state *istate,
+		      const struct cache_entry *ce)
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
 		istate->timestamp.sec &&
@@ -298,7 +287,7 @@ int ie_match_stat(const struct index_state *istate,
 	if (ce->ce_flags & CE_INTENT_TO_ADD)
 		return DATA_CHANGED | TYPE_CHANGED | MODE_CHANGED;
 
-	changed = ce_match_stat_basic(ce, st);
+	changed = ce_match_stat_basic(istate, ce, st);
 
 	/*
 	 * Within 1 second of this sequence:
@@ -982,6 +971,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 {
 	int pos;
 
+	if (!istate->initialized)
+		initialize_index(istate, INDEX_FORMAT_DEFAULT);
 	if (option & ADD_CACHE_JUST_APPEND)
 		pos = istate->cache_nr;
 	else {
@@ -1212,13 +1203,25 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
 }
 
+void initialize_index(struct index_state *istate, int version)
+{
+	istate->initialized = 1;
+	if (!version)
+		version = INDEX_FORMAT_DEFAULT;
+	istate->version = version;
+	set_istate_ops(istate);
+}
+
+void change_index_version(struct index_state *istate, int version)
+{
+	istate->version = version;
+	set_istate_ops(istate);
+}
 
 /*****************************************************************
  * Index File I/O
  *****************************************************************/
 
-#define INDEX_FORMAT_DEFAULT 3
-
 /*
  * dev/ino/uid/gid/size are also just tracked to the low 32 bits
  * Again - this is just a (very strong in practice) heuristic that
@@ -1269,7 +1272,8 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr_version(struct cache_header *hdr, unsigned long size)
+static int verify_hdr_version(struct index_state *istate,
+			      struct cache_header *hdr, unsigned long size)
 {
 	int hdr_version;
 
@@ -1278,42 +1282,7 @@ static int verify_hdr_version(struct cache_header *hdr, unsigned long size)
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
-	return 0;
-}
-
-static int verify_hdr(void *mmap, unsigned long size)
-{
-	git_SHA_CTX c;
-	unsigned char sha1[20];
-
-	if (size < sizeof(struct cache_header) + 20)
-		die("index file smaller than expected");
-
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, mmap, size - 20);
-	git_SHA1_Final(sha1, &c);
-	if (hashcmp(sha1, (unsigned char *)mmap + size - 20))
-		return error("bad index file sha1 signature");
-	return 0;
-}
-
-static int read_index_extension(struct index_state *istate,
-				const char *ext, void *data, unsigned long sz)
-{
-	switch (CACHE_EXT(ext)) {
-	case CACHE_EXT_TREE:
-		istate->cache_tree = cache_tree_read(data, sz);
-		break;
-	case CACHE_EXT_RESOLVE_UNDO:
-		istate->resolve_undo = resolve_undo_read(data, sz);
-		break;
-	default:
-		if (*ext < 'A' || 'Z' < *ext)
-			return error("index uses %.4s extension, which we do not understand",
-				     ext);
-		fprintf(stderr, "ignoring %.4s extension\n", ext);
-		break;
-	}
+	initialize_index(istate, hdr_version);
 	return 0;
 }
 
@@ -1322,176 +1291,6 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
-#ifndef NEEDS_ALIGNED_ACCESS
-#define ntoh_s(var) ntohs(var)
-#define ntoh_l(var) ntohl(var)
-#else
-static inline uint16_t ntoh_s_force_align(void *p)
-{
-	uint16_t x;
-	memcpy(&x, p, sizeof(x));
-	return ntohs(x);
-}
-static inline uint32_t ntoh_l_force_align(void *p)
-{
-	uint32_t x;
-	memcpy(&x, p, sizeof(x));
-	return ntohl(x);
-}
-#define ntoh_s(var) ntoh_s_force_align(&(var))
-#define ntoh_l(var) ntoh_l_force_align(&(var))
-#endif
-
-static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
-						   unsigned int flags,
-						   const char *name,
-						   size_t len)
-{
-	struct cache_entry *ce = xmalloc(cache_entry_size(len));
-
-	ce->ce_stat_data.sd_ctime.sec = ntoh_l(ondisk->ctime.sec);
-	ce->ce_stat_data.sd_mtime.sec = ntoh_l(ondisk->mtime.sec);
-	ce->ce_stat_data.sd_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
-	ce->ce_stat_data.sd_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
-	ce->ce_stat_data.sd_dev   = ntoh_l(ondisk->dev);
-	ce->ce_stat_data.sd_ino   = ntoh_l(ondisk->ino);
-	ce->ce_mode  = ntoh_l(ondisk->mode);
-	ce->ce_stat_data.sd_uid   = ntoh_l(ondisk->uid);
-	ce->ce_stat_data.sd_gid   = ntoh_l(ondisk->gid);
-	ce->ce_stat_data.sd_size  = ntoh_l(ondisk->size);
-	ce->ce_flags = flags & ~CE_NAMEMASK;
-	ce->ce_namelen = len;
-	hashcpy(ce->sha1, ondisk->sha1);
-	memcpy(ce->name, name, len);
-	ce->name[len] = '\0';
-	return ce;
-}
-
-/*
- * Adjacent cache entries tend to share the leading paths, so it makes
- * sense to only store the differences in later entries.  In the v4
- * on-disk format of the index, each on-disk cache entry stores the
- * number of bytes to be stripped from the end of the previous name,
- * and the bytes to append to the result, to come up with its name.
- */
-static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
-{
-	const unsigned char *ep, *cp = (const unsigned char *)cp_;
-	size_t len = decode_varint(&cp);
-
-	if (name->len < len)
-		die("malformed name field in the index");
-	strbuf_remove(name, name->len - len, len);
-	for (ep = cp; *ep; ep++)
-		; /* find the end */
-	strbuf_add(name, cp, ep - cp);
-	return (const char *)ep + 1 - cp_;
-}
-
-static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
-					    unsigned long *ent_size,
-					    struct strbuf *previous_name)
-{
-	struct cache_entry *ce;
-	size_t len;
-	const char *name;
-	unsigned int flags;
-
-	/* On-disk flags are just 16 bits */
-	flags = ntoh_s(ondisk->flags);
-	len = flags & CE_NAMEMASK;
-
-	if (flags & CE_EXTENDED) {
-		struct ondisk_cache_entry_extended *ondisk2;
-		int extended_flags;
-		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		extended_flags = ntoh_s(ondisk2->flags2) << 16;
-		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
-		if (extended_flags & ~CE_EXTENDED_FLAGS)
-			die("Unknown index entry format %08x", extended_flags);
-		flags |= extended_flags;
-		name = ondisk2->name;
-	}
-	else
-		name = ondisk->name;
-
-	if (!previous_name) {
-		/* v3 and earlier */
-		if (len == CE_NAMEMASK)
-			len = strlen(name);
-		ce = cache_entry_from_ondisk(ondisk, flags, name, len);
-
-		*ent_size = ondisk_ce_size(ce);
-	} else {
-		unsigned long consumed;
-		consumed = expand_name_field(previous_name, name);
-		ce = cache_entry_from_ondisk(ondisk, flags,
-					     previous_name->buf,
-					     previous_name->len);
-
-		*ent_size = (name - ((char *)ondisk)) + consumed;
-	}
-	return ce;
-}
-
-static int read_index_v2(struct index_state *istate, void *mmap, unsigned long mmap_size)
-{
-	int i;
-	unsigned long src_offset;
-	struct cache_header *hdr;
-	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-
-	hdr = mmap;
-
-	istate->version = ntohl(hdr->hdr_version);
-	istate->cache_nr = ntohl(hdr->hdr_entries);
-	istate->cache_alloc = alloc_nr(istate->cache_nr);
-	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
-	istate->initialized = 1;
-
-	if (istate->version == 4)
-		previous_name = &previous_name_buf;
-	else
-		previous_name = NULL;
-
-	src_offset = sizeof(*hdr);
-	for (i = 0; i < istate->cache_nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
-		struct cache_entry *ce;
-		unsigned long consumed;
-
-		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(disk_ce, &consumed, previous_name);
-		set_index_entry(istate, i, ce);
-
-		src_offset += consumed;
-	}
-	strbuf_release(&previous_name_buf);
-
-	while (src_offset <= mmap_size - 20 - 8) {
-		/* After an array of active_nr index entries,
-		 * there can be arbitrary number of extended
-		 * sections, each of which is prefixed with
-		 * extension name (4-byte) and section length
-		 * in 4-byte network byte order.
-		 */
-		uint32_t extsize;
-		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
-		extsize = ntohl(extsize);
-		if (read_index_extension(istate,
-					 (const char *) mmap + src_offset,
-					 (char *) mmap + src_offset + 8,
-					 extsize) < 0)
-			goto unmap;
-		src_offset += 8;
-		src_offset += extsize;
-	}
-	return 0;
-unmap:
-	munmap(mmap, mmap_size);
-	die("index file corrupt");
-}
-
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1508,10 +1307,13 @@ int read_index_from(struct index_state *istate, const char *path)
 	errno = ENOENT;
 	istate->timestamp.sec = 0;
 	istate->timestamp.nsec = 0;
+
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno == ENOENT)
+		if (errno == ENOENT) {
+			initialize_index(istate, 0);
 			return 0;
+		}
 		die_errno("index file open failed");
 	}
 
@@ -1520,24 +1322,23 @@ int read_index_from(struct index_state *istate, const char *path)
 
 	errno = EINVAL;
 	mmap_size = xsize_t(st.st_size);
-	if (mmap_size < sizeof(struct cache_header) + 20)
-		die("index file smaller than expected");
-
 	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (mmap == MAP_FAILED)
 		die_errno("unable to map index file");
 
 	hdr = mmap;
-	if (verify_hdr_version(hdr, mmap_size) < 0)
+	if (verify_hdr_version(istate, hdr, mmap_size) < 0)
 		goto unmap;
 
-	if (verify_hdr(mmap, mmap_size) < 0)
+	if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
 		goto unmap;
 
-	read_index_v2(istate, mmap, mmap_size);
+	if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
+		goto unmap;
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
@@ -1568,6 +1369,7 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache = NULL;
 	istate->cache_alloc = 0;
+	istate->ops = NULL;
 	return 0;
 }
 
@@ -1581,201 +1383,6 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-#define WRITE_BUFFER_SIZE 8192
-static unsigned char write_buffer[WRITE_BUFFER_SIZE];
-static unsigned long write_buffer_len;
-
-static int ce_write_flush(git_SHA_CTX *context, int fd)
-{
-	unsigned int buffered = write_buffer_len;
-	if (buffered) {
-		git_SHA1_Update(context, write_buffer, buffered);
-		if (write_in_full(fd, write_buffer, buffered) != buffered)
-			return -1;
-		write_buffer_len = 0;
-	}
-	return 0;
-}
-
-static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
-{
-	while (len) {
-		unsigned int buffered = write_buffer_len;
-		unsigned int partial = WRITE_BUFFER_SIZE - buffered;
-		if (partial > len)
-			partial = len;
-		memcpy(write_buffer + buffered, data, partial);
-		buffered += partial;
-		if (buffered == WRITE_BUFFER_SIZE) {
-			write_buffer_len = buffered;
-			if (ce_write_flush(context, fd))
-				return -1;
-			buffered = 0;
-		}
-		write_buffer_len = buffered;
-		len -= partial;
-		data = (char *) data + partial;
-	}
-	return 0;
-}
-
-static int write_index_ext_header(git_SHA_CTX *context, int fd,
-				  unsigned int ext, unsigned int sz)
-{
-	ext = htonl(ext);
-	sz = htonl(sz);
-	return ((ce_write(context, fd, &ext, 4) < 0) ||
-		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
-}
-
-static int ce_flush(git_SHA_CTX *context, int fd)
-{
-	unsigned int left = write_buffer_len;
-
-	if (left) {
-		write_buffer_len = 0;
-		git_SHA1_Update(context, write_buffer, left);
-	}
-
-	/* Flush first if not enough space for SHA1 signature */
-	if (left + 20 > WRITE_BUFFER_SIZE) {
-		if (write_in_full(fd, write_buffer, left) != left)
-			return -1;
-		left = 0;
-	}
-
-	/* Append the SHA1 signature at the end */
-	git_SHA1_Final(write_buffer + left, context);
-	left += 20;
-	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
-}
-
-static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
-{
-	/*
-	 * The only thing we care about in this function is to smudge the
-	 * falsely clean entry due to touch-update-touch race, so we leave
-	 * everything else as they are.  We are called for entries whose
-	 * ce_stat_data.sd_mtime match the index file mtime.
-	 *
-	 * Note that this actually does not do much for gitlinks, for
-	 * which ce_match_stat_basic() always goes to the actual
-	 * contents.  The caller checks with is_racy_timestamp() which
-	 * always says "no" for gitlinks, so we are not called for them ;-)
-	 */
-	struct stat st;
-
-	if (lstat(ce->name, &st) < 0)
-		return;
-	if (ce_match_stat_basic(ce, &st))
-		return;
-	if (ce_modified_check_fs(ce, &st)) {
-		/* This is "racily clean"; smudge it.  Note that this
-		 * is a tricky code.  At first glance, it may appear
-		 * that it can break with this sequence:
-		 *
-		 * $ echo xyzzy >frotz
-		 * $ git-update-index --add frotz
-		 * $ : >frotz
-		 * $ sleep 3
-		 * $ echo filfre >nitfol
-		 * $ git-update-index --add nitfol
-		 *
-		 * but it does not.  When the second update-index runs,
-		 * it notices that the entry "frotz" has the same timestamp
-		 * as index, and if we were to smudge it by resetting its
-		 * size to zero here, then the object name recorded
-		 * in index is the 6-byte file but the cached stat information
-		 * becomes zero --- which would then match what we would
-		 * obtain from the filesystem next time we stat("frotz").
-		 *
-		 * However, the second update-index, before calling
-		 * this function, notices that the cached size is 6
-		 * bytes and what is on the filesystem is an empty
-		 * file, and never calls us, so the cached size information
-		 * for "frotz" stays 6 which does not match the filesystem.
-		 */
-		ce->ce_stat_data.sd_size = 0;
-	}
-}
-
-/* Copy miscellaneous fields but not the name */
-static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
-				       struct cache_entry *ce)
-{
-	short flags;
-
-	ondisk->ctime.sec = htonl(ce->ce_stat_data.sd_ctime.sec);
-	ondisk->mtime.sec = htonl(ce->ce_stat_data.sd_mtime.sec);
-	ondisk->ctime.nsec = htonl(ce->ce_stat_data.sd_ctime.nsec);
-	ondisk->mtime.nsec = htonl(ce->ce_stat_data.sd_mtime.nsec);
-	ondisk->dev  = htonl(ce->ce_stat_data.sd_dev);
-	ondisk->ino  = htonl(ce->ce_stat_data.sd_ino);
-	ondisk->mode = htonl(ce->ce_mode);
-	ondisk->uid  = htonl(ce->ce_stat_data.sd_uid);
-	ondisk->gid  = htonl(ce->ce_stat_data.sd_gid);
-	ondisk->size = htonl(ce->ce_stat_data.sd_size);
-	hashcpy(ondisk->sha1, ce->sha1);
-
-	flags = ce->ce_flags;
-	flags |= (ce_namelen(ce) >= CE_NAMEMASK ? CE_NAMEMASK : ce_namelen(ce));
-	ondisk->flags = htons(flags);
-	if (ce->ce_flags & CE_EXTENDED) {
-		struct ondisk_cache_entry_extended *ondisk2;
-		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		ondisk2->flags2 = htons((ce->ce_flags & CE_EXTENDED_FLAGS) >> 16);
-		return ondisk2->name;
-	}
-	else {
-		return ondisk->name;
-	}
-}
-
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
-			  struct strbuf *previous_name)
-{
-	int size;
-	struct ondisk_cache_entry *ondisk;
-	char *name;
-	int result;
-
-	if (!previous_name) {
-		size = ondisk_ce_size(ce);
-		ondisk = xcalloc(1, size);
-		name = copy_cache_entry_to_ondisk(ondisk, ce);
-		memcpy(name, ce->name, ce_namelen(ce));
-	} else {
-		int common, to_remove, prefix_size;
-		unsigned char to_remove_vi[16];
-		for (common = 0;
-		     (ce->name[common] &&
-		      common < previous_name->len &&
-		      ce->name[common] == previous_name->buf[common]);
-		     common++)
-			; /* still matching */
-		to_remove = previous_name->len - common;
-		prefix_size = encode_varint(to_remove, to_remove_vi);
-
-		if (ce->ce_flags & CE_EXTENDED)
-			size = offsetof(struct ondisk_cache_entry_extended, name);
-		else
-			size = offsetof(struct ondisk_cache_entry, name);
-		size += prefix_size + (ce_namelen(ce) - common + 1);
-
-		ondisk = xcalloc(1, size);
-		name = copy_cache_entry_to_ondisk(ondisk, ce);
-		memcpy(name, to_remove_vi, prefix_size);
-		memcpy(name + prefix_size, ce->name + common, ce_namelen(ce) - common);
-
-		strbuf_splice(previous_name, common, to_remove,
-			      ce->name + common, ce_namelen(ce) - common);
-	}
-
-	result = ce_write(c, fd, ondisk, size);
-	free(ondisk);
-	return result;
-}
-
 static int has_racy_timestamp(struct index_state *istate)
 {
 	int entries = istate->cache_nr;
@@ -1801,101 +1408,9 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
-static int write_index_v2(struct index_state *istate, int newfd)
-{
-	git_SHA_CTX c;
-	struct cache_header hdr;
-	int i, err, removed, extended, hdr_version;
-	struct cache_entry **cache = istate->cache;
-	int entries = istate->cache_nr;
-	struct stat st;
-	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-
-	for (i = removed = extended = 0; i < entries; i++) {
-		if (cache[i]->ce_flags & CE_REMOVE)
-			removed++;
-
-		/* reduce extended entries if possible */
-		cache[i]->ce_flags &= ~CE_EXTENDED;
-		if (cache[i]->ce_flags & CE_EXTENDED_FLAGS) {
-			extended++;
-			cache[i]->ce_flags |= CE_EXTENDED;
-		}
-	}
-
-	if (!istate->version)
-		istate->version = INDEX_FORMAT_DEFAULT;
-
-	/* demote version 3 to version 2 when the latter suffices */
-	if (istate->version == 3 || istate->version == 2)
-		istate->version = extended ? 3 : 2;
-
-	hdr_version = istate->version;
-
-	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
-	hdr.hdr_version = htonl(hdr_version);
-	hdr.hdr_entries = htonl(entries - removed);
-
-	git_SHA1_Init(&c);
-	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
-		return -1;
-
-	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = cache[i];
-		if (ce->ce_flags & CE_REMOVE)
-			continue;
-		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
-			ce_smudge_racily_clean_entry(ce);
-		if (is_null_sha1(ce->sha1)) {
-			static const char msg[] = "cache entry has null sha1: %s";
-			static int allow = -1;
-
-			if (allow < 0)
-				allow = git_env_bool("GIT_ALLOW_NULL_SHA1", 0);
-			if (allow)
-				warning(msg, ce->name);
-			else
-				return error(msg, ce->name);
-		}
-		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
-			return -1;
-	}
-	strbuf_release(&previous_name_buf);
-
-	/* Write extension data here */
-	if (istate->cache_tree) {
-		struct strbuf sb = STRBUF_INIT;
-
-		cache_tree_write(&sb, istate->cache_tree);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
-		strbuf_release(&sb);
-		if (err)
-			return -1;
-	}
-	if (istate->resolve_undo) {
-		struct strbuf sb = STRBUF_INIT;
-
-		resolve_undo_write(&sb, istate->resolve_undo);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
-					     sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
-		strbuf_release(&sb);
-		if (err)
-			return -1;
-	}
-
-	if (ce_flush(&c, newfd) || fstat(newfd, &st))
-		return -1;
-	istate->timestamp.sec = (unsigned int)st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
-	return 0;
-}
-
 int write_index(struct index_state *istate, int newfd)
 {
-	return write_index_v2(istate, newfd);
+	return istate->ops->write_index(istate, newfd);
 }
 
 /*
diff --git a/read-cache.h b/read-cache.h
new file mode 100644
index 0000000..ceedcae
--- /dev/null
+++ b/read-cache.h
@@ -0,0 +1,63 @@
+#ifndef READ_CACHE_H
+#define READ_CACHE_H
+
+/* Index extensions.
+ *
+ * The first letter should be 'A'..'Z' for extensions that are not
+ * necessary for a correct operation (i.e. optimization data).
+ * When new extensions are added that _needs_ to be understood in
+ * order to correctly interpret the index file, pick character that
+ * is outside the range, to cause the reader to abort.
+ */
+
+#define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
+#define CACHE_EXT_TREE 0x54524545	/* "TREE" */
+#define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+
+#define INDEX_FORMAT_DEFAULT 3
+
+/*
+ * Basic data structures for the directory cache
+ */
+struct cache_header {
+	uint32_t hdr_signature;
+	uint32_t hdr_version;
+	uint32_t hdr_entries;
+};
+
+struct index_ops {
+	int (*match_stat_basic)(const struct cache_entry *ce, struct stat *st, int changed);
+	int (*verify_hdr)(void *mmap, unsigned long size);
+	int (*read_index)(struct index_state *istate, void *mmap, unsigned long mmap_size);
+	int (*write_index)(struct index_state *istate, int newfd);
+};
+
+extern struct index_ops v2_ops;
+
+#ifndef NEEDS_ALIGNED_ACCESS
+#define ntoh_s(var) ntohs(var)
+#define ntoh_l(var) ntohl(var)
+#else
+static inline uint16_t ntoh_s_force_align(void *p)
+{
+	uint16_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohs(x);
+}
+static inline uint32_t ntoh_l_force_align(void *p)
+{
+	uint32_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohl(x);
+}
+#define ntoh_s(var) ntoh_s_force_align(&(var))
+#define ntoh_l(var) ntoh_l_force_align(&(var))
+#endif
+
+extern int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st);
+extern int ce_match_stat_basic(const struct index_state *istate,
+			       const struct cache_entry *ce, struct stat *st);
+extern int is_racy_timestamp(const struct index_state *istate, const struct cache_entry *ce);
+extern void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce);
+
+#endif
diff --git a/test-index-version.c b/test-index-version.c
index 05d4699..d3c0ebd 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -1,5 +1,11 @@
 #include "cache.h"
 
+struct cache_header {
+	uint32_t hdr_signature;
+	uint32_t hdr_version;
+	uint32_t hdr_entries;
+};
+
 int main(int argc, char **argv)
 {
 	struct cache_header hdr;
diff --git a/unpack-trees.c b/unpack-trees.c
index 35cb05e..8d07c2a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1035,10 +1035,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
-	o->result.initialized = 1;
+	initialize_index(&o->result, o->src_index->version);
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
 	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
-	o->result.version = o->src_index->version;
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
-- 
1.8.4.2
