From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 01/10] get rid of num_packed_objects()
Date: Mon, 09 Apr 2007 01:06:28 -0400
Message-ID: <11760951973319-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5t-00038I-Hg
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXDIFGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbXDIFGl
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbXDIFGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:39 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:39 -0400 (EDT)
In-reply-to: <11760951973172-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44033>

The coming index format change doesn't allow for the number of objects
to be determined from the size of the index file directly.  Instead, Let's
initialize a field in the packed_git structure with the object count when
the index is validated since the count is always known at that point.

While at it let's reorder some struct packed_git fields to avoid padding
due to needed 64-bit alignment for some of them.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-count-objects.c |    2 +-
 builtin-fsck.c          |    2 +-
 builtin-pack-objects.c  |    4 ++--
 cache.h                 |    8 ++++----
 pack-check.c            |    4 ++--
 sha1_file.c             |   17 ++++++-----------
 sha1_name.c             |    2 +-
 7 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 6263d8a..ff90ebd 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -111,7 +111,7 @@ int cmd_count_objects(int ac, const char **av, const char *prefix)
 		for (p = packed_git; p; p = p->next) {
 			if (!p->pack_local)
 				continue;
-			packed += num_packed_objects(p);
+			packed += p->num_objects;
 			num_pack++;
 		}
 		printf("count: %lu\n", loose);
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 4d8b66c..44a02d3 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -653,7 +653,7 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			verify_pack(p, 0);
 
 		for (p = packed_git; p; p = p->next) {
-			uint32_t i, num = num_packed_objects(p);
+			uint32_t i, num = p->num_objects;
 			for (i = 0; i < num; i++)
 				fsck_sha1(nth_packed_object_sha1(p, i));
 		}
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 45ac3e4..6bff17b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -164,7 +164,7 @@ static int cmp_offset(const void *a_, const void *b_)
 static void prepare_pack_revindex(struct pack_revindex *rix)
 {
 	struct packed_git *p = rix->p;
-	int num_ent = num_packed_objects(p);
+	int num_ent = p->num_objects;
 	int i;
 	const char *index = p->index_data;
 
@@ -198,7 +198,7 @@ static struct revindex_entry * find_packed_object(struct packed_git *p,
 		prepare_pack_revindex(rix);
 	revindex = rix->revindex;
 	lo = 0;
-	hi = num_packed_objects(p) + 1;
+	hi = p->num_objects + 1;
 	do {
 		int mi = (lo + hi) / 2;
 		if (revindex[mi].offset == ofs) {
diff --git a/cache.h b/cache.h
index c15daa8..73d8e63 100644
--- a/cache.h
+++ b/cache.h
@@ -378,11 +378,12 @@ struct pack_window {
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
-	const void *index_data;
-	off_t index_size;
 	off_t pack_size;
-	time_t mtime;
+	const void *index_data;
+	size_t index_size;
+	uint32_t num_objects;
 	int index_version;
+	time_t mtime;
 	int pack_fd;
 	int pack_local;
 	unsigned char sha1[20];
@@ -433,7 +434,6 @@ extern void pack_report(void);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *, int, int);
-extern uint32_t num_packed_objects(const struct packed_git *p);
 extern const unsigned char *nth_packed_object_sha1(const struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
diff --git a/pack-check.c b/pack-check.c
index f58083d..d04536b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -40,7 +40,7 @@ static int verify_packfile(struct packed_git *p,
 	 * have verified that nr_objects matches between idx and pack,
 	 * we do not do scan-streaming check on the pack file.
 	 */
-	nr_objects = num_packed_objects(p);
+	nr_objects = p->num_objects;
 	for (i = 0, err = 0; i < nr_objects; i++) {
 		const unsigned char *sha1;
 		void *data;
@@ -79,7 +79,7 @@ static void show_pack_info(struct packed_git *p)
 {
 	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN];
 
-	nr_objects = num_packed_objects(p);
+	nr_objects = p->num_objects;
 	memset(chain_histogram, 0, sizeof(chain_histogram));
 
 	for (i = 0; i < nr_objects; i++) {
diff --git a/sha1_file.c b/sha1_file.c
index 4304fe9..d9ca69a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -494,6 +494,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	p->index_version = 1;
 	p->index_data = idx_map;
 	p->index_size = idx_size;
+	p->num_objects = nr;
 	return 0;
 }
 
@@ -605,11 +606,11 @@ static int open_packed_git_1(struct packed_git *p)
 			p->pack_name, ntohl(hdr.hdr_version));
 
 	/* Verify the pack matches its index. */
-	if (num_packed_objects(p) != ntohl(hdr.hdr_entries))
+	if (p->num_objects != ntohl(hdr.hdr_entries))
 		return error("packfile %s claims to have %u objects"
-			" while index size indicates %u objects",
-			p->pack_name, ntohl(hdr.hdr_entries),
-			num_packed_objects(p));
+			     " while index indicates %u objects",
+			     p->pack_name, ntohl(hdr.hdr_entries),
+			     p->num_objects);
 	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
 		return error("end of packfile %s is unavailable", p->pack_name);
 	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
@@ -1526,18 +1527,12 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	return data;
 }
 
-uint32_t num_packed_objects(const struct packed_git *p)
-{
-	/* See check_packed_git_idx() */
-	return (uint32_t)((p->index_size - 20 - 20 - 4*256) / 24);
-}
-
 const unsigned char *nth_packed_object_sha1(const struct packed_git *p,
 					    uint32_t n)
 {
 	const unsigned char *index = p->index_data;
 	index += 4 * 256;
-	if (num_packed_objects(p) <= n)
+	if (n >= p->num_objects)
 		return NULL;
 	return index + 24 * n + 4;
 }
diff --git a/sha1_name.c b/sha1_name.c
index 267ea3f..b0b12bb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -76,7 +76,7 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 
 	prepare_packed_git();
 	for (p = packed_git; p && found < 2; p = p->next) {
-		uint32_t num = num_packed_objects(p);
+		uint32_t num = p->num_objects;
 		uint32_t first = 0, last = num;
 		while (first < last) {
 			uint32_t mid = (first + last) / 2;
-- 
1.5.1.696.g6d352-dirty
