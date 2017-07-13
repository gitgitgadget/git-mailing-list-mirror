Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B4F202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdGMRf5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:11127 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbdGMRfz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:55 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 51BA6844EA;
        Thu, 13 Jul 2017 13:35:45 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A3F14844E3;
        Thu, 13 Jul 2017 13:35:44 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 19/19] fetch: add object filtering to fetch
Date:   Thu, 13 Jul 2017 17:34:59 +0000
Message-Id: <20170713173459.3559-20-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f2c2ab..306c165 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -16,6 +16,7 @@
 #include "connected.h"
 #include "argv-array.h"
 #include "utf8.h"
+#include "object-filter.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -52,6 +53,7 @@ static const char *recurse_submodules_default;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
+static struct object_filter_options filter_options;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -141,6 +143,14 @@ static struct option builtin_fetch_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+
+	OPT_PARSE_FILTER_OMIT_ALL_BLOBS(&filter_options),
+	OPT_PARSE_FILTER_OMIT_LARGE_BLOBS(&filter_options),
+	OPT_PARSE_FILTER_USE_SPARSE(&filter_options),
+
+	/* OPT_PARSE_FILTER_PRINT_MANIFEST(&filter_options), */
+	/* OPT_PARSE_FILTER_RELAX(&filter_options), */
+
 	OPT_END()
 };
 
@@ -733,6 +743,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
+	struct check_connected_options opt = CHECK_CONNECTED_INIT;
+
+	/*
+	 * Relax consistency check to allow missing blobs (presumably
+	 * because they are exactly the set that we requested be
+	 * omitted.
+	 */
+	opt.filter_relax = object_filter_enabled(&filter_options);
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -744,7 +762,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	rm = ref_map;
-	if (check_connected(iterate_ref_map, &rm, NULL)) {
+	if (check_connected(iterate_ref_map, &rm, &opt)) {
 		rc = error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -885,6 +903,13 @@ static int quickfetch(struct ref *ref_map)
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
 	/*
+	 * Relax consistency check to allow missing blobs (presumably
+	 * because they are exactly the set that we requested be
+	 * omitted.
+	 */
+	opt.filter_relax = object_filter_enabled(&filter_options);
+
+	/*
 	 * If we are deepening a shallow clone we already have these
 	 * objects reachable.  Running rev-list here will return with
 	 * a good (0) exit status and we'll bypass the fetch that we
-- 
2.9.3

