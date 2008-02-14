From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH] Remove object-refs from fsck
Date: Thu, 14 Feb 2008 04:00:13 -0500
Message-ID: <20080214090013.GK24004@spearce.org>
References: <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080212190411.GA23837@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121507310.2732@xanadu.home> <20080212213858.GA29151@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121645121.2732@xanadu.home> <20080213062015.GF24004@spearce.org> <20080213073959.GA27158@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Thu Feb 14 10:01:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPZy3-0000aw-Gw
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 10:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428AbYBNJAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 04:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757527AbYBNJAm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 04:00:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38772 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117AbYBNJAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 04:00:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPZx3-0007go-DU; Thu, 14 Feb 2008 04:00:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0B15D20FBAE; Thu, 14 Feb 2008 04:00:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080213073959.GA27158@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73866>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> On Wed, Feb 13, 2008 at 01:20:15AM -0500, Shawn O. Pearce wrote:
> >     Is it just me or is track_object_refs perhaps outlived its
> >     usefulness?
> 
> See the patch at the start of this topic. I'm working on replacing
> track-object-refs.
> 
> It is missing some frees and I copied the lookup_unknown_object call
> (This should be replaced with an error message in my patch, as the the
> verification of the tree content would reject such an invalid mode).

Here's my first attempt at removing track_object_refs.  At least
the diffstat suggets its in the correct direction.  Note!  It is
only very lightly tested, which is why this is not a properly
formatted patch.

I'm trying to reuse the code in reachable.c, which is what prune
is based on.  We now parse trees twice.  Once to read the content
and verify it is sane and later to perform the reachability walk.
We use less memory however as we no longer have object_refs.

Missing objects discovered during fsck get flagged on the referrer
by the new WANTING flag.  We go back later and reparse the referrer
to find out what links he had that were broken.  This 3rd parse of
a tree shouldn't be an issue in a perfectly valid repository.

In other news, fsck --full is a dog.

I think we can make it run faster for packed data by fsck'ing
according to the delta base, as index-pack does.  We also could get
better running time if we avoided the per-object unpack/checksum
that occurs in verify_pack() and instead do it as part of the fsck
delta base ordered loop.

Today `fsck --full` is actually SHA-1 checksumming every object in
a packfile twice: once in verify_pack() and again in parse_object().
Cute.


--8<--
 Makefile               |    2 +-
 builtin-fetch-pack.c   |    1 -
 builtin-fsck.c         |  199 ++++++++++++++++++++++++++++++------------------
 builtin-pack-objects.c |    1 -
 builtin-prune.c        |    2 +-
 builtin-reflog.c       |    2 +-
 builtin-rev-list.c     |    1 -
 commit.c               |   11 ---
 object-refs.c          |   87 ---------------------
 object.h               |   13 ---
 reachable.c            |   43 ++++++++--
 reachable.h            |    7 ++-
 tag.c                  |    6 --
 tree.c                 |   48 ------------
 upload-pack.c          |    1 -
 walker.c               |    1 -
 16 files changed, 168 insertions(+), 257 deletions(-)

diff --git a/Makefile b/Makefile
index 92341c4..8f930ed 100644
--- a/Makefile
+++ b/Makefile
@@ -312,7 +312,7 @@ LIB_OBJS = \
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
diff --git a/builtin-fsck.c b/builtin-fsck.c
index cc7524b..50c358b 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -9,9 +9,12 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "parse-options.h"
+#include "diff.h"
+#include "revision.h"
+#include "reachable.h"
 
-#define REACHABLE 0x0001
-#define SEEN      0x0002
+#define FSCKED    (1u<<17)
+#define WANTING   (1u<<18)
 
 static int show_root;
 static int show_tags;
@@ -63,13 +66,81 @@ static int objwarning(struct object *obj, const char *err, ...)
 	return -1;
 }
 
