From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/6] teach git-index-pack about deltas with offset to base
Date: Thu, 21 Sep 2006 00:08:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609210007430.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 06:08:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQFra-0006xO-PF
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 06:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWIUEIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 00:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWIUEIf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 00:08:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50153 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751198AbWIUEIe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 00:08:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5X007XNCU9T700@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 00:08:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27447>


Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/index-pack.c b/index-pack.c
index aef7f0a..fffddd2 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -18,10 +18,15 @@ struct object_entry
 	unsigned char sha1[20];
 };
 
+union delta_base {
+	unsigned char sha1[20];
+	unsigned long offset;
+};
+
 struct delta_entry
 {
 	struct object_entry *obj;
-	unsigned char base_sha1[20];
+	union delta_base base;
 };
 
 static const char *pack_name;
@@ -134,13 +139,13 @@ static void *unpack_entry_data(unsigned 
 static void *unpack_raw_entry(unsigned long offset,
 			      enum object_type *obj_type,
 			      unsigned long *obj_size,
-			      unsigned char *delta_base,
+			      union delta_base *delta_base,
 			      unsigned long *next_obj_offset)
 {
 	unsigned long pack_limit = pack_size - 20;
 	unsigned long pos = offset;
 	unsigned char c;
-	unsigned long size;
+	unsigned long size, base_offset;
 	unsigned shift;
 	enum object_type type;
 	void *data;
@@ -161,26 +166,43 @@ static void *unpack_raw_entry(unsigned l
 	case OBJ_REF_DELTA:
 		if (pos + 20 >= pack_limit)
 			bad_object(offset, "object extends past end of pack");
-		hashcpy(delta_base, pack_base + pos);
+		hashcpy(delta_base->sha1, pack_base + pos);
 		pos += 20;
-		/* fallthru */
+		break;
+	case OBJ_OFS_DELTA:
+		memset(delta_base, 0, sizeof(*delta_base));
+		c = pack_base[pos++];
+		base_offset = c & 127;
+		while (c & 128) {
+			base_offset += 1;
+			if (!base_offset || base_offset & ~(~0UL >> 7))
+				bad_object(offset, "offset value overflow for delta base object");
+			if (pos >= pack_limit)
+				bad_object(offset, "object extends past end of pack");
+			c = pack_base[pos++];
+			base_offset = (base_offset << 7) + (c & 127);
+		}
+		delta_base->offset = offset - base_offset;
+		if (delta_base->offset >= offset)
+			bad_object(offset, "delta base offset is out of bound");
+		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		data = unpack_entry_data(offset, &pos, size);
 		break;
 	default:
 		bad_object(offset, "bad object type %d", type);
 	}
 
+	data = unpack_entry_data(offset, &pos, size);
 	*obj_type = type;
 	*obj_size = size;
 	*next_obj_offset = pos;
 	return data;
 }
 
-static int find_delta(const unsigned char *base_sha1)
+static int find_delta(const union delta_base *base)
 {
 	int first = 0, last = nr_deltas;
 
@@ -189,7 +211,7 @@ static int find_delta(const unsigned cha
                 struct delta_entry *delta = &deltas[next];
                 int cmp;
 
-                cmp = hashcmp(base_sha1, delta->base_sha1);
+                cmp = memcmp(base, &delta->base, sizeof(*base));
                 if (!cmp)
                         return next;
                 if (cmp < 0) {
@@ -201,18 +223,18 @@ static int find_delta(const unsigned cha
         return -first-1;
 }
 
-static int find_deltas_based_on_sha1(const unsigned char *base_sha1,
-				     int *first_index, int *last_index)
+static int find_delta_childs(const union delta_base *base,
+			     int *first_index, int *last_index)
 {
-	int first = find_delta(base_sha1);
+	int first = find_delta(base);
 	int last = first;
 	int end = nr_deltas - 1;
 
 	if (first < 0)
 		return -1;
-	while (first > 0 && !hashcmp(deltas[first - 1].base_sha1, base_sha1))
+	while (first > 0 && !memcmp(&deltas[first - 1].base, base, sizeof(*base)))
 		--first;
-	while (last < end && !hashcmp(deltas[last + 1].base_sha1, base_sha1))
+	while (last < end && !memcmp(&deltas[last + 1].base, base, sizeof(*base)))
 		++last;
 	*first_index = first;
 	*last_index = last;
@@ -253,13 +275,13 @@ static void resolve_delta(struct delta_e
 	void *result;
 	unsigned long result_size;
 	enum object_type delta_type;
-	unsigned char base_sha1[20];
+	union delta_base delta_base;
 	unsigned long next_obj_offset;
 	int j, first, last;
 
 	obj->real_type = type;
 	delta_data = unpack_raw_entry(obj->offset, &delta_type,
-				      &delta_size, base_sha1,
+				      &delta_size, &delta_base,
 				      &next_obj_offset);
 	result = patch_delta(base_data, base_size, delta_data, delta_size,
 			     &result_size);
@@ -267,10 +289,22 @@ static void resolve_delta(struct delta_e
 	if (!result)
 		bad_object(obj->offset, "failed to apply delta");
 	sha1_object(result, result_size, type, obj->sha1);
-	if (!find_deltas_based_on_sha1(obj->sha1, &first, &last)) {
+
+	hashcpy(delta_base.sha1, obj->sha1);
+	if (!find_delta_childs(&delta_base, &first, &last)) {
 		for (j = first; j <= last; j++)
-			resolve_delta(&deltas[j], result, result_size, type);
+			if (deltas[j].obj->type == OBJ_REF_DELTA)
+				resolve_delta(&deltas[j], result, result_size, type);
 	}
+
+	memset(&delta_base, 0, sizeof(delta_base));
+	delta_base.offset = obj->offset;
+	if (!find_delta_childs(&delta_base, &first, &last)) {
+		for (j = first; j <= last; j++)
+			if (deltas[j].obj->type == OBJ_OFS_DELTA)
+				resolve_delta(&deltas[j], result, result_size, type);
+	}
+
 	free(result);
 }
 
@@ -278,14 +312,14 @@ static int compare_delta_entry(const voi
 {
 	const struct delta_entry *delta_a = a;
 	const struct delta_entry *delta_b = b;
-	return hashcmp(delta_a->base_sha1, delta_b->base_sha1);
+	return memcmp(&delta_a->base, &delta_b->base, sizeof(union delta_base));
 }
 
 static void parse_pack_objects(void)
 {
 	int i;
 	unsigned long offset = sizeof(struct pack_header);
-	unsigned char base_sha1[20];
+	struct delta_entry *delta = deltas;
 	void *data;
 	unsigned long data_size;
 
@@ -299,12 +333,12 @@ static void parse_pack_objects(void)
 		struct object_entry *obj = &objects[i];
 		obj->offset = offset;
 		data = unpack_raw_entry(offset, &obj->type, &data_size,
-					base_sha1, &offset);
+					&delta->base, &offset);
 		obj->real_type = obj->type;
-		if (obj->type == OBJ_REF_DELTA) {
-			struct delta_entry *delta = &deltas[nr_deltas++];
+		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
+			nr_deltas++;
 			delta->obj = obj;
-			hashcpy(delta->base_sha1, base_sha1);
+			delta++;
 		} else
 			sha1_object(data, data_size, obj->type, obj->sha1);
 		free(data);
@@ -312,7 +346,7 @@ static void parse_pack_objects(void)
 	if (offset != pack_size - 20)
 		die("packfile '%s' has junk at the end", pack_name);
 
-	/* Sort deltas by base SHA1 for fast searching */
+	/* Sort deltas by base SHA1/offset for fast searching */
 	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
 	      compare_delta_entry);
 
@@ -326,22 +360,37 @@ static void parse_pack_objects(void)
 	 */
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
-		int j, first, last;
+		union delta_base base;
+		int j, ref, ref_first, ref_last, ofs, ofs_first, ofs_last;
 
-		if (obj->type == OBJ_REF_DELTA)
+		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
 			continue;
-		if (find_deltas_based_on_sha1(obj->sha1, &first, &last))
+		hashcpy(base.sha1, obj->sha1);
+		ref = !find_delta_childs(&base, &ref_first, &ref_last);
+		memset(&base, 0, sizeof(base));
+		base.offset = obj->offset;
+		ofs = !find_delta_childs(&base, &ofs_first, &ofs_last);
+		if (!ref && !ofs)
 			continue;
 		data = unpack_raw_entry(obj->offset, &obj->type, &data_size,
-					base_sha1, &offset);
-		for (j = first; j <= last; j++)
-			resolve_delta(&deltas[j], data, data_size, obj->type);
+					&base, &offset);
+		if (ref)
+			for (j = ref_first; j <= ref_last; j++)
+				if (deltas[j].obj->type == OBJ_REF_DELTA)
+					resolve_delta(&deltas[j], data,
+						      data_size, obj->type);
+		if (ofs)
+			for (j = ofs_first; j <= ofs_last; j++)
+				if (deltas[j].obj->type == OBJ_OFS_DELTA)
+					resolve_delta(&deltas[j], data,
+						      data_size, obj->type);
 		free(data);
 	}
 
 	/* Check for unresolved deltas */
 	for (i = 0; i < nr_deltas; i++) {
-		if (deltas[i].obj->real_type == OBJ_REF_DELTA)
+		if (deltas[i].obj->real_type == OBJ_REF_DELTA ||
+		    deltas[i].obj->real_type == OBJ_OFS_DELTA)
 			die("packfile '%s' has unresolved deltas",  pack_name);
 	}
 }
