From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/5] get rid of num_packed_objects()
Date: Wed, 16 Jul 2008 02:31:37 -0400
Message-ID: <1216189899-14279-4-git-send-email-nico@cam.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
 <1216189899-14279-2-git-send-email-nico@cam.org>
 <1216189899-14279-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:33:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ0ZX-0006cW-5v
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 08:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbYGPGbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYGPGbr
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 02:31:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11931 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbYGPGbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 02:31:43 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K43006BG64RTN50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jul 2008 02:31:41 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.3.499.geae9
In-reply-to: <1216189899-14279-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88644>

The coming index format change doesn't allow for the number of objects
to be determined from the size of the index file directly.  Instead, Let's
initialize a field in the packed_git structure with the object count when
the index is validated since the count is always known at that point.

(based on commit 57059091fad25427bce9b3d47e073ce0518d164b)

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-count-objects.c |    2 +-
 builtin-pack-objects.c  |    4 ++--
 cache.h                 |    2 +-
 fsck-objects.c          |    2 +-
 pack-check.c            |    4 ++--
 sha1_file.c             |    9 ++-------
 sha1_name.c             |    2 +-
 7 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 73c5982..7795a63 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -110,7 +110,7 @@ int cmd_count_objects(int ac, const char **av, const char *prefix)
 		for (p = packed_git; p; p = p->next) {
 			if (!p->pack_local)
 				continue;
-			packed += num_packed_objects(p);
+			packed += p->num_objects;
 		}
 		printf("count: %lu\n", loose);
 		printf("size: %lu\n", loose_size / 2);
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4c345d5..b9c3da2 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -168,7 +168,7 @@ static int cmp_offset(const void *a_, const void *b_)
 static void prepare_pack_revindex(struct pack_revindex *rix)
 {
 	struct packed_git *p = rix->p;
-	int num_ent = num_packed_objects(p);
+	int num_ent = p->num_objects;
 	int i;
 	const char *index = p->index_data;
 
@@ -202,7 +202,7 @@ static struct revindex_entry * find_packed_object(struct packed_git *p,
 		prepare_pack_revindex(rix);
 	revindex = rix->revindex;
 	lo = 0;
-	hi = num_packed_objects(p) + 1;
+	hi = p->num_objects + 1;
 	do {
 		int mi = (lo + hi) / 2;
 		if (revindex[mi].offset == ofs) {
diff --git a/cache.h b/cache.h
index 191c738..1bcc7c1 100644
--- a/cache.h
+++ b/cache.h
@@ -336,6 +336,7 @@ extern struct packed_git {
 	unsigned long pack_size;
 	const void *index_data;
 	void *pack_base;
+	unsigned int num_objects;
 	int index_version;
 	unsigned int pack_last_used;
 	unsigned int pack_use_cnt;
@@ -387,7 +388,6 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 extern int use_packed_git(struct packed_git *);
 extern void unuse_packed_git(struct packed_git *);
 extern struct packed_git *add_packed_git(char *, int, int);
-extern int num_packed_objects(const struct packed_git *p);
 extern const unsigned char *nth_packed_object_sha1(const struct packed_git *, unsigned int);
 extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry_gently(struct packed_git *, unsigned long, char *, unsigned long *);
diff --git a/fsck-objects.c b/fsck-objects.c
index f6015a8..bdbca54 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -550,7 +550,7 @@ int main(int argc, char **argv)
 			verify_pack(p, 0);
 
 		for (p = packed_git; p; p = p->next) {
-			int num = num_packed_objects(p);
+			int num = p->num_objects;
 			for (i = 0; i < num; i++)
 				fsck_sha1(nth_packed_object_sha1(p, i));
 		}
diff --git a/pack-check.c b/pack-check.c
index 11f6ed2..578f59e 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -22,10 +22,10 @@ static int verify_packfile(struct packed_git *p)
 		return error("Packfile version %d unsupported",
 			     ntohl(hdr->hdr_version));
 	nr_objects = ntohl(hdr->hdr_entries);
-	if (num_packed_objects(p) != nr_objects)
+	if (p->num_objects != nr_objects)
 		return error("Packfile claims to have %d objects, "
 			     "while idx size expects %d", nr_objects,
-			     num_packed_objects(p));
+			     p->num_objects);
 
 	/* Check integrity of pack data with its SHA-1 checksum */
 	SHA1_Init(&ctx);
diff --git a/sha1_file.c b/sha1_file.c
index b4c5209..9c40e7e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -458,6 +458,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	p->index_version = 1;
 	p->index_data = idx_map;
 	p->index_size = idx_size;
+	p->num_objects = nr;
 	return 0;
 }
 
@@ -1171,18 +1172,12 @@ void *unpack_entry_gently(struct packed_git *p, unsigned long offset,
 	}
 }
 
-int num_packed_objects(const struct packed_git *p)
-{
-	/* See check_packed_git_idx() */
-	return (p->index_size - 20 - 20 - 4*256) / 24;
-}
-
 const unsigned char *nth_packed_object_sha1(const struct packed_git *p,
 					    unsigned int n)
 {
 	const unsigned char *index = p->index_data;
 	index += 4 * 256;
-	if (num_packed_objects(p) <= n)
+	if (n >= p->num_objects)
 		return NULL;
 	return index + 24 * n + 4;
 }
diff --git a/sha1_name.c b/sha1_name.c
index d083096..be9be52 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -76,7 +76,7 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 
 	prepare_packed_git();
 	for (p = packed_git; p && found < 2; p = p->next) {
-		unsigned num = num_packed_objects(p);
+		unsigned num = p->num_objects;
 		unsigned first = 0, last = num;
 		while (first < last) {
 			unsigned mid = (first + last) / 2;
-- 
1.5.6.3.499.geae9
