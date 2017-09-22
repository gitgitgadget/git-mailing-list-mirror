Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640DB20A26
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbdIVUbk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:63539 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdIVUbi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4AED78470B;
        Fri, 22 Sep 2017 16:31:38 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C4ACC8470A;
        Fri, 22 Sep 2017 16:31:37 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 12/13] pack-objects: add object filtering support
Date:   Fri, 22 Sep 2017 20:30:16 +0000
Message-Id: <20170922203017.53986-13-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922203017.53986-6-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach pack-objects to use the filtering provided by the
traverse_commit_list_filtered() interface to omit unwanted
objects from the resulting packfile.

This feature is intended for partial clone/fetch.

Filtering requires the use of the "--stdout" option.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f4a8441..1712d1b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -78,6 +78,8 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static struct object_filter_options filter_options;
+
 /*
  * stats
  */
@@ -2810,7 +2812,12 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+	if (object_filter_enabled(&filter_options))
+		traverse_commit_list_filtered(&filter_options, &revs,
+					      show_commit, show_object,
+					      NULL, NULL);
+	else
+		traverse_commit_list(&revs, show_commit, show_object, NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
@@ -2946,6 +2953,15 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+
+		OPT_PARSE_FILTER_OMIT_ALL_BLOBS(&filter_options),
+		OPT_PARSE_FILTER_OMIT_LARGE_BLOBS(&filter_options),
+		OPT_PARSE_FILTER_USE_BLOB(&filter_options),
+		OPT_PARSE_FILTER_USE_PATH(&filter_options),
+		/* not needed: OPT_PARSE_FILTER_PRINT_MISSING */
+		/* not needed: OPT_PARSE_FILTER_PRINT_OMITTED */
+		/* not needed: OPT_PARSE_FILTER_RELAX */
+
 		OPT_END(),
 	};
 
@@ -3022,6 +3038,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
+	if (object_filter_enabled(&filter_options)) {
+		if (!pack_to_stdout)
+			die("cannot use filtering with an indexable pack.");
+		use_bitmap_index = 0;
+	}
+
 	/*
 	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
 	 *
-- 
2.9.3

