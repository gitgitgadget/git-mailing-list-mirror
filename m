Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AEC81FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdJXSyS (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:42893 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbdJXSyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:54:06 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5B4E8845A8;
        Tue, 24 Oct 2017 14:54:06 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BC14F84597;
        Tue, 24 Oct 2017 14:54:05 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 12/13] pack-objects: add list-objects filtering
Date:   Tue, 24 Oct 2017 18:53:31 +0000
Message-Id: <20171024185332.57261-13-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
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
 Documentation/git-pack-objects.txt |  8 +++++++-
 builtin/pack-objects.c             | 18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 473a161..8b4a223 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--stdout | base-name]
+	[--revs [--unpacked | --all]]
+	[--stdout [--filter=<filter-spec>] | base-name]
 	[--shallow] [--keep-true-parents] < object-list
 
 
@@ -236,6 +237,11 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
 
+--filter=<filter-spec>::
+	Requires `--stdout`.  Omits certain objects (usually blobs) from
+	the resulting packfile.  See linkgit:git-rev-list[1] for valid
+	`<filter-spec>` forms.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6e77dfd..a251850 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -79,6 +79,8 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static struct list_objects_filter_options filter_options;
+
 /*
  * stats
  */
@@ -2816,7 +2818,12 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+	if (filter_options.choice)
+		traverse_commit_list_filtered(&filter_options, &revs,
+					      show_commit, show_object,
+					      NULL, NULL);
+	else
+		traverse_commit_list(&revs, show_commit, show_object, NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
@@ -2952,6 +2959,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+
 		OPT_END(),
 	};
 
@@ -3028,6 +3038,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
+	if (filter_options.choice) {
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

