From: Jeff King <peff@peff.net>
Subject: [PATCH v2 14/25] prune: keep objects reachable from recent objects
Date: Wed, 15 Oct 2014 18:41:35 -0400
Message-ID: <20141015224135.GN25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:41:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXGI-0008G8-51
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbaJOWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:41:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:58983 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbaJOWli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:41:38 -0400
Received: (qmail 2488 invoked by uid 102); 15 Oct 2014 22:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:41:37 -0500
Received: (qmail 28116 invoked by uid 107); 15 Oct 2014 22:41:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:41:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:41:35 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our current strategy with prune is that an object falls into
one of three categories:

  1. Reachable (from ref tips, reflogs, index, etc).

  2. Not reachable, but recent (based on the --expire time).

  3. Not reachable and not recent.

We keep objects from (1) and (2), but prune objects in (3).
The point of (2) is that these objects may be part of an
in-progress operation that has not yet updated any refs.

However, it is not always the case that objects for an
in-progress operation will have a recent mtime. For example,
the object database may have an old copy of a blob (from an
abandoned operation, a branch that was deleted, etc). If we
create a new tree that points to it, a simultaneous prune
will leave our tree, but delete the blob. Referencing that
tree with a commit will then work (we check that the tree is
in the object database, but not that all of its referred
objects are), as will mentioning the commit in a ref. But
the resulting repo is corrupt; we are missing the blob
reachable from a ref.

One way to solve this is to be more thorough when
referencing a sha1: make sure that not only do we have that
sha1, but that we have objects it refers to, and so forth
recursively. The problem is that this is very expensive.
Creating a parent link would require traversing the entire
object graph!

Instead, this patch pushes the extra work onto prune, which
runs less frequently (and has to look at the whole object
graph anyway). It creates a new category of objects: objects
which are not recent, but which are reachable from a recent
object. We do not prune these objects, just like the
reachable and recent ones.

This lets us avoid the recursive check above, because if we
have an object, even if it is unreachable, we should have
its referent. We can make a simple inductive argument that
with this patch, this property holds (that there are no
objects with missing referents in the repository):

  0. When we have no objects, we have nothing to refer or be
     referred to, so the property holds.

  1. If we add objects to the repository, their direct
     referents must generally exist (e.g., if you create a
     tree, the blobs it references must exist; if you create
     a commit to point at the tree, the tree must exist).
     This is already the case before this patch. And it is
     not 100% foolproof (you can make bogus objects using
     `git hash-object`, for example), but it should be the
     case for normal usage.

     Therefore for any sequence of object additions, the
     property will continue to hold.

  2. If we remove objects from the repository, then we will
     not remove a child object (like a blob) if an object
     that refers to it is being kept. That is the part
     implemented by this patch.

     Note, however, that our reachability check and the
     actual pruning are not atomic. So it _is_ still
     possible to violate the property (e.g., an object
     becomes referenced just as we are deleting it). This
     patch is shooting for eliminating problems where the
     mtimes of dependent objects differ by hours or days,
     and one is dropped without the other. It does nothing
     to help with short races.

Naively, the simplest way to implement this would be to add
all recent objects as tips to the reachability traversal.
However, this does not perform well. In a recently-packed
repository, all reachable objects will also be recent, and
therefore we have to look at each object twice. This patch
instead performs the reachability traversal, then follows up
with a second traversal for recent objects, skipping any
that have already been marked.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/prune.c            |   2 +-
 builtin/reflog.c           |   2 +-
 reachable.c                | 112 +++++++++++++++++++++++++++++++++++++++++++++
 reachable.h                |   3 +-
 t/t6501-freshen-objects.sh |  88 +++++++++++++++++++++++++++++++++++
 5 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100755 t/t6501-freshen-objects.sh

diff --git a/builtin/prune.c b/builtin/prune.c
index 763f53e..04d3b12 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -135,7 +135,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 
-	mark_reachable_objects(&revs, 1, progress);
+	mark_reachable_objects(&revs, 1, expire, progress);
 	stop_progress(&progress);
 	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
 				      prune_cruft, prune_subdir, NULL);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b6388f7..2d85d26 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -649,7 +649,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		init_revisions(&cb.revs, prefix);
 		if (cb.verbose)
 			printf("Marking reachable objects...");
-		mark_reachable_objects(&cb.revs, 0, NULL);
+		mark_reachable_objects(&cb.revs, 0, 0, NULL);
 		if (cb.verbose)
 			putchar('\n');
 	}
diff --git a/reachable.c b/reachable.c
index d03f829..55589a0 100644
--- a/reachable.c
+++ b/reachable.c
@@ -97,7 +97,109 @@ static void mark_commit(struct commit *c, void *data)
 	mark_object(&c->object, NULL, NULL, data);
 }
 
