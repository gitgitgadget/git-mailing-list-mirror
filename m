From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Show more details of packfile with verify-pack -v.
Date: Thu, 30 Jun 2005 17:17:20 -0700
Message-ID: <7virzvz8fj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 02:10:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do96o-0006IT-Iy
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 02:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbVGAARs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 20:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVGAARs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 20:17:48 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62855 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263134AbVGAARX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 20:17:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050701001720.NHLE8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 20:17:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This implements show_pack_info() function used in verify-pack
command when -v flag is used to obtain something like
unpack-objects used to give when it was first written.

It shows the following for each non-deltified object found in
the pack:

    SHA1 type size offset

For deltified objects, it shows this instead:

    SHA1 type size offset depth base_sha1

In order to get the output in the order that appear in the pack
file for debugging purposes, you can do this:

 $ git-verify-pack -v packfile | sort -n -k 4,4

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h      |    1 +
 pack-check.c |   33 ++++++++++++++++++++++++++++++++-
 sha1_file.c  |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletions(-)

c45c7e2f7d1718a156cef21630940e6be0e75d18
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -266,5 +266,6 @@ extern int num_packed_objects(const stru
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
 extern int find_pack_entry_one(const unsigned char *, struct pack_entry *, struct packed_git *);
 extern void *unpack_entry_gently(struct pack_entry *, char *, unsigned long *);
+extern void packed_object_info_detail(struct pack_entry *, char *, unsigned long *, unsigned long *, int *, unsigned char *);
 
 #endif /* CACHE_H */
diff --git a/pack-check.c b/pack-check.c
--- a/pack-check.c
+++ b/pack-check.c
@@ -72,7 +72,36 @@ static int verify_packfile(struct packed
 
 static void show_pack_info(struct packed_git *p)
 {
-	/* Next round */
+	struct pack_header *hdr;
+	int nr_objects, i;
+
+	hdr = p->pack_base;
+	nr_objects = ntohl(hdr->hdr_entries);
+
+	for (i = 0; i < nr_objects; i++) {
+		unsigned char sha1[20], base_sha1[20];
+		struct pack_entry e;
+		char type[20];
+		unsigned long size;
+		unsigned long store_size;
+		int delta_chain_length;
+
+		if (nth_packed_object_sha1(p, i, sha1))
+			die("internal error pack-check nth-packed-object");
+		if (!find_pack_entry_one(sha1, &e, p))
+			die("internal error pack-check find-pack-entry-one");
+
+		packed_object_info_detail(&e, type, &size, &store_size,
+					  &delta_chain_length,
+					  base_sha1);
+		printf("%s ", sha1_to_hex(sha1));
+		if (!delta_chain_length)
+			printf("%-6s %lu %u\n", type, size, e.offset);
+		else
+			printf("%-6s %lu %u %d %s\n", type, size, e.offset,
+			       delta_chain_length, sha1_to_hex(base_sha1));
+	}
+
 }
 
 int verify_pack(struct packed_git *p, int verbose)
@@ -103,7 +132,9 @@ int verify_pack(struct packed_git *p, in
 		if (ret)
 			printf("%s: bad\n", p->pack_name);
 		else {
+			use_packed_git(p);
 			show_pack_info(p);
+			unuse_packed_git(p);
 			printf("%s: ok\n", p->pack_name);
 		}
 	}
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -704,6 +704,57 @@ static unsigned long unpack_object_heade
 	return offset;
 }
 
+void packed_object_info_detail(struct pack_entry *e,
+			       char *type,
+			       unsigned long *size,
+			       unsigned long *store_size,
+			       int *delta_chain_length,
+			       unsigned char *base_sha1)
+{
+	struct packed_git *p = e->p;
+	unsigned long offset, left;
+	unsigned char *pack;
+	enum object_type kind;
+
+	offset = unpack_object_header(p, e->offset, &kind, size);
+	pack = p->pack_base + offset;
+	left = p->pack_size - offset;
+	if (kind != OBJ_DELTA)
+		*delta_chain_length = 0;
+	else {
+		int chain_length = 0;
+		memcpy(base_sha1, pack, 20);
+		do {
+			struct pack_entry base_ent;
+			unsigned long junk;
+
+			find_pack_entry_one(pack, &base_ent, p);
+			offset = unpack_object_header(p, base_ent.offset,
+						      &kind, &junk);
+			pack = p->pack_base + offset;
+			chain_length++;
+		} while (kind == OBJ_DELTA);
+		*delta_chain_length = chain_length;
+	}
+	switch (kind) {
+	case OBJ_COMMIT:
+		strcpy(type, "commit");
+		break;
+	case OBJ_TREE:
+		strcpy(type, "tree");
+		break;
+	case OBJ_BLOB:
+		strcpy(type, "blob");
+		break;
+	case OBJ_TAG:
+		strcpy(type, "tag");
+		break;
+	default:
+		die("corrupted pack file");
+	}
+	*store_size = 0; /* notyet */
+}
+
 static int packed_object_info(struct pack_entry *entry,
 			      char *type, unsigned long *sizep)
 {
------------
