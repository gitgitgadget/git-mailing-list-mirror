From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 5/6 (v2)] full integration of rev-cache into git's revision
 walker, completed test suite
Date: Sat, 08 Aug 2009 09:31:59 +0200
Message-ID: <op.uyb1vl2jtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Sat Aug 08 09:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgPo-0007kQ-0Q
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933117AbZHHHcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbZHHHcI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:32:08 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50170 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbZHHHcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:32:05 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so1992751ewy.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=VuucnKhs61XjYEVqb7ONOipsVCc2J4SlPmfbaVkaXHk=;
        b=d55C6lHlcYWt/VOUOhTueDy8Mi2dnLmpj65vam4jzHV2RYpWtlc1HYHq/4sbcw3UU/
         Y8VlkhcwGk4V05oWsU1N7zgQQw7YcR7/fZrwTlJGm3j7dx36beuw14k+bCv9/yvTp3dV
         KREdocwAysES0udB8OI5Ixydy+hFGU+rT5HLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=E1VQ+rAlYc6rDgYpKJycy1X93hmj97rHGM1+KeFvEHYAGndGY2JkznYNwi6b9DD7h4
         aV7Hl2yYPPtEIxBf7kcbMEv9/yMaicf/83kLVY09hIRhPK+JO2I5BtWoZcD3poLPbxay
         o+ZXaZ2RyDTbJBW+DhcBOwZBXLy3prClbB5q4=
Received: by 10.210.130.13 with SMTP id c13mr381424ebd.0.1249716725584;
        Sat, 08 Aug 2009 00:32:05 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 28sm5066198eyg.12.2009.08.08.00.32.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 00:32:05 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125259>

This patch provides a working integration of rev-cache into the revision 
walker, along with some touch-ups:
 - integration into revision walker and list-objects
 - addition of 'unique' field to commit objects, optionally initialized in 
   rev-cache with the objects introduced in that commit
 - tweak of object generation to take advantage of the 'unique' field
 - more fluid handling of damaged cache slices
 - numerous tests for both features from the previous patch, and the 
integration's integrity

'Integration' is rather broad -- a more detailed description follows for each 
aspect:
 - rev-cache
the traversal mechanism is updated to handle many of the non-prune options 
rev-list does (date limiting, slop-handling, etc.), and is adjusted to allow 
for non-fatal cache-traversal failures.

 - revision walker
both limited and unlimited traversal attempt to use the cache when possible, 
smoothly falling back if it's not.

 - list-objects
object listing does not recurse into cached trees, and has been adjusted to 
guarantee commit-tag-tree-blob ordering.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
5/5 in previous.  I decided to not split this up, as Sam suggested, largely 
because the changesets, while seemingly numerous, are actually rather small, 
and very connected with each other.  Tests for --ignore-size are also added.

 builtin-rev-cache.c       |   46 +++++++-
 commit.c                  |    2 +-
 commit.h                  |    1 +
 list-objects.c            |   49 ++++++-
 rev-cache.c               |  303 ++++++++++++++++++++++++++++++++++++++------
 revision.c                |   87 +++++++++++---
 t/t6015-rev-cache-list.sh |  152 +++++++++++++++++++++--
 7 files changed, 562 insertions(+), 78 deletions(-)

diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
index 532ec9f..4a02af6 100755
--- a/builtin-rev-cache.c
+++ b/builtin-rev-cache.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "list-objects.h"
 
 #define DEFAULT_IGNORE_SLICE_SIZE		"30mb"
 
@@ -69,6 +70,43 @@ static int handle_add(int argc, const char *argv[]) /* args beyond this command
 	return 0;
 }
 
+static void show_commit(struct commit *commit, void *data)
+{
+	printf("%s\n", sha1_to_hex(commit->object.sha1));
+}
+
+static void show_object(struct object *obj, const struct name_path *path, const char *last)
+{
+	printf("%s\n", sha1_to_hex(obj->sha1));
+}
+
+static int test_rev_list(int argc, const char *argv[])
+{
+	struct rev_info revs;
+	unsigned int flags = 0;
+	int i;
+	
+	init_revisions(&revs, 0);
+	
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--not"))
+			flags ^= UNINTERESTING;
+		else if (!strcmp(argv[i], "--objects"))
+			revs.tree_objects = revs.blob_objects = 1;
+		else
+			handle_revision_arg(argv[i], &revs, flags, 1);
+	}
+	
+	setup_revisions(0, 0, &revs, 0);
+	revs.topo_order = 1;
+	revs.lifo = 1;
+	prepare_revision_walk(&revs);
+	
+	traverse_commit_list(&revs, show_commit, show_object, 0);
+	
+	return 0;
+}
+
 static int handle_walk(int argc, const char *argv[])
 {
 	struct commit *commit;
@@ -117,17 +155,17 @@ static int handle_walk(int argc, const char *argv[])
 	if (retval < 0)
 		return retval;
 	
-	printf("queue:\n");
+	fprintf(stderr, "queue:\n");
 	while ((commit = pop_commit(&queue)) != 0) {
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
 	}
 	
-	printf("work:\n");
+	fprintf(stderr, "work:\n");
 	while ((commit = pop_commit(&work)) != 0) {
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
 	}
 	
-	printf("pending:\n");
+	fprintf(stderr, "pending:\n");
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object *obj = revs.pending.objects[i].item;
 		
@@ -259,6 +297,8 @@ int cmd_rev_cache(int argc, const char *argv[], const char *prefix)
 		r = handle_walk(argc, argv);
 	else if (!strcmp(arg, "index"))
 		r = handle_index(argc, argv);
+	else if (!strcmp(arg, "test"))
+		r = test_rev_list(argc, argv);
 	else
 		return handle_help();
 	
diff --git a/commit.c b/commit.c
index afe504f..1b710c2 100644
--- a/commit.c
+++ b/commit.c
@@ -252,7 +252,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 			     sha1_to_hex(item->object.sha1));
 	item->tree = lookup_tree(parent);
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
- 	pptr = &item->parents;
+	pptr = &item->parents;
 	while (pop_commit(pptr))
 		; /* clear anything from cache */
 
