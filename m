Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E2E20281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbdKBUbw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:31:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:14598 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934516AbdKBUbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:31:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E3A43845AD;
        Thu,  2 Nov 2017 16:31:49 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 545B4845AC;
        Thu,  2 Nov 2017 16:31:49 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 08/14] fetch: add from_promisor and exclude-promisor-objects parameters
Date:   Thu,  2 Nov 2017 20:31:23 +0000
Message-Id: <20171102203129.59417-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102203129.59417-1-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach fetch to use from-promisor and exclude-promisor-objects
parameters with sub-commands.  Initialize fetch_if_missing
global variable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch.c | 9 ++++++---
 connected.c     | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 150ca0a..ab53df3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -19,6 +19,7 @@
 #include "utf8.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "partial-clone-utils.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -1048,9 +1049,11 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
-	if (filter_options.choice)
+	if (filter_options.choice) {
 		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
 			   filter_options.raw_value);
+		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	}
 	return transport;
 }
 
@@ -1290,7 +1293,6 @@ static int fetch_multiple(struct string_list *list)
 
 static inline void partial_fetch_one_setup(struct remote *remote)
 {
-#if 0 /* TODO */
 	if (filter_options.choice) {
 		/*
 		 * A partial-fetch was explicitly requested.
@@ -1325,7 +1327,6 @@ static inline void partial_fetch_one_setup(struct remote *remote)
 			&filter_options,
 			repository_format_partial_clone_filter);
 	}
-#endif
 }
 
 static int fetch_one(struct remote *remote, int argc, const char **argv)
@@ -1392,6 +1393,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch");
 
+	fetch_if_missing = 0;
+
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
diff --git a/connected.c b/connected.c
index f416b05..6015316 100644
--- a/connected.c
+++ b/connected.c
@@ -4,6 +4,7 @@
 #include "connected.h"
 #include "transport.h"
 #include "packfile.h"
+#include "partial-clone-utils.h"
 
 /*
  * If we feed all the commits we want to verify to this command
@@ -56,6 +57,8 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
+	if (is_partial_clone_registered())
+		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	argv_array_push(&rev_list.args, "--not");
 	argv_array_push(&rev_list.args, "--all");
 	argv_array_push(&rev_list.args, "--quiet");
-- 
2.9.3

