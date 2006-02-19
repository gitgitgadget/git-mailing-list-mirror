From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Thin pack - create packfile with missing delta base.
Date: Sun, 19 Feb 2006 15:28:04 -0800
Message-ID: <7vd5hjexob.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 00:28:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAxyT-0005NX-Ry
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 00:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWBSX2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 18:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWBSX2I
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 18:28:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40687 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932386AbWBSX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 18:28:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219232653.LML15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Feb 2006 18:26:53 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16460>

This goes together with "rev-list --object-edge" change, to feed
pack-objects list of edge commits in addition to the usual
object list.  Upon seeing such list, pack-objects loosens the
usual "self contained delta" constraints, and can produce delta
against blobs and trees contained in the edge commits without
storing the delta base objects themselves.

The resulting packfile is not usable in .git/object/packs, but
is a good way to implement "delta-only" transfer.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * For "delta transfer"; this comes on top of "next".

 pack-objects.c |  298 +++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 218 insertions(+), 80 deletions(-)

630dcb88482d99b77f83e1ed67b24d4026183c81
diff --git a/pack-objects.c b/pack-objects.c
index 0c9f4c9..fc923c9 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -3,6 +3,7 @@
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "diff.h"
 #include <sys/time.h>
 
 static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
@@ -26,6 +27,13 @@ struct object_entry {
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
 					     */
+	int preferred_base;	/* we do not pack this, but is encouraged to
+				 * be used as the base objectto delta huge
+				 * objects against.
+				 */
+	int based_on_preferred;	/* current delta candidate is a preferred
+				 * one, or delta against a preferred one.
+				 */
 };
 
 /*
@@ -48,7 +56,7 @@ static int local = 0;
 static int incremental = 0;
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects = NULL;
-static int nr_objects = 0, nr_alloc = 0;
+static int nr_objects = 0, nr_alloc = 0, nr_result = 0;
 static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
@@ -229,7 +237,8 @@ static int encode_header(enum object_typ
 	return n;
 }
 
-static unsigned long write_object(struct sha1file *f, struct object_entry *entry)
+static unsigned long write_object(struct sha1file *f,
+				  struct object_entry *entry)
 {
 	unsigned long size;
 	char type[10];
@@ -239,6 +248,9 @@ static unsigned long write_object(struct
 	enum object_type obj_type;
 	int to_reuse = 0;
 
+	if (entry->preferred_base)
+		return 0;
+
 	obj_type = entry->type;
 	if (! entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
@@ -326,10 +338,11 @@ static void write_pack_file(void)
 	if (!base_name)
 		f = sha1fd(1, "<stdout>");
 	else
-		f = sha1create("%s-%s.%s", base_name, sha1_to_hex(object_list_sha1), "pack");
+		f = sha1create("%s-%s.%s", base_name,
+			       sha1_to_hex(object_list_sha1), "pack");
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(PACK_VERSION);
-	hdr.hdr_entries = htonl(nr_objects);
+	hdr.hdr_entries = htonl(nr_result);
 	sha1write(f, &hdr, sizeof(hdr));
 	offset = sizeof(hdr);
 	for (i = 0; i < nr_objects; i++)
@@ -341,9 +354,10 @@ static void write_pack_file(void)
 static void write_index_file(void)
 {
 	int i;
-	struct sha1file *f = sha1create("%s-%s.%s", base_name, sha1_to_hex(object_list_sha1), "idx");
+	struct sha1file *f = sha1create("%s-%s.%s", base_name,
+					sha1_to_hex(object_list_sha1), "idx");
 	struct object_entry **list = sorted_by_sha;
-	struct object_entry **last = list + nr_objects;
+	struct object_entry **last = list + nr_result;
 	unsigned int array[256];
 
 	/*
@@ -368,7 +382,7 @@ static void write_index_file(void)
 	 * Write the actual SHA1 entries..
 	 */
 	list = sorted_by_sha;