diff --git a/commit.h b/commit.h
index 0529fcf..7c50a7f 100644
--- a/commit.h
+++ b/commit.h
@@ -20,6 +20,7 @@ struct commit {
 	struct tree *tree;
 	char *buffer;
 	unsigned long size;
+	struct object_list *unique;
 };
 
 extern int save_commit_buffer;
diff --git a/list-objects.c b/list-objects.c
index 8953548..958c0f8 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -74,22 +74,33 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree(tree) < 0)
-		die("bad tree object %s", sha1_to_hex(obj->sha1));
+	
 	obj->flags |= SEEN;
 	show(obj, path, name);
+	if (obj->flags & FACE_VALUE)
+		return;
+	
+	/* traverse_commit_list is only used for enumeration purposes, 
+	 * ie. nothing relies on trees being parsed in this routine */
+	if (parse_tree(tree) < 0)
+		die("bad tree object %s", sha1_to_hex(obj->sha1));
+
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
-
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
-		if (S_ISDIR(entry.mode))
+		if (S_ISDIR(entry.mode)) {
+			struct tree *subtree = lookup_tree(entry.sha1);
+			if (!subtree)
+				continue;
+			
+			subtree->object.flags &= ~FACE_VALUE;
 			process_tree(revs,
-				     lookup_tree(entry.sha1),
+				     subtree,
 				     show, &me, entry.path);
-		else if (S_ISGITLINK(entry.mode))
+		} else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path);
 		else
