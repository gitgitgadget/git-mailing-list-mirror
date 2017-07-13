Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33385202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbdGMPHG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:07:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:39150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752179AbdGMPHF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:07:05 -0400
Received: (qmail 24352 invoked by uid 109); 13 Jul 2017 15:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:07:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32261 invoked by uid 111); 13 Jul 2017 15:07:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:07:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:07:03 -0400
Date:   Thu, 13 Jul 2017 11:07:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/15] color: check color.ui in git_default_config()
Message-ID: <20170713150703.phnuyezu5lwjtsdi@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in prehistoric times, our decision on whether or not to
show color by default relied on using a config callback that
either did or didn't load color config like color.diff.
When we introduced color.ui, we put it in the same boat:
commands had to manually respect it by using git_color_config()
or its git_color_default_config() convenience wrapper.

But in 4c7f1819b (make color.ui default to 'auto',
2013-06-10), that changed. Since then, we default color.ui
to auto in all programs, meaning that even plumbing commands
like "git diff-tree --pretty" might colorize the output.
Nobody seems to have complained in the intervening years,
presumably because the "is stdout a tty" check does a good
job of catching the right cases.

But that leaves an interesting curiosity: color.ui defaults
to auto even in plumbing, but you can't actually _disable_
the color via config. So if you really hate color and set
"color.ui" to false, diff-tree will still show color (but
porcelain like git-diff won't).  Nobody noticed that either,
probably because very few people disable color.

One could argue that the plumbing should _always_ disable
color unless an explicit --color option is given on the
command line. But in practice, this creates a lot of
complications for scripts which do want plumbing to show
user-visible output. They can't just pass "--color" blindly;
they need to check the user's config and decide what to
send.

Given that nobody has complained about the current behavior,
let's assume it's a good path, and follow it to its
conclusion: supporting color.ui everywhere.

Note that you can create havoc by setting color.ui=always in
your config, but that's more or less already the case. We
could disallow it entirely, but it is handy for one-offs
like:

  git -c color.ui=always foo >not-a-tty

when "foo" does not take a --color option itself.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c      | 2 +-
 builtin/clean.c       | 3 +--
 builtin/grep.c        | 2 +-
 builtin/show-branch.c | 2 +-
 color.c               | 8 --------
 config.c              | 4 ++++
 diff.c                | 3 ---
 7 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 036fdc929..d852ded49 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -92,7 +92,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, branch_colors[slot]);
 	}
-	return git_color_default_config(var, value, cb);
+	return git_default_config(var, value, cb);
 }
 
 static const char *branch_get_color(enum color_branch ix)
diff --git a/builtin/clean.c b/builtin/clean.c
index 057fc97fe..c1bafda5b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -125,8 +125,7 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	/* inspect the color.ui config variable and others */
-	return git_color_default_config(var, value, cb);
+	return git_default_config(var, value, cb);
 }
 
 static const char *clean_get_color(enum color_clean ix)
diff --git a/builtin/grep.c b/builtin/grep.c
index 0d6e66973..a7157f563 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -284,7 +284,7 @@ static int wait_all(void)
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
 	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	if (git_default_config(var, value, cb) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7073a3eb9..28f245c8c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -554,7 +554,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_color_default_config(var, value, cb);
+	return git_default_config(var, value, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
diff --git a/color.c b/color.c
index 31b6207a0..7aa8b076f 100644
--- a/color.c
+++ b/color.c
@@ -361,14 +361,6 @@ int git_color_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-int git_color_default_config(const char *var, const char *value, void *cb)
-{
-	if (git_color_config(var, value, cb) < 0)
-		return -1;
-
-	return git_default_config(var, value, cb);
-}
-
 void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb)
 {
 	if (*color)
diff --git a/config.c b/config.c
index a9356c138..bc290e756 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1350,6 +1351,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (starts_with(var, "advice."))
 		return git_default_advice_config(var, value);
 
+	if (git_color_config(var, value, dummy) < 0)
+		return -1;
+
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
diff --git a/diff.c b/diff.c
index 85e714f6c..9c3825803 100644
--- a/diff.c
+++ b/diff.c
@@ -299,9 +299,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (git_color_config(var, value, cb) < 0)
-		return -1;
-
 	return git_diff_basic_config(var, value, cb);
 }
 
-- 
2.13.2.1157.gc6daca446

