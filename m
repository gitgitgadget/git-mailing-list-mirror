Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F14202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 18:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760423AbdKPSRu (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 13:17:50 -0500
Received: from siwi.pair.com ([209.68.5.199]:46715 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966656AbdKPSRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 13:17:39 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 126858455C;
        Thu, 16 Nov 2017 13:17:39 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8B00E8455A;
        Thu, 16 Nov 2017 13:17:38 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 07/15] fetch-pack: test support excluding large blobs
Date:   Thu, 16 Nov 2017 18:17:15 +0000
Message-Id: <20171116181723.62033-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171116181723.62033-1-git@jeffhostetler.com>
References: <20171116181723.62033-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Created tests to verify fetch-pack and upload-pack support
for excluding large blobs using --filter=blob:limit=<n>
parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 cache.h                       |  1 +
 config.c                      |  5 +++
 environment.c                 |  1 +
 list-objects-filter-options.c | 84 +++++++++++++++++++++++++++++++++++++++----
 list-objects-filter-options.h |  6 ++++
 t/t5500-fetch-pack.sh         | 27 ++++++++++++++
 6 files changed, 117 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 6980072..bccc510 100644
--- a/cache.h
+++ b/cache.h
@@ -861,6 +861,7 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
 extern char *repository_format_partial_clone;
+extern const char *core_partial_clone_filter_default;
 
 struct repository_format {
 	int version;
diff --git a/config.c b/config.c
index adb7d7a..adeee04 100644
--- a/config.c
+++ b/config.c
@@ -1241,6 +1241,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.partialclonefilter")) {
+		return git_config_string(&core_partial_clone_filter_default,
+					 var, value);
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index e52aab3..7537565 100644
--- a/environment.c
+++ b/environment.c
@@ -28,6 +28,7 @@ int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
 char *repository_format_partial_clone;
+const char *core_partial_clone_filter_default;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index f1fb57b..76a6579 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -75,13 +75,22 @@ int armor_decode_arg(struct strbuf *buf, const char *arg)
  * subordinate commands when necessary.  We also "intern" the arg for
  * the convenience of the current command.
  */
-int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
-			      const char *arg)
+static int gently_parse_list_objects_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf)
 {
 	const char *v0;
 
-	if (filter_options->choice)
-		die(_("multiple object filter types cannot be combined"));
+	if (filter_options->choice) {
+		if (errbuf) {
+			strbuf_init(errbuf, 0);
+			strbuf_addstr(
+				errbuf,
+				_("multiple filter-specs cannot be combined"));
+		}
+		return 1;
+	}
 
 	filter_options->raw_value = strdup(arg);
 
@@ -92,7 +101,7 @@ int parse_list_objects_filter(struct list_objects_filter_options *filter_options
 
 	if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (!git_parse_ulong(v0, &filter_options->blob_limit_value))
-			die(_("invalid filter-spec expression '%s'"), arg);
+			goto invalid_expression;
 		filter_options->choice = LOFC_BLOB_LIMIT;
 		return 0;
 	}
@@ -127,13 +136,27 @@ int parse_list_objects_filter(struct list_objects_filter_options *filter_options
 		int r;
 		struct strbuf buf = STRBUF_INIT;
 		if (armor_decode_arg(&buf, v0) < 0)
-			die(_("invalid filter-spec expression '%s'"), arg);
+			goto invalid_expression;
 		r = parse_list_objects_filter(filter_options, buf.buf);
 		strbuf_release(&buf);
 		return r;
 	}
 
-	die(_("invalid filter-spec expression '%s'"), arg);
+invalid_expression:
+	if (errbuf) {
+		strbuf_init(errbuf, 0);
+		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
+	}
+	memset(filter_options, 0, sizeof(*filter_options));
+	return 1;
+}
+
+int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
+			      const char *arg)
+{
+	struct strbuf buf = STRBUF_INIT;
+	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
+		die("%s", buf.buf);
 	return 0;
 }
 
@@ -173,3 +196,50 @@ void list_objects_filter_push_arg(
 	}
 }
 
+void partial_clone_register(
+	const char *remote,
+	const struct list_objects_filter_options *filter_options)
+{
+	/*
+	 * Record the name of the partial clone remote in the
+	 * config and in the global variable -- the latter is
+	 * used throughout to indicate that partial clone is
+	 * enabled and to expect missing objects.
+	 */
+	if (repository_format_partial_clone &&
+	    *repository_format_partial_clone &&
+	    strcmp(remote, repository_format_partial_clone))
+		die(_("cannot change partial clone promisor remote"));
+
+	git_config_set("core.repositoryformatversion", "1");
+	git_config_set("extensions.partialclone", remote);
+
+	repository_format_partial_clone = xstrdup(remote);
+
+	/*
+	 * Record the initial filter-spec in the config as
+	 * the default for subsequent fetches from this remote.
+	 */
+	if (filter_options->requires_armor) {
+		struct strbuf buf = STRBUF_INIT;
+		armor_encode_arg(&buf, filter_options->raw_value);
+		core_partial_clone_filter_default = xstrdup(buf.buf);
+		strbuf_release(&buf);
+	} else {
+		core_partial_clone_filter_default =
+			xstrdup(filter_options->raw_value);
+	}
+	git_config_set("core.partialclonefilter",
+		       core_partial_clone_filter_default);
+}
+
+void partial_clone_get_default_filter_spec(
+	struct list_objects_filter_options *filter_options)
+{
+	/*
+	 * Parse default value, but silently ignore it if it is invalid.
+	 */
+	gently_parse_list_objects_filter(filter_options,
+					 core_partial_clone_filter_default,
+					 NULL);
+}
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 99f454c..1a345ec 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -60,4 +60,10 @@ void list_objects_filter_push_arg(
 	struct argv_array *args,
 	const struct list_objects_filter_options *filter_options);
 
+void partial_clone_register(
+	const char *remote,
+	const struct list_objects_filter_options *filter_options);
+void partial_clone_get_default_filter_spec(
+	struct list_objects_filter_options *filter_options);
+
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 80a1a32..c57916b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -755,4 +755,31 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
+test_expect_success 'filtering by size' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_config -C server uploadpack.allowfilter 1 &&
+
+	test_create_repo client &&
+	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
+
+	# Ensure that object is not inadvertently fetched
+	test_must_fail git -C client cat-file -e $(git hash-object server/one.t)
+'
+
+test_expect_success 'filtering by size has no effect if support for it is not advertised' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	test_create_repo client &&
+	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD 2> err &&
+
+	# Ensure that object is fetched
+	git -C client cat-file -e $(git hash-object server/one.t) &&
+
+	test_i18ngrep "filtering not recognized by server" err
+'
+
 test_done
-- 
2.9.3

