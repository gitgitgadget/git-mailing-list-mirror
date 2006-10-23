From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] enable index-pack streaming capability
Date: Mon, 23 Oct 2006 14:50:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610231338590.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:51:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4sU-0007c8-7J
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWJWSuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWJWSuV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:50:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64954 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965034AbWJWSuU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 14:50:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7L008LBQZUK990@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Oct 2006 14:50:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29860>

A new flag, --stdin, allows for a pack to be received over a stream.
When this flag is provided, the pack content is written to either
the named pack file or directly to the object repository under the
same name as produced by git-repack.  The pack index is written as
well with the corresponding base name, unless the index name is
overriden with -o.

With this patch, git-pack-index could be used instead of
git-unpack-objects when fetching remote objects but only with
non "thin" packs for now.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 71ce557..0799e67 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -8,7 +8,7 @@ git-index-pack - Build pack index file f
 
 SYNOPSIS
 --------
-'git-index-pack' [-o <index-file>] <pack-file>
+'git-index-pack' [-o <index-file>] { <pack-file> | --stdin [<pack-file>] }
 
 
 DESCRIPTION
@@ -29,7 +29,13 @@ OPTIONS
 	fails if the name of packed archive does not end
 	with .pack).
 
-
+--stdin::
+	When this flag is provided, the pack is read from stdin
+	instead and a copy is then written to <pack-file>. If
+	<pack-file> is not specified, the pack is written to
+	objects/pack/ directory of the current git repository with
+	a default name determined from the pack content.
+	
 Author
 ------
 Written by Sergey Vlasov <vsu@altlinux.ru>
diff --git a/index-pack.c b/index-pack.c
index e33f605..cecdd26 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -8,7 +8,7 @@ #include "tag.h"
 #include "tree.h"
 
 static const char index_pack_usage[] =
-"git-index-pack [-o index-file] pack-file";
+"git-index-pack [-o <index-file>] { <pack-file> | --stdin [<pack-file>] }";
 
 struct object_entry
 {
@@ -37,17 +37,18 @@ struct delta_entry
 	union delta_base base;
 };
 
-static const char *pack_name;
 static struct object_entry *objects;
 static struct delta_entry *deltas;
 static int nr_objects;
 static int nr_deltas;
 
+static int from_stdin;
+
 /* We always read in 4kB chunks. */
 static unsigned char input_buffer[4096];
 static unsigned long input_offset, input_len, consumed_bytes;
 static SHA_CTX input_ctx;
-static int input_fd;
+static int input_fd, output_fd, mmap_fd;
 
 /*
  * Make sure at least "min" bytes are available in the buffer, and
@@ -60,6 +61,8 @@ static void * fill(int min)
 	if (min > sizeof(input_buffer))
 		die("cannot fill %d bytes", min);
 	if (input_offset) {
+		if (output_fd >= 0)
+			write_or_die(output_fd, input_buffer, input_offset);
 		SHA1_Update(&input_ctx, input_buffer, input_offset);
 		memcpy(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
@@ -86,13 +89,31 @@ static void use(int bytes)
 	consumed_bytes += bytes;
 }
 
-static void open_pack_file(void)
+static const char * open_pack_file(const char *pack_name)
 {
-	input_fd = open(pack_name, O_RDONLY);
-	if (input_fd < 0)
-		die("cannot open packfile '%s': %s", pack_name,
-		    strerror(errno));
+	if (from_stdin) {
+		input_fd = 0;
+		if (!pack_name) {
+			static char tmpfile[PATH_MAX];
+			snprintf(tmpfile, sizeof(tmpfile),
+				 "%s/pack_XXXXXX", get_object_directory());
+			output_fd = mkstemp(tmpfile);
+			pack_name = xstrdup(tmpfile);
+		} else
+			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
+		if (output_fd < 0)
+			die("unable to create %s: %s\n", pack_name, strerror(errno));
+		mmap_fd = output_fd;
+	} else {
+		input_fd = open(pack_name, O_RDONLY);
+		if (input_fd < 0)
+			die("cannot open packfile '%s': %s",
+			    pack_name, strerror(errno));
+		output_fd = -1;
+		mmap_fd = input_fd;
+	}
 	SHA1_Init(&input_ctx);
+	return pack_name;
 }
 
 static void parse_pack_header(void)
@@ -101,10 +122,9 @@ static void parse_pack_header(void)
 
 	/* Header consistency check */
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
-		die("packfile '%s' signature mismatch", pack_name);
+		die("pack signature mismatch");
 	if (!pack_version_ok(hdr->hdr_version))
-		die("packfile '%s' version %d unsupported",
-		    pack_name, ntohl(hdr->hdr_version));
+		die("pack version %d unsupported", ntohl(hdr->hdr_version));
 
 	nr_objects = ntohl(hdr->hdr_entries);
 	use(sizeof(struct pack_header));
@@ -122,8 +142,7 @@ static void bad_object(unsigned long off
 	va_start(params, format);
 	vsnprintf(buf, sizeof(buf), format, params);
 	va_end(params);
-	die("packfile '%s': bad object at offset %lu: %s",
-	    pack_name, offset, buf);
+	die("pack has bad object at offset %lu: %s", offset, buf);
 }
 
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
@@ -222,9 +241,9 @@ static void * get_data_from_pack(struct 
 	int st;
 
 	map = mmap(NULL, len + pg_offset, PROT_READ, MAP_PRIVATE,
-		   input_fd, from - pg_offset);
+		   mmap_fd, from - pg_offset);
 	if (map == MAP_FAILED)
