Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E4C83F2B
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbjHaHMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjHaHMf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:12:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38CB1A3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:12:31 -0700 (PDT)
Received: (qmail 21343 invoked by uid 109); 31 Aug 2023 07:12:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:12:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3448 invoked by uid 111); 31 Aug 2023 07:12:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:12:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:12:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 1/8] merge: make xopts a strvec
Message-ID: <20230831071230.GA3197647@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "xopts" variable uses a custom array with ALLOC_GROW(). Using a
strvec simplifies things a bit. We need fewer variables, and we can also
ditch our custom parseopt callback in favor of OPT_STRVEC().

As a bonus, this means that "--no-strategy-option", which was previously
a silent noop, now does something useful: like other list-like options,
it will clear the list of -X options seen so far.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess you could argue this is a backwards-incompatible change, but the
existing behavior of --no-strategy-option is so dumb that I can't
believe somebody would prefer it (plus revert/cherry-pick already use
OPT_STRVEC for their matching "-X").

I didn't bother adding a test since we're just re-using OPT_STRVEC code
that is used elsewhere.

 builtin/merge.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index de68910177..53e9fe70d9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -79,8 +79,7 @@ static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
-static const char **xopts;
-static size_t xopts_nr, xopts_alloc;
+static struct strvec xopts = STRVEC_INIT;
 static const char *branch;
 static char *branch_mergeoptions;
 static int verbosity;
@@ -242,17 +241,6 @@ static int option_parse_strategy(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_x(const struct option *opt,
-			  const char *arg, int unset)
-{
-	if (unset)
-		return 0;
-
-	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
-	xopts[xopts_nr++] = xstrdup(arg);
-	return 0;
-}
-
 static int option_parse_n(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -287,8 +275,8 @@ static struct option builtin_merge_options[] = {
 		N_("verify that the named commit has a valid GPG signature")),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
-	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=value"),
-		N_("option for selected merge strategy"), option_parse_x),
+	OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
+		N_("option for selected merge strategy")),
 	OPT_CALLBACK('m', "message", &merge_msg, N_("message"),
 		N_("merge commit message (for a non-fast-forward merge)"),
 		option_parse_message),
@@ -749,9 +737,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		o.show_rename_progress =
 			show_progress == -1 ? isatty(2) : show_progress;
 
-		for (x = 0; x < xopts_nr; x++)
-			if (parse_merge_opt(&o, xopts[x]))
-				die(_("unknown strategy option: -X%s"), xopts[x]);
+		for (x = 0; x < xopts.nr; x++)
+			if (parse_merge_opt(&o, xopts.v[x]))
+				die(_("unknown strategy option: -X%s"), xopts.v[x]);
 
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
@@ -777,7 +765,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(the_repository,
-					 strategy, xopts_nr, xopts,
+					 strategy, xopts.nr, xopts.v,
 					 common, head_arg, remoteheads);
 	}
 }
-- 
2.42.0.561.gaa987ecc69

