From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 15/22] read-cache: read index-v5
Date: Sun,  7 Jul 2013 10:11:53 +0200
Message-ID: <1373184720-29767-16-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk68-0006Q3-Ea
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab3GGIN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:28 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59405 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab3GGINW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:22 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so2138007eek.19
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3P7EP2DAXkTAHjfaObmZt8W4YX0mSoITawpSmy+/4bk=;
        b=sxkkNwY81g5t5I9tNxE5o0JJWGyz0V5cvfZ+rqm7ME+P1RT72pgHepC0qDizmcfCjl
         XQ2DDFhwCOsxOvcSewyKfX+097WFzfNWXPxYwbQARw0M0VoNwX851l8gS4E9Kvy8BenO
         R4XqUXpaMWULUs4bv5UozEfF0C/iCMK2ZoI6g2A3kcpewsA5N9abJbZWn58W2cxP8rV1
         bkAT22ucZ8vBmQ0QI2dUnNZ6+V8xL5EmxaQ5SsBNgt/8GSdlnY6TzybGNT2d26cad5RP
         UKcsNrEu+PcjUglN2NTbcZ0ZNABDc9GasS8HEyKc+zvKiTKEAaErG2vuWxedVDrGbh4d
         5CmA==
X-Received: by 10.15.55.199 with SMTP id v47mr19317129eew.41.1373184801443;
        Sun, 07 Jul 2013 01:13:21 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id n45sm30825718eew.1.2013.07.07.01.13.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229746>

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
 cache.h         |  75 ++++++-
 read-cache-v5.c | 658 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.h    |   1 +
 4 files changed, 734 insertions(+), 1 deletion(-)
 create mode 100644 read-cache-v5.c

diff --git a/Makefile b/Makefile
index 73369ae..80e35f5 100644
--- a/Makefile
+++ b/Makefile
@@ -856,6 +856,7 @@ LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += read-cache-v2.o
+LIB_OBJS += read-cache-v5.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
diff --git a/cache.h b/cache.h
index d77af5e..e110ec8 100644
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
@@ -133,11 +142,59 @@ struct cache_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
 
