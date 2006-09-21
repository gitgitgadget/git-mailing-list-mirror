From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/6] introduce delta objects with offset to base
Date: Thu, 21 Sep 2006 00:06:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609210005430.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 06:07:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQFq6-0006iw-Lz
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 06:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWIUEGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 00:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWIUEGw
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 00:06:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16870 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750716AbWIUEGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 00:06:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5X007T7CRDT700@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 00:06:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27445>

This adds a new object, namely OBJ_OFS_DELTA, renames OBJ_DELTA to
OBJ_REF_DELTA to better make the distinction between those two delta
objects, and adds support for the handling of those new delta objects
in sha1_file.c only.

The OBJ_OFS_DELTA contains a relative offset from the delta object's
position in a pack instead of the 20-byte SHA1 reference to identify
the base object.  Since the base is likely to be not so far away, the
relative offset is more likely to have a smaller encoding on average
than an absolute offset.  And for those delta objects the base must
always be stored first because there is no way to know the distance of
later objects when streaming a pack.  Hence this relative offset is
always meant to be negative.

The offset encoding is slightly denser than the one used for object
size -- credits to <linux@horizon.com> (whoever this is) for bringing
it to my attention.

This allows for pack size reduction between 3.2% (Linux-2.6) to over 5%
(linux-historic).  Runtime pack access should be faster too since delta
replay does skip a search in the pack index for each delta in a chain.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 96c069a..c62734a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -232,7 +232,7 @@ static int encode_header(enum object_typ
 	int n = 1;
 	unsigned char c;
 
-	if (type < OBJ_COMMIT || type > OBJ_DELTA)
+	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
 		die("bad type %d", type);
 
 	c = (type << 4) | (size & 15);
@@ -297,7 +297,7 @@ static int revalidate_pack_entry(struct 
 	used = unpack_object_header_gently(data, len, &type, &size);
 	if (!used)
 		return -1;
-	if (type == OBJ_DELTA)
+	if (type == OBJ_REF_DELTA)
 		used += 20; /* skip base object name */
 	data += used;
 	len -= used;
@@ -340,7 +340,7 @@ static unsigned long write_object(struct
 	obj_type = entry->type;
 	if (! entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
-	else if (obj_type == OBJ_DELTA)
+	else if (obj_type == OBJ_REF_DELTA)
 		to_reuse = 1;	/* check_object() decided it for us */
 	else if (obj_type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
@@ -380,7 +380,7 @@ static unsigned long write_object(struct
 		if (entry->delta) {
 			buf = delta_against(buf, size, entry);
 			size = entry->delta_size;
-			obj_type = OBJ_DELTA;
+			obj_type = OBJ_REF_DELTA;
 		}
 		/*
 		 * The object header is a byte of 'type' followed by zero or
@@ -409,11 +409,11 @@ static unsigned long write_object(struct
 		sha1write(f, buf, datalen);
 		unuse_packed_git(p);
 		hdrlen = 0; /* not really */
-		if (obj_type == OBJ_DELTA)
+		if (obj_type == OBJ_REF_DELTA)
 			reused_delta++;
 		reused++;
 	}
-	if (obj_type == OBJ_DELTA)
+	if (obj_type == OBJ_REF_DELTA)
 		written_delta++;
 	written++;
 	return hdrlen + datalen;
@@ -916,7 +916,7 @@ static void check_object(struct object_e
 		 * delta.
 		 */
 		if (!no_reuse_delta &&
-		    entry->in_pack_type == OBJ_DELTA &&
+		    entry->in_pack_type == OBJ_REF_DELTA &&
 		    (base_entry = locate_object_entry(base)) &&
 		    (!base_entry->preferred_base)) {
 
@@ -929,7 +929,7 @@ static void check_object(struct object_e
 			/* uncompressed size of the delta data */
 			entry->size = entry->delta_size = size;
 			entry->delta = base_entry;
-			entry->type = OBJ_DELTA;
+			entry->type = OBJ_REF_DELTA;
 
 			entry->delta_sibling = base_entry->delta_child;
 			base_entry->delta_child = entry;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 4f96bca..c6c6368 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -241,7 +241,7 @@ static void unpack_one(unsigned nr, unsi
 	case OBJ_TAG:
 		unpack_non_delta_entry(type, size);
 		return;
-	case OBJ_DELTA:
+	case OBJ_REF_DELTA:
 		unpack_delta_entry(size);
 		return;
 	default:
diff --git a/cache.h b/cache.h
index 42f13e2..7ecab65 100644
--- a/cache.h
+++ b/cache.h
@@ -273,8 +273,9 @@ enum object_type {
 	OBJ_TREE = 2,
 	OBJ_BLOB = 3,
 	OBJ_TAG = 4,
-	/* 5/6 for future expansion */
-	OBJ_DELTA = 7,
+	/* 5 for future expansion */
+	OBJ_OFS_DELTA = 6,
+	OBJ_REF_DELTA = 7,
 	OBJ_BAD,
 };
 
diff --git a/index-pack.c b/index-pack.c
index 80bc6cb..aef7f0a 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -158,7 +158,7 @@ static void *unpack_raw_entry(unsigned l
 	}
 
 	switch (type) {
-	case OBJ_DELTA:
+	case OBJ_REF_DELTA:
 		if (pos + 20 >= pack_limit)
 			bad_object(offset, "object extends past end of pack");
 		hashcpy(delta_base, pack_base + pos);
@@ -301,7 +301,7 @@ static void parse_pack_objects(void)
 		data = unpack_raw_entry(offset, &obj->type, &data_size,
 					base_sha1, &offset);
 		obj->real_type = obj->type;
-		if (obj->type == OBJ_DELTA) {
+		if (obj->type == OBJ_REF_DELTA) {
 			struct delta_entry *delta = &deltas[nr_deltas++];
 			delta->obj = obj;
 			hashcpy(delta->base_sha1, base_sha1);
@@ -328,7 +328,7 @@ static void parse_pack_objects(void)
 		struct object_entry *obj = &objects[i];
 		int j, first, last;
 
-		if (obj->type == OBJ_DELTA)
+		if (obj->type == OBJ_REF_DELTA)
 			continue;
 		if (find_deltas_based_on_sha1(obj->sha1, &first, &last))
 			continue;
@@ -341,7 +341,7 @@ static void parse_pack_objects(void)
 
 	/* Check for unresolved deltas */
 	for (i = 0; i < nr_deltas; i++) {
-		if (deltas[i].obj->real_type == OBJ_DELTA)
+		if (deltas[i].obj->real_type == OBJ_REF_DELTA)
 			die("packfile '%s' has unresolved deltas",  pack_name);
 	}
 }
diff --git a/sha1_file.c b/sha1_file.c
index 6fae766..66ebdde 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -887,26 +887,61 @@ void * unpack_sha1_file(void *map, unsig
 	return unpack_sha1_rest(&stream, hdr, *size);
 }
 
+static unsigned long get_delta_base(struct packed_git *p,
+				    unsigned long offset,
+				    enum object_type kind,
+				    unsigned long delta_obj_offset,
+				    unsigned long *base_obj_offset)
+{
+	unsigned char *base_info = (unsigned char *) p->pack_base + offset;
+	unsigned long base_offset;
+
+	/* there must be at least 20 bytes left regardless of delta type */
+	if (p->pack_size <= offset + 20)
+		die("truncated pack file");
+
+	if (kind == OBJ_OFS_DELTA) {
+		unsigned used = 0;
+		unsigned char c = base_info[used++];
+		base_offset = c & 127;
+		while (c & 128) {
+			base_offset += 1;
+			if (!base_offset || base_offset & ~(~0UL >> 7))
+				die("offset value overflow for delta base object");
+			c = base_info[used++];
+			base_offset = (base_offset << 7) + (c & 127);
+		}
+		base_offset = delta_obj_offset - base_offset;
+		if (base_offset >= delta_obj_offset)
+			die("delta base offset out of bound");
+		offset += used;
+	} else if (kind == OBJ_REF_DELTA) {
+		/* The base entry _must_ be in the same pack */
+		base_offset = find_pack_entry_one(base_info, p);
+		if (!base_offset)
+			die("failed to find delta-pack base object %s",
+				sha1_to_hex(base_info));
+		offset += 20;
+	} else
+		die("I am totally screwed");
+	*base_obj_offset = base_offset;
+	return offset;
+}
+
 /* forward declaration for a mutually recursive function */
 static int packed_object_info(struct packed_git *p, unsigned long offset,
 			      char *type, unsigned long *sizep);
 
 static int packed_delta_info(struct packed_git *p,
 			     unsigned long offset,
+			     enum object_type kind,
+			     unsigned long obj_offset,
 			     char *type,
 			     unsigned long *sizep)
 {
 	unsigned long base_offset;
-	unsigned char *base_sha1 = (unsigned char *) p->pack_base + offset;
 
-	if (p->pack_size < offset + 20)
-		die("truncated pack file");
-	/* The base entry _must_ be in the same pack */
-	base_offset = find_pack_entry_one(base_sha1, p);
-	if (!base_offset)
-		die("failed to find delta-pack base object %s",
-		    sha1_to_hex(base_sha1));
-	offset += 20;
+	offset = get_delta_base(p, offset, kind, obj_offset, &base_offset);
 
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
@@ -979,7 +1014,7 @@ int check_reuse_pack_delta(struct packed
 	use_packed_git(p);
 	ptr = offset;
 	ptr = unpack_object_header(p, ptr, kindp, sizep);
-	if (*kindp != OBJ_DELTA)
+	if (*kindp != OBJ_REF_DELTA)
 		goto done;
 	hashcpy(base, (unsigned char *) p->pack_base + ptr);
 	status = 0;
@@ -996,11 +1031,12 @@ void packed_object_info_detail(struct pa
 			       unsigned int *delta_chain_length,
 			       unsigned char *base_sha1)
 {
-	unsigned long val;
+	unsigned long obj_offset, val;
 	unsigned char *next_sha1;
 	enum object_type kind;
 
 	*delta_chain_length = 0;
+	obj_offset = offset;
 	offset = unpack_object_header(p, offset, &kind, size);
 
 	for (;;) {
@@ -1015,7 +1051,13 @@ void packed_object_info_detail(struct pa
 			strcpy(type, type_names[kind]);
 			*store_size = 0; /* notyet */
 			return;
-		case OBJ_DELTA:
+		case OBJ_OFS_DELTA:
+			get_delta_base(p, offset, kind, obj_offset, &offset);
+			if (*delta_chain_length == 0) {
+				/* TODO: find base_sha1 as pointed by offset */
+			}
+			break;
+		case OBJ_REF_DELTA:
 			if (p->pack_size <= offset + 20)
 				die("pack file %s records an incomplete delta base",
 			    	    p->pack_name);
@@ -1025,6 +1067,7 @@ void packed_object_info_detail(struct pa
 			offset = find_pack_entry_one(next_sha1, p);
 			break;
 		}
+		obj_offset = offset;
 		offset = unpack_object_header(p, offset, &kind, &val);
 		(*delta_chain_length)++;
 	}
@@ -1033,15 +1076,15 @@ void packed_object_info_detail(struct pa
 static int packed_object_info(struct packed_git *p, unsigned long offset,
 			      char *type, unsigned long *sizep)
 {
-	unsigned long size;
+	unsigned long size, obj_offset = offset;
 	enum object_type kind;
 
 	offset = unpack_object_header(p, offset, &kind, &size);
 
-	if (kind == OBJ_DELTA)
-		return packed_delta_info(p, offset, type, sizep);
-
 	switch (kind) {
+	case OBJ_OFS_DELTA:
+	case OBJ_REF_DELTA:
+		return packed_delta_info(p, offset, kind, obj_offset, type, sizep);
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
@@ -1087,23 +1130,15 @@ static void *unpack_compressed_entry(str
 static void *unpack_delta_entry(struct packed_git *p,
 				unsigned long offset,
 				unsigned long delta_size,
+				enum object_type kind,
+				unsigned long obj_offset,
 				char *type,
 				unsigned long *sizep)
 {
 	void *delta_data, *result, *base;
 	unsigned long result_size, base_size, base_offset;
-	unsigned char *base_sha1;
-
-	if (p->pack_size < offset + 20)
-		die("truncated pack file");
-	/* The base entry _must_ be in the same pack */
-	base_sha1 = (unsigned char*)p->pack_base + offset;
-	base_offset = find_pack_entry_one(base_sha1, p);
-	if (!base_offset)
-		die("failed to find delta-pack base object %s",
-		    sha1_to_hex(base_sha1));
-	offset += 20;
 
+	offset = get_delta_base(p, offset, kind, obj_offset, &base_offset);
 	base = unpack_entry_gently(p, base_offset, type, &base_size);
 	if (!base)
 		die("failed to read delta base object at %lu from %s",
@@ -1140,13 +1175,14 @@ static void *unpack_entry(struct pack_en
 void *unpack_entry_gently(struct packed_git *p, unsigned long offset,
 			  char *type, unsigned long *sizep)
 {
-	unsigned long size;
+	unsigned long size, obj_offset = offset;
 	enum object_type kind;
 
 	offset = unpack_object_header(p, offset, &kind, &size);
 	switch (kind) {
-	case OBJ_DELTA:
-		return unpack_delta_entry(p, offset, size, type, sizep);
+	case OBJ_OFS_DELTA:
+	case OBJ_REF_DELTA:
+		return unpack_delta_entry(p, offset, size, kind, obj_offset, type, sizep);
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
