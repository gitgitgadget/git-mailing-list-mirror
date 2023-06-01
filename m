Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166EFC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjFARlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjFARlK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 13:41:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B99136
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:41:08 -0700 (PDT)
Received: (qmail 5885 invoked by uid 109); 1 Jun 2023 17:41:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 17:41:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25310 invoked by uid 111); 1 Jun 2023 17:41:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 13:41:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 13:41:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jim Pryor <dubiousjim@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 2/3] diff: factor out --follow pathspec check
Message-ID: <20230601174106.GB4165297@coredump.intra.peff.net>
References: <20230601173724.GA4158369@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601173724.GA4158369@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In --follow mode, we require exactly one pathspec. We check this
condition in two places:

  - in diff_setup_done(), we complain if --follow is used with an
    inapropriate pathspec

  - in git-log's revision "tweak" function, we enable log.follow only if
    the pathspec allows it

The duplication isn't a big deal right now, since the logic is so
simple. But in preparation for it becoming more complex, let's pull it
into a shared function.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't love the die_on_error pattern here, but the obvious alternative
of having the caller die when the boolean is false means it won't be
able to give as descriptive a message. And I didn't think it was worth
getting into passing out an err strbuf, given that there are only these
two callers.

 builtin/log.c |  2 +-
 diff.c        | 14 ++++++++++++--
 diff.h        |  7 +++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 676de107d6..83d9b69dba 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -866,7 +866,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 				      struct setup_revision_opt *opt)
 {
 	if (rev->diffopt.flags.default_follow_renames &&
-	    rev->prune_data.nr == 1)
+	    diff_check_follow_pathspec(&rev->prune_data, 0))
 		rev->diffopt.flags.follow_renames = 1;
 
 	if (rev->first_parent_only)
diff --git a/diff.c b/diff.c
index 3c88c37908..9f548f3471 100644
--- a/diff.c
+++ b/diff.c
@@ -4751,6 +4751,16 @@ unsigned diff_filter_bit(char status)
 	return filter_bit[(int) status];
 }
 
+int diff_check_follow_pathspec(struct pathspec *ps, int die_on_error)
+{
+	if (ps->nr != 1) {
+		if (die_on_error)
+			die(_("--follow requires exactly one pathspec"));
+		return 0;
+	}
+	return 1;
+}
+
 void diff_setup_done(struct diff_options *options)
 {
 	unsigned check_mask = DIFF_FORMAT_NAME |
@@ -4858,8 +4868,8 @@ void diff_setup_done(struct diff_options *options)
 
 	options->diff_path_counter = 0;
 
-	if (options->flags.follow_renames && options->pathspec.nr != 1)
-		die(_("--follow requires exactly one pathspec"));
+	if (options->flags.follow_renames)
+		diff_check_follow_pathspec(&options->pathspec, 1);
 
 	if (!options->use_color || external_diff())
 		options->color_moved = 0;
diff --git a/diff.h b/diff.h
index 3a7a9e8b88..6c10ce289d 100644
--- a/diff.h
+++ b/diff.h
@@ -539,6 +539,13 @@ void repo_diff_setup(struct repository *, struct diff_options *);
 struct option *add_diff_options(const struct option *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
 void diff_setup_done(struct diff_options *);
+
+/*
+ * Returns true if the pathspec can work with --follow mode. If die_on_error is
+ * set, die() with a specific error message rather than returning false.
+ */
+int diff_check_follow_pathspec(struct pathspec *ps, int die_on_error);
+
 int git_config_rename(const char *var, const char *value);
 
 #define DIFF_DETECT_RENAME	1
-- 
2.41.0.346.g8d12207a4f

