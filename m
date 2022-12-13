Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86645C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiLMLPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiLMLPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:15:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE091D676
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:13:49 -0800 (PST)
Received: (qmail 14498 invoked by uid 109); 13 Dec 2022 11:13:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:13:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4319 invoked by uid 111); 13 Dec 2022 11:13:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:13:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:13:48 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 7/9] diff: mark unused parameters in callbacks
Message-ID: <Y5hebAsGdsRBgwhD@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diff code provides a format_callback interface, but not every
callback needs each parameter (e.g., the "opt" and "data" parameters are
frequently left unused). Likewise for the output_prefix callback, the
low-level change/add_remove interfaces, the callbacks used by
xdi_diff(), etc.

Mark unused arguments in the callback implementations to quiet
-Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c           |  2 +-
 builtin/add.c               |  2 +-
 builtin/fast-export.c       |  2 +-
 builtin/merge-tree.c        |  2 +-
 builtin/merge.c             |  2 +-
 builtin/rerere.c            |  2 +-
 builtin/reset.c             |  3 ++-
 builtin/submodule--helper.c |  2 +-
 combine-diff.c              |  2 +-
 diff-lib.c                  |  2 +-
 diff.c                      |  7 ++++---
 range-diff.c                | 12 ++++++++----
 revision.c                  | 25 +++++++++++++++----------
 submodule.c                 |  2 +-
 wt-status.c                 |  4 ++--
 15 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index ae1839c04a..00a0f6f96f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -724,7 +724,7 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 }
 
 static void revert_from_diff(struct diff_queue_struct *q,
-			     struct diff_options *opt, void *data)
+			     struct diff_options *opt, void *data UNUSED)
 {
 	int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
 
diff --git a/builtin/add.c b/builtin/add.c
index 76277df326..190d1a692a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -88,7 +88,7 @@ static int fix_unmerged_status(struct diff_filepair *p,
 }
 
 static void update_callback(struct diff_queue_struct *q,
-			    struct diff_options *opt, void *cbdata)
+			    struct diff_options *opt UNUSED, void *cbdata)
 {
 	int i;
 	struct update_callback_data *data = cbdata;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 3b3314e7b2..39a890fc00 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -409,7 +409,7 @@ static const char *anonymize_oid(const char *oid_hex)
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
-			    struct diff_options *options, void *data)
+			    struct diff_options *options UNUSED, void *data)
 {
 	int i;
 	struct string_list *changed = data;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e3767087bb..ae2c011681 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -98,7 +98,7 @@ static void *origin(struct merge_list *entry, unsigned long *size)
 	return NULL;
 }
 
