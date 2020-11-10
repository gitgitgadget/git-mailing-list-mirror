Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC721C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 18:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FEB206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 18:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgKJS2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:28:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:53114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJS2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 13:28:37 -0500
Received: (qmail 8617 invoked by uid 109); 10 Nov 2020 18:28:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 18:28:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3678 invoked by uid 111); 10 Nov 2020 18:28:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 13:28:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 13:28:33 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH] add-interactive.c: use correct names to load color.diff.*
 config
Message-ID: <20201110182833.GB1362803@coredump.intra.peff.net>
References: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com>
 <20201106170345.GA174555@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 05:06:59PM +0100, Johannes Schindelin wrote:

> A bigger puzzle for me was: why did we not catch that earlier? I vaguely
> remember that we introduced _specifically_ code to test coloring, and to
> make those test work on Windows (rather than skipping them all).
> 
> *clicketyclick* ah, we only tests the menu of `git add -i`, and we do not
> even override the colors...

Yeah, the test coverage could definitely be improved.

> Will try to set aside some time to work on fixing this,

How about this?

-- >8 --
Subject: add-interactive.c: use correct names to load color.diff.* config

The builtin version of add-interactive mistakenly loads diff colors from
color.interactive.* instead of color.diff.*. It also accidentally spells
"frag" as "fraginfo".

Let's fix that, and add some test coverage:

  - check that color.diff.* is respected (this passes with the perl
    version, but without this patch fails if GIT_TEST_ADD_I_USE_BUILTIN
    is set)

  - check that color.interactive.* is respected; this passes already
    with both versions, but confirms we didn't break anything

Note that neither test is exhaustive over the set of color config, but
this is enough to sanity check the system (and we do check frag
explicitly because of its typo).

Note also that we don't respect the historical "diff.color.*". The perl
version never did, and those have been deprecated since 2007.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't love that we have to repeat the set of color config here (and I
guess maybe somebody would complain that we don't respect all of the
weird "moved" variants?). But I agree that it's hard to re-use the
existing diff code without stomping all over global variables. So I'd
consider this the minimal fix bringing us in line with the perl version,
but we may want to later revisit the diff color-config code as a whole.

 add-interactive.c          | 22 ++++++++++++----------
 t/t3701-add-interactive.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 555c4abf32..208a058a68 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -12,10 +12,11 @@
 #include "prompt.h"
 
 static void init_color(struct repository *r, struct add_i_state *s,
+		       const char *section,
 		       const char *slot_name, char *dst,
 		       const char *default_color)
 {
-	char *key = xstrfmt("color.interactive.%s", slot_name);
+	char *key = xstrfmt("color.%s.%s", section, slot_name);
 	const char *value;
 
 	if (!s->use_color)
@@ -40,18 +41,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 			git_config_colorbool("color.interactive", value);
 	s->use_color = want_color(s->use_color);
 
-	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
-	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
-	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
-	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
-	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
-	init_color(r, s, "fraginfo", s->fraginfo_color,
+	init_color(r, s, "interactive", "header", s->header_color, GIT_COLOR_BOLD);
+	init_color(r, s, "interactive", "help", s->help_color, GIT_COLOR_BOLD_RED);
+	init_color(r, s, "interactive", "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
+	init_color(r, s, "interactive", "error", s->error_color, GIT_COLOR_BOLD_RED);
+
+	init_color(r, s, "diff", "reset", s->reset_color, GIT_COLOR_RESET);
+	init_color(r, s, "diff", "frag", s->fraginfo_color,
 		   diff_get_color(s->use_color, DIFF_FRAGINFO));
-	init_color(r, s, "context", s->context_color,
+	init_color(r, s, "diff", "context", s->context_color,
 		diff_get_color(s->use_color, DIFF_CONTEXT));
-	init_color(r, s, "old", s->file_old_color,
+	init_color(r, s, "diff", "old", s->file_old_color,
 		diff_get_color(s->use_color, DIFF_FILE_OLD));
-	init_color(r, s, "new", s->file_new_color,
+	init_color(r, s, "diff", "new", s->file_new_color,
 		diff_get_color(s->use_color, DIFF_FILE_NEW));
 
 	FREE_AND_NULL(s->interactive_diff_filter);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..7c3107a04a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -602,6 +602,27 @@ test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	grep "old<" output
 '
 
+test_expect_success 'colorized diffs respect color config' '
+	git reset --hard &&
+
+	echo content >test &&
+	printf y >y &&
+	force_color git \
+		-c color.diff.meta="bold red" \
+		-c color.diff.frag="bold blue" \
+		-c color.diff.old="green" \
+		-c color.diff.new="red" \
+		add -p >output.raw 2>&1 <y &&
+	test_decode_color <output.raw >output &&
+
+	# do not check the full output, which would make the test brittle;
+	# just make sure the items we configured were colored correctly
+	grep "^<BOLD;RED>diff" output &&
+	grep "^<BOLD;BLUE>@@" output &&
+	grep "^<GREEN>-" output &&
+	grep "^<RED>\+" output
+'
+
 test_expect_success 'diffFilter filters diff' '
 	git reset --hard &&
 
@@ -884,4 +905,15 @@ test_expect_success 'show help from add--helper' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'interactive colors can be configured' '
+	git reset --hard &&
+
+	test_write_lines h |
+	force_color git \
+		-c color.interactive.help="bold yellow" \
+		add -i >actual.colored &&
+	test_decode_color <actual.colored >actual &&
+	test_i18ngrep "^<BOLD;YELLOW>update" actual
+'
+
 test_done
-- 
2.29.2.640.g9e24689a4c

