From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 15/24] read-cache: read index-v5
Date: Sun, 18 Aug 2013 21:42:04 +0200
Message-ID: <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yD-000474-NN
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab3HRTs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:56 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:40357 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab3HRTsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:54 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so2833833wgg.34
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k9bjTO3QUw8ZhRXFhl6GOcIvS1OLEUZJ+RdZ5EFYz78=;
        b=jratW/6jUs/3/JKMn35aNNyxXvn71aNgTTUXlU5Ya0Z+bTahjTorCyWsOSYN0LS1Fi
         uN9O8tGqjdiDfgrxOc/fFaW2gU1O2wHHYfHSkKGrWVYKHtAbd83yDm3vefv4YVymLlRk
         2WK7Wo7mOStW7YGH2aDboOLLVENBD+SAWUOG/Pw5Ikj7COr3oyCY3CY52d76+T2tsYq6
         ovOeybnT/FuogGoh5bbx2dX7D1OCuwB6Ix1kG7hMNzCHx4QebPGHGvQO5rJpjGTfse9X
         7CPpoRlJWSi6Hd5VX0jzYMw/LNMeglT4rk4cA4FNmGdgDRGOvXZMzL1/cL0q1YxWnn32
         cICA==
X-Received: by 10.194.24.168 with SMTP id v8mr5903673wjf.28.1376855333579;
        Sun, 18 Aug 2013 12:48:53 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id i5sm12396612wiw.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232503>

Make git read the index file version 5 without complaining.

This version of the reader doesn't read neither the cache-tree
nor the resolve undo data, but doesn't choke on an index that
includes such data.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile        |   1 +
 cache.h         |  32 +++-
 read-cache-v5.c | 473 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.h    |   1 +
 4 files changed, 506 insertions(+), 1 deletion(-)
 create mode 100644 read-cache-v5.c

diff --git a/Makefile b/Makefile
index afae23e..a55206d 100644
--- a/Makefile
+++ b/Makefile
@@ -857,6 +857,7 @@ LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += read-cache-v2.o
+LIB_OBJS += read-cache-v5.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
diff --git a/cache.h b/cache.h
index 714a334..89f556b 100644
--- a/cache.h
+++ b/cache.h
@@ -99,7 +99,7 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
 
 #define INDEX_FORMAT_LB 2
