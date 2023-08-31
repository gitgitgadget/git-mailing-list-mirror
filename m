Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B73C83F30
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbjHaHRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjHaHRv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:17:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5681A3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:17:45 -0700 (PDT)
Received: (qmail 21368 invoked by uid 109); 31 Aug 2023 07:17:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:17:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3495 invoked by uid 111); 31 Aug 2023 07:17:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:17:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:17:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 3/8] parse-options: prefer opt->value to globals in callbacks
Message-ID: <20230831071743.GA3197751@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have several parse-options callbacks that ignore their "opt"
parameters entirely. This is a little unusual, as we'd normally put the
result of the parsing into opt->value. In the case of these callbacks,
though, they directly manipulate global variables instead (and in
most cases the caller sets opt->value to NULL in the OPT_CALLBACK
declaration).

The immediate symptom we'd like to deal with is that the unused "opt"
variables trigger -Wunused-parameter. But how to fix that is debatable.
One option is to annotate them with UNUSED. But another is to have the
caller pass in the appropriate variable via opt->value, and use it. That
has the benefit of making the callbacks reusable (in theory at least),
and makes it clear from the OPT_CALLBACK declaration which variables
will be affected (doubly so for the cases in builtin/fast-export.c,
where we do set opt->value, but it is completely ignored!).

The slight downside is that we lose type safety, since they're now
passing through void pointers.

I went with the "just use them" approach here. The loss of type safety
is unfortunate, but that is already an issue with most of the other
callbacks. If we want to try to address that, we should do so more
consistently (and this patch would prepare these callbacks for whatever
we choose to do there).

Note that in the cases in builtin/fast-export.c, we are passing
anonymous enums. We'll have to give them names so that we can declare
the appropriate pointer type within the callbacks.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to push some of these globals into the cmd_foo()
functions, to make sure we don't make the same mistake again. But there
are lots of ripple effects from other functions which want to access the
globals (and passing them makes the code longer for little benefit).
Plus it would make things inconsistent, with some options globals and
some not. So that can be a cleanup for another day if somebody is
interested (and this takes us one tiny step closer).

 builtin/describe.c           |  6 ++++--
 builtin/fast-export.c        | 36 +++++++++++++++++++++---------------
 builtin/interpret-trailers.c | 12 ++++++------
 builtin/pack-objects.c       | 21 ++++++++++++---------
 4 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b28a4a1f82..718b5c3073 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -561,9 +561,11 @@ static void describe(const char *arg, int last_one)
 static int option_parse_exact_match(const struct option *opt, const char *arg,
 				    int unset)
 {
+	int *val = opt->value;
+
 	BUG_ON_OPT_ARG(arg);
 
-	max_candidates = unset ? DEFAULT_CANDIDATES : 0;
+	*val = unset ? DEFAULT_CANDIDATES : 0;
 	return 0;
 }
 
@@ -578,7 +580,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
 		OPT__ABBREV(&abbrev),