-static int show_outf(void *priv_, mmbuffer_t *mb, int nbuf)
+static int show_outf(void *priv UNUSED, mmbuffer_t *mb, int nbuf)
 {
 	int i;
 	for (i = 0; i < nbuf; i++)
diff --git a/builtin/merge.c b/builtin/merge.c
index dd474371a2..17b41fbe38 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -776,7 +776,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 }
 
 static void count_diff_files(struct diff_queue_struct *q,
-			     struct diff_options *opt, void *data)
+			     struct diff_options *opt UNUSED, void *data)
 {
 	int *count = data;
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 8b7392d5b4..94ffb8c21a 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -14,7 +14,7 @@ static const char * const rerere_usage[] = {
 	NULL,
 };
 
-static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
+static int outf(void *dummy UNUSED, mmbuffer_t *ptr, int nbuf)
 {
 	int i;
 	for (i = 0; i < nbuf; i++)
diff --git a/builtin/reset.c b/builtin/reset.c
index 1fa86edb4c..d2e0185e55 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -133,7 +133,8 @@ static void print_new_head_line(struct commit *commit)
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
-		struct diff_options *opt, void *data)
+				   struct diff_options *opt UNUSED,
+				   void *data)
 {
 	int i;
 	int intent_to_add = *(int *)data;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 05f2c9bc98..6743fb27bd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1043,7 +1043,7 @@ static void prepare_submodule_summary(struct summary_cb *info,
 }
 
 static void submodule_summary_callback(struct diff_queue_struct *q,
-				       struct diff_options *options,
+				       struct diff_options *options UNUSED,
 				       void *data)
 {
 	int i;
diff --git a/combine-diff.c b/combine-diff.c
index b0ece95480..1a39b5dde0 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -372,7 +372,7 @@ struct combine_diff_state {
 static void consume_hunk(void *state_,
 			 long ob, long on,
 			 long nb, long nn,
-			 const char *funcline, long funclen)
+			 const char *func UNUSED, long funclen UNUSED)
 {
 	struct combine_diff_state *state = state_;
 
diff --git a/diff-lib.c b/diff-lib.c
index 2edea41a23..dec040c366 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -673,7 +673,7 @@ int index_differs_from(struct repository *r,
 	return (has_changes != 0);
 }
 
-static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
+static struct strbuf *idiff_prefix_cb(struct diff_options *opt UNUSED, void *data)
 {
 	return data;
 }
diff --git a/diff.c b/diff.c
index 74ebe247b4..830291080b 100644
--- a/diff.c
+++ b/diff.c
@@ -1954,7 +1954,7 @@ static int color_words_output_graph_prefix(struct diff_words_data *diff_words)
 static void fn_out_diff_words_aux(void *priv,
 				  long minus_first, long minus_len,
 				  long plus_first, long plus_len,
-				  const char *func, long funclen)
+				  const char *func UNUSED, long funclen UNUSED)
 {
 	struct diff_words_data *diff_words = priv;
 	struct diff_words_style *style = diff_words->style;
@@ -3184,8 +3184,9 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 }
 
 static void checkdiff_consume_hunk(void *priv,
-				   long ob, long on, long nb, long nn,
-				   const char *func, long funclen)
+				   long ob UNUSED, long on UNUSED,
+				   long nb, long nn UNUSED,
+				   const char *func UNUSED, long funclen UNUSED)
 
 {
 	struct checkdiff_t *data = priv;
diff --git a/range-diff.c b/range-diff.c
index 8b7d81adc1..8255ab4349 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -269,14 +269,18 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 	hashmap_clear(&map);
 }
 
-static int diffsize_consume(void *data, char *line, unsigned long len)
+static int diffsize_consume(void *data,
+			     char *line UNUSED,
+			     unsigned long len UNUSED)
 {
 	(*(int *)data)++;
 	return 0;
 }
 
-static void diffsize_hunk(void *data, long ob, long on, long nb, long nn,
-			  const char *funcline, long funclen)
+static void diffsize_hunk(void *data,
+			  long ob UNUSED, long on UNUSED,
+			  long nb UNUSED, long nn UNUSED,
+			  const char *func UNUSED, long funclen UNUSED)
 {
 	diffsize_consume(data, NULL, 0);
 }
@@ -461,7 +465,7 @@ static void patch_diff(const char *a, const char *b,
 	diff_flush(diffopt);
 }
 
-static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
+static struct strbuf *output_prefix_cb(struct diff_options *opt UNUSED, void *data)
 {
 	return data;
 }
diff --git a/revision.c b/revision.c
index 439e34a7c5..ec441b80ef 100644
--- a/revision.c
+++ b/revision.c
@@ -600,10 +600,12 @@ static struct commit *one_relevant_parent(const struct rev_info *revs,
 static int tree_difference = REV_TREE_SAME;
 
 static void file_add_remove(struct diff_options *options,
-		    int addremove, unsigned mode,
-		    const struct object_id *oid,
-		    int oid_valid,
-		    const char *fullpath, unsigned dirty_submodule)
+		    int addremove,
+		    unsigned mode UNUSED,
+		    const struct object_id *oid UNUSED,
+		    int oid_valid UNUSED,
+		    const char *fullpath UNUSED,
+		    unsigned dirty_submodule UNUSED)
 {
 	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
 	struct rev_info *revs = options->change_fn_data;
@@ -614,12 +616,15 @@ static void file_add_remove(struct diff_options *options,
 }
 
 static void file_change(struct diff_options *options,
-		 unsigned old_mode, unsigned new_mode,
-		 const struct object_id *old_oid,
-		 const struct object_id *new_oid,
-		 int old_oid_valid, int new_oid_valid,
-		 const char *fullpath,
-		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
+		 unsigned old_mode UNUSED,
+		 unsigned new_mode UNUSED,
+		 const struct object_id *old_oid UNUSED,
+		 const struct object_id *new_oid UNUSED,
+		 int old_oid_valid UNUSED,
+		 int new_oid_valid UNUSED,
+		 const char *fullpath UNUSED,
+		 unsigned old_dirty_submodule UNUSED,
+		 unsigned new_dirty_submodule UNUSED)
 {
 	tree_difference = REV_TREE_DIFFERENT;
 	options->flags.has_changes = 1;
diff --git a/submodule.c b/submodule.c
index 8ac2fca855..fae24ef34a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -832,7 +832,7 @@ static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
 }
 
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
-					  struct diff_options *options,
+					  struct diff_options *options UNUSED,
 					  void *data)
 {
 	struct collect_changed_submodules_cb_data *me = data;
diff --git a/wt-status.c b/wt-status.c
index 5813174896..76e37a8088 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -438,7 +438,7 @@ static char short_submodule_status(struct wt_status_change_data *d)
 }
 
 static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
-					 struct diff_options *options,
+					 struct diff_options *options UNUSED,
 					 void *data)
 {
 	struct wt_status *s = data;
@@ -525,7 +525,7 @@ static int unmerged_mask(struct index_state *istate, const char *path)
 }
 
 static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
-					 struct diff_options *options,
+					 struct diff_options *options UNUSED,
 					 void *data)
 {
 	struct wt_status *s = data;
-- 
2.39.0.546.g5ea984bc66

