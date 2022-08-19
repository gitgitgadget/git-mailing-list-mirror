Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6505FC32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348318AbiHSKJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348299AbiHSKI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1A9D11F
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:45 -0700 (PDT)
Received: (qmail 17675 invoked by uid 109); 19 Aug 2022 10:08:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 937 invoked by uid 111); 19 Aug 2022 10:08:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/11] config: mark unused callback parameters
Message-ID: <Yv9hLNIv3Y7aNqTb@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callback passed to git_config() must conform to a particular
interface. But most callbacks don't actually look at the extra "void
*data" parameter. Let's mark the unused parameters to make
-Wunused-parameter happy.

Note there's one unusual case here in get_remote_default() where we
actually ignore the "value" parameter. That's because it's only checking
whether the option is found at all, and not parsing its value.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c              | 3 ++-
 archive-zip.c              | 3 ++-
 builtin/am.c               | 2 +-
 builtin/commit-graph.c     | 2 +-
 builtin/config.c           | 8 +++++---
 builtin/multi-pack-index.c | 2 +-
 builtin/remote.c           | 2 +-
 color.c                    | 2 +-
 config.c                   | 3 ++-
 convert.c                  | 2 +-
 delta-islands.c            | 2 +-
 diff.c                     | 3 ++-
 git-compat-util.h          | 4 +++-
 gpg-interface.c            | 2 +-
 ident.c                    | 2 +-
 ll-merge.c                 | 3 ++-
 ls-refs.c                  | 3 ++-
 pager.c                    | 3 ++-
 pretty.c                   | 3 ++-
 submodule.c                | 3 ++-
 t/helper/test-config.c     | 2 +-
 t/helper/test-userdiff.c   | 2 +-
 trailer.c                  | 6 ++++--
 23 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3d77e0f750..45e5d91407 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -366,7 +366,8 @@ static struct archiver *find_tar_filter(const char *name, size_t len)
 	return NULL;
 }
 
-static int tar_filter_config(const char *var, const char *value, void *data)
+static int tar_filter_config(const char *var, const char *value,
+			     void *UNUSED(data))
 {
 	struct archiver *ar;
 	const char *name;
diff --git a/archive-zip.c b/archive-zip.c
index 9fe43d740d..854bceb018 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -612,7 +612,8 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 	*dos_time = tm.tm_sec / 2 + tm.tm_min * 32 + tm.tm_hour * 2048;
 }
 
-static int archive_zip_config(const char *var, const char *value, void *data)
+static int archive_zip_config(const char *var, const char *value,
+			      void *UNUSED(data))
 {
 	return userdiff_config(var, value);
 }
diff --git a/builtin/am.c b/builtin/am.c
index 93bec62afa..0811b9ff67 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2301,7 +2301,7 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	return 0;
 }
 
-static int git_am_config(const char *k, const char *v, void *cb)
+static int git_am_config(const char *k, const char *v, void *UNUSED(cb))
 {
 	int status;
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 51c4040ea6..ea923ea33a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -179,7 +179,7 @@ static int write_option_max_new_filters(const struct option *opt,
 }
 
 static int git_commit_graph_write_config(const char *var, const char *value,
-					 void *cb)
+					 void *UNUSED(cb))
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
 		write_opts.max_new_filters = git_config_int(var, value);
diff --git a/builtin/config.c b/builtin/config.c
index e7b88a9c08..bdc8b1d1a8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -207,7 +207,8 @@ static void show_config_scope(struct strbuf *buf)
 	strbuf_addch(buf, term);
 }
 
