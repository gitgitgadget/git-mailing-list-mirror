From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 01/13] Move index v2 specific functions to their own file
Date: Thu, 16 Aug 2012 11:58:37 +0200
Message-ID: <1345111129-6925-2-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 12:00:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrt-0000D2-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab2HPJ7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:53 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48155 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136Ab2HPJ7N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:13 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 96FEE4EF53; Thu, 16 Aug 2012 11:59:08 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move index version 2 specific functions to their own file,
to prepare for the addition of a new index file format. With
the split into two files we have the non-index specific
functions in read-cache.c and the index-v2 specific functions
in read-cache-v2.c

Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile             |   2 +
 cache.h              |  13 +-
 read-cache-v2.c      | 581 ++++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.c         | 612 +++------------------------------------------------
 read-cache.h         |  57 +++++
 test-index-version.c |   7 +-
 6 files changed, 682 insertions(+), 590 deletions(-)
 create mode 100644 read-cache-v2.c
 create mode 100644 read-cache.h

diff --git a/Makefile b/Makefile
index 6b0c961..3ccd3a8 100644
--- a/Makefile
+++ b/Makefile
@@ -645,6 +645,7 @@ LIB_H += progress.h
 LIB_H += prompt.h
 LIB_H += quote.h
 LIB_H += reachable.h
+LIB_H += read-cache.h
 LIB_H += reflog-walk.h
 LIB_H += refs.h
 LIB_H += remote.h
@@ -768,6 +769,7 @@ LIB_OBJS += prompt.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
+LIB_OBJS += read-cache-v2.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
diff --git a/cache.h b/cache.h
index 67f28b4..c77cdbe 100644
--- a/cache.h
+++ b/cache.h
@@ -94,16 +94,8 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
  */
 #define DEFAULT_GIT_PORT 9418
 
-/*
- * Basic data structures for the directory cache
- */
 
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
-struct cache_header {
-	unsigned int hdr_signature;
-	unsigned int hdr_version;
-	unsigned int hdr_entries;
-};
 
 #define INDEX_FORMAT_LB 2
 #define INDEX_FORMAT_UB 4
@@ -267,6 +259,7 @@ struct index_state {
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
+	struct index_ops *ops;
 };
 
 extern struct index_state the_index;
@@ -471,8 +464,8 @@ extern int index_name_is_other(const struct index_state *, const char *, int);
 #define CE_MATCH_RACY_IS_DIRTY		02
 /* do stat comparison even if CE_SKIP_WORKTREE is true */
 #define CE_MATCH_IGNORE_SKIP_WORKTREE	04
-extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
-extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
+extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
+extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspec() */
diff --git a/read-cache-v2.c b/read-cache-v2.c
new file mode 100644
index 0000000..2c5e78b
--- /dev/null
+++ b/read-cache-v2.c
@@ -0,0 +1,581 @@
+#include "cache.h"
+#include "read-cache.h"
+#include "resolve-undo.h"
+#include "cache-tree.h"
+#include "varint.h"
+
+/* Mask for the name length in ce_flags in the on-disk index */
+#define CE_NAMEMASK  (0x0fff)
+
+struct cache_header {
+	unsigned int hdr_entries;
+};
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
+	unsigned int dev;
+	unsigned int ino;
+	unsigned int mode;
+	unsigned int uid;
+	unsigned int gid;
+	unsigned int size;
+	unsigned char sha1[20];
+	unsigned short flags;
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
+	unsigned int dev;
+	unsigned int ino;
+	unsigned int mode;
+	unsigned int uid;
+	unsigned int gid;
+	unsigned int size;
+	unsigned char sha1[20];
+	unsigned short flags;
+	unsigned short flags2;
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
+	if (size < sizeof(struct cache_version_header)
+			+ sizeof(struct cache_header) + 20)
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
+static int match_stat_basic(struct cache_entry *ce,
+				struct stat *st,
+				int changed)
+{
+	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
+		changed |= MTIME_CHANGED;
+	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
+		changed |= CTIME_CHANGED;
+
+#ifdef USE_NSEC
+	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
+		changed |= MTIME_CHANGED;
+	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+		changed |= CTIME_CHANGED;
+#endif
+
+	if (ce->ce_uid != (unsigned int) st->st_uid ||
+	    ce->ce_gid != (unsigned int) st->st_gid)
+		changed |= OWNER_CHANGED;
+	if (ce->ce_ino != (unsigned int) st->st_ino)
+		changed |= INODE_CHANGED;
+
+#ifdef USE_STDEV
+	/*
+	 * st_dev breaks on network filesystems where different
+	 * clients will have different views of what "device"
+	 * the filesystem is on
+	 */
+	if (ce->ce_dev != (unsigned int) st->st_dev)
+		changed |= INODE_CHANGED;
+#endif
+
+	if (ce->ce_size != (unsigned int) st->st_size)
+		changed |= DATA_CHANGED;
+
+	/* Racily smudged entry? */
+	if (!ce->ce_size) {
+		if (!is_empty_blob_sha1(ce->sha1))
+			changed |= DATA_CHANGED;
+	}
+
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
+	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
+	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
+	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
+	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
+	ce->ce_dev   = ntoh_l(ondisk->dev);
+	ce->ce_ino   = ntoh_l(ondisk->ino);
+	ce->ce_mode  = ntoh_l(ondisk->mode);
+	ce->ce_uid   = ntoh_l(ondisk->uid);
+	ce->ce_gid   = ntoh_l(ondisk->gid);
+	ce->ce_size  = ntoh_l(ondisk->size);
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
+static int read_index_v2(struct index_state *istate, void *mmap, int mmap_size)
+{
+	int i;
+	unsigned long src_offset;
+	struct cache_version_header *hdr;
+	struct cache_header *hdr_v2;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+
+	hdr = mmap;
+	hdr_v2 = (struct cache_header *)((char *)mmap + sizeof(*hdr));
+	istate->version = ntohl(hdr->hdr_version);
+	istate->cache_nr = ntohl(hdr_v2->hdr_entries);
+	istate->cache_alloc = alloc_nr(istate->cache_nr);
+	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
+	istate->initialized = 1;
+
+	if (istate->version == 4)
+		previous_name = &previous_name_buf;
+	else
+		previous_name = NULL;
+
+	src_offset = sizeof(*hdr) + sizeof(*hdr_v2);
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
+	 * ce_mtime match the index file mtime.
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
+		ce->ce_size = 0;
+	}
+}
+
+/* Copy miscellaneous fields but not the name */
+static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
+				       struct cache_entry *ce)
+{
+	short flags;
+
+	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
+	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
+	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
+	ondisk->mtime.nsec = htonl(ce->ce_mtime.nsec);
+	ondisk->dev  = htonl(ce->ce_dev);
+	ondisk->ino  = htonl(ce->ce_ino);
+	ondisk->mode = htonl(ce->ce_mode);
+	ondisk->uid  = htonl(ce->ce_uid);
+	ondisk->gid  = htonl(ce->ce_gid);
+	ondisk->size = htonl(ce->ce_size);
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
+	struct cache_version_header hdr;
+	struct cache_header hdr_v2;
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
+	/* demote version 3 to version 2 when the latter suffices */
+	if (istate->version == 3 || istate->version == 2)
+		istate->version = extended ? 3 : 2;
+
+	hdr_version = istate->version;
+
+	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
+	hdr.hdr_version = htonl(hdr_version);
+	hdr_v2.hdr_entries = htonl(entries - removed);
+
+	git_SHA1_Init(&c);
+	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
+		return -1;
+	if (ce_write(&c, newfd, &hdr_v2, sizeof(hdr_v2)) < 0)
+		return -1;
+
+	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = cache[i];
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
+			ce_smudge_racily_clean_entry(istate, ce);
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
index 2f8159f..6a8b4b1 100644
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
@@ -143,7 +127,7 @@ static int ce_compare_gitlink(struct cache_entry *ce)
 	return hashcmp(sha1, ce->sha1);
 }
 
