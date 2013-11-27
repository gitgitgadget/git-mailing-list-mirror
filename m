From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 15/24] read-cache: write index-v5
Date: Wed, 27 Nov 2013 13:00:50 +0100
Message-ID: <1385553659-9928-16-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vldux-00059V-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab3K0MI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:08:27 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:46824 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3K0MI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:08:26 -0500
Received: by mail-lb0-f175.google.com with SMTP id x18so5358773lbi.34
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b391jDp0Vv6Egg9xlBVvxH4wHkj9+BNuk8zgN6kHEiY=;
        b=XMt7qn5lDqtO2P5LuWKsi25cUTB+t2dCDDr1MJRlZg0+Qwd8S+8m3jlVV+BIg4kj5f
         7GXcY5c8kwfvUWDE8Gjf8GduivuXAz8awIk0S+gFNful6VvtQnhTvBnLMWbHw5zYv5R7
         bQshnrLJTkfEreTiTWtgi8AEJZBycbrn9xYDKzkC4fg7wRkk/4sxT8inRKTQA2fLhaUF
         QkkL09LmPQnf6J3L0Oe9DFm8KzTCAmuimrq420CYR5fxaEchIYgoR26ql6CBsmY+nf5O
         L0aDjYIaXtsgtr9gSVlnghO6+AG3cEQotFSXmnuxURf08EqsDt231aFE1WYEDUYc5uu0
         SonA==
X-Received: by 10.152.203.168 with SMTP id kr8mr15492lac.44.1385553737120;
        Wed, 27 Nov 2013 04:02:17 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id l10sm45488369lbh.13.2013.11.27.04.02.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:16 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238438>

Write the index version 5 file format to disk. This version doesn't
write the cache-tree data and resolve-undo data to the file.

The main work is done when filtering out the directories from the
current in-memory format, where in the same turn also the conflicts
and the file data is calculated.

Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h         |   1 +
 read-cache-v5.c | 431 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 read-cache.c    |   4 +-
 read-cache.h    |   1 +
 4 files changed, 435 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 65171e4..71b98cf 100644
--- a/cache.h
+++ b/cache.h
@@ -138,6 +138,7 @@ struct cache_entry {
 	unsigned char sha1[20];
 	uint32_t ce_stat_crc;
 	struct cache_entry *next; /* used by name_hash */
+	struct cache_entry *next_ce;
 	char name[FLEX_ARRAY]; /* more */
 };
 
