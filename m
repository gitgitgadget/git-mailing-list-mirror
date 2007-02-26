From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/6] convert object type handling from a string to a number
Date: Mon, 26 Feb 2007 14:55:59 -0500
Message-ID: <11725197632516-git-send-email-nico@cam.org>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org>
 <11725197633144-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlxb-0004Dt-QV
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbXBZT4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbXBZT4R
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:56:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36667 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030494AbXBZT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:56:12 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3007SW61CD1Q1@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 14:56:11 -0500 (EST)
In-reply-to: <11725197633144-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.572.ge86d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40658>

We currently have two parallel notation for dealing with object types
in the code: a string and a numerical value.  One of them is obviously
redundent, and the most used one requires more stack space and a bunch
of strcmp() all over the place.

This is an initial step for the removal of the version using a char array
found in object reading code paths.  The patch is unfortunately large but
there is no sane way to split it in smaller parts without breaking the
system.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 archive-tar.c            |    4 +-
 archive-zip.c            |    4 +-
 blob.c                   |    6 +-
 builtin-apply.c          |    8 +-
 builtin-blame.c          |   18 ++---
 builtin-cat-file.c       |   19 +++--
 builtin-commit-tree.c    |    7 +-
 builtin-for-each-ref.c   |    4 +-
 builtin-grep.c           |    8 +-
 builtin-log.c            |    4 +-
 builtin-pack-objects.c   |   32 ++++-----
 builtin-prune.c          |   11 +--
 builtin-reflog.c         |    4 +-
 builtin-unpack-objects.c |   39 ++++-------
 cache.h                  |   36 +++++-----
 combine-diff.c           |    6 +-
 commit.c                 |    6 +-
 convert-objects.c        |   12 ++--
 diff.c                   |    7 +-
 entry.c                  |    6 +-
 fast-import.c            |   18 +++---
 http-push.c              |    6 +-
 index-pack.c             |   10 +--
 merge-file.c             |   10 ++--
 merge-recursive.c        |   14 ++--
 merge-tree.c             |    8 +-
 mktag.c                  |    8 +-
 mktree.c                 |    9 ++-
 object.c                 |   16 ++--
 object.h                 |    2 +-
 pack-check.c             |   14 ++--
 read-cache.c             |    4 +-
 sha1_file.c              |  170 ++++++++++++++++++++++------------------------
 tag.c                    |    6 +-
 tree-diff.c              |    6 +-
 tree.c                   |    6 +-
 unpack-file.c            |    6 +-
 37 files changed, 265 insertions(+), 289 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 7d52a06..d9c30d3 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -262,7 +262,7 @@ static int write_tar_entry(const unsigned char *sha1,
 	static struct strbuf path;
 	int filenamelen = strlen(filename);
 	void *buffer;
-	char type[20];
+	enum object_type type;
 	unsigned long size;
 
 	if (!path.alloc) {
@@ -283,7 +283,7 @@ static int write_tar_entry(const unsigned char *sha1,
 		buffer = NULL;
 		size = 0;
 	} else {
-		buffer = read_sha1_file(sha1, type, &size);
+		buffer = read_sha1_file(sha1, &type, &size);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 	}
diff --git a/archive-zip.c b/archive-zip.c
index f31b8ed..7c49848 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -167,7 +167,7 @@ static int write_zip_entry(const unsigned char *sha1,
 	int pathlen;
 	unsigned char *out;
 	char *path;
-	char type[20];
+	enum object_type type;
 	void *buffer = NULL;
 	void *deflated = NULL;
 
@@ -195,7 +195,7 @@ static int write_zip_entry(const unsigned char *sha1,
 		if (S_ISREG(mode) && zlib_compression_level != 0)
 			method = 8;
 		result = 0;
-		buffer = read_sha1_file(sha1, type, &size);
+		buffer = read_sha1_file(sha1, &type, &size);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 		crc = crc32(crc, buffer, size);
diff --git a/blob.c b/blob.c
index 9776bea..0a9ea41 100644
--- a/blob.c
+++ b/blob.c
@@ -30,18 +30,18 @@ int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
 
 int parse_blob(struct blob *item)
 {
-        char type[20];
+        enum object_type type;
         void *buffer;
         unsigned long size;
 	int ret;
 
         if (item->object.parsed)
                 return 0;
-        buffer = read_sha1_file(item->object.sha1, type, &size);
+        buffer = read_sha1_file(item->object.sha1, &type, &size);
         if (!buffer)
                 return error("Could not read %s",
                              sha1_to_hex(item->object.sha1));
-        if (strcmp(type, blob_type))
+        if (type != OBJ_BLOB)
                 return error("Object %s not a blob",
                              sha1_to_hex(item->object.sha1));
 	ret = parse_blob_buffer(item, buffer, size);
diff --git a/builtin-apply.c b/builtin-apply.c
index 2dde341..bd3372f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1911,11 +1911,11 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 
 	if (has_sha1_file(sha1)) {
 		/* We already have the postimage */
-		char type[10];
+		enum object_type type;
 		unsigned long size;
 
 		free(desc->buffer);
-		desc->buffer = read_sha1_file(sha1, type, &size);
+		desc->buffer = read_sha1_file(sha1, &type, &size);
 		if (!desc->buffer)
 			return error("the necessary postimage %s for "
 				     "'%s' cannot be read",
@@ -1971,8 +1971,8 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	buf = NULL;
 	if (cached) {
 		if (ce) {
-			char type[20];
-			buf = read_sha1_file(ce->sha1, type, &size);
+			enum object_type type;
+			buf = read_sha1_file(ce->sha1, &type, &size);
 			if (!buf)
 				return error("read of %s failed",
 					     patch->old_name);
diff --git a/builtin-blame.c b/builtin-blame.c
index 530b97f..9f7dd4e 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -87,9 +87,9 @@ struct origin {
 static char *fill_origin_blob(struct origin *o, mmfile_t *file)
 {
 	if (!o->file.ptr) {
-		char type[10];
+		enum object_type type;
 		num_read_blob++;
-		file->ptr = read_sha1_file(o->blob_sha1, type,
+		file->ptr = read_sha1_file(o->blob_sha1, &type,
 					   (unsigned long *)(&(file->size)));
 		o->file = *file;
 	}
@@ -263,7 +263,6 @@ static struct origin *get_origin(struct scoreboard *sb,
 static int fill_blob_sha1(struct origin *origin)
 {
 	unsigned mode;
-	char type[10];
 
 	if (!is_null_sha1(origin->blob_sha1))
 		return 0;
@@ -271,8 +270,7 @@ static int fill_blob_sha1(struct origin *origin)
 			   origin->path,
 			   origin->blob_sha1, &mode))
 		goto error_out;
-	if (sha1_object_info(origin->blob_sha1, type, NULL) ||
-	    strcmp(type, blob_type))
+	if (sha1_object_info(origin->blob_sha1, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
@@ -1322,10 +1320,10 @@ static void get_commit_info(struct commit *commit,
 	 * we now need to populate them for output.
 	 */
 	if (!commit->buffer) {
-		char type[20];
+		enum object_type type;
 		unsigned long size;
 		commit->buffer =
-			read_sha1_file(commit->object.sha1, type, &size);
+			read_sha1_file(commit->object.sha1, &type, &size);
 	}
 	ret->author = author_buf;
 	get_ac_line(commit->buffer, "\nauthor ",
@@ -2006,7 +2004,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	buf[fin_size] = 0;
 	origin->file.ptr = buf;
 	origin->file.size = fin_size;
-	pretend_sha1_file(buf, fin_size, blob_type, origin->blob_sha1);
+	pretend_sha1_file(buf, fin_size, OBJ_BLOB, origin->blob_sha1);
 	commit->util = origin;
 
 	/*
@@ -2068,7 +2066,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	int show_stats = 0;
 	const char *revs_file = NULL;
 	const char *final_commit_name = NULL;
-	char type[10];
+	enum object_type type;
 	const char *bottomtop = NULL;
 	const char *contents_from = NULL;
 
@@ -2302,7 +2300,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		if (fill_blob_sha1(o))
 			die("no such path %s in %s", path, final_commit_name);
 
-		sb.final_buf = read_sha1_file(o->blob_sha1, type,
+		sb.final_buf = read_sha1_file(o->blob_sha1, &type,
 					      &sb.final_buf_size);
 	}
 	num_read_blob++;
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 6c16bfa..d61d3d5 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -79,7 +79,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
-	char type[20];
+	enum object_type type;
 	void *buf;
 	unsigned long size;
 	int opt;
@@ -100,14 +100,16 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	buf = NULL;
 	switch (opt) {
 	case 't':
-		if (!sha1_object_info(sha1, type, NULL)) {
-			printf("%s\n", type);
+		type = sha1_object_info(sha1, NULL);
+		if (type > 0) {
+			printf("%s\n", typename(type));
 			return 0;
 		}
 		break;
 
 	case 's':
-		if (!sha1_object_info(sha1, type, &size)) {
+		type = sha1_object_info(sha1, &size);
+		if (type > 0) {
 			printf("%lu\n", size);
 			return 0;
 		}
@@ -117,17 +119,18 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		return !has_sha1_file(sha1);
 
 	case 'p':
-		if (sha1_object_info(sha1, type, NULL))
+		type = sha1_object_info(sha1, NULL);
+		if (type < 0)
 			die("Not a valid object name %s", argv[2]);
 
 		/* custom pretty-print here */
-		if (!strcmp(type, tree_type))
+		if (type == OBJ_TREE)
 			return cmd_ls_tree(2, argv + 1, NULL);
 
-		buf = read_sha1_file(sha1, type, &size);
+		buf = read_sha1_file(sha1, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", argv[2]);
-		if (!strcmp(type, tag_type)) {
+		if (type == OBJ_TAG) {
 			pprint_tag(sha1, buf, size);
 			return 0;
 		}
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 2a818a0..04f61d5 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -47,11 +47,10 @@ static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
 
 static void check_valid(unsigned char *sha1, const char *expect)
 {
-	char type[20];
-
-	if (sha1_object_info(sha1, type, NULL))
+	enum object_type type = sha1_object_info(sha1, NULL);
+	if (type < 0)
 		die("%s is not a valid object", sha1_to_hex(sha1));
-	if (expect && strcmp(type, expect))
+	if (expect && type != type_from_string(expect))
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
 		    expect);
 }
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 14fff2b..b11ca92 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -173,8 +173,8 @@ static void verify_format(const char *format)
  */
 static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned long *sz, int *eaten)
 {
-	char type[20];
-	void *buf = read_sha1_file(sha1, type, sz);
+	enum object_type type;
+	void *buf = read_sha1_file(sha1, &type, sz);
 
 	if (buf)
 		*obj = parse_object_buffer(sha1, type, *sz, buf, eaten);
diff --git a/builtin-grep.c b/builtin-grep.c
index f35f2d0..96b7022 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -84,11 +84,11 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char
 {
 	unsigned long size;
 	char *data;
-	char type[20];
+	enum object_type type;
 	char *to_free = NULL;
 	int hit;
 
-	data = read_sha1_file(sha1, type, &size);
+	data = read_sha1_file(sha1, &type, &size);
 	if (!data) {
 		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
 		return 0;
@@ -380,10 +380,10 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 		else if (S_ISREG(entry.mode))
 			hit |= grep_sha1(opt, entry.sha1, path_buf, tn_len);
 		else if (S_ISDIR(entry.mode)) {
-			char type[20];
+			enum object_type type;
 			struct tree_desc sub;
 			void *data;
-			data = read_sha1_file(entry.sha1, type, &sub.size);
+			data = read_sha1_file(entry.sha1, &type, &sub.size);
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
diff --git a/builtin-log.c b/builtin-log.c
index f43790c..1c9f7d0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -89,8 +89,8 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 static int show_object(const unsigned char *sha1, int suppress_header)
 {
 	unsigned long size;
-	char type[20];
-	char *buf = read_sha1_file(sha1, type, &size);
+	enum object_type type;
+	char *buf = read_sha1_file(sha1, &type, &size);
 	int offset = 0;
 
 	if (!buf)
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c456f49..010f24a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -230,8 +230,8 @@ static unsigned char *find_packed_object_name(struct packed_git *p,
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
 {
 	unsigned long othersize, delta_size;
-	char type[10];
-	void *otherbuf = read_sha1_file(entry->delta->sha1, type, &othersize);
+	enum object_type type;
+	void *otherbuf = read_sha1_file(entry->delta->sha1, &type, &othersize);
 	void *delta_buf;
 
 	if (!otherbuf)
@@ -375,7 +375,7 @@ static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry)
 {
 	unsigned long size;
-	char type[10];
+	enum object_type type;
 	void *buf;
 	unsigned char header[10];
 	unsigned hdrlen, datalen;
@@ -416,7 +416,7 @@ static unsigned long write_object(struct sha1file *f,
 	}
 
 	if (!to_reuse) {
-		buf = read_sha1_file(entry->sha1, type, &size);
+		buf = read_sha1_file(entry->sha1, &type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
 		if (size != entry->size)
@@ -765,7 +765,7 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 	struct pbase_tree_cache *ent, *nent;
 	void *data;
 	unsigned long size;
-	char type[20];
+	enum object_type type;
 	int neigh;
 	int my_ix = pbase_tree_cache_ix(sha1);
 	int available_ix = -1;
@@ -792,10 +792,10 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 	/* Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
-	data = read_sha1_file(sha1, type, &size);
+	data = read_sha1_file(sha1, &type, &size);
 	if (!data)
 		return NULL;
-	if (strcmp(type, tree_type)) {
+	if (type != OBJ_TREE) {
 		free(data);
 		return NULL;
 	}
@@ -854,19 +854,19 @@ static void add_pbase_object(struct tree_desc *tree,
 
 	while (tree_entry(tree,&entry)) {
 		unsigned long size;
-		char type[20];
+		enum object_type type;
 
 		if (entry.pathlen != cmplen ||
 		    memcmp(entry.path, name, cmplen) ||
 		    !has_sha1_file(entry.sha1) ||
-		    sha1_object_info(entry.sha1, type, &size))
+		    (type = sha1_object_info(entry.sha1, &size)) < 0)
 			continue;
 		if (name[cmplen] != '/') {
 			unsigned hash = name_hash(fullname);
 			add_object_entry(entry.sha1, hash, 1);
 			return;
 		}
-		if (!strcmp(type, tree_type)) {
+		if (type == OBJ_TREE) {
 			struct tree_desc sub;
 			struct pbase_tree_cache *tree;
 			const char *down = name+cmplen+1;
@@ -978,8 +978,6 @@ static void add_preferred_base(unsigned char *sha1)
 
 static void check_object(struct object_entry *entry)
 {
-	char type[20];
-
 	if (entry->in_pack && !entry->preferred_base) {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
@@ -1062,10 +1060,10 @@ static void check_object(struct object_entry *entry)
 		/* Otherwise we would do the usual */
 	}
 
-	if (sha1_object_info(entry->sha1, type, &entry->size))
+	entry->type = sha1_object_info(entry->sha1, &entry->size);
+	if (entry->type < 0)
 		die("unable to get type of object %s",
 		    sha1_to_hex(entry->sha1));
-	entry->type = type_from_string(type);
 }
 
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
@@ -1195,7 +1193,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
 	unsigned long trg_size, src_size, delta_size, sizediff, max_size, sz;
-	char type[10];
+	enum object_type type;
 	void *delta_buf;
 
 	/* Don't bother doing diffs between different types */
@@ -1246,13 +1244,13 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
-		trg->data = read_sha1_file(trg_entry->sha1, type, &sz);
+		trg->data = read_sha1_file(trg_entry->sha1, &type, &sz);
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(trg_entry->sha1), sz, trg_size);
 	}
 	if (!src->data) {
-		src->data = read_sha1_file(src_entry->sha1, type, &sz);
+		src->data = read_sha1_file(src_entry->sha1, &type, &sz);
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(src_entry->sha1), sz, src_size);
diff --git a/builtin-prune.c b/builtin-prune.c
index 6f0ba0d..09864b7 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -10,15 +10,10 @@ static int show_only;
 
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
-	char buf[20];
-	const char *type;
-
 	if (show_only) {
-		if (sha1_object_info(sha1, buf, NULL))
-			type = "unknown";
-		else
-			type = buf;
-		printf("%s %s\n", sha1_to_hex(sha1), type);
+		enum object_type type = sha1_object_info(sha1, NULL);
+		printf("%s %s\n", sha1_to_hex(sha1),
+		       (type > 0) ? typename(type) : "unknown");
 		return 0;
 	}
 	unlink(mkpath("%s/%s", path, filename));
diff --git a/builtin-reflog.c b/builtin-reflog.c
index cefb40d..186aabc 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -55,8 +55,8 @@ static int tree_is_complete(const unsigned char *sha1)
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 	if (!desc.buf) {
-		char type[20];
-		void *data = read_sha1_file(sha1, type, &desc.size);
+		enum object_type type;
+		void *data = read_sha1_file(sha1, &type, &desc.size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
 			return 0;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 8f8e898..3956c56 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -119,18 +119,18 @@ struct obj_info {
 
 static struct obj_info *obj_list;
 
-static void added_object(unsigned nr, const char *type, void *data,
-			 unsigned long size);
+static void added_object(unsigned nr, enum object_type type,
+			 void *data, unsigned long size);
 
-static void write_object(unsigned nr, void *buf, unsigned long size,
-			 const char *type)
+static void write_object(unsigned nr, enum object_type type,
+			 void *buf, unsigned long size)
 {
-	if (write_sha1_file(buf, size, type, obj_list[nr].sha1) < 0)
+	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
 		die("failed to write object");
 	added_object(nr, type, buf, size);
 }
 
-static void resolve_delta(unsigned nr, const char *type,
+static void resolve_delta(unsigned nr, enum object_type type,
 			  void *base, unsigned long base_size,
 			  void *delta, unsigned long delta_size)
 {
@@ -143,12 +143,12 @@ static void resolve_delta(unsigned nr, const char *type,
 	if (!result)
 		die("failed to apply delta");
 	free(delta);
-	write_object(nr, result, result_size, type);
+	write_object(nr, type, result, result_size);
 	free(result);
 }
 
-static void added_object(unsigned nr, const char *type, void *data,
-			 unsigned long size)
+static void added_object(unsigned nr, enum object_type type,
+			 void *data, unsigned long size)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
@@ -167,33 +167,24 @@ static void added_object(unsigned nr, const char *type, void *data,
 	}
 }
 
-static void unpack_non_delta_entry(enum object_type kind, unsigned long size,
+static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
 	void *buf = get_data(size);
-	const char *type;
-
-	switch (kind) {
-	case OBJ_COMMIT: type = commit_type; break;
-	case OBJ_TREE:   type = tree_type; break;
-	case OBJ_BLOB:   type = blob_type; break;
-	case OBJ_TAG:    type = tag_type; break;
-	default: die("bad type %d", kind);
-	}
+
 	if (!dry_run && buf)
-		write_object(nr, buf, size, type);
+		write_object(nr, type, buf, size);
 	free(buf);
 }
 
-static void unpack_delta_entry(enum object_type kind, unsigned long delta_size,
+static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			       unsigned nr)
 {
 	void *delta_data, *base;
 	unsigned long base_size;
-	char type[20];
 	unsigned char base_sha1[20];
 
-	if (kind == OBJ_REF_DELTA) {
+	if (type == OBJ_REF_DELTA) {
 		hashcpy(base_sha1, fill(20));
 		use(20);
 		delta_data = get_data(delta_size);
@@ -255,7 +246,7 @@ static void unpack_delta_entry(enum object_type kind, unsigned long delta_size,
 		}
 	}
 
-	base = read_sha1_file(base_sha1, type, &base_size);
+	base = read_sha1_file(base_sha1, &type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
 		      sha1_to_hex(base_sha1));
diff --git a/cache.h b/cache.h
index 8bbc142..0117b7e 100644
--- a/cache.h
+++ b/cache.h
@@ -262,13 +262,25 @@ int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
 
+enum object_type {
+	OBJ_NONE = 0,
+	OBJ_COMMIT = 1,
+	OBJ_TREE = 2,
+	OBJ_BLOB = 3,
+	OBJ_TAG = 4,
+	/* 5 for future expansion */
+	OBJ_OFS_DELTA = 6,
+	OBJ_REF_DELTA = 7,
+	OBJ_BAD,
+};
+
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
-extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
+extern int sha1_object_info(const unsigned char *, unsigned long *);
+extern void * unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size);
+extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
 extern int hash_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
-extern int pretend_sha1_file(void *, unsigned long, const char *, unsigned char *);
+extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
@@ -285,18 +297,6 @@ extern int legacy_loose_object(unsigned char *);
 extern int has_pack_file(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
 
-enum object_type {
-	OBJ_NONE = 0,
-	OBJ_COMMIT = 1,
-	OBJ_TREE = 2,
-	OBJ_BLOB = 3,
-	OBJ_TAG = 4,
-	/* 5 for future expansion */
-	OBJ_OFS_DELTA = 6,
-	OBJ_REF_DELTA = 7,
-	OBJ_BAD,
-};
-
 extern signed char hexval_table[256];
 static inline unsigned int hexval(unsigned int c)
 {
@@ -422,9 +422,9 @@ extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
 extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
-extern void *unpack_entry(struct packed_git *, unsigned long, char *, unsigned long *);
+extern void *unpack_entry(struct packed_git *, unsigned long, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern void packed_object_info_detail(struct packed_git *, unsigned long, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern const char *packed_object_info_detail(struct packed_git *, unsigned long, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/combine-diff.c b/combine-diff.c
index a5f2c8d..8205486 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -92,14 +92,14 @@ struct sline {
 static char *grab_blob(const unsigned char *sha1, unsigned long *size)
 {
 	char *blob;
-	char type[20];
+	enum object_type type;
 	if (is_null_sha1(sha1)) {
 		/* deleted blob */
 		*size = 0;
 		return xcalloc(1, 1);
 	}
-	blob = read_sha1_file(sha1, type, size);
-	if (strcmp(type, blob_type))
+	blob = read_sha1_file(sha1, &type, size);
+	if (type != OBJ_BLOB)
 		die("object '%s' is not a blob!", sha1_to_hex(sha1));
 	return blob;
 }
diff --git a/commit.c b/commit.c
index fb75ae5..5552527 100644
--- a/commit.c
+++ b/commit.c
@@ -352,18 +352,18 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 
 int parse_commit(struct commit *item)
 {
-	char type[20];
+	enum object_type type;
 	void *buffer;
 	unsigned long size;
 	int ret;
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, type, &size);
+	buffer = read_sha1_file(item->object.sha1, &type, &size);
 	if (!buffer)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, commit_type)) {
+	if (type != OBJ_COMMIT) {
 		free(buffer);
 		return error("Object %s not a commit",
 			     sha1_to_hex(item->object.sha1));
diff --git a/convert-objects.c b/convert-objects.c
index a630132..b5f41ae 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -284,27 +284,27 @@ static void convert_commit(void *buffer, unsigned long size, unsigned char *resu
 static struct entry * convert_entry(unsigned char *sha1)
 {
 	struct entry *entry = lookup_entry(sha1);
-	char type[20];
+	enum object_type type;
 	void *buffer, *data;
 	unsigned long size;
 
 	if (entry->converted)
 		return entry;
-	data = read_sha1_file(sha1, type, &size);
+	data = read_sha1_file(sha1, &type, &size);
 	if (!data)
 		die("unable to read object %s", sha1_to_hex(sha1));
 
 	buffer = xmalloc(size);
 	memcpy(buffer, data, size);
 
-	if (!strcmp(type, blob_type)) {
+	if (type == OBJ_BLOB) {
 		write_sha1_file(buffer, size, blob_type, entry->new_sha1);
-	} else if (!strcmp(type, tree_type))
+	} else if (type == OBJ_TREE)
 		convert_tree(buffer, size, entry->new_sha1);
-	else if (!strcmp(type, commit_type))
+	else if (type == OBJ_COMMIT)
 		convert_commit(buffer, size, entry->new_sha1);
 	else
-		die("unknown object type '%s' in %s", type, sha1_to_hex(sha1));
+		die("unknown object type %d in %s", type, sha1_to_hex(sha1));
 	entry->converted = 1;
 	free(buffer);
 	free(data);
diff --git a/diff.c b/diff.c
index 6bd456e..f097626 100644
--- a/diff.c
+++ b/diff.c
@@ -1430,7 +1430,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		}
 	}
 	else {
-		char type[20];
+		enum object_type type;
 		struct sha1_size_cache *e;
 
 		if (size_only) {
@@ -1439,11 +1439,12 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 				s->size = e->size;
 				return 0;
 			}
-			if (!sha1_object_info(s->sha1, type, &s->size))
+			type = sha1_object_info(s->sha1, &s->size);
+			if (type < 0)
 				locate_size_cache(s->sha1, 0, s->size);
 		}
 		else {
-			s->data = read_sha1_file(s->sha1, type, &s->size);
+			s->data = read_sha1_file(s->sha1, &type, &s->size);
 			s->should_free = 1;
 		}
 	}
diff --git a/entry.c b/entry.c
index 472a9ef..21b5f2e 100644
--- a/entry.c
+++ b/entry.c
@@ -68,10 +68,10 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 	void *new;
 	unsigned long size;
 	long wrote;
-	char type[20];
+	enum object_type type;
 
-	new = read_sha1_file(ce->sha1, type, &size);
-	if (!new || strcmp(type, blob_type)) {
+	new = read_sha1_file(ce->sha1, &type, &size);
+	if (!new || type != OBJ_BLOB) {
 		if (new)
 			free(new);
 		return error("git-checkout-index: unable to read sha1 file of %s (%s)",
diff --git a/fast-import.c b/fast-import.c
index aa9eac3..65e99c2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1008,11 +1008,11 @@ static void *gfi_unpack_entry(
 	struct object_entry *oe,
 	unsigned long *sizep)
 {
-	static char type[20];
+	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
 	if (p == pack_data)
 		p->pack_size = pack_size + 20;
-	return unpack_entry(p, oe->offset, type, sizep);
+	return unpack_entry(p, oe->offset, &type, sizep);
 }
 
 static const char *get_mode(const char *str, uint16_t *modep)
@@ -1049,9 +1049,9 @@ static void load_tree(struct tree_entry *root)
 		t->delta_depth = 0;
 		buf = gfi_unpack_entry(myoe, &size);
 	} else {
-		char type[20];
-		buf = read_sha1_file(sha1, type, &size);
-		if (!buf || strcmp(type, tree_type))
+		enum object_type type;
+		buf = read_sha1_file(sha1, &type, &size);
+		if (!buf || type != OBJ_TREE)
 			die("Can't load tree %s", sha1_to_hex(sha1));
 	}
 
@@ -1573,7 +1573,6 @@ static void file_change_m(struct branch *b)
 	struct object_entry *oe = oe;
 	unsigned char sha1[20];
 	uint16_t mode, inline_data = 0;
-	char type[20];
 
 	p = get_mode(p, &mode);
 	if (!p)
@@ -1628,11 +1627,12 @@ static void file_change_m(struct branch *b)
 			die("Not a blob (actually a %s): %s",
 				command_buf.buf, typename(oe->type));
 	} else {
-		if (sha1_object_info(sha1, type, NULL))
+		enum object_type type = sha1_object_info(sha1, NULL);
+		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
-		if (strcmp(blob_type, type))
+		if (type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
-				command_buf.buf, type);
+			    typename(type), command_buf.buf);
 	}
 
 	tree_content_set(&b->branch_tree, p, sha1, S_IFREG | mode);
diff --git a/http-push.c b/http-push.c
index 9ad6fd0..0fd73db 100644
--- a/http-push.c
+++ b/http-push.c
@@ -479,7 +479,7 @@ static void start_put(struct transfer_request *request)
 	char *hex = sha1_to_hex(request->obj->sha1);
 	struct active_request_slot *slot;
 	char *posn;
-	char type[20];
+	enum object_type type;
 	char hdr[50];
 	void *unpacked;
 	unsigned long len;
@@ -487,8 +487,8 @@ static void start_put(struct transfer_request *request)
 	ssize_t size;
 	z_stream stream;
 
-	unpacked = read_sha1_file(request->obj->sha1, type, &len);
-	hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
+	unpacked = read_sha1_file(request->obj->sha1, &type, &len);
+	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
diff --git a/index-pack.c b/index-pack.c
index c25cd40..859ec01 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -596,25 +596,23 @@ static void fix_unresolved_deltas(int nr_unresolved)
 		struct delta_entry *d = sorted_by_pos[i];
 		void *data;
 		unsigned long size;
-		char type[10];
-		enum object_type obj_type;
+		enum object_type type;
 		int j, first, last;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		data = read_sha1_file(d->base.sha1, type, &size);
+		data = read_sha1_file(d->base.sha1, &type, &size);
 		if (!data)
 			continue;
 
-		obj_type = type_from_string(type);
 		find_delta_children(&d->base, &first, &last);
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
 			if (child->real_type == OBJ_REF_DELTA)
-				resolve_delta(child, data, size, obj_type);
+				resolve_delta(child, data, size, type);
 		}
 
-		append_obj_to_pack(data, size, obj_type);
+		append_obj_to_pack(data, size, type);
 		free(data);
 		if (verbose)
 			percent = display_progress(nr_resolved_deltas,
diff --git a/merge-file.c b/merge-file.c
index 69dc1eb..748d15c 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -7,12 +7,12 @@ static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
 	void *buf;
 	unsigned long size;
-	char type[20];
+	enum object_type type;
 
-	buf = read_sha1_file(obj->object.sha1, type, &size);
+	buf = read_sha1_file(obj->object.sha1, &type, &size);
 	if (!buf)
 		return -1;
-	if (strcmp(type, blob_type))
+	if (type != OBJ_BLOB)
 		return -1;
 	f->ptr = buf;
 	f->size = size;
@@ -86,12 +86,12 @@ void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsign
 	 * modified in the other branch!
 	 */
 	if (!our || !their) {
-		char type[20];
+		enum object_type type;
 		if (base)
 			return NULL;
 		if (!our)
 			our = their;
-		return read_sha1_file(our->object.sha1, type, size);
+		return read_sha1_file(our->object.sha1, &type, size);
 	}
 
 	if (fill_mmfile_blob(&f1, our) < 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index 5898942..ec8294d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -560,14 +560,14 @@ static void update_file_flags(const unsigned char *sha,
 		update_wd = 0;
 
 	if (update_wd) {
-		char type[20];
+		enum object_type type;
 		void *buf;
 		unsigned long size;
 
-		buf = read_sha1_file(sha, type, &size);
+		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
-		if (strcmp(type, blob_type) != 0)
+		if (type != OBJ_BLOB)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
 
 		if (S_ISREG(mode)) {
@@ -620,7 +620,7 @@ struct merge_file_info
 static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 {
 	unsigned long size;
-	char type[20];
+	enum object_type type;
 
 	if (!hashcmp(sha1, null_sha1)) {
 		mm->ptr = xstrdup("");
@@ -628,8 +628,8 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 		return;
 	}
 
-	mm->ptr = read_sha1_file(sha1, type, &size);
-	if (!mm->ptr || strcmp(type, blob_type))
+	mm->ptr = read_sha1_file(sha1, &type, &size);
+	if (!mm->ptr || type != OBJ_BLOB)
 		die("unable to read blob object %s", sha1_to_hex(sha1));
 	mm->size = size;
 }
@@ -1213,7 +1213,7 @@ static int merge(struct commit *h1,
 
 		tree->object.parsed = 1;
 		tree->object.type = OBJ_TREE;
-		pretend_sha1_file(NULL, 0, tree_type, tree->object.sha1);
+		pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/merge-tree.c b/merge-tree.c
index 692ede0..b2867ba 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -57,11 +57,11 @@ extern void *merge_file(struct blob *, struct blob *, struct blob *, unsigned lo
 
 static void *result(struct merge_list *entry, unsigned long *size)
 {
-	char type[20];
+	enum object_type type;
 	struct blob *base, *our, *their;
 
 	if (!entry->stage)
-		return read_sha1_file(entry->blob->object.sha1, type, size);
+		return read_sha1_file(entry->blob->object.sha1, &type, size);
 	base = NULL;
 	if (entry->stage == 1) {
 		base = entry->blob;
@@ -80,10 +80,10 @@ static void *result(struct merge_list *entry, unsigned long *size)
 
 static void *origin(struct merge_list *entry, unsigned long *size)
 {
-	char type[20];
+	enum object_type type;
 	while (entry) {
 		if (entry->stage == 2)
-			return read_sha1_file(entry->blob->object.sha1, type, size);
+			return read_sha1_file(entry->blob->object.sha1, &type, size);
 		entry = entry->link;
 	}
 	return NULL;
diff --git a/mktag.c b/mktag.c
index 3448a5d..9310111 100644
--- a/mktag.c
+++ b/mktag.c
@@ -27,13 +27,13 @@
 static int verify_object(unsigned char *sha1, const char *expected_type)
 {
 	int ret = -1;
-	char type[100];
+	enum object_type type;
 	unsigned long size;
-	void *buffer = read_sha1_file(sha1, type, &size);
+	void *buffer = read_sha1_file(sha1, &type, &size);
 
 	if (buffer) {
-		if (!strcmp(type, expected_type))
-			ret = check_sha1_signature(sha1, buffer, size, type);
+		if (type == type_from_string(expected_type))
+			ret = check_sha1_signature(sha1, buffer, size, expected_type);
 		free(buffer);
 	}
 	return ret;
diff --git a/mktree.c b/mktree.c
index 56205d1..d86dde8 100644
--- a/mktree.c
+++ b/mktree.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 		int len;
 		char *ptr, *ntr;
 		unsigned mode;
-		char type[20];
+		enum object_type type;
 		char *path;
 
 		read_line(&sb, stdin, line_termination);
@@ -115,11 +115,12 @@ int main(int ac, char **av)
 		    ntr[41] != '\t' ||
 		    get_sha1_hex(ntr + 1, sha1))
 			die("input format error: %s", sb.buf);
-		if (sha1_object_info(sha1, type, NULL))
+		type = sha1_object_info(sha1, NULL);
+		if (type < 0)
 			die("object %s unavailable", sha1_to_hex(sha1));
 		*ntr++ = 0; /* now at the beginning of SHA1 */
-		if (strcmp(ptr, type))
-			die("object type %s mismatch (%s)", ptr, type);
+		if (type != type_from_string(ptr))
+			die("object type %s mismatch (%s)", ptr, typename(type));
 		ntr += 41; /* at the beginning of name */
 		if (line_termination && ntr[0] == '"')
 			path = unquote_c_style(ntr, NULL);
diff --git a/object.c b/object.c
index 37cedc0..0e67af3 100644
--- a/object.c
+++ b/object.c
@@ -158,23 +158,23 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	return obj;
 }
 
-struct object *parse_object_buffer(const unsigned char *sha1, const char *type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer(const unsigned char *sha1, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	int eaten = 0;
 
-	if (!strcmp(type, blob_type)) {
+	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(sha1);
 		parse_blob_buffer(blob, buffer, size);
 		obj = &blob->object;
-	} else if (!strcmp(type, tree_type)) {
+	} else if (type == OBJ_TREE) {
 		struct tree *tree = lookup_tree(sha1);
 		obj = &tree->object;
 		if (!tree->object.parsed) {
 			parse_tree_buffer(tree, buffer, size);
 			eaten = 1;
 		}
-	} else if (!strcmp(type, commit_type)) {
+	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(sha1);
 		parse_commit_buffer(commit, buffer, size);
 		if (!commit->buffer) {
@@ -182,7 +182,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, const char *type,
 			eaten = 1;
 		}
 		obj = &commit->object;
-	} else if (!strcmp(type, tag_type)) {
+	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(sha1);
 		parse_tag_buffer(tag, buffer, size);
 		obj = &tag->object;
@@ -196,13 +196,13 @@ struct object *parse_object_buffer(const unsigned char *sha1, const char *type,
 struct object *parse_object(const unsigned char *sha1)
 {
 	unsigned long size;
-	char type[20];
+	enum object_type type;
 	int eaten;
-	void *buffer = read_sha1_file(sha1, type, &size);
+	void *buffer = read_sha1_file(sha1, &type, &size);
 
 	if (buffer) {
 		struct object *obj;
-		if (check_sha1_signature(sha1, buffer, size, type) < 0)
+		if (check_sha1_signature(sha1, buffer, size, typename(type)) < 0)
 			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
 
 		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
diff --git a/object.h b/object.h
index ade4dae..749a6f5 100644
--- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object *parse_object(const unsigned char *sha1);
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(const unsigned char *sha1, const char *type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(const unsigned char *sha1, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
diff --git a/pack-check.c b/pack-check.c
index 08a9fd8..ac7751d 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -43,7 +43,7 @@ static int verify_packfile(struct packed_git *p,
 	for (i = err = 0; i < nr_objects; i++) {
 		unsigned char sha1[20];
 		void *data;
-		char type[20];
+		enum object_type type;;
 		unsigned long size, offset;
 
 		if (nth_packed_object_sha1(p, i, sha1))
@@ -51,13 +51,13 @@ static int verify_packfile(struct packed_git *p,
 		offset = find_pack_entry_one(sha1, p);
 		if (!offset)
 			die("internal error pack-check find-pack-entry-one");
-		data = unpack_entry(p, offset, type, &size);
+		data = unpack_entry(p, offset, &type, &size);
 		if (!data) {
 			err = error("cannot unpack %s from %s",
 				    sha1_to_hex(sha1), p->pack_name);
 			continue;
 		}
-		if (check_sha1_signature(sha1, data, size, type)) {
+		if (check_sha1_signature(sha1, data, size, typename(type))) {
 			err = error("packed %s from %s is corrupt",
 				    sha1_to_hex(sha1), p->pack_name);
 			free(data);
@@ -82,7 +82,7 @@ static void show_pack_info(struct packed_git *p)
 
 	for (i = 0; i < nr_objects; i++) {
 		unsigned char sha1[20], base_sha1[20];
-		char type[20];
+		const char *type;
 		unsigned long size;
 		unsigned long store_size;
 		unsigned long offset;
@@ -94,9 +94,9 @@ static void show_pack_info(struct packed_git *p)
 		if (!offset)
 			die("internal error pack-check find-pack-entry-one");
 
-		packed_object_info_detail(p, offset, type, &size, &store_size,
-					  &delta_chain_length,
-					  base_sha1);
+		type = packed_object_info_detail(p, offset, &size, &store_size,
+						 &delta_chain_length,
+						 base_sha1);
 		printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length)
 			printf("%-6s %lu %lu\n", type, size, offset);
diff --git a/read-cache.c b/read-cache.c
index 605b352..d637464 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -72,7 +72,7 @@ static int ce_compare_link(struct cache_entry *ce, unsigned long expected_size)
 	char *target;
 	void *buffer;
 	unsigned long size;
-	char type[10];
+	enum object_type type;
 	int len;
 
 	target = xmalloc(expected_size);
@@ -81,7 +81,7 @@ static int ce_compare_link(struct cache_entry *ce, unsigned long expected_size)
 		free(target);
 		return -1;
 	}
-	buffer = read_sha1_file(ce->sha1, type, &size);
+	buffer = read_sha1_file(ce->sha1, &type, &size);
 	if (!buffer) {
 		free(target);
 		return -1;
diff --git a/sha1_file.c b/sha1_file.c
index 423ff0a..136e79b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -983,8 +983,9 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
+static int parse_sha1_header(const char *hdr, unsigned long *sizep)
 {
+	char type[10];
 	int i;
 	unsigned long size;
 
@@ -993,16 +994,16 @@ static int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
 	 * terminating '\0' that we add), and is followed by
 	 * a space. 
 	 */
-	i = 10;
+	i = 0;
 	for (;;) {
 		char c = *hdr++;
 		if (c == ' ')
 			break;
-		if (!--i)
+		type[i++] = c;
+		if (i >= sizeof(type))
 			return -1;
-		*type++ = c;
 	}
-	*type = 0;
+	type[i] = 0;
 
 	/*
 	 * The length must follow immediately, and be in canonical
@@ -1025,17 +1026,17 @@ static int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : 0;
+	return *hdr ? -1 : type_from_string(type);
 }
 
-void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
+void * unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size)
 {
 	int ret;
 	z_stream stream;
 	char hdr[8192];
 
 	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
-	if (ret < Z_OK || parse_sha1_header(hdr, type, size) < 0)
+	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
 		return NULL;
 
 	return unpack_sha1_rest(&stream, hdr, *size);
@@ -1044,7 +1045,7 @@ void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned l
 static unsigned long get_delta_base(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    unsigned long *curpos,
-				    enum object_type kind,
+				    enum object_type type,
 				    unsigned long delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
@@ -1056,7 +1057,7 @@ static unsigned long get_delta_base(struct packed_git *p,
 	 * that is assured.  An OFS_DELTA longer than the hash size
 	 * is stupid, as then a REF_DELTA would be smaller to store.
 	 */
-	if (kind == OBJ_OFS_DELTA) {
+	if (type == OBJ_OFS_DELTA) {
 		unsigned used = 0;
 		unsigned char c = base_info[used++];
 		base_offset = c & 127;
@@ -1071,7 +1072,7 @@ static unsigned long get_delta_base(struct packed_git *p,
 		if (base_offset >= delta_obj_offset)
 			die("delta base offset out of bound");
 		*curpos += used;
-	} else if (kind == OBJ_REF_DELTA) {
+	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset = find_pack_entry_one(base_info, p);
 		if (!base_offset)
@@ -1085,28 +1086,25 @@ static unsigned long get_delta_base(struct packed_git *p,
 
 /* forward declaration for a mutually recursive function */
 static int packed_object_info(struct packed_git *p, unsigned long offset,
-			      char *type, unsigned long *sizep);
+			      unsigned long *sizep);
 
 static int packed_delta_info(struct packed_git *p,
 			     struct pack_window **w_curs,
 			     unsigned long curpos,
-			     enum object_type kind,
+			     enum object_type type,
 			     unsigned long obj_offset,
-			     char *type,
 			     unsigned long *sizep)
 {
 	unsigned long base_offset;
-
-	base_offset = get_delta_base(p, w_curs, &curpos, kind, obj_offset);
+	
+	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
+	type = packed_object_info(p, base_offset, NULL);
 
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
 	 * based on a base with a wrong size.  This saves tons of
 	 * inflate() calls.
 	 */
-	if (packed_object_info(p, base_offset, type, NULL))
-		die("cannot get info for delta-pack base");
-
 	if (sizep) {
 		const unsigned char *data;
 		unsigned char delta_head[20], *in;
@@ -1141,7 +1139,8 @@ static int packed_delta_info(struct packed_git *p,
 		/* Read the result size */
 		*sizep = get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 	}
-	return 0;
+
+	return type;
 }
 
 static int unpack_object_header(struct packed_git *p,
@@ -1169,38 +1168,36 @@ static int unpack_object_header(struct packed_git *p,
 	return type;
 }
 
-void packed_object_info_detail(struct packed_git *p,
-			       unsigned long obj_offset,
-			       char *type,
-			       unsigned long *size,
-			       unsigned long *store_size,
-			       unsigned int *delta_chain_length,
-			       unsigned char *base_sha1)
+const char *packed_object_info_detail(struct packed_git *p,
+				      unsigned long obj_offset,
+				      unsigned long *size,
+				      unsigned long *store_size,
+				      unsigned int *delta_chain_length,
+				      unsigned char *base_sha1)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long curpos, dummy;
 	unsigned char *next_sha1;
-	enum object_type kind;
+	enum object_type type;
 
 	*delta_chain_length = 0;
 	curpos = obj_offset;
-	kind = unpack_object_header(p, &w_curs, &curpos, size);
+	type = unpack_object_header(p, &w_curs, &curpos, size);
 
 	for (;;) {
-		switch (kind) {
+		switch (type) {
 		default:
 			die("pack %s contains unknown object type %d",
-			    p->pack_name, kind);
+			    p->pack_name, type);
 		case OBJ_COMMIT:
 		case OBJ_TREE:
 		case OBJ_BLOB:
 		case OBJ_TAG:
-			strcpy(type, typename(kind));
 			*store_size = 0; /* notyet */
 			unuse_pack(&w_curs);
-			return;
+			return typename(type);
 		case OBJ_OFS_DELTA:
-			obj_offset = get_delta_base(p, &w_curs, &curpos, kind, obj_offset);
+			obj_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
 			if (*delta_chain_length == 0) {
 				/* TODO: find base_sha1 as pointed by curpos */
 			}
@@ -1214,39 +1211,38 @@ void packed_object_info_detail(struct packed_git *p,
 		}
 		(*delta_chain_length)++;
 		curpos = obj_offset;
-		kind = unpack_object_header(p, &w_curs, &curpos, &dummy);
+		type = unpack_object_header(p, &w_curs, &curpos, &dummy);
 	}
 }
 
 static int packed_object_info(struct packed_git *p, unsigned long obj_offset,
-			      char *type, unsigned long *sizep)
+			      unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size, curpos = obj_offset;
-	enum object_type kind;
+	enum object_type type;
 
-	kind = unpack_object_header(p, &w_curs, &curpos, &size);
+	type = unpack_object_header(p, &w_curs, &curpos, &size);
 
-	switch (kind) {
+	switch (type) {
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
-		packed_delta_info(p, &w_curs, curpos, kind,
-				  obj_offset, type, sizep);
+		type = packed_delta_info(p, &w_curs, curpos,
+					 type, obj_offset, sizep);
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		strcpy(type, typename(kind));
 		if (sizep)
 			*sizep = size;
 		break;
 	default:
 		die("pack %s contains unknown object type %d",
-		    p->pack_name, kind);
+		    p->pack_name, type);
 	}
 	unuse_pack(&w_curs);
-	return 0;
+	return type;
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
@@ -1284,15 +1280,14 @@ static void *unpack_delta_entry(struct packed_git *p,
 				struct pack_window **w_curs,
 				unsigned long curpos,
 				unsigned long delta_size,
-				enum object_type kind,
 				unsigned long obj_offset,
-				char *type,
+				enum object_type *type,
 				unsigned long *sizep)
 {
 	void *delta_data, *result, *base;
-	unsigned long result_size, base_size, base_offset;
+	unsigned long base_size, base_offset;
 
-	base_offset = get_delta_base(p, w_curs, &curpos, kind, obj_offset);
+	base_offset = get_delta_base(p, w_curs, &curpos, *type, obj_offset);
 	base = unpack_entry(p, base_offset, type, &base_size);
 	if (!base)
 		die("failed to read delta base object at %lu from %s",
@@ -1301,43 +1296,39 @@ static void *unpack_delta_entry(struct packed_git *p,
 	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
-			     &result_size);
+			     sizep);
 	if (!result)
 		die("failed to apply delta");
 	free(delta_data);
 	free(base);
-	*sizep = result_size;
 	return result;
 }
 
 void *unpack_entry(struct packed_git *p, unsigned long obj_offset,
-		   char *type, unsigned long *sizep)
+		   enum object_type *type, unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size, curpos = obj_offset;
-	enum object_type kind;
-	void *retval;
+	unsigned long curpos = obj_offset;
+	void *data;
 
-	kind = unpack_object_header(p, &w_curs, &curpos, &size);
-	switch (kind) {
+	*type = unpack_object_header(p, &w_curs, &curpos, sizep);
+	switch (*type) {
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
-		retval = unpack_delta_entry(p, &w_curs, curpos, size,
-			kind, obj_offset, type, sizep);
+		data = unpack_delta_entry(p, &w_curs, curpos, *sizep,
+					  obj_offset, type, sizep);
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		strcpy(type, typename(kind));
-		*sizep = size;
-		retval = unpack_compressed_entry(p, &w_curs, curpos, size);
+		data = unpack_compressed_entry(p, &w_curs, curpos, *sizep);
 		break;
 	default:
-		die("unknown object type %i in %s", kind, p->pack_name);
+		die("unknown object type %i in %s", *type, p->pack_name);
 	}
 	unuse_pack(&w_curs);
-	return retval;
+	return data;
 }
 
 int num_packed_objects(const struct packed_git *p)
@@ -1447,7 +1438,7 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 	
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
+static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
 	int status;
 	unsigned long mapsize, size;
@@ -1461,31 +1452,29 @@ static int sha1_loose_object_info(const unsigned char *sha1, char *type, unsigne
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
-	else if (parse_sha1_header(hdr, type, &size) < 0)
+	else if ((status = parse_sha1_header(hdr, &size)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
-	else {
-		status = 0;
-		if (sizep)
-			*sizep = size;
-	}
+	else if (sizep)
+		*sizep = size;
 	inflateEnd(&stream);
 	munmap(map, mapsize);
 	return status;
 }
 
-int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
+int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
 	struct pack_entry e;
 
 	if (!find_pack_entry(sha1, &e, NULL)) {
 		reprepare_packed_git();
 		if (!find_pack_entry(sha1, &e, NULL))
-			return sha1_loose_object_info(sha1, type, sizep);
+			return sha1_loose_object_info(sha1, sizep);
 	}
-	return packed_object_info(e.p, e.offset, type, sizep);
+	return packed_object_info(e.p, e.offset, sizep);
 }
 
-static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned long *size)
+static void *read_packed_sha1(const unsigned char *sha1,
+			      enum object_type *type, unsigned long *size)
 {
 	struct pack_entry e;
 
@@ -1503,7 +1492,7 @@ static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned lo
  */
 static struct cached_object {
 	unsigned char sha1[20];
-	const char *type;
+	enum object_type type;
 	void *buf;
 	unsigned long size;
 } *cached_objects;
@@ -1521,11 +1510,12 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 	return NULL;
 }
 
-int pretend_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1)
+int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
+		      unsigned char *sha1)
 {
 	struct cached_object *co;
 
-	hash_sha1_file(buf, len, type, sha1);
+	hash_sha1_file(buf, len, typename(type), sha1);
 	if (has_sha1_file(sha1) || find_cached_object(sha1))
 		return 0;
 	if (cached_object_alloc <= cached_object_nr) {
@@ -1536,14 +1526,15 @@ int pretend_sha1_file(void *buf, unsigned long len, const char *type, unsigned c
 	}
 	co = &cached_objects[cached_object_nr++];
 	co->size = len;
-	co->type = strdup(type);
+	co->type = type;
 	co->buf = xmalloc(len);
 	memcpy(co->buf, buf, len);
 	hashcpy(co->sha1, sha1);
 	return 0;
 }
 
-void *read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
+void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
+		     unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
@@ -1554,7 +1545,7 @@ void *read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 		buf = xmalloc(co->size + 1);
 		memcpy(buf, co->buf, co->size);
 		((char*)buf)[co->size] = 0;
-		strcpy(type, co->type);
+		*type = co->type;
 		*size = co->size;
 		return buf;
 	}
@@ -1573,33 +1564,34 @@ void *read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 }
 
 void *read_object_with_reference(const unsigned char *sha1,
-				 const char *required_type,
+				 const char *required_type_name,
 				 unsigned long *size,
 				 unsigned char *actual_sha1_return)
 {
-	char type[20];
+	enum object_type type, required_type;
 	void *buffer;
 	unsigned long isize;
 	unsigned char actual_sha1[20];
 
+	required_type = type_from_string(required_type_name);
 	hashcpy(actual_sha1, sha1);
 	while (1) {
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = read_sha1_file(actual_sha1, type, &isize);
+		buffer = read_sha1_file(actual_sha1, &type, &isize);
 		if (!buffer)
 			return NULL;
-		if (!strcmp(type, required_type)) {
+		if (type == required_type) {
 			*size = isize;
 			if (actual_sha1_return)
 				hashcpy(actual_sha1_return, actual_sha1);
 			return buffer;
 		}
 		/* Handle references */
-		else if (!strcmp(type, commit_type))
+		else if (type == OBJ_COMMIT)
 			ref_type = "tree ";
-		else if (!strcmp(type, tag_type))
+		else if (type == OBJ_TAG)
 			ref_type = "object ";
 		else {
 			free(buffer);
@@ -1841,17 +1833,17 @@ static void *repack_object(const unsigned char *sha1, unsigned long *objsize)
 	z_stream stream;
 	unsigned char *unpacked;
 	unsigned long len;
-	char type[20];
+	enum object_type type;;
 	char hdr[32];
 	int hdrlen;
 	void *buf;
 
 	/* need to unpack and recompress it by itself */
-	unpacked = read_packed_sha1(sha1, type, &len);
+	unpacked = read_packed_sha1(sha1, &type, &len);
 	if (!unpacked)
 		error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 
-	hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
+	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
diff --git a/tag.c b/tag.c
index 864ac1b..30ffc17 100644
--- a/tag.c
+++ b/tag.c
@@ -85,18 +85,18 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 
 int parse_tag(struct tag *item)
 {
-	char type[20];
+	enum object_type type;
 	void *data;
 	unsigned long size;
 	int ret;
 
 	if (item->object.parsed)
 		return 0;
-	data = read_sha1_file(item->object.sha1, type, &size);
+	data = read_sha1_file(item->object.sha1, &type, &size);
 	if (!data)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, tag_type)) {
+	if (type != OBJ_TAG) {
 		free(data);
 		return error("Object %s not a tag",
 			     sha1_to_hex(item->object.sha1));
diff --git a/tree-diff.c b/tree-diff.c
index 37d235e..c827582 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -139,13 +139,13 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 	const unsigned char *sha1 = tree_entry_extract(desc, &path, &mode);
 
 	if (opt->recursive && S_ISDIR(mode)) {
-		char type[20];
+		enum object_type type;
 		char *newbase = malloc_base(base, path, strlen(path));
 		struct tree_desc inner;
 		void *tree;
 
-		tree = read_sha1_file(sha1, type, &inner.size);
-		if (!tree || strcmp(type, tree_type))
+		tree = read_sha1_file(sha1, &type, &inner.size);
+		if (!tree || type != OBJ_TREE)
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
 		inner.buf = tree;
diff --git a/tree.c b/tree.c
index b6f02fe..46923ee 100644
--- a/tree.c
+++ b/tree.c
@@ -190,17 +190,17 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 
 int parse_tree(struct tree *item)
 {
-	 char type[20];
+	 enum object_type type;
 	 void *buffer;
 	 unsigned long size;
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, type, &size);
+	buffer = read_sha1_file(item->object.sha1, &type, &size);
 	if (!buffer)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, tree_type)) {
+	if (type != OBJ_TREE) {
 		free(buffer);
 		return error("Object %s not a tree",
 			     sha1_to_hex(item->object.sha1));
diff --git a/unpack-file.c b/unpack-file.c
index d24acc2..25c56b3 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -5,12 +5,12 @@ static char *create_temp_file(unsigned char *sha1)
 {
 	static char path[50];
 	void *buf;
-	char type[100];
+	enum object_type type;
 	unsigned long size;
 	int fd;
 
-	buf = read_sha1_file(sha1, type, &size);
-	if (!buf || strcmp(type, blob_type))
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", sha1_to_hex(sha1));
 
 	strcpy(path, ".merge_file_XXXXXX");
-- 
1.5.0.572.ge86d
