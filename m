Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774AA20437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbdJMRX1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:23:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:52356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750973AbdJMRX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:23:26 -0400
Received: (qmail 31357 invoked by uid 109); 13 Oct 2017 17:23:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 17:23:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27249 invoked by uid 111); 13 Oct 2017 17:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:23:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 13:23:24 -0400
Date:   Fri, 13 Oct 2017 13:23:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 1/4] Revert "color: make "always" the same as "auto" in
 config"
Message-ID: <20171013172323.txugkww6pylwhcnr@sigill.intra.peff.net>
References: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 6be4595edb8e5b616c6e8b9fbc78b0f831fa2a87.

That commit weakened the "always" setting of color config so
that it acted as "auto". This was meant to solve regressions
in v2.14.2 in which setting "color.ui=always" in the on-disk
config broke scripts like add--interactive, because the
plumbing diff commands began to generate color output.

This was due to 136c8c8b8f (color: check color.ui in
git_default_config(), 2017-07-13), which was in turn trying
to fix issues caused by 4c7f1819b3 (make color.ui default to
'auto', 2013-06-10). But in weakening "always", we created
even more problems, as people expect to be able to use "git
-c color.ui=always" to force color (especially because some
commands don't have their own --color flag). We can fix that
by special-casing the command-line "-c", but now things are
getting pretty confusing.

Instead of piling hacks upon hacks, let's start peeling off
the hacks. The first step is dropping the weakening of
"always", which this revert does.

Note that we could actually revert the whole series merged
in by da15b78e52642bd45fd5513ab0000fdf2e58a6f4. Most of that
series consists of preparations to the tests to handle the
weakening of "-c color.ui=always". But it's worth keeping
for a few reasons:

  - there are some other preparatory cleanups, like
    e433749d86 (test-terminal: set TERM=vt100, 2017-10-03)

  - it adds "--color" options more consistently in
    0c88bf5050 (provide --color option for all ref-filter
    users, 2017-10-03)

  - some of the cases dropping "-c" end up being more robust
    and realistic tests, as in 01c94e9001 (t7508: use
    test_terminal for color output, 2017-10-03)

  - the preferred tool for overriding config is "--color",
    and we should be modeling that consistently

We can individually revert the few commits necessary to
restore some useful tests (which will be done on top of this
patch).

Note that this isn't a pure revert; we'll keep the test
added in t3701, but mark it as failure for now.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt   | 35 ++++++++++++++++++-----------------
 color.c                    |  2 +-
 t/t3701-add-interactive.sh |  2 +-
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b53c994d0a..1ac0ae6adb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1058,10 +1058,10 @@ clean.requireForce::
 
 color.branch::
 	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `false` (or `never`) to
-	disable color entirely, `auto` (or `true` or `always`) in which
-	case colors are used only when the output is to a terminal.  If
-	unset, then the value of `color.ui` is used (`auto` by default).
+	linkgit:git-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
 
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
@@ -1072,11 +1072,12 @@ color.branch.<slot>::
 
 color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
-	If this is set to `true` or `auto`, linkgit:git-diff[1],
+	If this is set to `always`, linkgit:git-diff[1],
 	linkgit:git-log[1], and linkgit:git-show[1] will use color
-	when output is to the terminal. The value `always` is a
-	historical synonym for `auto`.  If unset, then the value of
-	`color.ui` is used (`auto` by default).
+	for all patches.  If it is set to `true` or `auto`, those
+	commands will only use color when output is to the terminal.
+	If unset, then the value of `color.ui` is used (`auto` by
+	default).
 +
 This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
@@ -1140,12 +1141,12 @@ color.grep.<slot>::
 --
 
 color.interactive::
-	When set to `true` or `auto`, use colors for interactive prompts
+	When set to `always`, always use colors for interactive prompts
 	and displays (such as those used by "git-add --interactive" and
-	"git-clean --interactive") when the output is to the terminal.
-	When false (or `never`), never show colors. The value `always`
-	is a historical synonym for `auto`.  If unset, then the value of
-	`color.ui` is used (`auto` by default).
+	"git-clean --interactive"). When false (or `never`), never.
+	When set to `true` or `auto`, use colors only when the output is
+	to the terminal. If unset, then the value of `color.ui` is
+	used (`auto` by default).
 
 color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
@@ -1192,10 +1193,10 @@ color.ui::
 	configuration to set a default for the `--color` option.  Set it
 	to `false` or `never` if you prefer Git commands not to use
 	color unless enabled explicitly with some other configuration
-	or the `--color` option. Set it to `true` or `auto` to enable
-	color when output is written to the terminal (this is also the
-	default since Git 1.8.4). The value `always` is a historical
-	synonym for `auto`.
+	or the `--color` option. Set it to `always` if you want all
+	output not intended for machine consumption to use color, to
+	`true` or `auto` (this is the default since Git 1.8.4) if you
+	want such output to use color when written to the terminal.
 
 column.ui::
 	Specify whether supported commands should output in columns.
diff --git a/color.c b/color.c
index 9c0dc82370..9ccd954d6b 100644
--- a/color.c
+++ b/color.c
@@ -308,7 +308,7 @@ int git_config_colorbool(const char *var, const char *value)
 		if (!strcasecmp(value, "never"))
 			return 0;
 		if (!strcasecmp(value, "always"))
-			return var ? GIT_COLOR_AUTO : 1;
+			return 1;
 		if (!strcasecmp(value, "auto"))
 			return GIT_COLOR_AUTO;
 	}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index a49c12c79b..87ffd4d43c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -483,7 +483,7 @@ test_expect_success 'hunk-editing handles custom comment char' '
 	git diff --exit-code
 '
 
-test_expect_success 'add -p works even with color.ui=always' '
+test_expect_failure 'add -p works even with color.ui=always' '
 	git reset --hard &&
 	echo change >>file &&
 	test_config color.ui always &&
-- 
2.15.0.rc1.395.ga4290b5804

