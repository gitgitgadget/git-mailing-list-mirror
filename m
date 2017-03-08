Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C3E202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbdCHUrb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:47:31 -0500
Received: from siwi.pair.com ([209.68.5.199]:47620 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754298AbdCHUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:47:29 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9199E84602;
        Wed,  8 Mar 2017 13:51:01 -0500 (EST)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 02/10] pack-objects: add --partial-by-size=n --partial-special
Date:   Wed,  8 Mar 2017 18:50:31 +0000
Message-Id: <1488999039-37631-3-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Teach pack-objects to omit blobs from the generated packfile.

When the --partial-by-size=n[kmg] argument is used, only blobs
smaller than the requested size are included.  When n is zero,
no blobs are included.

When the --partial-special argument is used, git special files,
such as ".gitattributes" and ".gitignores" are included.

When both are given, the union of two are included.

This is intended to be used in a partial clone or fetch.
(This has also been called sparse- or lazy-clone.)

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7e052bb..2df2f49 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -77,6 +77,10 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static signed long partial_by_size = -1;
+static int partial_special = 0;
+static struct trace_key trace_partial = TRACE_KEY_INIT(PARTIAL);
+
 /*
  * stats
  */
@@ -2532,6 +2536,54 @@ static void show_object(struct object *obj, const char *name, void *data)
 	obj->flags |= OBJECT_ADDED;
 }
 
+/*
+ * If ANY --partial-* option was given, we want to OMIT all
+ * blobs UNLESS they match one of our patterns.  We treat
+ * the options as OR's so that we get the resulting UNION.
+ */
+static void show_object_partial(struct object *obj, const char *name, void *data)
+{
+	unsigned long s = 0;
+
+	if (obj->type != OBJ_BLOB)
+		goto include_it;
+
+	/*
+	 * When (partial_by_size == 0), we want to OMIT all blobs.
+	 * When (partial_by_size >  0), we want blobs smaller than that.
+	 */
+	if (partial_by_size > 0) {
+		enum object_type t = sha1_object_info(obj->oid.hash, &s);
+		assert(t == OBJ_BLOB);
+		if (s < partial_by_size)
+			goto include_it;
+	}
+
+	/*
+	 * When (partial_special), we want the .git* special files.
+	 */
+	if (partial_special) {
+		if (strcmp(name, GITATTRIBUTES_FILE) == 0 ||
+			strcmp(name, ".gitignore") == 0)
+			goto include_it;
+		else {
+			const char *last_slash = strrchr(name, '/');
+			if (last_slash)
+				if (strcmp(last_slash+1, GITATTRIBUTES_FILE) == 0 ||
+					strcmp(last_slash+1, ".gitignore") == 0)
+					goto include_it;
+		}
+	}
+
+	trace_printf_key(
+		&trace_partial, "omitting blob '%s' %"PRIuMAX" '%s'\n",
+		oid_to_hex(&obj->oid), (uintmax_t)s, name);
+	return;
+
+include_it:
+	show_object(obj, name, data);
+}
+
 static void show_edge(struct commit *commit)
 {
 	add_preferred_base(commit->object.oid.hash);
@@ -2794,7 +2846,11 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+
+	if (partial_by_size >= 0 || partial_special)
+		traverse_commit_list(&revs, show_commit, show_object_partial, NULL);
+	else
+		traverse_commit_list(&revs, show_commit, show_object, NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
@@ -2930,6 +2986,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_MAGNITUDE(0, "partial-by-size", (unsigned long *)&partial_by_size,
+			 N_("only include blobs smaller than size in result")),
+		OPT_BOOL(0, "partial-special", &partial_special,
+			 N_("only include blobs for git special files")),
 		OPT_END(),
 	};
 
-- 
2.7.4

