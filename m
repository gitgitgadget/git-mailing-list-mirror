Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5647B202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbdGMPIt (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:08:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:39168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752251AbdGMPIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:08:48 -0400
Received: (qmail 24454 invoked by uid 109); 13 Jul 2017 15:08:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:08:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32309 invoked by uid 111); 13 Jul 2017 15:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:09:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:08:46 -0400
Date:   Thu, 13 Jul 2017 11:08:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/15] pretty: respect color settings for %C placeholders
Message-ID: <20170713150845.yodu6al56po662so@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The color placeholders have traditionally been
unconditional, showing colors even when git is not otherwise
configured to do so. This was not so bad for their original
use, which was on the command-line (and the user could
decide at that moment whether to add colors or not). But
these days we have configured formats via pretty.*, and
those should operate correctly in multiple contexts.

In 3082517 (log --format: teach %C(auto,black) to respect
color config, 2012-12-17), we gave an extended placeholder
that could be used to accomplish this. But it's rather
clunky to use, because you have to specify it individually
for each color (and their matching resets) in the format.
We shied away from just switching the default to auto,
because it is technically breaking backwards compatibility.

However, there's not really a use case for unconditional
colors. The most plausible reason you would want them is to
redirect "git log" output to a file. But there, the right
answer is --color=always, as it does the right thing both
with custom user-format colors and git-generated colors.

So let's switch to the more useful default. In the
off-chance that somebody really does find a use for
unconditional colors without wanting to enable the rest of
git's colors, we provide a new %C(always,...) to enable the
old behavior. And we can remind them of --color=always in
the documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
The test diff is a lot easier to read with "-w", as it moves all of the
%C(auto,...) tests into a loop that checks all three variants.

 Documentation/pretty-formats.txt | 18 +++++----
 pretty.c                         | 27 +++++++++++--
 t/t6006-rev-list-format.sh       | 84 ++++++++++++++++++++++++----------------
 3 files changed, 84 insertions(+), 45 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 4d6dac577..973d19606 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -173,13 +173,17 @@ endif::git-rev-list[]
 - '%Cblue': switch color to blue
 - '%Creset': reset color
 - '%C(...)': color specification, as described under Values in the
