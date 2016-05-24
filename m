From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v8 2/3] bisect: rewrite `check_term_format` shell function in C
Date: Tue, 24 May 2016 12:51:23 +0530
Message-ID: <20160524072124.2945-3-pranit.bauva@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 09:23:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b56gB-0003p6-HK
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 09:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbcEXHXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 03:23:00 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35597 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbcEXHW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 03:22:59 -0400
Received: by mail-pa0-f67.google.com with SMTP id gp3so1172445pac.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hcjP9ThTdOlpVSFp9tIpa1u5iF7/Pcb5hUOpOPD0M6s=;
        b=enCGyiFWDRITjHH89HPMT10dmoPfJNV/VF7SpeObJfXKAmybFJBPaWonwQjxPrTGpe
         Roj7dMHvBYrylEU/hS5HKqWY2SdqBnP8NSIKtO1FN4mbUkrUNL8OybJ4XozUFT5LGzAC
         PC0FOgO8Ra5HcW53BXFPmYPptYBzJC+DZtz6+mBvbzNJQhDr26jCBSp/ZyGI/g/uMm7v
         qHGWXjXRa4g9dAZXr4mqJCY3r2y+5lgOHHV5fQOr21n4gRdPni6GkwYg6pMB2rv0uPa0
         g3ndl/gKPmWbMNc0IJvzL4D2Bt0SnjGYqDcPW65j4Zo8F+9gnbnwoWd2pdYaxhmDzWRj
         Xo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hcjP9ThTdOlpVSFp9tIpa1u5iF7/Pcb5hUOpOPD0M6s=;
        b=bPbDtkZ2QVIajoxVsGLRvD135dwSpxKuJHAcbI/BtAxJ2iU40bj9Z166mQPCJaDMdu
         O5t7EC4tEJaQ6jflnpNxaXkvz3Unlvn/jg/+suq2LVmH8xdd3dm4pss0BNMc/RUSiPea
         aXHhwRyXqMti6J2t2f5AhB6HQW2ehwfN9AEyvkjY6trlfyFdSVAdwL/g6y3Kk5zY3ib4
         2iWR9G/59LpUHf8eLvpQ7fF2lOPUluyA7dhxY2u2YPywOKkIFO0DDypqd+Vhlkxe0rl9
         3S0Snt/VZP14uoWkWMy+KZa6uwBbD3OuHVhIg5Ho6bMTUeIzqqLaQCBD6+PxCBFU1llw
         cISw==
X-Gm-Message-State: ALyK8tJ9UAIoNqO1hLBCSoZUwNPiWE8UP7iJPsBWiw+e/F7zB1SGVCPNJr6bFcsIje8l4A==
X-Received: by 10.66.6.35 with SMTP id x3mr4470512pax.135.1464074578198;
        Tue, 24 May 2016 00:22:58 -0700 (PDT)
Received: from localhost.localdomain ([183.87.83.48])
        by smtp.gmail.com with ESMTPSA id a5sm2491900pat.19.2016.05.24.00.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 00:22:57 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160524072124.2945-1-pranit.bauva@gmail.com>
In-Reply-To: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
References: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295423>

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