-	for (i = 0; i < nr_objects; i++) {
+	for (i = 0; i < nr_result; i++) {
 		struct object_entry *entry = *list++;
 		unsigned int offset = htonl(entry->offset);
 		sha1write(f, &offset, 4);
@@ -378,27 +392,87 @@ static void write_index_file(void)
 	sha1close(f, NULL, 1);
 }
 
-static int add_object_entry(unsigned char *sha1, unsigned int hash)
+static int locate_object_entry_hash(const unsigned char *sha1)
+{
+	int i;
+	unsigned int ui;
+	memcpy(&ui, sha1, sizeof(unsigned int));
+	i = ui % object_ix_hashsz;
+	while (0 < object_ix[i]) {
+		if (!memcmp(sha1, objects[object_ix[i]-1].sha1, 20))
+			return i;
+		if (++i == object_ix_hashsz)
+			i = 0;
+	}
+	return -1 - i;
+}
+
+static struct object_entry *locate_object_entry(const unsigned char *sha1)
+{
+	int i;
+
+	if (!object_ix_hashsz)
+		return NULL;
+
+	i = locate_object_entry_hash(sha1);
+	if (0 <= i)
+		return &objects[object_ix[i]-1];
+	return NULL;
+}
+
+static void rehash_objects(void)
 {
+	int i;
+	struct object_entry *oe;
+
+	object_ix_hashsz = nr_objects * 2;
+	if (object_ix_hashsz < 256)
+		object_ix_hashsz = 256;
+	object_ix = xrealloc(object_ix, sizeof(int) * object_ix_hashsz);
+	object_ix = memset(object_ix, 0, sizeof(int) * object_ix_hashsz);
+	for (i = 0, oe = objects; i < nr_objects; i++, oe++) {
+		int ix = locate_object_entry_hash(oe->sha1);
+		if (0 <= ix)
+			continue;
+		ix = -1 - ix;
+		object_ix[ix] = i + 1;
+	}
+}
+
+static int add_object_entry(const unsigned char *sha1, const char *name, int exclude)
+{
+	unsigned int hash = 0;
 	unsigned int idx = nr_objects;
 	struct object_entry *entry;
 	struct packed_git *p;
 	unsigned int found_offset = 0;
 	struct packed_git *found_pack = NULL;
+	int ix;
 
-	for (p = packed_git; p; p = p->next) {
-		struct pack_entry e;
-		if (find_pack_entry_one(sha1, &e, p)) {
-			if (incremental)
-				return 0;
-			if (local && !p->pack_local)
-				return 0;
-			if (!found_pack) {
-				found_offset = e.offset;
-				found_pack = e.p;
+	if (!exclude) {
+		for (p = packed_git; p; p = p->next) {
+			struct pack_entry e;
+			if (find_pack_entry_one(sha1, &e, p)) {
+				if (incremental)
+					return 0;
+				if (local && !p->pack_local)
+					return 0;
+				if (!found_pack) {
+					found_offset = e.offset;
+					found_pack = e.p;
+				}
 			}
 		}
 	}
+	if ((entry = locate_object_entry(sha1)) != NULL)
+		goto already_added;
+
+	while (*name) {
+		unsigned char c = *name++;
+		if (isspace(c))
+			continue;
+		hash = hash * 11 + c;
+	}
 
 	if (idx >= nr_alloc) {
 		unsigned int needed = (idx + 1024) * 3 / 2;
@@ -406,45 +480,79 @@ static int add_object_entry(unsigned cha
 		nr_alloc = needed;
 	}
 	entry = objects + idx;
+	nr_objects = idx + 1;
 	memset(entry, 0, sizeof(*entry));
 	memcpy(entry->sha1, sha1, 20);
 	entry->hash = hash;
-	if (found_pack) {
-		entry->in_pack = found_pack;
-		entry->in_pack_offset = found_offset;
+
+	if (object_ix_hashsz <= nr_objects * 2)
+		rehash_objects();
+	else {
+		ix = locate_object_entry_hash(entry->sha1);
+		if (0 <= ix)
+			die("internal error in object hashing.");
+		object_ix[-1 - ix] = idx + 1;
+	}
+
+ already_added:
+	if (exclude)
+		entry->preferred_base = 1;
+	else {
+		if (found_pack) {
+			entry->in_pack = found_pack;
+			entry->in_pack_offset = found_offset;
+		}
 	}
-	nr_objects = idx+1;
 	return 1;
 }
 
-static int locate_object_entry_hash(unsigned char *sha1)
+static void add_pbase_tree(struct tree_desc *tree)
 {
-	int i;
-	unsigned int ui;
-	memcpy(&ui, sha1, sizeof(unsigned int));
-	i = ui % object_ix_hashsz;
-	while (0 < object_ix[i]) {
-		if (!memcmp(sha1, objects[object_ix[i]-1].sha1, 20))
-			return i;
-		if (++i == object_ix_hashsz)
-			i = 0;
+	while (tree->size) {
+		const unsigned char *sha1;
+		const char *name;
+		unsigned mode;
+		unsigned long size;
+		char type[20];
+
+		sha1 = tree_entry_extract(tree, &name, &mode);
+		update_tree_entry(tree);
+		if (!has_sha1_file(sha1))
+			continue;
+		if (sha1_object_info(sha1, type, &size))
+			continue;
+		add_object_entry(sha1, name, 1);
+		if (!strcmp(type, "tree")) {
+			struct tree_desc sub;
+			void *elem;
+			elem = read_sha1_file(sha1, type, &sub.size);
+			sub.buf = elem;
+			if (sub.buf) {
+				add_pbase_tree(&sub);
+				free(elem);
+			}
+		}
 	}
-	return -1 - i;
 }
 
-static struct object_entry *locate_object_entry(unsigned char *sha1)
+static void add_preferred_base(unsigned char *sha1)
 {
-	int i = locate_object_entry_hash(sha1);
-	if (0 <= i)
-		return &objects[object_ix[i]-1];
-	return NULL;
+	struct tree_desc tree;
+	void *elem;
+	elem = read_object_with_reference(sha1, "tree", &tree.size, NULL);
+	tree.buf = elem;
+	if (!tree.buf)
+		return;
+	add_object_entry(sha1, "", 1);
+	add_pbase_tree(&tree);
+	free(elem);
 }
 
 static void check_object(struct object_entry *entry)
 {
 	char type[20];
 
-	if (entry->in_pack) {
+	if (entry->in_pack && !entry->preferred_base) {
 		unsigned char base[20];
 		unsigned long size;
 		struct object_entry *base_entry;
@@ -463,7 +571,8 @@ static void check_object(struct object_e
 		 */
 		if (!no_reuse_delta &&
 		    entry->in_pack_type == OBJ_DELTA &&
-		    (base_entry = locate_object_entry(base))) {
+		    (base_entry = locate_object_entry(base)) &&
+		    (!base_entry->preferred_base)) {
 
 			/* Depth value does not matter - find_deltas()
 			 * will never consider reused delta as the
@@ -501,25 +610,6 @@ static void check_object(struct object_e
 		    sha1_to_hex(entry->sha1), type);
 }
 
-static void hash_objects(void)
-{
-	int i;
-	struct object_entry *oe;
-
-	object_ix_hashsz = nr_objects * 2;
-	object_ix = xcalloc(sizeof(int), object_ix_hashsz);
-	for (i = 0, oe = objects; i < nr_objects; i++, oe++) {
-		int ix = locate_object_entry_hash(oe->sha1);
-		if (0 <= ix) {
-			error("the same object '%s' added twice",
-			      sha1_to_hex(oe->sha1));
-			continue;
-		}
-		ix = -1 - ix;
-		object_ix[ix] = i + 1;
-	}
-}
-
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 {
 	struct object_entry *child = me->delta_child;
@@ -538,7 +628,6 @@ static void get_object_details(void)
 	int i;
 	struct object_entry *entry;
 
-	hash_objects();
 	prepare_pack_ix();
 	for (i = 0, entry = objects; i < nr_objects; i++, entry++)
 		check_object(entry);
@@ -576,6 +665,24 @@ static int sha1_sort(const struct object
 	return memcmp(a->sha1, b->sha1, 20);
 }
 
+static struct object_entry **create_final_object_list()
+{
+	struct object_entry **list;
+	int i, j;
+
+	for (i = nr_result = 0; i < nr_objects; i++)
+		if (!objects[i].preferred_base)
+			nr_result++;
+	list = xmalloc(nr_result * sizeof(struct object_entry *));
+	for (i = j = 0; i < nr_objects; i++) {
+		if (!objects[i].preferred_base)
+			list[j++] = objects + i;
+	}
+	current_sort = sha1_sort;
+	qsort(list, nr_result, sizeof(struct object_entry *), sort_comparator);
+	return list;
+}
+
 static int type_size_sort(const struct object_entry *a, const struct object_entry *b)
 {
 	if (a->type < b->type)
@@ -586,6 +693,10 @@ static int type_size_sort(const struct o
 		return -1;
 	if (a->hash > b->hash)
 		return 1;
+	if (a->preferred_base < b->preferred_base)
+		return -1;
+	if (a->preferred_base > b->preferred_base)
+		return 1;
 	if (a->size < b->size)
 		return -1;
 	if (a->size > b->size)
@@ -610,6 +721,8 @@ static int try_delta(struct unpacked *cu
 {
 	struct object_entry *cur_entry = cur->entry;
 	struct object_entry *old_entry = old->entry;
+	int old_preferred = (old_entry->preferred_base ||
+			     old_entry->based_on_preferred);
 	unsigned long size, oldsize, delta_size, sizediff;
 	long max_size;
 	void *delta_buf;
@@ -618,9 +731,15 @@ static int try_delta(struct unpacked *cu
 	if (cur_entry->type != old_entry->type)
 		return -1;
 
-	/* If the current object is at edge, take the depth the objects
-	 * that depend on the current object into account -- otherwise
-	 * they would become too deep.
+	/* We do not compute delta to *create* objects we are not
+	 * going to pack.
+	 */
+	if (cur_entry->preferred_base)
+		return -1;
+
+	/* If the current object is at pack edge, take the depth the
+	 * objects that depend on the current object into account --
+	 * otherwise they would become too deep.
 	 */
 	if (cur_entry->delta_child) {
 		if (max_depth <= cur_entry->delta_limit)
@@ -646,8 +765,27 @@ static int try_delta(struct unpacked *cu
 	 * delete).
 	 */
 	max_size = size / 2 - 20;
-	if (cur_entry->delta)
-		max_size = cur_entry->delta_size-1;
+	if (cur_entry->delta) {
+		if (cur_entry->based_on_preferred) {
+			if (old_preferred)
+				max_size = cur_entry->delta_size-1;
+			else
+				/* trying with non-preferred one when we
+				 * already have a delta based on preferred
+				 * one is pointless.
+				 */
+				return 0;
+		}
+		else if (!old_preferred)
+			max_size = cur_entry->delta_size-1;
+		else
+			/* otherwise...  even if delta with a
+			 * preferred one produces a bigger result than
+			 * what we currently have, which is based on a
+			 * non-preferred one, it is OK.
+			 */
+			;
+	}
 	if (sizediff >= max_size)
 		return -1;
 	delta_buf = diff_delta(old->data, oldsize,
@@ -657,6 +795,7 @@ static int try_delta(struct unpacked *cu
 	cur_entry->delta = old_entry;
 	cur_entry->delta_size = delta_size;
 	cur_entry->depth = old_entry->depth + 1;
+	cur_entry->based_on_preferred = old_preferred;
 	free(delta_buf);
 	return 0;
 }
@@ -722,7 +861,7 @@ static void find_deltas(struct object_en
 static void prepare_pack(int window, int depth)
 {
 	if (progress)
-		fprintf(stderr, "Packing %d objects", nr_objects);
+		fprintf(stderr, "Packing %d objects", nr_result);
 	get_object_details();
 	if (progress)
 		fputc('.', stderr);
@@ -861,8 +1000,6 @@ int main(int argc, char **argv)
 		gettimeofday(&prev_tv, NULL);
 	}
 	while (fgets(line, sizeof(line), stdin) != NULL) {
-		unsigned int hash;
-		char *p;
 		unsigned char sha1[20];
 
 		if (progress && (eye_candy <= nr_objects)) {
@@ -881,31 +1018,32 @@ int main(int argc, char **argv)
 			}
 			eye_candy += eye_candy_incr;
 		}
+		if (line[0] == '-') {
+			if (get_sha1_hex(line+1, sha1))
+				die("expected edge sha1, got garbage:\n %s",
+				    line+1);
+			add_preferred_base(sha1);
+			continue;
+		}
 		if (get_sha1_hex(line, sha1))
 			die("expected sha1, got garbage:\n %s", line);
-		hash = 0;
-		p = line+40;
-		while (*p) {
-			unsigned char c = *p++;
-			if (isspace(c))
-				continue;
-			hash = hash * 11 + c;
-		}
-		add_object_entry(sha1, hash);
+		add_object_entry(sha1, line+40, 0);
 	}
 	if (progress)
 		fprintf(stderr, "Done counting %d objects.\n", nr_objects);
 	if (non_empty && !nr_objects)
 		return 0;
 
-	sorted_by_sha = create_sorted_list(sha1_sort);
+	sorted_by_sha = create_final_object_list();
 	SHA1_Init(&ctx);
 	list = sorted_by_sha;
-	for (i = 0; i < nr_objects; i++) {
+	for (i = 0; i < nr_result; i++) {
 		struct object_entry *entry = *list++;
 		SHA1_Update(&ctx, entry->sha1, 20);
 	}
 	SHA1_Final(object_list_sha1, &ctx);
+	if (progress && (nr_objects != nr_result))
+		fprintf(stderr, "Result has %d objects.\n", nr_result);
 
 	if (reuse_cached_pack(object_list_sha1, pack_to_stdout))
 		;
@@ -918,6 +1056,6 @@ int main(int argc, char **argv)
 	}
 	if (progress)
 		fprintf(stderr, "Total %d, written %d (delta %d), reused %d (delta %d)\n",
-			nr_objects, written, written_delta, reused, reused_delta);
+			nr_result, written, written_delta, reused, reused_delta);
 	return 0;
 }
-- 
1.2.2.g0d27
