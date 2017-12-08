Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E168620C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbdLHP70 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:59:26 -0500
Received: from siwi.pair.com ([209.68.5.199]:55827 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754445AbdLHP7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:59:16 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1C5A3844F1;
        Fri,  8 Dec 2017 10:59:16 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9746B844DE;
        Fri,  8 Dec 2017 10:59:15 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 15/16] fetch: inherit filter-spec from partial clone
Date:   Fri,  8 Dec 2017 15:58:50 +0000
Message-Id: <20171208155851.855-16-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach (partial) fetch to inherit the filter-spec used by
the partial clone.  Extend --no-filter to override this
inheritance.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch-pack.c          |  2 +-
 builtin/fetch.c               | 56 ++++++++++++++++++++++++++++++++++++++++---
 builtin/rev-list.c            |  2 +-
 list-objects-filter-options.c |  2 +-
 list-objects-filter-options.h | 12 ++++++++++
 t/t5616-partial-clone.sh      | 22 ++++++++++++++++-
 6 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cbf5035..a7bc136 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -158,7 +158,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			list_objects_filter_release(&args.filter_options);
+			list_objects_filter_set_no_filter(&args.filter_options);
 			continue;
 		}
 		usage(fetch_pack_usage);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 14aab71..79c866c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1275,6 +1275,56 @@ static int fetch_multiple(struct string_list *list)
 	return result;
 }
 
+/*
+ * Fetching from the promisor remote should use the given filter-spec
+ * or inherit the default filter-spec from the config.
+ */
+static inline void fetch_one_setup_partial(struct remote *remote)
+{
+	/*
+	 * Explicit --no-filter argument overrides everything, regardless
+	 * of any prior partial clones and fetches.
+	 */
+	if (filter_options.no_filter)
+		return;
+
+	/*
+	 * If no prior partial clone/fetch and the current fetch DID NOT
+	 * request a partial-fetch, do a normal fetch.
+	 */
+	if (!repository_format_partial_clone && !filter_options.choice)
+		return;
+
+	/*
+	 * If this is the FIRST partial-fetch request, we enable partial
+	 * on this repo and remember the given filter-spec as the default
+	 * for subsequent fetches to this remote.
+	 */
+	if (!repository_format_partial_clone && filter_options.choice) {
+		partial_clone_register(remote->name, &filter_options);
+		return;
+	}
+
+	/*
+	 * We are currently limited to only ONE promisor remote and only
+	 * allow partial-fetches from the promisor remote.
+	 */
+	if (strcmp(remote->name, repository_format_partial_clone)) {
+		if (filter_options.choice)
+			die(_("--filter can only be used with the remote configured in core.partialClone"));
+		return;
+	}
+
+	/*
+	 * Do a partial-fetch from the promisor remote using either the
+	 * explicitly given filter-spec or inherit the filter-spec from
+	 * the config.
+	 */
+	if (!filter_options.choice)
+		partial_clone_get_default_filter_spec(&filter_options);
+	return;
+}
+
 static int fetch_one(struct remote *remote, int argc, const char **argv)
 {
 	static const char **refs = NULL;
@@ -1404,13 +1454,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (remote) {
-		if (filter_options.choice &&
-		    strcmp(remote->name, repository_format_partial_clone))
-			die(_("--filter can only be used with the remote configured in core.partialClone"));
+		if (filter_options.choice || repository_format_partial_clone)
+			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv);
 	} else {
 		if (filter_options.choice)
 			die(_("--filter can only be used with the remote configured in core.partialClone"));
+		/* TODO should this also die if we have a previous partial-clone? */
 		result = fetch_multiple(&list);
 	}
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 48f922d..8503dea 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -460,7 +460,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			list_objects_filter_release(&filter_options);
+			list_objects_filter_set_no_filter(&filter_options);
 			continue;
 		}
 		if (!strcmp(arg, "--filter-print-omitted")) {
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5c47e2b..6a3cc98 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -94,7 +94,7 @@ int opt_parse_list_objects_filter(const struct option *opt,
 	struct list_objects_filter_options *filter_options = opt->value;
 
 	if (unset || !arg) {
-		list_objects_filter_release(filter_options);
+		list_objects_filter_set_no_filter(filter_options);
 		return 0;
 	}
 
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 1143539..0000a61 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -31,6 +31,11 @@ struct list_objects_filter_options {
 	enum list_objects_filter_choice choice;
 
 	/*
+	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
+	 */
+	unsigned int no_filter : 1;
+
+	/*
 	 * Parsed values (fields) from within the filter-spec.  These are
 	 * choice-specific; not all values will be defined for any given
 	 * choice.
@@ -58,6 +63,13 @@ int opt_parse_list_objects_filter(const struct option *opt,
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options);
 
+static inline void list_objects_filter_set_no_filter(
+	struct list_objects_filter_options *filter_options)
+{
+	list_objects_filter_release(filter_options);
+	filter_options->no_filter = 1;
+}
+
 void partial_clone_register(
 	const char *remote,
 	const struct list_objects_filter_options *filter_options);
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 3b8cc0b..433e07e 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -59,7 +59,7 @@ test_expect_success 'push new commits to server' '
 	git -C src remote add srv "file://$(pwd)/srv.bare" &&
 	for x in a b c d e
 	do
-		echo "Mod $x" >>src/file.1.txt
+		echo "Mod file.1.txt $x" >>src/file.1.txt
 		git -C src add file.1.txt
 		git -C src commit -m "mod $x"
 	done &&
@@ -93,4 +93,24 @@ test_expect_success 'verify blame causes dynamic object fetch' '
 	test_line_count = 0 observed
 '
 
+# create new commits in "src" repo to establish a history on file.2.txt
+# and push to "srv.bare".
+test_expect_success 'push new commits to server for file.2.txt' '
+	for x in a b c d e f
+	do
+		echo "Mod file.2.txt $x" >>src/file.2.txt
+		git -C src add file.2.txt
+		git -C src commit -m "mod $x"
+	done &&
+	git -C src push -u srv master
+'
+
+# Do FULL fetch by disabling filter-spec using --no-filter.
+# Verify we have all the new blobs.
+test_expect_success 'override inherited filter-spec using --no-filter' '
+	git -C pc1 fetch --no-filter origin &&
+	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print >observed &&
+	test_line_count = 0 observed
+'
+
 test_done
-- 
2.9.3