+static int object_exists(const unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+	if (obj && obj->flags & FSCKED)
+		return 1;
+	return has_sha1_file(sha1);
+}
+
+static void broken_link(struct object *obj,
+		enum object_type ref_type,
+		const unsigned char *ref_sha1)
+{
+	printf("broken link from %7s %s\n",
+	       typename(obj->type), sha1_to_hex(obj->sha1));
+	printf("              to %7s %s\n",
+	       typename(ref_type), sha1_to_hex(ref_sha1));
+	errors_found |= ERROR_REACHABLE;
+}
+
+static void broken_tree(struct tree *item)
+{
+	struct tree_desc desc;
+
+	item->object.parsed = 0;
+	if (parse_tree(item) < 0)
+		return; /* error already displayed */
+
+	init_tree_desc(&desc, item->buffer, item->size);
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+		if (S_ISGITLINK(mode) || object_exists(sha1))
+			continue;
+		if (S_ISDIR(mode))
+			broken_link(&item->object, OBJ_TREE, sha1);
+		else
+			broken_link(&item->object, OBJ_BLOB, sha1);
+	}
+	free(item->buffer);
+	item->buffer = NULL;
+}
+
+static void broken_commit(struct commit *commit)
+{
+	struct tree *tree = commit->tree;
+	struct commit_list *pp;
+
+	if (tree && !object_exists(tree->object.sha1))
+		broken_link(&commit->object, OBJ_TREE, tree->object.sha1);
+
+	pp = commit->parents;
+	while (pp) {
+		struct commit *p = pp->item;
+		if (p && !object_exists(p->object.sha1))
+			broken_link(&commit->object, OBJ_COMMIT, p->object.sha1);
+		pp = pp->next;
+	}
+}
+
+static void broken_tag(struct tag *tag)
+{
+	struct object *ref = tag->tagged;
+	if (ref && !object_exists(ref->sha1))
+		broken_link(&tag->object, ref->type, ref->sha1);
+}
+
 /*
  * Check a single reachable object
  */
 static void check_reachable_object(struct object *obj)
 {
-	const struct object_refs *refs;
-
 	/*
 	 * We obviously want the object to be parsed,
 	 * except if it was in a pack-file and we didn't
@@ -84,21 +155,28 @@ static void check_reachable_object(struct object *obj)
 	}
 
 	/*
-	 * Check that everything that we try to reference is also good.
+	 * If the fsck routines found this object WANTING
+	 * then we need to re-evaluate what it wanted and
+	 * report on those broken links.
 	 */
-	refs = lookup_object_refs(obj);
-	if (refs) {
-		unsigned j;
-		for (j = 0; j < refs->count; j++) {
-			struct object *ref = refs->ref[j];
-			if (ref->parsed ||
-			    (has_sha1_file(ref->sha1)))
-				continue;
-			printf("broken link from %7s %s\n",
-			       typename(obj->type), sha1_to_hex(obj->sha1));
-			printf("              to %7s %s\n",
-			       typename(ref->type), sha1_to_hex(ref->sha1));
-			errors_found |= ERROR_REACHABLE;
+	if (obj->flags & WANTING) {
+		switch (obj->type) {
+		case OBJ_TREE:
+			broken_tree((struct tree *) obj);
+			break;
+
+		case OBJ_COMMIT:
+			broken_commit((struct commit *) obj);
+			break;
+
+		case OBJ_TAG:
+			broken_tag((struct tag *) obj);
+			break;
+
+		default:
+			objerror(obj,
+				"type '%d' has broken link (internal fsck error)",
+				obj->type);
 		}
 	}
 }
@@ -181,7 +259,7 @@ static void check_object(struct object *obj)
 	if (verbose)
 		fprintf(stderr, "Checking %s\n", sha1_to_hex(obj->sha1));
 
-	if (obj->flags & REACHABLE)
+	if (obj->flags & SEEN)
 		check_reachable_object(obj);
 	else
 		check_unreachable_object(obj);
@@ -309,6 +387,15 @@ static int fsck_tree(struct tree *item)
 			has_bad_modes = 1;
 		}
 
+		/*
+		 * If the SHA-1 should exist in this repository but
+		 * we are missing it flag this tree as WANTING.  We
+		 * will revisit this error later once we determine
+		 * this tree is SEEN.
+		 */
+		if (!S_ISGITLINK(mode) && !object_exists(sha1))
+			item->object.flags |= WANTING;
+
 		if (o_name) {
 			switch (verify_ordered(o_mode, o_name, mode, name)) {
 			case TREE_UNORDERED:
@@ -367,10 +454,15 @@ static int fsck_commit(struct commit *commit)
 		return objerror(&commit->object, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
 		return objerror(&commit->object, "invalid 'tree' line format - bad sha1");
+	if (!object_exists(tree_sha1))
+		commit->object.flags |= WANTING;
+
 	buffer += 46;
 	while (!memcmp(buffer, "parent ", 7)) {
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
 			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
+		if (!object_exists(sha1))
+			commit->object.flags |= WANTING;
 		buffer += 48;
 	}
 	if (memcmp(buffer, "author ", 7))
@@ -395,6 +487,9 @@ static int fsck_tag(struct tag *tag)
 	if (!tagged) {
 		return objerror(&tag->object, "could not load tagged object");
 	}
+	if (!object_exists(tagged->sha1))
+		tag->object.flags |= WANTING;
+
 	if (!show_tags)
 		return 0;
 
@@ -411,9 +506,9 @@ static int fsck_sha1(const unsigned char *sha1)
 		return error("%s: object corrupt or missing",
 			     sha1_to_hex(sha1));
 	}
-	if (obj->flags & SEEN)
+	if (obj->flags & FSCKED)
 		return 0;
-	obj->flags |= SEEN;
+	obj->flags |= FSCKED;
 	if (obj->type == OBJ_BLOB)
 		return 0;
 	if (obj->type == OBJ_TREE)
@@ -524,37 +619,6 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
-static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
-{
-	struct object *obj;
-
-	if (verbose)
-		fprintf(stderr, "Checking reflog %s->%s\n",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1));
-
-	if (!is_null_sha1(osha1)) {
-		obj = lookup_object(osha1);
-		if (obj) {
-			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
-		}
-	}
-	obj = lookup_object(nsha1);
-	if (obj) {
-		obj->used = 1;
-		mark_reachable(obj, REACHABLE);
-	}
-	return 0;
-}
-
-static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, int flag, void *cb_data)
-{
-	for_each_reflog_ent(logname, fsck_handle_reflog_ent, NULL);
-	return 0;
-}
-
 static int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
@@ -574,7 +638,6 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 		error("%s: not a commit", refname);
 	default_refs++;
 	obj->used = 1;
-	mark_reachable(obj, REACHABLE);
 
 	return 0;
 }
