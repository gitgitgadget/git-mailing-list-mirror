From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/6] teach git-unpack-objects about deltas with offset to base
Date: Thu, 21 Sep 2006 00:07:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609210006520.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 06:07:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQFqp-0006ow-Ay
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 06:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWIUEHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 00:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWIUEHm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 00:07:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48869 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751207AbWIUEHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 00:07:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5X007UTCSRT700@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 00:07:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27446>

For delta resolution to be possible, a list of sha1/offset tupple must
be constructed in memory in order to load the appropriate base object.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index c6c6368..e70a711 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -15,7 +15,7 @@ static const char unpack_usage[] = "git-
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
-static unsigned long offset, len;
+static unsigned long offset, len, consumed_bytes;
 static SHA_CTX ctx;
 
 /*
@@ -51,6 +51,7 @@ static void use(int bytes)
 		die("used more bytes than were available");
 	len -= bytes;
 	offset += bytes;
+	consumed_bytes += bytes;
 }
 
 static void *get_data(unsigned long size)
@@ -89,35 +90,49 @@ static void *get_data(unsigned long size
 
 struct delta_info {
 	unsigned char base_sha1[20];
+	unsigned long base_offset;
 	unsigned long size;
 	void *delta;
+	unsigned nr;
 	struct delta_info *next;
 };
 
 static struct delta_info *delta_list;
 
-static void add_delta_to_list(unsigned char *base_sha1, void *delta, unsigned long size)
+static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
+			      unsigned long base_offset,
+			      void *delta, unsigned long size)
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
 
 	hashcpy(info->base_sha1, base_sha1);
+	info->base_offset = base_offset;
 	info->size = size;
 	info->delta = delta;
+	info->nr = nr;
 	info->next = delta_list;
 	delta_list = info;
 }
 
-static void added_object(unsigned char *sha1, const char *type, void *data, unsigned long size);
+struct obj_info {
+	unsigned long offset;
+	unsigned char sha1[20];
+};
+
+static struct obj_info *obj_list;
 
-static void write_object(void *buf, unsigned long size, const char *type)
+static void added_object(unsigned nr, const char *type, void *data,
+			 unsigned long size);
+
+static void write_object(unsigned nr, void *buf, unsigned long size,
+			 const char *type)
 {
-	unsigned char sha1[20];
-	if (write_sha1_file(buf, size, type, sha1) < 0)
+	if (write_sha1_file(buf, size, type, obj_list[nr].sha1) < 0)
 		die("failed to write object");
-	added_object(sha1, type, buf, size);
+	added_object(nr, type, buf, size);
 }
 
-static void resolve_delta(const char *type,
+static void resolve_delta(unsigned nr, const char *type,
 			  void *base, unsigned long base_size,
 			  void *delta, unsigned long delta_size)
 {
@@ -130,20 +145,23 @@ static void resolve_delta(const char *ty
 	if (!result)
 		die("failed to apply delta");
 	free(delta);
-	write_object(result, result_size, type);
+	write_object(nr, result, result_size, type);
 	free(result);
 }
 
-static void added_object(unsigned char *sha1, const char *type, void *data, unsigned long size)
+static void added_object(unsigned nr, const char *type, void *data,
+			 unsigned long size)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
 
 	while ((info = *p) != NULL) {
-		if (!hashcmp(info->base_sha1, sha1)) {
+		if (!hashcmp(info->base_sha1, obj_list[nr].sha1) ||
+		    info->base_offset == obj_list[nr].offset) {
 			*p = info->next;
 			p = &delta_list;
-			resolve_delta(type, data, size, info->delta, info->size);
+			resolve_delta(info->nr, type, data, size,
+				      info->delta, info->size);
 			free(info);
 			continue;
 		}
@@ -151,7 +169,8 @@ static void added_object(unsigned char *
 	}
 }
 
-static void unpack_non_delta_entry(enum object_type kind, unsigned long size)
+static void unpack_non_delta_entry(enum object_type kind, unsigned long size,
+				   unsigned nr)
 {
 	void *buf = get_data(size);
 	const char *type;
@@ -164,30 +183,80 @@ static void unpack_non_delta_entry(enum 
 	default: die("bad type %d", kind);
 	}
 	if (!dry_run && buf)
-		write_object(buf, size, type);
+		write_object(nr, buf, size, type);
 	free(buf);
 }
 
-static void unpack_delta_entry(unsigned long delta_size)
+static void unpack_delta_entry(enum object_type kind, unsigned long delta_size,
+			       unsigned nr)
 {
 	void *delta_data, *base;
 	unsigned long base_size;
 	char type[20];
 	unsigned char base_sha1[20];
 
-	hashcpy(base_sha1, fill(20));
-	use(20);
+	if (kind == OBJ_REF_DELTA) {
+		hashcpy(base_sha1, fill(20));
+		use(20);
+		delta_data = get_data(delta_size);
+		if (dry_run || !delta_data) {
+			free(delta_data);
+			return;
+		}
+		if (!has_sha1_file(base_sha1)) {
+			hashcpy(obj_list[nr].sha1, null_sha1);
+			add_delta_to_list(nr, base_sha1, 0, delta_data, delta_size);
+			return;
+		}
+	} else {
+		unsigned base_found = 0;
+		unsigned char *pack, c;
+		unsigned long base_offset;
+		unsigned lo, mid, hi;
 
-	delta_data = get_data(delta_size);
-	if (dry_run || !delta_data) {
-		free(delta_data);
-		return;
-	}
+		pack = fill(1);
+		c = *pack;
+		use(1);
+		base_offset = c & 127;
+		while (c & 128) {
+			base_offset += 1;
+			if (!base_offset || base_offset & ~(~0UL >> 7))
+				die("offset value overflow for delta base object");
+			pack = fill(1);
+			c = *pack;
+			use(1);
+			base_offset = (base_offset << 7) + (c & 127);
+		}
+		base_offset = obj_list[nr].offset - base_offset;
 
-	if (!has_sha1_file(base_sha1)) {
-		add_delta_to_list(base_sha1, delta_data, delta_size);
-		return;
+		delta_data = get_data(delta_size);
+		if (dry_run || !delta_data) {
+			free(delta_data);
+			return;
+		}
+		lo = 0;
+		hi = nr;
+		while (lo < hi) {
+			mid = (lo + hi)/2;
+			if (base_offset < obj_list[mid].offset) {
+				hi = mid;
+			} else if (base_offset > obj_list[mid].offset) {
+				lo = mid + 1;
+			} else {
+				hashcpy(base_sha1, obj_list[mid].sha1);
+				base_found = !is_null_sha1(base_sha1);
+				break;
+			}
+		}
+		if (!base_found) {
+			/* The delta base object is itself a delta that
+			   has not been	resolved yet. */
+			hashcpy(obj_list[nr].sha1, null_sha1);
+			add_delta_to_list(nr, null_sha1, base_offset, delta_data, delta_size);
+			return;
+		}
 	}
