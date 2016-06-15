From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 15/19] read-cache: write index-v5
Date: Fri, 12 Jul 2013 19:27:00 +0200
Message-ID: <1373650024-3001-16-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhDI-0006ZQ-0U
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172Ab3GLRcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:32:55 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:41571 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813Ab3GLRcy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:32:54 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so9189250pbc.18
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9Un4m3skg288Qvq8xeBAHZpTSZoOqWGaXwp7uv4FQM0=;
        b=Z+APoPjeodBF4czievTTeScsbPDlkU0O1p09KX6lM4oYCO1DQBrSZm1KieKT1feVNK
         HIWzffJTNkJHLzWZVRGWatvkKkebjGY9UpClCkCZSSMQcXK2CL480b0d5v1ju9lWB7oH
         FZkFzdeRBS/K9pQUKVx9H//43G+oJ6YymS+8udkcs3hDR0+39YP6OyUIJR+UcEMVIQHM
         uFEttzDBjUHC7lwM9bq4glncsnNcGTZOP8toL7ceAXjl7OJ3midscixKdSnl0Uyk06kH
         j+tOq3uq3r2Fr3WaO33pdQ63O45ilDfMSYYn/UUQ+PLOFxEklVAM3H4FhjYkQ3A7iv6X
         CEoQ==
X-Received: by 10.66.219.170 with SMTP id pp10mr36013586pac.119.1373650374297;
        Fri, 12 Jul 2013 10:32:54 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id qv4sm46427993pbc.16.2013.07.12.10.32.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:32:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230227>

Write the index version 5 file format to disk. This version doesn't
write the cache-tree data and resolve-undo data to the file.

The main work is done when filtering out the directories from the
current in-memory format, where in the same turn also the conflicts
and the file data is calculated.

Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h         |   8 +
 read-cache-v5.c | 594 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 read-cache.c    |  11 +-
 read-cache.h    |   1 +
 4 files changed, 611 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 1e5cc77..f3685f8 100644
--- a/cache.h
+++ b/cache.h
@@ -565,6 +565,7 @@ extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+extern struct directory_entry *init_directory_entry(char *pathname, int len);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
@@ -1363,6 +1364,13 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
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
diff --git a/read-cache-v5.c b/read-cache-v5.c
index 0b9c320..33667d7 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -769,9 +769,601 @@ static int read_index_v5(struct index_state *istate, void *mmap,
 	return 0;
 }
 