-static int show_all_config(const char *key_, const char *value_, void *cb)
+static int show_all_config(const char *key_, const char *value_,
+			   void *UNUSED(cb))
 {
 	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
@@ -458,7 +459,8 @@ static const char *get_color_slot;
 static const char *get_colorbool_slot;
 static char parsed_color[COLOR_MAXLEN];
 
-static int git_get_color_config(const char *var, const char *value, void *cb)
+static int git_get_color_config(const char *var, const char *value,
+				void *UNUSED(cb))
 {
 	if (!strcmp(var, get_color_slot)) {
 		if (!value)
@@ -490,7 +492,7 @@ static int get_colorbool_found;
 static int get_diff_color_found;
 static int get_color_ui_found;
 static int git_get_colorbool_config(const char *var, const char *value,
-		void *cb)
+				    void *UNUSED(data))
 {
 	if (!strcmp(var, get_colorbool_slot))
 		get_colorbool_found = git_config_colorbool(var, value);
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8f24d59a75..8d156766af 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -78,7 +78,7 @@ static struct option *add_common_options(struct option *prev)
 }
 
 static int git_multi_pack_index_write_config(const char *var, const char *value,
-					     void *cb)
+					     void *UNUSED(cb))
 {
 	if (!strcmp(var, "pack.writebitmaphashcache")) {
 		if (git_config_bool(var, value))
diff --git a/builtin/remote.c b/builtin/remote.c
index b390360f07..87dda7c37b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1486,7 +1486,7 @@ static int prune(int argc, const char **argv)
 	return result;
 }
 
-static int get_remote_default(const char *key, const char *value, void *priv)
+static int get_remote_default(const char *key, const char *UNUSED(value), void *priv)
 {
 	if (strcmp(key, "remotes.default") == 0) {
 		int *found = priv;
diff --git a/color.c b/color.c
index 4f884c6b3d..04ad0a8bf7 100644
--- a/color.c
+++ b/color.c
@@ -415,7 +415,7 @@ int want_color_fd(int fd, int var)
 	return var;
 }
 
-int git_color_config(const char *var, const char *value, void *cb)
+int git_color_config(const char *var, const char *value, void *UNUSED(cb))
 {
 	if (!strcmp(var, "color.ui")) {
 		git_use_color_default = git_config_colorbool(var, value);
diff --git a/config.c b/config.c
index e8ebef77d5..589dec9028 100644
--- a/config.c
+++ b/config.c
@@ -362,7 +362,8 @@ static void populate_remote_urls(struct config_include_data *inc)
 	current_parsing_scope = store_scope;
 }
 
-static int forbid_remote_url(const char *var, const char *value, void *data)
+static int forbid_remote_url(const char *var, const char *UNUSED(value),
+			     void *UNUSED(data))
 {
 	const char *remote_name;
 	size_t remote_name_len;
diff --git a/convert.c b/convert.c
index 4d153729da..b31a25b536 100644
--- a/convert.c
+++ b/convert.c
@@ -1008,7 +1008,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	return 0;
 }
 
-static int read_convert_config(const char *var, const char *value, void *cb)
+static int read_convert_config(const char *var, const char *value, void *UNUSED(cb))
 {
 	const char *key, *name;
 	size_t namelen;
diff --git a/delta-islands.c b/delta-islands.c
index 13eb96e0c4..c64333f9de 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -316,7 +316,7 @@ static regex_t *island_regexes;
 static unsigned int island_regexes_alloc, island_regexes_nr;
 static const char *core_island_name;
 
-static int island_config_callback(const char *k, const char *v, void *cb)
+static int island_config_callback(const char *k, const char *v, void *UNUSED(cb))
 {
 	if (!strcmp(k, "pack.island")) {
 		struct strbuf re = STRBUF_INIT;
diff --git a/diff.c b/diff.c
index 974626a621..8a9c9083f3 100644
--- a/diff.c
+++ b/diff.c
@@ -264,7 +264,8 @@ void init_diff_ui_defaults(void)
 	diff_detect_rename_default = DIFF_DETECT_RENAME;
 }
 
-int git_diff_heuristic_config(const char *var, const char *value, void *cb)
+int git_diff_heuristic_config(const char *var, const char *value,
+			      void *UNUSED(cb))
 {
 	if (!strcmp(var, "diff.indentheuristic"))
 		diff_indent_heuristic = git_config_bool(var, value);
diff --git a/git-compat-util.h b/git-compat-util.h
index c6669db07d..12239fedf7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -403,7 +403,9 @@ typedef uintmax_t timestamp_t;
 #endif
 
 #ifndef platform_core_config
-static inline int noop_core_config(const char *var, const char *value, void *cb)
+static inline int noop_core_config(const char *UNUSED(var),
+				   const char *UNUSED(value),
+				   void *UNUSED(cb))
 {
 	return 0;
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index 6dff241460..721d69bf42 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -699,7 +699,7 @@ void set_signing_key(const char *key)
 	configured_signing_key = xstrdup(key);
 }
 
-int git_gpg_config(const char *var, const char *value, void *cb)
+int git_gpg_config(const char *var, const char *value, void *UNUSED(cb))
 {
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
diff --git a/ident.c b/ident.c
index 7f66beda42..48745a1f0e 100644
--- a/ident.c
+++ b/ident.c
@@ -668,7 +668,7 @@ static int set_ident(const char *var, const char *value)
 	return 0;
 }
 
-int git_ident_config(const char *var, const char *value, void *data)
+int git_ident_config(const char *var, const char *value, void *UNUSED(data))
 {
 	if (!strcmp(var, "user.useconfigonly")) {
 		ident_use_config_only = git_config_bool(var, value);
diff --git a/ll-merge.c b/ll-merge.c
index 14b8362019..9f3ae1f8fe 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -249,7 +249,8 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
 static const char *default_ll_merge;
 
-static int read_merge_config(const char *var, const char *value, void *cb)
+static int read_merge_config(const char *var, const char *value,
+			     void *UNUSED(cb))
 {
 	struct ll_merge_driver *fn;
 	const char *key, *name;
diff --git a/ls-refs.c b/ls-refs.c
index 98e69373c8..e54b883e87 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -136,7 +136,8 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 	strbuf_release(&namespaced);
 }
 
-static int ls_refs_config(const char *var, const char *value, void *data)
+static int ls_refs_config(const char *var, const char *value,
+			  void *UNUSED(data))
 {
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
diff --git a/pager.c b/pager.c
index 5cfe23b025..19c016ff54 100644
--- a/pager.c
+++ b/pager.c
@@ -38,7 +38,8 @@ static void wait_for_pager_signal(int signo)
 	raise(signo);
 }
 
-static int core_pager_config(const char *var, const char *value, void *data)
+static int core_pager_config(const char *var, const char *value,
+			     void *UNUSED(data))
 {
 	if (!strcmp(var, "core.pager"))
 		return git_config_string(&pager_program, var, value);
diff --git a/pretty.c b/pretty.c
index 6d819103fb..584026b746 100644
--- a/pretty.c
+++ b/pretty.c
@@ -43,7 +43,8 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 	rev->commit_format = CMIT_FMT_USERFORMAT;
 }
 
-static int git_pretty_formats_config(const char *var, const char *value, void *cb)
+static int git_pretty_formats_config(const char *var, const char *value,
+				     void *UNUSED(cb))
 {
 	struct cmt_fmt_map *commit_format = NULL;
 	const char *name;
diff --git a/submodule.c b/submodule.c
index d99c978fa5..597a347f85 100644
--- a/submodule.c
+++ b/submodule.c
@@ -213,7 +213,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 }
 
 /* Cheap function that only determines if we're interested in submodules at all */
-int git_default_submodule_config(const char *var, const char *value, void *cb)
+int git_default_submodule_config(const char *var, const char *value,
+				 void *UNUSED(cb))
 {
 	if (!strcmp(var, "submodule.recurse")) {
 		int v = git_config_bool(var, value) ?
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index a6e936721f..ddd538b838 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -37,7 +37,7 @@
  *
  */
 
-static int iterate_cb(const char *var, const char *value, void *data)
+static int iterate_cb(const char *var, const char *value, void *UNUSED(data))
 {
 	static int nr;
 
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index f013f8a31e..64538a0c20 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -12,7 +12,7 @@ static int driver_cb(struct userdiff_driver *driver,
 	return 0;
 }
 
-static int cmd__userdiff_config(const char *var, const char *value, void *cb)
+static int cmd__userdiff_config(const char *var, const char *value, void *UNUSED(cb))
 {
 	if (userdiff_config(var, value) < 0)
 		return -1;
diff --git a/trailer.c b/trailer.c
index d419c20735..a1e80478ab 100644
--- a/trailer.c
+++ b/trailer.c
@@ -478,7 +478,8 @@ static struct {
 	{ "ifmissing", TRAILER_IF_MISSING }
 };
 
-static int git_trailer_default_config(const char *conf_key, const char *value, void *cb)
+static int git_trailer_default_config(const char *conf_key, const char *value,
+				      void *UNUSED(cb))
 {
 	const char *trailer_item, *variable_name;
 
@@ -509,7 +510,8 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 	return 0;
 }
 
-static int git_trailer_config(const char *conf_key, const char *value, void *cb)
+static int git_trailer_config(const char *conf_key, const char *value,
+			      void *UNUSED(cb))
 {
 	const char *trailer_item, *variable_name;
 	struct arg_item *item;
-- 
2.37.2.928.g0821088f4a

