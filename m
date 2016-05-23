From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v7 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 23 May 2016 20:18:48 +0530
Message-ID: <1464014928-31548-4-git-send-email-pranit.bauva@gmail.com>
References: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
 <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com,
	sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 16:51:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4rCG-0008Eo-AL
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 16:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbcEWOvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 10:51:03 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35688 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbcEWOvC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 10:51:02 -0400
Received: by mail-pa0-f67.google.com with SMTP id rw9so18266639pab.2
        for <git@vger.kernel.org>; Mon, 23 May 2016 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zGNMuKp+xupmTeXizIxNB0o4l9HVJ0JGhrF36r/UxEE=;
        b=PndUM4LAA8IZu9YZN5LWVvqvBG5yZ4Fw2fqTnU+ExfgP4muJF8exELOzhUauzfg/Zm
         fDT/FlDnAzJ+9Ak1+Z9zLtUzOjsPAeh1QKvahPQJ3/hiVWphOT+H0jUzuDUCqPfbT0Wo
         S1/3AnoYH8+cs2kLj1rFftTEUcppq9yb6V/K1uxuuPcHzFOEHp16b0xVTjEzNXgVrtc9
         gYgEQiUfzgcWv/PcY97w2MrmCojCDk8sOoEZxt5ehn9fEshu2O9PvlIfrWs3djsZTcRg
         z2SalIjjQdhZbfpy/X1ZUBiI7MSSYue/mIs+66sihIPsBxoIEShGIWEnaTeI8mRZu1LH
         r0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zGNMuKp+xupmTeXizIxNB0o4l9HVJ0JGhrF36r/UxEE=;
        b=GP+zyfNrjWK5cC61pb0cn+kR/ZL95h/VKZly73wthL5M2TDDUGwl7rbzr+TlGXxELS
         xqFhkeENOB6Mmg5fG3elQFZ0TswiFYr2bim8aWsJYcIrkou1WY4zP203XlvpqBHz2IGC
         T3YIQewp9rMoaCh4ZgfGnEmYHf2yqH9Y2YbrYqxEnk6723s6pyShk9SUY3JQiRBBVTEl
         hjAZ1M8htw7UFPO++us+FBO7dJw3yvZGMYsZsIxnl0EsWu1JEFPb/sc/EeUcl6KiRqdE
         3grQgbwIZRidnYlbUXZAi9SPL9qIltjDglLO8aAp9b6BoWOfU/oKcXFjPuE7Uzy1ltRz
         ZOfA==
X-Gm-Message-State: AOPr4FXOqhwqJ3vgfugkc0Bpq8B5zUK/Yfuu9hJtLLBfMBqGHQ94fab33btnvvQj4Ik2zw==
X-Received: by 10.66.26.16 with SMTP id h16mr28024322pag.154.1464015056147;
        Mon, 23 May 2016 07:50:56 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id x89sm47301031pfa.87.2016.05.23.07.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 07:50:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295330>

Reimplement the `write_terms` shell function in C and add a `write-terms`
subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
remove the subcommand `--check-term-format` as it can now be called from
inside the function write_terms() C implementation.

Using `--write-terms` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 36 +++++++++++++++++++++++++++++-------
 git-bisect.sh            | 22 +++++++---------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3c748d1..8c7a5fc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,9 +4,11 @@
 #include "bisect.h"
 #include "refs.h"
 
+static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
+
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
-	N_("git bisect--helper --check-term-format <term> <orig_term>"),
+	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	NULL
 };
 
@@ -56,18 +58,38 @@ static int check_term_format(const char *term, const char *orig_term)
 	return 0;
 }
 
+static int write_terms(const char *bad, const char *good)
+{
+	FILE *fp;
+	int res;
+
+	if (!strcmp(bad, good))
+		return error(_("please use two different terms"));
+
+	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
+		return -1;
+
+	fp = fopen(git_path_bisect_write_terms(), "w");
+	if (!fp)
+		return error(_("could not open the file to write terms"));
+
+	res = fprintf(fp, "%s\n%s\n", bad, good);
+	fclose(fp);
+	return (res < 0) ? -1 : 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
-		CHECK_TERM_FMT
+		WRITE_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
-		OPT_CMDMODE(0, "check-term-format", &cmdmode,
-			 N_("check format of the term"), CHECK_TERM_FMT),
+		OPT_CMDMODE(0, "write-terms", &cmdmode,
+			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -82,10 +104,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	switch (cmdmode) {
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
-	case CHECK_TERM_FMT:
+	case WRITE_TERMS:
 		if (argc != 2)
-			die(_("--check-term-format requires two arguments"));
-		return check_term_format(argv[0], argv[1]);
+			die(_("--write-terms requires two arguments"));
+		return write_terms(argv[0], argv[1]);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 7d7965d..2dd7ec5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -210,7 +210,7 @@ bisect_start() {
 	eval "$eval true" &&
 	if test $must_write_terms -eq 1
 	then
-		write_terms "$TERM_BAD" "$TERM_GOOD"
+		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -557,18 +557,6 @@ get_terms () {
 	fi
 }
 
-write_terms () {
-	TERM_BAD=$1
-	TERM_GOOD=$2
-	if test "$TERM_BAD" = "$TERM_GOOD"
-	then
-		die "$(gettext "please use two different terms")"
-	fi
-	git bisect--helper --check-term-format "$TERM_BAD" bad || exit
-	git bisect--helper --check-term-format "$TERM_GOOD" good || exit
-	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
-}
-
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
@@ -582,13 +570,17 @@ check_and_set_terms () {
 		bad|good)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				write_terms bad good
+				TERM_BAD=bad
+				TERM_GOOD=good
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 			fi
 			;;
 		new|old)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				write_terms new old
+				TERM_BAD=new
+				TERM_GOOD=old
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 			fi
 			;;
 		esac ;;
-- 
2.8.2
