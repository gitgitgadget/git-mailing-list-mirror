Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4CC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 05:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355557AbhLBFjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 00:39:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:41660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355397AbhLBFjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 00:39:05 -0500
Received: (qmail 18635 invoked by uid 109); 2 Dec 2021 05:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Dec 2021 05:35:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14585 invoked by uid 111); 2 Dec 2021 05:35:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Dec 2021 00:35:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Dec 2021 00:35:43 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Rampersad <josh.rampersad@voiceflow.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] log: handle --decorate-refs with userformat "%d"
Message-ID: <YahbLwYiBWUaCotS@coredump.intra.peff.net>
References: <YahaA/ve7W5Y83Iu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YahaA/ve7W5Y83Iu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to show ref decorations, we first have to load them. If you
run:

  git log --decorate

then git-log will recognize the option and load them up front via
cmd_log_init(). Likewise if log.decorate is set.

If you don't say --decorate explicitly, but do mention "%d" or "%D" in
the output format, like so:

  git log --format=%d

then this also works, because we lazy-load the ref decorations. This has
been true since 3b3d443feb (add '%d' pretty format specifier to show
decoration, 2008-09-04), though the lazy-load was later moved into
log-tree.c.

But there's one problem: that lazy-load just uses the defaults; it
doesn't take into account any --decorate-refs options (or its exclude
variant, or their config). So this does not work:

  git log --decorate-refs=whatever --format=%d

It will decorate using all refs, not just the specified ones. This has
been true since --decorate-refs was added in 65516f586b (log: add option
to choose which refs to decorate, 2017-11-21). Adding further confusion
is that it _may_ work because of the auto-decoration feature. If that's
in use (and it often is, as it's the default), then if the output is
going to stdout, we do enable decorations early (and so load them up
front, respecting the extra options). But otherwise we do not. So:

  git log --decorate-refs=whatever --format=%d >some-file

would typically behave differently than it does when the output goes to
the pager or terminal!

The solution is simple: we should recognize in cmd_log_init() that we're
going to show decorations, and make sure we load them there. We already
check userformat_find_requirements(), so we can couple this with our
existing code there.

There are two new tests. The first shows off the actual fix. The second
makes sure that our fix doesn't cause us to stomp on an existing
--decorate option (see the new comment in the code, as well).

Reported-by: Josh Rampersad <josh.rampersad@voiceflow.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c  | 18 ++++++++++++++++--
 t/t4202-log.sh | 22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7..a924f56299 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -245,8 +245,22 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			rev->abbrev_commit = 0;
 	}
 
-	if (rev->commit_format == CMIT_FMT_USERFORMAT && !w.decorate)
-		decoration_style = 0;
+	if (rev->commit_format == CMIT_FMT_USERFORMAT) {
+		if (!w.decorate) {
+			/*
+			 * Disable decoration loading if the format will not
+			 * show them anyway.
+			 */
+			decoration_style = 0;
+		} else if (!decoration_style) {
+			/*
+			 * If we are going to show them, make sure we do load
+			 * them here, but taking care not to override a
+			 * specific style set by config or --decorate.
+			 */
+			decoration_style = DECORATE_SHORT_REFS;
+		}
+	}
 
 	if (decoration_style) {
 		const struct string_list *config_exclude =
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b..5f0ae7a785 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -952,6 +952,28 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	test_cmp expect.decorate actual
 '
 
+test_expect_success 'decorate-refs with implied decorate from format' '
+	cat >expect <<-\EOF &&
+	side-2 (tag: side-2)
+	side-1
+	EOF
+	git log --no-walk --format="%s%d" \
+		--decorate-refs="*side-2" side-1 side-2 \
+		>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'implied decorate does not override option' '
+	cat >expect <<-\EOF &&
+	side-2 (tag: refs/tags/side-2, refs/heads/side)
+	side-1 (tag: refs/tags/side-1)
+	EOF
+	git log --no-walk --format="%s%d" \
+		--decorate=full side-1 side-2 \
+		>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
2.34.1.328.g8a543840e4