-		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
+		OPT_CALLBACK_F(0, "exact-match", &max_candidates, NULL,
 			       N_("only output exact matches"),
 			       PARSE_OPT_NOARG, option_parse_exact_match),
 		OPT_INTEGER(0, "candidates", &max_candidates,
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 56dc69fac1..70aff515ac 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -33,9 +33,9 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
-static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
-static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
+static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
+static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
+static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
 static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
@@ -53,16 +53,18 @@ static struct revision_sources revision_sources;
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
 {
+	enum signed_tag_mode *val = opt->value;
+
 	if (unset || !strcmp(arg, "abort"))
-		signed_tag_mode = SIGNED_TAG_ABORT;
+		*val = SIGNED_TAG_ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
-		signed_tag_mode = VERBATIM;
+		*val = VERBATIM;
 	else if (!strcmp(arg, "warn"))
-		signed_tag_mode = WARN;
+		*val = WARN;
 	else if (!strcmp(arg, "warn-strip"))
-		signed_tag_mode = WARN_STRIP;
+		*val = WARN_STRIP;
 	else if (!strcmp(arg, "strip"))
-		signed_tag_mode = STRIP;
+		*val = STRIP;
 	else
 		return error("Unknown signed-tags mode: %s", arg);
 	return 0;
@@ -71,12 +73,14 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 					  const char *arg, int unset)
 {
+	enum tag_of_filtered_mode *val = opt->value;
+
 	if (unset || !strcmp(arg, "abort"))
-		tag_of_filtered_mode = TAG_FILTERING_ABORT;
+		*val = TAG_FILTERING_ABORT;
 	else if (!strcmp(arg, "drop"))
-		tag_of_filtered_mode = DROP;
+		*val = DROP;
 	else if (!strcmp(arg, "rewrite"))
-		tag_of_filtered_mode = REWRITE;
+		*val = REWRITE;
 	else
 		return error("Unknown tag-of-filtered mode: %s", arg);
 	return 0;
@@ -85,21 +89,23 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 static int parse_opt_reencode_mode(const struct option *opt,
 				   const char *arg, int unset)
 {
+	enum reencode_mode *val = opt->value;
+
 	if (unset) {
-		reencode_mode = REENCODE_ABORT;
+		*val = REENCODE_ABORT;
 		return 0;
 	}
 
 	switch (git_parse_maybe_bool(arg)) {
 	case 0:
-		reencode_mode = REENCODE_NO;
+		*val = REENCODE_NO;
 		break;
 	case 1:
-		reencode_mode = REENCODE_YES;
+		*val = REENCODE_YES;
 		break;
 	default:
 		if (!strcasecmp(arg, "abort"))
-			reencode_mode = REENCODE_ABORT;
+			*val = REENCODE_ABORT;
 		else
 			return error("Unknown reencoding mode: %s", arg);
 	}
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index c5e8345265..6aadce6a1e 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -26,19 +26,19 @@ static enum trailer_if_missing if_missing;
 static int option_parse_where(const struct option *opt,
 			      const char *arg, int unset)
 {
-	return trailer_set_where(&where, arg);
+	return trailer_set_where(opt->value, arg);
 }
 
 static int option_parse_if_exists(const struct option *opt,
 				  const char *arg, int unset)
 {
-	return trailer_set_if_exists(&if_exists, arg);
+	return trailer_set_if_exists(opt->value, arg);
 }
 
 static int option_parse_if_missing(const struct option *opt,
 				   const char *arg, int unset)
 {
-	return trailer_set_if_missing(&if_missing, arg);
+	return trailer_set_if_missing(opt->value, arg);
 }
 
 static void new_trailers_clear(struct list_head *trailers)
@@ -97,11 +97,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 
-		OPT_CALLBACK(0, "where", NULL, N_("action"),
+		OPT_CALLBACK(0, "where", &where, N_("action"),
 			     N_("where to place the new trailer"), option_parse_where),
-		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
+		OPT_CALLBACK(0, "if-exists", &if_exists, N_("action"),
 			     N_("action if trailer already exists"), option_parse_if_exists),
-		OPT_CALLBACK(0, "if-missing", NULL, N_("action"),
+		OPT_CALLBACK(0, "if-missing", &if_missing, N_("action"),
 			     N_("action if trailer is missing"), option_parse_if_missing),
 
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d2a162d528..492372ee5d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4120,29 +4120,32 @@ static void add_extra_kept_packs(const struct string_list *names)
 static int option_parse_quiet(const struct option *opt, const char *arg,
 			      int unset)
 {
+	int *val = opt->value;
+
 	BUG_ON_OPT_ARG(arg);
 
 	if (!unset)
-		progress = 0;
-	else if (!progress)
-		progress = 1;
+		*val = 0;
+	else if (!*val)
+		*val = 1;
 	return 0;
 }
 
 static int option_parse_index_version(const struct option *opt,
 				      const char *arg, int unset)
 {
+	struct pack_idx_option *popts = opt->value;
 	char *c;
 	const char *val = arg;
 
 	BUG_ON_OPT_NEG(unset);
 
-	pack_idx_opts.version = strtoul(val, &c, 10);
-	if (pack_idx_opts.version > 2)
+	popts->version = strtoul(val, &c, 10);
+	if (popts->version > 2)
 		die(_("unsupported index version %s"), val);
 	if (*c == ',' && c[1])
-		pack_idx_opts.off32_limit = strtoul(c+1, &c, 0);
-	if (*c || pack_idx_opts.off32_limit & 0x80000000)
+		popts->off32_limit = strtoul(c+1, &c, 0);
+	if (*c || popts->off32_limit & 0x80000000)
 		die(_("bad index version '%s'"), val);
 	return 0;
 }
@@ -4190,7 +4193,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		LIST_OBJECTS_FILTER_INIT;
 
 	struct option pack_objects_options[] = {
-		OPT_CALLBACK_F('q', "quiet", NULL, NULL,
+		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
 			       N_("do not show progress meter"),
 			       PARSE_OPT_NOARG, option_parse_quiet),
 		OPT_SET_INT(0, "progress", &progress,
@@ -4200,7 +4203,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "all-progress-implied",
 			 &all_progress_implied,
 			 N_("similar to --all-progress when progress meter is shown")),
-		OPT_CALLBACK_F(0, "index-version", NULL, N_("<version>[,<offset>]"),
+		OPT_CALLBACK_F(0, "index-version", &pack_idx_opts, N_("<version>[,<offset>]"),
 		  N_("write the pack index file in the specified idx format version"),
 		  PARSE_OPT_NONEG, option_parse_index_version),
 		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
-- 
2.42.0.561.gaa987ecc69

