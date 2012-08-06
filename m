From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Add index-v5
Date: Mon,  6 Aug 2012 21:36:00 +0700
Message-ID: <1344263760-31191-3-git-send-email-pclouds@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 16:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyORK-0001lU-HG
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 16:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab2HFOhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 10:37:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47575 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756646Ab2HFOha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 10:37:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2667860pbb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bdijcWvEsAxIAsilfBh1Z7MGaS7xNqtnGaGhnspEB9Q=;
        b=zuhda+forsu/bW4Sj+MRy/jJ4Miq16eHB2aM/x36u1CQtkC01h97z53veLmIwRYSE+
         x2b+pgQVIvFmA9lfBpWZGETiT6KkLhDvaITr8VY/eCWd/a8QC7vbYXtpsRf67Q9CE2Kx
         RmsSaQDBBO9yr2Cg2oW/KeKiZuvOfw+IVJLwizcMo10JS0E96dKOFlYxTlqLK2Lp5qeh
         h35l0PspkAWOqKzVQIFetyLGKwEkMBGo6yLusxfH7kIjq5hJ0CW3ROk/rsP1QOyzjvoK
         crDu5H0Uhl5ZrE9YCUN7oTCnbOxyM1eoU/wKpDtPeG8T91td5x6oXRwvIVHMN2PCrrIz
         scCw==
Received: by 10.68.239.103 with SMTP id vr7mr19843955pbc.0.1344263849876;
        Mon, 06 Aug 2012 07:37:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.147])
        by mx.google.com with ESMTPS id pt2sm9069034pbb.58.2012.08.06.07.37.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 07:37:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 06 Aug 2012 21:36:18 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1344263760-31191-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202966>

---
 Makefile        |    1 +
 read-cache-v5.c | 1170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.c    |   27 ++
 3 files changed, 1198 insertions(+), 0 deletions(-)
 create mode 100644 read-cache-v5.c

