Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D51202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdGMRfl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:11037 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752610AbdGMRfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CC714844E5;
        Thu, 13 Jul 2017 13:35:38 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2AB84844E3;
        Thu, 13 Jul 2017 13:35:38 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 11/19] pack-objects: add object filtering support
Date:   Thu, 13 Jul 2017 17:34:51 +0000
Message-Id: <20170713173459.3559-12-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach pack-objects to use filtering provided by the
traverse_commit_list_filtered() interface to omit
unwanted objects from the result.

This feature is intended for narrow/partial clone/fetch.

Filtering requires use of "--stdout" option.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 50e01aa..614ad60 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -14,6 +14,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filters.h"
+#include "object-filter.h"
 #include "pack-objects.h"
 #include "progress.h"
 #include "refs.h"
@@ -77,6 +79,8 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static struct object_filter_options filter_options;
+
 /*
  * stats
  */
@@ -2800,7 +2804,20 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+
+	if (filter_options.omit_all_blobs)
+		traverse_commit_list_omit_all_blobs(
+			&revs, show_commit, show_object, NULL, NULL);
+	else if (filter_options.omit_large_blobs)
+		traverse_commit_list_omit_large_blobs(
+			&revs, show_commit, show_object, NULL, NULL,
+			(int64_t)(uint64_t)filter_options.large_byte_limit);
+	else if (filter_options.use_sparse)
+		traverse_commit_list_use_sparse(
+			&revs, show_commit, show_object, NULL, NULL,
+			&filter_options.sparse_oid);
+	else
+		traverse_commit_list(&revs, show_commit, show_object, NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
@@ -2936,6 +2953,14 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+
+		OPT_PARSE_FILTER_OMIT_ALL_BLOBS(&filter_options),
+		OPT_PARSE_FILTER_OMIT_LARGE_BLOBS(&filter_options),
+		OPT_PARSE_FILTER_USE_SPARSE(&filter_options),
+
+		/* OPT_PARSE_FILTER_PRINT_MANIFEST(&filter_options), */
+		/* OPT_PARSE_FILTER_RELAX(&filter_options), */
+
 		OPT_END(),
 	};
 
@@ -3007,6 +3032,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
+	if (!pack_to_stdout && object_filter_enabled(&filter_options))
+		die("object filtering cannot be used when building an indexable pack.");
+
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
@@ -3031,6 +3059,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
 		use_bitmap_index = 0;
 
+	if (object_filter_enabled(&filter_options))
+		use_bitmap_index = 0;
+
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
-- 
2.9.3

