From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 17/24] read-cache: write resolve-undo data for index-v5
Date: Wed, 27 Nov 2013 13:00:52 +0100
Message-ID: <1385553659-9928-18-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldpA-00029c-4l
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab3K0MC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:27 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:55397 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab3K0MCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:24 -0500
Received: by mail-la0-f41.google.com with SMTP id eo20so5177768lab.14
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J53VFFQ8lO62kb5Gx4rxSCPuLg+UG2zu9SFWgVpbMz4=;
        b=cTuujR8vx08EcUrW1SDnw0axnAiEZ03p2TxEEozFcfojQ5lpsVFsBJ2kxcs7SsCpsW
         7uQXZCERMGLulFXMm7W047CgmFZ0KDcLLvM0YRCPTsYNYq53d7EanmdPDt+qr0gULkRK
         PI/+uL0qTRoG+kfOybXbWtsxI/Hdc1aaS84p03cgIPkSZiYIamufnPstiWx1SlP0xTX1
         74H62blFkmYV5u9LrmyECqC2Zv3R7eA+SI93LSM1mN4RMP0C0BQD/OQHYA83BBe5QeMe
         6b4T3+U937XS+xhbBGMDR8u0Lt15g/vcQm8/SjWvqz5beEiruNmJHRv9rQmSZu2fA7yx
         upbg==
X-Received: by 10.152.180.228 with SMTP id dr4mr1389015lac.32.1385553743494;
        Wed, 27 Nov 2013 04:02:23 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id a8sm13615287lae.5.2013.11.27.04.02.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:22 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238430>

Make git read the resolve-undo data from the index.

