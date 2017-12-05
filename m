Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705B120A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbdLERDS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:18 -0500
Received: from siwi.pair.com ([209.68.5.199]:15269 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752819AbdLERDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:14 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B2817844E2;
        Tue,  5 Dec 2017 12:03:13 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 39122844DE;
        Tue,  5 Dec 2017 12:03:13 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 06/14] fetch: support filters
Date:   Tue,  5 Dec 2017 17:02:46 +0000
Message-Id: <20171205170254.65293-7-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fetch to support filters. This is only allowed for the remote
configured in extensions.partialcloneremote.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c       | 23 +++++++++++++++++++++--
 connected.c           |  1 +
 remote-curl.c         |  6 ++++++
 t/t5500-fetch-pack.sh | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b1f039..05d0b1a 100644
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
 
@@ -1044,6 +1047,11 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (filter_options.choice) {
+		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
+			   filter_options.filter_spec);
+		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	}
 	return transport;
 }
 
@@ -1328,6 +1336,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch");
 
+	fetch_if_missing = 0;
+
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
@@ -1361,6 +1371,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
+	if (filter_options.choice && !repository_format_partial_clone)
+		die("--blob-max-bytes can only be used when extensions.partialClone is set");
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
@@ -1390,10 +1403,16 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (remote)
+	if (remote) {
+		if (filter_options.choice &&
+		    strcmp(remote->name, repository_format_partial_clone))
+			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
 		result = fetch_one(remote, argc, argv);
-	else
+	} else {
+		if (filter_options.choice)
+			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
 		result = fetch_multiple(&list);
+	}
 
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct argv_array options = ARGV_ARRAY_INIT;
diff --git a/connected.c b/connected.c
index f416b05..a51c01d 100644
--- a/connected.c
+++ b/connected.c
@@ -56,6 +56,7 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
+	argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	argv_array_push(&rev_list.args, "--not");
 	argv_array_push(&rev_list.args, "--all");
 	argv_array_push(&rev_list.args, "--quiet");
diff --git a/remote-curl.c b/remote-curl.c
index 4318391..6ec5352 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -24,6 +24,7 @@ struct options {
 	char *deepen_since;
 	struct string_list deepen_not;
 	struct string_list push_options;
+	char *filter;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -165,6 +166,9 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "no-dependents")) {
 		options.no_dependents = 1;
 		return 0;
+	} else if (!strcmp(name, "filter")) {
+		options.filter = xstrdup(value);;
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -834,6 +838,8 @@ static int fetch_git(struct discovery *heads,
 		argv_array_push(&args, "--from-promisor");
 	if (options.no_dependents)
 		argv_array_push(&args, "--no-dependents");
+	if (options.filter)
+		argv_array_pushf(&args, "--filter=%s", options.filter);
 	argv_array_push(&args, url.buf);
 
 	for (i = 0; i < nr_heads; i++) {
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index c57916b..65fc7bb 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -782,4 +782,40 @@ test_expect_success 'filtering by size has no effect if support for it is not ad
 	test_i18ngrep "filtering not recognized by server" err
 '
 
+fetch_blob_max_bytes () {
+	SERVER="$1"
+	URL="$2"
+
+	rm -rf "$SERVER" client &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" one &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+
+	git clone "$URL" client &&
+	test_config -C client extensions.partialclone origin &&
+
+	test_commit -C "$SERVER" two &&
+
+	git -C client fetch --filter=blob:limit=0 origin HEAD:somewhere &&
+
+	# Ensure that commit is fetched, but blob is not
+	test_config -C client extensions.partialclone "arbitrary string" &&
+	git -C client cat-file -e $(git -C "$SERVER" rev-parse two) &&
+	test_must_fail git -C client cat-file -e $(git hash-object "$SERVER/two.t")
+}
+
+test_expect_success 'fetch with --blob-max-bytes' '
+	fetch_blob_max_bytes server server
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetch with --blob-max-bytes and HTTP' '
+	fetch_blob_max_bytes "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
+'
+
+stop_httpd
+
+
 test_done
-- 
2.9.3