-#define INDEX_FORMAT_UB 4
+#define INDEX_FORMAT_UB 5
 
 /*
  * The "cache_time" is just the low 32 bits of the
@@ -121,6 +121,15 @@ struct stat_data {
 	unsigned int sd_size;
 };
 
+/*
+ * The *next pointer is used in read_entries_v5 for holding
+ * all the elements of a directory, and points to the next
+ * cache_entry in a directory.
+ *
+ * It is reset by the add_name_hash call in set_index_entry
+ * to set it to point to the next cache_entry in the
+ * correct in-memory format ordering.
+ */
 struct cache_entry {
 	struct stat_data ce_stat_data;
 	unsigned int ce_mode;
@@ -132,11 +141,17 @@ struct cache_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
 
+#define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_EXTENDED  (0x4000)
 #define CE_VALID     (0x8000)
+#define CE_SMUDGED   (0x0400) /* index v5 only flag */
 #define CE_STAGESHIFT 12
 
+#define CONFLICT_CONFLICTED (0x8000)
+#define CONFLICT_STAGESHIFT 13
+#define CONFLICT_STAGEMASK (0x6000)
+
 /*
  * Range 0xFFFF0000 in ce_flags is divided into
  * two parts: in-memory flags and on-disk ones.
@@ -173,6 +188,19 @@ struct cache_entry {
 #define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
 
 /*
+ * Representation of the extended on-disk flags in the v5 format.
+ * They must not collide with the ordinary on-disk flags, and need to
+ * fit in 16 bits.  Note however that v5 does not save the name
+ * length.
+ */
+#define CE_INTENT_TO_ADD_V5  (0x4000)
+#define CE_SKIP_WORKTREE_V5  (0x0800)
+#define CE_INVALID_V5        (0x0200)
+#if (CE_VALID|CE_STAGEMASK) & (CE_INTENTTOADD_V5|CE_SKIPWORKTREE_V5|CE_INVALID_V5)
+#error "v5 on-disk flags collide with ordinary on-disk flags"
+#endif
+
+/*
  * Safeguard to avoid saving wrong flags:
  *  - CE_EXTENDED2 won't get saved until its semantic is known
  *  - Bits in 0x0000FFFF have been saved in ce_flags already
@@ -213,6 +241,8 @@ static inline unsigned create_ce_flags(unsigned stage)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
 
+#define conflict_stage(c) ((CONFLICT_STAGEMASK & (c)->flags) >> CONFLICT_STAGESHIFT)
+
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
 {
diff --git a/read-cache-v5.c b/read-cache-v5.c
new file mode 100644
index 0000000..799b8e7
--- /dev/null
+++ b/read-cache-v5.c
@@ -0,0 +1,473 @@
+#include "cache.h"
+#include "read-cache.h"
+#include "resolve-undo.h"
+#include "cache-tree.h"
+#include "dir.h"
+#include "pathspec.h"
+
+#define ptr_add(x,y) ((void *)(((char *)(x)) + (y)))
+
+struct cache_header_v5 {
+	uint32_t hdr_ndir;
+	uint32_t hdr_fblockoffset;
+	uint32_t hdr_nextension;
+};
+
+struct directory_entry {
+	struct directory_entry **sub;
+	struct directory_entry *next;
+	struct directory_entry *next_hash;
+	struct cache_entry *ce;
+	struct cache_entry *ce_last;
+	struct conflict_entry *conflict;
+	struct conflict_entry *conflict_last;
+	uint32_t conflict_size;
+	uint32_t de_foffset;
+	uint32_t de_cr;
+	uint32_t de_ncr;
+	uint32_t de_nsubtrees;
+	uint32_t de_nfiles;
+	uint32_t de_nentries;
+	unsigned char sha1[20];
+	uint16_t de_flags;
+	uint32_t de_pathlen;
+	char pathname[FLEX_ARRAY];
+};
+
+struct conflict_part {
+	struct conflict_part *next;
+	uint16_t flags;
+	uint16_t entry_mode;
+	unsigned char sha1[20];
+};
+
+struct conflict_entry {
+	struct conflict_entry *next;
+	uint32_t nfileconflicts;
+	struct conflict_part *entries;
+	uint32_t namelen;
+	uint32_t pathlen;
+	char name[FLEX_ARRAY];
+};
+
+#define directory_entry_size(len) (offsetof(struct directory_entry,pathname) + (len) + 1)
+#define conflict_entry_size(len) (offsetof(struct conflict_entry,name) + (len) + 1)
+
+/*****************************************************************
+ * Index File I/O
+ *****************************************************************/
+
+struct ondisk_conflict_part {
+	uint16_t flags;
+	uint16_t entry_mode;
+	unsigned char sha1[20];
+};
+
+struct ondisk_cache_entry {
+	uint16_t flags;
+	uint16_t mode;
+	struct cache_time mtime;
+	uint32_t size;
+	int stat_crc;
+	unsigned char sha1[20];
+};
+
+struct ondisk_directory_entry {
+	uint32_t foffset;
+	uint32_t cr;
+	uint32_t ncr;
+	uint32_t nsubtrees;
+	uint32_t nfiles;
+	uint32_t nentries;
+	unsigned char sha1[20];
+	uint16_t flags;
+};
+
+static int check_crc32(int initialcrc,
+			void *data,
+			size_t len,
+			unsigned int expected_crc)
+{
+	int crc;
+
+	crc = crc32(initialcrc, (Bytef*)data, len);
+	return crc == expected_crc;
+}
+
+static int match_stat_crc(struct stat *st, uint32_t expected_crc)
+{
+	uint32_t data, stat_crc = 0;
+	unsigned int ctimens = 0;
+
+	data = htonl(st->st_ctime);
+	stat_crc = crc32(0, (Bytef*)&data, 4);
+#ifdef USE_NSEC
+	ctimens = ST_CTIME_NSEC(*st);
+#endif
+	data = htonl(ctimens);
+	stat_crc = crc32(stat_crc, (Bytef*)&data, 4);
+	data = htonl(st->st_ino);
+	stat_crc = crc32(stat_crc, (Bytef*)&data, 4);
+	data = htonl(st->st_dev);
+	stat_crc = crc32(stat_crc, (Bytef*)&data, 4);
+	data = htonl(st->st_uid);
+	stat_crc = crc32(stat_crc, (Bytef*)&data, 4);
+	data = htonl(st->st_gid);
+	stat_crc = crc32(stat_crc, (Bytef*)&data, 4);
+
+	return stat_crc == expected_crc;
+}
+
+static int match_stat_basic(const struct cache_entry *ce,
+			    struct stat *st,
+			    int changed)
+{
+
+	if (ce->ce_stat_data.sd_mtime.sec != (unsigned int)st->st_mtime)
+		changed |= MTIME_CHANGED;
+#ifdef USE_NSEC
+	if (ce->ce_stat_data.sd_mtime.nsec != ST_MTIME_NSEC(*st))
+		changed |= MTIME_CHANGED;
+#endif
+	if (ce->ce_stat_data.sd_size != (unsigned int)st->st_size)
+		changed |= DATA_CHANGED;
+
+	if (trust_ctime && ce->ce_stat_crc != 0 && !match_stat_crc(st, ce->ce_stat_crc)) {
+		changed |= OWNER_CHANGED;
+		changed |= INODE_CHANGED;
+	}
+	/* Racily smudged entry? */
+	if (ce->ce_flags & CE_SMUDGED) {
+		if (!changed && !is_empty_blob_sha1(ce->sha1) && ce_modified_check_fs(ce, st))
+			changed |= DATA_CHANGED;
+	}
+	return changed;
+}
+
+static int verify_hdr(void *mmap, unsigned long size)
+{
+	uint32_t *filecrc;
+	unsigned int header_size;
+	struct cache_header *hdr;
+	struct cache_header_v5 *hdr_v5;
+
+	if (size < sizeof(struct cache_header)
+	    + sizeof (struct cache_header_v5) + 4)
+		die("index file smaller than expected");
+
+	hdr = mmap;
+	hdr_v5 = ptr_add(mmap, sizeof(*hdr));
+	/* Size of the header + the size of the extensionoffsets */
+	header_size = sizeof(*hdr) + sizeof(*hdr_v5) + hdr_v5->hdr_nextension * 4;
+	/* Initialize crc */
+	filecrc = ptr_add(mmap, header_size);
+	if (!check_crc32(0, hdr, header_size, ntohl(*filecrc)))
+		return error("bad index file header crc signature");
+	return 0;
+}
+
+static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
+						   char *pathname,
+						   char *name,
+						   size_t len,
+						   size_t pathlen)
+{
+	struct cache_entry *ce = xmalloc(cache_entry_size(len + pathlen));
+	int flags;
+
+	flags = ntoh_s(ondisk->flags);
+	/*
+	 * This entry was invalidated in the index file,
+	 * we don't need any data from it
+	 */
+	if (flags & CE_INVALID_V5)
+		return NULL;
+	ce->ce_stat_data.sd_ctime.sec  = 0;
+	ce->ce_stat_data.sd_mtime.sec  = ntoh_l(ondisk->mtime.sec);
+	ce->ce_stat_data.sd_ctime.nsec = 0;
+	ce->ce_stat_data.sd_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
+	ce->ce_stat_data.sd_dev        = 0;
+	ce->ce_stat_data.sd_ino        = 0;
+	ce->ce_stat_data.sd_uid        = 0;
+	ce->ce_stat_data.sd_gid        = 0;
+	ce->ce_stat_data.sd_size       = ntoh_l(ondisk->size);
+	ce->ce_mode       = ntoh_s(ondisk->mode);
+	ce->ce_flags      = flags & CE_STAGEMASK;
+	ce->ce_flags     |= flags & CE_VALID;
+	ce->ce_flags     |= flags & CE_SMUDGED;
+	if (flags & CE_INTENT_TO_ADD_V5)
+		ce->ce_flags |= CE_INTENT_TO_ADD;
+	if (flags & CE_SKIP_WORKTREE_V5)
+		ce->ce_flags |= CE_SKIP_WORKTREE;
+	ce->ce_stat_crc   = ntoh_l(ondisk->stat_crc);
+	ce->ce_namelen    = len + pathlen;
+	hashcpy(ce->sha1, ondisk->sha1);
+	memcpy(ce->name, pathname, pathlen);
+	memcpy(ce->name + pathlen, name, len);
+	ce->name[len + pathlen] = '\0';
+	return ce;
+}
+
+static struct directory_entry *directory_entry_from_ondisk(struct ondisk_directory_entry *ondisk,
+						   const char *name,
+						   size_t len)
+{
+	struct directory_entry *de = xmalloc(directory_entry_size(len));
+
+	memcpy(de->pathname, name, len);
+	de->pathname[len] = '\0';
+	de->de_flags      = ntoh_s(ondisk->flags);
+	de->de_foffset    = ntoh_l(ondisk->foffset);
+	de->de_cr         = ntoh_l(ondisk->cr);
+	de->de_ncr        = ntoh_l(ondisk->ncr);
+	de->de_nsubtrees  = ntoh_l(ondisk->nsubtrees);
+	de->de_nfiles     = ntoh_l(ondisk->nfiles);
+	de->de_nentries   = ntoh_l(ondisk->nentries);
+	de->de_pathlen    = len;
+	hashcpy(de->sha1, ondisk->sha1);
+	return de;
+}
+
+static struct directory_entry *read_directories(unsigned int *dir_offset,
+				unsigned int *dir_table_offset,
+				void *mmap,
+				int mmap_size)
+{
+	int i, ondisk_directory_size;
+	uint32_t *filecrc, *beginning, *end;
+	struct ondisk_directory_entry *disk_de;
+	struct directory_entry *de;
+	unsigned int data_len, len;
+	char *name;
+
+	/*
+	 * Length of pathname + nul byte for termination + size of
+	 * members of ondisk_directory_entry. (Just using the size
+	 * of the struct doesn't work, because there may be padding
+	 * bytes for the struct)
+	 */
+	ondisk_directory_size = sizeof(disk_de->flags)
+		+ sizeof(disk_de->foffset)
+		+ sizeof(disk_de->cr)
+		+ sizeof(disk_de->ncr)
+		+ sizeof(disk_de->nsubtrees)
+		+ sizeof(disk_de->nfiles)
+		+ sizeof(disk_de->nentries)
+		+ sizeof(disk_de->sha1);
+	name = ptr_add(mmap, *dir_offset);
+	beginning = ptr_add(mmap, *dir_table_offset);
+	end = ptr_add(mmap, *dir_table_offset + 4);
+	len = ntoh_l(*end) - ntoh_l(*beginning) - ondisk_directory_size - 5;
+	disk_de = ptr_add(mmap, *dir_offset + len + 1);
+	de = directory_entry_from_ondisk(disk_de, name, len);
+	de->next = NULL;
+	de->sub = NULL;
+
+	data_len = len + 1 + ondisk_directory_size;
+	filecrc = ptr_add(mmap, *dir_offset + data_len);
+	if (!check_crc32(0, ptr_add(mmap, *dir_offset), data_len, ntoh_l(*filecrc)))
+		die("directory crc doesn't match for '%s'", de->pathname);
+
+	*dir_table_offset += 4;
+	*dir_offset += data_len + 4; /* crc code */
+
+	de->sub = xcalloc(de->de_nsubtrees, sizeof(struct directory_entry *));
+	for (i = 0; i < de->de_nsubtrees; i++) {
+		de->sub[i] = read_directories(dir_offset, dir_table_offset,
+						   mmap, mmap_size);
+	}
+
+	return de;
+}
+
+static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
+		      void *mmap, unsigned long mmap_size,
+		      unsigned int first_entry_offset,
+		      unsigned int foffsetblock)
+{
+	int len, offset_to_offset;
+	char *name;
+	uint32_t foffsetblockcrc, *filecrc, *beginning, *end, entry_offset;
+	struct ondisk_cache_entry *disk_ce;
+
+	beginning = ptr_add(mmap, foffsetblock);
+	end = ptr_add(mmap, foffsetblock + 4);
+	len = ntoh_l(*end) - ntoh_l(*beginning) - sizeof(struct ondisk_cache_entry) - 5;
+	entry_offset = first_entry_offset + ntoh_l(*beginning);
+	name = ptr_add(mmap, entry_offset);
+	disk_ce = ptr_add(mmap, entry_offset + len + 1);
+	*ce = cache_entry_from_ondisk(disk_ce, pathname, name, len, pathlen);
+	filecrc = ptr_add(mmap, entry_offset + len + 1 + sizeof(*disk_ce));
+	offset_to_offset = htonl(foffsetblock);
+	foffsetblockcrc = crc32(0, (Bytef*)&offset_to_offset, 4);
+	if (!check_crc32(foffsetblockcrc,
+		ptr_add(mmap, entry_offset), len + 1 + sizeof(*disk_ce),
+		ntoh_l(*filecrc)))
+		return -1;
+
+	return 0;
+}
+
+struct conflict_entry *create_new_conflict(char *name, int len, int pathlen)
+{
+	struct conflict_entry *conflict_entry;
+
+	if (pathlen)
+		pathlen++;
+	conflict_entry = xmalloc(conflict_entry_size(len));
+	conflict_entry->entries = NULL;
+	conflict_entry->nfileconflicts = 0;
+	conflict_entry->namelen = len;
+	memcpy(conflict_entry->name, name, len);
+	conflict_entry->name[len] = '\0';
+	conflict_entry->pathlen = pathlen;
+	conflict_entry->next = NULL;
+
+	return conflict_entry;
+}
+
+void add_part_to_conflict_entry(struct directory_entry *de,
+					struct conflict_entry *entry,
+					struct conflict_part *conflict_part)
+{
+
+	struct conflict_part *conflict_search;
+
+	entry->nfileconflicts++;
+	de->conflict_size += sizeof(struct ondisk_conflict_part);
+	if (!entry->entries)
+		entry->entries = conflict_part;
+	else {
+		conflict_search = entry->entries;
+		while (conflict_search->next)
+			conflict_search = conflict_search->next;
+		conflict_search->next = conflict_part;
+	}
+}
+
+static int read_entries(struct index_state *istate, struct directory_entry *de,
+			unsigned int first_entry_offset, void *mmap,
+			unsigned long mmap_size, unsigned int *nr,
+			unsigned int foffsetblock)
+{
+	struct cache_entry *ce;
+	int i, subdir = 0;
+
+	for (i = 0; i < de->de_nfiles; i++) {
+		unsigned int subdir_foffsetblock = de->de_foffset + foffsetblock + (i * 4);
+		if (read_entry(&ce, de->pathname, de->de_pathlen, mmap, mmap_size,
+			       first_entry_offset, subdir_foffsetblock) < 0)
+			return -1;
+		while (subdir < de->de_nsubtrees &&
+		       cache_name_compare(ce->name + de->de_pathlen,
+					  ce_namelen(ce) - de->de_pathlen,
+					  de->sub[subdir]->pathname + de->de_pathlen,
+					  de->sub[subdir]->de_pathlen - de->de_pathlen) > 0) {
+			read_entries(istate, de->sub[subdir], first_entry_offset, mmap,
+				     mmap_size, nr, foffsetblock);
+			subdir++;
+		}
+		if (!ce)
+			continue;
+		set_index_entry(istate, (*nr)++, ce);
+	}
+	for (i = subdir; i < de->de_nsubtrees; i++) {
+		read_entries(istate, de->sub[i], first_entry_offset, mmap,
+			     mmap_size, nr, foffsetblock);
+	}
+	return 0;
+}
+
+static struct directory_entry *read_all_directories(struct index_state *istate,
+						    unsigned int *entry_offset,
+						    unsigned int *foffsetblock,
+						    unsigned int *ndirs,
+						    void *mmap, unsigned long mmap_size)
+{
+	unsigned int dir_offset, dir_table_offset;
+	struct cache_header *hdr;
+	struct cache_header_v5 *hdr_v5;
+	struct directory_entry *root_directory;
+
+	hdr = mmap;
+	hdr_v5 = ptr_add(mmap, sizeof(*hdr));
+	istate->cache_alloc = alloc_nr(ntohl(hdr->hdr_entries));
+	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
+
+	/* Skip size of the header + crc sum + size of offsets to extensions + size of offsets */
+	dir_offset = sizeof(*hdr) + sizeof(*hdr_v5) + ntohl(hdr_v5->hdr_nextension) * 4 + 4
+		+ (ntohl(hdr_v5->hdr_ndir) + 1) * 4;
+	dir_table_offset = sizeof(*hdr) + sizeof(*hdr_v5) + ntohl(hdr_v5->hdr_nextension) * 4 + 4;
+	root_directory = read_directories(&dir_offset, &dir_table_offset,
+					  mmap, mmap_size);
+
+	*entry_offset = ntohl(hdr_v5->hdr_fblockoffset);
+	*foffsetblock = dir_offset;
+	*ndirs = ntohl(hdr_v5->hdr_ndir);
+	return root_directory;
+}
+
+static int read_index_v5(struct index_state *istate, void *mmap,
+			 unsigned long mmap_size, struct filter_opts *opts)
+{
+	unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
+	struct directory_entry *root_directory, *de, *last_de;
+	const char **paths = NULL;
+	struct pathspec adjusted_pathspec;
+	int need_root = 0, i;
+
+	root_directory = read_all_directories(istate, &entry_offset,
+					      &foffsetblock, &ndirs,
+					      mmap, mmap_size);
+
+	if (opts && opts->pathspec && opts->pathspec->nr) {
+		need_root = 0;
+		paths = xmalloc((opts->pathspec->nr + 1)*sizeof(char *));
+		paths[opts->pathspec->nr] = NULL;
+		for (i = 0; i < opts->pathspec->nr; i++) {
+			char *super = strdup(opts->pathspec->items[i].match);
+			int len = strlen(super);
+			while (len && super[len - 1] == '/' && super[len - 2] == '/')
+				super[--len] = '\0'; /* strip all but one trailing slash */
+			while (len && super[--len] != '/')
+				; /* scan backwards to next / */
+			if (len >= 0)
+				super[len--] = '\0';
+			if (len <= 0) {
+				need_root = 1;
+				break;
+			}
+			paths[i] = super;
+		}
+	}
+
+	if (!need_root)
+		parse_pathspec(&adjusted_pathspec, PATHSPEC_ALL_MAGIC, PATHSPEC_PREFER_CWD, NULL, paths);
+
+	de = root_directory;
+	last_de = de;
+	while (de) {
+		if (need_root ||
+		    match_pathspec_depth(&adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
+			if (read_entries(istate, de, entry_offset,
+					 mmap, mmap_size, &nr,
+					 foffsetblock) < 0)
+				return -1;
+		} else {
+			for (i = 0; i < de->de_nsubtrees; i++) {
+				last_de->next = de->sub[i];
+				last_de = last_de->next;
+			}
+		}
+		de = de->next;
+	}
+	istate->cache_nr = nr;
+	return 0;
+}
+
+struct index_ops v5_ops = {
+	match_stat_basic,
+	verify_hdr,
+	read_index_v5,
+	NULL
+};
diff --git a/read-cache.h b/read-cache.h
index 644b199..01c76de 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -31,6 +31,7 @@ struct index_ops {
 };
 
 extern struct index_ops v2_ops;
+extern struct index_ops v5_ops;
 
 #ifndef NEEDS_ALIGNED_ACCESS
 #define ntoh_s(var) ntohs(var)
-- 
1.8.3.4.1231.g9fbf354.dirty
