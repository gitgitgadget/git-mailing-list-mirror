From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/5] clean up and optimize nth_packed_object_sha1() usage
Date: Wed, 16 Jul 2008 02:31:36 -0400
Message-ID: <1216189899-14279-3-git-send-email-nico@cam.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
 <1216189899-14279-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:33:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ0ZW-0006cW-A8
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 08:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbYGPGbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 02:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYGPGbp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 02:31:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11931 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbYGPGbm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 02:31:42 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K43006BG64RTN50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jul 2008 02:31:41 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.3.499.geae9
In-reply-to: <1216189899-14279-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88645>

Let's avoid the open coded pack index reference in pack-object and use
nth_packed_object_sha1() instead.  This will help encapsulating index
format differences in one place.

And while at it there is no reason to copy SHA1's over and over while a
direct pointer to it in the index will do just fine.

(based on commit d72308e01c5977177cda0aed06cfeee9192e1247)

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 +-
 cache.h                |    2 +-
 fsck-objects.c         |    9 +++------
 pack-check.c           |   11 +++++++----
 sha1_file.c            |   11 +++++------
 sha1_name.c            |   16 ++++++++--------
 6 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ae051f9..4c345d5 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -227,7 +227,7 @@ static const unsigned char *find_packed_object_name(struct packed_git *p,
 						    unsigned long ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
-	return ((unsigned char *)p->index_data) + 4 * 256 + 24 * entry->nr + 4;
+	return nth_packed_object_sha1(p, entry->nr);
 }
 
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
diff --git a/cache.h b/cache.h
index cc8e84e..191c738 100644
--- a/cache.h
+++ b/cache.h
@@ -388,7 +388,7 @@ extern int use_packed_git(struct packed_git *);
 extern void unuse_packed_git(struct packed_git *);
 extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
-extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
+extern const unsigned char *nth_packed_object_sha1(const struct packed_git *, unsigned int);
 extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry_gently(struct packed_git *, unsigned long, char *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/fsck-objects.c b/fsck-objects.c
index 46b628c..f6015a8 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -289,7 +289,7 @@ static int fsck_tag(struct tag *tag)
 	return 0;
 }
 
-static int fsck_sha1(unsigned char *sha1)
+static int fsck_sha1(const unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
 	if (!obj)
@@ -551,11 +551,8 @@ int main(int argc, char **argv)
 
 		for (p = packed_git; p; p = p->next) {
 			int num = num_packed_objects(p);
-			for (i = 0; i < num; i++) {
-				unsigned char sha1[20];
-				nth_packed_object_sha1(p, i, sha1);
-				fsck_sha1(sha1);
-			}
+			for (i = 0; i < num; i++)
+				fsck_sha1(nth_packed_object_sha1(p, i));
 		}
 	}
 
diff --git a/pack-check.c b/pack-check.c
index 7db44e9..11f6ed2 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -51,12 +51,13 @@ static int verify_packfile(struct packed_git *p)
 	 * we do not do scan-streaming check on the pack file.
 	 */
 	for (i = err = 0; i < nr_objects; i++) {
-		unsigned char sha1[20];
+		const unsigned char *sha1;
 		void *data;
 		char type[20];
 		unsigned long size, offset;
 
-		if (nth_packed_object_sha1(p, i, sha1))
+		sha1 = nth_packed_object_sha1(p, i);
+		if (!sha1)
 			die("internal error pack-check nth-packed-object");
 		offset = find_pack_entry_one(sha1, p);
 		if (!offset)
@@ -93,14 +94,16 @@ static void show_pack_info(struct packed_git *p)
 	memset(chain_histogram, 0, sizeof(chain_histogram));
 
 	for (i = 0; i < nr_objects; i++) {
-		unsigned char sha1[20], base_sha1[20];
+		const unsigned char *sha1;
+		unsigned char base_sha1[20];
 		char type[20];
 		unsigned long size;
 		unsigned long store_size;
 		unsigned long offset;
 		unsigned int delta_chain_length;
 
-		if (nth_packed_object_sha1(p, i, sha1))
+		sha1 = nth_packed_object_sha1(p, i);
+		if (!sha1)
 			die("internal error pack-check nth-packed-object");
 		offset = find_pack_entry_one(sha1, p);
 		if (!offset)
diff --git a/sha1_file.c b/sha1_file.c
index df31462..b4c5209 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1177,15 +1177,14 @@ int num_packed_objects(const struct packed_git *p)
 	return (p->index_size - 20 - 20 - 4*256) / 24;
 }
 
-int nth_packed_object_sha1(const struct packed_git *p, int n,
-			   unsigned char* sha1)
+const unsigned char *nth_packed_object_sha1(const struct packed_git *p,
+					    unsigned int n)
 {
 	const unsigned char *index = p->index_data;
 	index += 4 * 256;
-	if (n < 0 || num_packed_objects(p) <= n)
-		return -1;
-	hashcpy(sha1, index + 24 * n + 4);
-	return 0;
+	if (num_packed_objects(p) <= n)
+		return NULL;
+	return index + 24 * n + 4;
 }
 
 unsigned long find_pack_entry_one(const unsigned char *sha1,
diff --git a/sha1_name.c b/sha1_name.c
index 6d7cd78..d083096 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -71,7 +71,7 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 static int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
 {
 	struct packed_git *p;
-	unsigned char found_sha1[20];
+	const unsigned char *found_sha1 = NULL;
 	int found = 0;
 
 	prepare_packed_git();
@@ -80,10 +80,10 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 		unsigned first = 0, last = num;
 		while (first < last) {
 			unsigned mid = (first + last) / 2;
-			unsigned char now[20];
+			const unsigned char *now;
 			int cmp;
 
-			nth_packed_object_sha1(p, mid, now);
+			now = nth_packed_object_sha1(p, mid);
 			cmp = hashcmp(match, now);
 			if (!cmp) {
 				first = mid;
@@ -96,14 +96,14 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 			last = mid;
 		}
 		if (first < num) {
-			unsigned char now[20], next[20];
-			nth_packed_object_sha1(p, first, now);
+			const unsigned char *now, *next;
+		       now = nth_packed_object_sha1(p, first);
 			if (match_sha(len, match, now)) {
-				if (nth_packed_object_sha1(p, first+1, next) ||
-				    !match_sha(len, match, next)) {
+				next = nth_packed_object_sha1(p, first+1);
+			       if (!next|| !match_sha(len, match, next)) {
 					/* unique within this pack */
 					if (!found) {
-						hashcpy(found_sha1, now);
+						found_sha1 = now;
 						found++;
 					}
 					else if (hashcmp(found_sha1, now)) {
-- 
1.5.6.3.499.geae9
