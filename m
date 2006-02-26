From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] First cut at libifying revlist generation
Date: Sat, 25 Feb 2006 16:19:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Feb 26 01:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FD9eC-0000Gx-KI
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 01:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWBZAUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 19:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWBZAUG
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 19:20:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750880AbWBZAUE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Feb 2006 19:20:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1Q0JtDZ015671
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Feb 2006 16:19:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1Q0Jlpf023436;
	Sat, 25 Feb 2006 16:19:49 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-8.776 required=5 tests=PATCH_SUBJECT_OSDL,PATCH_UNIFIED_DIFF_OSDL,REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16764>


This really just splits things up partially, and creates the
interface to set things up by parsign the command line.

No real code changes so far, although the parsing of filenames is a bit 
stricter. In particular, if there is a "--", then we do not accept any 
filenames before it, and if there isn't any "--", then we check that _all_ 
paths listed are valid, not just the first one.

The new argument parsing automatically also gives us "--default" and 
"--not" handling as in git-rev-parse.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

The path checking just makes sense. 

This also makes git-rev-list handle "--all" and "--not" correctly (before, 
it wouldn't handle "--not"), and teaches it to handle "--default". I 
didn't do "--since" and "--before", but I will eventually. The final end 
result is that we won't need git-rev-parse for most things.

But basically there should be no code changes, and this is just a mid-way 
point where a _partial_ set of routines from "git-rev-list" has been moved 
into a library files - revision.c. The half-way point has some ugly 
interfaces, but I don't want to do it all in one go.

The _plan_ is to:

 - move the actual history traversal into revision.c too

 - leave all the git-rev-list -specific stuff (the "--bisect" logic, 
   the print-out logic etc) in rev-list.c

 - make it trivial to make a small C version of "git diff" that just uses 
   the same "setup_revisions()" interface and then looks at 
   "revs->commits" to see what revisions were passed in (the library 
   interface is already at the point where that should work)

 - when the actual history _traversal_ is moved into "revision.c" too, it 
   should then be possible to make an equally small "git log" and friends 
   (whatchanged etc) into C using the revision.c code.

Comments? I think this is safe to apply, because I've done a diff of the 
old non-split rev-list.c against both the new rev-list.c and revision.c, 
and all the changes _look_ like just moving things around and taking the 
new "struct rev_info" into account.

It also passes all the tests, and in general seems straightforward enough. 
HOEVER, I'd still like to point out that I could have screwed something 
up, and this is just about the most core program in all of git, so it 
would make a lot of sense if more people double-checked my "trivial" 
split-up.

		Linus


diff --git a/Makefile b/Makefile
index 6c59cee..3575489 100644
--- a/Makefile
+++ b/Makefile
@@ -192,7 +192,7 @@ LIB_FILE=libgit.a
 LIB_H = \
 	blob.h cache.h commit.h count-delta.h csum-file.h delta.h \
 	diff.h epoch.h object.h pack.h pkt-line.h quote.h refs.h \
-	run-command.h strbuf.h tag.h tree.h git-compat-util.h
+	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h
 
 DIFF_OBJS = \
 	diff.o diffcore-break.o diffcore-order.o diffcore-pathspec.o \
@@ -205,7 +205,7 @@ LIB_OBJS = \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
-	fetch-clone.o \
+	fetch-clone.o revision.o \
 	$(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
diff --git a/epoch.c b/epoch.c
index 3a76748..0f37492 100644
--- a/epoch.c
+++ b/epoch.c
@@ -15,6 +15,7 @@
 
 #include "cache.h"
 #include "commit.h"
+#include "revision.h"
 #include "epoch.h"
 
 struct fraction {
diff --git a/epoch.h b/epoch.h
index 7493d5a..3756009 100644
--- a/epoch.h
+++ b/epoch.h
@@ -11,7 +11,6 @@ typedef int (*emitter_func) (struct comm
 int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
 
 /* Low bits are used by rev-list */
-#define UNINTERESTING   (1u<<10)
 #define BOUNDARY        (1u<<11)
 #define VISITED         (1u<<12)
 #define DISCONTINUITY   (1u<<13)
diff --git a/rev-list.c b/rev-list.c
index 67d2a48..d1c52a6 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -6,9 +6,10 @@
 #include "blob.h"
 #include "epoch.h"
 #include "diff.h"
+#include "revision.h"
+
+/* bits #0 and #1 in revision.h */
 
-#define SEEN		(1u << 0)
-#define INTERESTING	(1u << 1)
 #define COUNTED		(1u << 2)
 #define SHOWN		(1u << 3)
 #define TREECHANGE	(1u << 4)
@@ -38,60 +39,20 @@ static const char rev_list_usage[] =
 "    --bisect"
 ;
 
-static int dense = 1;
+struct rev_info revs;
+
 static int unpacked = 0;
 static int bisect_list = 0;
-static int tag_objects = 0;
-static int tree_objects = 0;
-static int blob_objects = 0;
-static int edge_hint = 0;
 static int verbose_header = 0;
 static int abbrev = DEFAULT_ABBREV;
 static int show_parents = 0;
 static int hdr_termination = 0;
 static const char *commit_prefix = "";
-static unsigned long max_age = -1;
-static unsigned long min_age = -1;
-static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
 static int stop_traversal = 0;
-static int topo_order = 0;
-static int lifo = 1;
 static int no_merges = 0;
-static const char **paths = NULL;
-static int remove_empty_trees = 0;
-
-struct name_path {
-	struct name_path *up;
-	int elem_len;
-	const char *elem;
-};
-
-static char *path_name(struct name_path *path, const char *name)
-{
-	struct name_path *p;
-	char *n, *m;
-	int nlen = strlen(name);
-	int len = nlen + 1;
-
-	for (p = path; p; p = p->up) {
-		if (p->elem_len)
-			len += p->elem_len + 1;
-	}
-	n = xmalloc(len);
-	m = n + len - (nlen + 1);
-	strcpy(m, name);
-	for (p = path; p; p = p->up) {
-		if (p->elem_len) {
-			m -= p->elem_len + 1;
-			memcpy(m, p->elem, p->elem_len);
-			m[p->elem_len] = '/';
-		}
-	}
-	return n;
-}
 
 static void show_commit(struct commit *commit)
 {
@@ -168,15 +129,15 @@ static int filter_commit(struct commit *
 		return STOP;
 	if (commit->object.flags & (UNINTERESTING|SHOWN))
 		return CONTINUE;
-	if (min_age != -1 && (commit->date > min_age))
+	if (revs.min_age != -1 && (commit->date > revs.min_age))
 		return CONTINUE;
-	if (max_age != -1 && (commit->date < max_age)) {
+	if (revs.max_age != -1 && (commit->date < revs.max_age)) {
 		stop_traversal=1;
 		return CONTINUE;
 	}
 	if (no_merges && (commit->parents && commit->parents->next))
 		return CONTINUE;
-	if (paths && dense) {
+	if (revs.paths && revs.dense) {
 		if (!(commit->object.flags & TREECHANGE))
 			return CONTINUE;
 		rewrite_parents(commit);
@@ -196,7 +157,7 @@ static int process_commit(struct commit 
 		return CONTINUE;
 	}
 
-	if (max_count != -1 && !max_count--)
+	if (revs.max_count != -1 && !revs.max_count--)
 		return STOP;
 
 	show_commit(commit);
@@ -204,19 +165,6 @@ static int process_commit(struct commit 
 	return CONTINUE;
 }
 
-static struct object_list **add_object(struct object *obj,
-				       struct object_list **p,
-				       struct name_path *path,
-				       const char *name)
-{
-	struct object_list *entry = xmalloc(sizeof(*entry));
-	entry->item = obj;
-	entry->next = *p;
-	entry->name = path_name(path, name);
-	*p = entry;
-	return &entry->next;
-}
-
 static struct object_list **process_blob(struct blob *blob,
 					 struct object_list **p,
 					 struct name_path *path,
@@ -224,7 +172,7 @@ static struct object_list **process_blob
 {
 	struct object *obj = &blob->object;
 
-	if (!blob_objects)
+	if (!revs.blob_objects)
 		return p;
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return p;
@@ -241,7 +189,7 @@ static struct object_list **process_tree
 	struct tree_entry_list *entry;
 	struct name_path me;
 
-	if (!tree_objects)
+	if (!revs.tree_objects)
 		return p;
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return p;
@@ -314,75 +262,6 @@ static void show_commit_list(struct comm
 	}
 }
 
-static void mark_blob_uninteresting(struct blob *blob)
-{
-	if (!blob_objects)
-		return;
-	if (blob->object.flags & UNINTERESTING)
-		return;
-	blob->object.flags |= UNINTERESTING;
-}
-
-static void mark_tree_uninteresting(struct tree *tree)
-{
-	struct object *obj = &tree->object;
-	struct tree_entry_list *entry;
-
-	if (!tree_objects)
-		return;
-	if (obj->flags & UNINTERESTING)
-		return;
-	obj->flags |= UNINTERESTING;
-	if (!has_sha1_file(obj->sha1))
-		return;
-	if (parse_tree(tree) < 0)
-		die("bad tree %s", sha1_to_hex(obj->sha1));
-	entry = tree->entries;
-	tree->entries = NULL;
-	while (entry) {
-		struct tree_entry_list *next = entry->next;
-		if (entry->directory)
-			mark_tree_uninteresting(entry->item.tree);
-		else
-			mark_blob_uninteresting(entry->item.blob);
-		free(entry);
-		entry = next;
-	}
-}
-
-static void mark_parents_uninteresting(struct commit *commit)
-{
-	struct commit_list *parents = commit->parents;
-
-	while (parents) {
-		struct commit *commit = parents->item;
-		commit->object.flags |= UNINTERESTING;
-
-		/*
-		 * Normally we haven't parsed the parent
-		 * yet, so we won't have a parent of a parent
-		 * here. However, it may turn out that we've
-		 * reached this commit some other way (where it
-		 * wasn't uninteresting), in which case we need
-		 * to mark its parents recursively too..
-		 */
-		if (commit->parents)
-			mark_parents_uninteresting(commit);
-
-		/*
-		 * A missing commit is ok iff its parent is marked 
-		 * uninteresting.
-		 *
-		 * We just mark such a thing parsed, so that when
-		 * it is popped next time around, we won't be trying
-		 * to parse it and get an error.
-		 */
-		if (!has_sha1_file(commit->object.sha1))
-			commit->object.parsed = 1;
-		parents = parents->next;
-	}
-}
-
 static int everybody_uninteresting(struct commit_list *orig)
 {
 	struct commit_list *list = orig;
@@ -413,7 +292,7 @@ static int count_distance(struct commit_
 
 		if (commit->object.flags & (UNINTERESTING | COUNTED))
 			break;
-		if (!paths || (commit->object.flags & TREECHANGE))
+		if (!revs.paths || (commit->object.flags & TREECHANGE))
 			nr++;
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
@@ -447,7 +326,7 @@ static struct commit_list *find_bisectio
 	nr = 0;
 	p = list;
 	while (p) {
-		if (!paths || (p->item->object.flags & TREECHANGE))
+		if (!revs.paths || (p->item->object.flags & TREECHANGE))
 			nr++;
 		p = p->next;
 	}
@@ -457,7 +336,7 @@ static struct commit_list *find_bisectio
 	for (p = list; p; p = p->next) {
 		int distance;
 
-		if (paths && !(p->item->object.flags & TREECHANGE))
+		if (revs.paths && !(p->item->object.flags & TREECHANGE))
 			continue;
 
 		distance = count_distance(p);
@@ -483,7 +362,7 @@ static void mark_edge_parents_uninterest
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
 		mark_tree_uninteresting(parent->tree);
-		if (edge_hint && !(parent->object.flags & SHOWN)) {
+		if (revs.edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |= SHOWN;
 			printf("-%s\n", sha1_to_hex(parent->object.sha1));
 		}
@@ -613,7 +492,7 @@ static void try_to_simplify_commit(struc
 			return;
 
 		case TREE_NEW:
-			if (remove_empty_trees && same_tree_as_empty(p->tree)) {
+			if (revs.remove_empty_trees && same_tree_as_empty(p->tree)) {
 				*pp = parent->next;
 				continue;
 			}
@@ -664,7 +543,7 @@ static void add_parents_to_list(struct c
 	 * simplify the commit history and find the parent
 	 * that has no differences in the path set if one exists.
 	 */
-	if (paths)
+	if (revs.paths)
 		try_to_simplify_commit(commit);
 
 	parent = commit->parents;
@@ -693,7 +572,7 @@ static struct commit_list *limit_list(st
 		list = list->next;
 		free(entry);
 
-		if (max_age != -1 && (commit->date < max_age))
+		if (revs.max_age != -1 && (commit->date < revs.max_age))
 			obj->flags |= UNINTERESTING;
 		if (unpacked && has_sha1_pack(obj->sha1))
 			obj->flags |= UNINTERESTING;
@@ -704,155 +583,40 @@ static struct commit_list *limit_list(st
 				break;
 			continue;
 		}
-		if (min_age != -1 && (commit->date > min_age))
+		if (revs.min_age != -1 && (commit->date > revs.min_age))
 			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
-	if (tree_objects)
+	if (revs.tree_objects)
 		mark_edges_uninteresting(newlist);
 	if (bisect_list)
 		newlist = find_bisection(newlist);
 	return newlist;
 }
 
-static void add_pending_object(struct object *obj, const char *name)
-{
-	add_object(obj, &pending_objects, NULL, name);
-}
-
-static struct commit *get_commit_reference(const char *name, const unsigned char *sha1, unsigned int flags)
-{
-	struct object *object;
-
-	object = parse_object(sha1);
-	if (!object)
-		die("bad object %s", name);
-
-	/*
-	 * Tag object? Look what it points to..
-	 */
-	while (object->type == tag_type) {
-		struct tag *tag = (struct tag *) object;
-		object->flags |= flags;
-		if (tag_objects && !(object->flags & UNINTERESTING))
-			add_pending_object(object, tag->tag);
-		object = parse_object(tag->tagged->sha1);
-		if (!object)
-			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
-	}
-
-	/*
-	 * Commit object? Just return it, we'll do all the complex
-	 * reachability crud.
-	 */
-	if (object->type == commit_type) {
-		struct commit *commit = (struct commit *)object;
-		object->flags |= flags;
-		if (parse_commit(commit) < 0)
-			die("unable to parse commit %s", name);
-		if (flags & UNINTERESTING)
-			mark_parents_uninteresting(commit);
-		return commit;
-	}
-
-	/*
-	 * Tree object? Either mark it uniniteresting, or add it
-	 * to the list of objects to look at later..
-	 */
-	if (object->type == tree_type) {
-		struct tree *tree = (struct tree *)object;
-		if (!tree_objects)
-			return NULL;
-		if (flags & UNINTERESTING) {
-			mark_tree_uninteresting(tree);
-			return NULL;
-		}
-		add_pending_object(object, "");
-		return NULL;
-	}
-
-	/*
-	 * Blob object? You know the drill by now..
-	 */
-	if (object->type == blob_type) {
-		struct blob *blob = (struct blob *)object;
-		if (!blob_objects)
-			return NULL;
-		if (flags & UNINTERESTING) {
-			mark_blob_uninteresting(blob);
-			return NULL;
-		}
-		add_pending_object(object, "");
-		return NULL;
-	}
-	die("%s is unknown object", name);
-}
-
-static void handle_one_commit(struct commit *com, struct commit_list **lst)
-{
-	if (!com || com->object.flags & SEEN)
-		return;
-	com->object.flags |= SEEN;
-	commit_list_insert(com, lst);
-}
-
-/* for_each_ref() callback does not allow user data -- Yuck. */
-static struct commit_list **global_lst;
-
-static int include_one_commit(const char *path, const unsigned char *sha1)
-{
-	struct commit *com = get_commit_reference(path, sha1, 0);
-	handle_one_commit(com, global_lst);
-	return 0;
-}
-
-static void handle_all(struct commit_list **lst)
-{
-	global_lst = lst;
-	for_each_ref(include_one_commit);
-	global_lst = NULL;
-}
-
 int main(int argc, const char **argv)
 {
-	const char *prefix = setup_git_directory();
-	struct commit_list *list = NULL;
+	struct commit_list *list;
 	int i, limited = 0;
 
+	argc = setup_revisions(argc, argv, &revs);
+
 	for (i = 1 ; i < argc; i++) {
-		int flags;
 		const char *arg = argv[i];
-		char *dotdot;
-		struct commit *commit;
-		unsigned char sha1[20];
 
 		/* accept -<digit>, like traditilnal "head" */
 		if ((*arg == '-') && isdigit(arg[1])) {
-			max_count = atoi(arg + 1);
+			revs.max_count = atoi(arg + 1);
 			continue;
 		}
 		if (!strcmp(arg, "-n")) {
 			if (++i >= argc)
 				die("-n requires an argument");
-			max_count = atoi(argv[i]);
+			revs.max_count = atoi(argv[i]);
 			continue;
 		}
 		if (!strncmp(arg,"-n",2)) {
-			max_count = atoi(arg + 2);
-			continue;
-		}
-		if (!strncmp(arg, "--max-count=", 12)) {
-			max_count = atoi(arg + 12);
-			continue;
-		}
-		if (!strncmp(arg, "--max-age=", 10)) {
-			max_age = atoi(arg + 10);
-			limited = 1;
-			continue;
-		}
-		if (!strncmp(arg, "--min-age=", 10)) {
-			min_age = atoi(arg + 10);
-			limited = 1;
+			revs.max_count = atoi(arg + 2);
 			continue;
 		}
 		if (!strcmp(arg, "--header")) {
@@ -893,23 +657,6 @@ int main(int argc, const char **argv)
 			bisect_list = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--all")) {
-			handle_all(&list);
-			continue;
-		}
-		if (!strcmp(arg, "--objects")) {
-			tag_objects = 1;
-			tree_objects = 1;
-			blob_objects = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--objects-edge")) {
-			tag_objects = 1;
-			tree_objects = 1;
-			blob_objects = 1;
-			edge_hint = 1;
-			continue;
-		}
 		if (!strcmp(arg, "--unpacked")) {
 			unpacked = 1;
 			limited = 1;
@@ -923,100 +670,42 @@ int main(int argc, const char **argv)
 			show_breaks = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--topo-order")) {
-		        topo_order = 1;
-			lifo = 1;
-		        limited = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--date-order")) {
-		        topo_order = 1;
-			lifo = 0;
-		        limited = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--dense")) {
-			dense = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--sparse")) {
-			dense = 0;
-			continue;
-		}
-		if (!strcmp(arg, "--remove-empty")) {
-			remove_empty_trees = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-
-		if (show_breaks && !merge_order)
-			usage(rev_list_usage);
+		usage(rev_list_usage);
 
-		flags = 0;
-		dotdot = strstr(arg, "..");
-		if (dotdot) {
-			unsigned char from_sha1[20];
-			char *next = dotdot + 2;
-			*dotdot = 0;
-			if (!*next)
-				next = "HEAD";
-			if (!get_sha1(arg, from_sha1) && !get_sha1(next, sha1)) {
-				struct commit *exclude;
-				struct commit *include;
-				
-				exclude = get_commit_reference(arg, from_sha1, UNINTERESTING);
-				include = get_commit_reference(next, sha1, 0);
-				if (!exclude || !include)
-					die("Invalid revision range %s..%s", arg, next);
-				limited = 1;
-				handle_one_commit(exclude, &list);
-				handle_one_commit(include, &list);
-				continue;
-			}
-			*dotdot = '.';
-		}
-		if (*arg == '^') {
-			flags = UNINTERESTING;
-			arg++;
-			limited = 1;
-		}
-		if (get_sha1(arg, sha1) < 0) {
-			struct stat st;
-			if (lstat(arg, &st) < 0)
-				die("'%s': %s", arg, strerror(errno));
-			break;
-		}
-		commit = get_commit_reference(arg, sha1, flags);
-		handle_one_commit(commit, &list);
 	}
 
+	list = revs.commits;
+	if (list && list->next)
+		limited = 1;
+
+	if (revs.topo_order)
+		limited = 1;
+
 	if (!list &&
-	    (!(tag_objects||tree_objects||blob_objects) && !pending_objects))
+	    (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) && !revs.pending_objects))
 		usage(rev_list_usage);
 
-	paths = get_pathspec(prefix, argv + i);
-	if (paths) {
+	if (revs.paths) {
 		limited = 1;
-		diff_tree_setup_paths(paths);
+		diff_tree_setup_paths(revs.paths);
 	}
+	if (revs.max_age || revs.min_age)
+		limited = 1;
 
 	save_commit_buffer = verbose_header;
 	track_object_refs = 0;
 
 	if (!merge_order) {		
 		sort_by_date(&list);
-		if (list && !limited && max_count == 1 &&
-		    !tag_objects && !tree_objects && !blob_objects) {
+		if (list && !limited && revs.max_count == 1 &&
+		    !revs.tag_objects && !revs.tree_objects && !revs.blob_objects) {
 			show_commit(list->item);
 			return 0;
 		}
 	        if (limited)
 			list = limit_list(list);
-		if (topo_order)
-			sort_in_topological_order(&list, lifo);
+		if (revs.topo_order)
+			sort_in_topological_order(&list, revs.lifo);
 		show_commit_list(list);
 	} else {
 #ifndef NO_OPENSSL
diff --git a/revision.c b/revision.c
new file mode 100644
index 0000000..17dbf9a
--- /dev/null
+++ b/revision.c
@@ -0,0 +1,370 @@
+#include "cache.h"
+#include "tag.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "refs.h"
+#include "revision.h"
+
+static char *path_name(struct name_path *path, const char *name)
+{
+	struct name_path *p;
+	char *n, *m;
+	int nlen = strlen(name);
+	int len = nlen + 1;
+
+	for (p = path; p; p = p->up) {
+		if (p->elem_len)
+			len += p->elem_len + 1;
+	}
+	n = xmalloc(len);
+	m = n + len - (nlen + 1);
+	strcpy(m, name);
+	for (p = path; p; p = p->up) {
+		if (p->elem_len) {
+			m -= p->elem_len + 1;
+			memcpy(m, p->elem, p->elem_len);
+			m[p->elem_len] = '/';
+		}
+	}
+	return n;
+}
+
+struct object_list **add_object(struct object *obj,
+				       struct object_list **p,
+				       struct name_path *path,
+				       const char *name)
+{
+	struct object_list *entry = xmalloc(sizeof(*entry));
+	entry->item = obj;
+	entry->next = *p;
+	entry->name = path_name(path, name);
+	*p = entry;
+	return &entry->next;
+}
+
+static void mark_blob_uninteresting(struct blob *blob)
+{
+	if (blob->object.flags & UNINTERESTING)
+		return;
+	blob->object.flags |= UNINTERESTING;
+}
+
+void mark_tree_uninteresting(struct tree *tree)
+{
+	struct object *obj = &tree->object;
+	struct tree_entry_list *entry;
+
+	if (obj->flags & UNINTERESTING)
+		return;
+	obj->flags |= UNINTERESTING;
+	if (!has_sha1_file(obj->sha1))
+		return;
+	if (parse_tree(tree) < 0)
+		die("bad tree %s", sha1_to_hex(obj->sha1));
+	entry = tree->entries;
+	tree->entries = NULL;
+	while (entry) {
+		struct tree_entry_list *next = entry->next;
+		if (entry->directory)
+			mark_tree_uninteresting(entry->item.tree);
+		else
+			mark_blob_uninteresting(entry->item.blob);
+		free(entry);
+		entry = next;
+	}
+}
+
+void mark_parents_uninteresting(struct commit *commit)
+{
+	struct commit_list *parents = commit->parents;
+
+	while (parents) {
+		struct commit *commit = parents->item;
+		commit->object.flags |= UNINTERESTING;
+
+		/*
+		 * Normally we haven't parsed the parent
+		 * yet, so we won't have a parent of a parent
+		 * here. However, it may turn out that we've
+		 * reached this commit some other way (where it
+		 * wasn't uninteresting), in which case we need
+		 * to mark its parents recursively too..
+		 */
+		if (commit->parents)
+			mark_parents_uninteresting(commit);
+
+		/*
+		 * A missing commit is ok iff its parent is marked 
+		 * uninteresting.
+		 *
+		 * We just mark such a thing parsed, so that when
+		 * it is popped next time around, we won't be trying
+		 * to parse it and get an error.
+		 */
+		if (!has_sha1_file(commit->object.sha1))
+			commit->object.parsed = 1;
+		parents = parents->next;
+	}
+}
+
+static void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
+{
+	add_object(obj, &revs->pending_objects, NULL, name);
+}
+
+static struct commit *get_commit_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
+{
+	struct object *object;
+
+	object = parse_object(sha1);
+	if (!object)
+		die("bad object %s", name);
+
+	/*
+	 * Tag object? Look what it points to..
+	 */
+	while (object->type == tag_type) {
+		struct tag *tag = (struct tag *) object;
+		object->flags |= flags;
+		if (revs->tag_objects && !(object->flags & UNINTERESTING))
+			add_pending_object(revs, object, tag->tag);
+		object = parse_object(tag->tagged->sha1);
+		if (!object)
+			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
+	}
+
+	/*
+	 * Commit object? Just return it, we'll do all the complex
+	 * reachability crud.
+	 */
+	if (object->type == commit_type) {
+		struct commit *commit = (struct commit *)object;
+		object->flags |= flags;
+		if (parse_commit(commit) < 0)
+			die("unable to parse commit %s", name);
+		if (flags & UNINTERESTING)
+			mark_parents_uninteresting(commit);
+		return commit;
+	}
+
+	/*
+	 * Tree object? Either mark it uniniteresting, or add it
+	 * to the list of objects to look at later..
+	 */
+	if (object->type == tree_type) {
+		struct tree *tree = (struct tree *)object;
+		if (!revs->tree_objects)
+			return NULL;
+		if (flags & UNINTERESTING) {
+			mark_tree_uninteresting(tree);
+			return NULL;
+		}
+		add_pending_object(revs, object, "");
+		return NULL;
+	}
+
+	/*
+	 * Blob object? You know the drill by now..
+	 */
+	if (object->type == blob_type) {
+		struct blob *blob = (struct blob *)object;
+		if (!revs->blob_objects)
+			return NULL;
+		if (flags & UNINTERESTING) {
+			mark_blob_uninteresting(blob);
+			return NULL;
+		}
+		add_pending_object(revs, object, "");
+		return NULL;
+	}
+	die("%s is unknown object", name);
+}
+
+static void add_one_commit(struct commit *commit, struct rev_info *revs)
+{
+	if (!commit || (commit->object.flags & SEEN))
+		return;
+	commit->object.flags |= SEEN;
+	commit_list_insert(commit, &revs->commits);
+}
+
+static int all_flags;
+static struct rev_info *all_revs;
+
+static int handle_one_ref(const char *path, const unsigned char *sha1)
+{
+	struct commit *commit = get_commit_reference(all_revs, path, sha1, all_flags);
+	add_one_commit(commit, all_revs);
+	return 0;
+}
+
+static void handle_all(struct rev_info *revs, unsigned flags)
+{
+	all_revs = revs;
+	all_flags = flags;
+	for_each_ref(handle_one_ref);
+}
+
+/*
+ * Parse revision information, filling in the "rev_info" structure,
+ * and removing the used arguments from the argument list.
+ *
+ * Returns the number of arguments left ("new argc").
+ */
+int setup_revisions(int argc, const char **argv, struct rev_info *revs)
+{
+	int i, flags, seen_dashdash;
+	const char *def = NULL;
+	const char **unrecognized = argv+1;
+	int left = 1;
+
+	memset(revs, 0, sizeof(*revs));
+	revs->lifo = 1;
+	revs->dense = 1;
+	revs->prefix = setup_git_directory();
+	revs->max_age = -1;
+	revs->min_age = -1;
+	revs->max_count = -1;
+
+	/* First, search for "--" */
+	seen_dashdash = 0;
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (strcmp(arg, "--"))
+			continue;
+		argv[i] = NULL;
+		argc = i;
+		revs->paths = get_pathspec(revs->prefix, argv + i + 1);
+		seen_dashdash = 1;
+		break;
+	}
+
+	flags = 0;
+	for (i = 1; i < argc; i++) {
+		struct commit *commit;
+		const char *arg = argv[i];
+		unsigned char sha1[20];
+		char *dotdot;
+		int local_flags;
+
+		if (*arg == '-') {
+			if (!strncmp(arg, "--max-count=", 12)) {
+				revs->max_count = atoi(arg + 12);
+				continue;
+			}
+			if (!strncmp(arg, "--max-age=", 10)) {
+				revs->max_age = atoi(arg + 10);
+				continue;
+			}
+			if (!strncmp(arg, "--min-age=", 10)) {
+				revs->min_age = atoi(arg + 10);
+				continue;
+			}
+			if (!strcmp(arg, "--all")) {
+				handle_all(revs, flags);
+				continue;
+			}
+			if (!strcmp(arg, "--not")) {
+				flags ^= UNINTERESTING;
+				continue;
+			}
+			if (!strcmp(arg, "--default")) {
+				if (++i >= argc)
+					die("bad --default argument");
+				def = argv[i];
+				continue;
+			}
+			if (!strcmp(arg, "--topo-order")) {
+				revs->topo_order = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--date-order")) {
+				revs->lifo = 0;
+				revs->topo_order = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--dense")) {
+				revs->dense = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--sparse")) {
+				revs->dense = 0;
+				continue;
+			}
+			if (!strcmp(arg, "--remove-empty")) {
+				revs->remove_empty_trees = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--objects")) {
+				revs->tag_objects = 1;
+				revs->tree_objects = 1;
+				revs->blob_objects = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--objects-edge")) {
+				revs->tag_objects = 1;
+				revs->tree_objects = 1;
+				revs->blob_objects = 1;
+				revs->edge_hint = 1;
+				continue;
+			}
+			*unrecognized++ = arg;
+			left++;
+			continue;
+		}
+		dotdot = strstr(arg, "..");
+		if (dotdot) {
+			unsigned char from_sha1[20];
+			char *next = dotdot + 2;
+			*dotdot = 0;
+			if (!*next)
+				next = "HEAD";
+			if (!get_sha1(arg, from_sha1) && !get_sha1(next, sha1)) {
+				struct commit *exclude;
+				struct commit *include;
+
+				exclude = get_commit_reference(revs, arg, from_sha1, flags ^ UNINTERESTING);
+				include = get_commit_reference(revs, next, sha1, flags);
+				if (!exclude || !include)
+					die("Invalid revision range %s..%s", arg, next);
+				add_one_commit(exclude, revs);
+				add_one_commit(include, revs);
+				continue;
+			}
+			*dotdot = '.';
+		}
+		local_flags = 0;
+		if (*arg == '^') {
+			local_flags = UNINTERESTING;
+			arg++;
+		}
+		if (get_sha1(arg, sha1) < 0) {
+			struct stat st;
+			int j;
+
+			if (seen_dashdash || local_flags)
+				die("bad revision '%s'", arg);
+
+			/* If we didn't have a "--", all filenames must exist */
+			for (j = i; j < argc; j++) {
+				if (lstat(argv[j], &st) < 0)
+					die("'%s': %s", arg, strerror(errno));
+			}
+			revs->paths = get_pathspec(revs->prefix, argv + i);
+			break;
+		}
+		commit = get_commit_reference(revs, arg, sha1, flags ^ local_flags);
+		add_one_commit(commit, revs);
+	}
+	if (def && !revs->commits) {
+		unsigned char sha1[20];
+		struct commit *commit;
+		if (get_sha1(def, sha1) < 0)
+			die("bad default revision '%s'", def);
+		commit = get_commit_reference(revs, def, sha1, 0);
+		add_one_commit(commit, revs);
+	}
+	*unrecognized = NULL;
+	return left;
+}
diff --git a/revision.h b/revision.h
new file mode 100644
index 0000000..5170ac4
--- /dev/null
+++ b/revision.h
@@ -0,0 +1,48 @@
+#ifndef REVISION_H
+#define REVISION_H
+
+#define SEEN		(1u<<0)
+#define UNINTERESTING   (1u<<1)
+
+struct rev_info {
+	/* Starting list */
+	struct commit_list *commits;
+	struct object_list *pending_objects;
+
+	/* Basic information */
+	const char *prefix;
+	const char **paths;
+
+	/* Traversal flags */
+	unsigned int	dense:1,
+			remove_empty_trees:1,
+			lifo:1,
+			topo_order:1,
+			tag_objects:1,
+			tree_objects:1,
+			blob_objects:1,
+			edge_hint:1;
+
+	/* special limits */
+	int max_count;
+	unsigned long max_age;
+	unsigned long min_age;
+};
+
+/* revision.c */
+extern int setup_revisions(int argc, const char **argv, struct rev_info *revs);
+extern void mark_parents_uninteresting(struct commit *commit);
+extern void mark_tree_uninteresting(struct tree *tree);
+
+struct name_path {
+	struct name_path *up;
+	int elem_len;
+	const char *elem;
+};
+
+extern struct object_list **add_object(struct object *obj,
+				       struct object_list **p,
+				       struct name_path *path,
+				       const char *name);
+
+#endif