@@ -136,6 +147,7 @@ void mark_edges_uninteresting(struct commit_list *list,
 
 static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 {
+	tree->object.flags &= ~FACE_VALUE;
 	add_pending_object(revs, &tree->object, "");
 }
 
@@ -146,17 +158,27 @@ void traverse_commit_list(struct rev_info *revs,
 {
 	int i;
 	struct commit *commit;
+	enum object_type what = OBJ_TAG;
+	char face_value = 0;
 
 	while ((commit = get_revision(revs)) != NULL) {
-		add_pending_tree(revs, commit->tree);
+		if (!(commit->object.flags & FACE_VALUE))
+			add_pending_tree(revs, commit->tree);
+		else 
+			face_value = 1;
 		show_commit(commit, data);
 	}
+	
+loop_objects:
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
+		if (obj->type != what && face_value)
+			continue;
+		
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
 			show_object(obj, NULL, name);
@@ -175,6 +197,19 @@ void traverse_commit_list(struct rev_info *revs,
 		die("unknown pending object %s (%s)",
 		    sha1_to_hex(obj->sha1), name);
 	}
+	if (face_value) {
+		switch (what) {
+		case OBJ_TAG : 
+			what = OBJ_TREE;
+			goto loop_objects;
+		case OBJ_TREE : 
+			what = OBJ_BLOB;
+			goto loop_objects;
+		default : 
+			break;
+		}
+	}
+	
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
 		revs->pending.nr = 0;
diff --git a/rev-cache.c b/rev-cache.c
index 4cda858..e6808e7 100755
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -65,14 +65,20 @@ struct object_entry {
 	/* size */
 };
 
+struct bad_slice {
+	unsigned char sha1[20];
+	struct bad_slice *next;
+};
+
 /* list resembles pack index format */
 static uint32_t fanout[0xff + 2];
 
 static unsigned char *idx_map;
 static int idx_size;
 static struct index_header idx_head;
+static char no_idx, save_unique, add_to_pending;
+static struct bad_slice *bad_slices;
 static unsigned char *idx_caches;
-static char no_idx;
 
 static struct strbuf *g_buffer;
 
@@ -91,10 +97,36 @@ static struct strbuf *g_buffer;
 #define ACTUAL_OBJECT_ENTRY_SIZE(e)		(OE_SIZE + PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
 #define ENTRY_SIZE_OFFSET(e)			(ACTUAL_OBJECT_ENTRY_SIZE(e) - (e)->size_size)
 
-#define SLOP		5
+#define SLOP			5
+
+#define HAS_UNIQUES		FACE_VALUE
 
 /* initialization */
 
+static void mark_bad_slice(unsigned char *sha1)
+{
+	struct bad_slice *bad;
+	
+	bad = xcalloc(sizeof(struct bad_slice), 1);
+	hashcpy(bad->sha1, sha1);
+	
+	bad->next = bad_slices;
+	bad_slices = bad;
+}
+
+static int is_bad_slice(unsigned char *sha1)
+{
+	struct bad_slice *bad = bad_slices;
+	
+	while (bad) {
+		if (!hashcmp(bad->sha1, sha1))
+			return 1;
+		bad = bad->next;
+	}
+	
+	return 0;
+}
+
 static int get_index_head(unsigned char *map, int len, struct index_header *head, uint32_t *fanout, unsigned char **caches)
 {
 	struct index_header whead;
@@ -210,6 +242,7 @@ static struct index_entry *search_index(unsigned char *sha1)
 unsigned char *get_cache_slice(struct commit *commit)
 {
 	struct index_entry *ie;
+	unsigned char *sha1;
 	
 	if (!idx_map) {
 		if (no_idx)
@@ -221,8 +254,13 @@ unsigned char *get_cache_slice(struct commit *commit)
 		return 0;
 	
 	ie = search_index(commit->object.sha1);
-	if (ie && ie->cache_index < idx_head.cache_nr)
-		return idx_caches + ie->cache_index * 20;
+	if (ie && ie->cache_index < idx_head.cache_nr) {
+		sha1 = idx_caches + ie->cache_index * 20;
+		
+		if (is_bad_slice(sha1))
+			return 0;
+		return sha1;
+	}
 	
 	return 0;
 }
@@ -232,8 +270,29 @@ unsigned char *get_cache_slice(struct commit *commit)
 
 static unsigned long decode_size(unsigned char *str, int len);
 
+/* on failure */
+static void restore_commit(struct commit *commit)
+{
+	if (commit->unique) {
+		free(commit->unique);
+		commit->unique = 0;
+	}
+	
+	commit->object.flags &= ~(ADDED | SEEN | FACE_VALUE);
+	
+	if (!commit->object.parsed) {
+		while (pop_commit(&commit->parents)) 
+			;
+		
+		parse_commit(commit);
+	}
+	
+}
+
 static void handle_noncommit(struct rev_info *revs, struct commit *commit, struct object_entry *entry)
 {
+	static struct commit *last_commit = 0;
+	static struct object_list **last_unique = 0;
 	struct blob *blob;
 	struct tree *tree;
 	struct object *obj;
@@ -271,11 +330,27 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, struc
 		return;
 	}
 	
+	/* add to unique list if we're not an end */
+	if (save_unique && (commit->object.flags & FACE_VALUE)) {
+		if (last_commit != commit) {
+			last_commit = commit;
+			last_unique = 0;
+		}
+		
+		if (!last_unique)
+			last_unique = &commit->unique;
+		
+		object_list_append(obj, last_unique);
+		last_unique = &(*last_unique)->next;
+	}
+	
 	obj->flags |= FACE_VALUE;
-	add_pending_object(revs, obj, "");
+	if (add_to_pending)
+		add_pending_object(revs, obj, "");
 }
 
-static int setup_traversal(struct cache_slice_header *head, unsigned char *map, struct commit *commit, struct commit_list **work)
+static int setup_traversal(struct cache_slice_header *head, unsigned char *map, struct commit *commit, struct commit_list **work, 
+	struct commit_list **unwork, int *ipath_nr, int *upath_nr, char *ioutside)
 {
 	struct index_entry *iep;
 	struct object_entry *oep;
@@ -284,6 +359,11 @@ static int setup_traversal(struct cache_slice_header *head, unsigned char *map,
 	
 	iep = search_index(commit->object.sha1);
 	oep = OE_CAST(map + ntohl(iep->pos));
+	if (commit->object.flags & UNINTERESTING) {
+		++*upath_nr;
+		oep->uninteresting = 1;
+	} else
+		++*ipath_nr;
 	oep->include = 1;
 	retval = ntohl(iep->pos);
 	
@@ -299,10 +379,14 @@ static int setup_traversal(struct cache_slice_header *head, unsigned char *map,
 		/* is this in our cache slice? */
 		iep = search_index(obj->sha1);
 		if (!iep || hashcmp(idx_caches + iep->cache_index * 20, head->sha1)) {
+			/* there are interesing objects outside the slice */
+			if (!(obj->flags & UNINTERESTING))
+				*ioutside = 1;
+			
 			prev = wp;
 			wp = wp->next;
 			wpp = &wp;
- 			continue;
+			continue;
 		}
 		
 		t = ntohl(iep->pos);
@@ -313,11 +397,20 @@ static int setup_traversal(struct cache_slice_header *head, unsigned char *map,
 		if (t < retval)
 			retval = t;
 		
+		/* count even if not in slice so we can stop enumerating if possible */
+		if (obj->flags & UNINTERESTING)
+			++*upath_nr;
+		else
+			++*ipath_nr;
+		
 		/* remove from work list */
 		co = pop_commit(wpp);
 		wp = *wpp;
 		if (prev)
 			prev->next = wp;
+		
+		/* ...and store in temp list so we can restore work on failure */
+		commit_list_insert(co, unwork);
 	}
 	
 	return retval;
@@ -334,16 +427,21 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 	unsigned long *date_so_far, int *slop_so_far, 
 	struct commit_list ***queue, struct commit_list **work)
 {
-	struct commit_list *insert_cache = 0;
+	struct commit_list *insert_cache = 0, *myq = 0, **myqp = &myq, *mywork = 0, **myworkp = &mywork, *unwork = 0;
 	struct commit **last_objects, *co;
-	int i, total_path_nr = head->path_nr, retval = -1;
-	char consume_children = 0;
+	unsigned long date = date_so_far ? *date_so_far : ~0ul;
+	int i, ipath_nr = 0, upath_nr = 0, orig_obj_nr = 0, 
+		total_path_nr = head->path_nr, retval = -1, slop = slop_so_far ? *slop_so_far : SLOP;
+	char consume_children = 0, ioutside = 0;
 	unsigned char *paths;
 	
+	/* take note in case we need to regress */
+	orig_obj_nr = revs->pending.nr;
+	
 	paths = xcalloc(total_path_nr, PATH_WIDTH);
 	last_objects = xcalloc(total_path_nr, sizeof(struct commit *));
 	
-	i = setup_traversal(head, map, commit, work);
+	i = setup_traversal(head, map, commit, work, &unwork, &ipath_nr, &upath_nr, &ioutside);
 	
 	/* i already set */
 	while (i < head->size) {
@@ -386,6 +484,7 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 		
 		if ((paths[path] & IPATH) && (paths[path] & UPATH)) {
 			paths[path] = UPATH;
+			ipath_nr--;
 			
 			/* mark edge */
 			if (last_objects[path]) {
@@ -396,6 +495,7 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 				last_objects[path]->object.flags &= ~FACE_VALUE;
 				last_objects[path] = 0;
 			}
+			obj->flags |= BOUNDARY;
 		}
 		
 		/* now we gotta re-assess the whole interesting thing... */
@@ -419,8 +519,10 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 						last_objects[p]->object.flags &= ~FACE_VALUE;
 						last_objects[p] = 0;
 					}
-				} else if (last_objects[p] && !last_objects[p]->object.parsed)
+					obj->flags |= BOUNDARY;
+				} else if (last_objects[p] && !last_objects[p]->object.parsed) {
 					commit_list_insert(co, &last_objects[p]->parents);
+				}
 				
 				/* can't close a merge path until all are parents have been encountered */
 				if (GET_COUNT(paths[p])) {
@@ -430,44 +532,90 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 						continue;
 				}
 				
+				if (paths[p] & IPATH)
+					ipath_nr--;
+				else
+					upath_nr--;
+				
 				paths[p] = 0;
 				last_objects[p] = 0;
 			}
 		}
 		
 		/* make topo relations */
-		if (last_objects[path] && !last_objects[path]->object.parsed)
+		if (last_objects[path] && !last_objects[path]->object.parsed) {
 			commit_list_insert(co, &last_objects[path]->parents);
+		}
+		
+		/* we've been here already */
+		if (obj->flags & ADDED) {
+			if (entry->uninteresting && !(obj->flags & UNINTERESTING)) {
+				obj->flags |= UNINTERESTING;
+				mark_parents_uninteresting(co);
+				upath_nr--;
+			} else if (!entry->uninteresting)
+				ipath_nr--;
+			
+			paths[path] = 0;
+			continue;
+		}
 		
 		/* initialize commit */
 		if (!entry->is_end) {
 			co->date = ntohl(entry->date);
- 			obj->flags |= ADDED | FACE_VALUE;
+			obj->flags |= ADDED | FACE_VALUE;
 		} else
 			parse_commit(co);
 		
 		obj->flags |= SEEN;
- 		
- 		if (entry->uninteresting)
- 			obj->flags |= UNINTERESTING;
+		
+		if (entry->uninteresting)
+			obj->flags |= UNINTERESTING;
+		else if (co->date < date)
+			date = co->date;
 		
 		/* we need to know what the edges are */
 		last_objects[path] = co;
 		
 		/* add to list */
-		if (!(obj->flags & UNINTERESTING) || revs->show_all) {
-			if (entry->is_end)
-				insert_by_date_cached(co, work, insert_cache, &insert_cache);
-			else
-				*queue = &commit_list_insert(co, *queue)->next;
+		if (slop && !(revs->min_age != -1 && co->date > revs->min_age)) {
+			
+			if (!(obj->flags & UNINTERESTING) || revs->show_all) {
+				if (entry->is_end)
+					myworkp = &commit_list_insert(co, myworkp)->next;
+				else
+					myqp = &commit_list_insert(co, myqp)->next;
+				
+				/* add children to list as well */
+				if (obj->flags & UNINTERESTING)
+					consume_children = 0;
+				else
+					consume_children = 1;
+			}
 			
-			/* add children to list as well */
-			if (obj->flags & UNINTERESTING)
-				consume_children = 0;
-			else 
-				consume_children = 1;
 		}
 		
+		/* should we continue? */
+		if (!slop) {
+			if (!upath_nr) {
+				break;
+			} else if (ioutside || revs->show_all) {
+				/* pass it back to rev-list
+				 * we purposely ignore everything outside this cache, so we don't needlessly traverse the whole 
+				 * thing on uninteresting, but that does mean that we may need to bounce back 
+				 * and forth a few times with rev-list */
+				myworkp = &commit_list_insert(co, myworkp)->next;
+				
+				paths[path] = 0;
+				upath_nr--;
+			} else {
+				break;
+			}
+		} else if (!ipath_nr && co->date <= date)
+			slop--;
+		else
+			slop = SLOP;
+		
 		/* open parents */
 		if (entry->merge_nr) {
 			int j, off = index + OE_SIZE;
@@ -482,6 +630,11 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 				if (paths[p] & flag)
 					continue;
 				
+				if (flag == IPATH)
+					ipath_nr++;
+				else
+					upath_nr++;
+				
 				paths[p] |= flag;
 			}
 			
@@ -491,12 +644,55 @@ static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char
 		
 	}
 	
+	if (date_so_far)
+		*date_so_far = date;
+	if (slop_so_far)
+		*slop_so_far = slop;
 	retval = 0;
 	
+	/* success: attach to given lists */
+	if (myqp != &myq) {
+		**queue = myq;
+		*queue = myqp;
+	}
+	
+	while ((co = pop_commit(&mywork)) != 0) {
+		insert_by_date_cached(co, work, insert_cache, &insert_cache);
+	}
+	
+	/* free backup */
+	while (pop_commit(&unwork)) 
+		;
+	
 end:
 	free(paths);
 	free(last_objects);
 	
+	/* failure: restore work to previous condition
+	 * (cache corruption should *not* be fatal) */
+	if (retval) {
+		while ((co = pop_commit(&unwork)) != 0) {
+			restore_commit(co);
+			co->object.flags |= SEEN;
+			insert_by_date(co, work);
+		}
+		
+		/* free lists */
+		while ((co = pop_commit(&myq)) != 0)
+			restore_commit(co);
+		
+		while ((co = pop_commit(&mywork)) != 0)
+			restore_commit(co);
+		
+		/* truncate object array */
+		for (i = orig_obj_nr; i < revs->pending.nr; i++) {
+			struct object *obj = revs->pending.objects[i].item;
+			
+			obj->flags &= ~FACE_VALUE;
+		}
+		revs->pending.nr = orig_obj_nr;
+	}
+	
 	return retval;
 }
 
@@ -545,6 +741,8 @@ int traverse_cache_slice(struct rev_info *revs,
 	
 	/* load options */
 	rci = &revs->rev_cache_info;
+	save_unique = rci->save_unique;
+	add_to_pending = rci->add_to_pending;
 	
 	memset(&head, 0, sizeof(struct cache_slice_header));
 	
@@ -568,6 +766,10 @@ end:
 	if (fd != -1)
 		close(fd);
 	
+	/* remember this! */
+	if (retval)
+		mark_bad_slice(cache_sha1);
+	
 	return retval;
 }
 
@@ -762,6 +964,7 @@ static void handle_paths(struct commit *commit, struct object_entry *object, str
 		if (pt->commit == commit) {
 			if (paths[pt->path] != PATH_IN_USE)
 				paths[pt->path]--;
+			
 			remove_path_track(ppt, 0);
 			pt = *ppt;
 		} else {
@@ -1021,6 +1224,21 @@ static int add_unique_objects(struct commit *commit)
 	int i, j, next;
 	char is_first = 1;
 	
+	/* but wait!  is this itself from a slice? */
+	if (commit->unique) {
+		struct object_list *olist;
+		
+		olist = commit->unique;
+		i = 0;
+		while (olist) {
+			add_object_entry(olist->item->sha1, 0, 0, 0);
+			i++;
+			olist = olist->next;
+		}
+		
+		return i;
+	}
+	
 	/* ...no, calculate unique objects */
 	strbuf_init(&os, 0);
 	strbuf_init(&ost, 0);
@@ -1074,10 +1292,13 @@ static int add_unique_objects(struct commit *commit)
 	for (i = 0; i < os.len; i += 20)
 		add_object_entry((unsigned char *)(os.buf + i), 0, 0, 0);
 	
+	/* last but not least, the main tree */
+	add_object_entry(commit->tree->object.sha1, 0, 0, 0);
+	
 	strbuf_release(&ost);
 	strbuf_release(&os);
 	
-	return i / 20;
+	return i / 20 + 1;
 }
 
 static void init_revcache_directory(void)
@@ -1196,14 +1417,8 @@ int make_cache_slice(struct rev_cache_info *rci,
 		add_object_entry(0, &object, &merge_paths, &split_paths);
 		object_nr++;
 		
-		if (rci->objects && !(commit->object.flags & TREESAME)) {
-			/* add all unique children for this commit */
-			add_object_entry(commit->tree->object.sha1, 0, 0, 0);
-			object_nr++;
-			
-			if (!object.is_end)
-				object_nr += add_unique_objects(commit);
-		}
+		if (rci->objects && !(commit->object.flags & TREESAME) && !object.is_end)
+			object_nr += add_unique_objects(commit);
 		
 		/* print every ~1MB or so */
 		if (buffer.len > 1000000) {
@@ -1481,7 +1696,6 @@ void starts_from_slices(struct rev_info *revs, unsigned int flags, unsigned char
 	
 }
 
-
 /* the most work-intensive attributes in the cache are the unique objects and size, both 
  * of which can be re-used.  although path structures will be isomorphic, path generation is 
  * not particularly expensive, and at any rate we need to re-sort the commits */
@@ -1527,7 +1741,7 @@ int coagulate_cache_slices(struct rev_cache_info *rci, struct rev_info *revs)
 				}
 			}
 			
-			string_list_insert(base, &files);
+			string_list_insert(de->d_name, &files);
 		}
 		
 		closedir(dirh);
@@ -1548,15 +1762,20 @@ int coagulate_cache_slices(struct rev_cache_info *rci, struct rev_info *revs)
 	for (i = 0; i < files.nr; i++) {
 		char *name = files.items[i].string;
 		
-		fprintf(stderr, "removing %s\n", name);
-		unlink_or_warn(name);
+		/* in the odd case of only having one cache slice we effectively just remaking the index... */
+		if (strlen(name) >= 40 && !strncmp(name, sha1_to_hex(cache_sha1), 40))
+			continue;
+		
+		strncpy(base + baselen + 1, name, sizeof(base) - baselen - 1);
+		fprintf(stderr, "removing %s\n", base);
+		unlink_or_warn(base);
 	}
 	
 	string_list_clear(&files, 0);
 	
 	fd = open(git_path("rev-cache/%s", sha1_to_hex(cache_sha1)), O_RDWR);
 	if (fd < 0 || fstat(fd, &fi))
-		die("what?  I can't open/query the cache I just generated");
+		die("what?  I can't open/query the cache I just generated\n (sha1: %s)", sha1_to_hex(cache_sha1));
 	
 	if (make_cache_index(rci, cache_sha1, fd, fi.st_size) < 0)
 		die("can't make new index");
@@ -1610,4 +1829,4 @@ int regenerate_cache_index(struct rev_cache_info *rci)
 	}
 	
 	return 0;
-}
\ No newline at end of file
+}
diff --git a/revision.c b/revision.c
index 485bf72..e76fd1d 100644
--- a/revision.c
+++ b/revision.c
@@ -638,6 +638,8 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
+	unsigned char *cache_sha1;
+	char used_cache;
 
 	while (list) {
 		struct commit_list *entry = list;
@@ -650,24 +652,39 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (add_parents_to_list(revs, commit, &list, NULL) < 0)
-			return -1;
-		if (obj->flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
-			if (revs->show_all)
-				p = &commit_list_insert(commit, p)->next;
-			slop = still_interesting(list, date, slop);
-			if (slop)
+		
+		/* rev-cache to the rescue!!! */
+		used_cache = 0;
+		if (!revs->dont_cache_me && !(obj->flags & ADDED)) {
+			cache_sha1 = get_cache_slice(commit);
+			if (cache_sha1) {
+				if (traverse_cache_slice(revs, cache_sha1, commit, &date, &slop, &p, &list) < 0)
+					used_cache = 0;
+				else
+					used_cache = 1;
+			}
+		}
+		
+		if (!used_cache) {
+			if (add_parents_to_list(revs, commit, &list, NULL) < 0)
+				return -1;
+			if (obj->flags & UNINTERESTING) {
+				mark_parents_uninteresting(commit); /* ME: why? */
+				if (revs->show_all)
+					p = &commit_list_insert(commit, p)->next;
+				slop = still_interesting(list, date, slop);
+				if (slop > 0)
+					continue;
+				/* If showing all, add the whole pending list to the end */
+				if (revs->show_all)
+					*p = list;
+				break;
+			}
+			if (revs->min_age != -1 && (commit->date > revs->min_age))
 				continue;
-			/* If showing all, add the whole pending list to the end */
-			if (revs->show_all)
-				*p = list;
-			break;
+			date = commit->date;
+			p = &commit_list_insert(commit, p)->next;
 		}
-		if (revs->min_age != -1 && (commit->date > revs->min_age))
-			continue;
-		date = commit->date;
-		p = &commit_list_insert(commit, p)->next;
 
 		show = show_early_output;
 		if (!show)
@@ -813,6 +830,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
 	}
+	
+	init_rci(&revs->rev_cache_info);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -1372,6 +1391,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
 
+	/* limits on caching
+	 * todo: implement this functionality */
+	if (revs->prune || revs->diff)
+		revs->dont_cache_me = 1;
+
 	return left;
 }
 
