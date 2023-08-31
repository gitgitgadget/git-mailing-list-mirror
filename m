Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D4C83F2E
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbjHaHS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjHaHSY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:18:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614191A4
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:18:21 -0700 (PDT)
Received: (qmail 21374 invoked by uid 109); 31 Aug 2023 07:18:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:18:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3503 invoked by uid 111); 31 Aug 2023 07:18:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:18:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:18:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 4/8] parse-options: mark unused "opt" parameter in callbacks
Message-ID: <20230831071820.GB3197751@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit argued that parse-options callbacks should try to
use opt->value rather than touching globals directly. In some cases,
however, that's awkward to do. Some callbacks touch multiple variables,
or may even just call into an abstracted function that does so.

In some of these cases we _could_ convert them by stuffing the multiple
variables into a single struct and passing the struct pointer through
opt->value. But that may make other parts of the code less readable,
as the struct relationship has to be mentioned everywhere.

Let's just accept that these cases are special and leave them as-is. But
we do need to mark their "opt" parameters to satisfy -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout-index.c |  2 +-
 builtin/fetch.c          |  3 ++-
 builtin/gc.c             |  2 +-
 builtin/log.c            | 16 ++++++++++------
 builtin/merge.c          |  2 +-
 builtin/pack-objects.c   |  6 +++---
 builtin/read-tree.c      |  2 +-
 builtin/update-index.c   |  4 ++--
 8 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index f62f13f2b5..95b3717dd1 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -190,7 +190,7 @@ static const char * const builtin_checkout_index_usage[] = {
 	NULL
 };
 
-static int option_parse_stage(const struct option *opt,
+static int option_parse_stage(const struct option *opt UNUSED,
 			      const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8f93529505..cd2afe33e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -168,7 +168,8 @@ static int git_fetch_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, cb);
 }
 
-static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
+static int parse_refmap_arg(const struct option *opt UNUSED,
+			    const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 369bd43fb2..b842349d86 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1403,7 +1403,7 @@ static void initialize_task_config(int schedule)
 	strbuf_release(&config_name);
 }
 
-static int task_option_parse(const struct option *opt,
+static int task_option_parse(const struct option *opt UNUSED,
 			     const char *arg, int unset)
 {
 	int i, num_selected = 0;
diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..87e29c4171 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -118,16 +118,17 @@ static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
 static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 
-static int clear_decorations_callback(const struct option *opt,
-					    const char *arg, int unset)
+static int clear_decorations_callback(const struct option *opt UNUSED,
+				      const char *arg, int unset)
 {
 	string_list_clear(&decorate_refs_include, 0);
 	string_list_clear(&decorate_refs_exclude, 0);
 	use_default_decoration_filter = 0;
 	return 0;
 }
 
-static int decorate_callback(const struct option *opt, const char *arg, int unset)
+static int decorate_callback(const struct option *opt UNUSED, const char *arg,
+			     int unset)
 {
 	if (unset)
 		decoration_style = 0;
@@ -1555,7 +1556,8 @@ static int inline_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static int header_callback(const struct option *opt, const char *arg, int unset)
+static int header_callback(const struct option *opt UNUSED, const char *arg,
+			   int unset)
 {
 	if (unset) {
 		string_list_clear(&extra_hdr, 0);
@@ -1567,7 +1569,8 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static int to_callback(const struct option *opt, const char *arg, int unset)
+static int to_callback(const struct option *opt UNUSED, const char *arg,
+		       int unset)
 {
 	if (unset)
 		string_list_clear(&extra_to, 0);
@@ -1576,7 +1579,8 @@ static int to_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static int cc_callback(const struct option *opt, const char *arg, int unset)
+static int cc_callback(const struct option *opt UNUSED, const char *arg,
+		       int unset)
 {
 	if (unset)
 		string_list_clear(&extra_cc, 0);
diff --git a/builtin/merge.c b/builtin/merge.c
index 21363b7985..0436986dab 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -231,7 +231,7 @@ static void append_strategy(struct strategy *s)
 	use_strategies[use_strategies_nr++] = s;
 }
 
-static int option_parse_strategy(const struct option *opt,
+static int option_parse_strategy(const struct option *opt UNUSED,
 				 const char *name, int unset)
 {
 	if (unset)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 492372ee5d..91b4b7c177 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3739,7 +3739,7 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	show_object(obj, name, data);
 }
 
-static int option_parse_missing_action(const struct option *opt,
+static int option_parse_missing_action(const struct option *opt UNUSED,
 				       const char *arg, int unset)
 {
 	assert(arg);
@@ -4150,7 +4150,7 @@ static int option_parse_index_version(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_unpack_unreachable(const struct option *opt,
+static int option_parse_unpack_unreachable(const struct option *opt UNUSED,
 					   const char *arg, int unset)
 {
 	if (unset) {
@@ -4165,7 +4165,7 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_cruft_expiration(const struct option *opt,
+static int option_parse_cruft_expiration(const struct option *opt UNUSED,
 					 const char *arg, int unset)
 {
 	if (unset) {
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 1fec702a04..8196ca9dd8 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -49,7 +49,7 @@ static const char * const read_tree_usage[] = {
 	NULL
 };
 
-static int index_output_cb(const struct option *opt, const char *arg,
+static int index_output_cb(const struct option *opt UNUSED, const char *arg,
 				 int unset)
 {
 	BUG_ON_OPT_NEG(unset);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index aee3cb8cbd..59acae3336 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -856,7 +856,7 @@ static int chmod_callback(const struct option *opt,
 	return 0;
 }
 
-static int resolve_undo_clear_callback(const struct option *opt,
+static int resolve_undo_clear_callback(const struct option *opt UNUSED,
 				const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
@@ -890,7 +890,7 @@ static int parse_new_style_cacheinfo(const char *arg,
 }
 
 static enum parse_opt_result cacheinfo_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	struct parse_opt_ctx_t *ctx, const struct option *opt UNUSED,
 	const char *arg, int unset)
 {
 	struct object_id oid;
-- 
2.42.0.561.gaa987ecc69

