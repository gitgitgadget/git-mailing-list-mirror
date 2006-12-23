From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/17] Replace unpack_entry_gently with unpack_entry.
Date: Sat, 23 Dec 2006 02:33:25 -0500
Message-ID: <20061223073325.GB9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:33:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Nt-0001lG-Jl
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWLWHd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWLWHd3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:33:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38728 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbWLWHd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:33:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1NP-00035N-0x; Sat, 23 Dec 2006 02:33:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AC3FD20FB65; Sat, 23 Dec 2006 02:33:25 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35280>

The unpack_entry_gently function currently has only two callers:
the delta base resolution in sha1_file.c and the main loop of
pack-check.c.  Both of these must change to using unpack_entry
directly when we implement sliding window mmap logic, so I'm doing
it earlier to help break down the change set.

This may cause a slight performance decrease for delta base
resolution as well as for pack-check.c's verify_packfile(), as
the pack use counter will be incremented and decremented for every
object that is unpacked.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h      |    2 +-
 pack-check.c |    2 +-
 sha1_file.c  |   33 ++++++++++++---------------------
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index 4943056..38db1bf 100644
--- a/cache.h
+++ b/cache.h
@@ -394,7 +394,7 @@ extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
 extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
-extern void *unpack_entry_gently(struct packed_git *, unsigned long, char *, unsigned long *);
+extern void *unpack_entry(struct packed_git *, unsigned long, char *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern void packed_object_info_detail(struct packed_git *, unsigned long, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
diff --git a/pack-check.c b/pack-check.c
index c0caaee..491bad2 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -51,7 +51,7 @@ static int verify_packfile(struct packed_git *p)
 		offset = find_pack_entry_one(sha1, p);
 		if (!offset)
 			die("internal error pack-check find-pack-entry-one");
-		data = unpack_entry_gently(p, offset, type, &size);
+		data = unpack_entry(p, offset, type, &size);
 		if (!data) {
 			err = error("cannot unpack %s from %s",
 				    sha1_to_hex(sha1), p->pack_name);
diff --git a/sha1_file.c b/sha1_file.c
index 1c4df5b..4824a5d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1110,7 +1110,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 	unsigned long result_size, base_size, base_offset;
 
 	offset = get_delta_base(p, offset, kind, obj_offset, &base_offset);
-	base = unpack_entry_gently(p, base_offset, type, &base_size);
+	base = unpack_entry(p, base_offset, type, &base_size);
 	if (!base)
 		die("failed to read delta base object at %lu from %s",
 		    base_offset, p->pack_name);
@@ -1127,43 +1127,34 @@ static void *unpack_delta_entry(struct packed_git *p,
 	return result;
 }
 
-static void *unpack_entry(struct pack_entry *entry,
+void *unpack_entry(struct packed_git *p, unsigned long offset,
 			  char *type, unsigned long *sizep)
 {
-	struct packed_git *p = entry->p;
+	unsigned long size, obj_offset = offset;
+	enum object_type kind;
 	void *retval;
 
 	if (use_packed_git(p))
 		die("cannot map packed file");
-	retval = unpack_entry_gently(p, entry->offset, type, sizep);
-	unuse_packed_git(p);
-	if (!retval)
-		die("corrupted pack file %s", p->pack_name);
-	return retval;
-}
-
-/* The caller is responsible for use_packed_git()/unuse_packed_git() pair */
-void *unpack_entry_gently(struct packed_git *p, unsigned long offset,
-			  char *type, unsigned long *sizep)
-{
-	unsigned long size, obj_offset = offset;
-	enum object_type kind;
-
 	offset = unpack_object_header(p, offset, &kind, &size);
 	switch (kind) {
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
-		return unpack_delta_entry(p, offset, size, kind, obj_offset, type, sizep);
+		retval = unpack_delta_entry(p, offset, size, kind, obj_offset, type, sizep);
+		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		strcpy(type, type_names[kind]);
 		*sizep = size;
-		return unpack_compressed_entry(p, offset, size);
+		retval = unpack_compressed_entry(p, offset, size);
+		break;
 	default:
-		return NULL;
+		die("unknown object type %i in %s", kind, p->pack_name);
 	}
+	unuse_packed_git(p);
+	return retval;
 }
 
 int num_packed_objects(const struct packed_git *p)
@@ -1312,7 +1303,7 @@ static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned lo
 		error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 		return NULL;
 	}
-	return unpack_entry(&e, type, size);
+	return unpack_entry(e.p, e.offset, type, size);
 }
 
 void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
-- 
1.4.4.3.g87d8
