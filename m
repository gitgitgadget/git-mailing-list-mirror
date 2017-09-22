Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC321202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbdIVU1K (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:27:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:27082 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbdIVU1D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:27:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B9D698470A;
        Fri, 22 Sep 2017 16:27:02 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4013684706;
        Fri, 22 Sep 2017 16:27:02 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: [PATCH 03/13] list-objects: filter objects in traverse_commit_list
Date:   Fri, 22 Sep 2017 20:26:22 +0000
Message-Id: <20170922202632.53714-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922202632.53714-1-git@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create traverse_commit_list_filtered() and add filtering
interface to allow certain objects to be omitted (not shown)
during a traversal.

Update traverse_commit_list() to be a wrapper for the above.

Filtering will be used in a future commit by rev-list and
pack-objects for narrow/partial clone/fetch to omit certain
blobs from the output.

traverse_bitmap_commit_list() does not work with filtering.
If a packfile bitmap is present, it will not be used.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 list-objects.c | 66 ++++++++++++++++++++++++++++++++++++++++++++--------------
 list-objects.h | 30 ++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index b3931fa..3e86008 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -13,10 +13,13 @@ static void process_blob(struct rev_info *revs,
 			 show_object_fn show,
 			 struct strbuf *path,
 			 const char *name,
-			 void *cb_data)
+			 void *cb_data,
+			 filter_object_fn filter,
+			 void *filter_data)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
+	list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_SHOW;
 
 	if (!revs->blob_objects)
 		return;
@@ -24,11 +27,15 @@ static void process_blob(struct rev_info *revs,
 		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	obj->flags |= SEEN;
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	show(obj, path->buf, cb_data);
+	if (filter)
+		r = filter(LOFT_BLOB, obj, path->buf, &path->buf[pathlen], filter_data);
+	if (r & LOFR_MARK_SEEN)
+		obj->flags |= SEEN;
+	if (r & LOFR_SHOW)
+		show(obj, path->buf, cb_data);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -69,7 +76,9 @@ static void process_tree(struct rev_info *revs,
 			 show_object_fn show,
 			 struct strbuf *base,
 			 const char *name,
-			 void *cb_data)
+			 void *cb_data,
+			 filter_object_fn filter,
+			 void *filter_data)
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
@@ -77,6 +86,7 @@ static void process_tree(struct rev_info *revs,
 	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
+	list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_SHOW;
 
 	if (!revs->tree_objects)
 		return;
@@ -90,9 +100,13 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
-	obj->flags |= SEEN;
 	strbuf_addstr(base, name);
-	show(obj, base->buf, cb_data);
+	if (filter)
+		r = filter(LOFT_BEGIN_TREE, obj, base->buf, &base->buf[baselen], filter_data);
+	if (r & LOFR_MARK_SEEN)
+		obj->flags |= SEEN;
+	if (r & LOFR_SHOW)
+		show(obj, base->buf, cb_data);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -112,7 +126,7 @@ static void process_tree(struct rev_info *revs,
 			process_tree(revs,
 				     lookup_tree(entry.oid),
 				     show, base, entry.path,
-				     cb_data);
+				     cb_data, filter, filter_data);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.oid->hash,
 					show, base, entry.path,
@@ -121,8 +135,17 @@ static void process_tree(struct rev_info *revs,
 			process_blob(revs,
 				     lookup_blob(entry.oid),
 				     show, base, entry.path,
-				     cb_data);
+				     cb_data, filter, filter_data);
 	}
+
+	if (filter) {
+		r = filter(LOFT_END_TREE, obj, base->buf, &base->buf[baselen], filter_data);
+		if (r & LOFR_MARK_SEEN)
+			obj->flags |= SEEN;
+		if (r & LOFR_SHOW)
+			show(obj, base->buf, cb_data);
+	}
+
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
 }
@@ -183,10 +206,10 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *data)
+void traverse_commit_list_worker(
+	struct rev_info *revs,
+	show_commit_fn show_commit, show_object_fn show_object, void *show_data,
+	filter_object_fn filter, void *filter_data)
 {
 	int i;
 	struct commit *commit;
@@ -200,7 +223,7 @@ void traverse_commit_list(struct rev_info *revs,
 		 */
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
-		show_commit(commit, data);
+		show_commit(commit, show_data);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
@@ -211,19 +234,19 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			show_object(obj, name, data);
+			show_object(obj, name, show_data);
 			continue;
 		}
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     &base, path, data);
+				     &base, path, show_data, filter, filter_data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     &base, path, data);
+				     &base, path, show_data, filter, filter_data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
@@ -232,3 +255,14 @@ void traverse_commit_list(struct rev_info *revs,
 	object_array_clear(&revs->pending);
 	strbuf_release(&base);
 }
+
+void traverse_commit_list(struct rev_info *revs,
+			  show_commit_fn show_commit,
+			  show_object_fn show_object,
+			  void *show_data)
+{
+	traverse_commit_list_worker(
+		revs,
+		show_commit, show_object, show_data,
+		NULL, NULL);
+}
diff --git a/list-objects.h b/list-objects.h
index 0cebf85..39fcbb5 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -8,4 +8,34 @@ void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, voi
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
 
+enum list_objects_filter_result {
+	LOFR_ZERO      = 0,
+	LOFR_MARK_SEEN = 1<<0,
+	LOFR_SHOW      = 1<<1,
+};
+
+/* See object.h and revision.h */
+#define FILTER_REVISIT (1<<25)
+
+enum list_objects_filter_type {
+	LOFT_BEGIN_TREE,
+	LOFT_END_TREE,
+	LOFT_BLOB
+};
+
+typedef enum list_objects_filter_result list_objects_filter_result;
+typedef enum list_objects_filter_type list_objects_filter_type;
+
+typedef list_objects_filter_result (*filter_object_fn)(
+	list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data);
+
+void traverse_commit_list_worker(
+	struct rev_info *,
+	show_commit_fn, show_object_fn, void *show_data,
+	filter_object_fn filter, void *filter_data);
+
 #endif
-- 
2.9.3

