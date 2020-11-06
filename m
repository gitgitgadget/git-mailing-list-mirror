Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF0C388F2
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EC922202
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgKFRDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:03:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:50022 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFRDr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:03:47 -0500
Received: (qmail 19921 invoked by uid 109); 6 Nov 2020 17:03:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Nov 2020 17:03:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2097 invoked by uid 111); 6 Nov 2020 17:03:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Nov 2020 12:03:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Nov 2020 12:03:45 -0500
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: ["BUG"] builtin add-interactive does not honor 'color.diff. frag'
Message-ID: <20201106170345.GA174555@coredump.intra.peff.net>
References: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 06, 2020 at 11:31:32AM -0500, Philippe Blain wrote:

> I tried the builtin add-interactive for the first time today, 
> and noticed a very minor difference with the Perl version.
> The title says it all.
> 
> Repro:
> 
> # Change the default color
> $ git config color.diff.frag "magenta bold"
> # Compare
> $ git add -p
> # and
> $ git -c add.interactive.useBuiltin=true add -p 
> # I'm on latest master
> $ git --version
> git version 2.29.2.154.g7f7ebe054a

It looks like the code in add-interactive.c uses "fraginfo" instead of
"frag". But there's something much more puzzling, which is that it
checks color.interactive.frag. AFAIK that has never been a valid config
option (there are some color.interactive.* values, but they are all for
interactive-specific things).

So something like this seems to go in the right direction (and makes
your example work):

diff --git a/add-interactive.c b/add-interactive.c
index a14c0feaa2..1eb69c5160 100644
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

but that is missing another thing: for historical reasons we allow both
color.diff.frag and diff.color.frag. TBH, I wouldn't be too sad to see
us drop support for the historical versions in this setting. But it
makes me wonder if we could be reusing the parsing from
git_diff_basic_config(), which handles both cases.

I'm not entirely clear on how add-interactive.c invokes the diff, and
whether it would be unhappy to pick up diff config. But it seems like
this:

diff --git a/builtin/add.c b/builtin/add.c
index a825887c50..47bb6ea10b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -362,7 +362,7 @@ static int add_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_diff_basic_config(var, value, cb);
 }
 
 static const char embedded_advice[] = N_(

might be the simplest thing (and drop the extra diff-config parsing from
add-interactive.c that I was touching above). It does need to be done in
each program that calls into the add-interactive code though (so
checkout, etc). Obviously it would be easy for init_add_i_state() to
make a similar call, though that may open us up to loading the diff
config twice. I suspect that would probably be OK, but it could lead to
weirdness if there are any multi-valued config options.

-Peff
