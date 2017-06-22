Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541EA20802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbdFVUgY (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:36:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:20239 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdFVUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:36:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7327D84596;
        Thu, 22 Jun 2017 16:36:22 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D6A0D8458F;
        Thu, 22 Jun 2017 16:36:21 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 2/3] pack-objects: WIP add max-blob-size filtering
Date:   Thu, 22 Jun 2017 20:36:14 +0000
Message-Id: <20170622203615.34135-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170622203615.34135-1-git@jeffhostetler.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach pack-objects command to accept --max-blob-size=<n> argument
and use a traverse_commit_list filter-proc to omit unwanted blobs
from the resulting packfile.

This filter-proc always includes special files matching ".git*"
(such as ".gitignore") and blobs smaller than <n>.  <n> is a
magnitude value and accepts [kmg] suffixes.  A value of zero
can be used to omit all blobs (except for special files).

There are 2 placeholder TODOs in this code to talk about building
an omitted-blob list for the client.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 50e01aa..cdcd4d6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -77,6 +77,8 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static signed long max_blob_size = -1;
+
 /*
  * stats
  */
@@ -2519,6 +2521,7 @@ static void read_object_list_from_stdin(void)
 }
 
 #define OBJECT_ADDED (1u<<20)
+#define BLOB_OMITTED (1u<<21)
 
 static void show_commit(struct commit *commit, void *data)
 {
@@ -2536,6 +2539,70 @@ static void show_object(struct object *obj, const char *name, void *data)
 	obj->flags |= OBJECT_ADDED;
 }
 
+/*
+ * Filter blobs by pathname or size.
+ * Return 1 to mark the blob SEEN so that it will not be reported again.
+ * Return 0 to allow it to be presented again.
+ */
+static int filter_blob(
+	struct object *obj,
+	const char *pathname,
+	const char *entryname,
+	void *data)
+{
+	assert(obj->type == OBJ_BLOB);
+	assert((obj->flags & SEEN) == 0);
+	assert((obj->flags & OBJECT_ADDED) == 0);
+	assert(max_blob_size >= 0);
+
+	/*
+	 * Always include blobs for special files of the form ".git*".
+	 */
+	if ((strncmp(entryname, ".git", 4) == 0) && entryname[4]) {
+		if (obj->flags & BLOB_OMITTED) {
+			/*
+			 * TODO
+			 * TODO Remove this blob from the omitted blob list.
+			 * TODO
+			 */
+			obj->flags &= ~BLOB_OMITTED;
+		}
+		show_object(obj, pathname, data);
+		return 1;
+	}
+
+	/*
+	 * We already know the blob is too big because it was previously
+	 * omitted.  We still don't want it yet.  DO NOT mark it SEEN
+	 * in case it is associated with a ".git*" path in another tree
+	 * or commit.
+	 */
+	if (obj->flags & BLOB_OMITTED)
+		return 0;
+
+	/*
+	 * We only want blobs that are LESS THAN the maximum.
+	 * This allows zero to mean NO BLOBS.
+	 */
+	if (max_blob_size > 0) {
+		unsigned long s;
+		enum object_type t = sha1_object_info(obj->oid.hash, &s);
+		assert(t == OBJ_BLOB);
+		if (s < max_blob_size) {
+			show_object(obj, pathname, data);
+			return 1;
+		}
+	}
+
+	/*
+	 * TODO
+	 * TODO (Provisionally) add this blob to the omitted blob list.
+	 * TODO
+	 */
+	obj->flags |= BLOB_OMITTED;
+	return 0;
+}
+
 static void show_edge(struct commit *commit)
 {
 	add_preferred_base(commit->object.oid.hash);
@@ -2800,7 +2867,12 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+
+	if (max_blob_size == -1)
+		traverse_commit_list(&revs, show_commit, show_object, NULL);
+	else
+		traverse_commit_list_filtered(&revs, show_commit, show_object,
+			filter_blob, NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
@@ -2936,6 +3008,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_MAGNITUDE(0, "max-blob-size", (unsigned long *)&max_blob_size,
+					  N_("omit large blobs from packfile")),
 		OPT_END(),
 	};
 
-- 
2.9.3