-static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
+int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 {
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
@@ -163,7 +147,17 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
+static void check_set_istate_ops(struct index_state *istate)
+{
+	if (!istate->version)
+		istate->version = INDEX_FORMAT_DEFAULT;
+	if (!istate->ops)
+		if (istate->version >= 2 && istate->version <=4)
+			istate->ops = &v2_ops;
+}
+
+int ce_match_stat_basic(struct index_state *istate,
+		struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
 
@@ -195,47 +189,13 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	default:
 		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
-	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
-
-#ifdef USE_NSEC
-	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
-#endif
-
-	if (ce->ce_uid != (unsigned int) st->st_uid ||
-	    ce->ce_gid != (unsigned int) st->st_gid)
-		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
-		changed |= INODE_CHANGED;
-
-#ifdef USE_STDEV
-	/*
-	 * st_dev breaks on network filesystems where different
-	 * clients will have different views of what "device"
-	 * the filesystem is on
-	 */
-	if (ce->ce_dev != (unsigned int) st->st_dev)
-		changed |= INODE_CHANGED;
-#endif
-
-	if (ce->ce_size != (unsigned int) st->st_size)
-		changed |= DATA_CHANGED;
-
-	/* Racily smudged entry? */
-	if (!ce->ce_size) {
-		if (!is_empty_blob_sha1(ce->sha1))
-			changed |= DATA_CHANGED;
-	}
 
+	check_set_istate_ops(istate);
+	changed = istate->ops->match_stat_basic(ce, st, changed);
 	return changed;
 }
 
-static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
+int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
 		istate->timestamp.sec &&
@@ -250,7 +210,7 @@ static int is_racy_timestamp(const struct index_state *istate, struct cache_entr
 		 );
 }
 
-int ie_match_stat(const struct index_state *istate,
+int ie_match_stat(struct index_state *istate,
 		  struct cache_entry *ce, struct stat *st,
 		  unsigned int options)
 {
@@ -278,7 +238,7 @@ int ie_match_stat(const struct index_state *istate,
 	if (ce->ce_flags & CE_INTENT_TO_ADD)
 		return DATA_CHANGED | TYPE_CHANGED | MODE_CHANGED;
 
-	changed = ce_match_stat_basic(ce, st);
+	changed = ce_match_stat_basic(istate, ce, st);
 
 	/*
 	 * Within 1 second of this sequence:
@@ -306,7 +266,7 @@ int ie_match_stat(const struct index_state *istate,
 	return changed;
 }
 
-int ie_modified(const struct index_state *istate,
+int ie_modified(struct index_state *istate,
 		struct cache_entry *ce, struct stat *st, unsigned int options)
 {
 	int changed, changed_fs;
@@ -1190,99 +1150,18 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
 }
 
-
-/*****************************************************************
- * Index File I/O
- *****************************************************************/
-
-#define INDEX_FORMAT_DEFAULT 3
-
-/*
- * dev/ino/uid/gid/size are also just tracked to the low 32 bits
- * Again - this is just a (very strong in practice) heuristic that
- * the inode hasn't changed.
- *
- * We save the fields in big-endian order to allow using the
- * index file over NFS transparently.
- */
-struct ondisk_cache_entry {
-	struct cache_time ctime;
-	struct cache_time mtime;
-	unsigned int dev;
-	unsigned int ino;
-	unsigned int mode;
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int size;
-	unsigned char sha1[20];
-	unsigned short flags;
-	char name[FLEX_ARRAY]; /* more */
-};
-
-/*
- * This struct is used when CE_EXTENDED bit is 1
- * The struct must match ondisk_cache_entry exactly from
- * ctime till flags
- */
-struct ondisk_cache_entry_extended {
-	struct cache_time ctime;
-	struct cache_time mtime;
-	unsigned int dev;
-	unsigned int ino;
-	unsigned int mode;
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int size;
-	unsigned char sha1[20];
-	unsigned short flags;
-	unsigned short flags2;
-	char name[FLEX_ARRAY]; /* more */
-};
-
-/* These are only used for v3 or lower */
-#define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
-#define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
-#define ondisk_cache_entry_extended_size(len) align_flex_name(ondisk_cache_entry_extended,len)
-#define ondisk_ce_size(ce) (((ce)->ce_flags & CE_EXTENDED) ? \
-			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
-			    ondisk_cache_entry_size(ce_namelen(ce)))
-
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr_version(struct index_state *istate,
+		struct cache_version_header *hdr, unsigned long size)
 {
-	git_SHA_CTX c;
-	unsigned char sha1[20];
 	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version = ntohl(hdr->hdr_version);
-	if (hdr_version < 2 || 4 < hdr_version)
+	if (hdr_version >= 2 && hdr_version <= 4)
+		istate->ops = &v2_ops;
+	else
 		return error("bad index version %d", hdr_version);
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, size - 20);
-	git_SHA1_Final(sha1, &c);
-	if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
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
 	return 0;
 }
 
@@ -1291,128 +1170,14 @@ int read_index(struct index_state *istate)
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
-	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
-	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
-	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
-	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
-	ce->ce_dev   = ntoh_l(ondisk->dev);
-	ce->ce_ino   = ntoh_l(ondisk->ino);
-	ce->ce_mode  = ntoh_l(ondisk->mode);
-	ce->ce_uid   = ntoh_l(ondisk->uid);
-	ce->ce_gid   = ntoh_l(ondisk->gid);
-	ce->ce_size  = ntoh_l(ondisk->size);
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
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
-	int fd, i;
+	int fd;
 	struct stat st;
-	unsigned long src_offset;
-	struct cache_header *hdr;
+	struct cache_version_header *hdr;
 	void *mmap;
 	size_t mmap_size;
-	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
 	errno = EBUSY;
 	if (istate->initialized)
@@ -1433,69 +1198,27 @@ int read_index_from(struct index_state *istate, const char *path)
 
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
-	if (verify_hdr(hdr, mmap_size) < 0)
+	if (verify_hdr_version(istate, hdr, mmap_size) < 0)
 		goto unmap;
 
-	istate->version = ntohl(hdr->hdr_version);
-	istate->cache_nr = ntohl(hdr->hdr_entries);
-	istate->cache_alloc = alloc_nr(istate->cache_nr);
-	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
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
+	if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
+		goto unmap;
 
-		src_offset += consumed;
-	}
-	strbuf_release(&previous_name_buf);
+	istate->ops->read_index(istate, mmap, mmap_size);
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
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
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
 unmap:
 	munmap(mmap, mmap_size);