+struct recent_data {
+	struct rev_info *revs;
+	unsigned long timestamp;
+};
+
+static void add_recent_object(const unsigned char *sha1,
+			      unsigned long mtime,
+			      struct recent_data *data)
+{
+	struct object *obj;
+	enum object_type type;
+
+	if (mtime <= data->timestamp)
+		return;
+
+	/*
+	 * We do not want to call parse_object here, because
+	 * inflating blobs and trees could be very expensive.
+	 * However, we do need to know the correct type for
+	 * later processing, and the revision machinery expects
+	 * commits and tags to have been parsed.
+	 */
+	type = sha1_object_info(sha1, NULL);
+	if (type < 0)
+		die("unable to get object info for %s", sha1_to_hex(sha1));
+
+	switch (type) {
+	case OBJ_TAG:
+	case OBJ_COMMIT:
+		obj = parse_object_or_die(sha1, NULL);
+		break;
+	case OBJ_TREE:
+		obj = (struct object *)lookup_tree(sha1);
+		break;
+	case OBJ_BLOB:
+		obj = (struct object *)lookup_blob(sha1);
+		break;
+	default:
+		die("unknown object type for %s: %s",
+		    sha1_to_hex(sha1), typename(type));
+	}
+
+	if (!obj)
+		die("unable to lookup %s", sha1_to_hex(sha1));
+
+	add_pending_object(data->revs, obj, "");
+}
+
+static int add_recent_loose(const unsigned char *sha1,
+			    const char *path, void *data)
+{
+	struct stat st;
+	struct object *obj = lookup_object(sha1);
+
+	if (obj && obj->flags & SEEN)
+		return 0;
+
+	if (stat(path, &st) < 0) {
+		/*
+		 * It's OK if an object went away during our iteration; this
+		 * could be due to a simultaneous repack. But anything else
+		 * we should abort, since we might then fail to mark objects
+		 * which should not be pruned.
+		 */
+		if (errno == ENOENT)
+			return 0;
+		return error("unable to stat %s: %s",
+			     sha1_to_hex(sha1), strerror(errno));
+	}
+
+	add_recent_object(sha1, st.st_mtime, data);
+	return 0;
+}
+
+static int add_recent_packed(const unsigned char *sha1,
+			     struct packed_git *p, uint32_t pos,
+			     void *data)
+{
+	struct object *obj = lookup_object(sha1);
+
+	if (obj && obj->flags & SEEN)
+		return 0;
+	add_recent_object(sha1, p->mtime, data);
+	return 0;
+}
+
+static int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
+						  unsigned long timestamp)
+{
+	struct recent_data data;
+	int r;
+
+	data.revs = revs;
+	data.timestamp = timestamp;
+
+	r = for_each_loose_object(add_recent_loose, &data);
+	if (r)
+		return r;
+	return for_each_packed_object(add_recent_packed, &data);
+}
+
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
+			    unsigned long mark_recent,
 			    struct progress *progress)
 {
 	struct connectivity_progress cp;
@@ -133,5 +235,15 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	traverse_commit_list(revs, mark_commit, mark_object, &cp);
+
+	if (mark_recent) {
+		revs->ignore_missing_links = 1;
+		if (add_unseen_recent_objects_to_traversal(revs, mark_recent))
+			die("unable to mark recent objects");
+		if (prepare_revision_walk(revs))
+			die("revision walk setup failed");
+		traverse_commit_list(revs, mark_commit, mark_object, &cp);
+	}
+
 	display_progress(cp.progress, cp.count);
 }
diff --git a/reachable.h b/reachable.h
index 5d082ad..141fe30 100644
--- a/reachable.h
+++ b/reachable.h
@@ -2,6 +2,7 @@
 #define REACHEABLE_H
 
 struct progress;
-extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog, struct progress *);
+extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
+				   unsigned long mark_recent, struct progress *);
 
 #endif
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
new file mode 100755
index 0000000..de941c2
--- /dev/null
+++ b/t/t6501-freshen-objects.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+#
+# This test covers the handling of objects which might have old
+# mtimes in the filesystem (because they were used previously)
+# and are just now becoming referenced again.
+#
+# We're going to do two things that are a little bit "fake" to
+# help make our simulation easier:
+#
+#   1. We'll turn off reflogs. You can still run into
+#      problems with reflogs on, but your objects
+#      don't get pruned until both the reflog expiration
+#      has passed on their references, _and_ they are out
+#      of prune's expiration period. Dropping reflogs
+#      means we only have to deal with one variable in our tests,
+#      but the results generalize.
+#
+#   2. We'll use a temporary index file to create our
+#      works-in-progress. Most workflows would mention
+#      referenced objects in the index, which prune takes
+#      into account. However, many operations don't. For
+#      example, a partial commit with "git commit foo"
+#      will use a temporary index. Or they may not need
+#      an index at all (e.g., creating a new commit
+#      to refer to an existing tree).
+
+test_description='check pruning of dependent objects'
+. ./test-lib.sh
+
+# We care about reachability, so we do not want to use
+# the normal test_commit, which creates extra tags.
+add () {
+	echo "$1" >"$1" &&
+	git add "$1"
+}
+commit () {
+	test_tick &&
+	add "$1" &&
+	git commit -m "$1"
+}
+
+test_expect_success 'disable reflogs' '
+	git config core.logallrefupdates false &&
+	rm -rf .git/logs
+'
+
+test_expect_success 'setup basic history' '
+	commit base
+'
+
+test_expect_success 'create and abandon some objects' '
+	git checkout -b experiment &&
+	commit abandon &&
+	git checkout master &&
+	git branch -D experiment
+'
+
+test_expect_success 'simulate time passing' '
+	find .git/objects -type f |
+	xargs test-chmtime -v -86400
+'
+
+test_expect_success 'start writing new commit with old blob' '
+	tree=$(
+		GIT_INDEX_FILE=index.tmp &&
+		export GIT_INDEX_FILE &&
+		git read-tree HEAD &&
+		add unrelated &&
+		add abandon &&
+		git write-tree
+	)
+'
+
+test_expect_success 'simultaneous gc' '
+	git gc --prune=12.hours.ago
+'
+
+test_expect_success 'finish writing out commit' '
+	commit=$(echo foo | git commit-tree -p HEAD $tree) &&
+	git update-ref HEAD $commit
+'
+
+# "abandon" blob should have been rescued by reference from new tree
+test_expect_success 'repository passes fsck' '
+	git fsck
+'
+
+test_done
-- 
2.1.2.596.g7379948
