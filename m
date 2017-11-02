Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686F720281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964855AbdKBUVL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:21:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:41042 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934337AbdKBUVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:21:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6BB93845A8;
        Thu,  2 Nov 2017 16:21:09 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EA78F844EC;
        Thu,  2 Nov 2017 16:21:07 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/9] extension.partialclone: introduce partial clone extension
Date:   Thu,  2 Nov 2017 20:20:44 +0000
Message-Id: <20171102202052.58762-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102202052.58762-1-git@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Introduce the ability to have missing objects in a repo.  This
functionality is guarded by new repository extension options:
    `extensions.partialcloneremote` and
    `extensions.partialclonefilter`.

See the update to Documentation/technical/repository-version.txt
in this patch for more information.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/repository-version.txt | 22 ++++++++
 Makefile                                       |  1 +
 cache.h                                        |  4 ++
 config.h                                       |  3 +
 environment.c                                  |  2 +
 partial-clone-utils.c                          | 78 ++++++++++++++++++++++++++
 partial-clone-utils.h                          | 34 +++++++++++
 setup.c                                        | 15 +++++
 8 files changed, 159 insertions(+)
 create mode 100644 partial-clone-utils.c
 create mode 100644 partial-clone-utils.h

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad379..9d488db 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,25 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`partialcloneremote`
+~~~~~~~~~~~~~~~~~~~~
+
+When the config key `extensions.partialcloneremote` is set, it indicates
+that the repo was created with a partial clone (or later performed
+a partial fetch) and that the remote may have omitted sending
+certain unwanted objects.  Such a remote is called a "promisor remote"
+and it promises that all such omitted objects can be fetched from it
+in the future.
+
+The value of this key is the name of the promisor remote.
+
+`partialclonefilter`
+~~~~~~~~~~~~~~~~~~~~
+
+When the config key `extensions.partialclonefilter` is set, it gives
+the initial filter expression used to create the partial clone.
+This value becomed the default filter expression for subsequent
+fetches (called "partial fetches") from the promisor remote.  This
+value may also be set by the first explicit partial fetch following a
+normal clone.
diff --git a/Makefile b/Makefile
index ca378a4..12d141a 100644
--- a/Makefile
+++ b/Makefile
@@ -838,6 +838,7 @@ LIB_OBJS += pack-write.o
 LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += parse-options-cb.o
+LIB_OBJS += partial-clone-utils.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
diff --git a/cache.h b/cache.h
index 6440e2b..4b785c0 100644
--- a/cache.h
+++ b/cache.h
@@ -860,12 +860,16 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
+extern char *repository_format_partial_clone_remote;
+extern char *repository_format_partial_clone_filter;
 
 struct repository_format {
 	int version;
 	int precious_objects;
 	int is_bare;
 	char *work_tree;
+	char *partial_clone_remote; /* value of extensions.partialcloneremote */
+	char *partial_clone_filter; /* value of extensions.partialclonefilter */
 	struct string_list unknown_extensions;
 };
 
diff --git a/config.h b/config.h
index a49d264..90544ef 100644
--- a/config.h
+++ b/config.h
@@ -34,6 +34,9 @@ struct config_options {
 	const char *git_dir;
 };
 
