From: Florian Forster <octo@verplant.org>
Subject: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 07:50:31 +0200
Message-ID: <1150609831500-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 07:50:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrqBN-0006K0-C6
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 07:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWFRFuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 01:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWFRFuf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 01:50:35 -0400
Received: from verplant.org ([213.95.21.52]:11239 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S932099AbWFRFue (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 01:50:34 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FrqB6-0001nQ-Jm; Sun, 18 Jun 2006 07:50:33 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1FrqB5-0001sx-3o; Sun, 18 Jun 2006 07:50:31 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22052>

Using this patch I was able to build git with
$ make CFLAGS="-Wall -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE"

While most of this patch fixes void-pointer arithmetic and is therefore
trivial, I had to change the use of a struct with FAMs in `diff-lib.c'. Since
this is the first time I encountered FAMs it'd probably be a good idea if
someone who knows would take a look at that.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 blame.c             |    4 ++--
 builtin-apply.c     |    6 +++---
 builtin-read-tree.c |    3 +--
 builtin-tar-tree.c  |    6 +++---
 convert-objects.c   |   22 +++++++++++-----------
 csum-file.c         |    4 ++--
 diff-delta.c        |    5 +++--
 diff-lib.c          |   41 ++++++++++++++++++++++-------------------
 diff.c              |    2 +-
 diffcore-order.c    |    2 +-
 http-fetch.c        |   15 ++++++++-------
 http-push.c         |   15 ++++++++-------
 http.c              |    4 ++--
 imap-send.c         |    2 +-
 pack-check.c        |    6 +++---
 pack-objects.c      |    4 ++--
 pack-redundant.c    |   16 ++++++++--------
 patch-delta.c       |    4 ++--
 pkt-line.c          |    4 ++--
 quote.c             |    9 ++++++++-
 read-cache.c        |   13 +++++++------
 sha1_file.c         |   27 ++++++++++++++-------------
 ssh-fetch.c         |    2 +-
 tag.c               |    4 ++--
 tree-walk.c         |   11 ++++++-----
 25 files changed, 123 insertions(+), 108 deletions(-)

714b7eca861ad3b6863209f0298d55c0c2292116
diff --git a/blame.c b/blame.c
index 25d3bcf..51eab2e 100644
--- a/blame.c
+++ b/blame.c
@@ -301,9 +301,9 @@ static void fill_line_map(struct commit 
 				if (DEBUG)
 					printf("map: i1: %d %d %p i2: %d %d %p\n",
 					       i1, map[i1],
-					       i1 != -1 ? blame_lines[map[i1]] : NULL,
+					       (void *) (i1 != -1 ? blame_lines[map[i1]] : NULL),
 					       i2, map2[i2],
-					       i2 != -1 ? blame_lines[map2[i2]] : NULL);
+					       (void *) (i2 != -1 ? blame_lines[map2[i2]] : NULL));
 				if (map2[i2] != -1 &&
 				    blame_lines[map[i1]] &&
 				    !blame_lines[map2[i2]])
diff --git a/builtin-apply.c b/builtin-apply.c
index e113c74..6dd0472 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -148,7 +148,7 @@ static void *read_patch_file(int fd, uns
 			buffer = xrealloc(buffer, alloc);
 			nr = alloc - size;
 		}
-		nr = xread(fd, buffer + size, nr);
+		nr = xread(fd, (char *) buffer + size, nr);
 		if (!nr)
 			break;
 		if (nr < 0)
@@ -164,7 +164,7 @@ static void *read_patch_file(int fd, uns
 	 */
 	if (alloc < size + SLOP)
 		buffer = xrealloc(buffer, size + SLOP);
-	memset(buffer + size, 0, SLOP);
+	memset((char *) buffer + size, 0, SLOP);
 	return buffer;
 }
 
@@ -1194,7 +1194,7 @@ static int read_old_data(struct stat *st
 			return error("unable to open %s", path);
 		got = 0;
 		for (;;) {
-			int ret = xread(fd, buf + got, size - got);
+			int ret = xread(fd, (char *) buf + got, size - got);
 			if (ret <= 0)
 				break;
 			got += ret;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index bb50fbd..fdd6706 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -30,8 +30,7 @@ static int merge_size = 0;
 
 static struct object_list *trees = NULL;
 
-static struct cache_entry df_conflict_entry = {
-};
+static struct cache_entry df_conflict_entry;
 
 struct tree_entry_list {
 	struct tree_entry_list *next;
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f6310b9..646322d 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -34,7 +34,7 @@ static void reliable_write(void *buf, un
 			die("git-tar-tree: disk full?");
 		}
 		size -= ret;
-		buf += ret;
+		buf   = (char *) buf + ret;
 	}
 }
 
@@ -87,13 +87,13 @@ static void write_blocked(void *buf, uns
 		memcpy(block + offset, buf, chunk);
 		size -= chunk;
 		offset += chunk;
-		buf += chunk;
+		buf     = (char *) buf + chunk;
 		write_if_needed();
 	}
 	while (size >= BLOCKSIZE) {
 		reliable_write(buf, BLOCKSIZE);
 		size -= BLOCKSIZE;
-		buf += BLOCKSIZE;
+		buf   = (char *) buf + BLOCKSIZE;
 	}
 	if (size) {
 		memcpy(block + offset, buf, size);
diff --git a/convert-objects.c b/convert-objects.c
index a67d6b4..0fabd89 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -103,12 +103,12 @@ static int write_subdirectory(void *buff
 		if (!slash) {
 			newlen += sprintf(new + newlen, "%o %s", mode, path);
 			new[newlen++] = '\0';
-			memcpy(new + newlen, buffer + len - 20, 20);
+			memcpy(new + newlen, (char *) buffer + len - 20, 20);
 			newlen += 20;
 
 			used += len;
 			size -= len;
-			buffer += len;
+			buffer = (char *) buffer + len;
 			continue;
 		}
 
@@ -121,7 +121,7 @@ static int write_subdirectory(void *buff
 
 		used += len;
 		size -= len;
-		buffer += len;
+		buffer = (char *) buffer + len;
 	}
 
 	write_sha1_file(new, newlen, tree_type, result_sha1);
@@ -137,13 +137,13 @@ static void convert_tree(void *buffer, u
 	while (size) {
 		int len = 1+strlen(buffer);
 
-		convert_binary_sha1(buffer + len);
+		convert_binary_sha1((char *) buffer + len);
 
 		len += 20;
 		if (len > size)
 			die("corrupt tree object");
 		size -= len;
-		buffer += len;
+		buffer = (char *) buffer + len;
 	}
 
 	write_subdirectory(orig_buffer, orig_size, "", 0, result_sha1);
@@ -244,14 +244,14 @@ static void convert_date(void *buffer, u
 	// "tree <sha1>\n"
 	memcpy(new + newlen, buffer, 46);
 	newlen += 46;
-	buffer += 46;
+	buffer = (char *) buffer + 46;
 	size -= 46;
 
 	// "parent <sha1>\n"
 	while (!memcmp(buffer, "parent ", 7)) {
 		memcpy(new + newlen, buffer, 48);
 		newlen += 48;
-		buffer += 48;
+		buffer = (char *) buffer + 48;
 		size -= 48;
 	}
 
@@ -275,11 +275,11 @@ static void convert_commit(void *buffer,
 
 	if (memcmp(buffer, "tree ", 5))
 		die("Bad commit '%s'", (char*) buffer);
-	convert_ascii_sha1(buffer+5);
-	buffer += 46;    /* "tree " + "hex sha1" + "\n" */
+	convert_ascii_sha1((char *) buffer + 5);
+	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
 	while (!memcmp(buffer, "parent ", 7)) {
-		convert_ascii_sha1(buffer+7);
-		buffer += 48;
+		convert_ascii_sha1((char *) buffer + 7);
+		buffer = (char *) buffer + 48;
 	}
 	convert_date(orig_buffer, orig_size, result_sha1);
 }
diff --git a/csum-file.c b/csum-file.c
index 5f9249a..ebaad03 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -17,7 +17,7 @@ static int sha1flush(struct sha1file *f,
 	for (;;) {
 		int ret = xwrite(f->fd, buf, count);
 		if (ret > 0) {
-			buf += ret;
+			buf = (char *) buf + ret;
 			count -= ret;
 			if (count)
 				continue;
@@ -57,7 +57,7 @@ int sha1write(struct sha1file *f, void *
 		memcpy(f->buffer + offset, buf, nr);
 		count -= nr;
 		offset += nr;
-		buf += nr;
+		buf = (char *) buf + nr;
 		left -= nr;
 		if (!left) {
 			SHA1_Update(&f->ctx, f->buffer, offset);
diff --git a/diff-delta.c b/diff-delta.c
index 25a798d..8b9172a 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -22,6 +22,7 @@ #include <stdlib.h>
 #include <string.h>
 #include "delta.h"
 
+#include "git-compat-util.h"
 
 /* maximum hash entry list for the same hash bucket */
 #define HASH_LIMIT 64
@@ -131,7 +132,7 @@ struct delta_index {
 	const void *src_buf;
 	unsigned long src_size;
 	unsigned int hash_mask;
-	struct index_entry *hash[0];
+	struct index_entry *hash[FLEX_ARRAY];
 };
 
 struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
@@ -283,7 +284,7 @@ create_delta(const struct delta_index *i
 	ref_data = index->src_buf;
 	ref_top = ref_data + index->src_size;
 	data = trg_buf;
-	top = trg_buf + trg_size;
+	top = (const unsigned char *) trg_buf + trg_size;
 
 	outpos++;
 	val = 0;
diff --git a/diff-lib.c b/diff-lib.c
index 2183b41..fdc1173 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -34,21 +34,23 @@ int run_diff_files(struct rev_info *revs
 			continue;
 
 		if (ce_stage(ce)) {
-			struct {
-				struct combine_diff_path p;
-				struct combine_diff_parent filler[5];
-			} combine;
+			struct combine_diff_path *dpath;
 			int num_compare_stages = 0;
+			size_t path_len;
 
-			combine.p.next = NULL;
-			combine.p.len = ce_namelen(ce);
-			combine.p.path = xmalloc(combine.p.len + 1);
-			memcpy(combine.p.path, ce->name, combine.p.len);
-			combine.p.path[combine.p.len] = 0;
-			combine.p.mode = 0;
-			memset(combine.p.sha1, 0, 20);
-			memset(&combine.p.parent[0], 0,
-			       sizeof(combine.filler));
+			path_len = ce_namelen(ce);
+
+			dpath = xmalloc (combine_diff_path_size (5, path_len));
+			dpath->path = (char *) &(dpath->parent[5]);
+
+			dpath->next = NULL;
+			dpath->len = path_len;
+			memcpy(dpath->path, ce->name, path_len);
+			dpath->path[path_len] = '\0';
+			dpath->mode = 0;
+			memset(dpath->sha1, 0, 20);
+			memset(&(dpath->parent[0]), 0,
+					sizeof(struct combine_diff_parent)*5);
 
 			while (i < entries) {
 				struct cache_entry *nce = active_cache[i];
@@ -64,11 +66,11 @@ int run_diff_files(struct rev_info *revs
 				if (2 <= stage) {
 					int mode = ntohl(nce->ce_mode);
 					num_compare_stages++;
-					memcpy(combine.p.parent[stage-2].sha1,
+					memcpy(dpath->parent[stage-2].sha1,
 					       nce->sha1, 20);
-					combine.p.parent[stage-2].mode =
+					dpath->parent[stage-2].mode =
 						canon_mode(mode);
-					combine.p.parent[stage-2].status =
+					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
 				}
 
@@ -83,13 +85,14 @@ int run_diff_files(struct rev_info *revs
 			i--;
 
 			if (revs->combine_merges && num_compare_stages == 2) {
-				show_combined_diff(&combine.p, 2,
+				show_combined_diff(dpath, 2,
 						   revs->dense_combined_merges,
 						   revs);
-				free(combine.p.path);
+				free(dpath);
 				continue;
 			}
-			free(combine.p.path);
+			free(dpath);
+			dpath = NULL;
 
 			/*
 			 * Show the diff for the 'ce' if we found the one
diff --git a/diff.c b/diff.c
index 9e9cfc8..fb1411c 100644
--- a/diff.c
+++ b/diff.c
@@ -515,7 +515,7 @@ static void emit_binary_diff(mmfile_t *o
 		else
 			line[0] = bytes - 26 + 'a' - 1;
 		encode_85(line + 1, cp, bytes);
-		cp += bytes;
+		cp = (char *) cp + bytes;
 		puts(line);
 	}
 	printf("\n");
diff --git a/diffcore-order.c b/diffcore-order.c
index 0bc2b22..aef6da6 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -30,7 +30,7 @@ static void prepare_order(const char *or
 	close(fd);
 	if (map == MAP_FAILED)
 		return;
-	endp = map + st.st_size;
+	endp = (char *) map + st.st_size;
 	for (pass = 0; pass < 2; pass++) {
 		cnt = 0;
 		cp = map;
diff --git a/http-fetch.c b/http-fetch.c
index da1a7f5..2b63d89 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -123,7 +123,7 @@ static size_t fwrite_sha1_file(void *ptr
 	struct object_request *obj_req = (struct object_request *)data;
 	do {
 		ssize_t retval = write(obj_req->local,
-				       ptr + posn, size - posn);
+				       (char *) ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
 		posn += retval;
@@ -1136,13 +1136,14 @@ int fetch(unsigned char *sha1)
 
 static inline int needs_quote(int ch)
 {
-	switch (ch) {
-	case '/': case '-': case '.':
-	case 'A'...'Z':	case 'a'...'z':	case '0'...'9':
+	if (((ch >= 'A') && (ch <= 'Z'))
+			|| ((ch >= 'a') && (ch <= 'z'))
+			|| ((ch >= '0') && (ch <= '9'))
+			|| (ch == '/')
+			|| (ch == '-')
+			|| (ch == '.'))
 		return 0;
-	default:
-		return 1;
-	}
+	return 1;
 }
 
 static inline int hex(int v)
diff --git a/http-push.c b/http-push.c
index 2d9441e..0684e46 100644
--- a/http-push.c
+++ b/http-push.c
@@ -196,7 +196,7 @@ static size_t fwrite_sha1_file(void *ptr
 	struct transfer_request *request = (struct transfer_request *)data;
 	do {
 		ssize_t retval = write(request->local_fileno,
-				       ptr + posn, size - posn);
+				       (char *) ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
 		posn += retval;
@@ -1077,13 +1077,14 @@ static int fetch_indices(void)
 
 static inline int needs_quote(int ch)
 {
-	switch (ch) {
-	case '/': case '-': case '.':
-	case 'A'...'Z':	case 'a'...'z':	case '0'...'9':
+	if (((ch >= 'A') && (ch <= 'Z'))
+			|| ((ch >= 'a') && (ch <= 'z'))
+			|| ((ch >= '0') && (ch <= '9'))
+			|| (ch == '/')
+			|| (ch == '-')
+			|| (ch == '.'))
 		return 0;
-	default:
-		return 1;
-	}
+	return 1;
 }
 
 static inline int hex(int v)
diff --git a/http.c b/http.c
index 08769cc..6c1937b 100644
--- a/http.c
+++ b/http.c
@@ -34,7 +34,7 @@ size_t fread_buffer(void *ptr, size_t el
 	size_t size = eltsize * nmemb;
 	if (size > buffer->size - buffer->posn)
 		size = buffer->size - buffer->posn;
-	memcpy(ptr, buffer->buffer + buffer->posn, size);
+	memcpy(ptr, (char *) buffer->buffer + buffer->posn, size);
 	buffer->posn += size;
 	return size;
 }
@@ -49,7 +49,7 @@ size_t fwrite_buffer(const void *ptr, si
 			buffer->size = buffer->posn + size;
 		buffer->buffer = xrealloc(buffer->buffer, buffer->size);
 	}
-	memcpy(buffer->buffer + buffer->posn, ptr, size);
+	memcpy((char *) buffer->buffer + buffer->posn, ptr, size);
 	buffer->posn += size;
 	data_received++;
 	return size;
diff --git a/imap-send.c b/imap-send.c
index 285ad29..87db8e2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -93,7 +93,7 @@ typedef struct {
 	char *data;
 	int len;
 	unsigned char flags;
-	unsigned char crlf:1;
+	unsigned int  crlf:1;
 } msg_data_t;
 
 #define DRV_OK          0
diff --git a/pack-check.c b/pack-check.c
index e575879..3a62e1b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -29,10 +29,10 @@ static int verify_packfile(struct packed
 	pack_base = p->pack_base;
 	SHA1_Update(&ctx, pack_base, pack_size - 20);
 	SHA1_Final(sha1, &ctx);
-	if (memcmp(sha1, pack_base + pack_size - 20, 20))
+	if (memcmp(sha1, (char *) pack_base + pack_size - 20, 20))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
-	if (memcmp(sha1, index_base + index_size - 40, 20))
+	if (memcmp(sha1, (char *) index_base + index_size - 40, 20))
 		return error("Packfile %s SHA1 mismatch with idx",
 			     p->pack_name);
 
@@ -135,7 +135,7 @@ int verify_pack(struct packed_git *p, in
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, index_base, index_size - 20);
 	SHA1_Final(sha1, &ctx);
-	if (memcmp(sha1, index_base + index_size - 20, 20))
+	if (memcmp(sha1, (char *) index_base + index_size - 20, 20))
 		ret = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
 
diff --git a/pack-objects.c b/pack-objects.c
index 179560f..ba6525d 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -156,7 +156,7 @@ static void prepare_pack_revindex(struct
 
 	rix->revindex = xmalloc(sizeof(unsigned long) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
-		unsigned int hl = *((unsigned int *)(index + 24 * i));
+		unsigned int hl = *((unsigned int *)((char *) index + 24*i));
 		rix->revindex[i] = ntohl(hl);
 	}
 	/* This knows the pack format -- the 20-byte trailer
@@ -300,7 +300,7 @@ static unsigned long write_object(struct
 		use_packed_git(p);
 
 		datalen = find_packed_object_size(p, entry->in_pack_offset);
-		buf = p->pack_base + entry->in_pack_offset;
+		buf = (char *) p->pack_base + entry->in_pack_offset;
 		sha1write(f, buf, datalen);
 		unuse_packed_git(p);
 		hdrlen = 0; /* not really */
diff --git a/pack-redundant.c b/pack-redundant.c
index cd81f5a..4864a2b 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -246,12 +246,12 @@ static struct pack_list * pack_list_diff
 static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 {
 	int p1_off, p2_off;
-	void *p1_base, *p2_base;
+	unsigned char *p1_base, *p2_base;
 	struct llist_item *p1_hint = NULL, *p2_hint = NULL;
 	
 	p1_off = p2_off = 256 * 4 + 4;
-	p1_base = (void *)p1->pack->index_base;
-	p2_base = (void *)p2->pack->index_base;
+	p1_base = (unsigned char *) p1->pack->index_base;
+	p2_base = (unsigned char *) p2->pack->index_base;
 
 	while (p1_off <= p1->pack->index_size - 3 * 20 &&
 	       p2_off <= p2->pack->index_size - 3 * 20)
@@ -351,11 +351,11 @@ static size_t sizeof_union(struct packed
 {
 	size_t ret = 0;
 	int p1_off, p2_off;
-	void *p1_base, *p2_base;
+	char *p1_base, *p2_base;
 
 	p1_off = p2_off = 256 * 4 + 4;
-	p1_base = (void *)p1->index_base;
-	p2_base = (void *)p2->index_base;
+	p1_base = (char *)p1->index_base;
+	p2_base = (char *)p2->index_base;
 
 	while (p1_off <= p1->index_size - 3 * 20 &&
 	       p2_off <= p2->index_size - 3 * 20)
@@ -534,7 +534,7 @@ static struct pack_list * add_pack(struc
 {
 	struct pack_list l;
 	size_t off;
-	void *base;
+	unsigned char *base;
 
 	if (!p->pack_local && !(alt_odb || verbose))
 		return NULL;
@@ -543,7 +543,7 @@ static struct pack_list * add_pack(struc
 	llist_init(&l.all_objects);
 
 	off = 256 * 4 + 4;
-	base = (void *)p->index_base;
+	base = (unsigned char *)p->index_base;
 	while (off <= p->index_size - 3 * 20) {
 		llist_insert_back(l.all_objects, base + off);
 		off += 24;
diff --git a/patch-delta.c b/patch-delta.c
index 8f318ed..e3a1d42 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -25,7 +25,7 @@ void *patch_delta(const void *src_buf, u
 		return NULL;
 
 	data = delta_buf;
-	top = delta_buf + delta_size;
+	top = (const unsigned char *) delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
 	size = get_delta_hdr_size(&data, top);
@@ -56,7 +56,7 @@ void *patch_delta(const void *src_buf, u
 			    cp_off + cp_size > src_size ||
 			    cp_size > size)
 				goto bad;
-			memcpy(out, src_buf + cp_off, cp_size);
+			memcpy(out, (char *) src_buf + cp_off, cp_size);
 			out += cp_size;
 			size -= cp_size;
 		} else if (cmd) {
diff --git a/pkt-line.c b/pkt-line.c
index bb3bab0..44d4296 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -21,7 +21,7 @@ static void safe_write(int fd, const voi
 	while (n) {
 		int ret = xwrite(fd, buf, n);
 		if (ret > 0) {
-			buf += ret;
+			buf = (char *) buf + ret;
 			n -= ret;
 			continue;
 		}
@@ -66,7 +66,7 @@ static void safe_read(int fd, void *buff
 	int n = 0;
 
 	while (n < size) {
-		int ret = xread(fd, buffer + n, size - n);
+		int ret = xread(fd, (char *) buffer + n, size - n);
 		if (ret < 0)
 			die("read error (%s)", strerror(errno));
 		if (!ret)
diff --git a/quote.c b/quote.c
index 06792d4..dcc2326 100644
--- a/quote.c
+++ b/quote.c
@@ -206,7 +206,14 @@ #define EMIT(c) (outp ? (*outp++ = (c)) 
 				case '\\': case '"':
 					break; /* verbatim */
 
-				case '0'...'7':
+				case '0':
+				case '1':
+				case '2':
+				case '3':
+				case '4':
+				case '5':
+				case '6':
+				case '7':
 					/* octal */
 					ac = ((ch - '0') << 6);
 					if ((ch = *sp++) < '0' || '7' < ch)
diff --git a/read-cache.c b/read-cache.c
index c499c51..3c32aae 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -706,7 +706,7 @@ static int verify_hdr(struct cache_heade
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, size - 20);
 	SHA1_Final(sha1, &c);
-	if (memcmp(sha1, (void *)hdr + size - 20, 20))
+	if (memcmp(sha1, (char *) hdr + size - 20, 20))
 		return error("bad index file sha1 signature");
 	return 0;
 }
@@ -770,7 +770,7 @@ int read_cache(void)
 
 	offset = sizeof(*hdr);
 	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = map + offset;
+		struct cache_entry *ce = (struct cache_entry *) ((char *) map + offset);
 		offset = offset + ce_size(ce);
 		active_cache[i] = ce;
 	}
@@ -783,10 +783,11 @@ int read_cache(void)
 		 * in 4-byte network byte order.
 		 */
 		unsigned long extsize;
-		memcpy(&extsize, map + offset + 4, 4);
+		memcpy(&extsize, (char *) map + offset + 4, 4);
 		extsize = ntohl(extsize);
-		if (read_index_extension(map + offset,
-					 map + offset + 8, extsize) < 0)
+		if (read_index_extension(((const char *) map) + offset,
+					 (char *) map + offset + 8,
+					 extsize) < 0)
 			goto unmap;
 		offset += 8;
 		offset += extsize;
@@ -820,7 +821,7 @@ static int ce_write(SHA_CTX *context, in
 		}
 		write_buffer_len = buffered;
 		len -= partial;
-		data += partial;
+		data = (char *) data + partial;
  	}
  	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index b4ff233..3c001d7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -486,7 +486,8 @@ int use_packed_git(struct packed_git *p)
 		 * this is cheap.
 		 */
 		if (memcmp((char*)(p->index_base) + p->index_size - 40,
-			   p->pack_base + p->pack_size - 20, 20)) {
+			   (char *) p->pack_base + p->pack_size - 20,
+			   20)) {
 			      
 			die("packfile %s does not match index.", p->pack_name);
 		}
@@ -701,7 +702,7 @@ static void *unpack_sha1_rest(z_stream *
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmalloc(1+size);
 
-	memcpy(buf, buffer + bytes, stream->total_out - bytes);
+	memcpy(buf, (char *) buffer + bytes, stream->total_out - bytes);
 	bytes = stream->total_out - bytes;
 	if (bytes < size) {
 		stream->next_out = buf + bytes;
@@ -853,7 +854,7 @@ static unsigned long unpack_object_heade
 	if (offset >= p->pack_size)
 		die("object offset outside of pack file");
 
-	pack =  p->pack_base + offset;
+	pack =  (unsigned char *) p->pack_base + offset;
 	c = *pack++;
 	offset++;
 	*type = (c >> 4) & 7;
@@ -883,7 +884,7 @@ int check_reuse_pack_delta(struct packed
 	ptr = unpack_object_header(p, ptr, kindp, sizep);
 	if (*kindp != OBJ_DELTA)
 		goto done;
-	memcpy(base, p->pack_base + ptr, 20);
+	memcpy(base, (char *) p->pack_base + ptr, 20);
 	status = 0;
  done:
 	unuse_packed_git(p);
@@ -903,7 +904,7 @@ void packed_object_info_detail(struct pa
 	enum object_type kind;
 
 	offset = unpack_object_header(p, e->offset, &kind, size);
-	pack = p->pack_base + offset;
+	pack = (unsigned char *) p->pack_base + offset;
 	if (kind != OBJ_DELTA)
 		*delta_chain_length = 0;
 	else {
@@ -919,7 +920,7 @@ void packed_object_info_detail(struct pa
 			find_pack_entry_one(pack, &base_ent, p);
 			offset = unpack_object_header(p, base_ent.offset,
 						      &kind, &junk);
-			pack = p->pack_base + offset;
+			pack = (unsigned char *) p->pack_base + offset;
 			chain_length++;
 		} while (kind == OBJ_DELTA);
 		*delta_chain_length = chain_length;
@@ -957,7 +958,7 @@ static int packed_object_info(struct pac
 		die("cannot map packed file");
 
 	offset = unpack_object_header(p, entry->offset, &kind, &size);
-	pack = p->pack_base + offset;
+	pack = (unsigned char *) p->pack_base + offset;
 	left = p->pack_size - offset;
 
 	switch (kind) {
@@ -1096,7 +1097,7 @@ void *unpack_entry_gently(struct pack_en
 	void *retval;
 
 	offset = unpack_object_header(p, entry->offset, &kind, &size);
-	pack = p->pack_base + offset;
+	pack = (unsigned char *) p->pack_base + offset;
 	left = p->pack_size - offset;
 	switch (kind) {
 	case OBJ_DELTA:
@@ -1134,7 +1135,7 @@ int nth_packed_object_sha1(const struct 
 	void *index = p->index_base + 256;
 	if (n < 0 || num_packed_objects(p) <= n)
 		return -1;
-	memcpy(sha1, (index + 24 * n + 4), 20);
+	memcpy(sha1, (char *) index + (24 * n) + 4, 20);
 	return 0;
 }
 
@@ -1148,9 +1149,9 @@ int find_pack_entry_one(const unsigned c
 
 	do {
 		int mi = (lo + hi) / 2;
-		int cmp = memcmp(index + 24 * mi + 4, sha1, 20);
+		int cmp = memcmp((char *) index + (24 * mi) + 4, sha1, 20);
 		if (!cmp) {
-			e->offset = ntohl(*((unsigned int *)(index + 24 * mi)));
+			e->offset = ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
 			memcpy(e->sha1, sha1, 20);
 			e->p = p;
 			return 1;
@@ -1290,7 +1291,7 @@ void *read_object_with_reference(const u
 		ref_length = strlen(ref_type);
 
 		if (memcmp(buffer, ref_type, ref_length) ||
-		    get_sha1_hex(buffer + ref_length, actual_sha1)) {
+		    get_sha1_hex((char *) buffer + ref_length, actual_sha1)) {
 			free(buffer);
 			return NULL;
 		}
@@ -1408,7 +1409,7 @@ static int write_buffer(int fd, const vo
 			return error("file write error (%s)", strerror(errno));
 		}
 		len -= size;
-		buf += size;
+		buf = (char *) buf + size;
 	}
 	return 0;
 }
diff --git a/ssh-fetch.c b/ssh-fetch.c
index e3067b8..1e59cd2 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -24,7 +24,7 @@ static ssize_t force_write(int fd, void 
 {
 	ssize_t ret = 0;
 	while (ret < length) {
-		ssize_t size = write(fd, buffer + ret, length - ret);
+		ssize_t size = write(fd, (char *) buffer + ret, length - ret);
 		if (size < 0) {
 			return size;
 		}
diff --git a/tag.c b/tag.c
index f390ee7..13c364d 100644
--- a/tag.c
+++ b/tag.c
@@ -47,10 +47,10 @@ int parse_tag_buffer(struct tag *item, v
 
 	if (size < 64)
 		return -1;
-	if (memcmp("object ", data, 7) || get_sha1_hex(data + 7, object))
+	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, object))
 		return -1;
 
-	type_line = data + 48;
+	type_line = (char *) data + 48;
 	if (memcmp("\ntype ", type_line-1, 6))
 		return -1;
 
diff --git a/tree-walk.c b/tree-walk.c
index 297c697..3f83e98 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -43,7 +43,7 @@ void update_tree_entry(struct tree_desc 
 
 	if (size < len)
 		die("corrupt tree file");
-	desc->buf = buf + len;
+	desc->buf = (char *) buf + len;
 	desc->size = size - len;
 }
 
@@ -66,7 +66,7 @@ const unsigned char *tree_entry_extract(
 	const void *tree = desc->buf;
 	unsigned long size = desc->size;
 	int len = strlen(tree)+1;
-	const unsigned char *sha1 = tree + len;
+	const unsigned char *sha1 = (unsigned char *) tree + len;
 	const char *path;
 	unsigned int mode;
 
@@ -80,7 +80,8 @@ const unsigned char *tree_entry_extract(
 
 int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 {
-	const void *tree = desc->buf, *path;
+	const void *tree = desc->buf;
+	const char *path;
 	unsigned long len, size = desc->size;
 
 	if (!size)
@@ -95,10 +96,10 @@ int tree_entry(struct tree_desc *desc, s
 	entry->pathlen = len;
 
 	path += len + 1;
-	entry->sha1 = path;
+	entry->sha1 = (const unsigned char *) path;
 
 	path += 20;
-	len = path - tree;
+	len = path - (char *) tree;
 	if (len > size)
 		die("corrupt tree file");
 
-- 
1.3.3
