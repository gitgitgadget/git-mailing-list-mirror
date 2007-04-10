From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] Refactor patch-id filtering out of git-cherry and git-format-patch.
Date: Tue, 10 Apr 2007 15:39:48 -0700
Message-ID: <7vmz1fua4r.fsf_-_@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	<7vircbwfym.fsf@assigned-by-dhcp.cox.net>
	<7virc524cd.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 05:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbP0m-0001C9-OT
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030716AbXDJWjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbXDJWjw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:39:52 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55286 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030716AbXDJWju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:39:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410223950.MTPV1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 18:39:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lafp1W00F1kojtg0000000; Tue, 10 Apr 2007 18:39:49 -0400
In-Reply-To: <7virc524cd.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Apr 2007 04:07:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44172>

This implements the patch-id computation and recording library,
patch-ids.c, and rewrites the get_patch_ids() function used in
cherry and format-patch to use it, so that they do not pollute
the object namespace.  Earlier code threw non-objects into the
in-core object database, and hoped for not getting bitten by
SHA-1 collisions.  While it may be practically Ok, it still was
an ugly hack.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * Replacement of the previous one.  I wanted to clean-up the
   mess first.

 Makefile      |    3 +-
 builtin-log.c |   44 ++++---------
 patch-ids.c   |  192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 patch-ids.h   |   21 ++++++
 4 files changed, 228 insertions(+), 32 deletions(-)
 create mode 100644 patch-ids.c
 create mode 100644 patch-ids.h

diff --git a/Makefile b/Makefile
index a77d31d..f956c3d 100644
--- a/Makefile
+++ b/Makefile
@@ -283,7 +283,7 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h
+	utf8.h reflog-walk.h patch-ids.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -295,6 +295,7 @@ LIB_OBJS = \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o \
 	interpolate.o \
 	lockfile.o \
+	patch-ids.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o sideband.o \
 	reachable.o reflog-walk.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
diff --git a/builtin-log.c b/builtin-log.c
index 71df957..df676df 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "tag.h"
 #include "reflog-walk.h"
+#include "patch-ids.h"
 
 static int default_show_root = 1;
 
@@ -333,25 +334,12 @@ static int reopen_stdout(struct commit *commit, int nr, int keep_subject)
 
 }
 
-static int get_patch_id(struct commit *commit, struct diff_options *options,
-		unsigned char *sha1)
-{
-	if (commit->parents)
-		diff_tree_sha1(commit->parents->item->object.sha1,
-		               commit->object.sha1, "", options);
-	else
-		diff_root_tree_sha1(commit->object.sha1, "", options);
-	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1);
-}
-
-static void get_patch_ids(struct rev_info *rev, struct diff_options *options, const char *prefix)
+static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const char *prefix)
 {
 	struct rev_info check_rev;
 	struct commit *commit;
 	struct object *o1, *o2;
 	unsigned flags1, flags2;
-	unsigned char sha1[20];
 
 	if (rev->pending.nr != 2)
 		die("Need exactly one range.");
@@ -364,10 +352,7 @@ static void get_patch_ids(struct rev_info *rev, struct diff_options *options, co
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die("Not a range.");
 
-	diff_setup(options);
-	options->recursive = 1;
-	if (diff_setup_done(options) < 0)
-		die("diff_setup_done failed");
+	init_patch_ids(ids);
 
 	/* given a range a..b get all patch ids for b..a */
 	init_revisions(&check_rev, prefix);
@@ -382,8 +367,7 @@ static void get_patch_ids(struct rev_info *rev, struct diff_options *options, co
 		if (commit->parents && commit->parents->next)
 			continue;
 
-		if (!get_patch_id(commit, options, sha1))
-			created_object(sha1, xcalloc(1, sizeof(struct object)));
+		add_commit_patch_id(commit, ids);
 	}
 
 	/* reset for next revision walk */
@@ -420,7 +404,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
 	const char *in_reply_to = NULL;
-	struct diff_options patch_id_opts;
+	struct patch_ids ids;
 	char *add_signoff = NULL;
 	char message_id[1024];
 	char ref_message_id[1024];
@@ -554,22 +538,19 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (ignore_if_in_upstream)
-		get_patch_ids(&rev, &patch_id_opts, prefix);
+		get_patch_ids(&rev, &ids, prefix);
 
 	if (!use_stdout)
 		realstdout = fdopen(dup(1), "w");
 
 	prepare_revision_walk(&rev);
 	while ((commit = get_revision(&rev)) != NULL) {
-		unsigned char sha1[20];
-
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
 			continue;
 
 		if (ignore_if_in_upstream &&
-				!get_patch_id(commit, &patch_id_opts, sha1) &&
-				lookup_object(sha1))
+				has_commit_patch_id(commit, &ids))
 			continue;
 
 		nr++;
@@ -624,6 +605,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fclose(stdout);
 	}
 	free(list);
+	if (ignore_if_in_upstream)
+		free_patch_ids(&ids);
 	return 0;
 }
 