diff --git a/Makefile b/Makefile
index b4a7c73..77be175 100644
--- a/Makefile
+++ b/Makefile
@@ -770,6 +770,7 @@ LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += read-cache-v2.o
+LIB_OBJS += read-cache-v5.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
diff --git a/read-cache-v5.c b/read-cache-v5.c
new file mode 100644
index 0000000..a4a3746
--- /dev/null
+++ b/read-cache-v5.c
@@ -0,0 +1,1170 @@
+#include "cache.h"
+#include "read-cache.h"
+#include "resolve-undo.h"
+#include "cache-tree.h"
+
+struct cache_header_v5 {
+	unsigned int hdr_ndir;
+	unsigned int hdr_nfile;
+	unsigned int hdr_fblockoffset;
+	unsigned int hdr_nextension;
+};
+
+struct ondisk_cache_entry_v5 {
+	unsigned short flags;
+	unsigned short mode;
+	struct cache_time mtime;
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
+static int match_stat_crc(struct stat *st, uint32_t expected_crc)
+{
+	uint32_t data, stat_crc = 0;
+	unsigned int ctimens = 0;
+
+	data = htonl(st->st_ctime);
+	stat_crc = crc32(0, (Bytef*)&data, 4);
+#ifdef USE_NSEC
+	ctimens = ST_MTIME_NSEC(*st);
+#endif
+	data = htonl(ctimens);
+	stat_crc = crc32(stat_crc, (Bytef*)&data, 4);
+	data = htonl(st->st_ino);
+	stat_crc = crc32(stat_crc, (Bytef*)&data, 4);
+	data = htonl(st->st_size);
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
+static int match_stat_basic(struct cache_entry *ce,
+			    struct stat *st,
+			    int changed)
+{
+
+	if (ce->ce_mtime.sec != 0 && ce->ce_mtime.sec != (unsigned int)st->st_mtime)
+		changed |= MTIME_CHANGED;
+#ifdef USE_NSEC
+	if (ce->ce_mtime.nsec != 0 && ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
+		changed |= MTIME_CHANGED;
+#endif
+	if (!match_stat_crc(st, ce->ce_stat_crc)) {
+		changed |= OWNER_CHANGED;
+		changed |= INODE_CHANGED;
+	}
+	/* Racily smudged entry? */
+	if (!ce->ce_mtime.sec && !ce->ce_mtime.nsec) {
+		if (!changed && !is_empty_blob_sha1(ce->sha1) && ce_modified_check_fs(ce, st))
+			changed |= DATA_CHANGED;
+	}
+	return changed;
+}
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
+static int verify_hdr(struct cache_version_header *hdr, unsigned long size)
+{
+	uint32_t *filecrc;
+	unsigned int header_size_v5;
+	struct cache_header_v5 *hdr_v5;
+	void *mmap = hdr;;
+
+	hdr = mmap;
+	hdr_v5 = mmap + sizeof(*hdr);
+	/* Size of the header + the size of the extensionoffsets */
+	header_size_v5 = sizeof(*hdr_v5) + hdr_v5->hdr_nextension * 4;
+	/* Initialize crc */
+	filecrc = mmap + sizeof(*hdr) + header_size_v5;
+	if (!check_crc32(0, hdr, sizeof(*hdr) + header_size_v5, ntohl(*filecrc)))
+		return error("bad index file header crc signature");
+	return 0;
+}
+
+static struct cache_entry *cache_entry_from_ondisk_v5(struct ondisk_cache_entry_v5 *ondisk,
+						   struct directory_entry *de,
+						   char *name,
+						   size_t len,
+						   size_t prefix_len)
+{
+	struct cache_entry *ce = xmalloc(cache_entry_size(len + de->de_pathlen));
+	int flags;
+
+	flags = ntoh_s(ondisk->flags);
+	ce->ce_ctime.sec  = 0;
+	ce->ce_mtime.sec  = ntoh_l(ondisk->mtime.sec);
+	ce->ce_ctime.nsec = 0;
+	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
+	ce->ce_dev        = 0;
+	ce->ce_ino        = 0;
+	ce->ce_mode       = ntoh_s(ondisk->mode);
+	ce->ce_uid        = 0;
+	ce->ce_gid        = 0;
+	ce->ce_size       = 0;
+	ce->ce_flags      = flags & CE_STAGEMASK;
+	ce->ce_flags     |= flags & CE_VALID;
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
+	ce->ce_ctime.sec  = 0;
+	ce->ce_mtime.sec  = 0;
+	ce->ce_ctime.nsec = 0;
+	ce->ce_mtime.nsec = 0;
+	ce->ce_dev        = 0;
+	ce->ce_ino        = 0;
+	ce->ce_mode       = cp->entry_mode;
+	ce->ce_uid        = 0;
+	ce->ce_gid        = 0;
+	ce->ce_size       = 0;
+	ce->ce_flags      = conflict_stage(cp) << CE_STAGESHIFT;
+	ce->ce_stat_crc   = 0;
+	ce->ce_namelen    = len;
+	hashcpy(ce->sha1, cp->sha1);
+	memcpy(ce->name, name, len);
+	ce->name[len] = '\0';
+	return ce;
+}
+
+static struct directory_entry *read_directories_v5(unsigned int *dir_offset,
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
+	ondisk_directory_size = sizeof(disk_de->flags)
+		+ sizeof(disk_de->foffset)
+		+ sizeof(disk_de->cr)
+		+ sizeof(disk_de->ncr)
+		+ sizeof(disk_de->nsubtrees)
+		+ sizeof(disk_de->nfiles)
+		+ sizeof(disk_de->nentries)
+		+ sizeof(disk_de->sha1);
+	name = (char *)mmap + *dir_offset;
+	beginning = mmap + *dir_table_offset;
+	end = mmap + *dir_table_offset + 4;
+	len = ntoh_l(*end) - ntoh_l(*beginning) - ondisk_directory_size - 5;
+	disk_de = (struct ondisk_directory_entry *)
+			((char *)mmap + *dir_offset + len + 1);
+	de = directory_entry_from_ondisk(disk_de, name, len);
+	de->next = NULL;
+
+	/* Length of pathname + nul byte for termination + size of
+	 * members of ondisk_directory_entry. (Just using the size
+	 * of the stuct doesn't work, because there may be padding
+	 * bytes for the struct)
+	 */
+	data_len = len + 1 + ondisk_directory_size;
+
+	filecrc = mmap + *dir_offset + data_len;
+	if (!check_crc32(0, mmap + *dir_offset, data_len, ntoh_l(*filecrc)))
+		goto unmap;
+
+	*dir_table_offset += 4;
+	*dir_offset += data_len + 4; /* crc code */
+
+	current = de;
+	for (i = 0; i < de->de_nsubtrees; i++) {
+		current->next = read_directories_v5(dir_offset, dir_table_offset,
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
+static struct cache_entry *read_entry_v5(struct directory_entry *de,
+			unsigned long *entry_offset,
+			void **mmap,
+			unsigned long mmap_size,
+			unsigned int *foffsetblock,
+			int fd)
+{
+	int len, crc_wrong, i = 0, offset_to_offset;
+	char *name;
+	uint32_t foffsetblockcrc;
+	uint32_t *filecrc, *beginning, *end;
+	struct cache_entry *ce;
+	struct ondisk_cache_entry_v5 *disk_ce;
+
+	do {
+		name = (char *)*mmap + *entry_offset;
+		beginning = *mmap + *foffsetblock;
+		end = *mmap + *foffsetblock + 4;
+		len = ntoh_l(*end) - ntoh_l(*beginning) - sizeof(struct ondisk_cache_entry_v5) - 5;
+		disk_ce = (struct ondisk_cache_entry_v5 *)
+				((char *)*mmap + *entry_offset + len + 1);
+		ce = cache_entry_from_ondisk_v5(disk_ce, de, name, len, de->de_pathlen);
+		filecrc = *mmap + *entry_offset + len + 1 + sizeof(*disk_ce);
+		offset_to_offset = htonl(*foffsetblock);
+		foffsetblockcrc = crc32(0, (Bytef*)&offset_to_offset, 4);
+		crc_wrong = !check_crc32(foffsetblockcrc,
+			*mmap + *entry_offset, len + 1 + sizeof(*disk_ce),
+			ntoh_l(*filecrc));
+		if (crc_wrong) {
+			/* wait for 10 milliseconds */
+			usleep(10*1000);
+			munmap(*mmap, mmap_size);
+			*mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		}
+		i++;
+		/*
+		 * Retry for 500 ms maximum, before giving up and saying the
+		 * checksum is wrong.
+		 */
+	} while (crc_wrong && i < 50);
+	if (crc_wrong)
+		goto unmap;
+	*entry_offset += len + 1 + sizeof(*disk_ce) + 4;
+	return ce;
+unmap:
+	munmap(*mmap, mmap_size);
+	die("file crc doesn't match for '%s'", ce->name);
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
+static struct conflict_entry *read_conflicts_v5(struct directory_entry *de,
+						void **mmap,
+						unsigned long mmap_size,
+						int fd)
+{
+	struct conflict_entry *head, *tail;
+	unsigned int croffset, i, j = 0;
+	char *full_name;
+
+	croffset = de->de_cr;
+	tail = NULL;
+	head = NULL;
+	for (i = 0; i < de->de_ncr; i++) {
+		struct conflict_entry *conflict_new;
+		unsigned int len, *nfileconflicts;
+		char *name;
+		void *crc_start;
+		int k, offset, crc_wrong;
+		uint32_t *filecrc;
+
+		do {
+			offset = croffset;
+			crc_start = *mmap + offset;
+			name = (char *)*mmap + offset;
+			len = strlen(name);
+			offset += len + 1;
+			nfileconflicts = *mmap + offset;
+			offset += 4;
+
+			full_name = xmalloc(sizeof(char) * (len + de->de_pathlen));
+			memcpy(full_name, de->pathname, de->de_pathlen);
+			memcpy(full_name + de->de_pathlen, name, len);
+			conflict_new = create_new_conflict(full_name,
+					len + de->de_pathlen, de->de_pathlen);
+			for (k = 0; k < ntoh_l(*nfileconflicts); k++) {
+				struct ondisk_conflict_part *ondisk;
+				struct conflict_part *cp;
+
+				ondisk = *mmap + offset;
+				cp = conflict_part_from_ondisk(ondisk);
+				cp->next = NULL;
+				add_part_to_conflict_entry(de, conflict_new, cp);
+				offset += sizeof(struct ondisk_conflict_part);
+			}
+			filecrc = *mmap + offset;
+			crc_wrong = !check_crc32(0, crc_start,
+				len + 1 + 4 + conflict_new->nfileconflicts
+				* sizeof(struct ondisk_conflict_part),
+				ntoh_l(*filecrc));
+			if (crc_wrong) {
+				/* wait for 10 milliseconds */
+				usleep(10*1000);
+				munmap(*mmap, mmap_size);
+				*mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+			}
+			free(full_name);
+			j++;
+		} while (crc_wrong && j < 50);
+		if (crc_wrong)
+			goto unmap;
+		croffset = offset + 4;
+		conflict_entry_push(&head, &tail, conflict_new);
+	}
+	return head;
+unmap:
+	munmap(*mmap, mmap_size);
+	die("wrong crc for conflict: %s", full_name);
+}
+
+static struct directory_entry *read_entries_v5(struct index_state *istate,
+					struct directory_entry *de,
+					unsigned long *entry_offset,
+					void **mmap,
+					unsigned long mmap_size,
+					int *nr,
+					unsigned int *foffsetblock,
+					int fd)
+{
+	struct cache_entry *head = NULL, *tail = NULL;
+	struct conflict_entry *conflict_queue;
+	struct cache_entry *ce;
+	int i;
+
+	conflict_queue = read_conflicts_v5(de, mmap, mmap_size, fd);
+	resolve_undo_convert_v5(istate, conflict_queue);
+	for (i = 0; i < de->de_nfiles; i++) {
+		ce = read_entry_v5(de,
+				entry_offset,
+				mmap,
+				mmap_size,
+				foffsetblock,
+				fd);
+		ce_queue_push(&head, &tail, ce);
+		*foffsetblock += 4;
+
+		/* Add the conflicted entries at the end of the index file
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
+	de = de->next;
+
+	while (head) {
+		if (de != NULL
+		    && strcmp(head->name, de->pathname) > 0) {
+			de = read_entries_v5(istate,
+					de,
+					entry_offset,
+					mmap,
+					mmap_size,
+					nr,
+					foffsetblock,
+					fd);
+		} else {
+			ce = ce_queue_pop(&head);
+			set_index_entry(istate, *nr, ce);
+			(*nr)++;
+		}
+	}
+
+	return de;
+}
+
+static void read_index_v5(struct index_state *istate, void *mmap, int mmap_size, int fd)
+{
+	unsigned long entry_offset;
+	unsigned int dir_offset, dir_table_offset;
+	struct cache_version_header *hdr;
+	struct cache_header_v5 *hdr_v5;
+	struct directory_entry *root_directory, *de;
+	int nr;
+	unsigned int foffsetblock;
+
+	hdr = mmap;
+	hdr_v5 = mmap + sizeof(*hdr);
+	istate->version = ntohl(hdr->hdr_version);
+	istate->cache_nr = ntohl(hdr_v5->hdr_nfile);
+	istate->cache_alloc = alloc_nr(istate->cache_nr);
+	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
+	istate->initialized = 1;
+
+	/* Skip size of the header + crc sum + size of offsets */
+	dir_offset = sizeof(*hdr) + sizeof(*hdr_v5) + 4 + (ntohl(hdr_v5->hdr_ndir) + 1) * 4;
+	dir_table_offset = sizeof(*hdr) + sizeof(*hdr_v5) + 4;
+	root_directory = read_directories_v5(&dir_offset, &dir_table_offset, mmap, mmap_size);
+
+	entry_offset = ntohl(hdr_v5->hdr_fblockoffset);
+
+	nr = 0;
+	foffsetblock = dir_offset;
+	de = root_directory;
+	while (de)
+		de = read_entries_v5(istate, de, &entry_offset,
+				&mmap, mmap_size, &nr, &foffsetblock, fd);
+	istate->cache_tree = cache_tree_convert_v5(root_directory);
+}
+
+#define WRITE_BUFFER_SIZE 8192
+static unsigned char write_buffer[WRITE_BUFFER_SIZE];
+static unsigned long write_buffer_len;
+
+static int ce_flush_v5(int fd)
+{
+	unsigned int left = write_buffer_len;
+
+	if (left)
+		write_buffer_len = 0;
+
+	if (write_in_full(fd, write_buffer, left) != left)
+		return -1;
+
+	return 0;
+}
+
+static void ce_smudge_racily_clean_entry_v5(struct cache_entry *ce)
+{
+	/*
+	 * This method shall only be called if the timestamp of ce
+	 * is racy (check with is_racy_timestamp). If the timestamp
+	 * is racy, the writer will just set the time to 0.
+	 *
+	 * The reader (ce_match_stat_basic_v5) will then take care
+	 * of checking if the entry is really changed or not, by
+	 * taking into account the stat_crc and if that hasn't changed
+	 * checking the sha1.
+	 */
+	ce->ce_mtime.sec = 0;
+	ce->ce_mtime.nsec = 0;
+}
+
+static int ce_write_flush_v5(int fd)
+{
+	unsigned int buffered = write_buffer_len;
+	if (buffered) {
+		if (write_in_full(fd, write_buffer, buffered) != buffered)
+			return -1;
+		write_buffer_len = 0;
+	}
+	return 0;
+}
+
+static int ce_write_v5(uint32_t *crc, int fd, void *data, unsigned int len)
+{
+	if (crc)
+		*crc = crc32(*crc, (Bytef*)data, len);
+	while (len) {
+		unsigned int buffered = write_buffer_len;
+		unsigned int partial = WRITE_BUFFER_SIZE - buffered;
+		if (partial > len)
+			partial = len;
+		memcpy(write_buffer + buffered, data, partial);
+		buffered += partial;
+		if (buffered == WRITE_BUFFER_SIZE) {
+			write_buffer_len = buffered;
+			if (ce_write_flush_v5(fd))
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
+char *super_directory(const char *filename)
+{
+	char *slash;
+
+	slash = strrchr(filename, '/');
+	if (slash)
+		return xmemdupz(filename, slash-filename);
+	return NULL;
+}
+
+struct directory_entry *init_directory_entry(char *pathname, int len)
+{
+	struct directory_entry *de = xmalloc(directory_entry_size(len));
+
+	memcpy(de->pathname, pathname, len);
+	de->pathname[len] = '\0';
+	de->de_flags      = 0;
+	de->de_foffset    = 0;
+	de->de_cr         = 0;
+	de->de_ncr        = 0;
+	de->de_nsubtrees  = 0;
+	de->de_nfiles     = 0;
+	de->de_nentries   = 0;
+	memset(de->sha1, 0, 20);
+	de->de_pathlen    = len;
+	de->next          = NULL;
+	de->next_hash     = NULL;
+	de->ce            = NULL;
+	de->ce_last       = NULL;
+	de->conflict      = NULL;
+	de->conflict_last = NULL;
+	de->conflict_size = 0;
+	return de;
+}
+
+static void ondisk_from_directory_entry(struct directory_entry *de,
+					struct ondisk_directory_entry *ondisk)
+{
+	ondisk->foffset   = htonl(de->de_foffset);
+	ondisk->cr        = htonl(de->de_cr);
+	ondisk->ncr       = htonl(de->de_ncr);
+	ondisk->nsubtrees = htonl(de->de_nsubtrees);
+	ondisk->nfiles    = htonl(de->de_nfiles);
+	ondisk->nentries  = htonl(de->de_nentries);
+	hashcpy(ondisk->sha1, de->sha1);
+	ondisk->flags     = htons(de->de_flags);
+}
+
+static struct conflict_part *conflict_part_from_inmemory(struct cache_entry *ce)
+{
+	struct conflict_part *conflict;
+	short flags;
+
+	conflict = xmalloc(sizeof(struct conflict_part));
+	flags                = CONFLICT_CONFLICTED;
+	flags               |= ce_stage(ce) << CONFLICT_STAGESHIFT;
+	conflict->flags      = flags;
+	conflict->entry_mode = ce->ce_mode;
+	conflict->next       = NULL;
+	hashcpy(conflict->sha1, ce->sha1);
+	return conflict;
+}
+
+static void conflict_to_ondisk(struct conflict_part *cp,
+				struct ondisk_conflict_part *ondisk)
+{
+	ondisk->flags      = htons(cp->flags);
+	ondisk->entry_mode = htons(cp->entry_mode);
+	hashcpy(ondisk->sha1, cp->sha1);
+}
+
+void add_conflict_to_directory_entry(struct directory_entry *de,
+					struct conflict_entry *conflict_entry)
+{
+	de->de_ncr++;
+	de->conflict_size += conflict_entry->namelen + 1 + 8 - conflict_entry->pathlen;
+	conflict_entry_push(&de->conflict, &de->conflict_last, conflict_entry);
+}
+
+void insert_directory_entry(struct directory_entry *de,
+			struct hash_table *table,
+			int *total_dir_len,
+			unsigned int *ndir,
+			uint32_t crc)
+{
+	struct directory_entry *insert;
+
+	insert = (struct directory_entry *)insert_hash(crc, de, table);
+	if (insert) {
+		de->next_hash = insert->next_hash;
+		insert->next_hash = de;
+	}
+	(*ndir)++;
+	if (de->de_pathlen == 0)
+		(*total_dir_len)++;
+	else
+		*total_dir_len += de->de_pathlen + 2;
+}
+
+static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *ce,
+								int pathlen)
+{
+	return create_new_conflict(ce->name, ce_namelen(ce), pathlen);
+}
+
+static struct directory_entry *compile_directory_data(struct index_state *istate,
+						int nfile,
+						unsigned int *ndir,
+						int *non_conflicted,
+						int *total_dir_len,
+						int *total_file_len)
+{
+	int i, dir_len = -1;
+	char *dir;
+	struct directory_entry *de, *current, *search, *found, *new, *previous_entry;
+	struct cache_entry **cache = istate->cache;
+	struct conflict_entry *conflict_entry;
+	struct hash_table table;
+	uint32_t crc;
+
+	init_hash(&table);
+	de = init_directory_entry("", 0);
+	current = de;
+	*ndir = 1;
+	*total_dir_len = 1;
+	crc = crc32(0, (Bytef*)de->pathname, de->de_pathlen);
+	insert_hash(crc, de, &table);
+	conflict_entry = NULL;
+	for (i = 0; i < nfile; i++) {
+		int new_entry;
+		if (cache[i]->ce_flags & CE_REMOVE)
+			continue;
+
+		new_entry = !ce_stage(cache[i]) || !conflict_entry
+		    || cache_name_compare(conflict_entry->name, conflict_entry->namelen,
+					cache[i]->name, ce_namelen(cache[i]));
+		if (new_entry)
+			(*non_conflicted)++;
+		if (dir_len < 0 || strncmp(cache[i]->name, dir, dir_len)
+		    || cache[i]->name[dir_len] != '/'
+		    || strchr(cache[i]->name + dir_len + 1, '/')) {
+			dir = super_directory(cache[i]->name);
+			if (!dir)
+				dir_len = 0;
+			else
+				dir_len = strlen(dir);
+			crc = crc32(0, (Bytef*)dir, dir_len);
+			found = lookup_hash(crc, &table);
+			search = found;
+			while (search && dir_len != 0 && strcmp(dir, search->pathname) != 0)
+				search = search->next_hash;
+		}
+		previous_entry = current;
+		if (!search || !found) {
+			new = init_directory_entry(dir, dir_len);
+			current->next = new;
+			current = current->next;
+			insert_directory_entry(new, &table, total_dir_len, ndir, crc);
+			search = current;
+		}
+		if (new_entry) {
+			search->de_nfiles++;
+			*total_file_len += ce_namelen(cache[i]) + 1;
+			if (search->de_pathlen)
+				*total_file_len -= search->de_pathlen + 1;
+			ce_queue_push(&(search->ce), &(search->ce_last), cache[i]);
+		}
+		if (ce_stage(cache[i]) > 0) {
+			struct conflict_part *conflict_part;
+			if (new_entry) {
+				conflict_entry = create_conflict_entry_from_ce(cache[i], search->de_pathlen);
+				add_conflict_to_directory_entry(search, conflict_entry);
+			}
+			conflict_part = conflict_part_from_inmemory(cache[i]);
+			add_part_to_conflict_entry(search, conflict_entry, conflict_part);
+		}
+		if (dir && !found) {
+			struct directory_entry *no_subtrees;
+
+			no_subtrees = current;
+			dir = super_directory(dir);
+			if (dir)
+				dir_len = strlen(dir);
+			else
+				dir_len = 0;
+			crc = crc32(0, (Bytef*)dir, dir_len);
+			found = lookup_hash(crc, &table);
+			while (!found) {
+				new = init_directory_entry(dir, dir_len);
+				new->de_nsubtrees = 1;
+				new->next = no_subtrees;
+				no_subtrees = new;
+				insert_directory_entry(new, &table, total_dir_len, ndir, crc);
+				dir = super_directory(dir);
+				if (!dir)
+					dir_len = 0;
+				else
+					dir_len = strlen(dir);
+				crc = crc32(0, (Bytef*)dir, dir_len);
+				found = lookup_hash(crc, &table);
+			}
+			search = found;
+			while (search->next_hash && strcmp(dir, search->pathname) != 0)
+				search = search->next_hash;
+			if (search)
+				found = search;
+			found->de_nsubtrees++;
+			previous_entry->next = no_subtrees;
+		}
+	}
+	if (istate->cache_tree)
+		cache_tree_to_ondisk_v5(&table, istate->cache_tree);
+	resolve_undo_to_ondisk_v5(&table, istate->resolve_undo, ndir, total_dir_len, de);
+	return de;
+}
+
+static void ondisk_from_cache_entry(struct cache_entry *ce,
+				    struct ondisk_cache_entry_v5 *ondisk)
+{
+	unsigned int flags;
+
+	flags  = ce->ce_flags & CE_STAGEMASK;
+	flags |= ce->ce_flags & CE_VALID;
+	if (ce->ce_flags & CE_INTENT_TO_ADD)
+		flags |= CE_INTENT_TO_ADD_V5;
+	if (ce->ce_flags & CE_SKIP_WORKTREE)
+		flags |= CE_SKIP_WORKTREE_V5;
+	ondisk->flags      = htons(flags);
+	ondisk->mode       = htons(ce->ce_mode);
+	ondisk->mtime.sec  = htonl(ce->ce_mtime.sec);
+#ifdef USE_NSEC
+	ondisk->mtime.nsec = htonl(ce->ce_mtime.nsec);
+#else
+	ondisk->mtime.nsec = 0;
+#endif
+	if (!ce->ce_stat_crc)
+		ce->ce_stat_crc = calculate_stat_crc(ce);
+	ondisk->stat_crc   = htonl(ce->ce_stat_crc);
+	hashcpy(ondisk->sha1, ce->sha1);
+}
+
+static int write_directories_v5(struct directory_entry *de, int fd, int conflict_offset)
+{
+	struct directory_entry *current;
+	struct ondisk_directory_entry ondisk;
+	int current_offset, offset_write, ondisk_size, foffset;
+	uint32_t crc;
+
+	/*
+	 * This is needed because the compiler aligns structs to sizes multipe
+	 * of 4
+	 */
+	ondisk_size = sizeof(ondisk.flags)
+		+ sizeof(ondisk.foffset)
+		+ sizeof(ondisk.cr)
+		+ sizeof(ondisk.ncr)
+		+ sizeof(ondisk.nsubtrees)
+		+ sizeof(ondisk.nfiles)
+		+ sizeof(ondisk.nentries)
+		+ sizeof(ondisk.sha1);
+	current = de;
+	current_offset = 0;
+	foffset = 0;
+	while (current) {
+		int pathlen;
+
+		offset_write = htonl(current_offset);
+		if (ce_write_v5(NULL, fd, &offset_write, 4) < 0)
+			return -1;
+		if (current->de_pathlen == 0)
+			pathlen = 0;
+		else
+			pathlen = current->de_pathlen + 1;
+		current_offset += pathlen + 1 + ondisk_size + 4;
+		current = current->next;
+	}
+	/*
+	 * Write one more offset, which points to the end of the entries,
+	 * because we use it for calculating the dir length, instead of
+	 * using strlen.
+	 */
+	offset_write = htonl(current_offset);
+	if (ce_write_v5(NULL, fd, &offset_write, 4) < 0)
+		return -1;
+	current = de;
+	while (current) {
+		crc = 0;
+		if (current->de_pathlen == 0) {
+			if (ce_write_v5(&crc, fd, current->pathname, 1) < 0)
+				return -1;
+		} else {
+			char *path;
+			path = xmalloc(sizeof(char) * (current->de_pathlen + 2));
+			memcpy(path, current->pathname, current->de_pathlen);
+			memcpy(path + current->de_pathlen, "/\0", 2);
+			if (ce_write_v5(&crc, fd, path, current->de_pathlen + 2) < 0)
+				return -1;
+		}
+		current->de_foffset = foffset;
+		current->de_cr = conflict_offset;
+		ondisk_from_directory_entry(current, &ondisk);
+		if (ce_write_v5(&crc, fd, &ondisk, ondisk_size) < 0)
+			return -1;
+		crc = htonl(crc);
+		if (ce_write_v5(NULL, fd, &crc, 4) < 0)
+			return -1;
+		conflict_offset += current->conflict_size;
+		foffset += current->de_nfiles * 4;
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_entries_v5(struct index_state *istate,
+			    struct directory_entry *de,
+			    int entries,
+			    int fd,
+			    int offset_to_offset)
+{
+	int offset, offset_write, ondisk_size;
+	struct directory_entry *current;
+
+	offset = 0;
+	ondisk_size = sizeof(struct ondisk_cache_entry_v5);
+	current = de;
+	while (current) {
+		int pathlen;
+		struct cache_entry *ce = current->ce;
+
+		if (current->de_pathlen == 0)
+			pathlen = 0;
+		else
+			pathlen = current->de_pathlen + 1;
+		while (ce) {
+			if (ce->ce_flags & CE_REMOVE)
+				continue;
+			if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
+				ce_smudge_racily_clean_entry_v5(ce);
+
+			offset_write = htonl(offset);
+			if (ce_write_v5(NULL, fd, &offset_write, 4) < 0)
+				return -1;
+			offset += ce_namelen(ce) - pathlen + 1 + ondisk_size + 4;
+			ce = ce->next;
+		}
+		current = current->next;
+	}
+	/*
+	 * Write one more offset, which points to the end of the entries,
+	 * because we use it for calculating the file length, instead of
+	 * using strlen.
+	 */
+	offset_write = htonl(offset);
+	if (ce_write_v5(NULL, fd, &offset_write, 4) < 0)
+		return -1;
+
+	offset = offset_to_offset;
+	current = de;
+	while (current) {
+		int pathlen;
+		struct cache_entry *ce = current->ce;
+
+		if (current->de_pathlen == 0)
+			pathlen = 0;
+		else
+			pathlen = current->de_pathlen + 1;
+		while (ce) {
+			struct ondisk_cache_entry_v5 ondisk;
+			uint32_t crc, calc_crc;
+
+			if (ce->ce_flags & CE_REMOVE)
+				continue;
+			calc_crc = htonl(offset);
+			crc = crc32(0, (Bytef*)&calc_crc, 4);
+			if (ce_write_v5(&crc, fd, ce->name + pathlen,
+					ce_namelen(ce) - pathlen + 1) < 0)
+				return -1;
+			ondisk_from_cache_entry(ce, &ondisk);
+			if (ce_write_v5(&crc, fd, &ondisk, ondisk_size) < 0)
+				return -1;
+			crc = htonl(crc);
+			if (ce_write_v5(NULL, fd, &crc, 4) < 0)
+				return -1;
+			offset += 4;
+			ce = ce->next;
+		}
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_conflict_v5(struct conflict_entry *conflict, int fd)
+{
+	struct conflict_entry *current;
+	struct conflict_part *current_part;
+	uint32_t crc;
+
+	current = conflict;
+	while (current) {
+		unsigned int to_write;
+
+		crc = 0;
+		if (ce_write_v5(&crc, fd,
+		     (Bytef*)(current->name + current->pathlen),
+		     current->namelen - current->pathlen) < 0)
+			return -1;
+		if (ce_write_v5(&crc, fd, (Bytef*)"\0", 1) < 0)
+			return -1;
+		to_write = htonl(current->nfileconflicts);
+		if (ce_write_v5(&crc, fd, (Bytef*)&to_write, 4) < 0)
+			return -1;
+		current_part = current->entries;
+		while (current_part) {
+			struct ondisk_conflict_part ondisk;
+
+			conflict_to_ondisk(current_part, &ondisk);
+			if (ce_write_v5(&crc, fd, (Bytef*)&ondisk, sizeof(struct ondisk_conflict_part)) < 0)
+				return 0;
+			current_part = current_part->next;
+		}
+		to_write = htonl(crc);
+		if (ce_write_v5(NULL, fd, (Bytef*)&to_write, 4) < 0)
+			return -1;
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_conflicts_v5(struct index_state *istate,
+			      struct directory_entry *de,
+			      int fd)
+{
+	struct directory_entry *current;
+
+	current = de;
+	while (current) {
+		if (current->de_ncr != 0) {
+			if (write_conflict_v5(current->conflict, fd) < 0)
+				return -1;
+		}
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_index_v5(struct index_state *istate, int newfd)
+{
+	struct cache_version_header hdr;
+	struct cache_header_v5 hdr_v5;
+	struct cache_entry **cache = istate->cache;
+	struct directory_entry *de;
+	struct ondisk_directory_entry *ondisk;
+	int entries = istate->cache_nr;
+	int i, removed, non_conflicted, total_dir_len, ondisk_directory_size;
+	int total_file_len, conflict_offset, offset_to_offset;
+	unsigned int ndir;
+	uint32_t crc;
+
+	for (i = removed = 0; i < entries; i++) {
+		if (cache[i]->ce_flags & CE_REMOVE)
+			removed++;
+	}
+	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
+	hdr.hdr_version = htonl(istate->version);
+	hdr_v5.hdr_nfile = htonl(entries - removed);
+	hdr_v5.hdr_nextension = htonl(0); /* Currently no extensions are supported */
+
+	non_conflicted = 0;
+	total_dir_len = 0;
+	total_file_len = 0;
+	de = compile_directory_data(istate, entries, &ndir, &non_conflicted,
+			&total_dir_len, &total_file_len);
+	hdr_v5.hdr_ndir = htonl(ndir);
+
+	/*
+	 * This is needed because the compiler aligns structs to sizes multipe
+	 * of 4
+	 */
+	ondisk_directory_size = sizeof(ondisk->flags)
+		+ sizeof(ondisk->foffset)
+		+ sizeof(ondisk->cr)
+		+ sizeof(ondisk->ncr)
+		+ sizeof(ondisk->nsubtrees)
+		+ sizeof(ondisk->nfiles)
+		+ sizeof(ondisk->nentries)
+		+ sizeof(ondisk->sha1);
+	hdr_v5.hdr_fblockoffset = htonl(sizeof(hdr) + sizeof(hdr_v5) + 4
+		+ (ndir + 1) * 4
+		+ total_dir_len
+		+ ndir * (ondisk_directory_size + 4)
+		+ (non_conflicted + 1) * 4);
+
+	crc = 0;
+	if (ce_write_v5(&crc, newfd, &hdr, sizeof(hdr)) < 0)
+		return -1;
+	if (ce_write_v5(&crc, newfd, &hdr_v5, sizeof(hdr_v5)) < 0)
+		return -1;
+	crc = htonl(crc);
+	if (ce_write_v5(NULL, newfd, &crc, 4) < 0)
+		return -1;
+
+	conflict_offset = sizeof(hdr) + sizeof(hdr_v5) + 4
+		+ (ndir + 1) * 4
+		+ total_dir_len
+		+ ndir * (ondisk_directory_size + 4)
+		+ (non_conflicted + 1) * 4
+		+ total_file_len
+		+ non_conflicted * (sizeof(struct ondisk_cache_entry_v5) + 4);
+	if (write_directories_v5(de, newfd, conflict_offset) < 0)
+		return -1;
+	offset_to_offset = sizeof(hdr) + sizeof(hdr_v5) + 4
+		+ (ndir + 1) * 4
+		+ total_dir_len
+		+ ndir * (ondisk_directory_size + 4);
+	if (write_entries_v5(istate, de, entries, newfd, offset_to_offset) < 0)
+		return -1;
+	if (write_conflicts_v5(istate, de, newfd) < 0)
+		return -1;
+	return ce_flush_v5(newfd);
+}
+
+struct index_ops v5_ops = {
+	match_stat_basic,
+	verify_hdr,
+	read_index_v5,
+	write_index_v5
+};
diff --git a/read-cache.c b/read-cache.c
index 215c91f..61e2ea8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -55,6 +55,31 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
+uint32_t calculate_stat_crc(struct cache_entry *ce)
+{
+	unsigned int ctimens = 0;
+	uint32_t stat, stat_crc;
+
+	stat = htonl(ce->ce_ctime.sec);
+	stat_crc = crc32(0, (Bytef*)&stat, 4);
+#ifdef USE_NSEC
+	ctimens = ce->ce_ctime.nsec;
+#endif
+	stat = htonl(ctimens);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_ino);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_size);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_dev);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_uid);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_gid);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	return stat_crc;
+}
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -77,6 +102,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 
 	if (S_ISREG(st->st_mode))
 		ce_mark_uptodate(ce);
+
+	ce->ce_stat_crc = calculate_stat_crc(ce);
 }
 
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
-- 
1.7.8
