From: Linus Torvalds <torvalds@osdl.org>
Subject: Add "named object array" concept
Date: Mon, 19 Jun 2006 17:42:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606191726160.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 02:42:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsUKM-0007gM-2m
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 02:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWFTAmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 20:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWFTAmn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 20:42:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965014AbWFTAmm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 20:42:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5K0gagt021748
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Jun 2006 17:42:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5K0gZ4B020283;
	Mon, 19 Jun 2006 17:42:35 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22152>


We've had this notion of a "object_list" for a long time, which eventually 
grew a "name" member because some users (notably git-rev-list) wanted to 
name each object as it is generated.

That object_list is great for some things, but it isn't all that wonderful 
for others, and the "name" member is generally not used by everybody.

This patch splits the users of the object_list array up into two: the 
traditional list users, who want the list-like format, and who don't 
actually use or want the name. And another class of users that really used 
the list as an extensible array, and generally wanted to name the objects.

The patch is fairly straightforward, but it's also biggish. Most of it 
really just cleans things up: switching the revision parsing and listing 
over to the array makes things like the builtin-diff usage much simpler 
(we now see exactly how many members the array has, and we don't get the 
objects reversed from the order they were on the command line).

One of the main reasons for doing this at all is that the malloc overhead 
of the simple object list was actually pretty high, and the array is just 
a lot denser. So this patch brings down memory usage by git-rev-list by 
just under 3% (on top of all the other memory use optimizations) on the 
mozilla archive.

It does add more lines than it removes, and more importantly, it adds a 
whole new infrastructure for maintaining lists of objects, but on the 
other hand, the new dynamic array code is pretty obvious. The change to 
builtin-diff-tree.c shows a fairly good example of why an array interface 
is sometimes more natural, and just much simpler for everybody.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Btw, somebody should really check my http-push conversion.

It actually used to set up the whole "name" thing, and it still has the 
code for it, but there really is no point to it, and as far as I can tell, 
it never _used_ it. It just had it because the code was copied from 
git-rev-list, I suspect.

