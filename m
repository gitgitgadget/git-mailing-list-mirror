Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C216920195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbcGLWjg (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:36 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35673 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcGLWjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:32 -0400
Received: by mail-pa0-f66.google.com with SMTP id dx3so1832802pab.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NxvHHJKgPygmSjfMnn4AEnsRKFet/aw1p9uRwsm64wo=;
        b=NyEuCjoo0RXIrBa5RaOiQxuUiJfdUsosVjHjXPfUYWsuniAvGOayi164GEbsB6bVvP
         XHwWkkpS8jnxmrj2A5048vEsPXIJrWffFvLjA1rvQqjkJllI0rhV6egjp1w/UzEuFVYb
         /cifO5fgqB8cq6pwQUeVmhEiXzCBr5MQzWahEE3maOtjHfHUcc7tmpCDgUdMFqXJMHkZ
         HacdODq0ieBfNtlNdu2Q5h7Vg4OOsNjtWlBohW4xDHeCRytkV8IThpNzhuC37u37sAIM
         Lp5czYuEJGqM6MKOaLkqhfA6j0kpJOXRfCylnyfCjXAJv753PZlzBLQOJf51UD2rAm1q
         WP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NxvHHJKgPygmSjfMnn4AEnsRKFet/aw1p9uRwsm64wo=;
        b=QXZb+D4NZ6D62ddw2CqoeLhejerki0nspbaDBv/0ecDH/9hdxRRWZtHcK1TCHLENPd
         NkEcjAcEnbHU8ZMjCQADRX5pajeEnf9h3WDDZg1wOejhJTk16Gn+Yl1WayV5UQ0usVTY
         OzrmCg32lALiTcJ+vZrJos2aZTB1NQyjpQu/5LDzG6IsqFalsKNHyOlX77UVkrkJsAPF
         3BhLsp0yEFl5mNB/HZrKMgn8auHPAOx/y+2uCibG6clDA0l9J5iXtEN1SamJ9IGBfs2N
         sjxTNxskO2gfqtAM8eBEK//1uEi2hGwefojYd672y+QW9wCMernKWy++rzYevX6cH4vh
         q8zQ==
X-Gm-Message-State: ALyK8tKf8YAXJt2w9J1jrqdrBSPZYMgXr2tn7EvR6o9fpPV2JVmnnsLMdBH3R2x9Hqy4gg==
X-Received: by 10.66.253.38 with SMTP id zx6mr8059077pac.19.1468363147092;
        Tue, 12 Jul 2016 15:39:07 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:06 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 2/9] bisect: rewrite `check_term_format` shell function in C
Date:	Wed, 13 Jul 2016 04:05:31 +0530
Message-Id: <20160712223538.28508-3-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `check_term_format` shell function in C and add
a `--check-term-format` subcommand to `git bisect--helper` to call it
from git-bisect.sh

Using `--check-term-format` subcommand is a temporary measure to port
shell function to C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and will
be called by some other method/subcommand. For eg. In conversion of
write_terms() of git-bisect.sh, the subcommand will be removed and
instead check_term_format() will be called in its C implementation while
a new subcommand will be introduced for write_terms().

Helped-by: Johannes Schindelein <Johannes.Schindelein@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 31 ++-----------------------
 2 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8111c91..3c748d1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,19 +2,72 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "bisect.h"
+#include "refs.h"
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
+	N_("git bisect--helper --check-term-format <term> <orig_term>"),
 	NULL
 };
 
+/*
+ * Check whether the string `term` belongs to the set of strings
+ * included in the variable arguments.
+ */
+static int one_of(const char *term, ...)
+{
+	int res = 0;
+	va_list matches;
+	const char *match;
+
+	va_start(matches, term);
+	while (!res && (match = va_arg(matches, const char *)))
+		res = !strcmp(term, match);
+	va_end(matches);
+
+	return res;
+}
+
+static int check_term_format(const char *term, const char *orig_term)
+{
+	struct strbuf new_term = STRBUF_INIT;
+	strbuf_addf(&new_term, "refs/bisect/%s", term);
+
+	if (check_refname_format(new_term.buf, 0)) {
+		strbuf_release(&new_term);
+		return error(_("'%s' is not a valid term"), term);
+	}
+	strbuf_release(&new_term);
+
+	if (one_of(term, "help", "start", "skip", "next", "reset",
+			"visualize", "replay", "log", "run", NULL))
+		return error(_("can't use the builtin command '%s' as a term"), term);
+
+	/*
+	 * In theory, nothing prevents swapping completely good and bad,
+	 * but this situation could be confusing and hasn't been tested
+	 * enough. Forbid it for now.
+	 */
+
+	if ((strcmp(orig_term, "bad") && one_of(term, "bad", "new", NULL)) ||
+		 (strcmp(orig_term, "good") && one_of(term, "good", "old", NULL)))
+		return error(_("can't change the meaning of the term '%s'"), term);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum { NEXT_ALL = 1 } cmdmode = 0;
+	enum {
+		NEXT_ALL = 1,
+		CHECK_TERM_FMT
+	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
+		OPT_CMDMODE(0, "check-term-format", &cmdmode,
+			 N_("check format of the term"), CHECK_TERM_FMT),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -29,6 +82,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	switch (cmdmode) {
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
+	case CHECK_TERM_FMT:
+		if (argc != 2)
+			die(_("--check-term-format requires two arguments"));
+		return check_term_format(argv[0], argv[1]);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..7d7965d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -564,38 +564,11 @@ write_terms () {
 	then
 		die "$(gettext "please use two different terms")"
 	fi
-	check_term_format "$TERM_BAD" bad
-	check_term_format "$TERM_GOOD" good
+	git bisect--helper --check-term-format "$TERM_BAD" bad || exit
+	git bisect--helper --check-term-format "$TERM_GOOD" good || exit
 	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
 }
 
-check_term_format () {
-	term=$1
-	git check-ref-format refs/bisect/"$term" ||
-	die "$(eval_gettext "'\$term' is not a valid term")"
-	case "$term" in
-	help|start|terms|skip|next|reset|visualize|replay|log|run)
-		die "$(eval_gettext "can't use the builtin command '\$term' as a term")"
-		;;
-	bad|new)
-		if test "$2" != bad
-		then
-			# In theory, nothing prevents swapping
-			# completely good and bad, but this situation
-			# could be confusing and hasn't been tested
-			# enough. Forbid it for now.
-			die "$(eval_gettext "can't change the meaning of term '\$term'")"
-		fi
-		;;
-	good|old)
-		if test "$2" != good
-		then
-			die "$(eval_gettext "can't change the meaning of term '\$term'")"
-		fi
-		;;
-	esac
-}
-
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-- 
2.9.0

