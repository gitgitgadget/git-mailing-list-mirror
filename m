From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/6] many cleanups to sha1_file.c
Date: Thu, 21 Sep 2006 00:05:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609210004550.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 06:05:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQFox-0006Z1-Gy
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 06:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWIUEFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 00:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWIUEFl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 00:05:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54243 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751204AbWIUEFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 00:05:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5X007PYCPDT700@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 00:05:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27444>

Those cleanups are mainly to set the table for the support of deltas
with base objects referenced by offsets instead of sha1.  This means
that many pack lookup functions are converted to take a pack/offset
tuple instead of a sha1.

This eliminates many struct pack_entry usages since this structure
carried redundent information in many cases, and it increased stack
footprint needlessly for a couple recursively called functions that used
to declare a local copy of it for every recursion loop.

In the process, packed_object_info_detail() has been reorganized as well
so to look much saner and more amenable to deltas with offset support.

Finally the appropriate adjustments have been made to functions that
depend on the above changes.  But there is no functionality changes yet
simply some code refactoring at this point.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

This patch might look a bit frightening since it touches core code quite
extensively but all those changes must occur at the same time to keep the
code fully functional.  All tests are still passing fine of course.  And
again there should not be any change in behavior with this patch.

This will allow for the new functionalities to be added with a minimum of
changes later on and therefore easier to evaluate.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8d7a120..96c069a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -597,15 +597,15 @@ static int add_object_entry(const unsign
 
 	if (!exclude) {
 		for (p = packed_git; p; p = p->next) {
-			struct pack_entry e;
-			if (find_pack_entry_one(sha1, &e, p)) {
+			unsigned long offset = find_pack_entry_one(sha1, p);
+			if (offset) {
 				if (incremental)
 					return 0;
 				if (local && !p->pack_local)
 					return 0;
 				if (!found_pack) {
-					found_offset = e.offset;
-					found_pack = e.p;
+					found_offset = offset;
+					found_pack = p;
 				}
 			}
 		}
diff --git a/cache.h b/cache.h
index 282eed6..42f13e2 100644
--- a/cache.h
+++ b/cache.h
@@ -383,10 +383,10 @@ extern void unuse_packed_git(struct pack
 extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
-extern int find_pack_entry_one(const unsigned char *, struct pack_entry *, struct packed_git *);
-extern void *unpack_entry_gently(struct pack_entry *, char *, unsigned long *);
+extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
+extern void *unpack_entry_gently(struct packed_git *, unsigned long, char *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern void packed_object_info_detail(struct pack_entry *, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern void packed_object_info_detail(struct packed_git *, unsigned long, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/pack-check.c b/pack-check.c
index 04c6c00..c0caaee 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -42,16 +42,16 @@ static int verify_packfile(struct packed
 	 */
 	for (i = err = 0; i < nr_objects; i++) {
 		unsigned char sha1[20];
-		struct pack_entry e;
 		void *data;
 		char type[20];
-		unsigned long size;
+		unsigned long size, offset;
 
 		if (nth_packed_object_sha1(p, i, sha1))
 			die("internal error pack-check nth-packed-object");
-		if (!find_pack_entry_one(sha1, &e, p))
+		offset = find_pack_entry_one(sha1, p);
+		if (!offset)
 			die("internal error pack-check find-pack-entry-one");
-		data = unpack_entry_gently(&e, type, &size);
+		data = unpack_entry_gently(p, offset, type, &size);
 		if (!data) {
 			err = error("cannot unpack %s from %s",
 				    sha1_to_hex(sha1), p->pack_name);
@@ -84,25 +84,26 @@ static void show_pack_info(struct packed
 
 	for (i = 0; i < nr_objects; i++) {
 		unsigned char sha1[20], base_sha1[20];
-		struct pack_entry e;
 		char type[20];
 		unsigned long size;
 		unsigned long store_size;
+		unsigned long offset;
 		unsigned int delta_chain_length;
 
 		if (nth_packed_object_sha1(p, i, sha1))
 			die("internal error pack-check nth-packed-object");
-		if (!find_pack_entry_one(sha1, &e, p))
+		offset = find_pack_entry_one(sha1, p);
+		if (!offset)
 			die("internal error pack-check find-pack-entry-one");
 
-		packed_object_info_detail(&e, type, &size, &store_size,
+		packed_object_info_detail(p, offset, type, &size, &store_size,
 					  &delta_chain_length,
 					  base_sha1);
 		printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length)
-			printf("%-6s %lu %u\n", type, size, e.offset);
+			printf("%-6s %lu %lu\n", type, size, offset);
 		else {
-			printf("%-6s %lu %u %u %s\n", type, size, e.offset,
+			printf("%-6s %lu %lu %u %s\n", type, size, offset,
 			       delta_chain_length, sha1_to_hex(base_sha1));
 			if (delta_chain_length < MAX_CHAIN)
 				chain_histogram[delta_chain_length]++;
diff --git a/sha1_file.c b/sha1_file.c
index b89edb9..6fae766 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -888,33 +888,32 @@ void * unpack_sha1_file(void *map, unsig
 }
 
 /* forward declaration for a mutually recursive function */
-static int packed_object_info(struct pack_entry *entry,
+static int packed_object_info(struct packed_git *p, unsigned long offset,
 			      char *type, unsigned long *sizep);
 
-static int packed_delta_info(unsigned char *base_sha1,
-			     unsigned long delta_size,
-			     unsigned long left,
+static int packed_delta_info(struct packed_git *p,
+			     unsigned long offset,
 			     char *type,
-			     unsigned long *sizep,
-			     struct packed_git *p)
+			     unsigned long *sizep)
 {
-	struct pack_entry base_ent;
+	unsigned long base_offset;
+	unsigned char *base_sha1 = (unsigned char *) p->pack_base + offset;
 
-	if (left < 20)
+	if (p->pack_size < offset + 20)
 		die("truncated pack file");
-
 	/* The base entry _must_ be in the same pack */
-	if (!find_pack_entry_one(base_sha1, &base_ent, p))
+	base_offset = find_pack_entry_one(base_sha1, p);
+	if (!base_offset)
 		die("failed to find delta-pack base object %s",
 		    sha1_to_hex(base_sha1));
+	offset += 20;
 
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
 	 * based on a base with a wrong size.  This saves tons of
 	 * inflate() calls.
 	 */
-
-	if (packed_object_info(&base_ent, type, NULL))
+	if (packed_object_info(p, base_offset, type, NULL))
 		die("cannot get info for delta-pack base");
 
 	if (sizep) {
@@ -926,8 +925,8 @@ static int packed_delta_info(unsigned ch
 
 		memset(&stream, 0, sizeof(stream));
 
-		data = stream.next_in = base_sha1 + 20;
-		stream.avail_in = left - 20;
+		data = stream.next_in = (unsigned char *) p->pack_base + offset;;
+		stream.avail_in = p->pack_size - offset;
 		stream.next_out = delta_head;
 		stream.avail_out = sizeof(delta_head);
 
@@ -989,75 +988,60 @@ int check_reuse_pack_delta(struct packed
 	return status;
 }
 
-void packed_object_info_detail(struct pack_entry *e,
+void packed_object_info_detail(struct packed_git *p,
+			       unsigned long offset,
 			       char *type,
 			       unsigned long *size,
 			       unsigned long *store_size,
 			       unsigned int *delta_chain_length,
 			       unsigned char *base_sha1)
 {
-	struct packed_git *p = e->p;
-	unsigned long offset;
-	unsigned char *pack;
+	unsigned long val;
+	unsigned char *next_sha1;
 	enum object_type kind;
 
-	offset = unpack_object_header(p, e->offset, &kind, size);
-	pack = (unsigned char *) p->pack_base + offset;
-	if (kind != OBJ_DELTA)
-		*delta_chain_length = 0;
-	else {
-		unsigned int chain_length = 0;
-		if (p->pack_size <= offset + 20)
-			die("pack file %s records an incomplete delta base",
-			    p->pack_name);
-		hashcpy(base_sha1, pack);
-		do {
-			struct pack_entry base_ent;
-			unsigned long junk;
-
-			find_pack_entry_one(pack, &base_ent, p);
-			offset = unpack_object_header(p, base_ent.offset,
-						      &kind, &junk);
-			pack = (unsigned char *) p->pack_base + offset;
-			chain_length++;
-		} while (kind == OBJ_DELTA);
-		*delta_chain_length = chain_length;
-	}
-	switch (kind) {
-	case OBJ_COMMIT:
-	case OBJ_TREE:
-	case OBJ_BLOB:
-	case OBJ_TAG:
-		strcpy(type, type_names[kind]);
-		break;
-	default:
-		die("corrupted pack file %s containing object of kind %d",
-		    p->pack_name, kind);
+	*delta_chain_length = 0;
+	offset = unpack_object_header(p, offset, &kind, size);
+
+	for (;;) {
+		switch (kind) {
+		default:
+			die("corrupted pack file %s containing object of kind %d",
+		    		p->pack_name, kind);
+		case OBJ_COMMIT:
+		case OBJ_TREE:
+		case OBJ_BLOB:
+		case OBJ_TAG:
+			strcpy(type, type_names[kind]);
+			*store_size = 0; /* notyet */
+			return;
+		case OBJ_DELTA:
+			if (p->pack_size <= offset + 20)
+				die("pack file %s records an incomplete delta base",
+			    	    p->pack_name);
+			next_sha1 = (unsigned char *) p->pack_base + offset;
+			if (*delta_chain_length == 0)
+				hashcpy(base_sha1, next_sha1);
+			offset = find_pack_entry_one(next_sha1, p);
+			break;
+		}
+		offset = unpack_object_header(p, offset, &kind, &val);
+		(*delta_chain_length)++;
 	}
-	*store_size = 0; /* notyet */
 }
 
-static int packed_object_info(struct pack_entry *entry,
+static int packed_object_info(struct packed_git *p, unsigned long offset,
 			      char *type, unsigned long *sizep)
 {
-	struct packed_git *p = entry->p;
-	unsigned long offset, size, left;
-	unsigned char *pack;
+	unsigned long size;
 	enum object_type kind;
-	int retval;
 
-	if (use_packed_git(p))
-		die("cannot map packed file");
+	offset = unpack_object_header(p, offset, &kind, &size);
 
-	offset = unpack_object_header(p, entry->offset, &kind, &size);
-	pack = (unsigned char *) p->pack_base + offset;
-	left = p->pack_size - offset;
+	if (kind == OBJ_DELTA)
+		return packed_delta_info(p, offset, type, sizep);
 
 	switch (kind) {
-	case OBJ_DELTA:
-		retval = packed_delta_info(pack, size, left, type, sizep, p);
-		unuse_packed_git(p);
-		return retval;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
@@ -1070,7 +1054,6 @@ static int packed_object_info(struct pac
 	}
 	if (sizep)
 		*sizep = size;
-	unuse_packed_git(p);
 	return 0;
 }
 
@@ -1107,25 +1090,26 @@ static void *unpack_delta_entry(struct p
 				char *type,
 				unsigned long *sizep)
 {
-	struct pack_entry base_ent;
 	void *delta_data, *result, *base;
-	unsigned long result_size, base_size;
-	unsigned char* base_sha1;
+	unsigned long result_size, base_size, base_offset;
+	unsigned char *base_sha1;
 
-	if ((offset + 20) >= p->pack_size)
+	if (p->pack_size < offset + 20)
 		die("truncated pack file");
-
 	/* The base entry _must_ be in the same pack */
 	base_sha1 = (unsigned char*)p->pack_base + offset;
-	if (!find_pack_entry_one(base_sha1, &base_ent, p))
+	base_offset = find_pack_entry_one(base_sha1, p);
+	if (!base_offset)
 		die("failed to find delta-pack base object %s",
 		    sha1_to_hex(base_sha1));
-	base = unpack_entry_gently(&base_ent, type, &base_size);
+	offset += 20;
+
+	base = unpack_entry_gently(p, base_offset, type, &base_size);
 	if (!base)
-		die("failed to read delta-pack base object %s",
-		    sha1_to_hex(base_sha1));
+		die("failed to read delta base object at %lu from %s",
+		    base_offset, p->pack_name);
 
-	delta_data = unpack_compressed_entry(p, offset + 20, delta_size);
+	delta_data = unpack_compressed_entry(p, offset, delta_size);
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
 			     &result_size);
@@ -1145,7 +1129,7 @@ static void *unpack_entry(struct pack_en
 
 	if (use_packed_git(p))
 		die("cannot map packed file");
-	retval = unpack_entry_gently(entry, type, sizep);
+	retval = unpack_entry_gently(p, entry->offset, type, sizep);
 	unuse_packed_git(p);
 	if (!retval)
 		die("corrupted pack file %s", p->pack_name);
@@ -1153,14 +1137,13 @@ static void *unpack_entry(struct pack_en
 }
 
 /* The caller is responsible for use_packed_git()/unuse_packed_git() pair */
-void *unpack_entry_gently(struct pack_entry *entry,
+void *unpack_entry_gently(struct packed_git *p, unsigned long offset,
 			  char *type, unsigned long *sizep)
 {
-	struct packed_git *p = entry->p;
-	unsigned long offset, size;
+	unsigned long size;
 	enum object_type kind;
 
-	offset = unpack_object_header(p, entry->offset, &kind, &size);
+	offset = unpack_object_header(p, offset, &kind, &size);
 	switch (kind) {
 	case OBJ_DELTA:
 		return unpack_delta_entry(p, offset, size, type, sizep);
@@ -1192,8 +1175,8 @@ int nth_packed_object_sha1(const struct 
 	return 0;
 }
 
-int find_pack_entry_one(const unsigned char *sha1,
-			struct pack_entry *e, struct packed_git *p)
+unsigned long find_pack_entry_one(const unsigned char *sha1,
+				  struct packed_git *p)
 {
 	unsigned int *level1_ofs = p->index_base;
 	int hi = ntohl(level1_ofs[*sha1]);
@@ -1203,12 +1186,8 @@ int find_pack_entry_one(const unsigned c
 	do {
 		int mi = (lo + hi) / 2;
 		int cmp = hashcmp((unsigned char *)index + (24 * mi) + 4, sha1);
-		if (!cmp) {
-			e->offset = ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
-			hashcpy(e->sha1, sha1);
-			e->p = p;
-			return 1;
-		}
+		if (!cmp)
+			return ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
 		if (cmp > 0)
 			hi = mi;
 		else
@@ -1220,6 +1199,8 @@ int find_pack_entry_one(const unsigned c
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
 	struct packed_git *p;
+	unsigned long offset;
+
 	prepare_packed_git();
 
 	for (p = packed_git; p; p = p->next) {
@@ -1231,8 +1212,13 @@ static int find_pack_entry(const unsigne
 			if (*ig)
 				continue;
 		}
-		if (find_pack_entry_one(sha1, e, p))
+		offset = find_pack_entry_one(sha1, p);
+		if (offset) {
+			e->offset = offset;
+			e->p = p;
+			hashcpy(e->sha1, sha1);
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -1241,10 +1227,9 @@ struct packed_git *find_sha1_pack(const 
 				  struct packed_git *packs)
 {
 	struct packed_git *p;
-	struct pack_entry e;
 
 	for (p = packs; p; p = p->next) {
-		if (find_pack_entry_one(sha1, &e, p))
+		if (find_pack_entry_one(sha1, p))
 			return p;
 	}
 	return NULL;
@@ -1263,12 +1248,16 @@ int sha1_object_info(const unsigned char
 	if (!map) {
 		struct pack_entry e;
 
-		if (find_pack_entry(sha1, &e, NULL))
-			return packed_object_info(&e, type, sizep);
-		reprepare_packed_git();
-		if (find_pack_entry(sha1, &e, NULL))
-			return packed_object_info(&e, type, sizep);
-		return error("unable to find %s", sha1_to_hex(sha1));
+		if (!find_pack_entry(sha1, &e, NULL)) {
+			reprepare_packed_git();
+			if (!find_pack_entry(sha1, &e, NULL))
+				return error("unable to find %s", sha1_to_hex(sha1));
+		}
+		if (use_packed_git(e.p))
+			die("cannot map packed file");
+		status = packed_object_info(e.p, e.offset, type, sizep);
+		unuse_packed_git(e.p);
+		return status;
 	}
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