diff --git a/read-cache-v5.c b/read-cache-v5.c
index 01f1c88..797022f 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -631,9 +631,438 @@ static int read_index_v5(struct index_state *istate, void *mmap,
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
+static char *super_directory(char *filename)
+{
+	char *super = dirname(filename);
+	if (!strcmp(super, "."))
+		return NULL;
+	return super;
+}
+
+static void ondisk_from_directory_entry(struct directory_entry *de,
+					struct ondisk_directory_entry *ondisk)
+{
+	ondisk->foffset   = htonl(de->de_foffset);
+	ondisk->nsubtrees = htonl(de->de_nsubtrees);
+	ondisk->nfiles    = htonl(de->de_nfiles);
+	ondisk->nentries  = htonl(de->de_nentries);
+	hashcpy(ondisk->sha1, de->sha1);
+	ondisk->flags     = htons(de->de_flags);
+	if (de->de_pathlen == 0) {
+		memcpy(ondisk->name, "\0", 1);
+	} else {
+		memcpy(ondisk->name, de->pathname, de->de_pathlen);
+		memcpy(ondisk->name + de->de_pathlen, "/\0", 2);
+	}
+}
+
+static void insert_directory_entry(struct directory_entry *de,
+				   struct hash_table *table,
+				   unsigned int *total_dir_len,
+				   unsigned int *ndir,
+				   uint32_t crc)
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
+	while (search &&
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
+						      int nfile, unsigned int *ndir,
+						      unsigned int *total_dir_len,
+						      unsigned int *total_file_len)
+{
+	int i, dir_len = -1;
+	char *dir;
+	struct directory_entry *de, *current, *search;
+	struct cache_entry **cache = istate->cache;
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
+	for (i = 0; i < nfile; i++) {
+		if (cache[i]->ce_flags & CE_REMOVE)
+			continue;
+
+		if (dir_len < 0
+		    || !(!(dir_len < ce_namelen(cache[i]) && cache[i]->name[dir_len] != '/')
+			 && !strchr(cache[i]->name + dir_len + 1, '/')
+			 && !cache_name_compare(cache[i]->name, ce_namelen(cache[i]),
+						dir, dir_len))) {
+			dir = super_directory(strdup(cache[i]->name));
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
+	}
+	return de;
+}
+
+static void ondisk_from_cache_entry(struct cache_entry *ce,
+				    struct ondisk_cache_entry *ondisk,
+				    int pathlen)
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
+	memcpy(ondisk->name, ce->name + pathlen, ce_namelen(ce) - pathlen);
+	ondisk->name[ce_namelen(ce) - pathlen] = '\0';
+}
+
+static int write_directories(struct directory_entry *de, int fd)
+{
+	struct directory_entry *current;
+	struct ondisk_directory_entry *ondisk;
+	int current_offset, offset_write, ondisk_size, foffset;
+	uint32_t crc;
+
+	ondisk_size = offsetof(struct ondisk_directory_entry, name);
+	current = de;
+	current_offset = 0;
+	foffset = 0;
+	/* Write directory offsets */
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
+	/* Write directory entries */
+	while (current) {
+		int size = ondisk_size + current->de_pathlen + 1;
+
+		crc = 0;
+		current->de_foffset = foffset;
+		if (current->de_pathlen != 0)
+			size++;
+		ondisk = xmalloc(size);
+		ondisk_from_directory_entry(current, ondisk);
+		if (ce_write(&crc, fd, ondisk, size) < 0)
+			return -1;
+		crc = htonl(crc);
+		if (ce_write(NULL, fd, &crc, 4) < 0)
+			return -1;
+		foffset += current->de_nfiles * 4;
+		free(ondisk);
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_entries(struct index_state *istate,
+			 struct directory_entry *de,
+			 int entries,
+			 int fd)
+{
+	int offset, offset_write, ondisk_size;
+	struct directory_entry *current;
+
+	offset = 0;
+	ondisk_size = offsetof(struct ondisk_cache_entry, name);
+	current = de;
+	/* Write cache entry offsets */
+	while (current) {
+		int pathlen;
+		struct cache_entry *ce = current->ce;
+
+		pathlen = current->de_pathlen ? current->de_pathlen + 1 : 0;
+		while (ce) {
+			if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
+				ce_smudge_racily_clean_entry(ce);
+			if (is_null_sha1(ce->sha1)) {
+				static const char msg[] = "cache entry has null sha1: %s";
+				static int allow = -1;
+
+				if (allow < 0)
+					allow = git_env_bool("GIT_ALLOW_NULL_SHA1", 0);
+				if (allow)
+					warning(msg, ce->name);
+				else
+					return error(msg, ce->name);
+			}
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
+	current = de;
+	/* Write cache entries */
+	while (current) {
+		int pathlen;
+		struct cache_entry *ce = current->ce;
+
+		pathlen = current->de_pathlen ? current->de_pathlen + 1 : 0;
+		while (ce) {
+			int size = offsetof(struct ondisk_cache_entry, name) +
+				ce_namelen(ce) - pathlen + 1;
+			struct ondisk_cache_entry *ondisk = xmalloc(size);
+			uint32_t crc;
+
+			crc = 0;
+			ondisk_from_cache_entry(ce, ondisk, pathlen);
+			if (ce_write(&crc, fd, ondisk, size) < 0)
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
+static int write_index_v5(struct index_state *istate, int newfd)
+{
+	struct cache_header hdr;
+	struct cache_header_v5 hdr_v5;
+	struct cache_entry **cache = istate->cache;
+	struct directory_entry *de;
+	unsigned int entries = istate->cache_nr;
+	unsigned int i, removed, total_dir_len;
+	unsigned int total_file_len, foffsetblock;
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
+	foffsetblock = sizeof(hdr) + sizeof(hdr_v5) + 4
+		+ (ndir + 1) * 4
+		+ total_dir_len
+		+ ndir * (offsetof(struct ondisk_directory_entry, name) + 4);
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
+	if (write_directories(de, newfd) < 0)
+		return -1;
+	if (write_entries(istate, de, entries, newfd) < 0)
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
index baa052c..46551af 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -106,7 +106,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	return changed;
 }
 
-static uint32_t calculate_stat_crc(struct cache_entry *ce)
+uint32_t calculate_stat_crc(struct cache_entry *ce)
 {
 	unsigned int ctimens = 0;
 	uint32_t stat, stat_crc;
@@ -227,6 +227,8 @@ static void set_istate_ops(struct index_state *istate)
 {
 	if (istate->version >= 2 && istate->version <= 4)
 		istate->ops = &v2_ops;
+	if (istate->version == 5)
+		istate->ops = &v5_ops;
 }
 
 int ce_match_stat_basic(const struct index_state *istate,
diff --git a/read-cache.h b/read-cache.h
index 7823fbb..9d66df6 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -61,5 +61,6 @@ extern int ce_match_stat_basic(const struct index_state *istate,
 			       const struct cache_entry *ce, struct stat *st);
 extern int is_racy_timestamp(const struct index_state *istate, const struct cache_entry *ce);
 extern void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce);
+extern uint32_t calculate_stat_crc(struct cache_entry *ce);
 
 #endif
-- 
1.8.4.2
