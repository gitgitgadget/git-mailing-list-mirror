From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 18/24] read-cache: write index-v5
Date: Sun, 18 Aug 2013 21:42:07 +0200
Message-ID: <1376854933-31241-19-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yR-0004HB-TG
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab3HRTtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:06 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44681 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974Ab3HRTtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:05 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi8so2350209wib.3
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ENdISmKsnsoOy+y0XKMutwRkEuAxcbvCR/OFVKngiuU=;
        b=xKgMojs+q4jLtcg/ovwD6D1KGGjRoJ81Y+45IFIWQ1MZVd7l+ddS9teFH4WZlyipek
         8hD0nrHwIsIuKBAfQA9fN3P/o+vD0l8PcBS3GKnOhSTaoflX2dM9gTJJcyjugWntuO+L
         TRzRFUaOI1UbttzbQpggF0eveITwY2FHkmnULyyi8PegHqENWNpuL/amrIML1zwjuOrE
         BVbChGEW1VNyd16SBzweplaQPIbu93Brg2GMN46cEMU/dyhHmC+zUZrjaJsUVO0VdbFQ
         AZZVPNCly0grhQl3xNTacJLYl2n9z7lfX8GVErTXAY1oTgB1tiPElM6L2dkY10RDZzyZ
         f3RA==
X-Received: by 10.180.12.243 with SMTP id b19mr5452565wic.18.1376855343714;
        Sun, 18 Aug 2013 12:49:03 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id a8sm11925759wie.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:49:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232506>

Write the index version 5 file format to disk. This version doesn't
write the cache-tree data and resolve-undo data to the file.

The main work is done when filtering out the directories from the
current in-memory format, where in the same turn also the conflicts
and the file data is calculated.

Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h         |   2 +
 read-cache-v5.c | 596 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 read-cache.c    |   4 +-
 read-cache.h    |   1 +
 4 files changed, 601 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 89f556b..a109f35 100644
