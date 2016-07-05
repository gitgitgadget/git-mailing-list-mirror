Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BF72070C
	for <e@80x24.org>; Tue,  5 Jul 2016 20:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbcGEUov (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 16:44:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:40655 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752151AbcGEUou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 16:44:50 -0400
Received: (qmail 15121 invoked by uid 102); 5 Jul 2016 20:44:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jul 2016 16:44:50 -0400
Received: (qmail 18161 invoked by uid 107); 5 Jul 2016 20:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jul 2016 16:45:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jul 2016 16:44:47 -0400
Date:	Tue, 5 Jul 2016 16:44:47 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
Message-ID: <20160705204447.GB14496@sigill.intra.peff.net>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
 <20160705202820.GA14496@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160705202820.GA14496@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 05, 2016 at 04:28:20PM -0400, Jeff King wrote:

> I wonder if parse_options_concat should simply allocate a new list
> (after computing the total required size). I guess this is the only
> caller, though, so perhaps it's not the end of the world. In the
> meantime, your patch is certainly an improvement.

Something like the patch below.

I admit this isn't buggy _now_, so this is potentially just churn. It
does make further patches look nicer, though (they don't have to add
apparently meaningless OPT_END() slots).

-- >8 --
Subject: [PATCH] parse_options: allocate a new array when concatenating

In exactly one callers (builtin/revert.c), we build up the
options list dynamically from multiple arrays. We do so by
manually inserting "filler" entries into one array, and then
copying the other array into the allocated space.

This is tedious and error-prone, as you have to adjust the
filler any time the second array is modified (although we do
at least check and die() when the counts do not match up).

Instead, let's just allocate a new array.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/revert.c   | 13 ++++---------
 parse-options-cb.c | 29 +++++++++++++++++------------
 parse-options.h    |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 56a2c36..4e69380 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -76,7 +76,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	int cmd = 0;
-	struct option options[] = {
+	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
@@ -91,13 +91,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			N_("option for merge strategy"), option_parse_x),
 		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_END(),
-		OPT_END(),
-		OPT_END(),
-		OPT_END(),
-		OPT_END(),
-		OPT_END(),
+		OPT_END()
 	};
+	struct option *options = base_options;
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
@@ -108,8 +104,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
 			OPT_END(),
 		};
-		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
-			die(_("program error"));
+		options = parse_options_concat(options, cp_extra);
 	}
 
 	argc = parse_options(argc, argv, NULL, options, usage_str,
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 239898d..2d87520 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -117,19 +117,24 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int parse_options_concat(struct option *dst, size_t dst_size, struct option *src)
+struct option *parse_options_concat(struct option *a, struct option *b)
 {
-	int i, j;
-
-	for (i = 0; i < dst_size; i++)
-		if (dst[i].type == OPTION_END)
-			break;
-	for (j = 0; i < dst_size; i++, j++) {
-		dst[i] = src[j];
-		if (src[j].type == OPTION_END)
-			return 0;
-	}
-	return -1;
+	struct option *ret;
+	size_t i, a_len = 0, b_len = 0;
+
+	for (i = 0; a[i].type != OPTION_END; i++)
+		a_len++;
+	for (i = 0; b[i].type != OPTION_END; i++)
+		b_len++;
+
+	ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
+	for (i = 0; i < a_len; i++)
+		ret[i] = a[i];
+	for (i = 0; i < b_len; i++)
+		ret[a_len + i] = b[i];
+	ret[a_len + b_len] = b[b_len]; /* final OPTION_END */
+
+	return ret;
 }
 
 int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
diff --git a/parse-options.h b/parse-options.h
index ea4af92..78f8384 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -215,7 +215,7 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
-extern int parse_options_concat(struct option *dst, size_t, struct option *src);
+extern struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
-- 
2.9.0.320.gd3e6182

