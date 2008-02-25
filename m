From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 03/10] Remove unused object-ref code
Date: Mon, 25 Feb 2008 22:54:53 +0100
Message-ID: <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlIi-0006Td-TL
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbYBYVzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759630AbYBYVzG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:06 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55595 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759488AbYBYVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 919186CF0060;
	Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpVbZZYZLrng; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 38274680BF8C; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75075>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Makefile               |    2 +-
 builtin-fetch-pack.c   |    1 -
 builtin-pack-objects.c |    1 -
 builtin-rev-list.c     |    1 -
 commit.c               |   11 ------
 object-refs.c          |   87 ------------------------------------------------
 object.h               |    8 ----
 tag.c                  |    6 ---
 tree.c                 |   48 --------------------------
 upload-pack.c          |    1 -
 walker.c               |    1 -
 11 files changed, 1 insertions(+), 166 deletions(-)
 delete mode 100644 object-refs.c

diff --git a/Makefile b/Makefile
index 3bb2034..2d7d6a8 100644
--- a/Makefile
+++ b/Makefile
@@ -319,7 +319,7 @@ LIB_OBJS = \
 	patch-ids.o \
 	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
 	sideband.o reachable.o reflog-walk.o \
-	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
+	quote.o read-cache.o refs.o run-command.o dir.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f401352..25f1915 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -386,7 +386,6 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 	int retval;
 	unsigned long cutoff = 0;
 
-	track_object_refs = 0;
 	save_commit_buffer = 0;
 
 	for (ref = *refs; ref; ref = ref->next) {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d2bb12e..8c148e1 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2013,7 +2013,6 @@ static void get_object_list(int ac, const char **av)
 
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
-	track_object_refs = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 6f7d5f8..921113f 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -607,7 +607,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		usage(rev_list_usage);
 
 	save_commit_buffer = revs.verbose_header || revs.grep_filter;
-	track_object_refs = 0;
 	if (bisect_list)
 		revs.limited = 1;
 
diff --git a/commit.c b/commit.c
index 22ce776..6684c4e 100644
--- a/commit.c
+++ b/commit.c
@@ -290,17 +290,6 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	}
 	item->date = parse_commit_date(bufptr, tail);
 
-	if (track_object_refs) {
-		unsigned i = 0;
-		struct commit_list *p;
-		struct object_refs *refs = alloc_object_refs(n_refs);
-		if (item->tree)
-			refs->ref[i++] = &item->tree->object;
-		for (p = item->parents; p; p = p->next)
-			refs->ref[i++] = &p->item->object;
-		set_object_refs(&item->object, refs);
-	}
-
 	return 0;
 }
 
diff --git a/object-refs.c b/object-refs.c
deleted file mode 100644
index 5345671..0000000
--- a/object-refs.c
+++ /dev/null
@@ -1,87 +0,0 @@
-#include "cache.h"
-#include "object.h"
-#include "decorate.h"
-
-int track_object_refs = 0;
-
-static struct decoration ref_decorate;
-
-struct object_refs *lookup_object_refs(struct object *base)
-{
-	return lookup_decoration(&ref_decorate, base);
-}
-
-static void add_object_refs(struct object *obj, struct object_refs *refs)
-{
-	if (add_decoration(&ref_decorate, obj, refs))
-		die("object %s tried to add refs twice!", sha1_to_hex(obj->sha1));
-}
-
-struct object_refs *alloc_object_refs(unsigned count)
-{
-	struct object_refs *refs;
-	size_t size = sizeof(*refs) + count*sizeof(struct object *);
-
-	refs = xcalloc(1, size);
-	refs->count = count;
-	return refs;
-}
-
-static int compare_object_pointers(const void *a, const void *b)
-{
-	const struct object * const *pa = a;
-	const struct object * const *pb = b;
-	if (*pa == *pb)
-		return 0;
-	else if (*pa < *pb)
-		return -1;
-	else
-		return 1;
-}
-
-void set_object_refs(struct object *obj, struct object_refs *refs)
-{
-	unsigned int i, j;
-
-	/* Do not install empty list of references */
-	if (refs->count < 1) {
-		free(refs);
-		return;
-	}
-
-	/* Sort the list and filter out duplicates */
-	qsort(refs->ref, refs->count, sizeof(refs->ref[0]),
-	      compare_object_pointers);
-	for (i = j = 1; i < refs->count; i++) {
-		if (refs->ref[i] != refs->ref[i - 1])
-			refs->ref[j++] = refs->ref[i];
-	}
-	if (j < refs->count) {
-		/* Duplicates were found - reallocate list */
-		size_t size = sizeof(*refs) + j*sizeof(struct object *);
-		refs->count = j;
-		refs = xrealloc(refs, size);
-	}
-
-	for (i = 0; i < refs->count; i++)
-		refs->ref[i]->used = 1;
-	add_object_refs(obj, refs);
-}
-
-void mark_reachable(struct object *obj, unsigned int mask)
-{
-	const struct object_refs *refs;
-
-	if (!track_object_refs)
-		die("cannot do reachability with object refs turned off");
-	/* If we've been here already, don't bother */
-	if (obj->flags & mask)
-		return;
-	obj->flags |= mask;
-	refs = lookup_object_refs(obj);
-	if (refs) {
-		unsigned i;
-		for (i = 0; i < refs->count; i++)
-			mark_reachable(refs->ref[i], mask);
-	}
-}
diff --git a/object.h b/object.h
index 397bbfa..036bd66 100644
--- a/object.h
+++ b/object.h
@@ -35,14 +35,11 @@ struct object {
 	unsigned char sha1[20];
 };
 
