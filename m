Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4CC1202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760442AbdKPSSD (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 13:18:03 -0500
Received: from siwi.pair.com ([209.68.5.199]:46694 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966659AbdKPSRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 13:17:41 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CA4F984558;
        Thu, 16 Nov 2017 13:17:40 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5395784557;
        Thu, 16 Nov 2017 13:17:40 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 10/15] fetch: add from_promisor and exclude-promisor-objects parameters
Date:   Thu, 16 Nov 2017 18:17:18 +0000
Message-Id: <20171116181723.62033-11-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171116181723.62033-1-git@jeffhostetler.com>
References: <20171116181723.62033-1-git@jeffhostetler.com>
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
 builtin/fetch.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 connected.c     |  2 ++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fb9af7c..d3cf423 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1047,9 +1047,11 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
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
 
@@ -1287,6 +1289,59 @@ static int fetch_multiple(struct string_list *list)
 	return result;
 }
 
+static inline void fetch_one__setup_partial(struct remote *remote)
+{
+	int ppc, neq;
+
+	/* Do we have a prior partial clone/fetch? */
+	ppc = (repository_format_partial_clone &&
+	       *repository_format_partial_clone);
+
+	/*
+	 * If no prior partial clone/fetch and partial fetch was NOT
+	 * requested now, do a normal fetch.
+	 */
+	if (!ppc && !filter_options.choice)
+		return;
+
+	/*
+	 * If this is the FIRST partial fetch request, we enable partial
+	 * on this repo and remember the given filter-spec as the default
+	 * for subsequent fetches to this remote.
+	 */
+	if (!ppc && filter_options.choice) {
+		partial_clone_register(remote->name, &filter_options);
+		return;
+	}
+
+	/*
+	 * We are currently limited to only ONE promisor remote.  That is,
+	 * we only allow partial fetches back to the original partial clone
+	 * remote (or the first partial fetch remote).  Disallow explicit
+	 * partial fetches to a different remote.
+	 *
+	 * Normal (non-partial) fetch commands should still be allowed to
+	 * other remotes.
+	 */
+	neq = (strcmp(remote->name, repository_format_partial_clone));
+	if (neq && filter_options.choice)
+		die(_("unsupported partial-fetch to a different remote"));
+
+	if (neq && !filter_options.choice)
+		return;
+
+	/*
+	 * When fetching from the promisor remote, we either use the
+	 * explicitly given filter-spec or inherit the filter-spec from
+	 * the clone.
+	 */
+	if (filter_options.choice)
+		return;
+
+	partial_clone_get_default_filter_spec(&filter_options);
+	return;
+}
+
 static int fetch_one(struct remote *remote, int argc, const char **argv)
 {
 	static const char **refs = NULL;
@@ -1298,6 +1353,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die(_("No remote repository specified.  Please, specify either a URL or a\n"
 		    "remote name from which new revisions should be fetched."));
 
+	fetch_one__setup_partial(remote);
+
 	gtransport = prepare_transport(remote, 1);
 
 	if (prune < 0) {
@@ -1348,6 +1405,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch");
 
+	fetch_if_missing = 0;
+
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
diff --git a/connected.c b/connected.c
index f416b05..3a5bd67 100644
--- a/connected.c
+++ b/connected.c
@@ -56,6 +56,8 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
+	if (repository_format_partial_clone)
+		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	argv_array_push(&rev_list.args, "--not");
 	argv_array_push(&rev_list.args, "--all");
 	argv_array_push(&rev_list.args, "--quiet");
-- 
2.9.3