-	errno = EINVAL;
 	die("index file corrupt");
 }
 
@@ -1534,201 +1257,6 @@ int unmerged_index(const struct index_state *istate)
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
-	 * ce_mtime match the index file mtime.
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
-		ce->ce_size = 0;
-	}
-}
-
-/* Copy miscellaneous fields but not the name */
-static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
-				       struct cache_entry *ce)
-{
-	short flags;
-
-	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
-	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
-	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
-	ondisk->mtime.nsec = htonl(ce->ce_mtime.nsec);
-	ondisk->dev  = htonl(ce->ce_dev);
-	ondisk->ino  = htonl(ce->ce_ino);
-	ondisk->mode = htonl(ce->ce_mode);
-	ondisk->uid  = htonl(ce->ce_uid);
-	ondisk->gid  = htonl(ce->ce_gid);
-	ondisk->size = htonl(ce->ce_size);
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
@@ -1756,83 +1284,9 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 
 int write_index(struct index_state *istate, int newfd)
 {
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
-		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
-			return -1;
-	}
-	strbuf_release(&previous_name_buf);
+	check_set_istate_ops(istate);
 
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
+	return istate->ops->write_index(istate, newfd);
 }
 
 /*
diff --git a/read-cache.h b/read-cache.h
new file mode 100644
index 0000000..f41ba75
--- /dev/null
+++ b/read-cache.h
@@ -0,0 +1,57 @@
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
+struct cache_version_header {
+	unsigned int hdr_signature;
+	unsigned int hdr_version;
+};
+
+struct index_ops {
+	int (*match_stat_basic)(struct cache_entry *ce, struct stat *st, int changed);
+	int (*verify_hdr)(void *mmap, unsigned long size);
+	int (*read_index)(struct index_state *istate, void *mmap, int mmap_size);
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
+extern int ce_modified_check_fs(struct cache_entry *ce, struct stat *st);
+extern int ce_match_stat_basic(struct index_state *istate,
+		struct cache_entry *ce, struct stat *st);
+extern int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce);
+extern void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce);
diff --git a/test-index-version.c b/test-index-version.c
index bfaad9e..3899a2f 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -1,8 +1,13 @@
 #include "cache.h"
 
+struct cache_version_header {
+	unsigned int hdr_signature;
+	unsigned int hdr_version;
+};
+
 int main(int argc, const char **argv)
 {
-	struct cache_header hdr;
+	struct cache_version_header hdr;
 	int version;
 
 	memset(&hdr,0,sizeof(hdr));
-- 
1.7.11.2
