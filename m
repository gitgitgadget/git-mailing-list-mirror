From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH 5/7 (v5)] integration into revision walker
Date: Mon, 05 Apr 2010 20:58:32 +0100
Message-ID: <4BBA40E8.1050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Apr 05 21:58:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NysRX-0001GP-Uq
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409Ab0DET6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:58:34 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:33419 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab0DET6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:58:33 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so121824ewy.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=YwxCFBnJ316F7v8WZI+V8GKn9xMHbBgIHASsbHQDr3U=;
        b=fplkUaBsuwk9lU9wOoHAT2IpC2prv+7yWjbTvs7ZADOqeNAMmNeIVbQjc0b6ozCKeF
         6Pgez04LUDNHN/gI0Fx3IP9D+6R+amKo0tijtbueMqTik/td5gag6Mz8y8mg+OPJrQmy
         O75BfL24a2yPHKGcDlSHitgRSov3Aj+EHhxWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=n9GlV6krTm0kOWULSlW/q1CG3Qqgr8sQ+WGqqmyPHJ3RvFFwR8gdFMRvQr36u90N/n
         8TgA7IlywUzYlLf1tx2oAxo3HZqcrS8aUIeso4/Wq4lIABvvz8/BT/kM33yifdlTCDB/
         J8jZ91l9G7PbtLszKoK3Ho17xycP25zMoAnDo=
Received: by 10.213.68.11 with SMTP id t11mr3198540ebi.98.1270497512085;
        Mon, 05 Apr 2010 12:58:32 -0700 (PDT)
