From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/6] sha1_file.c: cleanup "offset" usage
Date: Mon, 26 Feb 2007 14:55:56 -0500
Message-ID: <11725197613482-git-send-email-nico@cam.org>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlxZ-0004Dt-P8
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbXBZT4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbXBZT4H
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:56:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030496AbXBZT4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:56:04 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3007SW61CD1Q1@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 14:56:02 -0500 (EST)
In-reply-to: <1172519760216-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.572.ge86d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40654>

First there are too many offsets there and it is getting confusing.
So 'offset' is now 'curpos' to distinguish from other offsets like
'obj_offset'.

Then structures like x = foo(x, &y) are now done as y = foo(&x).
It looks more natural that the result y be returned directly and
x be passed as reference to be updated in place.  This has the effect
of reducing some line length and removing a few, needing a bit less
stack space, and it even reduces the compiled code size.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |  110 +++++++++++++++++++++++++++-------------------------------
 1 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 57a9b53..8147a4f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1043,12 +1043,11 @@ void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned l
 
 static unsigned long get_delta_base(struct packed_git *p,
 				    struct pack_window **w_curs,
-				    unsigned long offset,
+				    unsigned long *curpos,
 				    enum object_type kind,
-				    unsigned long delta_obj_offset,
-				    unsigned long *base_obj_offset)
+				    unsigned long delta_obj_offset)
 {
-	unsigned char *base_info = use_pack(p, w_curs, offset, NULL);
+	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
 	unsigned long base_offset;
 
 	/* use_pack() assured us we have [base_info, base_info + 20)
@@ -1071,18 +1070,17 @@ static unsigned long get_delta_base(struct packed_git *p,
 		base_offset = delta_obj_offset - base_offset;
 		if (base_offset >= delta_obj_offset)
 			die("delta base offset out of bound");
-		offset += used;
+		*curpos += used;
 	} else if (kind == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset = find_pack_entry_one(base_info, p);
 		if (!base_offset)
 			die("failed to find delta-pack base object %s",
 				sha1_to_hex(base_info));
-		offset += 20;
+		*curpos += 20;
 	} else
 		die("I am totally screwed");
-	*base_obj_offset = base_offset;
-	return offset;
+	return base_offset;
 }
 
 /* forward declaration for a mutually recursive function */
@@ -1091,7 +1089,7 @@ static int packed_object_info(struct packed_git *p, unsigned long offset,
 
 static int packed_delta_info(struct packed_git *p,
 			     struct pack_window **w_curs,
-			     unsigned long offset,
+			     unsigned long curpos,
 			     enum object_type kind,
 			     unsigned long obj_offset,
 			     char *type,
@@ -1099,8 +1097,7 @@ static int packed_delta_info(struct packed_git *p,
 {
 	unsigned long base_offset;
 
-	offset = get_delta_base(p, w_curs, offset, kind,
-		obj_offset, &base_offset);
+	base_offset = get_delta_base(p, w_curs, &curpos, kind, obj_offset);
 
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
@@ -1113,7 +1110,6 @@ static int packed_delta_info(struct packed_git *p,
 	if (sizep) {
 		const unsigned char *data;
 		unsigned char delta_head[20], *in;
-		unsigned long result_size;
 		z_stream stream;
 		int st;
 
@@ -1123,10 +1119,10 @@ static int packed_delta_info(struct packed_git *p,
 
 		inflateInit(&stream);
 		do {
-			in = use_pack(p, w_curs, offset, &stream.avail_in);
+			in = use_pack(p, w_curs, curpos, &stream.avail_in);
 			stream.next_in = in;
 			st = inflate(&stream, Z_FINISH);
-			offset += stream.next_in - in;
+			curpos += stream.next_in - in;
 		} while ((st == Z_OK || st == Z_BUF_ERROR)
 			&& stream.total_out < sizeof(delta_head));
 		inflateEnd(&stream);
@@ -1143,21 +1139,20 @@ static int packed_delta_info(struct packed_git *p,
 		get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 
 		/* Read the result size */
-		result_size = get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
-		*sizep = result_size;
+		*sizep = get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 	}
 	return 0;
 }
 
-static unsigned long unpack_object_header(struct packed_git *p,
-		struct pack_window **w_curs,
-		unsigned long offset,
-		enum object_type *type,
-		unsigned long *sizep)
+static int unpack_object_header(struct packed_git *p,
+				struct pack_window **w_curs,
+				unsigned long *curpos,
+				unsigned long *sizep)
 {
 	unsigned char *base;
 	unsigned int left;
 	unsigned long used;
+	enum object_type type;
 
 	/* use_pack() assures us we have [base, base + 20) available
 	 * as a range that we can look at at.  (Its actually the hash
@@ -1165,16 +1160,17 @@ static unsigned long unpack_object_header(struct packed_git *p,
 	 * the maximum deflated object size is 2^137, which is just
 	 * insane, so we know won't exceed what we have been given.
 	 */
-	base = use_pack(p, w_curs, offset, &left);
-	used = unpack_object_header_gently(base, left, type, sizep);
+	base = use_pack(p, w_curs, *curpos, &left);
+	used = unpack_object_header_gently(base, left, &type, sizep);
 	if (!used)
 		die("object offset outside of pack file");
+	*curpos += used;
 
-	return offset + used;
+	return type;
 }
 
 void packed_object_info_detail(struct packed_git *p,
-			       unsigned long offset,
+			       unsigned long obj_offset,
 			       char *type,
 			       unsigned long *size,
 			       unsigned long *store_size,
@@ -1182,13 +1178,13 @@ void packed_object_info_detail(struct packed_git *p,
 			       unsigned char *base_sha1)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long obj_offset, val;
+	unsigned long curpos, dummy;
 	unsigned char *next_sha1;
 	enum object_type kind;
 
 	*delta_chain_length = 0;
-	obj_offset = offset;
-	offset = unpack_object_header(p, &w_curs, offset, &kind, size);
+	curpos = obj_offset;
+	kind = unpack_object_header(p, &w_curs, &curpos, size);
 
 	for (;;) {
 		switch (kind) {
@@ -1204,61 +1200,58 @@ void packed_object_info_detail(struct packed_git *p,
 			unuse_pack(&w_curs);
 			return;
 		case OBJ_OFS_DELTA:
-			get_delta_base(p, &w_curs, offset, kind,
-				obj_offset, &offset);
+			obj_offset = get_delta_base(p, &w_curs, &curpos, kind, obj_offset);
 			if (*delta_chain_length == 0) {
-				/* TODO: find base_sha1 as pointed by offset */
+				/* TODO: find base_sha1 as pointed by curpos */
 			}
 			break;
 		case OBJ_REF_DELTA:
-			next_sha1 = use_pack(p, &w_curs, offset, NULL);
+			next_sha1 = use_pack(p, &w_curs, curpos, NULL);
 			if (*delta_chain_length == 0)
 				hashcpy(base_sha1, next_sha1);
-			offset = find_pack_entry_one(next_sha1, p);
+			obj_offset = find_pack_entry_one(next_sha1, p);
 			break;
 		}
-		obj_offset = offset;
-		offset = unpack_object_header(p, &w_curs, offset, &kind, &val);
 		(*delta_chain_length)++;
+		curpos = obj_offset;
+		kind = unpack_object_header(p, &w_curs, &curpos, &dummy);
 	}
 }
 
-static int packed_object_info(struct packed_git *p, unsigned long offset,
+static int packed_object_info(struct packed_git *p, unsigned long obj_offset,
 			      char *type, unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size, obj_offset = offset;
+	unsigned long size, curpos = obj_offset;
 	enum object_type kind;
-	int r;
 
-	offset = unpack_object_header(p, &w_curs, offset, &kind, &size);
+	kind = unpack_object_header(p, &w_curs, &curpos, &size);
 
 	switch (kind) {
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
-		r = packed_delta_info(p, &w_curs, offset, kind,
-			obj_offset, type, sizep);
-		unuse_pack(&w_curs);
-		return r;
+		packed_delta_info(p, &w_curs, curpos, kind,
+				  obj_offset, type, sizep);
+		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		strcpy(type, type_names[kind]);
-		unuse_pack(&w_curs);
+		if (sizep)
+			*sizep = size;
 		break;
 	default:
 		die("pack %s contains unknown object type %d",
 		    p->pack_name, kind);
 	}
-	if (sizep)
-		*sizep = size;
+	unuse_pack(&w_curs);
 	return 0;
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
-				    unsigned long offset,
+				    unsigned long curpos,
 				    unsigned long size)
 {
 	int st;
@@ -1273,10 +1266,10 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 	inflateInit(&stream);
 	do {
-		in = use_pack(p, w_curs, offset, &stream.avail_in);
+		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = inflate(&stream, Z_FINISH);
-		offset += stream.next_in - in;
+		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	inflateEnd(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != size) {
@@ -1289,7 +1282,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 static void *unpack_delta_entry(struct packed_git *p,
 				struct pack_window **w_curs,
-				unsigned long offset,
+				unsigned long curpos,
 				unsigned long delta_size,
 				enum object_type kind,
 				unsigned long obj_offset,
@@ -1299,14 +1292,13 @@ static void *unpack_delta_entry(struct packed_git *p,
 	void *delta_data, *result, *base;
 	unsigned long result_size, base_size, base_offset;
 
-	offset = get_delta_base(p, w_curs, offset, kind,
-		obj_offset, &base_offset);
+	base_offset = get_delta_base(p, w_curs, &curpos, kind, obj_offset);
 	base = unpack_entry(p, base_offset, type, &base_size);
 	if (!base)
 		die("failed to read delta base object at %lu from %s",
 		    base_offset, p->pack_name);
 
-	delta_data = unpack_compressed_entry(p, w_curs, offset, delta_size);
+	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
 			     &result_size);
@@ -1318,19 +1310,19 @@ static void *unpack_delta_entry(struct packed_git *p,
 	return result;
 }
 
-void *unpack_entry(struct packed_git *p, unsigned long offset,
-			  char *type, unsigned long *sizep)
+void *unpack_entry(struct packed_git *p, unsigned long obj_offset,
+		   char *type, unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size, obj_offset = offset;
+	unsigned long size, curpos = obj_offset;
 	enum object_type kind;
 	void *retval;
 
-	offset = unpack_object_header(p, &w_curs, offset, &kind, &size);
+	kind = unpack_object_header(p, &w_curs, &curpos, &size);
 	switch (kind) {
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
-		retval = unpack_delta_entry(p, &w_curs, offset, size,
+		retval = unpack_delta_entry(p, &w_curs, curpos, size,
 			kind, obj_offset, type, sizep);
 		break;
 	case OBJ_COMMIT:
@@ -1339,7 +1331,7 @@ void *unpack_entry(struct packed_git *p, unsigned long offset,
 	case OBJ_TAG:
 		strcpy(type, type_names[kind]);
 		*sizep = size;
-		retval = unpack_compressed_entry(p, &w_curs, offset, size);
+		retval = unpack_compressed_entry(p, &w_curs, curpos, size);
 		break;
 	default:
 		die("unknown object type %i in %s", kind, p->pack_name);
-- 
1.5.0.572.ge86d