@@ -646,7 +629,7 @@ static const char cherry_usage[] =
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct diff_options patch_id_opts;
+	struct patch_ids ids;
 	struct commit *commit;
 	struct commit_list *list = NULL;
 	const char *upstream;
@@ -692,7 +675,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			return 0;
 	}
 
-	get_patch_ids(&revs, &patch_id_opts, prefix);
+	get_patch_ids(&revs, &ids, prefix);
 
 	if (limit && add_pending_commit(limit, &revs, UNINTERESTING))
 		die("Unknown commit %s", limit);
@@ -708,12 +691,10 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	}
 
 	while (list) {
-		unsigned char sha1[20];
 		char sign = '+';
 
 		commit = list->item;
-		if (!get_patch_id(commit, &patch_id_opts, sha1) &&
-		    lookup_object(sha1))
+		if (has_commit_patch_id(commit, &ids))
 			sign = '-';
 
 		if (verbose) {
@@ -731,5 +712,6 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		list = list->next;
 	}
 
+	free_patch_ids(&ids);
 	return 0;
 }
diff --git a/patch-ids.c b/patch-ids.c
new file mode 100644
index 0000000..a288fac
--- /dev/null
+++ b/patch-ids.c
@@ -0,0 +1,192 @@
+#include "cache.h"
+#include "diff.h"
+#include "commit.h"
+#include "patch-ids.h"
+
+static int commit_patch_id(struct commit *commit, struct diff_options *options,
+		    unsigned char *sha1)
+{
+	if (commit->parents)
+		diff_tree_sha1(commit->parents->item->object.sha1,
+		               commit->object.sha1, "", options);
+	else
+		diff_root_tree_sha1(commit->object.sha1, "", options);
+	diffcore_std(options);
+	return diff_flush_patch_id(options, sha1);
+}
+
+static uint32_t take2(const unsigned char *id)
+{
+	return ((id[0] << 8) | id[1]);
+}
+
+/*
+ * Conventional binary search loop looks like this:
+ *
+ *      do {
+ *              int mi = (lo + hi) / 2;
+ *              int cmp = "entry pointed at by mi" minus "target";
+ *              if (!cmp)
+ *                      return (mi is the wanted one)
+ *              if (cmp > 0)
+ *                      hi = mi; "mi is larger than target"
+ *              else
+ *                      lo = mi+1; "mi is smaller than target"
+ *      } while (lo < hi);
+ *
+ * The invariants are:
+ *
+ * - When entering the loop, lo points at a slot that is never
+ *   above the target (it could be at the target), hi points at a
+ *   slot that is guaranteed to be above the target (it can never
+ *   be at the target).
+ *
+ * - We find a point 'mi' between lo and hi (mi could be the same
+ *   as lo, but never can be the same as hi), and check if it hits
+ *   the target.  There are three cases:
+ *
+ *    - if it is a hit, we are happy.
+ *
+ *    - if it is strictly higher than the target, we update hi with
+ *      it.
+ *
+ *    - if it is strictly lower than the target, we update lo to be
+ *      one slot after it, because we allow lo to be at the target.
+ *
+ * When choosing 'mi', we do not have to take the "middle" but
+ * anywhere in between lo and hi, as long as lo <= mi < hi is
+ * satisfied.  When we somehow know that the distance between the
+ * target and lo is much shorter than the target and hi, we could
+ * pick mi that is much closer to lo than the midway.
+ */
+static int patch_pos(struct patch_id **table, int nr, const unsigned char *id)
+{
+	int hi = nr;
+	int lo = 0;
+	int mi = 0;
+
+	if (!nr)
+		return -1;
+
+	if (nr != 1) {
+		unsigned lov, hiv, miv, ofs;
+
+		for (ofs = 0; ofs < 18; ofs += 2) {
+			lov = take2(table[0]->patch_id + ofs);
+			hiv = take2(table[nr-1]->patch_id + ofs);
+			miv = take2(id + ofs);
+			if (miv < lov)
+				return -1;
+			if (hiv < miv)
+				return -1 - nr;
+			if (lov != hiv) {
+				/*
+				 * At this point miv could be equal
+				 * to hiv (but id could still be higher);
+				 * the invariant of (mi < hi) should be
+				 * kept.
+				 */
+				mi = (nr-1) * (miv - lov) / (hiv - lov);
+				if (lo <= mi && mi < hi)
+					break;
+				die("oops");
+			}
+		}
+		if (18 <= ofs)
+			die("cannot happen -- lo and hi are identical");
+	}
+
+	do {
+		int cmp;
+		cmp = hashcmp(table[mi]->patch_id, id);
+		if (!cmp)
+			return mi;
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+		mi = (hi + lo) / 2;
+	} while (lo < hi);
+	return -lo-1;
+}
+
+#define BUCKET_SIZE 190 /* 190 * 21 = 3990, with slop close enough to 4K */
+struct patch_id_bucket {
+	struct patch_id_bucket *next;
+	int nr;
+	struct patch_id bucket[BUCKET_SIZE];
+};
+
+int init_patch_ids(struct patch_ids *ids)
+{
+	memset(ids, 0, sizeof(*ids));
+	diff_setup(&ids->diffopts);
+	ids->diffopts.recursive = 1;
+	if (diff_setup_done(&ids->diffopts) < 0)
+		return error("diff_setup_done failed");
+	return 0;
+}
+
+int free_patch_ids(struct patch_ids *ids)
+{
+	struct patch_id_bucket *next, *patches;
+
+	free(ids->table);
+	for (patches = ids->patches; patches; patches = next) {
+		next = patches->next;
+		free(patches);
+	}
+	return 0;
+}
+
+static struct patch_id *add_commit(struct commit *commit,
+				   struct patch_ids *ids,
+				   int no_add)
+{
+	struct patch_id_bucket *bucket;
+	struct patch_id *ent;
+	unsigned char sha1[20];
+	int pos;
+
+	if (commit_patch_id(commit, &ids->diffopts, sha1))
+		return NULL;
+	pos = patch_pos(ids->table, ids->nr, sha1);
+	if (0 <= pos)
+		return ids->table[pos];
+	if (no_add)
+		return NULL;
+
+	pos = -1 - pos;
+
+	bucket = ids->patches;
+	if (!bucket || (BUCKET_SIZE <= bucket->nr)) {
+		bucket = xcalloc(1, sizeof(*bucket));
+		bucket->next = ids->patches;
+		ids->patches = bucket;
+	}
+	ent = &bucket->bucket[bucket->nr++];
+	hashcpy(ent->patch_id, sha1);
+
+	if (ids->alloc <= ids->nr) {
+		ids->alloc = alloc_nr(ids->nr);
+		ids->table = xrealloc(ids->table, sizeof(ent) * ids->alloc);
+	}
+	if (pos < ids->nr)
+		memmove(ids->table + pos + 1, ids->table + pos,
+			sizeof(ent) * (ids->nr - pos));
+	ids->nr++;
+	ids->table[pos] = ent;
+	return ids->table[pos];
+}
+
+struct patch_id *has_commit_patch_id(struct commit *commit,
+				     struct patch_ids *ids)
+{
+	return add_commit(commit, ids, 1);
+}
+
+struct patch_id *add_commit_patch_id(struct commit *commit,
+				     struct patch_ids *ids)
+{
+	return add_commit(commit, ids, 0);
+}
diff --git a/patch-ids.h b/patch-ids.h
new file mode 100644
index 0000000..c8c7ca1
--- /dev/null
+++ b/patch-ids.h
@@ -0,0 +1,21 @@
+#ifndef PATCH_IDS_H
+#define PATCH_IDS_H
+
+struct patch_id {
+	unsigned char patch_id[20];
+	char seen;
+};
+
+struct patch_ids {
+	struct diff_options diffopts;
+	int nr, alloc;
+	struct patch_id **table;
+	struct patch_id_bucket *patches;
+};
+
+int init_patch_ids(struct patch_ids *);
+int free_patch_ids(struct patch_ids *);
+struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
+struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
+
+#endif /* PATCH_IDS_H */
-- 
1.5.1.777.gd14d3