+
 	base = read_sha1_file(base_sha1, type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
@@ -197,7 +266,7 @@ static void unpack_delta_entry(unsigned 
 		has_errors = 1;
 		return;
 	}
-	resolve_delta(type, base, base_size, delta_data, delta_size);
+	resolve_delta(nr, type, base, base_size, delta_data, delta_size);
 	free(base);
 }
 
@@ -208,6 +277,8 @@ static void unpack_one(unsigned nr, unsi
 	unsigned long size;
 	enum object_type type;
 
+	obj_list[nr].offset = consumed_bytes;
+
 	pack = fill(1);
 	c = *pack;
 	use(1);
@@ -216,7 +287,7 @@ static void unpack_one(unsigned nr, unsi
 	shift = 4;
 	while (c & 0x80) {
 		pack = fill(1);
-		c = *pack++;
+		c = *pack;
 		use(1);
 		size += (c & 0x7f) << shift;
 		shift += 7;
@@ -225,13 +296,14 @@ static void unpack_one(unsigned nr, unsi
 		static unsigned long last_sec;
 		static unsigned last_percent;
 		struct timeval now;
-		unsigned percentage = (nr * 100) / total;
+		unsigned percentage = ((nr+1) * 100) / total;
 
 		gettimeofday(&now, NULL);
 		if (percentage != last_percent || now.tv_sec != last_sec) {
 			last_sec = now.tv_sec;
 			last_percent = percentage;
-			fprintf(stderr, "%4u%% (%u/%u) done\r", percentage, nr, total);
+			fprintf(stderr, "%4u%% (%u/%u) done\r",
+					percentage, (nr+1), total);
 		}
 	}
 	switch (type) {
@@ -239,10 +311,11 @@ static void unpack_one(unsigned nr, unsi
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		unpack_non_delta_entry(type, size);
+		unpack_non_delta_entry(type, size, nr);
 		return;
 	case OBJ_REF_DELTA:
-		unpack_delta_entry(size);
+	case OBJ_OFS_DELTA:
+		unpack_delta_entry(type, size, nr);
 		return;
 	default:
 		error("bad object type %d", type);
@@ -265,9 +338,10 @@ static void unpack_all(void)
 		die("unknown pack file version %d", ntohl(hdr->hdr_version));
 	fprintf(stderr, "Unpacking %d objects\n", nr_objects);
 
+	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
 	use(sizeof(struct pack_header));
 	for (i = 0; i < nr_objects; i++)
-		unpack_one(i+1, nr_objects);
+		unpack_one(i, nr_objects);
 	if (delta_list)
 		die("unresolved deltas left after unpacking");
 }