-		die("cannot mmap packfile '%s': %s", pack_name, strerror(errno));
+		die("cannot mmap pack file: %s", strerror(errno));
 	data = xmalloc(obj->size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = data;
@@ -382,14 +401,16 @@ static void parse_pack_objects(unsigned 
 	SHA1_Update(&input_ctx, input_buffer, input_offset);
 	SHA1_Final(sha1, &input_ctx);
 	if (hashcmp(fill(20), sha1))
-		die("packfile '%s' SHA1 mismatch", pack_name);
+		die("pack is corrupted (SHA1 mismatch)");
 	use(20);
+	if (output_fd >= 0)
+		write_or_die(output_fd, input_buffer, input_offset);
 
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
-		die("cannot fstat packfile '%s': %s", pack_name, strerror(errno));
+		die("cannot fstat packfile: %s", strerror(errno));
 	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
-		die("packfile '%s' has junk at the end", pack_name);
+		die("pack has junk at the end");
 
 	/* Sort deltas by base SHA1/offset for fast searching */
 	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
@@ -435,7 +456,7 @@ static void parse_pack_objects(unsigned 
 	for (i = 0; i < nr_deltas; i++) {
 		if (deltas[i].obj->real_type == OBJ_REF_DELTA ||
 		    deltas[i].obj->real_type == OBJ_OFS_DELTA)
-			die("packfile '%s' has unresolved deltas",  pack_name);
+			die("pack has unresolved deltas");
 	}
 }
 
@@ -450,12 +471,12 @@ static int sha1_compare(const void *_a, 
  * On entry *sha1 contains the pack content SHA1 hash, on exit it is
  * the SHA1 hash of sorted object names.
  */
-static void write_index_file(const char *index_name, unsigned char *sha1)
+static const char * write_index_file(const char *index_name, unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct object_entry **sorted_by_sha, **list, **last;
 	unsigned int array[256];
-	int i;
+	int i, fd;
 	SHA_CTX ctx;
 
 	if (nr_objects) {
@@ -472,8 +493,19 @@ static void write_index_file(const char 
 	else
 		sorted_by_sha = list = last = NULL;
 
-	unlink(index_name);
-	f = sha1create("%s", index_name);
+	if (!index_name) {
+		static char tmpfile[PATH_MAX];
+		snprintf(tmpfile, sizeof(tmpfile),
+			 "%s/index_XXXXXX", get_object_directory());
+		fd = mkstemp(tmpfile);
+		index_name = xstrdup(tmpfile);
+	} else {
+		unlink(index_name);
+		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	}
+	if (fd < 0)
+		die("unable to create %s: %s", index_name, strerror(errno));
+	f = sha1fd(fd, index_name);
 
 	/*
 	 * Write the first-level table (the list is sorted,
@@ -513,12 +545,52 @@ static void write_index_file(const char 
 	sha1close(f, NULL, 1);
 	free(sorted_by_sha);
 	SHA1_Final(sha1, &ctx);
+	return index_name;
+}
+
+static void final(const char *final_pack_name, const char *curr_pack_name,
+		  const char *final_index_name, const char *curr_index_name,
+		  unsigned char *sha1)
+{
+	char name[PATH_MAX];
+	int err;
+
+	if (!from_stdin) {
+		close(input_fd);
+	} else {
+		err = close(output_fd);
+		if (err)
+			die("error while closing pack file: %s", strerror(errno));
+		chmod(curr_pack_name, 0444);
+	}
+
+	if (final_pack_name != curr_pack_name) {
+		if (!final_pack_name) {
+			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
+				 get_object_directory(), sha1_to_hex(sha1));
+			final_pack_name = name;
+		}
+		if (move_temp_to_file(curr_pack_name, final_pack_name))
+			die("cannot store pack file");
+	}
+
+	chmod(curr_index_name, 0444);
+	if (final_index_name != curr_index_name) {
+		if (!final_index_name) {
+			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
+				 get_object_directory(), sha1_to_hex(sha1));
+			final_index_name = name;
+		}
+		if (move_temp_to_file(curr_index_name, final_index_name))
+			die("cannot store index file");
+	}
 }
 
 int main(int argc, char **argv)
 {
 	int i;
-	char *index_name = NULL;
+	const char *curr_pack, *pack_name = NULL;
+	const char *curr_index, *index_name = NULL;
 	char *index_name_buf = NULL;
 	unsigned char sha1[20];
 
@@ -526,7 +598,9 @@ int main(int argc, char **argv)
 		const char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!strcmp(arg, "-o")) {
+			if (!strcmp(arg, "--stdin")) {
+				from_stdin = 1;
+			} else if (!strcmp(arg, "-o")) {
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
 				index_name = argv[++i];
@@ -540,9 +614,9 @@ int main(int argc, char **argv)
 		pack_name = arg;
 	}
 
-	if (!pack_name)
+	if (!pack_name && !from_stdin)
 		usage(index_pack_usage);
-	if (!index_name) {
+	if (!index_name && pack_name) {
 		int len = strlen(pack_name);
 		if (!has_extension(pack_name, ".pack"))
 			die("packfile name '%s' does not end with '.pack'",
@@ -553,13 +627,14 @@ int main(int argc, char **argv)
 		index_name = index_name_buf;
 	}
 
-	open_pack_file();
+	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
 	objects = xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_pack_objects(sha1);
 	free(deltas);
-	write_index_file(index_name, sha1);
+	curr_index = write_index_file(index_name, sha1);
+	final(pack_name, curr_pack, index_name, curr_index, sha1);
 	free(objects);
 	free(index_name_buf);
 
