From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v9 2/3] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 25 May 2016 00:12:41 +0530
Message-ID: <20160524184242.7518-3-pranit.bauva@gmail.com>
References: <20160524184242.7518-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, gitster@pobox.com,
	larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@gmail.com, sunshine@sunshineco.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 20:46:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HLt-0004jN-9X
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbcEXSqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 14:46:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34211 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbcEXSqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 14:46:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so2972225pfz.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hcjP9ThTdOlpVSFp9tIpa1u5iF7/Pcb5hUOpOPD0M6s=;
        b=xkuIsa/u7U2mn/rHeBTg3sobHx3a74GwMzpZxMm5I7nww4a4DSVIgEaZoD9AGqTSmd
         Uhj3A8d+rYAWDh05oGKISGR9pTgQM58EPTha1P7Y6fqrTF0wpUnDGNd7R3IOi9MG8RhY
         /Vak6EHIoxEcMb0q7XqvbVLJslgrAZ7+/2CdiHt8WO4nEzC/0PfliweAu1FfduyPa26X
         /rB7WuEbK/N0ffQc1rZCbtQOqWsHTfEYBKTblyRcdoyNCubL0ki9C08HE4gU3svIzGpq
         vqkaPIVyLM4bK1GsniLaivQmue88Laxsv9/nQGFjb/QFC6MlqG53KE70K1Lgt/64Ws+6
         Urxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hcjP9ThTdOlpVSFp9tIpa1u5iF7/Pcb5hUOpOPD0M6s=;
        b=XcLoJqarwtskrP/PgsAiEEhNLfR8ytUXjCCirVvVI2SpdR/vNH89W/jVxlFdCm94Zs
         9KIN9VpGKk6brbEfaBfJz5RgSKNnHc4P+3QlYTsPma/hskJeh9KCQRZcTSux21rPr7PP
         Mii3oGuV31H/aey80P31M9bgvlxINis4BeCxnTwfjv0W6VmEddguhvEI1y6KqV/rS7WL
         dkoqu7DLTHdQou8qg3j61Pp81cgkSTm714n2h7QsNSRPdar/VuyjS+e26UmAAyspFiQb
         gMpvcRm6qI0hZUXO1SgYehzNi1SKGtMZ5QLV5X4j6NO8JmUac6o9Ikg5b8+/+buF5z2x
         FeJQ==
X-Gm-Message-State: ALyK8tLg1psmbN5uQQfLCLw9kXpJuTGD7S5vXZDRgm2tZ1PI8E/gmcagN99VyCrn4rjysQ==
X-Received: by 10.98.82.19 with SMTP id g19mr9052434pfb.157.1464115602768;
        Tue, 24 May 2016 11:46:42 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id u2sm6918859pan.45.2016.05.24.11.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 11:46:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160524184242.7518-1-pranit.bauva@gmail.com>
In-Reply-To: <20160524072124.2945-1-pranit.bauva@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295519>

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
2.8.3