-extern int track_object_refs;
-
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
 
 extern unsigned int get_max_object_index(void);
 extern struct object *get_indexed_object(unsigned int);
-extern struct object_refs *lookup_object_refs(struct object *);
 
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
@@ -61,11 +58,6 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
 
-struct object_refs *alloc_object_refs(unsigned count);
-void set_object_refs(struct object *obj, struct object_refs *refs);
-
-void mark_reachable(struct object *obj, unsigned int mask);
-
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
 
diff --git a/tag.c b/tag.c
index 990134f..4470d2b 100644
--- a/tag.c
+++ b/tag.c
@@ -87,12 +87,6 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 		item->tagged = NULL;
 	}
 
-	if (item->tagged && track_object_refs) {
-		struct object_refs *refs = alloc_object_refs(1);
-		refs->ref[0] = item->tagged;
-		set_object_refs(&item->object, refs);
-	}
-
 	return 0;
 }
 
diff --git a/tree.c b/tree.c
index 87708ef..4b1825c 100644
--- a/tree.c
+++ b/tree.c
@@ -202,52 +202,6 @@ struct tree *lookup_tree(const unsigned char *sha1)
 	return (struct tree *) obj;
 }
 
-/*
- * NOTE! Tree refs to external git repositories
- * (ie gitlinks) do not count as real references.
- *
- * You don't have to have those repositories
- * available at all, much less have the objects
- * accessible from the current repository.
- */
-static void track_tree_refs(struct tree *item)
-{
-	int n_refs = 0, i;
-	struct object_refs *refs;
-	struct tree_desc desc;
-	struct name_entry entry;
-
-	/* Count how many entries there are.. */
-	init_tree_desc(&desc, item->buffer, item->size);
-	while (tree_entry(&desc, &entry)) {
-		if (S_ISGITLINK(entry.mode))
-			continue;
-		n_refs++;
-	}
-
-	/* Allocate object refs and walk it again.. */
-	i = 0;
-	refs = alloc_object_refs(n_refs);
-	init_tree_desc(&desc, item->buffer, item->size);
-	while (tree_entry(&desc, &entry)) {
-		struct object *obj;
-
-		if (S_ISGITLINK(entry.mode))
-			continue;
-		if (S_ISDIR(entry.mode))
-			obj = &lookup_tree(entry.sha1)->object;
-		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
-			obj = &lookup_blob(entry.sha1)->object;
-		else {
-			warning("in tree %s: entry %s has bad mode %.6o\n",
-			     sha1_to_hex(item->object.sha1), entry.path, entry.mode);
-			obj = lookup_unknown_object(entry.sha1);
-		}
-		refs->ref[i++] = obj;
-	}
-	set_object_refs(&item->object, refs);
-}
-
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 {
 	if (item->object.parsed)
@@ -256,8 +210,6 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 	item->buffer = buffer;
 	item->size = size;
 
-	if (track_object_refs)
-		track_tree_refs(item);
 	return 0;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index b26d053..e5421db 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -393,7 +393,6 @@ static int get_common_commits(void)
 	char hex[41], last_hex[41];
 	int len;
 
-	track_object_refs = 0;
 	save_commit_buffer = 0;
 
 	for(;;) {
diff --git a/walker.c b/walker.c
index adc3e80..c10eca8 100644
--- a/walker.c
+++ b/walker.c
@@ -256,7 +256,6 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	int i;
 
 	save_commit_buffer = 0;
-	track_object_refs = 0;
 
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
-- 
1.5.4.3.g3c5f
