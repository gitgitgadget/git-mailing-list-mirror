Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94221C6FD1F
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCIGJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCIGJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:09:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08D867F2
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:09:55 -0800 (PST)
Received: (qmail 6267 invoked by uid 109); 9 Mar 2023 06:09:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:09:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28309 invoked by uid 111); 9 Mar 2023 06:09:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:09:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:09:54 -0500
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/5] diff: add --default-prefix option
Message-ID: <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can change the output of prefixes with diff.noprefix and
diff.mnemonicprefix, but there's no easy way to override them from the
command-line. We do have "--no-prefix", but there's no way to get back
to the default prefix. So let's add an option to do that.

Signed-off-by: Jeff King <peff@peff.net>
---
This isn't strictly necessary for the series, but it seemed like a gap.
You can always do:

  git -c diff.noprefix=false -c diff.mnemonicprefix=false ...

but that's rather a mouthful.

Note that there isn't a command-line equivalent for mnemonicprefix,
either. I don't think it's worth adding unless somebody really wants it.

 Documentation/diff-options.txt |  5 +++++
 diff.c                         | 14 ++++++++++++++
 t/t4013-diff-various.sh        | 10 ++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7d73e976d99..08ab86189a7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -852,6 +852,11 @@ endif::git-format-patch[]
 --no-prefix::
 	Do not show any source or destination prefix.
 
+--default-prefix::
+	Use the default source and destination prefixes ("a/" and "b/").
+	This is usually the default already, but may be used to override
+	config such as `diff.noprefix`.
+
 --line-prefix=<prefix>::
 	Prepend an additional prefix to every line of output.
 
diff --git a/diff.c b/diff.c
index 750d1b1a6c3..b322e319ff3 100644
--- a/diff.c
+++ b/diff.c
@@ -5275,6 +5275,17 @@ static int diff_opt_no_prefix(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_default_prefix(const struct option *opt,
+				   const char *optarg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(optarg);
+	diff_set_default_prefix(options);
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5564,6 +5575,9 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
 			       N_("do not show any source or destination prefix"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
+		OPT_CALLBACK_F(0, "default-prefix", options, NULL,
+			       N_("use default prefixes a/ and b/"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_default_prefix),
 		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
 			      N_("show context between diff hunks up to the specified number of lines"),
 			      PARSE_OPT_NONEG),
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 0bc69579898..5de1d190759 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -643,9 +643,19 @@ test_expect_success 'diff respects diff.noprefix' '
 	check_prefix actual file0 file0
 '
 
+test_expect_success 'diff --default-prefix overrides diff.noprefix' '
+	git -c diff.noprefix diff --default-prefix >actual &&
+	check_prefix actual a/file0 b/file0
+'
+
 test_expect_success 'diff respects diff.mnemonicprefix' '
 	git -c diff.mnemonicprefix diff >actual &&
 	check_prefix actual i/file0 w/file0
 '
 
+test_expect_success 'diff --default-prefix overrides diff.mnemonicprefix' '
+	git -c diff.mnemonicprefix diff --default-prefix >actual &&
+	check_prefix actual a/file0 b/file0
+'
+
 test_done
-- 
2.40.0.rc2.537.g928a61c97db

