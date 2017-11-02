Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848E420281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934509AbdKBUbp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:31:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:43856 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934503AbdKBUbo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:31:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 72F3C845AC;
        Thu,  2 Nov 2017 16:31:43 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D0CCE845AD;
        Thu,  2 Nov 2017 16:31:42 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 04/14] fetch: add object filtering for partial fetch
Date:   Thu,  2 Nov 2017 20:31:19 +0000
Message-Id: <20171102203129.59417-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102203129.59417-1-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fetch to use the list-objects filtering parameters
to allow a "partial fetch" following a "partial clone".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b1f039..150ca0a 100644
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
 
@@ -754,6 +757,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
+	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -765,7 +769,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	rm = ref_map;
-	if (check_connected(iterate_ref_map, &rm, NULL)) {
+	if (check_connected(iterate_ref_map, &rm, &opt)) {
 		rc = error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -1044,6 +1048,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (filter_options.choice)
+		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
+			   filter_options.raw_value);
 	return transport;
 }
 
@@ -1242,6 +1249,20 @@ static int fetch_multiple(struct string_list *list)
 	int i, result = 0;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
+	if (filter_options.choice) {
+		/*
+		 * We currently only support partial-fetches to the remote
+		 * used for the partial-clone because we only support 1
+		 * promisor remote, so we DO NOT allow explicit command
+		 * line filter arguments.
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
@@ -1267,6 +1288,46 @@ static int fetch_multiple(struct string_list *list)
 	return result;
 }
 
+static inline void partial_fetch_one_setup(struct remote *remote)
+{
+#if 0 /* TODO */
+	if (filter_options.choice) {
+		/*
+		 * A partial-fetch was explicitly requested.
+		 *
+		 * If this is the first partial-* command on
+		 * this repo, we must register the partial
+		 * settings in the repository extension.
+		 *
+		 * If this follows a previous partial-* command
+		 * we must ensure the args are consistent with
+		 * the existing registration (because we don't
+		 * currently support mixing-and-matching).
+		 */
+		partial_clone_utils_register(&filter_options,
+					     remote->name, "fetch");
+		return;
+	}
+
+	if (is_partial_clone_registered() &&
+	    !strcmp(remote->name, repository_format_partial_clone_remote)) {
+		/*
+		 * If a partial-* command has already been used on
+		 * this repo and it was to this remote, we should
+		 * inherit the filter settings used previously.
+		 * That is, if clone omitted very large blobs, then
+		 * fetch should too.
+		 *
+		 * Use the cached filter-spec and create the filter
+		 * settings.
+		 */
+		parse_list_objects_filter(
+			&filter_options,
+			repository_format_partial_clone_filter);
+	}
+#endif
+}
+
 static int fetch_one(struct remote *remote, int argc, const char **argv)
 {
 	static const char **refs = NULL;
@@ -1278,6 +1339,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die(_("No remote repository specified.  Please, specify either a URL or a\n"
 		    "remote name from which new revisions should be fetched."));
 
+	partial_fetch_one_setup(remote);
+
+
 	gtransport = prepare_transport(remote, 1);
 
 	if (prune < 0) {
-- 
2.9.3

