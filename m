Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A44C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 05:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355572AbhLBFlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 00:41:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:41664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355397AbhLBFlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 00:41:16 -0500
Received: (qmail 18643 invoked by uid 109); 2 Dec 2021 05:37:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Dec 2021 05:37:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14595 invoked by uid 111); 2 Dec 2021 05:37:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Dec 2021 00:37:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Dec 2021 00:37:53 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Rampersad <josh.rampersad@voiceflow.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] log: load decorations with --simplify-by-decoration
Message-ID: <YahbseXEC66dK0k8@coredump.intra.peff.net>
References: <YahaA/ve7W5Y83Iu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YahaA/ve7W5Y83Iu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible to specify --simplify-by-decoration but not --decorate. In
this case we do respect the simplification, but we don't actually show
any decorations. However, it works by lazy-loading the decorations when
needed; this is discussed in more detail in 0cc7380d88 (log-tree: call
load_ref_decorations() in get_name_decoration(), 2019-09-08).

This works for basic cases, but will fail to respect any --decorate-refs
option (or its variants). Those are handled only when cmd_log_init()
loads the ref decorations up front, which is only when --decorate is
specified explicitly (or as of the previous commit, when the userformat
asks for %d or similar).

We can solve this by making sure to load the decorations if we're going
to simplify using them but they're not otherwise going to be displayed.

The new test shows a simple case that fails without this patch. Note
that we expect two commits in the output: the one we asked for by
--decorate-refs, and the initial commit. The latter is just a quirk of
how --simplify-by-decoration works. Arguably it may be a bug, but it's
unrelated to this patch (which is just about the loading of the
decorations; you get the same behavior before this patch with an
explicit --decorate).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c  |  5 +++--
 t/t4202-log.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a924f56299..93ace0dde7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -262,7 +262,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		}
 	}
 
-	if (decoration_style) {
+	if (decoration_style || rev->simplify_by_decoration) {
 		const struct string_list *config_exclude =
 			repo_config_get_value_multi(the_repository,
 						    "log.excludeDecoration");
@@ -274,7 +274,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 						   item->string);
 		}
 
-		rev->show_decorations = 1;
+		if (decoration_style)
+			rev->show_decorations = 1;
 
 		load_ref_decorations(&decoration_filter, decoration_style);
 	}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f0ae7a785..7a725b9a23 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -974,6 +974,21 @@ test_expect_success 'implied decorate does not override option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'decorate-refs and simplify-by-decoration without output' '
+	cat >expect <<-\EOF &&
+	side-2
+	initial
+	EOF
+	# Do not just use a --format without %d here; we want to
+	# make sure that we did not accidentally turn on displaying
+	# the decorations, too. And that requires one of the regular
+	# formats.
+	git log --decorate-refs="*side-2" --oneline \
+		--simplify-by-decoration >actual.raw &&
+	sed "s/^[0-9a-f]* //" <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
2.34.1.328.g8a543840e4
