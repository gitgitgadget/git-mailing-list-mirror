From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v5 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Fri,  6 May 2016 20:19:27 +0530
Message-ID: <1462546167-1125-3-git-send-email-pranit.bauva@gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
 <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 06 16:52:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayh7c-0001nI-Jv
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 16:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758262AbcEFOwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 10:52:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36212 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956AbcEFOwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 10:52:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id p185so12446957pfb.3
        for <git@vger.kernel.org>; Fri, 06 May 2016 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/P6O7534kN5cMJ9GUMFBEK/RvYNPST/7WPiomkXy0c=;
        b=FA9nUQjQGIVFEg5uu864IHLnCtRSwgtRJ9ihzvkqN19Ko8XQ01tGdNCA+Ij/dTetPv
         9YJuH1bsxh3YQw59mGkZR7PF0eH1hU87+G29HBl3PFTqZUAdK2B5xqR0OAU/AHbLPQuK
         qB0xyXc/5XhmFtAr6dm7LR+4yau+gdzo+Onw0i0gXNhQQnc21x6nDXmahCQwcdbKOexg
         ITXy+1CVcKsIWA/7jOV5P/YA20zuZX+udzVeBABs71IPH5fRcXYN/O9OFBGT2Ww4r791
         TwxChO+mMLbX+P3bGKGRKEf0n79u3rhTNzL/wrBUnpUSQQn63bsRZHQC8xIzc9k6f8Sk
         XZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/P6O7534kN5cMJ9GUMFBEK/RvYNPST/7WPiomkXy0c=;
        b=HdpoduD1TCKQ1viStIR+FZAd6sIdhkYo2FNhs8FDANKNHzSuJDiYooEhIYV98MX52x
         y4MVWb3bX5Twna+5ZmOvo8UKdd0lQgXmbVpWwVupUASLgCl5z+FRDXHHwWEzhgVITYcL
         q91RwX7vVjGvP0CUB2NLYeP/adP7wJVF2fPuLyG2SVBbOkOYD7vDr2iEjTDc+8dQvGT3
         9C/DFcTNAzmoxP03WDIiQM0Q2BG5twnWQbHa+XNWK6nl81/F7ymgwpIcIS5n8YIuZSNm
         1/BkXFNW7eRgK/mhWQwRVXrFFXSYJOnRxpoNuRnJOwfyKxZ53nerUB8k/XWWnf8cZugc
         rxuw==
X-Gm-Message-State: AOPr4FW0CipLwHpm0bM3EcHDZR5F9oBcHWjrH5s6UjlKDupQsY3nUqQHiqf4xPAG4u9uzA==
X-Received: by 10.98.79.199 with SMTP id f68mr29670154pfj.44.1462546368730;
        Fri, 06 May 2016 07:52:48 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id dh4sm21775410pad.37.2016.05.06.07.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 May 2016 07:52:47 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293787>

Reimplement the `check_term_format` shell function in C and add
a `--check-term-format` subcommand to `git bisect--helper` to call it
from git-bisect.sh

Using `--check-term-format` subcommand is a temporary measure to port
shell function to C so as to use the existing test suite. As more
functions are ported, this subcommand will loose its existence and will
be called by some other method/subcommand. For eg. In conversion of
write_terms() of git-bisect.sh, the subcommand will be removed and
instead check_term_format() will be called in its C implementation while
a new subcommand will be introduced for write_terms().

Helped-by: Johannes Schindelein <Johannes.Schindelein@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 31 ++------------------------
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d8de651..cc50438 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,16 +2,65 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "bisect.h"
+#include "refs.h"
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
+	N_("git bisect--helper --check-term-format <term> <orig_term>"),
 	NULL
 };
 
 enum subcommand {
-	NEXT_ALL = 1
+	NEXT_ALL = 1,
+	CHECK_TERM_FMT
 };
 
+/*
+ * To check whether the string `term` belongs to the set of strings
+ * included in the variable arguments.
+ */
+static int one_of(const char *term, ...)
+{
+	int res = 0;
+	va_list matches;
+	const char *match;
+
+	va_start(matches, term);
+	while (!res && (match=va_arg(matches, const char *)))
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
 	int subcommand = 0;
@@ -19,6 +68,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &subcommand,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
+		OPT_CMDMODE(0, "check-term-format", &subcommand,
+			 N_("check format of the term"), CHECK_TERM_FMT),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -33,6 +84,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	switch (subcommand) {
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
+	case CHECK_TERM_FMT:
+		if (argc != 2)
+			die(_("--check-term-format requires two arguments"));
+		return check_term_format(argv[0], argv[1]);
 	default:
 		die("BUG: unknown subcommand '%d'", subcommand);
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
2.8.1
