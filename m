Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D850E20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbdLERDa (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:30 -0500
Received: from siwi.pair.com ([209.68.5.199]:15302 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753163AbdLERDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:16 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 45AF8844E2;
        Tue,  5 Dec 2017 12:03:16 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C10A0844DE;
        Tue,  5 Dec 2017 12:03:15 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 10/14] partial-clone: define partial clone settings in config
Date:   Tue,  5 Dec 2017 17:02:50 +0000
Message-Id: <20171205170254.65293-11-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create get and set routines for "partial clone" config settings.
These will be used in a future commit by clone and fetch to
remember the promisor remote and the default filter-spec.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 cache.h                       |  1 +
 config.c                      |  5 +++
 environment.c                 |  1 +
 list-objects-filter-options.c | 90 +++++++++++++++++++++++++++++++++++--------
 list-objects-filter-options.h |  6 +++
 5 files changed, 88 insertions(+), 15 deletions(-)

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
index 4c5b34e..5c47e2b 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -21,29 +21,36 @@
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
 
 	filter_options->filter_spec = strdup(arg);
 
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
-	}
 
-	if (skip_prefix(arg, "blob:limit=", &v0)) {
-		if (!git_parse_ulong(v0, &filter_options->blob_limit_value))
-			die(_("invalid filter-spec expression '%s'"), arg);
-		filter_options->choice = LOFC_BLOB_LIMIT;
-		return 0;
-	}
+	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
+		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
+			filter_options->choice = LOFC_BLOB_LIMIT;
+			return 0;
+		}
 
-	if (skip_prefix(arg, "sparse:oid=", &v0)) {
+	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
 		struct object_context oc;
 		struct object_id sparse_oid;
 
@@ -57,15 +64,27 @@ int parse_list_objects_filter(struct list_objects_filter_options *filter_options
 			filter_options->sparse_oid_value = oiddup(&sparse_oid);
 		filter_options->choice = LOFC_SPARSE_OID;
 		return 0;
-	}
 
-	if (skip_prefix(arg, "sparse:path=", &v0)) {
+	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
 	}
 
-	die(_("invalid filter-spec expression '%s'"), arg);
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
 
@@ -90,3 +109,44 @@ void list_objects_filter_release(
 	free(filter_options->sparse_path_value);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
+
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
+	core_partial_clone_filter_default =
+		xstrdup(filter_options->filter_spec);
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
index eea44a1..1143539 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -58,4 +58,10 @@ int opt_parse_list_objects_filter(const struct option *opt,
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options);
 
+void partial_clone_register(
+	const char *remote,
+	const struct list_objects_filter_options *filter_options);
+void partial_clone_get_default_filter_spec(
+	struct list_objects_filter_options *filter_options);
+
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
-- 
2.9.3

