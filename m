From: Jeff King <peff@peff.net>
Subject: [PATCH v2 16/25] pack-objects: match prune logic for discarding
 objects
Date: Wed, 15 Oct 2014 18:42:09 -0400
Message-ID: <20141015224209.GP25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:42:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXGq-00008M-5u
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbaJOWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:42:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:58993 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751173AbaJOWmM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:42:12 -0400
Received: (qmail 2559 invoked by uid 102); 15 Oct 2014 22:42:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:42:12 -0500
Received: (qmail 28152 invoked by uid 107); 15 Oct 2014 22:42:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:42:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:42:09 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent commit taught git-prune to keep non-recent objects
that are reachable from recent ones. However, pack-objects,
when loosening unreachable objects, tries to optimize out
the write in the case that the object will be immediately
pruned. It now gets this wrong, since its rule does not
reflect the new prune code (and this can be seen by running
t6501 with a strategically placed repack).

Let's teach pack-objects similar logic.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c     | 39 +++++++++++++++++++
 reachable.c                |  4 +-
 reachable.h                |  2 +
 t/t6501-freshen-objects.sh | 93 +++++++++++++++++++++++++++-------------------
 4 files changed, 98 insertions(+), 40 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2fe2ab0..4df9499 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -20,6 +20,8 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "pack-bitmap.h"
+#include "reachable.h"
+#include "sha1-array.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
@@ -2407,6 +2409,15 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 	return 0;
 }
 
+/*
+ * Store a list of sha1s that are should not be discarded
+ * because they are either written too recently, or are
+ * reachable from another object that was.
+ *
+ * This is filled by get_object_list.
+ */
+static struct sha1_array recent_objects;
+
 static int loosened_object_can_be_discarded(const unsigned char *sha1,
 					    unsigned long mtime)
 {
@@ -2414,6 +2425,8 @@ static int loosened_object_can_be_discarded(const unsigned char *sha1,
 		return 0;
 	if (mtime > unpack_unreachable_expiration)
 		return 0;
+	if (sha1_array_lookup(&recent_objects, sha1) >= 0)
+		return 0;
 	return 1;
 }
 
@@ -2470,6 +2483,19 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	return 0;
 }
 
+static void record_recent_object(struct object *obj,
+				 const struct name_path *path,
+				 const char *last,
+				 void *data)
+{
+	sha1_array_append(&recent_objects, obj->sha1);
+}
+
+static void record_recent_commit(struct commit *commit, void *data)
+{
+	sha1_array_append(&recent_objects, commit->object.sha1);
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
@@ -2517,10 +2543,23 @@ static void get_object_list(int ac, const char **av)
 	mark_edges_uninteresting(&revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object, NULL);
 
+	if (unpack_unreachable_expiration) {
+		revs.ignore_missing_links = 1;
+		if (add_unseen_recent_objects_to_traversal(&revs,
+				unpack_unreachable_expiration))
+			die("unable to add recent objects");
+		if (prepare_revision_walk(&revs))
+			die("revision walk setup failed");
+		traverse_commit_list(&revs, record_recent_commit,
+				     record_recent_object, NULL);
+	}
+
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
 	if (unpack_unreachable)
 		loosen_unused_packed_objects(&revs);
+
+	sha1_array_clear(&recent_objects);
 }
 
 static int option_parse_index_version(const struct option *opt,
diff --git a/reachable.c b/reachable.c
index 55589a0..0176a88 100644
--- a/reachable.c
+++ b/reachable.c
@@ -183,8 +183,8 @@ static int add_recent_packed(const unsigned char *sha1,
 	return 0;
 }
 
-static int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-						  unsigned long timestamp)
+int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
+					   unsigned long timestamp)
 {
 	struct recent_data data;
 	int r;
diff --git a/reachable.h b/reachable.h
index 141fe30..d23efc3 100644
--- a/reachable.h
+++ b/reachable.h
@@ -2,6 +2,8 @@
 #define REACHEABLE_H
 
 struct progress;
+extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
+						  unsigned long timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 				   unsigned long mark_recent, struct progress *);
 
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index de941c2..e25c47d 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -39,50 +39,67 @@ commit () {
 	git commit -m "$1"
 }
 
-test_expect_success 'disable reflogs' '
-	git config core.logallrefupdates false &&
-	rm -rf .git/logs
-'
+maybe_repack () {
+	if test -n "$repack"; then
+		git repack -ad
+	fi
+}
+
+for repack in '' true; do
+	title=${repack:+repack}
+	title=${title:-loose}
+
+	test_expect_success "make repo completely empty ($title)" '
+		rm -rf .git &&
+		git init
+	'
+
+	test_expect_success "disable reflogs ($title)" '
+		git config core.logallrefupdates false &&
+		rm -rf .git/logs
+	'
 
-test_expect_success 'setup basic history' '
-	commit base
-'
+	test_expect_success "setup basic history ($title)" '
+		commit base
+	'
 
-test_expect_success 'create and abandon some objects' '
-	git checkout -b experiment &&
-	commit abandon &&
-	git checkout master &&
-	git branch -D experiment
-'
+	test_expect_success "create and abandon some objects ($title)" '
+		git checkout -b experiment &&
+		commit abandon &&
+		maybe_repack &&
+		git checkout master &&
+		git branch -D experiment
+	'
 
-test_expect_success 'simulate time passing' '
-	find .git/objects -type f |
-	xargs test-chmtime -v -86400
-'
+	test_expect_success "simulate time passing ($title)" '
+		find .git/objects -type f |
+		xargs test-chmtime -v -86400
+	'
 
-test_expect_success 'start writing new commit with old blob' '
-	tree=$(
-		GIT_INDEX_FILE=index.tmp &&
-		export GIT_INDEX_FILE &&
-		git read-tree HEAD &&
-		add unrelated &&
-		add abandon &&
-		git write-tree
-	)
-'
+	test_expect_success "start writing new commit with old blob ($title)" '
+		tree=$(
+			GIT_INDEX_FILE=index.tmp &&
+			export GIT_INDEX_FILE &&
+			git read-tree HEAD &&
+			add unrelated &&
+			add abandon &&
+			git write-tree
+		)
+	'
 
-test_expect_success 'simultaneous gc' '
-	git gc --prune=12.hours.ago
-'
+	test_expect_success "simultaneous gc ($title)" '
+		git gc --prune=12.hours.ago
+	'
 
-test_expect_success 'finish writing out commit' '
-	commit=$(echo foo | git commit-tree -p HEAD $tree) &&
-	git update-ref HEAD $commit
-'
+	test_expect_success "finish writing out commit ($title)" '
+		commit=$(echo foo | git commit-tree -p HEAD $tree) &&
+		git update-ref HEAD $commit
+	'
 
-# "abandon" blob should have been rescued by reference from new tree
-test_expect_success 'repository passes fsck' '
-	git fsck
-'
+	# "abandon" blob should have been rescued by reference from new tree
+	test_expect_success "repository passes fsck ($title)" '
+		git fsck
+	'
+done
 
 test_done
-- 
2.1.2.596.g7379948
