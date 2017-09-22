Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02742202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdIVUb2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:23332 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbdIVUb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AF4448470A;
        Fri, 22 Sep 2017 16:31:27 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 34E7B84709;
        Fri, 22 Sep 2017 16:31:27 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 08/13] list-objects: add traverse_commit_list_filtered method
Date:   Fri, 22 Sep 2017 20:30:12 +0000
Message-Id: <20170922203017.53986-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922203017.53986-6-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add traverse_commit_list_filtered() wrapper around the various
filter methods using common data in object_filter_options.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 list-objects.c | 34 ++++++++++++++++++++++++++++++++++
 list-objects.h | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/list-objects.c b/list-objects.c
index 3e86008..0f063d9 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -7,6 +7,9 @@
 #include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filter-all.h"
+#include "list-objects-filter-large.h"
+#include "list-objects-filter-sparse.h"
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
@@ -266,3 +269,34 @@ void traverse_commit_list(struct rev_info *revs,
 		show_commit, show_object, show_data,
 		NULL, NULL);
 }
+
+void traverse_commit_list_filtered(
+	struct object_filter_options *filter_options,
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *show_data)
+{
+	if (filter_options->omit_all_blobs)
+		traverse_commit_list_omit_all_blobs(
+			revs, show_commit, show_object, print_omitted_object, show_data);
+
+	else if (filter_options->omit_large_blobs)
+		traverse_commit_list_omit_large_blobs(
+			revs, show_commit, show_object, print_omitted_object, show_data,
+			(int64_t)(uint64_t)filter_options->large_byte_limit);
+
+	else if (filter_options->use_blob)
+		traverse_commit_list_use_blob(
+			revs, show_commit, show_object, print_omitted_object, show_data,
+			&filter_options->sparse_oid);
+
+	else if (filter_options->use_path)
+		traverse_commit_list_use_path(
+			revs, show_commit, show_object, print_omitted_object, show_data,
+			filter_options->sparse_value);
+
+	else
+		die("unspecified list-objects filter");
+}
diff --git a/list-objects.h b/list-objects.h
index 39fcbb5..a8acedc 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -1,6 +1,9 @@
 #ifndef LIST_OBJECTS_H
 #define LIST_OBJECTS_H
 
+#include "oidset2.h"
+#include "object-filter.h"
+
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
@@ -38,4 +41,12 @@ void traverse_commit_list_worker(
 	show_commit_fn, show_object_fn, void *show_data,
 	filter_object_fn filter, void *filter_data);
 
+void traverse_commit_list_filtered(
+	struct object_filter_options *filter_options,
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *show_data);
+
 #endif
-- 
2.9.3