+struct directory_entry {
+	struct directory_entry *next;
+	struct directory_entry *next_hash;
+	struct cache_entry *ce;
+	struct cache_entry *ce_last;
+	struct conflict_entry *conflict;
+	struct conflict_entry *conflict_last;
+	unsigned int conflict_size;
+	unsigned int de_foffset;
+	unsigned int de_cr;
+	unsigned int de_ncr;
+	unsigned int de_nsubtrees;
+	unsigned int de_nfiles;
+	unsigned int de_nentries;
+	unsigned char sha1[20];
+	unsigned short de_flags;
+	unsigned int de_pathlen;
+	char pathname[FLEX_ARRAY];
+};
+
+struct conflict_part {
+	struct conflict_part *next;
+	unsigned short flags;
+	unsigned short entry_mode;
+	unsigned char sha1[20];
+};
+
+struct conflict_entry {
+	struct conflict_entry *next;
+	unsigned int nfileconflicts;
+	struct conflict_part *entries;
+	unsigned int namelen;
+	unsigned int pathlen;
+	char name[FLEX_ARRAY];
+};
+
+struct ondisk_conflict_part {
+	unsigned short flags;
+	unsigned short entry_mode;
+	unsigned char sha1[20];
+};
+
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
@@ -174,6 +231,18 @@ struct cache_entry {
 #define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
 
 /*
+ * Representation of the extended on-disk flags in the v5 format.
+ * They must not collide with the ordinary on-disk flags, and need to
+ * fit in 16 bits.  Note however that v5 does not save the name
+ * length.
+ */
+#define CE_INTENT_TO_ADD_V5  (0x4000)
+#define CE_SKIP_WORKTREE_V5  (0x0800)
+#if (CE_VALID|CE_STAGEMASK) & (CE_INTENTTOADD_V5|CE_SKIPWORKTREE_V5)
+#error "v5 on-disk flags collide with ordinary on-disk flags"
+#endif
+
+/*
  * Safeguard to avoid saving wrong flags:
  *  - CE_EXTENDED2 won't get saved until its semantic is known
  *  - Bits in 0x0000FFFF have been saved in ce_flags already
@@ -212,6 +281,8 @@ static inline unsigned create_ce_flags(unsigned stage)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
 
+#define conflict_stage(c) ((CONFLICT_STAGEMASK & (c)->flags) >> CONFLICT_STAGESHIFT)
+
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
 {
@@ -259,6 +330,8 @@ static inline unsigned int canon_mode(unsigned int mode)
 }
 
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
+#define directory_entry_size(len) (offsetof(struct directory_entry,pathname) + (len) + 1)
+#define conflict_entry_size(len) (offsetof(struct conflict_entry,name) + (len) + 1)
 
 /*
  * Options by which the index should be filtered when read partially.
diff --git a/read-cache-v5.c b/read-cache-v5.c
new file mode 100644
index 0000000..e319f30
--- /dev/null
+++ b/read-cache-v5.c
@@ -0,0 +1,658 @@
+#include "cache.h"
+#include "read-cache.h"
+#include "resolve-undo.h"
+#include "cache-tree.h"
+#include "dir.h"
+
+#define ptr_add(x,y) ((void *)(((char *)(x)) + (y)))
+
+struct cache_header {
+	unsigned int hdr_ndir;
+	unsigned int hdr_nfile;
+	unsigned int hdr_fblockoffset;
+	unsigned int hdr_nextension;
+};
+
+/*****************************************************************
+ * Index File I/O
+ *****************************************************************/
+
+struct ondisk_cache_entry {
+	unsigned short flags;
+	unsigned short mode;
+	struct cache_time mtime;
+	unsigned int size;
+	int stat_crc;
+	unsigned char sha1[20];
+};
+
+struct ondisk_directory_entry {
+	unsigned int foffset;
+	unsigned int cr;
+	unsigned int ncr;
+	unsigned int nsubtrees;
+	unsigned int nfiles;
+	unsigned int nentries;
+	unsigned char sha1[20];
+	unsigned short flags;
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
+	struct cache_version_header *hdr;
+	struct cache_header *hdr_v5;
+
+	if (size < sizeof(struct cache_version_header)
+			+ sizeof (struct cache_header) + 4)
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
+						   struct directory_entry *de,
+						   char *name,
+						   size_t len,
+						   size_t prefix_len)
+{
+	struct cache_entry *ce = xmalloc(cache_entry_size(len + de->de_pathlen));
+	int flags;
+
+	flags = ntoh_s(ondisk->flags);
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
+	ce->ce_namelen    = len + de->de_pathlen;
+	hashcpy(ce->sha1, ondisk->sha1);
+	memcpy(ce->name, de->pathname, de->de_pathlen);
+	memcpy(ce->name + de->de_pathlen, name, len);
+	ce->name[len + de->de_pathlen] = '\0';
+	ce->next_ce = NULL;
+	return ce;
+}
+
+static struct directory_entry *directory_entry_from_ondisk(struct ondisk_directory_entry *ondisk,
+						   const char *name,
+						   size_t len)
+{
+	struct directory_entry *de = xmalloc(directory_entry_size(len));
+
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
+static struct conflict_part *conflict_part_from_ondisk(struct ondisk_conflict_part *ondisk)
+{
+	struct conflict_part *cp = xmalloc(sizeof(struct conflict_part));
+
+	cp->flags      = ntoh_s(ondisk->flags);
+	cp->entry_mode = ntoh_s(ondisk->entry_mode);
+	hashcpy(cp->sha1, ondisk->sha1);
+	return cp;
+}
+
+static struct cache_entry *convert_conflict_part(struct conflict_part *cp,
+						char * name,
+						unsigned int len)
+{
+
+	struct cache_entry *ce = xmalloc(cache_entry_size(len));
+
+	ce->ce_stat_data.sd_ctime.sec  = 0;
+	ce->ce_stat_data.sd_mtime.sec  = 0;
+	ce->ce_stat_data.sd_ctime.nsec = 0;
+	ce->ce_stat_data.sd_mtime.nsec = 0;
+	ce->ce_stat_data.sd_dev        = 0;
+	ce->ce_stat_data.sd_ino        = 0;
+	ce->ce_stat_data.sd_uid        = 0;
+	ce->ce_stat_data.sd_gid        = 0;
+	ce->ce_stat_data.sd_size       = 0;
+	ce->ce_mode       = cp->entry_mode;
+	ce->ce_flags      = conflict_stage(cp) << CE_STAGESHIFT;
+	ce->ce_stat_crc   = 0;
+	ce->ce_namelen    = len;
+	hashcpy(ce->sha1, cp->sha1);
+	memcpy(ce->name, name, len);
+	ce->name[len] = '\0';
+	return ce;
+}
+
+static struct directory_entry *read_directories(unsigned int *dir_offset,
+				unsigned int *dir_table_offset,
+				void *mmap,
+				int mmap_size)
+{
+	int i, ondisk_directory_size;
+	uint32_t *filecrc, *beginning, *end;
+	struct directory_entry *current = NULL;
+	struct ondisk_directory_entry *disk_de;
+	struct directory_entry *de;
+	unsigned int data_len, len;
+	char *name;
+
+	/* Length of pathname + nul byte for termination + size of
+	 * members of ondisk_directory_entry. (Just using the size
+	 * of the stuct doesn't work, because there may be padding
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
+
+	data_len = len + 1 + ondisk_directory_size;
+	filecrc = ptr_add(mmap, *dir_offset + data_len);
+	if (!check_crc32(0, ptr_add(mmap, *dir_offset), data_len, ntoh_l(*filecrc)))
+		goto unmap;
+
+	*dir_table_offset += 4;
+	*dir_offset += data_len + 4; /* crc code */
+
+	current = de;
+	for (i = 0; i < de->de_nsubtrees; i++) {
+		current->next = read_directories(dir_offset, dir_table_offset,
+						mmap, mmap_size);
+		while (current->next)
+			current = current->next;
+	}
+
+	return de;
+unmap:
+	munmap(mmap, mmap_size);
+	die("directory crc doesn't match for '%s'", de->pathname);
+}
+
+static int read_entry(struct cache_entry **ce, struct directory_entry *de,
+		      unsigned int *entry_offset,
+		      void **mmap, unsigned long mmap_size,
+		      unsigned int *foffsetblock)
+{
+	int len, offset_to_offset;
+	char *name;
+	uint32_t foffsetblockcrc;
+	uint32_t *filecrc, *beginning, *end;
+	struct ondisk_cache_entry *disk_ce;
+
+	name = ptr_add(*mmap, *entry_offset);
+	beginning = ptr_add(*mmap, *foffsetblock);
+	end = ptr_add(*mmap, *foffsetblock + 4);
+	len = ntoh_l(*end) - ntoh_l(*beginning) - sizeof(struct ondisk_cache_entry) - 5;
+	disk_ce = ptr_add(*mmap, *entry_offset + len + 1);
+	*ce = cache_entry_from_ondisk(disk_ce, de, name, len, de->de_pathlen);
+	filecrc = ptr_add(*mmap, *entry_offset + len + 1 + sizeof(*disk_ce));
+	offset_to_offset = htonl(*foffsetblock);
+	foffsetblockcrc = crc32(0, (Bytef*)&offset_to_offset, 4);
+	if (!check_crc32(foffsetblockcrc,
+		ptr_add(*mmap, *entry_offset), len + 1 + sizeof(*disk_ce),
+		ntoh_l(*filecrc)))
+		return -1;
+
+	*entry_offset += len + 1 + sizeof(*disk_ce) + 4;
+	return 0;
+}
+
+static void ce_queue_push(struct cache_entry **head,
+			     struct cache_entry **tail,
+			     struct cache_entry *ce)
+{
+	if (!*head) {
+		*head = *tail = ce;
+		(*tail)->next = NULL;
+		return;
+	}
+
+	(*tail)->next = ce;
+	ce->next = NULL;
+	*tail = (*tail)->next;
+}
+
+static void conflict_entry_push(struct conflict_entry **head,
+				struct conflict_entry **tail,
+				struct conflict_entry *conflict_entry)
+{
+	if (!*head) {
+		*head = *tail = conflict_entry;
+		(*tail)->next = NULL;
+		return;
+	}
+
+	(*tail)->next = conflict_entry;
+	conflict_entry->next = NULL;
+	*tail = (*tail)->next;
+}
+
+static struct cache_entry *ce_queue_pop(struct cache_entry **head)
+{
+	struct cache_entry *ce;
+
+	ce = *head;
+	*head = (*head)->next;
+	return ce;
+}
+
+static void conflict_part_head_remove(struct conflict_part **head)
+{
+	struct conflict_part *to_free;
+
+	to_free = *head;
+	*head = (*head)->next;
+	free(to_free);
+}
+
+static void conflict_entry_head_remove(struct conflict_entry **head)
+{
+	struct conflict_entry *to_free;
+
+	to_free = *head;
+	*head = (*head)->next;
+	free(to_free);
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
+static int read_conflicts(struct conflict_entry **head,
+			  struct directory_entry *de,
+			  void **mmap, unsigned long mmap_size)
+{
+	struct conflict_entry *tail;
+	unsigned int croffset, i;
+	char *full_name;
+
+	croffset = de->de_cr;
+	tail = NULL;
+	for (i = 0; i < de->de_ncr; i++) {
+		struct conflict_entry *conflict_new;
+		unsigned int len, *nfileconflicts;
+		char *name;
+		void *crc_start;
+		int k, offset;
+		uint32_t *filecrc;
+
+		offset = croffset;
+		crc_start = ptr_add(*mmap, offset);
+		name = ptr_add(*mmap, offset);
+		len = strlen(name);
+		offset += len + 1;
+		nfileconflicts = ptr_add(*mmap, offset);
+		offset += 4;
+
+		full_name = xmalloc(sizeof(char) * (len + de->de_pathlen));
+		memcpy(full_name, de->pathname, de->de_pathlen);
+		memcpy(full_name + de->de_pathlen, name, len);
+		conflict_new = create_new_conflict(full_name,
+				len + de->de_pathlen, de->de_pathlen);
+		for (k = 0; k < ntoh_l(*nfileconflicts); k++) {
+			struct ondisk_conflict_part *ondisk;
+			struct conflict_part *cp;
+
+			ondisk = ptr_add(*mmap, offset);
+			cp = conflict_part_from_ondisk(ondisk);
+			cp->next = NULL;
+			add_part_to_conflict_entry(de, conflict_new, cp);
+			offset += sizeof(struct ondisk_conflict_part);
+		}
+		filecrc = ptr_add(*mmap, offset);
+		free(full_name);
+		if (!check_crc32(0, crc_start,
+			len + 1 + 4 + conflict_new->nfileconflicts
+			* sizeof(struct ondisk_conflict_part),
+			ntoh_l(*filecrc)))
+			return -1;
+		croffset = offset + 4;
+		conflict_entry_push(head, &tail, conflict_new);
+	}
+	return 0;
+}
+
+static int read_entries(struct index_state *istate, struct directory_entry **de,
+			unsigned int *entry_offset, void **mmap,
+			unsigned long mmap_size, unsigned int *nr,
+			unsigned int *foffsetblock, struct cache_entry **prev)
+{
+	struct cache_entry *head = NULL, *tail = NULL;
+	struct conflict_entry *conflict_queue;
+	struct cache_entry *ce;
+	int i;
+
+	conflict_queue = NULL;
+	if (read_conflicts(&conflict_queue, *de, mmap, mmap_size) < 0)
+		return -1;
+	for (i = 0; i < (*de)->de_nfiles; i++) {
+		if (read_entry(&ce,
+			       *de,
+			       entry_offset,
+			       mmap,
+			       mmap_size,
+			       foffsetblock) < 0)
+			return -1;
+		ce_queue_push(&head, &tail, ce);
+		*foffsetblock += 4;
+
+		/*
+		 * Add the conflicted entries at the end of the index file
+		 * to the in memory format
+		 */
+		if (conflict_queue &&
+		    (conflict_queue->entries->flags & CONFLICT_CONFLICTED) != 0 &&
+		    !cache_name_compare(conflict_queue->name, conflict_queue->namelen,
+					ce->name, ce_namelen(ce))) {
+			struct conflict_part *cp;
+			cp = conflict_queue->entries;
+			cp = cp->next;
+			while (cp) {
+				ce = convert_conflict_part(cp,
+						conflict_queue->name,
+						conflict_queue->namelen);
+				ce_queue_push(&head, &tail, ce);
+				conflict_part_head_remove(&cp);
+			}
+			conflict_entry_head_remove(&conflict_queue);
+		}
+	}
+
+	*de = (*de)->next;
+
+	while (head) {
+		if (*de != NULL
+		    && strcmp(head->name, (*de)->pathname) > 0) {
+			read_entries(istate,
+				     de,
+				     entry_offset,
+				     mmap,
+				     mmap_size,
+				     nr,
+				     foffsetblock,
+				     prev);
+		} else {
+			ce = ce_queue_pop(&head);
+			set_index_entry(istate, *nr, ce);
+			if (*prev)
+				(*prev)->next_ce = ce;
+			(*nr)++;
+			*prev = ce;
+			ce->next = NULL;
+		}
+	}
+	return 0;
+}
+
+static struct directory_entry *read_head_directories(struct index_state *istate,
+						     unsigned int *entry_offset,
+						     unsigned int *foffsetblock,
+						     unsigned int *ndirs,
+						     void *mmap, unsigned long mmap_size)
+{
+	unsigned int dir_offset, dir_table_offset;
+	struct cache_version_header *hdr;
+	struct cache_header *hdr_v5;
+	struct directory_entry *root_directory;
+
+	hdr = mmap;
+	hdr_v5 = ptr_add(mmap, sizeof(*hdr));
+	istate->version = ntohl(hdr->hdr_version);
+	istate->cache_alloc = alloc_nr(ntohl(hdr_v5->hdr_nfile));
+	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
+	istate->initialized = 1;
+
+	/* Skip size of the header + crc sum + size of offsets */
+	dir_offset = sizeof(*hdr) + sizeof(*hdr_v5) + 4 + (ntohl(hdr_v5->hdr_ndir) + 1) * 4;
+	dir_table_offset = sizeof(*hdr) + sizeof(*hdr_v5) + 4;
+	root_directory = read_directories(&dir_offset, &dir_table_offset,
+					  mmap, mmap_size);
+
+	*entry_offset = ntohl(hdr_v5->hdr_fblockoffset);
+	*foffsetblock = dir_offset;
+	*ndirs = ntohl(hdr_v5->hdr_ndir);
+	return root_directory;
+}
+
+static int read_index_filtered_v5(struct index_state *istate, void *mmap,
+				  unsigned long mmap_size, struct filter_opts *opts)
+{
+	unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
+	struct directory_entry *root_directory, *de;
+	int i, n;
+	const char **adjusted_pathspec = NULL;
+	int need_root = 1;
+	char *seen, *oldpath;
+	struct cache_entry *prev = NULL;
+
+	root_directory = read_head_directories(istate, &entry_offset,
+					       &foffsetblock, &ndirs,
+					       mmap, mmap_size);
+
+	if (opts && opts->pathspec) {
+		need_root = 0;
+		seen = xcalloc(1, ndirs);
+		for (de = root_directory; de; de = de->next)
+			match_pathspec(opts->pathspec, de->pathname, de->de_pathlen, 0, seen);
+		for (n = 0; opts->pathspec[n]; n++)
+			/* just count */;
+		adjusted_pathspec = xmalloc((n+1)*sizeof(char *));
+		adjusted_pathspec[n] = NULL;
+		for (i = 0; i < n; i++) {
+			if (seen[i] == MATCHED_EXACTLY)
+				adjusted_pathspec[i] = opts->pathspec[i];
+			else {
+				char *super = strdup(opts->pathspec[i]);
+				int len = strlen(super);
+				while (len && super[len - 1] == '/')
+					super[--len] = '\0'; /* strip trailing / */
+				while (len && super[--len] != '/')
+					; /* scan backwards to next / */
+				if (len >= 0)
+					super[len--] = '\0';
+				if (len <= 0) {
+					need_root = 1;
+					break;
+				}
+				adjusted_pathspec[i] = super;
+			}
+		}
+	}
+
+	de = root_directory;
+	while (de) {
+		if (need_root ||
+		    match_pathspec(adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
+			unsigned int subdir_foffsetblock = de->de_foffset + foffsetblock;
+			unsigned int *off = mmap + subdir_foffsetblock;
+			unsigned int subdir_entry_offset = entry_offset + ntoh_l(*off);
+			oldpath = de->pathname;
+			do {
+				if (read_entries(istate, &de, &subdir_entry_offset,
+						 &mmap, mmap_size, &nr,
+						 &subdir_foffsetblock, &prev) < 0)
+					return -1;
+			} while (de && !prefixcmp(de->pathname, oldpath));
+		} else
+			de = de->next;
+	}
+	istate->cache_nr = nr;
+	istate->partially_read = 1;
+	return 0;
+}
+
+static int read_index_v5(struct index_state *istate, void *mmap,
+			 unsigned long mmap_size, struct filter_opts *opts)
+{
+	unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
+	struct directory_entry *root_directory, *de;
+	struct cache_entry *prev = NULL;
+
+	if (opts != NULL)
+		return read_index_filtered_v5(istate, mmap, mmap_size, opts);
+
+	root_directory = read_head_directories(istate, &entry_offset,
+					       &foffsetblock, &ndirs,
+					       mmap, mmap_size);
+	de = root_directory;
+	while (de)
+		if (read_entries(istate, &de, &entry_offset, &mmap,
+				 mmap_size, &nr, &foffsetblock, &prev) < 0)
+			return -1;
+	istate->cache_nr = nr;
+	istate->partially_read = 0;
+	return 0;
+}
+
+static void index_change_filter_opts_v5(struct index_state *istate, struct filter_opts *opts)
+{
+	if (istate->initialized == 1 &&
+	    (((istate->filter_opts == NULL || opts == NULL) && istate->filter_opts != opts)
+	     || (!memcmp(istate->filter_opts, opts, sizeof(*opts)))))
+		return;
+	discard_index(istate);
+	read_index_filtered(istate, opts);
+}
+
+struct index_ops v5_ops = {
+	match_stat_basic,
+	verify_hdr,
+	read_index_v5,
+	NULL,
+	index_change_filter_opts_v5
+};
diff --git a/read-cache.h b/read-cache.h
index ce9b79c..fe53c8e 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -39,6 +39,7 @@ struct internal_ops {
 
 extern struct index_ops v2_ops;
 extern struct internal_ops v2_internal_ops;
+extern struct index_ops v5_ops;
 
 #ifndef NEEDS_ALIGNED_ACCESS
 #define ntoh_s(var) ntohs(var)
-- 
1.8.3.453.g1dfc63d
