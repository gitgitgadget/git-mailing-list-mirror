From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add the capability for index-pack to read from a stream
Date: Fri, 20 Oct 2006 14:45:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610201425570.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 20:45:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GazN2-0002Aj-NB
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 20:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992678AbWJTSpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 14:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992692AbWJTSpZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 14:45:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14717 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S2992678AbWJTSpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 14:45:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7G0053A6RLR7G0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Oct 2006 14:45:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29519>

This patch only adds the streaming capability to index-pack.  Although 
the code is different it has the exact same functionality as before to 
make sure nothing broke.

This is in preparation for receiving packs over the net, parse them on 
the fly, fix them up if they are "thin" packs, and keep the resulting 
pack instead of exploding it into loose objects.  But such functionality 
should come separately.

One immediate advantage of this patch is that index-pack can now deal 
with packs up to 4GB in size even on 32-bit architectures since the pack 
is not entirely mmap()'d all at once anymore.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/index-pack.c b/index-pack.c
index 56c590e..e33f605 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -13,6 +13,8 @@ static const char index_pack_usage[] =
 struct object_entry
 {
 	unsigned long offset;
+	unsigned long size;
+	unsigned int hdr_size;
 	enum object_type type;
 	enum object_type real_type;
 	unsigned char sha1[20];
@@ -36,51 +38,68 @@ struct delta_entry
 };
 
 static const char *pack_name;
-static unsigned char *pack_base;
-static unsigned long pack_size;
 static struct object_entry *objects;
 static struct delta_entry *deltas;
 static int nr_objects;
 static int nr_deltas;
 
-static void open_pack_file(void)
+/* We always read in 4kB chunks. */
+static unsigned char input_buffer[4096];
+static unsigned long input_offset, input_len, consumed_bytes;
+static SHA_CTX input_ctx;
+static int input_fd;
+
+/*
+ * Make sure at least "min" bytes are available in the buffer, and
+ * return the pointer to the buffer.
+ */
+static void * fill(int min)
 {
-	int fd;
-	struct stat st;
+	if (min <= input_len)
+		return input_buffer + input_offset;
+	if (min > sizeof(input_buffer))
+		die("cannot fill %d bytes", min);
+	if (input_offset) {
+		SHA1_Update(&input_ctx, input_buffer, input_offset);
+		memcpy(input_buffer, input_buffer + input_offset, input_len);
+		input_offset = 0;
+	}
+	do {
+		int ret = xread(input_fd, input_buffer + input_len,
+				sizeof(input_buffer) - input_len);
+		if (ret <= 0) {
+			if (!ret)
+				die("early EOF");
+			die("read error on input: %s", strerror(errno));
+		}
+		input_len += ret;
+	} while (input_len < min);
+	return input_buffer;
+}
+
+static void use(int bytes)
+{
+	if (bytes > input_len)
+		die("used more bytes than were available");
+	input_len -= bytes;
+	input_offset += bytes;
+	consumed_bytes += bytes;
+}
 
-	fd = open(pack_name, O_RDONLY);
-	if (fd < 0)
+static void open_pack_file(void)
+{
+	input_fd = open(pack_name, O_RDONLY);
+	if (input_fd < 0)
 		die("cannot open packfile '%s': %s", pack_name,
 		    strerror(errno));
-	if (fstat(fd, &st)) {
-		int err = errno;
-		close(fd);
-		die("cannot fstat packfile '%s': %s", pack_name,
-		    strerror(err));
-	}
-	pack_size = st.st_size;
-	pack_base = mmap(NULL, pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (pack_base == MAP_FAILED) {
-		int err = errno;
-		close(fd);
-		die("cannot mmap packfile '%s': %s", pack_name,
-		    strerror(err));
-	}
-	close(fd);
+	SHA1_Init(&input_ctx);
 }
 
 static void parse_pack_header(void)
 {
-	const struct pack_header *hdr;
-	unsigned char sha1[20];
-	SHA_CTX ctx;
-
-	/* Ensure there are enough bytes for the header and final SHA1 */
-	if (pack_size < sizeof(struct pack_header) + 20)
-		die("packfile '%s' is too small", pack_name);
+	struct pack_header *hdr = fill(sizeof(struct pack_header));
 
 	/* Header consistency check */
-	hdr = (void *)pack_base;
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		die("packfile '%s' signature mismatch", pack_name);
 	if (!pack_version_ok(hdr->hdr_version))
@@ -88,13 +107,8 @@ static void parse_pack_header(void)
 		    pack_name, ntohl(hdr->hdr_version));
 
 	nr_objects = ntohl(hdr->hdr_entries);
-
-	/* Check packfile integrity */
-	SHA1_Init(&ctx);
-	SHA1_Update(&ctx, pack_base, pack_size - 20);
-	SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, pack_base + pack_size - 20))
-		die("packfile '%s' SHA1 mismatch", pack_name);
+	use(sizeof(struct pack_header));
+	/*fprintf(stderr, "Indexing %d objects\n", nr_objects);*/
 }
 
 static void bad_object(unsigned long offset, const char *format,
@@ -112,85 +126,78 @@ static void bad_object(unsigned long off
 	    pack_name, offset, buf);
 }
 
