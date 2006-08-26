From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 5/5] Convert unpack_entry_gently and friends to use offsets.
Date: Sat, 26 Aug 2006 04:12:27 -0400
Message-ID: <20060826081227.GG22343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 10:12:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGtHO-000362-CR
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 10:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422900AbWHZIMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 04:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWHZIMb
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 04:12:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27329 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964922AbWHZIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 04:12:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGtHG-0007I1-T9; Sat, 26 Aug 2006 04:12:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 32DA920FB7F; Sat, 26 Aug 2006 04:12:27 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26040>

Change unpack_entry_gently and its helper functions to use offsets
rather than addresses and left counts to supply pack position
information.  In most cases this makes the code easier to follow,
and it reduces the number of local variables in a few functions.
It also better prepares this code for mapping partial segments of
packs and altering what regions of a pack are mapped while unpacking
an entry.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e6d47c1..558ec4a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1041,9 +1041,9 @@ static int packed_object_info(struct pac
 	return 0;
 }
 
-static void *unpack_compressed_entry(unsigned char *data,
-				    unsigned long size,
-				    unsigned long left)
+static void *unpack_compressed_entry(struct packed_git *p,
+				    unsigned long offset,
+				    unsigned long size)
 {
 	int st;
 	z_stream stream;
@@ -1052,8 +1052,8 @@ static void *unpack_compressed_entry(uns
 	buffer = xmalloc(size + 1);
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
-	stream.next_in = data;
-	stream.avail_in = left;
+	stream.next_in = (unsigned char*)p->pack_base + offset;
+	stream.avail_in = p->pack_size - offset;
 	stream.next_out = buffer;
 	stream.avail_out = size;
 
@@ -1068,21 +1068,22 @@ static void *unpack_compressed_entry(uns
 	return buffer;
 }
 
-static void *unpack_delta_entry(unsigned char *base_sha1,
+static void *unpack_delta_entry(struct packed_git *p,
+				unsigned long offset,
 				unsigned long delta_size,
-				unsigned long left,
 				char *type,
-				unsigned long *sizep,
-				struct packed_git *p)
+				unsigned long *sizep)
 {
 	struct pack_entry base_ent;
 	void *delta_data, *result, *base;
 	unsigned long result_size, base_size;
+	unsigned char* base_sha1;
 
-	if (left < 20)
+	if ((offset + 20) >= p->pack_size)
 		die("truncated pack file");
 
 	/* The base entry _must_ be in the same pack */
+	base_sha1 = (unsigned char*)p->pack_base + offset;
 	if (!find_pack_entry_one(base_sha1, &base_ent, p))
 		die("failed to find delta-pack base object %s",
 		    sha1_to_hex(base_sha1));
@@ -1091,8 +1092,7 @@ static void *unpack_delta_entry(unsigned
 		die("failed to read delta-pack base object %s",
 		    sha1_to_hex(base_sha1));
 
-	delta_data = unpack_compressed_entry(base_sha1 + 20,
-			     delta_size, left - 20);
+	delta_data = unpack_compressed_entry(p, offset + 20, delta_size);
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
 			     &result_size);
@@ -1124,23 +1124,20 @@ void *unpack_entry_gently(struct pack_en
 			  char *type, unsigned long *sizep)
 {
 	struct packed_git *p = entry->p;
-	unsigned long offset, size, left;
-	unsigned char *pack;
+	unsigned long offset, size;
 	enum object_type kind;
 
 	offset = unpack_object_header(p, entry->offset, &kind, &size);
-	pack = (unsigned char *) p->pack_base + offset;
-	left = p->pack_size - offset;
 	switch (kind) {
 	case OBJ_DELTA:
-		return unpack_delta_entry(pack, size, left, type, sizep, p);
+		return unpack_delta_entry(p, offset, size, type, sizep);
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		strcpy(type, type_names[kind]);
 		*sizep = size;
-		return unpack_compressed_entry(pack, size, left);
+		return unpack_compressed_entry(p, offset, size);
 	default:
 		return NULL;
 	}
-- 
1.4.2.g6580