+#define WRITE_BUFFER_SIZE 8192
+static unsigned char write_buffer[WRITE_BUFFER_SIZE];
+static unsigned long write_buffer_len;
+
+static int ce_write_flush(int fd)
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
+static int ce_write(uint32_t *crc, int fd, void *data, unsigned int len)
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
+			if (ce_write_flush(fd))
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
+static int ce_flush(int fd)
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
+static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
+{
+	/*
+	 * This method shall only be called if the timestamp of ce
+	 * is racy (check with is_racy_timestamp). If the timestamp
+	 * is racy, the writer will set the CE_SMUDGED flag.
+	 *
+	 * The reader (match_stat_basic) will then take care
+	 * of checking if the entry is really changed or not, by
+	 * taking into account the size and the stat_crc and if
+	 * that hasn't changed checking the sha1.
+	 */
+	ce->ce_flags |= CE_SMUDGED;
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
+	int flags;
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
+				    struct ondisk_cache_entry *ondisk)
+{
+	unsigned int flags;
+
+	flags  = ce->ce_flags & CE_STAGEMASK;
+	flags |= ce->ce_flags & CE_VALID;
+	flags |= ce->ce_flags & CE_SMUDGED;
+	if (ce->ce_flags & CE_INTENT_TO_ADD)
+		flags |= CE_INTENT_TO_ADD_V5;
+	if (ce->ce_flags & CE_SKIP_WORKTREE)
+		flags |= CE_SKIP_WORKTREE_V5;
+	ondisk->flags      = htons(flags);
+	ondisk->mode       = htons(ce->ce_mode);
+	ondisk->mtime.sec  = htonl(ce->ce_stat_data.sd_mtime.sec);
+#ifdef USE_NSEC
+	ondisk->mtime.nsec = htonl(ce->ce_stat_data.sd_mtime.nsec);
+#else
+	ondisk->mtime.nsec = 0;
+#endif
+	ondisk->size       = htonl(ce->ce_stat_data.sd_size);
+	if (!ce->ce_stat_crc)
+		ce->ce_stat_crc = calculate_stat_crc(ce);
+	ondisk->stat_crc   = htonl(ce->ce_stat_crc);
+	hashcpy(ondisk->sha1, ce->sha1);
+}
+
+static int write_directories(struct directory_entry *de, int fd, int conflict_offset)
+{
+	struct directory_entry *current;
+	struct ondisk_directory_entry ondisk;
+	int current_offset, offset_write, ondisk_size, foffset;
+	uint32_t crc;
+
+	/*
+	 * This is needed because the compiler aligns structs to sizes multiple
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
+		if (ce_write(NULL, fd, &offset_write, 4) < 0)
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
+	if (ce_write(NULL, fd, &offset_write, 4) < 0)
+		return -1;
+	current = de;
+	while (current) {
+		crc = 0;
+		if (current->de_pathlen == 0) {
+			if (ce_write(&crc, fd, current->pathname, 1) < 0)
+				return -1;
+		} else {
+			char *path;
+			path = xmalloc(sizeof(char) * (current->de_pathlen + 2));
+			memcpy(path, current->pathname, current->de_pathlen);
+			memcpy(path + current->de_pathlen, "/\0", 2);
+			if (ce_write(&crc, fd, path, current->de_pathlen + 2) < 0)
+				return -1;
+		}
+		current->de_foffset = foffset;
+		current->de_cr = conflict_offset;
+		ondisk_from_directory_entry(current, &ondisk);
+		if (ce_write(&crc, fd, &ondisk, ondisk_size) < 0)
+			return -1;
+		crc = htonl(crc);
+		if (ce_write(NULL, fd, &crc, 4) < 0)
+			return -1;
+		conflict_offset += current->conflict_size;
+		foffset += current->de_nfiles * 4;
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_entries(struct index_state *istate,
+			    struct directory_entry *de,
+			    int entries,
+			    int fd,
+			    int offset_to_offset)
+{
+	int offset, offset_write, ondisk_size;
+	struct directory_entry *current;
+
+	offset = 0;
+	ondisk_size = sizeof(struct ondisk_cache_entry);
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
+				ce_smudge_racily_clean_entry(ce);
+			if (is_null_sha1(ce->sha1))
+				return error("cache entry has null sha1: %s", ce->name);
+
+			offset_write = htonl(offset);
+			if (ce_write(NULL, fd, &offset_write, 4) < 0)
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
+	if (ce_write(NULL, fd, &offset_write, 4) < 0)
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
+			struct ondisk_cache_entry ondisk;
+			uint32_t crc, calc_crc;
+
+			if (ce->ce_flags & CE_REMOVE)
+				continue;
+			calc_crc = htonl(offset);
+			crc = crc32(0, (Bytef*)&calc_crc, 4);
+			if (ce_write(&crc, fd, ce->name + pathlen,
+					ce_namelen(ce) - pathlen + 1) < 0)
+				return -1;
+			ondisk_from_cache_entry(ce, &ondisk);
+			if (ce_write(&crc, fd, &ondisk, ondisk_size) < 0)
+				return -1;
+			crc = htonl(crc);
+			if (ce_write(NULL, fd, &crc, 4) < 0)
+				return -1;
+			offset += 4;
+			ce = ce->next;
+		}
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_conflict(struct conflict_entry *conflict, int fd)
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
+		if (ce_write(&crc, fd,
+		     (Bytef*)(current->name + current->pathlen),
+		     current->namelen - current->pathlen) < 0)
+			return -1;
+		if (ce_write(&crc, fd, (Bytef*)"\0", 1) < 0)
+			return -1;
+		to_write = htonl(current->nfileconflicts);
+		if (ce_write(&crc, fd, (Bytef*)&to_write, 4) < 0)
+			return -1;
+		current_part = current->entries;
+		while (current_part) {
+			struct ondisk_conflict_part ondisk;
+
+			conflict_to_ondisk(current_part, &ondisk);
+			if (ce_write(&crc, fd, (Bytef*)&ondisk, sizeof(struct ondisk_conflict_part)) < 0)
+				return 0;
+			current_part = current_part->next;
+		}
+		to_write = htonl(crc);
+		if (ce_write(NULL, fd, (Bytef*)&to_write, 4) < 0)
+			return -1;
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_conflicts(struct index_state *istate,
+			      struct directory_entry *de,
+			      int fd)
+{
+	struct directory_entry *current;
+
+	current = de;
+	while (current) {
+		if (current->de_ncr != 0) {
+			if (write_conflict(current->conflict, fd) < 0)
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
+	struct cache_header hdr_v5;
+	struct cache_entry **cache = istate->cache;
+	struct directory_entry *de;
+	struct ondisk_directory_entry *ondisk;
+	int entries = istate->cache_nr;
+	int i, removed, non_conflicted, total_dir_len, ondisk_directory_size;
+	int total_file_len, conflict_offset, offset_to_offset;
+	unsigned int ndir;
+	uint32_t crc;
+
+	if (istate->filter_opts)
+		die("BUG: index: cannot write a partially read index");
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
+	if (ce_write(&crc, newfd, &hdr, sizeof(hdr)) < 0)
+		return -1;
+	if (ce_write(&crc, newfd, &hdr_v5, sizeof(hdr_v5)) < 0)
+		return -1;
+	crc = htonl(crc);
+	if (ce_write(NULL, newfd, &crc, 4) < 0)
+		return -1;
+
+	conflict_offset = sizeof(hdr) + sizeof(hdr_v5) + 4
+		+ (ndir + 1) * 4
+		+ total_dir_len
+		+ ndir * (ondisk_directory_size + 4)
+		+ (non_conflicted + 1) * 4
+		+ total_file_len
+		+ non_conflicted * (sizeof(struct ondisk_cache_entry) + 4);
+	if (write_directories(de, newfd, conflict_offset) < 0)
+		return -1;
+	offset_to_offset = sizeof(hdr) + sizeof(hdr_v5) + 4
+		+ (ndir + 1) * 4
+		+ total_dir_len
+		+ ndir * (ondisk_directory_size + 4);
+	if (write_entries(istate, de, entries, newfd, offset_to_offset) < 0)
+		return -1;
+	if (write_conflicts(istate, de, newfd) < 0)
+		return -1;
+	return ce_flush(newfd);
+}
+
 struct index_ops v5_ops = {
 	match_stat_basic,
 	verify_hdr,
 	read_index_v5,
-	NULL
+	write_index_v5
 };
diff --git a/read-cache.c b/read-cache.c
index 9bfbb4f..2fcca7f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -108,7 +108,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	return changed;
 }
 
-static uint32_t calculate_stat_crc(struct cache_entry *ce)
+uint32_t calculate_stat_crc(struct cache_entry *ce)
 {
 	unsigned int ctimens = 0;
 	uint32_t stat, stat_crc;
@@ -232,6 +232,8 @@ static void set_istate_ops(struct index_state *istate)
 
 	if (istate->version >= 2 && istate->version <= 4)
 		istate->ops = &v2_ops;
+	if (istate->version == 5)
+		istate->ops = &v5_ops;
 }
 
 int ce_match_stat_basic(struct index_state *istate,
@@ -1300,7 +1302,12 @@ static int verify_hdr_version(struct index_state *istate,
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
-	istate->ops = &v2_ops;
+
+	if (hdr_version >= 2 && hdr_version <= 4)
+		istate->ops = &v2_ops;
+	else if (hdr_version == 5)
+		istate->ops = &v5_ops;
+
 	return 0;
 }
 
diff --git a/read-cache.h b/read-cache.h
index 869c562..0cb3b8b 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -62,3 +62,4 @@ extern int ce_match_stat_basic(struct index_state *istate, const struct cache_en
 			       struct stat *st);
 extern int is_racy_timestamp(const struct index_state *istate, const struct cache_entry *ce);
 extern void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce);
+extern uint32_t calculate_stat_crc(struct cache_entry *ce);
-- 
1.8.3.453.g1dfc63d