@@ -582,8 +645,6 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 static void get_default_heads(void)
 {
 	for_each_ref(fsck_handle_ref, NULL);
-	if (include_reflogs)
-		for_each_reflog(fsck_handle_reflog, NULL);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -660,7 +721,6 @@ static int fsck_cache_tree(struct cache_tree *it)
 			      sha1_to_hex(it->sha1));
 			return 1;
 		}
-		mark_reachable(obj, REACHABLE);
 		obj->used = 1;
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
@@ -692,8 +752,8 @@ static struct option fsck_opts[] = {
 int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
+	struct rev_info revs;
 
-	track_object_refs = 1;
 	errors_found = 0;
 
 	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
@@ -731,6 +791,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	heads = 0;
+	init_revisions(&revs, "");
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!get_sha1(arg, head_sha1)) {
@@ -740,8 +801,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			if (!obj)
 				continue;
 
-			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
+			add_pending_object(&revs, obj, arg);
 			heads++;
 			continue;
 		}
@@ -760,25 +820,16 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (keep_cache_objects) {
 		read_cache();
-		for (i = 0; i < active_nr; i++) {
-			unsigned int mode;
-			struct blob *blob;
-			struct object *obj;
-
-			mode = active_cache[i]->ce_mode;
-			if (S_ISGITLINK(mode))
-				continue;
-			blob = lookup_blob(active_cache[i]->sha1);
-			if (!blob)
-				continue;
-			obj = &blob->object;
-			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
-		}
 		if (active_cache_tree)
 			fsck_cache_tree(active_cache_tree);
 	}
 
+	ignore_reachability_errors = 1;
+	mark_reachable_objects(
+		&revs,
+		!heads,
+		!heads && include_reflogs,
+		keep_cache_objects);
 	check_connectivity();
 	return errors_found;
 }
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 692a761..2aaeb1a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2013,7 +2013,6 @@ static void get_object_list(int ac, const char **av)
 
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
-	track_object_refs = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
diff --git a/builtin-prune.c b/builtin-prune.c
index bb8ead9..760e41d 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -147,7 +147,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 	init_revisions(&revs, prefix);
-	mark_reachable_objects(&revs, 1);
+	mark_reachable_objects(&revs, 1, 1, 1);
 
 	prune_object_dir(get_object_directory());
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 4836ec9..108ca7a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -374,7 +374,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		init_revisions(&cb.revs, prefix);
 		if (cb.verbose)
 			printf("Marking reachable objects...");
-		mark_reachable_objects(&cb.revs, 0);
+		mark_reachable_objects(&cb.revs, 1, 0, 1);
 		if (cb.verbose)
 			putchar('\n');
 	}
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index de80158..14e86ce 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -605,7 +605,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		usage(rev_list_usage);
 
 	save_commit_buffer = revs.verbose_header || revs.grep_filter;
-	track_object_refs = 0;
 	if (bisect_list)
 		revs.limited = 1;
 
