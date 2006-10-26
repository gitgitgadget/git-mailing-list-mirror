X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: =?UTF-8?Q?=5BPATCH_1=2F3=5D_make_index-p=C3=A2ck_able_to_comp?=
 =?UTF-8?Q?lete_thin_packs?=
Date: Wed, 25 Oct 2006 23:28:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610252323100.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 03:28:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30133>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcvuq-0002w0-7l for gcvg-git@gmane.org; Thu, 26 Oct
 2006 05:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751707AbWJZD2U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 23:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWJZD2U
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 23:28:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20704 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1751707AbWJZD2T
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 23:28:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q00BAQ4B5PA83@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 25 Oct 2006 23:28:18 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

A new flag, --fix-thin, instructs git-index-pack to append any missing
objects to a thin pack to make it self contained and indexable. Of course
objects missing from the pack must be present elsewhere in the local
repository.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/git-index-pack.txt |   14 ++-
 index-pack.c                     |  254 +++++++++++++++++++++++++++++++-------
 2 files changed, 224 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index db7af58..c58287d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -8,7 +8,8 @@ git-index-pack - Build pack index file f
 
 SYNOPSIS
 --------
-'git-index-pack' [-o <index-file>] { <pack-file> | --stdin [<pack-file>] }
+'git-index-pack' [-o <index-file>] <pack-file>
+'git-index-pack' --stdin [--fix-thin] [-o <index-file>] [<pack-file>]
 
 
 DESCRIPTION
@@ -36,6 +37,17 @@ OPTIONS
 	objects/pack/ directory of the current git repository with
 	a default name determined from the pack content.
 
+--fix-thin::
+	It is possible for gitlink:git-pack-objects[1] to build
+	"thin" pack, which records objects in deltified form based on
+	objects not included in the pack to reduce network traffic.
+	Those objects are expected to be present on the receiving end
+	and they must be included in the pack for that pack to be self
+	contained and indexable. Without this option any attempt to
+	index a thin pack will fail. This option only makes sense in
+	conjonction with --stdin.
+
+
 Author
 ------
 Written by Sergey Vlasov <vsu@altlinux.ru>
diff --git a/index-pack.c b/index-pack.c
index cecdd26..9086bbf 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -8,7 +8,7 @@
 #include "tree.h"
 
 static const char index_pack_usage[] =