@@ -1654,6 +1678,8 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	if (!opt->grep_filter.pattern_list)
 		return 1;
+	if (!commit->object.parsed)
+		parse_commit(commit);
 	return grep_buffer(&opt->grep_filter,
 			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
@@ -1706,6 +1732,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 	do {
 		struct commit_list *entry = revs->commits;
 		struct commit *commit = entry->item;
+		struct object *obj = &commit->object;
 
 		revs->commits = entry->next;
 		free(entry);
@@ -1722,11 +1749,39 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->max_age != -1 &&
 			    (commit->date < revs->max_age))
 				continue;
+			
+			if (!revs->dont_cache_me) {
+				struct commit_list *queue = 0, **queuep = &queue;;
+				unsigned char *cache_sha1;
+				
+				if (obj->flags & ADDED)
+					goto skip_parenting;
+				
+				cache_sha1 = get_cache_slice(commit);
+				if (cache_sha1) {
+					if (!traverse_cache_slice(revs, cache_sha1, commit, 0, 0, &queuep, &revs->commits)) {
+						struct commit_list *work = revs->commits;
+						
+						/* attach queue to end of ->commits */
+						while (work && work->next)
+							work = work->next;
+						
+						if (work)
+							work->next = queue;
+						else
+							revs->commits = queue;
+						
+						goto skip_parenting;
+					}
+				}
+			}
+			
 			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0)
 				die("Failed to traverse parents of commit %s",
 				    sha1_to_hex(commit->object.sha1));
 		}
 
