Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B53C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCIGHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCIGHI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:07:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB385D333D
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:07:07 -0800 (PST)
Received: (qmail 6237 invoked by uid 109); 9 Mar 2023 06:07:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:07:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28296 invoked by uid 111); 9 Mar 2023 06:07:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:07:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:07:06 -0500
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/5] diff: factor out src/dst prefix setup
Message-ID: <ZAl3iqcSL4PODx01@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We directly manipulate diffopt's a_prefix and b_prefix to set up either
the default "a/foo" prefix or the "--no-prefix" variant. Although this
is only a few lines, it's worth pulling these into their own functions.
That lets us avoid one repetition already in this patch, but will also
give us a cleaner interface for callers which want to tweak this
setting.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 19 ++++++++++++++-----
 diff.h |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 469e18aed20..750d1b1a6c3 100644
--- a/diff.c
+++ b/diff.c
@@ -3374,6 +3374,17 @@ void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const
 		options->b_prefix = b;
 }
 
+void diff_set_noprefix(struct diff_options *options)
+{
+	options->a_prefix = options->b_prefix = "";
+}
+
+void diff_set_default_prefix(struct diff_options *options)
+{
+	options->a_prefix = "a/";
+	options->b_prefix = "b/";
+}
+
 struct userdiff_driver *get_textconv(struct repository *r,
 				     struct diff_filespec *one)
 {
@@ -4674,10 +4685,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 		options->flags.ignore_untracked_in_submodules = 1;
 
 	if (diff_no_prefix) {
-		options->a_prefix = options->b_prefix = "";
+		diff_set_noprefix(options);
 	} else if (!diff_mnemonic_prefix) {
-		options->a_prefix = "a/";
-		options->b_prefix = "b/";
+		diff_set_default_prefix(options);
 	}
 
 	options->color_moved = diff_color_moved_default;
@@ -5261,8 +5271,7 @@ static int diff_opt_no_prefix(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(optarg);
-	options->a_prefix = "";
-	options->b_prefix = "";
+	diff_set_noprefix(options);
 	return 0;
 }
 
diff --git a/diff.h b/diff.h
index 8d770b1d579..2af10bc5851 100644
--- a/diff.h
+++ b/diff.h
@@ -497,6 +497,8 @@ void diff_tree_combined(const struct object_id *oid, const struct oid_array *par
 void diff_tree_combined_merge(const struct commit *commit, struct rev_info *rev);
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
+void diff_set_noprefix(struct diff_options *options);
+void diff_set_default_prefix(struct diff_options *options);
 
 int diff_can_quit_early(struct diff_options *);
 
-- 
2.40.0.rc2.537.g928a61c97db