-"git-index-pack [-o <index-file>] { <pack-file> | --stdin [<pack-file>] }";
+"git-index-pack [-o <index-file>] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
 {
@@ -33,14 +33,15 @@ union delta_base {
 
 struct delta_entry
 {
-	struct object_entry *obj;
 	union delta_base base;
+	int obj_no;
 };
 
 static struct object_entry *objects;
 static struct delta_entry *deltas;
 static int nr_objects;
 static int nr_deltas;
+static int nr_resolved_deltas;
 
 static int from_stdin;
 
@@ -50,6 +51,18 @@ static unsigned long input_offset, input
 static SHA_CTX input_ctx;
 static int input_fd, output_fd, mmap_fd;
 
+/* Discard current buffer used content. */
+static void flush()
+{
+	if (input_offset) {
+		if (output_fd >= 0)
+			write_or_die(output_fd, input_buffer, input_offset);
+		SHA1_Update(&input_ctx, input_buffer, input_offset);
+		memcpy(input_buffer, input_buffer + input_offset, input_len);
+		input_offset = 0;
+	}
+}
+
 /*
  * Make sure at least "min" bytes are available in the buffer, and
  * return the pointer to the buffer.
@@ -60,13 +73,7 @@ static void * fill(int min)
 		return input_buffer + input_offset;
 	if (min > sizeof(input_buffer))
 		die("cannot fill %d bytes", min);
-	if (input_offset) {
-		if (output_fd >= 0)
-			write_or_die(output_fd, input_buffer, input_offset);
-		SHA1_Update(&input_ctx, input_buffer, input_offset);
-		memcpy(input_buffer, input_buffer + input_offset, input_len);
-		input_offset = 0;
-	}
+	flush();
 	do {
 		int ret = xread(input_fd, input_buffer + input_len,
 				sizeof(input_buffer) - input_len);
@@ -323,10 +330,9 @@ static void sha1_object(const void *data
 	SHA1_Final(sha1, &ctx);
 }
 
-static void resolve_delta(struct delta_entry *delta, void *base_data,
+static void resolve_delta(struct object_entry *delta_obj, void *base_data,
 			  unsigned long base_size, enum object_type type)
 {
-	struct object_entry *obj = delta->obj;
 	void *delta_data;
 	unsigned long delta_size;
 	void *result;
@@ -334,29 +340,34 @@ static void resolve_delta(struct delta_e
 	union delta_base delta_base;
 	int j, first, last;
 
-	obj->real_type = type;
-	delta_data = get_data_from_pack(obj);
-	delta_size = obj->size;
+	delta_obj->real_type = type;
+	delta_data = get_data_from_pack(delta_obj);
+	delta_size = delta_obj->size;
 	result = patch_delta(base_data, base_size, delta_data, delta_size,
 			     &result_size);
 	free(delta_data);
 	if (!result)
-		bad_object(obj->offset, "failed to apply delta");
-	sha1_object(result, result_size, type, obj->sha1);
+		bad_object(delta_obj->offset, "failed to apply delta");
+	sha1_object(result, result_size, type, delta_obj->sha1);
+	nr_resolved_deltas++;
 
-	hashcpy(delta_base.sha1, obj->sha1);
+	hashcpy(delta_base.sha1, delta_obj->sha1);
 	if (!find_delta_childs(&delta_base, &first, &last)) {
-		for (j = first; j <= last; j++)
-			if (deltas[j].obj->type == OBJ_REF_DELTA)
-				resolve_delta(&deltas[j], result, result_size, type);
+		for (j = first; j <= last; j++) {
+			struct object_entry *child = objects + deltas[j].obj_no;
+			if (child->real_type == OBJ_REF_DELTA)
+				resolve_delta(child, result, result_size, type);
+		}
 	}
 
 	memset(&delta_base, 0, sizeof(delta_base));
-	delta_base.offset = obj->offset;
+	delta_base.offset = delta_obj->offset;
 	if (!find_delta_childs(&delta_base, &first, &last)) {
-		for (j = first; j <= last; j++)
-			if (deltas[j].obj->type == OBJ_OFS_DELTA)
-				resolve_delta(&deltas[j], result, result_size, type);
+		for (j = first; j <= last; j++) {
+			struct object_entry *child = objects + deltas[j].obj_no;
+			if (child->real_type == OBJ_OFS_DELTA)
+				resolve_delta(child, result, result_size, type);
+		}
 	}
 
 	free(result);
@@ -389,7 +400,7 @@ static void parse_pack_objects(unsigned
 		obj->real_type = obj->type;
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
 			nr_deltas++;
-			delta->obj = obj;
+			delta->obj_no = i;
 			delta++;
 		} else
 			sha1_object(data, obj->size, obj->type, obj->sha1);
@@ -398,18 +409,15 @@ static void parse_pack_objects(unsigned
 	objects[i].offset = consumed_bytes;
 
 	/* Check pack integrity */
-	SHA1_Update(&input_ctx, input_buffer, input_offset);
+	flush();
 	SHA1_Final(sha1, &input_ctx);
 	if (hashcmp(fill(20), sha1))
 		die("pack is corrupted (SHA1 mismatch)");
-	use(20);
-	if (output_fd >= 0)
-		write_or_die(output_fd, input_buffer, input_offset);
 
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
 		die("cannot fstat packfile: %s", strerror(errno));
-	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
+	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes + 20)
 		die("pack has junk at the end");
 
 	/* Sort deltas by base SHA1/offset for fast searching */
@@ -440,24 +448,161 @@ static void parse_pack_objects(unsigned
 			continue;
 		data = get_data_from_pack(obj);
 		if (ref)
-			for (j = ref_first; j <= ref_last; j++)
-				if (deltas[j].obj->type == OBJ_REF_DELTA)
-					resolve_delta(&deltas[j], data,
+			for (j = ref_first; j <= ref_last; j++) {
+				struct object_entry *child = objects + deltas[j].obj_no;
+				if (child->real_type == OBJ_REF_DELTA)
+					resolve_delta(child, data,
 						      obj->size, obj->type);
+			}
 		if (ofs)
-			for (j = ofs_first; j <= ofs_last; j++)
-				if (deltas[j].obj->type == OBJ_OFS_DELTA)
-					resolve_delta(&deltas[j], data,
+			for (j = ofs_first; j <= ofs_last; j++) {
+				struct object_entry *child = objects + deltas[j].obj_no;
+				if (child->real_type == OBJ_OFS_DELTA)
+					resolve_delta(child, data,
 						      obj->size, obj->type);
+			}
 		free(data);
 	}
+}
+
+static int write_compressed(int fd, void *in, unsigned int size)
+{
+	z_stream stream;
+	unsigned long maxsize;
+	void *out;
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, zlib_compression_level);
+	maxsize = deflateBound(&stream, size);
+	out = xmalloc(maxsize);
+
+	/* Compress it */
+	stream.next_in = in;
+	stream.avail_in = size;
+	stream.next_out = out;
+	stream.avail_out = maxsize;
+	while (deflate(&stream, Z_FINISH) == Z_OK);
+	deflateEnd(&stream);
+
+	size = stream.total_out;
+	write_or_die(fd, out, size);
+	free(out);
+	return size;
+}
+
+static void append_obj_to_pack(void *buf,
+			       unsigned long size, enum object_type type)
+{
+	struct object_entry *obj = &objects[nr_objects++];
+	unsigned char header[10];
+	unsigned long s = size;
+	int n = 0;
+	unsigned char c = (type << 4) | (s & 15);
+	s >>= 4;
+	while (s) {
+		header[n++] = c | 0x80;
+		c = s & 0x7f;
+		s >>= 7;
+	}
+	header[n++] = c;
+	write_or_die(output_fd, header, n);
+	obj[1].offset = obj[0].offset + n;
+	obj[1].offset += write_compressed(output_fd, buf, size);
+	sha1_object(buf, size, type, obj->sha1);
+}
+
+static int delta_pos_compare(const void *_a, const void *_b)
+{
+	struct delta_entry *a = *(struct delta_entry **)_a;
+	struct delta_entry *b = *(struct delta_entry **)_b;
+	return a->obj_no - b->obj_no;
+}
 
-	/* Check for unresolved deltas */
+static void fix_unresolved_deltas(int nr_unresolved)
+{
+	struct delta_entry **sorted_by_pos;
+	int i, n = 0;
+
+	/*
+	 * Since many unresolved deltas may well be themselves base objects
+	 * for more unresolved deltas, we really want to include the
+	 * smallest number of base objects that would cover as much delta
+	 * as possible by picking the
+	 * trunc deltas first, allowing for other deltas to resolve without
+	 * additional base objects.  Since most base objects are to be found
+	 * before deltas depending on them, a good heuristic is to start
+	 * resolving deltas in the same order as their position in the pack.
+	 */
+	sorted_by_pos = xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
 	for (i = 0; i < nr_deltas; i++) {
-		if (deltas[i].obj->real_type == OBJ_REF_DELTA ||
-		    deltas[i].obj->real_type == OBJ_OFS_DELTA)
-			die("pack has unresolved deltas");
+		if (objects[deltas[i].obj_no].real_type != OBJ_REF_DELTA)
+			continue;
+		sorted_by_pos[n++] = &deltas[i];
 	}
+	qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_compare);
+
+	for (i = 0; i < n; i++) {
+		struct delta_entry *d = sorted_by_pos[i];
+		void *data;
+		unsigned long size;
+		char type[10];
+		enum object_type obj_type;
+		int j, first, last;
+
+		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
+			continue;
+		data = read_sha1_file(d->base.sha1, type, &size);
+		if (!data)
+			continue;
+		if      (!strcmp(type, blob_type))   obj_type = OBJ_BLOB;
+		else if (!strcmp(type, tree_type))   obj_type = OBJ_TREE;
+		else if (!strcmp(type, commit_type)) obj_type = OBJ_COMMIT;
+		else if (!strcmp(type, tag_type))    obj_type = OBJ_TAG;
+		else die("base object %s is of type '%s'",
+			 sha1_to_hex(d->base.sha1), type);
+
+		find_delta_childs(&d->base, &first, &last);
+		for (j = first; j <= last; j++) {
+			struct object_entry *child = objects + deltas[j].obj_no;
+			if (child->real_type == OBJ_REF_DELTA)
+				resolve_delta(child, data, size, obj_type);
+		}
+
+		append_obj_to_pack(data, size, obj_type);
+		free(data);
+	}
+	free(sorted_by_pos);
+}
+
+static void readjust_pack_header_and_sha1(unsigned char *sha1)
+{
+	struct pack_header hdr;
+	SHA_CTX ctx;
+	int size;
+
+	/* Rewrite pack header with updated object number */
+	if (lseek(output_fd, 0, SEEK_SET) != 0)
+		die("cannot seek back: %s", strerror(errno));
+	if (xread(output_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+		die("cannot read pack header back: %s", strerror(errno));
+	hdr.hdr_entries = htonl(nr_objects);
+	if (lseek(output_fd, 0, SEEK_SET) != 0)
+		die("cannot seek back: %s", strerror(errno));
+	write_or_die(output_fd, &hdr, sizeof(hdr));
+	if (lseek(output_fd, 0, SEEK_SET) != 0)
+		die("cannot seek back: %s", strerror(errno));
+
+	/* Recompute and store the new pack's SHA1 */
+	SHA1_Init(&ctx);
+	do {
+		unsigned char *buf[4096];
+		size = xread(output_fd, buf, sizeof(buf));
+		if (size < 0)
+			die("cannot read pack data back: %s", strerror(errno));
+		SHA1_Update(&ctx, buf, size);
+	} while (size > 0);
+	SHA1_Final(sha1, &ctx);
+	write_or_die(output_fd, sha1, 20);
 }
 
 static int sha1_compare(const void *_a, const void *_b)
@@ -588,7 +733,7 @@ static void final(const char *final_pack
 
 int main(int argc, char **argv)
 {
-	int i;
+	int i, fix_thin_pack = 0;
 	const char *curr_pack, *pack_name = NULL;
 	const char *curr_index, *index_name = NULL;
 	char *index_name_buf = NULL;
@@ -600,6 +745,8 @@ int main(int argc, char **argv)
 		if (*arg == '-') {
 			if (!strcmp(arg, "--stdin")) {
 				from_stdin = 1;
+			} else if (!strcmp(arg, "--fix-thin")) {
+				fix_thin_pack = 1;
 			} else if (!strcmp(arg, "-o")) {
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
@@ -616,6 +763,8 @@ int main(int argc, char **argv)
 
 	if (!pack_name && !from_stdin)
 		usage(index_pack_usage);
+	if (fix_thin_pack && !from_stdin)
+		die("--fix-thin cannot be used without --stdin");
 	if (!index_name && pack_name) {
 		int len = strlen(pack_name);
 		if (!has_extension(pack_name, ".pack"))
@@ -629,9 +778,28 @@ int main(int argc, char **argv)
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
-	objects = xcalloc(nr_objects + 1, sizeof(struct object_entry));
-	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
+	objects = xmalloc((nr_objects + 1) * sizeof(struct object_entry));
+	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
 	parse_pack_objects(sha1);
+	if (nr_deltas != nr_resolved_deltas) {
+		if (fix_thin_pack) {
+			int nr_unresolved = nr_deltas - nr_resolved_deltas;
+			if (nr_unresolved <= 0)
+				die("confusion beyond insanity");
+			objects = xrealloc(objects,
+					   (nr_objects + nr_unresolved + 1)
+					   * sizeof(*objects));
+			fix_unresolved_deltas(nr_unresolved);
+			readjust_pack_header_and_sha1(sha1);
+		}
+		if (nr_deltas != nr_resolved_deltas)
+			die("pack has %d unresolved deltas",
+			    nr_deltas - nr_resolved_deltas);
+	} else {
+		/* Flush remaining pack final 20-byte SHA1. */
+		use(20);
+		flush();
+	}
 	free(deltas);
 	curr_index = write_index_file(index_name, sha1);
 	final(pack_name, curr_pack, index_name, curr_index, sha1);
-- 
1.4.3.3.g10cf-dirty
