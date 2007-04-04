From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] clean up and optimize nth_packed_object_sha1() usage
Date: Wed, 04 Apr 2007 16:49:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704041639070.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 22:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZCQi-0001Fh-Bl
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 22:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbXDDUtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 16:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbXDDUtK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 16:49:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33792 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbXDDUtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 16:49:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFZ00EYHR5SFMF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Apr 2007 16:49:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43775>

Let's avoid the open coded pack index reference in pack-object and use 
nth_packed_object_sha1() instead.  This will help encapsulating index
format differences in one place.

And while at it there is no reason to copy SHA1's over and over while a 
direct pointer to it in the index will do just fine.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 21f1f9e..4e5aa33 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -348,7 +348,7 @@ static int fsck_tag(struct tag *tag)
 	return 0;
 }
 
-static int fsck_sha1(unsigned char *sha1)
+static int fsck_sha1(const unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
 	if (!obj) {
@@ -648,11 +648,8 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 
 		for (p = packed_git; p; p = p->next) {
 			uint32_t i, num = num_packed_objects(p);
-			for (i = 0; i < num; i++) {
-				unsigned char sha1[20];
-				nth_packed_object_sha1(p, i, sha1);
-				fsck_sha1(sha1);
-			}
+			for (i = 0; i < num; i++)
+				fsck_sha1(nth_packed_object_sha1(p, i));
 		}
 	}
 
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b5f9648..45ac3e4 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -222,7 +222,7 @@ static const unsigned char *find_packed_object_name(struct packed_git *p,
 						    off_t ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
-	return ((unsigned char *)p->index_data) + 4 * 256 + 24 * entry->nr + 4;
+	return nth_packed_object_sha1(p, entry->nr);
 }
 
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
diff --git a/cache.h b/cache.h
index 7199430..710554f 100644
--- a/cache.h
+++ b/cache.h
@@ -435,7 +435,7 @@ extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern uint32_t num_packed_objects(const struct packed_git *p);
-extern int nth_packed_object_sha1(const struct packed_git *, uint32_t, unsigned char*);
+extern const unsigned char *nth_packed_object_sha1(const struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/pack-check.c b/pack-check.c
index d988322..f58083d 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -42,13 +42,14 @@ static int verify_packfile(struct packed_git *p,
 	 */
 	nr_objects = num_packed_objects(p);
 	for (i = 0, err = 0; i < nr_objects; i++) {
-		unsigned char sha1[20];
+		const unsigned char *sha1;
 		void *data;
 		enum object_type type;
 		unsigned long size;
 		off_t offset;
 
-		if (nth_packed_object_sha1(p, i, sha1))
+		sha1 = nth_packed_object_sha1(p, i);
+		if (!sha1)
 			die("internal error pack-check nth-packed-object");
 		offset = find_pack_entry_one(sha1, p);
 		if (!offset)
@@ -82,14 +83,16 @@ static void show_pack_info(struct packed_git *p)
 	memset(chain_histogram, 0, sizeof(chain_histogram));
 
 	for (i = 0; i < nr_objects; i++) {
-		unsigned char sha1[20], base_sha1[20];
+		const unsigned char *sha1;
+		unsigned char base_sha1[20];
 		const char *type;
 		unsigned long size;
 		unsigned long store_size;
 		off_t offset;
 		unsigned int delta_chain_length;
 
-		if (nth_packed_object_sha1(p, i, sha1))
+		sha1 = nth_packed_object_sha1(p, i);
+		if (!sha1)
 			die("internal error pack-check nth-packed-object");
 		offset = find_pack_entry_one(sha1, p);
 		if (!offset)
diff --git a/sha1_file.c b/sha1_file.c
index 9c26038..4304fe9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1532,15 +1532,14 @@ uint32_t num_packed_objects(const struct packed_git *p)
 	return (uint32_t)((p->index_size - 20 - 20 - 4*256) / 24);
 }
 
-int nth_packed_object_sha1(const struct packed_git *p, uint32_t n,
-			   unsigned char* sha1)
+const unsigned char *nth_packed_object_sha1(const struct packed_git *p,
+					    uint32_t n)
 {
 	const unsigned char *index = p->index_data;
 	index += 4 * 256;
 	if (num_packed_objects(p) <= n)
-		return -1;
-	hashcpy(sha1, index + 24 * n + 4);
-	return 0;
+		return NULL;
+	return index + 24 * n + 4;
 }
 
 off_t find_pack_entry_one(const unsigned char *sha1,
diff --git a/sha1_name.c b/sha1_name.c
index bede0e5..267ea3f 100644
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
 		uint32_t first = 0, last = num;
 		while (first < last) {
 			uint32_t mid = (first + last) / 2;
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
