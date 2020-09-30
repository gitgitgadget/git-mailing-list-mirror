Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED26C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5C82071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgI3MaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:30:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:45322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgI3MaL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:30:11 -0400
Received: (qmail 23966 invoked by uid 109); 30 Sep 2020 12:30:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:30:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28014 invoked by uid 111); 30 Sep 2020 12:30:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:30:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:30:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/10] sparse-checkout: fill in some options boilerplate
Message-ID: <20200930123010.GG1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sparse-checkout passes along argv and argc to its sub-command helper
functions. Many of these sub-commands do not yet take any command-line
options, and ignore those parameters.

Let's instead add empty option lists and make sure we call
parse_options(). That will give a useful error message for something
like:

  git sparse-checkout list --nonsense

which currently just silently ignores the unknown option.

As a bonus, it also silences some -Wunused-parameter warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 4003f4d13a..e3140db2a0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -46,12 +46,24 @@ static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
 	}
 }
 
+static char const * const builtin_sparse_checkout_list_usage[] = {
+	N_("git sparse-checkout list"),
+	NULL
+};
+
 static int sparse_checkout_list(int argc, const char **argv)
 {
+	static struct option builtin_sparse_checkout_list_options[] = {
+		OPT_END(),
+	};
 	struct pattern_list pl;
 	char *sparse_filename;
 	int res;
 
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_list_options,
+			     builtin_sparse_checkout_list_usage, 0);
+
 	memset(&pl, 0, sizeof(pl));
 
 	pl.use_cone_patterns = core_sparse_checkout_cone;
@@ -560,17 +572,42 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	return modify_pattern_list(argc, argv, m);
 }
 
+static char const * const builtin_sparse_checkout_reapply_usage[] = {
+	N_("git sparse-checkout reapply"),
+	NULL
+};
+
 static int sparse_checkout_reapply(int argc, const char **argv)
 {
+	static struct option builtin_sparse_checkout_reapply_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_reapply_options,
+			     builtin_sparse_checkout_reapply_usage, 0);
+
 	repo_read_index(the_repository);
 	return update_working_directory(NULL);
 }
 
+static char const * const builtin_sparse_checkout_disable_usage[] = {
+	N_("git sparse-checkout disable"),
+	NULL
+};
+
 static int sparse_checkout_disable(int argc, const char **argv)
 {
+	static struct option builtin_sparse_checkout_disable_options[] = {
+		OPT_END(),
+	};
 	struct pattern_list pl;
 	struct strbuf match_all = STRBUF_INIT;
 
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_disable_options,
+			     builtin_sparse_checkout_disable_usage, 0);
+
 	repo_read_index(the_repository);
 
 	memset(&pl, 0, sizeof(pl));
-- 
2.28.0.1173.gad90222cf0