Received: from [192.168.55.86] (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 13sm6445590ewy.1.2010.04.05.12.58.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 12:58:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144063>

Provides a working integration of rev-cache into the revision walker, along
with some touch-ups:
 - integration into revision walker and list-objects
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
 builtin/rev-cache.c       |   40 ++++++++
 list-objects.c            |   46 ++++++++-
 rev-cache.c               |  225 ++++++++++++++++++++++++++++++++++++++++-----
 revision.c                |   88 ++++++++++++++---
 t/t6019-rev-cache-list.sh |  150 +++++++++++++++++++++++++++++-
 5 files changed, 498 insertions(+), 51 deletions(-)

diff --git a/builtin/rev-cache.c b/builtin/rev-cache.c
index d6cd57b..7a79007 100644
--- a/builtin/rev-cache.c
+++ b/builtin/rev-cache.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "rev-cache.h"
+#include "list-objects.h"
 
 unsigned long default_ignore_size = 50 * 1024 * 1024; /* 50mb */
 
@@ -78,6 +79,43 @@ static int handle_add(int argc, const char *argv[]) /* args beyond this command
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
@@ -277,6 +315,8 @@ int cmd_rev_cache(int argc, const char *argv[], const char *prefix)
 		r = handle_walk(argc, argv);
 	else if (!strcmp(arg, "index"))
 		r = handle_index(argc, argv);
+	else if (!strcmp(arg, "test"))
+		r = test_rev_list(argc, argv);
 	else if (!strcmp(arg, "alt"))
 		r = handle_alt(argc, argv);
 	else
diff --git a/list-objects.c b/list-objects.c
index 8953548..b8c3370 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -74,22 +74,34 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+	if (obj->flags & FACE_VALUE) {
+		obj->flags |= SEEN;
+		show(obj, path, name);
+		/* not parsing the tree saves a lot of time! */
+		return;
+	}
+
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
 	show(obj, path, name);
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
@@ -136,6 +148,7 @@ void mark_edges_uninteresting(struct commit_list *list,
 
 static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 {
+	tree->object.flags &= ~FACE_VALUE;
 	add_pending_object(revs, &tree->object, "");
 }
 
@@ -146,17 +159,27 @@ void traverse_commit_list(struct rev_info *revs,
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
@@ -175,6 +198,19 @@ void traverse_commit_list(struct rev_info *revs,
 		die("unknown pending object %s (%s)",
 		    sha1_to_hex(obj->sha1), name);
 	}
+	if (face_value) {
+		switch (what) {
+		case OBJ_TAG:
+			what = OBJ_TREE;
+			goto loop_objects;
+		case OBJ_TREE:
+			what = OBJ_BLOB;
+			goto loop_objects;
+		default:
+			break;
+		}
+	}
+
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
 		revs->pending.nr = 0;
diff --git a/rev-cache.c b/rev-cache.c
index 27e3b40..af1a704 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -11,6 +11,12 @@
 #include "run-command.h"
 #include "string-list.h"
 
+
+struct bad_slice {
+	unsigned char sha1[20];
+	struct bad_slice *next;
+};
+
 struct cache_slice_pointer {
 	char signature[8]; /* REVCOPTR */
 	char version;
@@ -23,8 +29,9 @@ static uint32_t fanout[0xff + 2];
 static unsigned char *idx_map;
 static int idx_size;
 static struct rc_index_header idx_head;
+static char no_idx, add_to_pending;
+static struct bad_slice *bad_slices;
 static unsigned char *idx_caches;
-static char no_idx;
 
 static struct strbuf *acc_buffer;
 
@@ -183,6 +190,30 @@ unsigned char *to_disked_rc_object_entry(struct rc_object_entry *src, unsigned c
 	return dst;
 }
 
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
 static int get_index_head(unsigned char *map, int len, struct rc_index_header *head, uint32_t *fanout, unsigned char **caches)
 {
 	int i, index = INDEX_HEADER_SIZE;
@@ -306,6 +337,7 @@ static struct rc_index_entry *search_index(unsigned char *sha1)
 unsigned char *get_cache_slice(struct commit *commit)
 {
 	struct rc_index_entry *ie;
+	unsigned char *sha1;
 
 	if (!idx_map) {
 		if (no_idx)
@@ -317,8 +349,13 @@ unsigned char *get_cache_slice(struct commit *commit)
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
@@ -328,6 +365,20 @@ unsigned char *get_cache_slice(struct commit *commit)
 
 static unsigned long decode_size(unsigned char *str, int len);
 
+/* on failure */
+static void restore_commit(struct commit *commit)
+{
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
 static void handle_noncommit(struct rev_info *revs, struct commit *commit, unsigned char *ptr, struct rc_object_entry *entry)
 {
 	struct blob *blob;
@@ -367,7 +418,8 @@ static void handle_noncommit(struct rev_info *revs, struct commit *commit, unsig
 	}
 
 	obj->flags |= FACE_VALUE;
-	add_pending_object(revs, obj, "");
+	if (add_to_pending)
+		add_pending_object(revs, obj, "");
 }
 
 struct entrance_point {
@@ -389,7 +441,8 @@ static int eps_sort_callback(const void *a, const void *b)
 }
 
 static int setup_traversal(struct rc_slice_header *head, struct entrance_point **peps, int *peplen,
-	struct commit *commit, struct commit_list **work)
+	struct commit *commit, struct commit_list **work,
+	struct commit_list **unwork, int *ipath_nr, int *upath_nr, char *ioutside)
 {
 	struct rc_index_entry *iep;
 	struct commit_list *prev, *wp, **wpp;
@@ -398,11 +451,13 @@ static int setup_traversal(struct rc_slice_header *head, struct entrance_point *
 
 	eps = xcalloc(1, eplen * sizeof(struct entrance_point));
 	iep = search_index(commit->object.sha1);
+	if (commit->object.flags & UNINTERESTING) {
+		++*upath_nr;
+		eps[0].uninteresting = 1;
+	} else
+		++*ipath_nr;
 
-	/* the .uniniteresting bit isn't strictly necessary, as we check the object during traversal as well,
-	 * but we might as well initialize it while we're at it */
 	eps[0].pos = iep->pos;
-	eps[0].uninteresting = !!(commit->object.flags & UNINTERESTING);
 	retval = iep->pos;
 
 	/* include any others in the work array */
@@ -416,6 +471,10 @@ static int setup_traversal(struct rc_slice_header *head, struct entrance_point *
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
@@ -435,11 +494,20 @@ static int setup_traversal(struct rc_slice_header *head, struct entrance_point *
 		eps[curep].uninteresting = !!(obj->flags & UNINTERESTING);
 		curep++;
 
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
 
 	qsort(eps, curep, sizeof(struct entrance_point), eps_sort_callback);
@@ -459,15 +527,20 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
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
 	struct entrance_point *eps;
 	int eplen, curep = 0;
 
-	i = setup_traversal(head, &eps, &eplen, commit, work);
+	/* take note in case we need to regress */
+	orig_obj_nr = revs->pending.nr;
+
+	i = setup_traversal(head, &eps, &eplen, commit, work, &unwork, &ipath_nr, &upath_nr, &ioutside);
 	if (i < 0)
 		return -1;
 
@@ -516,6 +589,7 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 
 		if ((paths[path] & IPATH) && (paths[path] & UPATH)) {
 			paths[path] = UPATH;
+			ipath_nr--;
 
 			/* mark edge */
 			if (last_objects[path]) {
@@ -526,6 +600,7 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 				last_objects[path]->object.flags &= ~FACE_VALUE;
 				last_objects[path] = 0;
 			}
+			obj->flags |= BOUNDARY;
 		}
 
 		/* now we gotta re-assess the whole interesting thing... */
@@ -549,8 +624,10 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
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
@@ -560,14 +637,33 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
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
+			if (uninteresting && !(obj->flags & UNINTERESTING)) {
+				obj->flags |= UNINTERESTING;
+				mark_parents_uninteresting(co);
+				upath_nr--;
+			} else if (!uninteresting)
+				ipath_nr--;
+
+			paths[path] = 0;
+			continue;
+		}
 
 		/* initialize commit */
 		if (!entry->is_end) {
@@ -582,24 +678,51 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 
 		if (uninteresting)
 			obj->flags |= UNINTERESTING;
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
 			int j, off = index + OBJECT_ENTRY_SIZE;
@@ -614,6 +737,11 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 				if (paths[p] & flag)
 					continue;
 
+				if (flag == IPATH)
+					ipath_nr++;
+				else
+					upath_nr++;
+
 				paths[p] |= flag;
 			}
 
@@ -623,13 +751,55 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 
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
+	while ((co = pop_commit(&mywork)) != 0)
+		insert_by_date_cached(co, work, insert_cache, &insert_cache);
+
+	/* free backup */
+	while (pop_commit(&unwork))
+		;
+
 end:
 	free(paths);
 	free(last_objects);
 	free(eps);
 
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
 
@@ -723,6 +893,7 @@ int traverse_cache_slice(struct rev_info *revs,
 
 	/* load options */
 	rci = &revs->rev_cache_info;
+	add_to_pending = rci->add_to_pending;
 
 	memset(&head, 0, sizeof(struct rc_slice_header));
 
@@ -746,6 +917,10 @@ end:
 	if (fd != -1)
 		close(fd);
 
+	/* remember this! */
+	if (retval)
+		mark_bad_slice(cache_sha1);
+
 	return retval;
 }
 
diff --git a/revision.c b/revision.c
index cd3dba8..201407c 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "rev-cache.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -653,6 +654,8 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
+	unsigned char *cache_sha1;
+	char used_cache;
 
 	while (list) {
 		struct commit_list *entry = list;
@@ -665,24 +668,39 @@ static int limit_list(struct rev_info *revs)
 
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
@@ -835,6 +853,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
 	}
+
+	init_rev_cache_info(&revs->rev_cache_info);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -1547,6 +1567,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
 
+	/* limits on caching
+	 * todo: implement this functionality */
+	if (revs->prune || revs->diff)
+		revs->dont_cache_me = 1;
+
 	return left;
 }
 
@@ -1829,6 +1854,8 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
+	if (!commit->object.parsed)
+		parse_commit(commit);
 	return grep_buffer(&opt->grep_filter,
 			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
@@ -1892,6 +1919,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 	do {
 		struct commit_list *entry = revs->commits;
 		struct commit *commit = entry->item;
+		struct object *obj = &commit->object;
 
 		revs->commits = entry->next;
 		free(entry);
@@ -1908,11 +1936,39 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->max_age != -1 &&
 			    (commit->date < revs->max_age))
 				continue;
+
+			if (!revs->dont_cache_me) {
+				struct commit_list *queue = 0, **queuep = &queue;
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
diff --git a/t/t6019-rev-cache-list.sh b/t/t6019-rev-cache-list.sh
index b6cf6fc..77cd191 100644
--- a/t/t6019-rev-cache-list.sh
+++ b/t/t6019-rev-cache-list.sh
@@ -38,6 +38,7 @@ test_expect_success 'init repo' '
 	git add . &&
 	git commit -m "omg" &&
 
+	sleep 2 &&
 	git branch b4 &&
 	git checkout b4 &&
 	echo shazam >file8 &&
@@ -46,7 +47,7 @@ test_expect_success 'init repo' '
 	git merge -m "merge b2" b2 &&
 
 	echo bam >smoke/pipe &&
-	git add .
+	git add . &&
 	git commit -m "bam" &&
 
 	git checkout master &&
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
 
-git rev-list HEAD --not HEAD~3 >proper_commit_list_limited
-git rev-list HEAD >proper_commit_list
-git rev-list HEAD --objects >proper_object_list
+max_date=`git rev-list --timestamp HEAD~1 --max-count=1 | grep -e "^[0-9]*" -o`
+min_date=`git rev-list --timestamp b4 --max-count=1 | grep -e "^[0-9]*" -o`
+
+git rev-list --topo-order HEAD --not HEAD~3 >proper_commit_list_limited
+git rev-list --topo-order HEAD --not HEAD~2 >proper_commit_list_limited2
+git rev-list --topo-order HEAD >proper_commit_list
+git rev-list --objects HEAD >proper_object_list
+git rev-list HEAD --max-age=$min_date --min-age=$max_date >proper_list_date_limited
+
+cache_sha1=`git rev-cache add HEAD 2>output.err`
 
 test_expect_success 'make cache slice' '
-	git rev-cache add HEAD 2>output.err &&
 	grep "final return value: 0" output.err
 '
 
@@ -102,11 +111,142 @@ test_expect_success 'test rev-caches walker directly (unlimited)' '
 	test_cmp_sorted list proper_commit_list
 '
 
+test_expect_success 'test rev-list traversal (limited)' '
+	git rev-list HEAD --not HEAD~3 >list &&
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-list traversal (unlimited)' '
+	git rev-list HEAD >list &&
+	test_cmp list proper_commit_list
+'
+
 #do the same for objects
 test_expect_success 'test rev-caches walker with objects' '
 	git rev-cache walk --objects HEAD >list &&
 	test_cmp_sorted list proper_object_list
 '
 
+test_expect_success 'test rev-list with objects (topo order)' '
+	git rev-list --topo-order --objects HEAD >list &&
+	test_cmp_sorted list proper_object_list
+'
+
+test_expect_success 'test rev-list with objects (no order)' '
+	git rev-list --objects HEAD >list &&
+	test_cmp_sorted list proper_object_list
+'
+
+#verify age limiting
+test_expect_success 'test rev-list date limiting (topo order)' '
+	git rev-list --topo-order --max-age=$min_date --min-age=$max_date HEAD >list &&
+	test_cmp_sorted list proper_list_date_limited
+'
+
+test_expect_success 'test rev-list date limiting (no order)' '
+	git rev-list --max-age=$min_date --min-age=$max_date HEAD >list &&
+	test_cmp_sorted list proper_list_date_limited
+'
+
+#check partial cache slice
+test_expect_success 'saving old cache and generating partial slice' '
+	cp ".git/rev-cache/$cache_sha1" .git/rev-cache/.old &&
+	rm ".git/rev-cache/$cache_sha1" .git/rev-cache/index &&
+
+	git rev-cache add HEAD~2 2>output.err &&
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'rev-list with wholly interesting partial slice' '
+	git rev-list --topo-order HEAD >list &&
+	test_cmp list proper_commit_list
+'
+
+test_expect_success 'rev-list with partly uninteresting partial slice' '
+	git rev-list --topo-order HEAD --not HEAD~3 >list &&
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'rev-list with wholly uninteresting partial slice' '
+	git rev-list --topo-order HEAD --not HEAD~2 >list &&
+	test_cmp list proper_commit_list_limited2
+'
+
+#try out index generation and fuse (note that --all == HEAD in this case)
+#probably should make a test for that too...
+test_expect_success 'test (non-)fusion of one slice' '
+	git rev-cache fuse >output.err &&
+	grep "nothing to fuse" output.err
+'
+
+test_expect_success 'make fresh slice' '
+	git rev-cache add --all --fresh 2>output.err &&
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'check dual slices' '
+	git rev-list --topo-order HEAD~2 HEAD >list &&
+	test_cmp list proper_commit_list
+'
+
+test_expect_success 'regenerate index' '
+	rm .git/rev-cache/index &&
+	git rev-cache index 2>output.err &&
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'fuse slices' '
+	test -e .git/rev-cache/.old &&
+	git rev-cache fuse 2>output.err &&
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
+	git rev-list --topo-order HEAD --not HEAD~3 >list &&
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-list traversal (unlimited) (corrupt slice)' '
+	git rev-list HEAD >list &&
+	test_cmp_sorted list proper_commit_list
+'
+
+test_expect_success 'corrupt index' '
+	echo blu >.git/rev-cache/index
+'
+
+test_expect_success 'test rev-list traversal (limited) (corrupt index)' '
+	git rev-list --topo-order HEAD --not HEAD~3 >list &&
+	test_cmp list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-list traversal (unlimited) (corrupt index)' '
+	git rev-list HEAD >list &&
+	test_cmp_sorted list proper_commit_list
+'
+
+#test --ignore-size in fuse
+rm .git/rev-cache/*
+cache_sha1=`git rev-cache add HEAD~2 2>output.err`
+
+test_expect_success 'make fragmented slices' '
+	git rev-cache add HEAD~1 --not HEAD~2 2>>output.err &&
+	git rev-cache add HEAD --fresh 2>>output.err &&
+	test `grep "final return value: 0" output.err | wc -l` -eq 3
+'
+
+cache_size=$(wc -c < .git/rev-cache/$cache_sha1)
+test_expect_success 'test --ignore-size function in fuse' '
+	git rev-cache fuse --ignore-size=$cache_size 2>output.err &&
+	grep "final return value: 0" output.err &&
+	test -e .git/rev-cache/$cache_sha1
+'
+
 test_done
 
-- 
tg: (c8f0b1d..) t/rc/int (depends on: t/rc/misc)
