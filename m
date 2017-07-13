Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E06C202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdGMPJl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:09:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:39174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752477AbdGMPJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:09:39 -0400
Received: (qmail 24494 invoked by uid 109); 13 Jul 2017 15:09:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:09:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32325 invoked by uid 111); 13 Jul 2017 15:09:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:09:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:09:32 -0400
Date:   Thu, 13 Jul 2017 11:09:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 15/15] ref-filter: consult want_color() before emitting colors
Message-ID: <20170713150932.y6i7un63b5fzmaei@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When color placeholders like %(color:red) are used in a
ref-filter format, we unconditionally output the colors,
even if the user has asked us for no colors. This usually
isn't a problem when the user is constructing a --format on
the command line, but it means we may do the wrong thing
when the format is fed from a script or alias. For example:

   $ git config alias.b 'branch --format=%(color:green)%(refname)'
   $ git b --no-color

should probably omit the green color. Likewise, running:

   $ git b >branches

should probably also omit the color, just as we would for
all baked-in coloring (and as we recently started to do for
user-specified colors in --pretty formats).

This commit makes both of those cases work by teaching
the ref-filter code to consult want_color() before
outputting any color. The color flag in ref_format defaults
to "-1", which means we'll consult color.ui, which in turn
defaults to the usual isatty() check on stdout. However,
callers like git-branch which support their own color config
(and command-line options) can override that.

The new tests independently cover all three of the callers
of ref-filter (for-each-ref, tag, and branch). Even though
these seem redundant, it confirms that we've correctly
plumbed through all of the necessary config to make colors
work by default.

Signed-off-by: Jeff King <peff@peff.net>
---
The "correctly plumbed" bits happened in the earlier patches. But it was
these tests that showed me they were broken.

 builtin/branch.c         |  1 +
 ref-filter.c             |  8 ++++++++
 ref-filter.h             |  3 ++-
 t/t3203-branch-output.sh | 31 +++++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh  | 37 ++++++++++++++++++++++++++-----------
 t/t7004-tag.sh           | 25 +++++++++++++++++++++++++
 6 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d852ded49..16d391b40 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -409,6 +409,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	if (!format->format)
 		format->format = to_free = build_format(filter, maxwidth, remote_prefix);
+	format->use_color = branch_use_color;
 
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
diff --git a/ref-filter.c b/ref-filter.c
index 129a63677..bc591f4f3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -104,6 +104,12 @@ static void color_atom_parser(const struct ref_format *format, struct used_atom
 		die(_("expected format: %%(color:<color>)"));
 	if (color_parse(color_value, atom->u.color) < 0)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
+	/*
+	 * We check this after we've parsed the color, which lets us complain
+	 * about syntactically bogus color names even if they won't be used.
+	 */
+	if (!want_color(format->use_color))
+		color_parse("", atom->u.color);
 }
 
 static void refname_atom_parser_internal(struct refname_atom *atom,
@@ -675,6 +681,8 @@ int verify_ref_format(struct ref_format *format)
 		if (skip_prefix(used_atom[at].name, "color:", &color))
 			format->need_color_reset_at_eol = !!strcmp(color, "reset");
 	}
+	if (format->need_color_reset_at_eol && !want_color(format->use_color))
+		format->need_color_reset_at_eol = 0;
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 1ffc3ca81..0d98342b3 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -79,12 +79,13 @@ struct ref_format {
 	 */
 	const char *format;
 	int quote_style;
+	int use_color;
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { NULL, 0 }
+#define REF_FORMAT_INIT { NULL, 0, -1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index a428ae670..d2aec0f38 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -2,6 +2,7 @@
 
 test_description='git branch display tests'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'make commits' '
 	echo content >file &&
@@ -239,4 +240,34 @@ test_expect_success 'git branch --format option' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success "set up color tests" '
+	echo "<RED>master<RESET>" >expect.color &&
+	echo "master" >expect.bare &&
+	color_args="--format=%(color:red)%(refname:short) --list master"
+'
+
+test_expect_success '%(color) omitted without tty' '
+	TERM=vt100 git branch $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.bare actual
+'
+
+test_expect_success TTY '%(color) present with tty' '
+	test_terminal env TERM=vt100 git branch $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.color actual
+'
+
+test_expect_success 'color.branch=always overrides auto-color' '
+	git -c color.branch=always branch $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.color actual
+'
+
+test_expect_success '--color overrides auto-color' '
+	git branch --color $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.color actual
+'
+
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7872a2f54..2274a4b73 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -7,6 +7,7 @@ test_description='for-each-ref test'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 # Mon Jul 3 23:18:43 2006 +0000
 datestamp=1151968723
@@ -412,19 +413,33 @@ test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
 
-cat >expected <<EOF
-$(git rev-parse --short refs/heads/master) <GREEN>master<RESET>
-$(git rev-parse --short refs/remotes/origin/master) <GREEN>origin/master<RESET>
-$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
-$(git rev-parse --short refs/tags/two) <GREEN>two<RESET>
-EOF
+test_expect_success 'set up color tests' '
+	cat >expected.color <<-EOF &&
+	$(git rev-parse --short refs/heads/master) <GREEN>master<RESET>
+	$(git rev-parse --short refs/remotes/origin/master) <GREEN>origin/master<RESET>
+	$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
+	$(git rev-parse --short refs/tags/two) <GREEN>two<RESET>
+	EOF
+	sed "s/<[^>]*>//g" <expected.color >expected.bare &&
+	color_format="%(objectname:short) %(color:green)%(refname:short)"
+'
 
-test_expect_success 'Check %(color:...) ' '
-	git for-each-ref \
-		--format="%(objectname:short) %(color:green)%(refname:short)" \
-		>actual.raw &&
+test_expect_success TTY '%(color) shows color with a tty' '
+	test_terminal env TERM=vt100 \
+		git for-each-ref --format="$color_format" >actual.raw &&
 	test_decode_color <actual.raw >actual &&
-	test_cmp expected actual
+	test_cmp expected.color actual
+'
+
+test_expect_success '%(color) does not show color without tty' '
+	TERM=vt100 git for-each-ref --format="$color_format" >actual &&
+	test_cmp expected.bare actual
+'
+
+test_expect_success 'color.ui=always can override tty check' '
+	git -c color.ui=always for-each-ref --format="$color_format" >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expected.color actual
 '
 
 cat >expected <<\EOF
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0ef7b9439..dd5ba450e 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -9,6 +9,7 @@ Tests for operations with tags.'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 # creating and listing lightweight tags:
 
@@ -1900,6 +1901,30 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_expect_success "set up color tests" '
+	echo "<RED>v1.0<RESET>" >expect.color &&
+	echo "v1.0" >expect.bare &&
+	color_args="--format=%(color:red)%(refname:short) --list v1.0"
+'
+
+test_expect_success '%(color) omitted without tty' '
+	TERM=vt100 git tag $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.bare actual
+'
+
+test_expect_success TTY '%(color) present with tty' '
+	test_terminal env TERM=vt100 git tag $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.color actual
+'
+
+test_expect_success 'color.ui=always overrides auto-color' '
+	git -c color.ui=always tag $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.color actual
+'
+
 test_expect_success 'setup --merged test tags' '
 	git tag mergetest-1 HEAD~2 &&
 	git tag mergetest-2 HEAD~1 &&
-- 
2.13.2.1157.gc6daca446