Since the resolve-undo data is joined with the conflicts in the ondisk
format of the index file version 5, conflicts and resolved data is read
at the same time, and the resolve-undo data is then converted to the
in-memory format.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache-v5.c | 199 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 191 insertions(+), 8 deletions(-)

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 0d06cfe..a5e9b5a 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -723,6 +723,29 @@ static void ondisk_from_directory_entry(struct directory_entry *de,
 	}
 }
 
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
+			       struct ondisk_conflict_part *ondisk)
+{
+	ondisk->flags      = htons(cp->flags);
+	ondisk->entry_mode = htons(cp->entry_mode);
+	hashcpy(ondisk->sha1, cp->sha1);
+}
+
 static void insert_directory_entry(struct directory_entry *de,
 				   struct hash_table *table,
 				   unsigned int *total_dir_len,
@@ -789,6 +812,11 @@ static struct directory_entry *get_directory(char *dir, unsigned int dir_len,
 	return ret;
 }
 
+static struct conflict_entry *create_conflict_entry_from_ce(struct cache_entry *ce)
+{
+	return create_new_conflict(ce->name, ce_namelen(ce));
+}
+
 static void convert_one_to_ondisk(struct hash_table *table, struct cache_tree *it,
 				  const char *path, int pathlen, uint32_t crc)
 {
@@ -840,6 +868,52 @@ static void cache_tree_to_ondisk(struct hash_table *table, struct cache_tree *ro
 	convert_one_to_ondisk(table, root, "", 0, 0);
 }
 
+static void resolve_undo_to_ondisk(struct string_list *resolve_undo,
+				   struct conflict_entry **conflict_queue)
+{
+	struct string_list_item *item;
+	struct conflict_entry *current = *conflict_queue;
+
+	if (!resolve_undo)
+		return;
+	for_each_string_list_item(item, resolve_undo) {
+		struct conflict_entry *conflict_entry;
+		struct resolve_undo_info *ui = item->util;
+		int i, len;
+
+		if (!ui)
+			continue;
+
+		len = strlen(item->string);
+		while (current && current->next &&
+		       cache_name_compare(current->name, current->namelen,
+					  item->string, len))
+			current = current->next;
+
+		conflict_entry = create_new_conflict(item->string, len);
+		for (i = 0; i < 3; i++) {
+			if (ui->mode[i]) {
+				struct conflict_part *cp;
+
+				cp = xmalloc(sizeof(struct conflict_part));
+				cp->flags = (i + 1) << CONFLICT_STAGESHIFT;
+				cp->entry_mode = ui->mode[i];
+				cp->next = NULL;
+				hashcpy(cp->sha1, ui->sha1[i]);
+				add_part_to_conflict_entry(conflict_entry, cp);
+			}
+		}
+		if (!*conflict_queue) {
+			*conflict_queue = conflict_entry;
+			conflict_entry->next = NULL;
+			current = conflict_entry;
+		} else {
+			conflict_entry->next = current->next;
+			current->next = conflict_entry;
+		}
+	}
+}
+
 static void ce_queue_push(struct cache_entry **head,
 			  struct cache_entry **tail,
 			  struct cache_entry *ce)
@@ -855,15 +929,32 @@ static void ce_queue_push(struct cache_entry **head,
 	*tail = (*tail)->next_ce;
 }
 
+static void conflict_queue_push(struct conflict_entry **head,
+				struct conflict_entry **tail,
+				struct conflict_entry *conflict)
+{
+	if (!*head) {
+		*head = *tail = conflict;
+		(*tail)->next = NULL;
+		return;
+	}
+
+	(*tail)->next = conflict;
+	conflict->next = NULL;
+	*tail = (*tail)->next;
+}
+
 static struct directory_entry *compile_directory_data(struct index_state *istate,
 						      int nfile, unsigned int *ndir,
 						      unsigned int *total_dir_len,
-						      unsigned int *total_file_len)
+						      unsigned int *total_file_len,
+						      struct conflict_entry **conflict_queue)
 {
 	int i, dir_len = -1;
 	char *dir;
 	struct directory_entry *de, *current, *search;
 	struct cache_entry **cache = istate->cache;
+	struct conflict_entry *conflict_entry = NULL, *tail;
 	struct hash_table table;
 	uint32_t crc;
 
@@ -894,9 +985,22 @@ static struct directory_entry *compile_directory_data(struct index_state *istate
 		if (search->de_pathlen)
 			*total_file_len -= search->de_pathlen + 1;
 		ce_queue_push(&(search->ce), &(search->ce_last), cache[i]);
+
+		if (ce_stage(cache[i]) > 0) {
+			struct conflict_part *conflict_part;
+			if (!conflict_entry ||
+			    cache_name_compare(conflict_entry->name, conflict_entry->namelen,
+					       cache[i]->name, ce_namelen(cache[i]))) {
+				conflict_entry = create_conflict_entry_from_ce(cache[i]);
+				conflict_queue_push(conflict_queue, &tail, conflict_entry);
+			}
+			conflict_part = conflict_part_from_inmemory(cache[i]);
+			add_part_to_conflict_entry(conflict_entry, conflict_part);
+		}
 	}
 	if (istate->cache_tree)
 		cache_tree_to_ondisk(&table, istate->cache_tree);
+	resolve_undo_to_ondisk(istate->resolve_undo, conflict_queue);
 	return de;
 }
 
@@ -1062,16 +1166,82 @@ static int write_entries(struct index_state *istate,
 	return 0;
 }
 
+static int write_conflict(struct conflict_entry *conflict, int fd)
+{
+	struct conflict_entry *current;
+	struct conflict_part *current_part;
+	uint32_t crc;
+
+	current = conflict;
+	while (current) {
+		unsigned int to_write, i;
+
+		crc = 0;
+		if (ce_write(&crc, fd, current->name, current->namelen) < 0)
+			return -1;
+		if (ce_write(&crc, fd, "\0", 1) < 0)
+			return -1;
+		to_write = htonl(current->nfileconflicts);
+		if (ce_write(&crc, fd, (Bytef*)&to_write, 4) < 0)
+			return -1;
+		current_part = current->entries;
+		for (i = 0; i < current->nfileconflicts; i++) {
+			struct ondisk_conflict_part ondisk;
+
+			conflict_to_ondisk(current_part, &ondisk);
+			if (ce_write(&crc, fd, (Bytef*)&ondisk, sizeof(struct ondisk_conflict_part)) < 0)
+				return 0;
+			current_part = current_part->next;
+		}
+		crc = htonl(crc);
+		if (ce_write(NULL, fd, &crc, 4) < 0)
+			return -1;
+		current = current->next;
+	}
+	return 0;
+}
+
+static int write_resolve_undo(struct index_state *istate,
+			      struct conflict_entry *conflict_queue,
+			      int fd)
+{
+	struct conflict_entry *current;
+	int nr = 0;
+	uint32_t crc = 0, to_write;
+
+	/* Just count */
+	for (current = conflict_queue; current; current = current->next)
+		nr++;
+
+	if (ce_write(&crc, fd, "REUC", 4) < 0)
+		return -1;
+	to_write = htonl(nr);
+	if (ce_write(&crc, fd, &to_write, 4) < 0)
+		return -1;
+	to_write = htonl(crc);
+	if (ce_write(NULL, fd, &to_write, 4) < 0)
+		return -1;
+
+	current = conflict_queue;
+	while (current) {
+		if (write_conflict(current, fd) < 0)
+			return -1;
+		current = current->next;
+	}
+	return 0;
+}
+
 static int write_index_v5(struct index_state *istate, int newfd)
 {
 	struct cache_header hdr;
 	struct cache_header_v5 hdr_v5;
 	struct cache_entry **cache = istate->cache;
 	struct directory_entry *de;
+	struct conflict_entry *conflict_queue = NULL;
 	unsigned int entries = istate->cache_nr;
 	unsigned int i, removed, total_dir_len;
 	unsigned int total_file_len, foffsetblock;
-	unsigned int ndir;
+	unsigned int ndir, extoffset, nextension;
 	uint32_t crc;
 
 	if (istate->filter_opts)
@@ -1084,24 +1254,34 @@ static int write_index_v5(struct index_state *istate, int newfd)
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(istate->version);
 	hdr.hdr_entries = htonl(entries - removed);
-	hdr_v5.hdr_nextension = htonl(0); /* Currently no extensions are supported */
 
 	total_dir_len = 0;
 	total_file_len = 0;
 	de = compile_directory_data(istate, entries, &ndir,
-				    &total_dir_len, &total_file_len);
+				    &total_dir_len, &total_file_len,
+				    &conflict_queue);
 	hdr_v5.hdr_ndir = htonl(ndir);
 
-	foffsetblock = sizeof(hdr) + sizeof(hdr_v5) + 4
-		+ (ndir + 1) * 4
-		+ total_dir_len
-		+ ndir * (offsetof(struct ondisk_directory_entry, name) + 4);
+	nextension = (istate->resolve_undo || conflict_queue) ? 1 : 0;
+	foffsetblock = sizeof(hdr) + sizeof(hdr_v5) + (nextension * 4) + 4 +
+		(ndir + 1) * 4 + total_dir_len +
+		ndir * (offsetof(struct ondisk_directory_entry, name) + 4);
 	hdr_v5.hdr_fblockoffset = htonl(foffsetblock + (entries - removed + 1) * 4);
+	hdr_v5.hdr_nextension = htonl(nextension);
+
 	crc = 0;
 	if (ce_write(&crc, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 	if (ce_write(&crc, newfd, &hdr_v5, sizeof(hdr_v5)) < 0)
 		return -1;
+
+	if (nextension) {
+		extoffset = foffsetblock + (entries - removed + 1) * 4 + total_file_len +
+			(entries - removed) * (offsetof(struct ondisk_cache_entry, name) + 4);
+		extoffset = htonl(extoffset);
+		if (ce_write(&crc, newfd, &extoffset, 4) < 0)
+			return -1;
+	}
 	crc = htonl(crc);
 	if (ce_write(NULL, newfd, &crc, 4) < 0)
 		return -1;
@@ -1110,6 +1290,9 @@ static int write_index_v5(struct index_state *istate, int newfd)
 		return -1;
 	if (write_entries(istate, de, entries, newfd) < 0)
 		return -1;
+	if (nextension)
+		if (write_resolve_undo(istate, conflict_queue, newfd) < 0)
+			return -1;
 	return ce_flush(newfd);
 }
 
-- 
1.8.4.2