diff --git a/commit.c b/commit.c
index 8b8fb04..df4d331 100644
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
index 397bbfa..20f560f 100644
--- a/object.h
+++ b/object.h
@@ -6,11 +6,6 @@ struct object_list {
 	struct object_list *next;
 };
 
-struct object_refs {
-	unsigned count;
-	struct object *ref[FLEX_ARRAY]; /* more */
-};
-
 struct object_array {
 	unsigned int nr;
 	unsigned int alloc;
@@ -35,14 +30,11 @@ struct object {
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
@@ -61,11 +53,6 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
 
-struct object_refs *alloc_object_refs(unsigned count);
-void set_object_refs(struct object *obj, struct object_refs *refs);
-
-void mark_reachable(struct object *obj, unsigned int mask);
-
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
 
diff --git a/reachable.c b/reachable.c
index 00f289f..0ded91c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -8,6 +8,8 @@
 #include "reachable.h"
 #include "cache-tree.h"
 
+int ignore_reachability_errors;
+
 static void process_blob(struct blob *blob,
 			 struct object_array *p,
 			 struct name_path *path,
@@ -42,8 +44,20 @@ static void process_tree(struct tree *tree,
 	if (obj->flags & SEEN)
 		return;
 	obj->flags |= SEEN;
-	if (parse_tree(tree) < 0)
-		die("bad tree object %s", sha1_to_hex(obj->sha1));
+	if (!obj->parsed || !tree->buffer) {
+		enum object_type type;
+		unsigned long size;
+		tree->buffer = read_sha1_file(obj->sha1, &type, &size);
+		if (!tree->buffer || type != OBJ_TREE) {
+			if (!ignore_reachability_errors)
+				die("bad tree object %s", sha1_to_hex(obj->sha1));
+			free(tree->buffer);
+			tree->buffer = NULL;
+			return;
+		}
+		tree->size = size;
+		obj->parsed = 1;
+	}
 	name = xstrdup(name);
 	add_object(obj, p, path, name);
 	me.up = path;
@@ -134,9 +148,10 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 	struct object *object = parse_object(sha1);
 	struct rev_info *revs = (struct rev_info *)cb_data;
 
-	if (!object)
+	if (object)
+		add_pending_object(revs, object, "");
+	else if (!ignore_reachability_errors)
 		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
-	add_pending_object(revs, object, "");
 
 	return 0;
 }
@@ -166,6 +181,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs)
 static void add_cache_refs(struct rev_info *revs)
 {
 	int i;
+	struct blob *obj;
 
 	read_cache();
 	for (i = 0; i < active_nr; i++) {
@@ -179,7 +195,10 @@ static void add_cache_refs(struct rev_info *revs)
 		if (S_ISGITLINK(active_cache[i]->ce_mode))
 			continue;
 
-		lookup_blob(active_cache[i]->sha1);
+		obj = lookup_blob(active_cache[i]->sha1);
+		if (obj)
+			obj->object.flags |= SEEN;
+
 		/*
 		 * We could add the blobs to the pending list, but quite
 		 * frankly, we don't care. Once we've looked them up, and
@@ -191,7 +210,11 @@ static void add_cache_refs(struct rev_info *revs)
 		add_cache_tree(active_cache_tree, revs);
 }
 
-void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
+void mark_reachable_objects(
+		struct rev_info *revs,
+		int mark_refs,
+		int mark_reflog,
+		int mark_cache)
 {
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -202,13 +225,15 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
 	revs->tree_objects = 1;
 
 	/* Add all refs from the index file */
-	add_cache_refs(revs);
+	if (mark_cache)
+		add_cache_refs(revs);
 
 	/* Add all external refs */
-	for_each_ref(add_one_ref, revs);
+	if (mark_refs)
+		for_each_ref(add_one_ref, revs);
 
 	/* Add all reflog info */
-	if (mark_reflog)
+	if (mark_refs && mark_reflog)
 		for_each_reflog(add_one_reflog, revs);
 
 	/*
diff --git a/reachable.h b/reachable.h
index 4075181..802d464 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,6 +1,11 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
 
-extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog);
+extern int ignore_reachability_errors;
+extern void mark_reachable_objects(
+		struct rev_info *revs,
+		int mark_refs,
+		int mark_reflog,
+		int mark_cache);
 
 #endif
diff --git a/tag.c b/tag.c
index 38bf913..d19f56d 100644
--- a/tag.c
+++ b/tag.c
@@ -84,12 +84,6 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
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
index 51e3ec4..7c2f5e5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -392,7 +392,6 @@ static int get_common_commits(void)
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
Shawn.
