Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D946C211B5
	for <e@80x24.org>; Thu, 14 Feb 2019 04:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbfBNEfZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 23:35:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:43616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388518AbfBNEfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 23:35:24 -0500
Received: (qmail 30136 invoked by uid 109); 14 Feb 2019 04:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 04:35:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6323 invoked by uid 111); 14 Feb 2019 04:35:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 23:35:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 23:35:22 -0500
Date:   Wed, 13 Feb 2019 23:35:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] prune: lazily perform reachability traversal
Message-ID: <20190214043522.GA19183@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214043127.GA19019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The general strategy of "git prune" is to do a full reachability walk,
then for each loose object see if we found it in our walk. But if we
don't have any loose objects, we don't need to do the expensive walk in
the first place.

This patch postpones that walk until the first time we need to see its
results.

Note that this is really a specific case of a more general optimization,
which is that we could traverse only far enough to find the object under
consideration (i.e., stop the traversal when we find it, then pick up
again when asked about the next object, etc). That could save us in some
instances from having to do a full walk. But it's actually a bit tricky
to do with our traversal code, and you'd need to do a full walk anyway
if you have even a single unreachable object (which you generally do, if
any objects are actually left after running git-repack).

So in practice this lazy-load of the full walk catches one easy but
common case (i.e., you've just repacked via git-gc, and there's nothing
unreachable).

The perf script is fairly contrived, but it does show off the
improvement:

  Test                            HEAD^             HEAD
  -------------------------------------------------------------------------
  5304.4: prune with no objects   3.66(3.60+0.05)   0.00(0.00+0.00) -100.0%

and would let us know if we accidentally regress this optimization.

Note also that we need to take special care with prune_shallow(), which
relies on us having performed the traversal. So this optimization can
only kick in for a non-shallow repository. Since this is easy to get
wrong and is not covered by existing tests, let's add an extra test to
t5304 that covers this case explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff looks nice with --color-moved. I wish there was a way to
communicate that information in a plaintext email.

 builtin/prune.c       | 43 ++++++++++++++++++++++++++++++++-----------
 t/perf/p5304-prune.sh | 24 ++++++++++++++++++++++++
 t/t5304-prune.sh      | 12 ++++++++++++
 3 files changed, 68 insertions(+), 11 deletions(-)
 create mode 100755 t/perf/p5304-prune.sh

diff --git a/builtin/prune.c b/builtin/prune.c
index 1ec9ddd751..04b6573945 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -31,16 +31,40 @@ static int prune_tmp_file(const char *fullpath)
 	return 0;
 }
 
-static int prune_object(const struct object_id *oid, const char *fullpath,
-			void *data)
+static void perform_reachability_traversal(struct rev_info *revs)
 {
-	struct stat st;
+	static int initialized;
+	struct progress *progress = NULL;
+
+	if (initialized)
+		return;
+
+	if (show_progress)
+		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	mark_reachable_objects(revs, 1, expire, progress);
+	stop_progress(&progress);
+	initialized = 1;
+}
+
+static int is_object_reachable(const struct object_id *oid,
+			       struct rev_info *revs)
+{
+	perform_reachability_traversal(revs);
 
 	/*
 	 * Do we know about this object?
 	 * It must have been reachable
 	 */
-	if (lookup_object(the_repository, oid->hash))
+	return !!lookup_object(the_repository, oid->hash);
+}
+
+static int prune_object(const struct object_id *oid, const char *fullpath,
+			void *data)
+{
+	struct rev_info *revs = data;
+	struct stat st;
+
+	if (is_object_reachable(oid, revs))
 		return 0;
 
 	if (lstat(fullpath, &st)) {
@@ -102,7 +126,6 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct progress *progress = NULL;
 	int exclude_promisor_objects = 0;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -142,17 +165,13 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	if (show_progress == -1)
 		show_progress = isatty(2);
-	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
 	if (exclude_promisor_objects) {
 		fetch_if_missing = 0;
 		revs.exclude_promisor_objects = 1;
 	}
 
-	mark_reachable_objects(&revs, 1, expire, progress);
-	stop_progress(&progress);
 	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
-				      prune_cruft, prune_subdir, NULL);
+				      prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
 	remove_temporary_files(get_object_directory());
@@ -160,8 +179,10 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	remove_temporary_files(s);
 	free(s);
 
-	if (is_repository_shallow(the_repository))
+	if (is_repository_shallow(the_repository)) {
+		perform_reachability_traversal(&revs);
 		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
+	}
 
 	return 0;
 }
diff --git a/t/perf/p5304-prune.sh b/t/perf/p5304-prune.sh
new file mode 100755
index 0000000000..3c852084eb
--- /dev/null
+++ b/t/perf/p5304-prune.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='performance tests of prune'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'remove reachable loose objects' '
+	git repack -ad
+'
+
+test_expect_success 'remove unreachable loose objects' '
+	git prune
+'
+
+test_expect_success 'confirm there are no loose objects' '
+	git count-objects | grep ^0
+'
+
+test_perf 'prune with no objects' '
+	git prune
+'
+
+test_done
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 270da21ac3..2c19a790c1 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -274,6 +274,18 @@ test_expect_success 'prune .git/shallow' '
 	test_path_is_missing .git/shallow
 '
 
+test_expect_success 'prune .git/shallow when there are no loose objects' '
+	SHA1=$(echo hi|git commit-tree HEAD^{tree}) &&
+	echo $SHA1 >.git/shallow &&
+	git update-ref refs/heads/shallow-tip $SHA1 &&
+	git repack -ad &&
+	# verify assumption that all loose objects are gone
+	git count-objects | grep ^0 &&
+	git prune &&
+	echo $SHA1 >expect &&
+	test_cmp expect .git/shallow
+'
+
 test_expect_success 'prune: handle alternate object database' '
 	test_create_repo A &&
 	git -C A commit --allow-empty -m "initial commit" &&
-- 
2.21.0.rc0.586.gffba1126a0

