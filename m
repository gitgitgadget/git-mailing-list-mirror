From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Use _type constants instead of litteral constants
Date: Sun, 2 Apr 2006 15:00:52 +0200
Message-ID: <20060402130051.GA2933@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 02 15:14:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ2Pb-0006Cm-T8
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 15:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWDBNOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 09:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWDBNOc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 09:14:32 -0400
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:28862 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S932333AbWDBNOc
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 09:14:32 -0400
Received: (qmail 4062 invoked by uid 5842); 2 Apr 2006 13:00:52 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18267>

From: Peter Eriksen <s022018@student.dtu.dk>
Date: Sun Apr 2 14:44:09 2006 +0200
Subject: [PATCH] Use blob_, commit_, tag_, and tree_type throughout.

This replaces occurences of "blob", "commit", "tag", and "tree",
where they're really used as type specifiers, which we already
have defined global constants for.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

I have no idea if something like this is wanted. It does touch
a lot of core files, and probably will give merge conflicts 
all over the place. It was good fun and practice for me, though. 

Regards,

Peter

 apply.c           |    5 +++--
 blame.c           |    2 +-
 cat-file.c        |    6 ++++--
 combine-diff.c    |    3 ++-
 commit-tree.c     |    8 +++++---
 convert-objects.c |   15 +++++++++------
 diff-tree.c       |    2 +-
 entry.c           |    3 ++-
 hash-object.c     |    3 ++-
 index-pack.c      |   14 +++++++++-----
 ls-tree.c         |    4 ++--
 mktag.c           |    3 ++-
 mktree.c          |    3 ++-
 object.c          |    8 ++++----
 pack-objects.c    |   16 ++++++++++------
 revision.c        |    2 +-
 sha1_file.c       |   42 +++++++++++++++++++++++-------------------
 tar-tree.c        |    2 +-
 tree-diff.c       |    7 ++++---
 tree-walk.c       |    3 ++-
 unpack-file.c     |    3 ++-
 unpack-objects.c  |   14 +++++++++-----
 write-tree.c      |    3 ++-
 23 files changed, 102 insertions(+), 69 deletions(-)

fad7c58e5e1bc105b7a39ff9ceb19eb7c4927c28
diff --git a/apply.c b/apply.c
index c50b3a6..cc3f12e 100644
--- a/apply.c
+++ b/apply.c
@@ -9,6 +9,7 @@
 #include <fnmatch.h>
 #include "cache.h"
 #include "quote.h"
+#include "blob.h"
 
 //  --check turns on checking that the working tree matches the
 //    files that are being modified, but doesn't apply the patch
