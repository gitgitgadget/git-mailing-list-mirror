Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E686520802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdFVUg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:36:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:48166 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdFVUgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:36:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B044A84593;
        Thu, 22 Jun 2017 16:36:21 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1FE168458F;
        Thu, 22 Jun 2017 16:36:21 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/3] list-objects: add filter_blob to traverse_commit_list
Date:   Thu, 22 Jun 2017 20:36:13 +0000
Message-Id: <20170622203615.34135-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170622203615.34135-1-git@jeffhostetler.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

In preparation for partial/sparse clone/fetch where the
server is allowed to omit large/all blobs from the packfile,
teach traverse_commit_list() to take a blob filter-proc that
controls when blobs are shown and marked as SEEN.

Normally, traverse_commit_list() always marks visited blobs
as SEEN, so that the show_object() callback will never see
duplicates.  Since a single blob OID may be referenced by
multiple pathnames, we may not be able to decide if a blob
should be excluded until later pathnames have been traversed.
With the filter-proc, the automatic deduping is disabled.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 list-objects.c | 39 +++++++++++++++++++++++++++++++++++----
 list-objects.h |  8 ++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index f3ca6aa..c9ca81c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -11,6 +11,7 @@
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
 			 show_object_fn show,
+			 filter_blob_fn filter_blob,
 			 struct strbuf *path,
 			 const char *name,
 			 void *cb_data)
@@ -24,11 +25,28 @@ static void process_blob(struct rev_info *revs,
 		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	obj->flags |= SEEN;
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	show(obj, path->buf, cb_data);
+	if (!filter_blob) {
+		/*
+		 * Normal processing is to imediately dedup blobs
+		 * during commit traversal, regardless of how many
+		 * times it appears in a single or multiple commits,
+		 * so we always set SEEN.
+		 */
+		obj->flags |= SEEN;
+		show(obj, path->buf, cb_data);
+	} else {
+		/*
+		 * Use the filter-proc to decide whether to show
+		 * the blob.  We only set SEEN if requested.  For
+		 * example, this could be used to omit a specific
+		 * blob until it appears with a ".git*" entryname.
+		 */
+		if (filter_blob(obj, path->buf, &path->buf[pathlen], cb_data))
+			obj->flags |= SEEN;
+	}
 	strbuf_setlen(path, pathlen);
 }
 
@@ -67,6 +85,7 @@ static void process_gitlink(struct rev_info *revs,
 static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
 			 show_object_fn show,
+			 filter_blob_fn filter_blob,
 			 struct strbuf *base,
 			 const char *name,
 			 void *cb_data)
@@ -111,7 +130,7 @@ static void process_tree(struct rev_info *revs,
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.oid->hash),
-				     show, base, entry.path,
+				     show, filter_blob, base, entry.path,
 				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.oid->hash,
@@ -120,7 +139,7 @@ static void process_tree(struct rev_info *revs,
 		else
 			process_blob(revs,
 				     lookup_blob(entry.oid->hash),
-				     show, base, entry.path,
+				     show, filter_blob, base, entry.path,
 				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
@@ -188,6 +207,16 @@ void traverse_commit_list(struct rev_info *revs,
 			  show_object_fn show_object,
 			  void *data)
 {
+	traverse_commit_list_filtered(revs, show_commit, show_object, NULL, data);
+}
+
+void traverse_commit_list_filtered(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	filter_blob_fn filter_blob,
+	void *data)
+{
 	int i;
 	struct commit *commit;
 	struct strbuf base;
@@ -218,11 +247,13 @@ void traverse_commit_list(struct rev_info *revs,
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
+				     filter_blob,
 				     &base, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
+				     filter_blob,
 				     &base, path, data);
 			continue;
 		}
diff --git a/list-objects.h b/list-objects.h
index 0cebf85..7f823aa 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -3,7 +3,15 @@
 
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *);
+typedef int  (*filter_blob_fn)(struct object *, const char *, const char *, void *);
+
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
+void traverse_commit_list_filtered(
+    struct rev_info *revs,
+    show_commit_fn show_commit,
+    show_object_fn show_object,
+    filter_blob_fn filter_blob,
+    void *data);
 
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
-- 
2.9.3