+skip_parenting:
 		switch (simplify_commit(revs, commit)) {
 		case commit_ignore:
 			continue;
diff --git a/t/t6015-rev-cache-list.sh b/t/t6015-rev-cache-list.sh
index 8aea2e3..561810f 100755
--- a/t/t6015-rev-cache-list.sh
+++ b/t/t6015-rev-cache-list.sh
@@ -37,7 +37,8 @@ test_expect_success 'init repo' '
 	echo omg >smoke/bong && 
 	git add . && 
 	git commit -m "omg" && 
-	
+
+	sleep 2 && 
 	git branch b4 && 
 	git checkout b4 && 
 	echo shazam >file8 && 
@@ -46,9 +47,9 @@ test_expect_success 'init repo' '
 	git merge -m "merge b2" b2 && 
 	
 	echo bam >smoke/pipe && 
-	git add .
+	git add . && 
 	git commit -m "bam" && 
-	
+
 	git checkout master && 
 	echo pow >file7 && 
 	git add . && 
@@ -71,18 +72,26 @@ test_expect_success 'init repo' '
 	git add . && 
 	git commit -m "lol" && 
 
+	sleep 2 && 
 	git checkout master && 
 	git merge -m "triple merge" b1 b11 && 
 	git rm -r d1 &&  
+	sleep 2 && 
 	git commit -a -m "oh noes"
 '
 
-git-rev-list HEAD --not HEAD~3 >proper_commit_list_limited
-git-rev-list HEAD >proper_commit_list
-git-rev-list HEAD --objects >proper_object_list
+max_date=`git-rev-list --timestamp HEAD~1 --max-count=1 | grep -e "^[0-9]*" -o`
+min_date=`git-rev-list --timestamp b4 --max-count=1 | grep -e "^[0-9]*" -o`
+
+git-rev-list --topo-order HEAD --not HEAD~3 >proper_commit_list_limited
+git-rev-list --topo-order HEAD --not HEAD~2 >proper_commit_list_limited2
+git-rev-list --topo-order HEAD >proper_commit_list
+git-rev-list --objects HEAD >proper_object_list
+git-rev-list HEAD --max-age=$min_date --min-age=$max_date >proper_list_date_limited
+
+cache_sha1=`git-rev-cache add HEAD 2>output.err`
 
 test_expect_success 'make cache slice' '
-	git-rev-cache add HEAD 2>output.err && 
 	grep "final return value: 0" output.err
 '
 
@@ -98,15 +107,140 @@ test_expect_success 'test rev-caches walker directly (limited)' '
 '
 
 test_expect_success 'test rev-caches walker directly (unlimited)' '
-	git-rev-cache walk HEAD >list &&  
+	git-rev-cache walk HEAD >list && 
 	test_cmp_sorted list proper_commit_list
 '
 
+test_expect_success 'test rev-list traversal (limited)' '
+	git-rev-list HEAD --not HEAD~3 >list && 
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-list traversal (unlimited)' '
+	git-rev-list HEAD >list && 
+	test_cmp list proper_commit_list
+'
+
 #do the same for objects
 test_expect_success 'test rev-caches walker with objects' '
 	git-rev-cache walk --objects HEAD >list && 
 	test_cmp_sorted list proper_object_list
 '
 
-test_done
+test_expect_success 'test rev-list with objects (topo order)' '
+	git-rev-list --topo-order --objects HEAD >list && 
+	test_cmp_sorted list proper_object_list
+'
+
+test_expect_success 'test rev-list with objects (no order)' '
+	git-rev-list --objects HEAD >list && 
+	test_cmp_sorted list proper_object_list
+'
+
+#verify age limiting
+test_expect_success 'test rev-list date limiting (topo order)' '
+	git-rev-list --topo-order --max-age=$min_date --min-age=$max_date HEAD >list && 
+	test_cmp_sorted list proper_list_date_limited
+'
+
+test_expect_success 'test rev-list date limiting (no order)' '
+	git-rev-list --max-age=$min_date --min-age=$max_date HEAD >list && 
+	test_cmp_sorted list proper_list_date_limited
+'
+
+#check partial cache slice
+test_expect_success 'saving old cache and generating partial slice' '
+	cp ".git/rev-cache/$cache_sha1" .git/rev-cache/.old && 
+	rm ".git/rev-cache/$cache_sha1" .git/rev-cache/index && 
+
+	git-rev-cache add HEAD~2 2>output.err && 
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'rev-list with wholly interesting partial slice' '
+	git-rev-list --topo-order HEAD >list && 
+	test_cmp list proper_commit_list
+'
+
+test_expect_success 'rev-list with partly uninteresting partial slice' '
+	git-rev-list --topo-order HEAD --not HEAD~3 >list && 
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'rev-list with wholly uninteresting partial slice' '
+	git-rev-list --topo-order HEAD --not HEAD~2 >list && 
+	test_cmp list proper_commit_list_limited2
+'
 
+#try out index generation and fuse (note that --all == HEAD in this case)
+#probably should make a test for that too...
+test_expect_success 'make fresh slice' '
+	git-rev-cache add --all --fresh 2>output.err && 
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'check dual slices' '
+	git-rev-list --topo-order HEAD~2 HEAD >list && 
+	test_cmp list proper_commit_list
+'
+
+test_expect_success 'regenerate index' '
+	rm .git/rev-cache/index && 
+	git-rev-cache index 2>output.err && 
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'fuse slices' '
+	test -e .git/rev-cache/.old && 
+	git-rev-cache fuse 2>output.err && 
+	grep "final return value: 0" output.err && 
+	test_cmp .git/rev-cache/$cache_sha1 .git/rev-cache/.old
+'
+
+#make sure we can smoothly handle corrupted caches
+test_expect_success 'corrupt slice' '
+	echo bla >.git/rev-cache/$cache_sha1
+'
+
+test_expect_success 'test rev-list traversal (limited) (corrupt slice)' '
+	git-rev-list --topo-order HEAD --not HEAD~3 >list && 
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-list traversal (unlimited) (corrupt slice)' '
+	git-rev-list HEAD >list && 
+	test_cmp_sorted list proper_commit_list
+'
+
+test_expect_success 'corrupt index' '
+	echo blu >.git/rev-cache/index
+'
+
+test_expect_success 'test rev-list traversal (limited) (corrupt index)' '
+	git-rev-list --topo-order HEAD --not HEAD~3 >list && 
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-list traversal (unlimited) (corrupt index)' '
+	git-rev-list HEAD >list && 
+	test_cmp_sorted list proper_commit_list
+'
+
+#test --ignore-size in fuse
+rm .git/rev-cache/*
+cache_sha1=`git-rev-cache add HEAD --not HEAD~3 2>output.err`
+
+test_expect_success 'make fragmented slices' '
+	git-rev-cache add HEAD~2 --not HEAD~3 2>>output.err && 
+	git-rev-cache add HEAD --fresh 2>>output.err && 
+	test `grep "final return value: 0" output.err | wc -l` -eq 3
+'
+
+cache_size=`wc -c .git/rev-cache/$cache_sha1 | grep -o "[0-9]*"`
+test_expect_success 'test --ignore-size function in fuse' '
+	git-rev-cache fuse --ignore-size=$cache_size 2>output.err && 
+	grep "final return value: 0" output.err && 
+	test -e .git/rev-cache/$cache_sha1
+'
+
+test_done
-- 
tg: (c7a46b0..) t/revcache/integration (depends on: t/revcache/misc)
