From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v9 3/3] bisect--helper: `write_terms` shell function in C
Date: Wed, 25 May 2016 00:12:42 +0530
Message-ID: <20160524184242.7518-4-pranit.bauva@gmail.com>
References: <20160524184242.7518-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, gitster@pobox.com,
	larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@gmail.com, sunshine@sunshineco.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 20:46:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HLz-0004lU-3h
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbcEXSqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 14:46:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33131 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbcEXSqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 14:46:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id b124so2478734pfb.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qtlN78AMp3dgcbMPJveCoFABarRkUFDgKFgw5yOIvS8=;
        b=o5DYgIT5QC/O+W28ng6XyJ47ExZltK08PP5V6tEpFmHEN5mes9ojp0hFMHYeN+wLgE
         X99nMpuADAZLjO5r0GVyf//xjPlqwYYGrBSD1HObTc7aYfQqE1ApbcuLi8OAp2cA8rwR
         qShQ75s7+gvLYci4ZvQq3Am7LIFWkjvWOOwrfiY9fTXv2+lJuy5uPY6+EIhIEBJf+y/V
         /2SYaCw7KmXmtObpiiJ/fX3d3tQ3m63p4LVd+D5KgASW1uaGOCgvnD4mzavpAkgDvxLt
         545+4XCOc53JE4IO3+vNHEmOvwT8E+3vNisKM8jhn42PpRiz4tStwWrsRGmGgS0FwpB1
         x9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qtlN78AMp3dgcbMPJveCoFABarRkUFDgKFgw5yOIvS8=;
        b=TDmdx10tyUJD2iXEJ+RZpcQVn9y4P//IvPrGHaIgBMipG0KLotGDDir8VU9wMund6c
         hvRzFTMObi+fTcIb+XyeZtUXbKChN2od8Ww7VmUrflWCZLoJ+Ifhn9k0lTCX1aS4vVwk
         9vT8ORXjkPwlC3JpY+OzEhzMtT1dT3j/JxNzLg/ShkzaogKVFwPT/t4tLH3ZONZDiyAe
         0dPlMMtXb9Om8ibzC/Omu7hLeQTXVSf0uWxMpbtHVr0ikYCkFBYUNtRMEZCJuZ+d8ZcN
         YFqAw/fn0JHxed5kjWAxzZ9bLxxunflcyWlCJf07et8ABz5TGBhwo3aN9MCcE9kTkIHt
         43DQ==
X-Gm-Message-State: ALyK8tLnXiQcdw0XCNvFsvjg0TUkBXND789nTuKBYIa2w2Glmj4TMjXpgUg5O+DZpxpIEg==
X-Received: by 10.98.28.84 with SMTP id c81mr9163085pfc.131.1464115609411;
        Tue, 24 May 2016 11:46:49 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id u2sm6918859pan.45.2016.05.24.11.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 11:46:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160524184242.7518-1-pranit.bauva@gmail.com>
In-Reply-To: <20160524072124.2945-1-pranit.bauva@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295520>

Reimplement the `write_terms` shell function in C and add a `write-terms`
subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
remove the subcommand `--check-term-format` as it can now be called from
inside the function write_terms() C implementation.

Also `|| exit` is added when calling write-terms subcommand from
git-bisect.sh so as to exit whenever there is an error.

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
index 3c748d1..91027b0 100644
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
+		return error_errno(_("could not open the file BISECT_TERMS"));
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
index 7d7965d..cd39bd0 100755
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
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
 			fi
 			;;
 		new|old)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				write_terms new old
+				TERM_BAD=new
+				TERM_GOOD=old
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
 			fi
 			;;
 		esac ;;
-- 
2.8.3