+#define KEY_PARTIALCLONEREMOTE "partialcloneremote"
+#define KEY_PARTIALCLONEFILTER "partialclonefilter"
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
diff --git a/environment.c b/environment.c
index 8289c25..2fcf9bb 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,8 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
+char *repository_format_partial_clone_remote;
+char *repository_format_partial_clone_filter;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/partial-clone-utils.c b/partial-clone-utils.c
new file mode 100644
index 0000000..32cc20d
--- /dev/null
+++ b/partial-clone-utils.c
@@ -0,0 +1,78 @@
+#include "cache.h"
+#include "config.h"
+#include "partial-clone-utils.h"
+
+int is_partial_clone_registered(void)
+{
+	if (repository_format_partial_clone_remote ||
+	    repository_format_partial_clone_filter)
+		return 1;
+
+	return 0;
+}
+
+void partial_clone_utils_register(
+	const struct list_objects_filter_options *filter_options,
+	const char *remote,
+	const char *cmd_name)
+{
+	if (is_partial_clone_registered()) {
+		/*
+		 * The original partial-clone or a previous partial-fetch
+		 * already registered the partial-clone settings.
+		 * If we get here, we are in a subsequent partial-* command
+		 * (with explicit filter args on the command line).
+		 *
+		 * For now, we restrict subsequent commands to one
+		 * consistent with the original request.  We may relax
+		 * this later after we get more experience with the
+		 * partial-clone feature.
+		 *
+		 * [] Restrict to same remote because our dynamic
+		 *    object loading only knows how to fetch objects
+		 *    from 1 remote.
+		 */
+		assert(filter_options && filter_options->choice);
+		assert(remote && *remote);
+
+		if (strcmp(remote, repository_format_partial_clone_remote))
+			die("%s --%s currently limited to remote '%s'",
+			    cmd_name, CL_ARG__FILTER,
+			    repository_format_partial_clone_remote);
+
+		/*
+		 * Treat the (possibly new) filter-spec as transient;
+		 * use it for the current command, but do not overwrite
+		 * the default.
+		 */
+		return;
+	}
+
+	repository_format_partial_clone_remote = xstrdup(remote);
+	repository_format_partial_clone_filter = xstrdup(filter_options->raw_value);
+
+	/*
+	 * Force repo version > 0 to enable extensions namespace.
+	 *
+	 * TODO if already set > 0, we should not overwrite it. 
+	 */
+	git_config_set("core.repositoryformatversion", "1");
+
+	/*
+	 * Use the "extensions" namespace in the config to record
+	 * the name of the remote used in the partial clone.
+	 * This will help us return to that server when we need
+	 * to backfill missing objects.
+	 *
+	 * It is also used to indicate that there *MAY* be
+	 * missing objects so that subsequent commands don't
+	 * immediately die if they hit one.
+	 *
+	 * Also remember the initial filter settings used by
+	 * clone as a default for future fetches.
+	 */
+	git_config_set("extensions." KEY_PARTIALCLONEREMOTE,
+		       repository_format_partial_clone_remote);
+	git_config_set("extensions." KEY_PARTIALCLONEFILTER,
+		       repository_format_partial_clone_filter);
+}
diff --git a/partial-clone-utils.h b/partial-clone-utils.h
new file mode 100644
index 0000000..b527570
--- /dev/null
+++ b/partial-clone-utils.h
@@ -0,0 +1,34 @@
+#ifndef PARTIAL_CLONE_UTILS_H
+#define PARTIAL_CLONE_UTILS_H
+
+#include "list-objects-filter-options.h"
+
+/*
+ * Register that partial-clone was used to create the repo and
+ * update the config on disk.
+ *
+ * If nothing else, this indicates that the ODB may have missing
+ * objects and that various commands should handle that gracefully.
+ *
+ * Record the remote used for the clone so that we know where
+ * to get missing objects in the future.
+ *
+ * Also record the filter expression so that we know something
+ * about the missing objects (e.g., size-limit vs sparse).
+ *
+ * May also be used by a partial-fetch following a normal clone
+ * to turn on the above tracking.
+ */ 
+extern void partial_clone_utils_register(
+	const struct list_objects_filter_options *filter_options,
+	const char *remote,
+	const char *cmd_name);
+
+/*
+ * Return 1 if partial-clone was used to create the repo
+ * or a subsequent partial-fetch was used.  This is an
+ * indicator that there may be missing objects.
+ */
+extern int is_partial_clone_registered(void);
+
+#endif /* PARTIAL_CLONE_UTILS_H */
diff --git a/setup.c b/setup.c
index 03f51e0..bc4133d 100644
--- a/setup.c
+++ b/setup.c
@@ -420,6 +420,19 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
+
+		else if (!strcmp(ext, KEY_PARTIALCLONEREMOTE))
+			if (!value)
+				return config_error_nonbool(var);
+			else
+				data->partial_clone_remote = xstrdup(value);
+
+		else if (!strcmp(ext, KEY_PARTIALCLONEFILTER))
+			if (!value)
+				return config_error_nonbool(var);
+			else
+				data->partial_clone_filter = xstrdup(value);
+
 		else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
@@ -463,6 +476,8 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	}
 
 	repository_format_precious_objects = candidate.precious_objects;
+	repository_format_partial_clone_remote = candidate.partial_clone_remote;
+	repository_format_partial_clone_filter = candidate.partial_clone_filter;
 	string_list_clear(&candidate.unknown_extensions, 0);
 	if (!has_common) {
 		if (candidate.is_bare != -1) {
-- 
2.9.3

