From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 09/16] Read index-v5
Date: Thu,  2 Aug 2012 13:01:59 +0200
Message-ID: <1343905326-23790-10-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtCF-0005eb-Df
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab2HBLDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:41 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64744 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab2HBLDG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:03:06 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so838708eaa.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KyItSUoFFapFPFiAyWfg7h60qCH3YNh3pdpBpHPtZyw=;
        b=L24mqVscUSVUY0WYlxEwri4kGpsxdyvCBSSacl5uThizn/gUQqu0+YFJh71xVWGs0t
         vEijv9N0txuToX5Jutp9mTDb1EGEA6N1lJ6DbwLy+Qy2VJGyKEJ94VsSU+YNf9JQi3ri
         HhnjjVStxs7zxLYaCe6/timikelFZsRm+EEwOXWr0KEV7jyqkTNznqVuLBxtm5xoUqZC
         s2HI46YtL6b5CgY4t8rufLV4ly4rS+62CdlE2IrSK6UpOgoZRc+pP3vBQzcP0oyukiSP
         5we64qrcEP7M79GMtabtAdOTfBJgCWp6Z3QftG5zdNR0eu7Mx078U5taTGaAxmWjfFQW
         QoDA==
Received: by 10.14.202.69 with SMTP id c45mr26514561eeo.4.1343905385292;
        Thu, 02 Aug 2012 04:03:05 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id c7sm16423239eem.9.2012.08.02.04.03.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:03:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202766>

Make git read the index file version 5 without complaining.

This version of the reader doesn't read neither the cache-tree
nor the resolve undo data, but doesn't choke on an index that
includes such data.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  79 +++++++++
 read-cache.c | 570 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 644 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 7247944..91d9b45 100644
--- a/cache.h
+++ b/cache.h
@@ -108,6 +108,13 @@ struct cache_header_v2 {
 	unsigned int hdr_entries;
 };
 
+struct cache_header_v5 {
+	unsigned int hdr_ndir;
+	unsigned int hdr_nfile;
+	unsigned int hdr_fblockoffset;
+	unsigned int hdr_nextension;
+};
+
 #define INDEX_FORMAT_LB 2
 #define INDEX_FORMAT_UB 4
 
@@ -121,6 +128,15 @@ struct cache_time {
 	unsigned int nsec;
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
 	struct cache_time ce_ctime;
 	struct cache_time ce_mtime;
@@ -139,12 +155,58 @@ struct cache_entry {
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
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_EXTENDED  (0x4000)
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
+#define CONFLICT_CONFLICTED (0x8000)
+#define CONFLICT_STAGESHIFT 13
+#define CONFLICT_STAGEMASK (0x6000)
+
 /*
  * Range 0xFFFF0000 in ce_flags is divided into
  * two parts: in-memory flags and on-disk ones.
@@ -178,6 +240,18 @@ struct cache_entry {
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
@@ -215,6 +289,8 @@ static inline unsigned create_ce_flags(unsigned stage)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
 
+#define conflict_stage(c) ((CONFLICT_STAGEMASK & (c)->flags) >> CONFLICT_STAGESHIFT)
+
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
 {
@@ -261,6 +337,8 @@ static inline unsigned int canon_mode(unsigned int mode)
 }
 
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
+#define directory_entry_size(len) (offsetof(struct directory_entry,pathname) + (len) + 1)
+#define conflict_entry_size(len) (offsetof(struct conflict_entry,name) + (len) + 1)
 
 struct index_state {
 	struct cache_entry **cache;
@@ -437,6 +515,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const char **pathspec);
 extern void read_index_v2(struct index_state *, void *mmap, int);
+extern void read_index_v5(struct index_state *, void *mmap, int, int);
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
diff --git a/read-cache.c b/read-cache.c
index dfe5ee2..884c2a7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -234,6 +234,55 @@ static int ce_match_stat_basic_v2(struct cache_entry *ce,
 	return changed;
 }
 
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
+static int ce_match_stat_basic_v5(struct cache_entry *ce,
+				struct stat *st,
+				int changed)
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
 static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
@@ -267,7 +316,10 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
 
-	changed = ce_match_stat_basic_v2(ce, st, changed);
+	if (the_index.version != 5)
+		changed = ce_match_stat_basic_v2(ce, st, changed);
+	else
+		changed = ce_match_stat_basic_v5(ce, st, changed);
 	return changed;
 }
 
@@ -1275,6 +1327,25 @@ struct ondisk_cache_entry_extended {
 	char name[FLEX_ARRAY]; /* more */
 };
 
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
 /* These are only used for v3 or lower */
 #define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
 #define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
@@ -1283,6 +1354,17 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
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
 static int verify_hdr_version(struct cache_version_header *hdr, unsigned long size)
 {
 	int hdr_version;
@@ -1290,7 +1372,7 @@ static int verify_hdr_version(struct cache_version_header *hdr, unsigned long si
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version = ntohl(hdr->hdr_version);
-	if (hdr_version < 2 || 4 < hdr_version)
+	if (hdr_version < 2 || 5 < hdr_version)
 		return error("bad index version %d", hdr_version);
 	return 0;
 }
@@ -1308,6 +1390,24 @@ static int verify_hdr_v2(struct cache_version_header *hdr, unsigned long size)
 	return 0;
 }
 
+static int verify_hdr_v5(void *mmap)
+{
+	uint32_t *filecrc;
+	unsigned int header_size_v5;
+	struct cache_version_header *hdr;
+	struct cache_header_v5 *hdr_v5;
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
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1372,12 +1472,105 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	ce->ce_size       = ntoh_l(ondisk->size);
 	ce->ce_flags      = flags & ~CE_NAMEMASK;
 	ce->ce_namelen    = len;
+	ce->ce_stat_crc   = 0;
 	hashcpy(ce->sha1, ondisk->sha1);
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
 	return ce;
 }
 
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
 /*
  * Adjacent cache entries tend to share the leading paths, so it makes
  * sense to only store the differences in later entries.  In the v4
@@ -1445,6 +1638,332 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
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
+static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *ce,
+								int pathlen)
+{
+	return create_new_conflict(ce->name, ce_namelen(ce), pathlen);
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
 void read_index_v2(struct index_state *istate, void *mmap, int mmap_size)
 {
 	int i;
@@ -1503,6 +2022,39 @@ unmap:
 	die("index file corrupt");
 }
 
+void read_index_v5(struct index_state *istate, void *mmap, int mmap_size, int fd)
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
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1542,10 +2094,18 @@ int read_index_from(struct index_state *istate, const char *path)
 	if (verify_hdr_version(hdr, mmap_size) < 0)
 		goto unmap;
 
-	if (verify_hdr_v2(hdr, mmap_size) < 0)
-		goto unmap;
+	if (htonl(hdr->hdr_version) != 5) {
+		if (verify_hdr_v2(hdr, mmap_size) < 0)
+			goto unmap;
 
-	read_index_v2(istate, mmap, mmap_size);
+		read_index_v2(istate, mmap, mmap_size);
+	} else {
+		if (verify_hdr_v5(hdr) < 0)
+			goto unmap;
+
+		read_index_v5(istate, mmap, mmap_size, fd);
+	}
+	close(fd);
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
-- 
1.7.10.886.gdf6792c.dirty