@@ -1296,7 +1297,7 @@ static int apply_fragments(struct buffer
 			 * applies to.
 			 */
 			write_sha1_file_prepare(desc->buffer, desc->size,
-						"blob", sha1, hdr, &hdrlen);
+						blob_type, sha1, hdr, &hdrlen);
 			if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
 				return error("the patch applies to '%s' (%s), "
 					     "which does not match the "
@@ -1659,7 +1660,7 @@ static void add_index_file(const char *p
 	if (lstat(path, &st) < 0)
 		die("unable to stat newly created file %s", path);
 	fill_stat_cache_info(ce, &st);
-	if (write_sha1_file(buf, size, "blob", ce->sha1) < 0)
+	if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
 		die("unable to create backing store for newly created file %s", path);
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
 		die("unable to add cache entry for %s", path);
diff --git a/blame.c b/blame.c
index 396defc..98f9992 100644
--- a/blame.c
+++ b/blame.c
@@ -229,7 +229,7 @@ static void get_blob(struct commit *comm
 
 	info->buf = read_sha1_file(info->sha1, type, &info->size);
 
-	assert(!strcmp(type, "blob"));
+	assert(!strcmp(type, blob_type));
 }
 
 /* For debugging only */
diff --git a/cat-file.c b/cat-file.c
index 761111e..628f6ca 100644
--- a/cat-file.c
+++ b/cat-file.c
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "tag.h"
+#include "tree.h"
 
 static void flush_buffer(const char *buf, unsigned long size)
 {
@@ -136,13 +138,13 @@ int main(int argc, char **argv)
 			die("Not a valid object name %s", argv[2]);
 
 		/* custom pretty-print here */
-		if (!strcmp(type, "tree"))
+		if (!strcmp(type, tree_type))
 			return execl_git_cmd("ls-tree", argv[2], NULL);
 
 		buf = read_sha1_file(sha1, type, &size);
 		if (!buf)
 			die("Cannot read object %s", argv[2]);
-		if (!strcmp(type, "tag"))
+		if (!strcmp(type, tag_type))
 			return pprint_tag(sha1, buf, size);
 
 		/* otherwise just spit out the data */
diff --git a/combine-diff.c b/combine-diff.c
index f17aab3..7693884 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "blob.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "quote.h"
@@ -104,7 +105,7 @@ static char *grab_blob(const unsigned ch
 		return xcalloc(1, 1);
 	}
 	blob = read_sha1_file(sha1, type, size);
-	if (strcmp(type, "blob"))
+	if (strcmp(type, blob_type))
 		die("object '%s' is not a blob!", sha1_to_hex(sha1));
 	return blob;
 }
diff --git a/commit-tree.c b/commit-tree.c
index 16c1787..2d86518 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -4,6 +4,8 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "commit.h"
+#include "tree.h"
 
 #define BLOCKING (1ul << 14)
 
@@ -93,13 +95,13 @@ int main(int argc, char **argv)
 	if (argc < 2 || get_sha1_hex(argv[1], tree_sha1) < 0)
 		usage(commit_tree_usage);
 
-	check_valid(tree_sha1, "tree");
+	check_valid(tree_sha1, tree_type);
 	for (i = 2; i < argc; i += 2) {
 		char *a, *b;
 		a = argv[i]; b = argv[i+1];
 		if (!b || strcmp(a, "-p") || get_sha1(b, parent_sha1[parents]))
 			usage(commit_tree_usage);
-		check_valid(parent_sha1[parents], "commit");
+		check_valid(parent_sha1[parents], commit_type);
 		if (new_parent(parents))
 			parents++;
 	}
@@ -125,7 +127,7 @@ int main(int argc, char **argv)
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
 		add_buffer(&buffer, &size, "%s", comment);
 
-	if (!write_sha1_file(buffer, size, "commit", commit_sha1)) {
+	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
 	}
diff --git a/convert-objects.c b/convert-objects.c
index b49bce2..2476577 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -2,6 +2,9 @@ #define _XOPEN_SOURCE 500 /* glibc2 and 
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #include <time.h>
 #include "cache.h"
+#include "blob.h"
+#include "commit.h"
+#include "tree.h"
 
 struct entry {
 	unsigned char old_sha1[20];
@@ -122,7 +125,7 @@ static int write_subdirectory(void *buff
 		buffer += len;
 	}
 
-	write_sha1_file(new, newlen, "tree", result_sha1);
+	write_sha1_file(new, newlen, tree_type, result_sha1);
 	free(new);
 	return used;
 }
@@ -262,7 +265,7 @@ static void convert_date(void *buffer, u
 	memcpy(new + newlen, buffer, size);
 	newlen += size;
 
-	write_sha1_file(new, newlen, "commit", result_sha1);
+	write_sha1_file(new, newlen, commit_type, result_sha1);
 	free(new);	
 }
 
@@ -298,11 +301,11 @@ static struct entry * convert_entry(unsi
 	buffer = xmalloc(size);
 	memcpy(buffer, data, size);
 	
-	if (!strcmp(type, "blob")) {
-		write_sha1_file(buffer, size, "blob", entry->new_sha1);
-	} else if (!strcmp(type, "tree"))
+	if (!strcmp(type, blob_type)) {
+		write_sha1_file(buffer, size, blob_type, entry->new_sha1);
+	} else if (!strcmp(type, tree_type))
 		convert_tree(buffer, size, entry->new_sha1);
-	else if (!strcmp(type, "commit"))
+	else if (!strcmp(type, commit_type))
 		convert_commit(buffer, size, entry->new_sha1);
 	else
 		die("unknown object type '%s' in %s", type, sha1_to_hex(sha1));
diff --git a/diff-tree.c b/diff-tree.c
index f55a35a..d1265d7 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -52,7 +52,7 @@ static int diff_root_tree(const unsigned
 	void *tree;
 	struct tree_desc empty, real;
 
-	tree = read_object_with_reference(new, "tree", &real.size, NULL);
+	tree = read_object_with_reference(new, tree_type, &real.size, NULL);
 	if (!tree)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
 	real.buf = tree;
diff --git a/entry.c b/entry.c
index 5d9aefd..793724f 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include <sys/types.h>
 #include <dirent.h>
 #include "cache.h"
+#include "blob.h"
 
 static void create_directories(const char *path, struct checkout *state)
 {
@@ -72,7 +73,7 @@ static int write_entry(struct cache_entr
 	char type[20];
 
 	new = read_sha1_file(ce->sha1, type, &size);
-	if (!new || strcmp(type, "blob")) {
+	if (!new || strcmp(type, blob_type)) {
 		if (new)
 			free(new);
 		return error("git-checkout-index: unable to read sha1 file of %s (%s)",
diff --git a/hash-object.c b/hash-object.c
index 6502b5b..87e1277 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -5,6 +5,7 @@
  * Copyright (C) Junio C Hamano, 2005 
  */
 #include "cache.h"
+#include "blob.h"
 
 static void hash_object(const char *path, const char *type, int write_object)
 {
@@ -35,7 +36,7 @@ static const char hash_object_usage[] =
 int main(int argc, char **argv)
 {
 	int i;
-	const char *type = "blob";
+	const char *type = blob_type;
 	int write_object = 0;
 	const char *prefix = NULL;
 	int prefix_length = -1;
diff --git a/index-pack.c b/index-pack.c
index babe34b..b39953d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -2,7 +2,11 @@ #include "cache.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
-
+#include "blob.h"
+#include "commit.h"
+#include "tag.h"
+#include "tree.h"
+
 static const char index_pack_usage[] =
 "git-index-pack [-o index-file] pack-file";
 
@@ -224,10 +228,10 @@ static void sha1_object(const void *data
 	const char *type_str;
 
 	switch (type) {
-	case OBJ_COMMIT: type_str = "commit"; break;
-	case OBJ_TREE:   type_str = "tree"; break;
-	case OBJ_BLOB:   type_str = "blob"; break;
-	case OBJ_TAG:    type_str = "tag"; break;
+	case OBJ_COMMIT: type_str = commit_type; break;
+	case OBJ_TREE:   type_str = tree_type; break;
+	case OBJ_BLOB:   type_str = blob_type; break;
+	case OBJ_TAG:    type_str = tag_type; break;
 	default:
 		die("bad type %d", type);
 	}
diff --git a/ls-tree.c b/ls-tree.c
index 26258c3..e4ef200 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -56,7 +56,7 @@ static int show_tree(unsigned char *sha1
 		     const char *pathname, unsigned mode, int stage)
 {
 	int retval = 0;
-	const char *type = "blob";
+	const char *type = blob_type;
 
 	if (S_ISDIR(mode)) {
 		if (show_recursive(base, baselen, pathname)) {
@@ -64,7 +64,7 @@ static int show_tree(unsigned char *sha1
 			if (!(ls_options & LS_SHOW_TREES))
 				return retval;
 		}
-		type = "tree";
+		type = tree_type;
 	}
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
diff --git a/mktag.c b/mktag.c
index fc6a9bf..2328878 100644
--- a/mktag.c
+++ b/mktag.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "tag.h"
 
 /*
  * A signature file has a very simple fixed format: three lines
@@ -126,7 +127,7 @@ int main(int argc, char **argv)
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 
-	if (write_sha1_file(buffer, size, "tag", result_sha1) < 0)
+	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
 		die("unable to write tag file");
 	printf("%s\n", sha1_to_hex(result_sha1));
 	return 0;
diff --git a/mktree.c b/mktree.c
index f853585..ab63cd9 100644
--- a/mktree.c
+++ b/mktree.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "tree.h"
 
 static struct treeent {
 	unsigned mode;
@@ -67,7 +68,7 @@ static void write_tree(unsigned char *sh
 		memcpy(buffer + offset, ent->sha1, 20);
 		offset += 20;
 	}
-	write_sha1_file(buffer, offset, "tree", sha1);
+	write_sha1_file(buffer, offset, tree_type, sha1);
 }
 
 static const char mktree_usage[] = "mktree [-z]";
diff --git a/object.c b/object.c
index c9ca481..b5c0ecf 100644
--- a/object.c
+++ b/object.c
@@ -196,15 +196,15 @@ struct object *parse_object(const unsign
 		struct object *obj;
 		if (check_sha1_signature(sha1, buffer, size, type) < 0)
 			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
-		if (!strcmp(type, "blob")) {
+		if (!strcmp(type, blob_type)) {
 			struct blob *blob = lookup_blob(sha1);
 			parse_blob_buffer(blob, buffer, size);
 			obj = &blob->object;
-		} else if (!strcmp(type, "tree")) {
+		} else if (!strcmp(type, tree_type)) {
 			struct tree *tree = lookup_tree(sha1);
 			parse_tree_buffer(tree, buffer, size);
 			obj = &tree->object;
-		} else if (!strcmp(type, "commit")) {
+		} else if (!strcmp(type, commit_type)) {
 			struct commit *commit = lookup_commit(sha1);
 			parse_commit_buffer(commit, buffer, size);
 			if (!commit->buffer) {
@@ -212,7 +212,7 @@ struct object *parse_object(const unsign
 				buffer = NULL;
 			}
 			obj = &commit->object;
-		} else if (!strcmp(type, "tag")) {
+		} else if (!strcmp(type, tag_type)) {
 			struct tag *tag = lookup_tag(sha1);
 			parse_tag_buffer(tag, buffer, size);
 			obj = &tag->object;
diff --git a/pack-objects.c b/pack-objects.c
index ccfaa5f..4145f25 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1,5 +1,9 @@
 #include "cache.h"
 #include "object.h"
+#include "blob.h"
+#include "commit.h"
+#include "tag.h"
+#include "tree.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
@@ -603,7 +607,7 @@ static void add_pbase_tree(struct tree_d
 		if (!add_object_entry(sha1, hash, 1))
 			continue;
 
-		if (!strcmp(type, "tree")) {
+		if (!strcmp(type, tree_type)) {
 			struct tree_desc sub;
 			void *elem;
 			struct name_path me;
@@ -626,7 +630,7 @@ static void add_preferred_base(unsigned 
 	struct tree_desc tree;
 	void *elem;
 
-	elem = read_object_with_reference(sha1, "tree", &tree.size, NULL);
+	elem = read_object_with_reference(sha1, tree_type, &tree.size, NULL);
 	tree.buf = elem;
 	if (!tree.buf)
 		return;
@@ -684,13 +688,13 @@ static void check_object(struct object_e
 		die("unable to get type of object %s",
 		    sha1_to_hex(entry->sha1));
 
-	if (!strcmp(type, "commit")) {
+	if (!strcmp(type, commit_type)) {
 		entry->type = OBJ_COMMIT;
-	} else if (!strcmp(type, "tree")) {
+	} else if (!strcmp(type, tree_type)) {
 		entry->type = OBJ_TREE;
-	} else if (!strcmp(type, "blob")) {
+	} else if (!strcmp(type, blob_type)) {
 		entry->type = OBJ_BLOB;
-	} else if (!strcmp(type, "tag")) {
+	} else if (!strcmp(type, tag_type)) {
 		entry->type = OBJ_TAG;
 	} else
 		die("unable to pack object %s of type %s",
diff --git a/revision.c b/revision.c
index c2a95aa..902a99f 100644
--- a/revision.c
+++ b/revision.c
@@ -260,7 +260,7 @@ int rev_same_tree_as_empty(struct tree *
 	if (!t1)
 		return 0;
 
-	tree = read_object_with_reference(t1->object.sha1, "tree", &real.size, NULL);
+	tree = read_object_with_reference(t1->object.sha1, tree_type, &real.size, NULL);
 	if (!tree)
 		return 0;
 	real.buf = tree;
diff --git a/sha1_file.c b/sha1_file.c
index 58edec0..ba8c4f7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -9,7 +9,11 @@
 #include "cache.h"
 #include "delta.h"
 #include "pack.h"
-
+#include "blob.h"
+#include "commit.h"
+#include "tag.h"
+#include "tree.h"
+
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
 #define O_NOATIME 01000000
@@ -894,16 +898,16 @@ void packed_object_info_detail(struct pa
 	}
 	switch (kind) {
 	case OBJ_COMMIT:
-		strcpy(type, "commit");
+		strcpy(type, commit_type);
 		break;
 	case OBJ_TREE:
-		strcpy(type, "tree");
+		strcpy(type, tree_type);
 		break;
 	case OBJ_BLOB:
-		strcpy(type, "blob");
+		strcpy(type, blob_type);
 		break;
 	case OBJ_TAG:
-		strcpy(type, "tag");
+		strcpy(type, tag_type);
 		break;
 	default:
 		die("corrupted pack file %s containing object of kind %d",
@@ -934,16 +938,16 @@ static int packed_object_info(struct pac
 		unuse_packed_git(p);
 		return retval;
 	case OBJ_COMMIT:
-		strcpy(type, "commit");
+		strcpy(type, commit_type);
 		break;
 	case OBJ_TREE:
-		strcpy(type, "tree");
+		strcpy(type, tree_type);
 		break;
 	case OBJ_BLOB:
-		strcpy(type, "blob");
+		strcpy(type, blob_type);
 		break;
 	case OBJ_TAG:
-		strcpy(type, "tag");
+		strcpy(type, tag_type);
 		break;
 	default:
 		die("corrupted pack file %s containing object of kind %d",
@@ -1071,16 +1075,16 @@ void *unpack_entry_gently(struct pack_en
 		retval = unpack_delta_entry(pack, size, left, type, sizep, p);
 		return retval;
 	case OBJ_COMMIT:
-		strcpy(type, "commit");
+		strcpy(type, commit_type);
 		break;
 	case OBJ_TREE:
-		strcpy(type, "tree");
+		strcpy(type, tree_type);
 		break;
 	case OBJ_BLOB:
-		strcpy(type, "blob");
+		strcpy(type, blob_type);
 		break;
 	case OBJ_TAG:
-		strcpy(type, "tag");
+		strcpy(type, tag_type);
 		break;
 	default:
 		return NULL;
@@ -1241,9 +1245,9 @@ void *read_object_with_reference(const u
 			return buffer;
 		}
 		/* Handle references */
-		else if (!strcmp(type, "commit"))
+		else if (!strcmp(type, commit_type))
 			ref_type = "tree ";
-		else if (!strcmp(type, "tag"))
+		else if (!strcmp(type, tag_type))
 			ref_type = "object ";
 		else {
 			free(buffer);
@@ -1625,7 +1629,7 @@ int index_pipe(unsigned char *sha1, int 
 		return -1;
 	}
 	if (!type)
-		type = "blob";
+		type = blob_type;
 	if (write_object)
 		ret = write_sha1_file(buf, off, type, sha1);
 	else {
@@ -1652,7 +1656,7 @@ int index_fd(unsigned char *sha1, int fd
 		return -1;
 
 	if (!type)
-		type = "blob";
+		type = blob_type;
 	if (write_object)
 		ret = write_sha1_file(buf, size, type, sha1);
 	else {
@@ -1690,9 +1694,9 @@ int index_path(unsigned char *sha1, cons
 		if (!write_object) {
 			unsigned char hdr[50];
 			int hdrlen;
-			write_sha1_file_prepare(target, st->st_size, "blob",
+			write_sha1_file_prepare(target, st->st_size, blob_type,
 						sha1, hdr, &hdrlen);
-		} else if (write_sha1_file(target, st->st_size, "blob", sha1))
+		} else if (write_sha1_file(target, st->st_size, blob_type, sha1))
 			return error("%s: failed to insert into database",
 				     path);
 		free(target);
diff --git a/tar-tree.c b/tar-tree.c
index 705b8fa..87870b6 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -336,7 +336,7 @@ int main(int argc, char **argv)
 	} else
 		archive_time = time(NULL);
 
-	tree.buf = read_object_with_reference(sha1, "tree", &tree.size,
+	tree.buf = read_object_with_reference(sha1, tree_type, &tree.size,
 	                                      tree_sha1);
 	if (!tree.buf)
 		die("not a reference to a tag, commit or tree object: %s",
diff --git a/tree-diff.c b/tree-diff.c
index 7bb6109..701fbba 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "diff.h"
+#include "tree.h"
 
 // What paths are we interested in?
 static int nr_paths = 0;
@@ -148,7 +149,7 @@ static int show_entry(struct diff_option
 		void *tree;
 
 		tree = read_sha1_file(sha1, type, &inner.size);
-		if (!tree || strcmp(type, "tree"))
+		if (!tree || strcmp(type, tree_type))
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
 		inner.buf = tree;
@@ -206,10 +207,10 @@ int diff_tree_sha1(const unsigned char *
 	struct tree_desc t1, t2;
 	int retval;
 
-	tree1 = read_object_with_reference(old, "tree", &t1.size, NULL);
+	tree1 = read_object_with_reference(old, tree_type, &t1.size, NULL);
 	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_object_with_reference(new, "tree", &t2.size, NULL);
+	tree2 = read_object_with_reference(new, tree_type, &t2.size, NULL);
 	if (!tree2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	t1.buf = tree1;
diff --git a/tree-walk.c b/tree-walk.c
index 0735f40..bf8bfdf 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tree-walk.h"
+#include "tree.h"
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 {
@@ -7,7 +8,7 @@ void *fill_tree_descriptor(struct tree_d
 	void *buf = NULL;
 
 	if (sha1) {
-		buf = read_object_with_reference(sha1, "tree", &size, NULL);
+		buf = read_object_with_reference(sha1, tree_type, &size, NULL);
 		if (!buf)
 			die("unable to read tree %s", sha1_to_hex(sha1));
 	}
diff --git a/unpack-file.c b/unpack-file.c
index 3accb97..23a8562 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "blob.h"
 
 static char *create_temp_file(unsigned char *sha1)
 {
@@ -9,7 +10,7 @@ static char *create_temp_file(unsigned c
 	int fd;
 
 	buf = read_sha1_file(sha1, type, &size);
-	if (!buf || strcmp(type, "blob"))
+	if (!buf || strcmp(type, blob_type))
 		die("unable to read blob object %s", sha1_to_hex(sha1));
 
 	strcpy(path, ".merge_file_XXXXXX");
diff --git a/unpack-objects.c b/unpack-objects.c
index 815a1b3..3b824b0 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -2,7 +2,11 @@ #include "cache.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
-
+#include "blob.h"
+#include "commit.h"
+#include "tag.h"
+#include "tree.h"
+
 #include <sys/time.h>
 
 static int dry_run, quiet;
@@ -148,10 +152,10 @@ static int unpack_non_delta_entry(enum o
 	const char *type;
 
 	switch (kind) {
-	case OBJ_COMMIT: type = "commit"; break;
-	case OBJ_TREE:   type = "tree"; break;
-	case OBJ_BLOB:   type = "blob"; break;
-	case OBJ_TAG:    type = "tag"; break;
+	case OBJ_COMMIT: type = commit_type; break;
+	case OBJ_TREE:   type = tree_type; break;
+	case OBJ_BLOB:   type = blob_type; break;
+	case OBJ_TAG:    type = tag_type; break;
 	default: die("bad type %d", kind);
 	}
 	if (!dry_run)
diff --git a/write-tree.c b/write-tree.c
index addb5de..dcad6e6 100644
--- a/write-tree.c
+++ b/write-tree.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "tree.h"
 
 static int missing_ok = 0;
 
@@ -78,7 +79,7 @@ static int write_tree(struct cache_entry
 		nr++;
 	}
 
-	write_sha1_file(buffer, offset, "tree", returnsha1);
+	write_sha1_file(buffer, offset, tree_type, returnsha1);
 	free(buffer);
 	return nr;
 }
-- 
1.3.0.rc1.g8eef8e
