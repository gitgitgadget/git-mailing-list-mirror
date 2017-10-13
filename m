Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E059E20437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdJMRYe (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:24:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:52376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751138AbdJMRYe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:24:34 -0400
Received: (qmail 31421 invoked by uid 109); 13 Oct 2017 17:24:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 17:24:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27285 invoked by uid 111); 13 Oct 2017 17:24:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:24:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 13:24:31 -0400
Date:   Fri, 13 Oct 2017 13:24:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 3/4] Revert "color: check color.ui in git_default_config()"
Message-ID: <20171013172431.7v6voqt2qd6suhno@sigill.intra.peff.net>
References: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 136c8c8b8fa39f1315713248473dececf20f8fe7.

That commit was trying to address a bug caused by 4c7f1819b3
(make color.ui default to 'auto', 2013-06-10), in which
plumbing like diff-tree defaulted to "auto" color, but did
not respect a "color.ui" directive to disable it.

But it also meant that we started respecting "color.ui" set
to "always". This was a known problem, but 4c7f1819b3 argued
that nobody ought to be doing that. However, that turned out
to be wrong, and we got a number of bug reports related to
"add -p" regressing in v2.14.2.

Let's revert 136c8c8b8, fixing the regression to "add -p".
This leaves the problem from 4c7f1819b3 unfixed, but:

  1. It's a pretty obscure problem in the first place. I
     only noticed it while working on the color code, and we
     haven't got a single bug report or complaint about it.

  2. We can make a more moderate fix on top by respecting
     "never" but not "always" for plumbing commands. This
     is just the minimal fix to go back to the working state
     we had before v2.14.2.

Note that this isn't a pure revert. We now have a test in
t3701 which shows off the "add -p" regression. This can be
flipped to success.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c           | 2 +-
 builtin/clean.c            | 3 ++-
 builtin/grep.c             | 2 +-
 builtin/show-branch.c      | 2 +-
 color.c                    | 8 ++++++++
 config.c                   | 4 ----
 diff.c                     | 3 +++
 t/t3701-add-interactive.sh | 2 +-
 8 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b67593288c..79dc9181fd 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -93,7 +93,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, branch_colors[slot]);
 	}
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static const char *branch_get_color(enum color_branch ix)
diff --git a/builtin/clean.c b/builtin/clean.c
index 733b6d3745..189e20628c 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -126,7 +126,8 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	/* inspect the color.ui config variable and others */
+	return git_color_default_config(var, value, cb);
 }
 
 static const char *clean_get_color(enum color_clean ix)
diff --git a/builtin/grep.c b/builtin/grep.c
index 19e23946ac..2d65f27d01 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -275,7 +275,7 @@ static int wait_all(void)
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
 	int st = grep_config(var, value, cb);
-	if (git_default_config(var, value, cb) < 0)
+	if (git_color_default_config(var, value, cb) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 84547d6fba..6fa1f62a88 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -554,7 +554,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
diff --git a/color.c b/color.c
index 9ccd954d6b..9a9261ac16 100644
--- a/color.c
+++ b/color.c
@@ -368,6 +368,14 @@ int git_color_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+int git_color_default_config(const char *var, const char *value, void *cb)
+{
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
+}
+
 void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb)
 {
 	if (*color)
diff --git a/config.c b/config.c
index 4831c12735..adb7d7a3e5 100644
--- a/config.c
+++ b/config.c
@@ -16,7 +16,6 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
-#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1351,9 +1350,6 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (starts_with(var, "advice."))
 		return git_default_advice_config(var, value);
 
-	if (git_color_config(var, value, dummy) < 0)
-		return -1;
-
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
diff --git a/diff.c b/diff.c
index 69f03570ad..30b2e271b0 100644
--- a/diff.c
+++ b/diff.c
@@ -358,6 +358,9 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
 	return git_diff_basic_config(var, value, cb);
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 87ffd4d43c..a49c12c79b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -483,7 +483,7 @@ test_expect_success 'hunk-editing handles custom comment char' '
 	git diff --exit-code
 '
 
-test_expect_failure 'add -p works even with color.ui=always' '
+test_expect_success 'add -p works even with color.ui=always' '
 	git reset --hard &&
 	echo change >>file &&
 	test_config color.ui always &&
-- 
2.15.0.rc1.395.ga4290b5804