So there's room for further simplification there, but I wanted to leave 
that part as a minimal patch, just because I don't use it, and while I'm 
pretty damn sure that the "name" part was never actually used (the fact 
that it compiles fine without any "name" in the object list at all is a 
big hint ;), it should get somebody else looking over my diff. And 
simplifying the code later.

 builtin-diff-files.c |    2 +-
 builtin-diff-index.c |    2 +-
 builtin-diff-tree.c  |   42 +++++++++------------------------
 builtin-diff.c       |   26 +++++++++++---------
 builtin-grep.c       |   16 +++++--------
 builtin-log.c        |    4 ++-
 builtin-rev-list.c   |   64 ++++++++++++++++++++++++++------------------------
 diff-lib.c           |    4 ++-
 http-push.c          |   28 +++++++++++++++-------
 name-rev.c           |   17 +++++++------
 object.c             |   17 +++++++++++++
 object.h             |   13 +++++++++-
 revision.c           |   33 ++++++++++++--------------
 revision.h           |   12 +++++----
 14 files changed, 150 insertions(+), 130 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index cebda82..5afc1d7 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -41,7 +41,7 @@ int cmd_diff_files(int argc, const char 
 	 * rev.max_count is reasonable (0 <= n <= 3),
 	 * there is no other revision filtering parameters.
 	 */
-	if (rev.pending_objects ||
+	if (rev.pending.nr ||
 	    rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_files_usage);
 	/*
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 1958580..c42ef9a 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -32,7 +32,7 @@ int cmd_diff_index(int argc, const char 
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
 	 */
-	if (!rev.pending_objects || rev.pending_objects->next ||
+	if (rev.pending.nr != 1 ||
 	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_cache_usage);
 	return run_diff_index(&rev, cached);
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 58cf658..3409a39 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -65,7 +65,6 @@ int cmd_diff_tree(int argc, const char *
 	char line[1000];
 	struct object *tree1, *tree2;
 	static struct rev_info *opt = &log_tree_opt;
-	struct object_list *list;
 	int read_stdin = 0;
 
 	git_config(git_diff_config);
@@ -86,45 +85,28 @@ int cmd_diff_tree(int argc, const char *
 	}
 
 	/*
-	 * NOTE! "setup_revisions()" will have inserted the revisions
-	 * it parsed in reverse order. So if you do
-	 *
-	 *	git-diff-tree a b
-	 *
-	 * the commit list will be "b" -> "a" -> NULL, so we reverse
-	 * the order of the objects if the first one is not marked
-	 * UNINTERESTING.
+	 * NOTE! We expect "a ^b" to be equal to "a..b", so we
+	 * reverse the order of the objects if the second one
+	 * is marked UNINTERESTING.
 	 */
-	nr_sha1 = 0;
-	list = opt->pending_objects;
-	if (list) {
-		nr_sha1++;
-		tree1 = list->item;
-		list = list->next;
-		if (list) {
-			nr_sha1++;
-			tree2 = tree1;
-			tree1 = list->item;
-			if (list->next)
-				usage(diff_tree_usage);
-			/* Switch them around if the second one was uninteresting.. */
-			if (tree2->flags & UNINTERESTING) {
-				struct object *tmp = tree2;
-				tree2 = tree1;
-				tree1 = tmp;
-			}
-		}
-	}
-
+	nr_sha1 = opt->pending.nr;
 	switch (nr_sha1) {
 	case 0:
 		if (!read_stdin)
 			usage(diff_tree_usage);
 		break;
 	case 1:
+		tree1 = opt->pending.objects[0].item;
 		diff_tree_commit_sha1(tree1->sha1);
 		break;
 	case 2:
+		tree1 = opt->pending.objects[0].item;
+		tree2 = opt->pending.objects[1].item;
+		if (tree2->flags & UNINTERESTING) {
+			struct object *tmp = tree2;
+			tree2 = tree1;
+			tree1 = tmp;
+		}
 		diff_tree_sha1(tree1->sha1,
 			       tree2->sha1,
 			       "", &opt->diffopt);
diff --git a/builtin-diff.c b/builtin-diff.c
index 6ac3d4b..99a2f76 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -50,7 +50,7 @@ static int builtin_diff_files(struct rev
 	 * specified rev.max_count is reasonable (0 <= n <= 3), and
 	 * there is no other revision filtering parameter.
 	 */
-	if (revs->pending_objects ||
+	if (revs->pending.nr ||
 	    revs->min_age != -1 ||
 	    revs->max_age != -1 ||
 	    3 < revs->max_count)
@@ -172,7 +172,7 @@ static int builtin_diff_index(struct rev
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
 	 */
-	if (!revs->pending_objects || revs->pending_objects->next ||
+	if (revs->pending.nr != 1 ||
 	    revs->max_count != -1 || revs->min_age != -1 ||
 	    revs->max_age != -1)
 		usage(builtin_diff_usage);
@@ -181,10 +181,10 @@ static int builtin_diff_index(struct rev
 
 static int builtin_diff_tree(struct rev_info *revs,
 			     int argc, const char **argv,
-			     struct object_list *ent)
+			     struct object_array_entry *ent)
 {
 	const unsigned char *(sha1[2]);
-	int swap = 1;
+	int swap = 0;
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--raw"))
@@ -195,10 +195,10 @@ static int builtin_diff_tree(struct rev_
 	}
 
 	/* We saw two trees, ent[0] and ent[1].
-	 * unless ent[0] is unintesting, they are swapped
+	 * if ent[1] is unintesting, they are swapped
 	 */
-	if (ent[0].item->flags & UNINTERESTING)
-		swap = 0;
+	if (ent[1].item->flags & UNINTERESTING)
+		swap = 1;
 	sha1[swap] = ent[0].item->sha1;
 	sha1[1-swap] = ent[1].item->sha1;
 	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
@@ -208,7 +208,7 @@ static int builtin_diff_tree(struct rev_
 
 static int builtin_diff_combined(struct rev_info *revs,
 				 int argc, const char **argv,
-				 struct object_list *ent,
+				 struct object_array_entry *ent,
 				 int ents)
 {
 	const unsigned char (*parent)[20];
@@ -242,13 +242,14 @@ void add_head(struct rev_info *revs)
 	obj = parse_object(sha1);
 	if (!obj)
 		return;
-	add_object(obj, &revs->pending_objects, NULL, "HEAD");
+	add_pending_object(revs, obj, "HEAD");
 }
 
 int cmd_diff(int argc, const char **argv, char **envp)
 {
+	int i;
 	struct rev_info rev;
-	struct object_list *list, ent[100];
+	struct object_array_entry ent[100];
 	int ents = 0, blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
@@ -281,7 +282,7 @@ int cmd_diff(int argc, const char **argv
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
-	if (!rev.pending_objects) {
+	if (!rev.pending.nr) {
 		int i;
 		for (i = 1; i < argc; i++) {
 			const char *arg = argv[i];
@@ -294,7 +295,8 @@ int cmd_diff(int argc, const char **argv
 		}
 	}
 
-	for (list = rev.pending_objects; list; list = list->next) {
+	for (i = 0; i < rev.pending.nr; i++) {
+		struct object_array_entry *list = rev.pending.objects+i;
 		struct object *obj = list->item;
 		const char *name = list->name;
 		int flags = (obj->flags & UNINTERESTING);
diff --git a/builtin-grep.c b/builtin-grep.c
index 9806499..6a240fb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -657,7 +657,7 @@ int cmd_grep(int argc, const char **argv
 	int cached = 0;
 	int seen_dashdash = 0;
 	struct grep_opt opt;
-	struct object_list *list, **tail, *object_list = NULL;
+	struct object_array list = { 0, 0, NULL };
 	const char *prefix = setup_git_directory();
 	const char **paths = NULL;
 	int i;
@@ -677,7 +677,6 @@ int cmd_grep(int argc, const char **argv
 	 * that continues up to the -- (if exists), and then paths.
 	 */
 
-	tail = &object_list;
 	while (1 < argc) {
 		const char *arg = argv[1];
 		argc--; argv++;
@@ -851,12 +850,9 @@ int cmd_grep(int argc, const char **argv
 		/* Is it a rev? */
 		if (!get_sha1(arg, sha1)) {
 			struct object *object = parse_object(sha1);
-			struct object_list *elem;
 			if (!object)
 				die("bad object %s", arg);
-			elem = object_list_insert(object, tail);
-			elem->name = arg;
-			tail = &elem->next;
+			add_object_array(object, arg, &list);
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
@@ -881,16 +877,16 @@ int cmd_grep(int argc, const char **argv
 		paths[1] = NULL;
 	}
 
-	if (!object_list)
+	if (!list.nr)
 		return !grep_cache(&opt, paths, cached);
 
 	if (cached)
 		die("both --cached and trees are given.");
 
-	for (list = object_list; list; list = list->next) {
+	for (i = 0; i < list.nr; i++) {
 		struct object *real_obj;
-		real_obj = deref_tag(list->item, NULL, 0);
-		if (grep_object(&opt, paths, real_obj, list->name))
+		real_obj = deref_tag(list.objects[i].item, NULL, 0);
+		if (grep_object(&opt, paths, real_obj, list.objects[i].name))
 			hit = 1;
 	}
 	return !hit;
diff --git a/builtin-log.c b/builtin-log.c
index 9187fd3..5a8a50b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -257,8 +257,8 @@ int cmd_format_patch(int argc, const cha
 			    output_directory);
 	}
 
-	if (rev.pending_objects && rev.pending_objects->next == NULL) {
-		rev.pending_objects->item->flags |= UNINTERESTING;
+	if (rev.pending.nr == 1) {
+		rev.pending.objects[0].item->flags |= UNINTERESTING;
 		add_head(&rev);
 	}
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 71353eb..63bad0e 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -99,26 +99,26 @@ static void show_commit(struct commit *c
 	}
 }
 
-static struct object_list **process_blob(struct blob *blob,
-					 struct object_list **p,
-					 struct name_path *path,
-					 const char *name)
+static void process_blob(struct blob *blob,
+			 struct object_array *p,
+			 struct name_path *path,
+			 const char *name)
 {
 	struct object *obj = &blob->object;
 
 	if (!revs.blob_objects)
-		return p;
+		return;
 	if (obj->flags & (UNINTERESTING | SEEN))
-		return p;
+		return;
 	obj->flags |= SEEN;
 	name = strdup(name);
-	return add_object(obj, p, path, name);
+	add_object(obj, p, path, name);
 }
 
-static struct object_list **process_tree(struct tree *tree,
-					 struct object_list **p,
-					 struct name_path *path,
-					 const char *name)
+static void process_tree(struct tree *tree,
+			 struct object_array *p,
+			 struct name_path *path,
+			 const char *name)
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
@@ -126,14 +126,14 @@ static struct object_list **process_tree
 	struct name_path me;
 
 	if (!revs.tree_objects)
-		return p;
+		return;
 	if (obj->flags & (UNINTERESTING | SEEN))
-		return p;
+		return;
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
 	name = strdup(name);
-	p = add_object(obj, p, path, name);
+	add_object(obj, p, path, name);
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
@@ -143,57 +143,59 @@ static struct object_list **process_tree
 
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
-			p = process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
+			process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
 		else
-			p = process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
+			process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
-	return p;
 }
 
 static void show_commit_list(struct rev_info *revs)
 {
+	int i;
 	struct commit *commit;
-	struct object_list *objects = NULL, **p = &objects, *pending;
+	struct object_array objects = { 0, 0, NULL };
 
 	while ((commit = get_revision(revs)) != NULL) {
-		p = process_tree(commit->tree, p, NULL, "");
+		process_tree(commit->tree, &objects, NULL, "");
 		show_commit(commit);
 	}
-	for (pending = revs->pending_objects; pending; pending = pending->next) {
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == TYPE_TAG) {
 			obj->flags |= SEEN;
-			p = add_object(obj, p, NULL, name);
+			add_object_array(obj, name, &objects);
 			continue;
 		}
 		if (obj->type == TYPE_TREE) {
-			p = process_tree((struct tree *)obj, p, NULL, name);
+			process_tree((struct tree *)obj, &objects, NULL, name);
 			continue;
 		}
 		if (obj->type == TYPE_BLOB) {
-			p = process_blob((struct blob *)obj, p, NULL, name);
+			process_blob((struct blob *)obj, &objects, NULL, name);
 			continue;
 		}
 		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
 	}
-	while (objects) {
+	for (i = 0; i < objects.nr; i++) {
+		struct object_array_entry *p = objects.objects + i;
+
 		/* An object with name "foo\n0000000..." can be used to
 		 * confuse downstream git-pack-objects very badly.
 		 */
-		const char *ep = strchr(objects->name, '\n');
+		const char *ep = strchr(p->name, '\n');
 		if (ep) {
-			printf("%s %.*s\n", sha1_to_hex(objects->item->sha1),
-			       (int) (ep - objects->name),
-			       objects->name);
+			printf("%s %.*s\n", sha1_to_hex(p->item->sha1),
+			       (int) (ep - p->name),
+			       p->name);
 		}
 		else
-			printf("%s %s\n", sha1_to_hex(objects->item->sha1), objects->name);
-		objects = objects->next;
+			printf("%s %s\n", sha1_to_hex(p->item->sha1), p->name);
 	}
 }
 
@@ -348,7 +350,7 @@ int cmd_rev_list(int argc, const char **
 
 	if ((!list &&
 	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
-	      !revs.pending_objects)) ||
+	      !revs.pending.nr)) ||
 	    revs.diff)
 		usage(rev_list_usage);
 
diff --git a/diff-lib.c b/diff-lib.c
index 2183b41..d93cd55 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -329,8 +329,8 @@ int run_diff_index(struct rev_info *revs
 	}
 	mark_merge_entries();
 
-	ent = revs->pending_objects->item;
-	tree_name = revs->pending_objects->name;
+	ent = revs->pending.objects[0].item;
+	tree_name = revs->pending.objects[0].name;
 	tree = parse_tree_indirect(ent->sha1);
 	if (!tree)
 		return error("bad tree object %s", tree_name);
diff --git a/http-push.c b/http-push.c
index ba64f8f..0f02a55 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1171,7 +1171,7 @@ static void one_remote_object(const char
 
 	obj->flags |= REMOTE;
 	if (!object_list_contains(objects, obj))
-		add_object(obj, &objects, NULL, "");
+		object_list_insert(obj, &objects);
 }
 
 static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
@@ -1699,6 +1699,15 @@ static int locking_available(void)
 	return lock_flags;
 }
 
+struct object_list **add_one_object(struct object *obj, struct object_list **p)
+{
+	struct object_list *entry = xmalloc(sizeof(struct object_list));
+	entry->item = obj;
+	entry->next = *p;
+	*p = entry;
+	return &entry->next;
+}
+
 static struct object_list **process_blob(struct blob *blob,
 					 struct object_list **p,
 					 struct name_path *path,
@@ -1712,8 +1721,7 @@ static struct object_list **process_blob
 		return p;
 
 	obj->flags |= SEEN;
-	name = strdup(name);
-	return add_object(obj, p, path, name);
+	return add_one_object(obj, p);
 }
 
 static struct object_list **process_tree(struct tree *tree,
@@ -1735,7 +1743,7 @@ static struct object_list **process_tree
 
 	obj->flags |= SEEN;
 	name = strdup(name);
-	p = add_object(obj, p, NULL, name);
+	p = add_one_object(obj, p);
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
@@ -1756,8 +1764,9 @@ static struct object_list **process_tree
 
 static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 {
+	int i;
 	struct commit *commit;
-	struct object_list **p = &objects, *pending;
+	struct object_list **p = &objects;
 	int count = 0;
 
 	while ((commit = get_revision(revs)) != NULL) {
@@ -1767,15 +1776,16 @@ static int get_delta(struct rev_info *re
 			count += add_send_request(&commit->object, lock);
 	}
 
-	for (pending = revs->pending_objects; pending; pending = pending->next) {
-		struct object *obj = pending->item;
-		const char *name = pending->name;
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object_array_entry *entry = revs->pending.objects + i;
+		struct object *obj = entry->item;
+		const char *name = entry->name;
 
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == TYPE_TAG) {
 			obj->flags |= SEEN;
-			p = add_object(obj, p, NULL, name);
+			p = add_one_object(obj, p);
 			continue;
 		}
 		if (obj->type == TYPE_TREE) {
diff --git a/name-rev.c b/name-rev.c
index c29b93e..586d842 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -128,8 +128,7 @@ static const char* get_rev_name(struct o
 	
 int main(int argc, char **argv)
 {
-	struct object_list *revs = NULL;
-	struct object_list **walker = &revs;
+	struct object_array revs = { 0, 0, NULL };
 	int as_is = 0, all = 0, transform_stdin = 0;
 
 	setup_git_directory();
@@ -184,9 +183,7 @@ int main(int argc, char **argv)
 		if (cutoff > commit->date)
 			cutoff = commit->date;
 
-		object_list_append((struct object *)commit, walker);
-		(*walker)->name = *argv;
-		walker = &((*walker)->next);
+		add_object_array((struct object *)commit, *argv, &revs);
 	}
 
 	for_each_ref(name_ref);
@@ -243,9 +240,13 @@ #define ishex(x) (isdigit((x)) || ((x) >
 			if (objs[i])
 				printf("%s %s\n", sha1_to_hex(objs[i]->sha1),
 						get_rev_name(objs[i]));
-	} else
-		for ( ; revs; revs = revs->next)
-			printf("%s %s\n", revs->name, get_rev_name(revs->item));
+	} else {
+		int i;
+		for (i = 0; i < revs.nr; i++)
+			printf("%s %s\n",
+				revs.objects[i].name,
+				get_rev_name(revs.objects[i].item));
+	}
 
 	return 0;
 }
diff --git a/object.c b/object.c
index e26e319..37784ce 100644
--- a/object.c
+++ b/object.c
@@ -200,3 +200,20 @@ int object_list_contains(struct object_l
 	}
 	return 0;
 }
+
+void add_object_array(struct object *obj, const char *name, struct object_array *array)
+{
+	unsigned nr = array->nr;
+	unsigned alloc = array->alloc;
+	struct object_array_entry *objects = array->objects;
+
+	if (nr >= alloc) {
+		alloc = (alloc + 32) * 2;
+		objects = xrealloc(objects, alloc * sizeof(*objects));
+		array->alloc = alloc;
+		array->objects = objects;
+	}
+	objects[nr].item = obj;
+	objects[nr].name = name;
+	array->nr = ++nr;
+}
diff --git a/object.h b/object.h
index c537b4b..6f23a9a 100644
--- a/object.h
+++ b/object.h
@@ -4,7 +4,6 @@ #define OBJECT_H
 struct object_list {
 	struct object *item;
 	struct object_list *next;
-	const char *name;
 };
 
 struct object_refs {
@@ -13,6 +12,15 @@ struct object_refs {
 	struct object *ref[FLEX_ARRAY]; /* more */
 };
 
+struct object_array {
+	unsigned int nr;
+	unsigned int alloc;
+	struct object_array_entry {
+		struct object *item;
+		const char *name;
+	} *objects;
+};
+
 #define TYPE_BITS   3
 #define FLAG_BITS  27
 
@@ -72,4 +80,7 @@ unsigned object_list_length(struct objec
 
 int object_list_contains(struct object_list *list, struct object *obj);
 
+/* Object array handling .. */
+void add_object_array(struct object *obj, const char *name, struct object_array *array);
+
 #endif /* OBJECT_H */
diff --git a/revision.c b/revision.c
index 7bff2a1..b963f2a 100644
--- a/revision.c
+++ b/revision.c
@@ -31,17 +31,12 @@ static char *path_name(struct name_path 
 	return n;
 }
 
-struct object_list **add_object(struct object *obj,
-				       struct object_list **p,
-				       struct name_path *path,
-				       const char *name)
+void add_object(struct object *obj,
+		struct object_array *p,
+		struct name_path *path,
+		const char *name)
 {
-	struct object_list *entry = xmalloc(sizeof(*entry));
-	entry->item = obj;
-	entry->next = *p;
-	entry->name = path_name(path, name);
-	*p = entry;
-	return &entry->next;
+	add_object_array(obj, path_name(path, name), p);
 }
 
 static void mark_blob_uninteresting(struct blob *blob)
@@ -117,9 +112,9 @@ void mark_parents_uninteresting(struct c
 	}
 }
 
-static void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
+void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
 {
-	add_object(obj, &revs->pending_objects, NULL, name);
+	add_object_array(obj, name, &revs->pending);
 }
 
 static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
@@ -836,7 +831,7 @@ int setup_revisions(int argc, const char
 		object = get_reference(revs, arg, sha1, flags ^ local_flags);
 		add_pending_object(revs, object, arg);
 	}
-	if (def && !revs->pending_objects) {
+	if (def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
 		if (get_sha1(def, sha1))
@@ -868,11 +863,13 @@ int setup_revisions(int argc, const char
 
 void prepare_revision_walk(struct rev_info *revs)
 {
-	struct object_list *list;
+	int nr = revs->pending.nr;
+	struct object_array_entry *list = revs->pending.objects;
 
-	list = revs->pending_objects;
-	revs->pending_objects = NULL;
-	while (list) {
+	revs->pending.nr = 0;
+	revs->pending.alloc = 0;
+	revs->pending.objects = NULL;
+	while (--nr >= 0) {
 		struct commit *commit = handle_commit(revs, list->item, list->name);
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
@@ -880,7 +877,7 @@ void prepare_revision_walk(struct rev_in
 				insert_by_date(commit, &revs->commits);
 			}
 		}
-		list = list->next;
+		list++;
 	}
 
 	if (revs->no_walk)
diff --git a/revision.h b/revision.h
index 4020e25..c010a08 100644
--- a/revision.h
+++ b/revision.h
@@ -18,7 +18,7 @@ typedef void (prune_fn_t)(struct rev_inf
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
-	struct object_list *pending_objects;
+	struct object_array pending;
 
 	/* Basic information */
 	const char *prefix;
@@ -99,9 +99,11 @@ struct name_path {
 	const char *elem;
 };
 
-extern struct object_list **add_object(struct object *obj,
-				       struct object_list **p,
-				       struct name_path *path,
-				       const char *name);
+extern void add_object(struct object *obj,
+		       struct object_array *p,
+		       struct name_path *path,
+		       const char *name);
+
+extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 
 #endif
