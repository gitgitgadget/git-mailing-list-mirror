Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69F6202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 18:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759914AbdKPSRs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 13:17:48 -0500
Received: from siwi.pair.com ([209.68.5.199]:46694 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966301AbdKPSRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 13:17:37 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4278384558;
        Thu, 16 Nov 2017 13:17:37 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BE4998454D;
        Thu, 16 Nov 2017 13:17:36 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 04/15] fetch: add object filtering for partial fetch
Date:   Thu, 16 Nov 2017 18:17:12 +0000
Message-Id: <20171116181723.62033-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171116181723.62033-1-git@jeffhostetler.com>
References: <20171116181723.62033-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fetch to use the list-objects filtering parameters
to allow a "partial fetch" following a "partial clone".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b1f039..fb9af7c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -18,6 +18,7 @@
 #include "argv-array.h"
 #include "utf8.h"
 #include "packfile.h"
+#include "list-objects-filter-options.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -55,6 +56,7 @@ static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
+static struct list_objects_filter_options filter_options;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -160,6 +162,7 @@ static struct option builtin_fetch_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_END()
 };
 
@@ -1044,6 +1047,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (filter_options.choice)
+		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
+			   filter_options.raw_value);
 	return transport;
 }
 
@@ -1242,6 +1248,20 @@ static int fetch_multiple(struct string_list *list)
 	int i, result = 0;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
+	if (filter_options.choice) {
+		/*
+		 * We currently only support partial-fetches to the remote
+		 * used for the partial-clone because we only support 1
+		 * promisor remote, so we DO NOT allow explicit command
+		 * line filter arguments for multi-fetches.
+		 *
+		 * Note that the loop below will spawn background fetches
+		 * for each remote and one of them MAY INHERIT the proper
+		 * partial-fetch settings, so everything is consistent.
+		 */
+		die(_("partial-fetch is not supported on multiple remotes"));
+	}
+
 	if (!append && !dry_run) {
 		int errcode = truncate_fetch_head();
 		if (errcode)
-- 
2.9.3