-  "CONFIGURATION FILE" section of linkgit:git-config[1];
-  adding `auto,` at the beginning (e.g. `%C(auto,red)`) will emit
-  color only when colors are enabled for log output (by `color.diff`,
-  `color.ui`, or `--color`, and respecting the `auto` settings of the
-  former if we are going to a terminal). `auto` alone (i.e.
-  `%C(auto)`) will turn on auto coloring on the next placeholders
-  until the color is switched again.
+  "CONFIGURATION FILE" section of linkgit:git-config[1].
+  By default, colors are shown only when enabled for log output (by
+  `color.diff`, `color.ui`, or `--color`, and respecting the `auto`
+  settings of the former if we are going to a terminal). `%C(auto,...)`
+  is accepted as a historical synonym for the default (e.g.,
+  `%C(auto,red)`). Specifying `%C(always,...) will show the colors
+  even when color is not otherwise enabled (though consider
+  just using `--color=always` to enable color for the whole output,
+  including this format and anything else git might color).  `auto`
+  alone (i.e. `%C(auto)`) will turn on auto coloring on the next
+  placeholders until the color is switched again.
 - '%m': left (`<`), right (`>`) or boundary (`-`) mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/pretty.c b/pretty.c
index e4b561c58..fd781e54f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -947,6 +947,7 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 			  struct format_commit_context *c)
 {
 	const char *rest = placeholder;
+	const char *basic_color = NULL;
 
 	if (placeholder[1] == '(') {
 		const char *begin = placeholder + 2;
@@ -955,23 +956,41 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 
 		if (!end)
 			return 0;
+
 		if (skip_prefix(begin, "auto,", &begin)) {
 			if (!want_color(c->pretty_ctx->color))
 				return end - placeholder + 1;
+		} else if(skip_prefix(begin, "always,", &begin)) {
+			/* nothing to do; we do not respect want_color at all */
+		} else {
+			/* the default is the same as "auto" */
+			if (!want_color(c->pretty_ctx->color))
+				return end - placeholder + 1;
 		}
+
 		if (color_parse_mem(begin, end - begin, color) < 0)
 			die(_("unable to parse --pretty format"));
 		strbuf_addstr(sb, color);
 		return end - placeholder + 1;
 	}
+
+	/*
+	 * We handle things like "%C(red)" above; for historical reasons, there
+	 * are a few colors that can be specified without parentheses (and
+	 * they cannot support things like "auto" or "always" at all).
+	 */
 	if (skip_prefix(placeholder + 1, "red", &rest))
-		strbuf_addstr(sb, GIT_COLOR_RED);
+		basic_color = GIT_COLOR_RED;
 	else if (skip_prefix(placeholder + 1, "green", &rest))
-		strbuf_addstr(sb, GIT_COLOR_GREEN);
+		basic_color = GIT_COLOR_GREEN;
 	else if (skip_prefix(placeholder + 1, "blue", &rest))
-		strbuf_addstr(sb, GIT_COLOR_BLUE);
+		basic_color = GIT_COLOR_BLUE;
 	else if (skip_prefix(placeholder + 1, "reset", &rest))
-		strbuf_addstr(sb, GIT_COLOR_RESET);
+		basic_color = GIT_COLOR_RESET;
+
+	if (basic_color && want_color(c->pretty_ctx->color))
+		strbuf_addstr(sb, basic_color);
+
 	return rest - placeholder;
 }
 
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 7b97a90ba..b326d550f 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -59,7 +59,10 @@ test_format () {
 }
 
 # Feed to --format to provide predictable colored sequences.
+BASIC_COLOR='%Credfoo%Creset'
+COLOR='%C(red)foo%C(reset)'
 AUTO_COLOR='%C(auto,red)foo%C(auto,reset)'
+ALWAYS_COLOR='%C(always,red)foo%C(always,reset)'
 has_color () {
 	test_decode_color <"$1" >decoded &&
 	echo "<RED>foo<RESET>" >expect &&
@@ -177,7 +180,7 @@ test_expect_success 'basic colors' '
 	<RED>foo<GREEN>bar<BLUE>baz<RESET>xyzzy
 	EOF
 	format="%Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy" &&
-	git rev-list --format="$format" -1 master >actual.raw &&
+	git rev-list --color --format="$format" -1 master >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual
 '
@@ -188,48 +191,61 @@ test_expect_success 'advanced colors' '
 	<BOLD;RED;BYELLOW>foo<RESET>
 	EOF
 	format="%C(red yellow bold)foo%C(reset)" &&
-	git rev-list --format="$format" -1 master >actual.raw &&
+	git rev-list --color --format="$format" -1 master >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success '%C(auto,...) does not enable color by default' '
-	git log --format=$AUTO_COLOR -1 >actual &&
-	has_no_color actual
-'
-
-test_expect_success '%C(auto,...) enables colors for color.diff' '
-	git -c color.diff=always log --format=$AUTO_COLOR -1 >actual &&
-	has_color actual
-'
-
-test_expect_success '%C(auto,...) enables colors for color.ui' '
-	git -c color.ui=always log --format=$AUTO_COLOR -1 >actual &&
-	has_color actual
-'
+for spec in \
+	"%Cred:$BASIC_COLOR" \
+	"%C(...):$COLOR" \
+	"%C(auto,...):$AUTO_COLOR"
+do
+	desc=${spec%%:*}
+	color=${spec#*:}
+	test_expect_success "$desc does not enable color by default" '
+		git log --format=$color -1 >actual &&
+		has_no_color actual
+	'
 
-test_expect_success '%C(auto,...) respects --color' '
-	git log --format=$AUTO_COLOR -1 --color >actual &&
-	has_color actual
-'
+	test_expect_success "$desc enables colors for color.diff" '
+		git -c color.diff=always log --format=$color -1 >actual &&
+		has_color actual
+	'
 
-test_expect_success '%C(auto,...) respects --no-color' '
-	git -c color.ui=always log --format=$AUTO_COLOR -1 --no-color >actual &&
-	has_no_color actual
-'
+	test_expect_success "$desc enables colors for color.ui" '
+		git -c color.ui=always log --format=$color -1 >actual &&
+		has_color actual
+	'
 
-test_expect_success TTY '%C(auto,...) respects --color=auto (stdout is tty)' '
-	test_terminal env TERM=vt100 \
-		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
-	has_color actual
-'
+	test_expect_success "$desc respects --color" '
+		git log --format=$color -1 --color >actual &&
+		has_color actual
+	'
 
-test_expect_success '%C(auto,...) respects --color=auto (stdout not tty)' '
-	(
-		TERM=vt100 && export TERM &&
-		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
+	test_expect_success "$desc respects --no-color" '
+		git -c color.ui=always log --format=$color -1 --no-color >actual &&
 		has_no_color actual
-	)
+	'
+
+	test_expect_success TTY "$desc respects --color=auto (stdout is tty)" '
+		test_terminal env TERM=vt100 \
+			git log --format=$color -1 --color=auto >actual &&
+		has_color actual
+	'
+
+	test_expect_success "$desc respects --color=auto (stdout not tty)" '
+		(
+			TERM=vt100 && export TERM &&
+			git log --format=$color -1 --color=auto >actual &&
+			has_no_color actual
+		)
+	'
+done
+
+test_expect_success '%C(always,...) enables color even without tty' '
+	git log --format=$ALWAYS_COLOR -1 >actual &&
+	has_color actual
 '
 
 test_expect_success '%C(auto) respects --color' '
-- 
2.13.2.1157.gc6daca446