-static void *unpack_entry_data(unsigned long offset,
-			       unsigned long *current_pos, unsigned long size)
+static void *unpack_entry_data(unsigned long offset, unsigned long size)
 {
-	unsigned long pack_limit = pack_size - 20;
-	unsigned long pos = *current_pos;
 	z_stream stream;
 	void *buf = xmalloc(size);
 
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buf;
 	stream.avail_out = size;
-	stream.next_in = pack_base + pos;
-	stream.avail_in = pack_limit - pos;
+	stream.next_in = fill(1);
+	stream.avail_in = input_len;
 	inflateInit(&stream);
 
 	for (;;) {
 		int ret = inflate(&stream, 0);
-		if (ret == Z_STREAM_END)
+		use(input_len - stream.avail_in);
+		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK)
 			bad_object(offset, "inflate returned %d", ret);
+		stream.next_in = fill(1);
+		stream.avail_in = input_len;
 	}
 	inflateEnd(&stream);
-	if (stream.total_out != size)
-		bad_object(offset, "size mismatch (expected %lu, got %lu)",
-			   size, stream.total_out);
-	*current_pos = pack_limit - stream.avail_in;
 	return buf;
 }
 
-static void *unpack_raw_entry(unsigned long offset,
-			      enum object_type *obj_type,
-			      unsigned long *obj_size,
-			      union delta_base *delta_base,
-			      unsigned long *next_obj_offset)
+static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_base)
 {
-	unsigned long pack_limit = pack_size - 20;
-	unsigned long pos = offset;
-	unsigned char c;
+	unsigned char *p, c;
 	unsigned long size, base_offset;
 	unsigned shift;
-	enum object_type type;
-	void *data;
 
-	c = pack_base[pos++];
-	type = (c >> 4) & 7;
+	obj->offset = consumed_bytes;
+
+	p = fill(1);
+	c = *p;
+	use(1);
+	obj->type = (c >> 4) & 7;
 	size = (c & 15);
 	shift = 4;
 	while (c & 0x80) {
-		if (pos >= pack_limit)
-			bad_object(offset, "object extends past end of pack");
-		c = pack_base[pos++];
+		p = fill(1);
+		c = *p;
+		use(1);
 		size += (c & 0x7fUL) << shift;
 		shift += 7;
 	}
+	obj->size = size;
 
-	switch (type) {
+	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		if (pos + 20 >= pack_limit)
-			bad_object(offset, "object extends past end of pack");
-		hashcpy(delta_base->sha1, pack_base + pos);
-		pos += 20;
+		hashcpy(delta_base->sha1, fill(20));
+		use(20);
 		break;
 	case OBJ_OFS_DELTA:
 		memset(delta_base, 0, sizeof(*delta_base));
-		c = pack_base[pos++];
+		p = fill(1);
+		c = *p;
+		use(1);
 		base_offset = c & 127;
 		while (c & 128) {
 			base_offset += 1;
 			if (!base_offset || base_offset & ~(~0UL >> 7))
-				bad_object(offset, "offset value overflow for delta base object");
-			if (pos >= pack_limit)
-				bad_object(offset, "object extends past end of pack");
-			c = pack_base[pos++];
+				bad_object(obj->offset, "offset value overflow for delta base object");
+			p = fill(1);
+			c = *p;
+			use(1);
 			base_offset = (base_offset << 7) + (c & 127);
 		}
-		delta_base->offset = offset - base_offset;
-		if (delta_base->offset >= offset)
-			bad_object(offset, "delta base offset is out of bound");
+		delta_base->offset = obj->offset - base_offset;
+		if (delta_base->offset >= obj->offset)
+			bad_object(obj->offset, "delta base offset is out of bound");
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -198,13 +205,38 @@ static void *unpack_raw_entry(unsigned l
 	case OBJ_TAG:
 		break;
 	default:
-		bad_object(offset, "bad object type %d", type);
+		bad_object(obj->offset, "bad object type %d", obj->type);
 	}
+	obj->hdr_size = consumed_bytes - obj->offset;
+
+	return unpack_entry_data(obj->offset, obj->size);
+}
+
+static void * get_data_from_pack(struct object_entry *obj)
+{
+	unsigned long from = obj[0].offset + obj[0].hdr_size;
+	unsigned long len = obj[1].offset - from;
+	unsigned pg_offset = from % getpagesize();
+	unsigned char *map, *data;
+	z_stream stream;
+	int st;
 
-	data = unpack_entry_data(offset, &pos, size);
-	*obj_type = type;
-	*obj_size = size;
-	*next_obj_offset = pos;
+	map = mmap(NULL, len + pg_offset, PROT_READ, MAP_PRIVATE,
+		   input_fd, from - pg_offset);
+	if (map == MAP_FAILED)
+		die("cannot mmap packfile '%s': %s", pack_name, strerror(errno));
+	data = xmalloc(obj->size);
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out = data;
+	stream.avail_out = obj->size;
+	stream.next_in = map + pg_offset;
+	stream.avail_in = len;
+	inflateInit(&stream);
+	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
+	inflateEnd(&stream);
+	if (st != Z_STREAM_END || stream.total_out != obj->size)
+		die("serious inflate inconsistency");
+	munmap(map, len + pg_offset);
 	return data;
 }
 
@@ -280,15 +312,12 @@ static void resolve_delta(struct delta_e
 	unsigned long delta_size;
 	void *result;
 	unsigned long result_size;
-	enum object_type delta_type;
 	union delta_base delta_base;
-	unsigned long next_obj_offset;
 	int j, first, last;
 
 	obj->real_type = type;
-	delta_data = unpack_raw_entry(obj->offset, &delta_type,
-				      &delta_size, &delta_base,
-				      &next_obj_offset);
+	delta_data = get_data_from_pack(obj);
+	delta_size = obj->size;
 	result = patch_delta(base_data, base_size, delta_data, delta_size,
 			     &result_size);
 	free(delta_data);
@@ -321,13 +350,13 @@ static int compare_delta_entry(const voi
 	return memcmp(&delta_a->base, &delta_b->base, UNION_BASE_SZ);
 }
 
-static void parse_pack_objects(void)
+/* Parse all objects and return the pack content SHA1 hash */
+static void parse_pack_objects(unsigned char *sha1)
 {
 	int i;
-	unsigned long offset = sizeof(struct pack_header);
 	struct delta_entry *delta = deltas;
 	void *data;
-	unsigned long data_size;
+	struct stat st;
 
 	/*
 	 * First pass:
@@ -337,19 +366,29 @@ static void parse_pack_objects(void)
 	 */
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
-		obj->offset = offset;
-		data = unpack_raw_entry(offset, &obj->type, &data_size,
-					&delta->base, &offset);
+		data = unpack_raw_entry(obj, &delta->base);
 		obj->real_type = obj->type;
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
 			nr_deltas++;
 			delta->obj = obj;
 			delta++;
 		} else
-			sha1_object(data, data_size, obj->type, obj->sha1);
+			sha1_object(data, obj->size, obj->type, obj->sha1);
 		free(data);
 	}
-	if (offset != pack_size - 20)
+	objects[i].offset = consumed_bytes;
+
+	/* Check pack integrity */
+	SHA1_Update(&input_ctx, input_buffer, input_offset);
+	SHA1_Final(sha1, &input_ctx);
+	if (hashcmp(fill(20), sha1))
+		die("packfile '%s' SHA1 mismatch", pack_name);
+	use(20);
+
+	/* If input_fd is a file, we should have reached its end now. */
+	if (fstat(input_fd, &st))
+		die("cannot fstat packfile '%s': %s", pack_name, strerror(errno));
+	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
 		die("packfile '%s' has junk at the end", pack_name);
 
 	/* Sort deltas by base SHA1/offset for fast searching */
@@ -378,18 +417,17 @@ static void parse_pack_objects(void)
 		ofs = !find_delta_childs(&base, &ofs_first, &ofs_last);
 		if (!ref && !ofs)
 			continue;
-		data = unpack_raw_entry(obj->offset, &obj->type, &data_size,
-					&base, &offset);
+		data = get_data_from_pack(obj);
 		if (ref)
 			for (j = ref_first; j <= ref_last; j++)
 				if (deltas[j].obj->type == OBJ_REF_DELTA)
 					resolve_delta(&deltas[j], data,
-						      data_size, obj->type);
+						      obj->size, obj->type);
 		if (ofs)
 			for (j = ofs_first; j <= ofs_last; j++)
 				if (deltas[j].obj->type == OBJ_OFS_DELTA)
 					resolve_delta(&deltas[j], data,
-						      data_size, obj->type);
+						      obj->size, obj->type);
 		free(data);
 	}
 
@@ -408,6 +446,10 @@ static int sha1_compare(const void *_a, 
 	return hashcmp(a->sha1, b->sha1);
 }
 
+/*
+ * On entry *sha1 contains the pack content SHA1 hash, on exit it is
+ * the SHA1 hash of sorted object names.
+ */
 static void write_index_file(const char *index_name, unsigned char *sha1)
 {
 	struct sha1file *f;
@@ -467,7 +509,7 @@ static void write_index_file(const char 
 		sha1write(f, obj->sha1, 20);
 		SHA1_Update(&ctx, obj->sha1, 20);
 	}
-	sha1write(f, pack_base + pack_size - 20, 20);
+	sha1write(f, sha1, 20);
 	sha1close(f, NULL, 1);
 	free(sorted_by_sha);
 	SHA1_Final(sha1, &ctx);
@@ -513,9 +555,9 @@ int main(int argc, char **argv)
 
 	open_pack_file();
 	parse_pack_header();
-	objects = xcalloc(nr_objects, sizeof(struct object_entry));
+	objects = xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
-	parse_pack_objects();
+	parse_pack_objects(sha1);
 	free(deltas);
 	write_index_file(index_name, sha1);
 	free(objects);
