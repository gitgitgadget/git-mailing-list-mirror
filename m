Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E381F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbcJNOab (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:30:31 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:54453
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754109AbcJNOa2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454455;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=tAHvp6qcmlSHfveakCOKyD5TpVikca7pJDgpQj+pqa4=;
        b=au+uiqPnPAIWlmeFsa+0AO1uLO/docMXuv9113TMBSoKUlkGtkCsNtGEZuK6hc/y
        zwBu3A37qw/a8fY6+ukb2YBCz8DsEXtD+JxNL0PWxREVM8kxLeTMTnuNhXBEti5VNs0
        uA/Md3VE6ayv9lnKzd7FwxCWISUxeTwmvDUlmnts=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1a74-ad2bcaff-0c92-4af4-9aa0-72d98f4945fc-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 02/27] bisect: rewrite `check_term_format` shell
 function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:15 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the `check_term_format` shell function in C and add
a `--check-term-format` subcommand to `git bisect--helper` to call it
from git-bisect.sh

Using `--check-term-format` subcommand is a temporary measure to port
shell function to C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and its
implementation will be called by some other method/subcommand. For
eg. In conversion of write_terms() of git-bisect.sh, the subcommand will
be removed and instead check_term_format() will be called in its C
implementation while a new subcommand will be introduced for write_terms().

Helped-by: Johannes Schindelein <Johannes.Schindelein@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 31 ++-----------------------
 2 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8111c91..a47f1f2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,19 +2,73 @@
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
+LAST_ARG_MUST_BE_NULL
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
@@ -29,6 +83,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index ae3cb01..a727c59 100755
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
https://github.com/git/git/pull/287
