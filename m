Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89DEF2036C
	for <e@80x24.org>; Tue,  3 Oct 2017 13:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJCNqK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:46:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:59206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751116AbdJCNqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:46:09 -0400
Received: (qmail 29702 invoked by uid 109); 3 Oct 2017 13:46:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:46:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8016 invoked by uid 111); 3 Oct 2017 13:46:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:46:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:46:06 -0400
Date:   Tue, 3 Oct 2017 09:46:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 12/12] color: make "always" the same as "auto" in config
Message-ID: <20171003134606.2r2653znqidt2mgx@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be handy to use `--color=always` (or it's synonym
`--color`) on the command-line to convince a command to
produce color even if it's stdout isn't going to the
terminal or a pager.

What's less clear is whether it makes sense to set config
variables like color.ui to `always`. For a one-shot like:

  git -c color.ui=always ...

it's potentially useful (especially if the command doesn't
directly support the `--color` option). But setting `always`
in your on-disk config is much muddier, as you may be
surprised when piped commands generate colors (and send them
to whatever is consuming the pipe downstream).

Some people have done this anyway, because:

  1. The documentation for color.ui makes it sound like
     using `always` is a good idea, when you almost
     certainly want `auto`.

  2. Traditionally not every command (and especially not
     plumbing) respected color.ui in the first place. So
     the confusion came up less frequently than it might
     have.

The situation changed in 136c8c8b8f (color: check color.ui
in git_default_config(), 2017-07-13), which negated point
(2): now scripts using only plumbing commands (like
add-interactive) are broken by this setting.

That commit was fixing real issues (e.g., by making
`color.ui=never` work, since `auto` is the default), so we
don't want to just revert it.  We could turn `always` into a
noop in plumbing commands, but that creates a hard-to-explain
inconsistency between the plumbing and other commands.

Instead, let's just turn `always` into `auto` for all config.
This does break the "one-shot" config shown above, but again,
we're probably better to have simple and consistent rules than
to try to special-case command-line config.

There is one place where `always` should retain its meaning:
on the command line, `--color=always` should continue to be
the same as `--color`, overriding any isatty checks. Since the
command-line parser also depends on git_config_colorbool(), we
can use the existence of the "var" string to deterine whether
we are serving the command-line or the config.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt   | 35 +++++++++++++++++------------------
 color.c                    |  2 +-
 t/t3701-add-interactive.sh | 10 ++++++++++
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb..b53c994d0a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1058,10 +1058,10 @@ clean.requireForce::
 
 color.branch::
 	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	linkgit:git-branch[1]. May be set to `false` (or `never`) to
+	disable color entirely, `auto` (or `true` or `always`) in which
+	case colors are used only when the output is to a terminal.  If
+	unset, then the value of `color.ui` is used (`auto` by default).
 
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
@@ -1072,12 +1072,11 @@ color.branch.<slot>::
 
 color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
-	If this is set to `always`, linkgit:git-diff[1],
+	If this is set to `true` or `auto`, linkgit:git-diff[1],
 	linkgit:git-log[1], and linkgit:git-show[1] will use color
-	for all patches.  If it is set to `true` or `auto`, those
-	commands will only use color when output is to the terminal.
-	If unset, then the value of `color.ui` is used (`auto` by
-	default).
+	when output is to the terminal. The value `always` is a
+	historical synonym for `auto`.  If unset, then the value of
+	`color.ui` is used (`auto` by default).
 +
 This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
@@ -1141,12 +1140,12 @@ color.grep.<slot>::
 --
 
 color.interactive::
-	When set to `always`, always use colors for interactive prompts
+	When set to `true` or `auto`, use colors for interactive prompts
 	and displays (such as those used by "git-add --interactive" and
-	"git-clean --interactive"). When false (or `never`), never.
-	When set to `true` or `auto`, use colors only when the output is
-	to the terminal. If unset, then the value of `color.ui` is
-	used (`auto` by default).
+	"git-clean --interactive") when the output is to the terminal.
+	When false (or `never`), never show colors. The value `always`
+	is a historical synonym for `auto`.  If unset, then the value of
+	`color.ui` is used (`auto` by default).
 
 color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
@@ -1193,10 +1192,10 @@ color.ui::
 	configuration to set a default for the `--color` option.  Set it
 	to `false` or `never` if you prefer Git commands not to use
 	color unless enabled explicitly with some other configuration
-	or the `--color` option. Set it to `always` if you want all
-	output not intended for machine consumption to use color, to
-	`true` or `auto` (this is the default since Git 1.8.4) if you
-	want such output to use color when written to the terminal.
+	or the `--color` option. Set it to `true` or `auto` to enable
+	color when output is written to the terminal (this is also the
+	default since Git 1.8.4). The value `always` is a historical
+	synonym for `auto`.
 
 column.ui::
 	Specify whether supported commands should output in columns.
diff --git a/color.c b/color.c
index 9ccd954d6b..9c0dc82370 100644
--- a/color.c
+++ b/color.c
@@ -308,7 +308,7 @@ int git_config_colorbool(const char *var, const char *value)
 		if (!strcasecmp(value, "never"))
 			return 0;
 		if (!strcasecmp(value, "always"))
-			return 1;
+			return var ? GIT_COLOR_AUTO : 1;
 		if (!strcasecmp(value, "auto"))
 			return GIT_COLOR_AUTO;
 	}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 39d0130f88..a49c12c79b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -483,4 +483,14 @@ test_expect_success 'hunk-editing handles custom comment char' '
 	git diff --exit-code
 '
 
+test_expect_success 'add -p works even with color.ui=always' '
+	git reset --hard &&
+	echo change >>file &&
+	test_config color.ui always &&
+	echo y | git add -p &&
+	echo file >expect &&
+	git diff --cached --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2.1079.gce6b466188