--- a/cache.h
+++ b/cache.h
@@ -138,6 +138,7 @@ struct cache_entry {
 	unsigned char sha1[20];
 	uint32_t ce_stat_crc;
 	struct cache_entry *next; /* used by name_hash */
+	struct cache_entry *next_ce;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -532,6 +533,7 @@ extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+extern struct directory_entry *init_directory_entry(char *pathname, int len);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
diff --git a/read-cache-v5.c b/read-cache-v5.c
index b14505a..85b912b 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -673,9 +673,603 @@ static int read_index_v5(struct index_state *istate, void *mmap,
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
+			unsigned int *total_dir_len,
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
+static struct directory_entry *find_directory(char *dir, int dir_len, uint32_t *crc,
+					      struct hash_table *table)
+{
+	struct directory_entry *search;
+
+	*crc = crc32(0, (Bytef*)dir, dir_len);
+	search = lookup_hash(*crc, table);
+	while (search && search->next_hash &&
+	       cache_name_compare(dir, dir_len, search->pathname, search->de_pathlen))
+		search = search->next_hash;
+	return search;
+}
+
+static struct directory_entry *get_directory(char *dir, unsigned int dir_len,
+					     struct hash_table *table,
+					     unsigned int *total_dir_len,
+					     unsigned int *ndir,
+					     struct directory_entry **current)
+{
+	struct directory_entry *tmp = NULL, *search, *new, *ret;
+	uint32_t crc;
+
+	search = find_directory(dir, dir_len, &crc, table);
+	if (search)
+		return search;
+	while (!search) {
+		new = init_directory_entry(dir, dir_len);
+		insert_directory_entry(new, table, total_dir_len, ndir, crc);
+		if (!tmp)
+			ret = new;
+		else
+			new->de_nsubtrees = 1;
+		new->next = tmp;
+		tmp = new;
+		dir = super_directory(dir);
+		dir_len = dir ? strlen(dir) : 0;
+		search = find_directory(dir, dir_len, &crc, table);
+	}
+	search->de_nsubtrees++;
+	(*current)->next = tmp;
+	while ((*current)->next)
+		*current = (*current)->next;
+
+	return ret;
+}
+
+static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *ce,
+								int pathlen)
+{
+	return create_new_conflict(ce->name, ce_namelen(ce), pathlen);
+}
+
+static void ce_queue_push(struct cache_entry **head,
+			  struct cache_entry **tail,
+			  struct cache_entry *ce)
+{
+	if (!*head) {
+		*head = *tail = ce;
+		(*tail)->next_ce = NULL;
+		return;
+	}
+
+	(*tail)->next_ce = ce;
+	ce->next_ce = NULL;
+	*tail = (*tail)->next_ce;
+}
+
+static struct directory_entry *compile_directory_data(struct index_state *istate,
+						      int nfile,
+						      unsigned int *ndir,
+						      unsigned int *total_dir_len,
+						      unsigned int *total_file_len)
+{
+	int i, dir_len = -1;
+	char *dir;
+	struct directory_entry *de, *current, *search;
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
+		if (cache[i]->ce_flags & CE_REMOVE)
+			continue;
+
+		if (dir_len < 0
+		    || cache[i]->name[dir_len] != '/'
+		    || strchr(cache[i]->name + dir_len + 1, '/')
+		    || cache_name_compare(cache[i]->name, ce_namelen(cache[i]),
+					  dir, dir_len)) {
+			dir = super_directory(cache[i]->name);
+			dir_len = dir ? strlen(dir) : 0;
+			search = get_directory(dir, dir_len, &table,
+					       total_dir_len, ndir,
+					       &current);
+		}
+		search->de_nfiles++;
+		*total_file_len += ce_namelen(cache[i]) + 1;
+		if (search->de_pathlen)
+			*total_file_len -= search->de_pathlen + 1;
+		ce_queue_push(&(search->ce), &(search->ce_last), cache[i]);
+
+		if (ce_stage(cache[i]) > 0) {
+			struct conflict_part *conflict_part;
+			if (!conflict_entry ||
+			    cache_name_compare(conflict_entry->name, conflict_entry->namelen,
+					       cache[i]->name, ce_namelen(cache[i]))) {
+				conflict_entry = create_conflict_entry_from_ce(cache[i], search->de_pathlen);
+				add_conflict_to_directory_entry(search, conflict_entry);
+			}
+			conflict_part = conflict_part_from_inmemory(cache[i]);
+			add_part_to_conflict_entry(search, conflict_entry, conflict_part);
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
+			ce = ce->next_ce;
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
+			ce = ce->next_ce;
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
+	struct cache_header hdr;
+	struct cache_header_v5 hdr_v5;
+	struct cache_entry **cache = istate->cache;
+	struct directory_entry *de;
+	struct ondisk_directory_entry *ondisk;
+	unsigned int entries = istate->cache_nr;
+	unsigned int i, removed, total_dir_len, ondisk_directory_size;
+	unsigned int total_file_len, conflict_offset, foffsetblock;
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
+	hdr.hdr_entries = htonl(entries - removed);
+	hdr_v5.hdr_nextension = htonl(0); /* Currently no extensions are supported */
+
+	total_dir_len = 0;
+	total_file_len = 0;
+	de = compile_directory_data(istate, entries, &ndir,
+				    &total_dir_len, &total_file_len);
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
+	foffsetblock = sizeof(hdr) + sizeof(hdr_v5) + 4
+		+ (ndir + 1) * 4
+		+ total_dir_len
+		+ ndir * (ondisk_directory_size + 4);
+	hdr_v5.hdr_fblockoffset = htonl(foffsetblock + (entries - removed + 1) * 4);
+	crc = 0;
+	if (ce_write(&crc, newfd, &hdr, sizeof(hdr)) < 0)
+		return -1;
+	if (ce_write(&crc, newfd, &hdr_v5, sizeof(hdr_v5)) < 0)
+		return -1;
+	crc = htonl(crc);
+	if (ce_write(NULL, newfd, &crc, 4) < 0)
+		return -1;
+
+	conflict_offset = foffsetblock +
+		+ (entries - removed + 1) * 4
+		+ total_file_len
+		+ (entries - removed) * (sizeof(struct ondisk_cache_entry) + 4);
+	if (write_directories(de, newfd, conflict_offset) < 0)
+		return -1;
+	if (write_entries(istate, de, entries, newfd, foffsetblock) < 0)
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
index a232372..1d9b615 100644
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
@@ -229,6 +229,8 @@ static void set_istate_ops(struct index_state *istate)
 {
 	if (istate->version >= 2 && istate->version <= 4)
 		istate->ops = &v2_ops;
+	if (istate->version == 5)
+		istate->ops = &v5_ops;
 }
 
 int ce_match_stat_basic(const struct index_state *istate,
diff --git a/read-cache.h b/read-cache.h
index 01c76de..27f862f 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -58,3 +58,4 @@ extern int ce_match_stat_basic(const struct index_state *istate,
 			       const struct cache_entry *ce, struct stat *st);
 extern int is_racy_timestamp(const struct index_state *istate, const struct cache_entry *ce);
 extern void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce);
+extern uint32_t calculate_stat_crc(struct cache_entry *ce);
-- 
1.8.3.4.1231.g9fbf354.dirty
