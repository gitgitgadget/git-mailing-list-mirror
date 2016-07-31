Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D511F855
	for <e@80x24.org>; Sun, 31 Jul 2016 09:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcGaJ6J (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 05:58:09 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:56762
	"EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751332AbcGaJ6I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 05:58:08 -0400
X-Greylist: delayed 1444 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jul 2016 05:58:07 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469956898;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=TYj9lsVZADTdDTLOt6LYBQWJiP55ceA/UoZzGxEO7Sw=;
	b=WNdUfaHc14LG63iOSkzXcgVxqqvMjLDrgtDwgb8sFVhkdQMDxIIsEtEWvHirH1nT
	i9tHVcoeK5wDnGvWzhvO/mY1a4DxdtXCPnm835NyoSO2QdNYJpPd1ieHw3EnH1rk/TK
	q2HHQzbvZmo9Q8R3B0+7YXUVpXPt5dnlarswnQUA=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <0102015640423cc5-691952fa-3726-4132-bcc1-dfa55d4c0895-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
Subject: [RFC/PATCH v11 02/13] bisect: rewrite `check_term_format` shell
 function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Sun, 31 Jul 2016 09:21:38 +0000
X-SES-Outgoing:	2016.07.31-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
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
index 8111c91..48285d4 100644
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
+	int res;
+	char *new_term = xstrfmt("refs/bisect/%s", term);
+
+	res = check_refname_format(new_term, 0);
+	free(new_term);
+
+	if (res)
+		return error(_("'%s' is not a valid term"), term);
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
https://github.com/git/git/pull/281
