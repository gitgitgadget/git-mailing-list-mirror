Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06C301F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfFXMVq (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:21:46 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.57]:55793 "EHLO mta1.cl.cam.ac.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfFXMVq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:21:46 -0400
X-Greylist: delayed 835 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 08:21:45 EDT
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta1.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-0005z4-Qw; Mon, 24 Jun 2019 12:07:45 +0000
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-0007ET-Oo; Mon, 24 Jun 2019 13:07:45 +0100
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH v3 2/5] revision walk: optionally use sparse reachability
Date:   Mon, 24 Jun 2019 13:07:08 +0100
Message-Id: <20190624120711.27744-3-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add another bit flag to the struct rev_info.

The only caller that uses this after this patch is builtin/pack-objects.
Without this, sparsity seems to do little good therein, as
prepare_revision_walk will densely propagate UNINTERESTING flags from
trees to tree contents, before mark_edges_uninteresting has a chance to
be faster by being sparse.

While here, drop the "sparse" parameter to mark_edges_uninteresting,
introduced in 4f6d26b167 ("list-objects: consume sparse tree walk",
2019-01-16) which can now use the flag in struct rev_info.  No
functional change intended.

Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
---
 bisect.c               | 2 +-
 builtin/pack-objects.c | 3 ++-
 builtin/rev-list.c     | 2 +-
 http-push.c            | 2 +-
 list-objects.c         | 5 ++---
 list-objects.h         | 3 +--
 revision.c             | 3 ++-
 revision.h             | 1 +
 8 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index e87ac29a51..b6ed2b5c92 100644
--- a/bisect.c
+++ b/bisect.c
@@ -658,7 +658,7 @@ static void bisect_common(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
-		mark_edges_uninteresting(revs, NULL, 0);
+		mark_edges_uninteresting(revs, NULL);
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b2be8869c2..afda6064ca 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3136,9 +3136,10 @@ static void get_object_list(int ac, const char **av)
 	if (use_delta_islands)
 		load_delta_islands(the_repository);
 
+	revs.sparse_tree_walk = !!sparse;
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge, sparse);
+	mark_edges_uninteresting(&revs, show_edge);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 660172b014..74658b7344 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -548,7 +548,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
-		mark_edges_uninteresting(&revs, show_edge, 0);
+		mark_edges_uninteresting(&revs, show_edge);
 
 	if (bisect_list) {
 		int reaches, all;
diff --git a/http-push.c b/http-push.c
index e36561a6db..fad6382069 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1934,7 +1934,7 @@ int cmd_main(int argc, const char **argv)
 		pushing = 0;
 		if (prepare_revision_walk(&revs))
 			die("revision walk setup failed");
-		mark_edges_uninteresting(&revs, NULL, 0);
+		mark_edges_uninteresting(&revs, NULL);
 		objects_to_send = get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
diff --git a/list-objects.c b/list-objects.c
index b5651ddd5b..175673cf78 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -264,13 +264,12 @@ static void add_edge_parents(struct commit *commit,
 }
 
 void mark_edges_uninteresting(struct rev_info *revs,
-			      show_edge_fn show_edge,
-			      int sparse)
+			      show_edge_fn show_edge)
 {
 	struct commit_list *list;
 	int i;
 
-	if (sparse) {
+	if (revs->sparse_tree_walk) {
 		struct oidset set;
 		oidset_init(&set, 16);
 
diff --git a/list-objects.h b/list-objects.h
index a952680e46..9388d96785 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -11,8 +11,7 @@ void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, voi
 
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *revs,
-			      show_edge_fn show_edge,
-			      int sparse);
+			      show_edge_fn show_edge);
 
 struct oidset;
 struct list_objects_filter_options;
diff --git a/revision.c b/revision.c
index 621feb9df7..ef523c4a1e 100644
--- a/revision.c
+++ b/revision.c
@@ -458,7 +458,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (!revs->tree_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
-			mark_tree_contents_uninteresting(revs->repo, tree);
+			if (!revs->sparse_tree_walk)
+				mark_tree_contents_uninteresting(revs->repo, tree);
 			return NULL;
 		}
 		add_pending_object_with_path(revs, object, name, mode, path);
diff --git a/revision.h b/revision.h
index 4134dc6029..a7154566b3 100644
--- a/revision.h
+++ b/revision.h
@@ -145,6 +145,7 @@ struct rev_info {
 			first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
+			sparse_tree_walk:1,
 
 			/*
 			 * Blobs are shown without regard for their existence.
-- 
2.17.1

