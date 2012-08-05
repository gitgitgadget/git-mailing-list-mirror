From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 12/16] Write index-v5
Date: Sun,  5 Aug 2012 23:49:09 +0200
Message-ID: <1344203353-2819-13-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8jE-00025m-1z
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab2HEVut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48892 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab2HEVuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:50:07 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so648690eaa.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VeG9U59rDyhbTuthaxo5UOXFQZfZkiKniLv6d3h14cQ=;
        b=o30P8pROGy0g+H8fcXcVGnrejzoN4B6mzaiG+zZp5Zv1itHfgsHzBwmu+gfXx32fsv
         kketxo+8rBbUerGloNlHIMcvTD4DfaNUwdvUZV9sCkG7fr9byNtJymHIQOC2CwcNejF8
         6cPTKIIDPiy9V7YZn9FsZEqwHUr5vfw/t2fZ8MfKEGkkjYQJvDDjNrGm3VIkvr/1a0rk
         v5CpFp2CKp0CJ3osWqj6f6SPGkjo4xpnXi8gLLUbFiuc/i3m+Kjuxt2ff4QtHQshvVgb
         r/HtXM0P8QcwbZuISfcAXnHHM16tMgj/Bti723ETWpi3WeNOJ3/ewZfVaMYD6X1VvYrd
         7U1g==
Received: by 10.14.206.200 with SMTP id l48mr10252951eeo.41.1344203406425;
        Sun, 05 Aug 2012 14:50:06 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id g46sm42049354eep.15.2012.08.05.14.50.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:50:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202931>

Write the index version 5 file format to disk. This version doesn't
write the cache-tree data and resolve-undo data to the file.

The main work is done when filtering out the directories from the
current in-memory format, where in the same turn also the conflicts
and the file data is calculated.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |   10 +-
 read-cache.c |  587 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 595 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 98adcd9..f953db4 100644
--- a/cache.h
+++ b/cache.h
@@ -98,7 +98,7 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
 
 #define INDEX_FORMAT_LB 2
-#define INDEX_FORMAT_UB 4
+#define INDEX_FORMAT_UB 5
 
 /*
  * The "cache_time" is just the low 32 bits of the
@@ -509,6 +509,7 @@ extern int verify_path(const char *path);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_stage_pos(const struct index_state *, const char *name, int namelen, int stage);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+extern struct directory_entry *init_directory_entry(char *pathname, int len);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
@@ -1243,6 +1244,13 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 	return write_in_full(fd, str, strlen(str));
 }
 
+/* index-v5 helper functions */
+extern char *super_directory(const char *filename);
+extern void insert_directory_entry(struct directory_entry *, struct hash_table *, int *, unsigned int *, uint32_t);
+extern void add_conflict_to_directory_entry(struct directory_entry *, struct conflict_entry *);
+extern void add_part_to_conflict_entry(struct directory_entry *, struct conflict_entry *, struct conflict_part *);
+extern struct conflict_entry *create_new_conflict(char *, int, int);
+
 /* pager.c */
 extern void setup_pager(void);
 extern const char *pager_program;
diff --git a/read-cache.c b/read-cache.c
index 21ae804..2c47a97 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2204,6 +2204,17 @@ static int ce_write_flush(git_SHA_CTX *context, int fd)
 	return 0;
 }
 
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
 static int ce_write_v2(git_SHA_CTX *context, int fd, void *data, unsigned int len)
 {
 	while (len) {
@@ -2226,6 +2237,30 @@ static int ce_write_v2(git_SHA_CTX *context, int fd, void *data, unsigned int le
 	return 0;
 }
 
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
 static int write_index_ext_header_v2(git_SHA_CTX *context, int fd,
 				  unsigned int ext, unsigned int sz)
 {
@@ -2257,6 +2292,19 @@ static int ce_flush(git_SHA_CTX *context, int fd)
 	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
 }
 
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
 static void ce_smudge_racily_clean_entry_v2(struct cache_entry *ce)
 {
 	/*
@@ -2306,6 +2354,22 @@ static void ce_smudge_racily_clean_entry_v2(struct cache_entry *ce)
 	}
 }
 
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
 /* Copy miscellaneous fields but not the name */
 static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 				       struct cache_entry *ce)
@@ -2489,12 +2553,533 @@ static int write_index_v2(struct index_state *istate, int newfd)
 	return 0;
 }
 
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
 int write_index(struct index_state *istate, int newfd)
 {
 	if (!istate->version)
 		istate->version = INDEX_FORMAT_DEFAULT;
 
-	return write_index_v2(istate, newfd);
+	if (istate->version != 5)
+		return write_index_v2(istate, newfd);
+	else
+		return write_index_v5(istate, newfd);
 }
 
 /*
-- 
1.7.10.GIT
