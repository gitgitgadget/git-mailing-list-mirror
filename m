Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E401FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdJXSyG (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:42886 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdJXSyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:54:04 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3D6E2845A8;
        Tue, 24 Oct 2017 14:54:03 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A031784597;
        Tue, 24 Oct 2017 14:54:02 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 08/13] list-objects: add traverse_commit_list_filtered method
Date:   Tue, 24 Oct 2017 18:53:27 +0000
Message-Id: <20171024185332.57261-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add traverse_commit_list_filtered() wrapper around the various
filter methods using common data in object_filter_options.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 list-objects.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 list-objects.h | 11 +++++++++++
 2 files changed, 56 insertions(+)

diff --git a/list-objects.c b/list-objects.c
index 3e86008..4ce2593 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -7,6 +7,9 @@
 #include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filter-blobs-none.h"
+#include "list-objects-filter-blobs-limit.h"
+#include "list-objects-filter-sparse.h"
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
@@ -266,3 +269,45 @@ void traverse_commit_list(struct rev_info *revs,
 		show_commit, show_object, show_data,
 		NULL, NULL);
 }
+
+void traverse_commit_list_filtered(
+	struct list_objects_filter_options *filter_options,
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	list_objects_filter_map_foreach_cb print_omitted_object,
+	void *show_data)
+{
+	switch (filter_options->choice) {
+	case LOFC_DISABLED:
+		traverse_commit_list(revs, show_commit, show_object, show_data);
+		return;
+
+	case LOFC_BLOB_NONE:
+		traverse_commit_list__blobs_none(
+			revs, show_commit, show_object, print_omitted_object,
+			show_data);
+		return;
+
+	case LOFC_BLOB_LIMIT:
+		traverse_commit_list__blobs_limit(
+			revs, show_commit, show_object, print_omitted_object,
+			show_data, filter_options->blob_limit_value);
+		return;
+
+	case LOFC_SPARSE_OID:
+		traverse_commit_list__sparse_oid(
+			revs, show_commit, show_object, print_omitted_object,
+			show_data, filter_options->sparse_oid_value);
+		return;
+
+	case LOFC_SPARSE_PATH:
+		traverse_commit_list__sparse_path(
+			revs, show_commit, show_object, print_omitted_object,
+			show_data, filter_options->sparse_path_value);
+		return;
+
+	default:
+		die("unspecified list-objects filter");
+	}
+}
diff --git a/list-objects.h b/list-objects.h
index 43a06fb..d14b0e0 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -1,6 +1,9 @@
 #ifndef LIST_OBJECTS_H
 #define LIST_OBJECTS_H
 
+#include "list-objects-filter-map.h"
+#include "list-objects-filter-options.h"
+
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
@@ -38,4 +41,12 @@ void traverse_commit_list_worker(
 	show_commit_fn, show_object_fn, void *show_data,
 	filter_object_fn filter, void *filter_data);
 
+void traverse_commit_list_filtered(
+	struct list_objects_filter_options *filter_options,
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	list_objects_filter_map_foreach_cb print_omitted_object,
+	void *show_data);
+
 #endif /* LIST_OBJECTS_H */
-- 
2.9.3

