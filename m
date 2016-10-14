Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D78A1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbcJNOa2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:30:28 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:54366
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753979AbcJNOa0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454455;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=DhuU0oRGDwSGpoPqwhtUhOqtin3t33htQaJZqFQRpas=;
        b=XD4bLp6VgxmPclzeIRkkmBPI7X+2GPLr7BoLkUYzm0+1RtRIhAiU2QTBu8rYTU1f
        eQFSt1S7m4FFq2odn0ZNYTXmDG1EegX4PqIriuLV52iqFIIv7W71kf1+Uk4yJ3J0dos
        5OzkzO4tlsF9njHDjGAtZF9B8quegylNkjPGRiLA=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1a84-d3b8c27a-aeb6-4cfd-8b9f-1db291331b2f-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 03/27] bisect--helper: `write_terms` shell function in C
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

Reimplement the `write_terms` shell function in C and add a `write-terms`
subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
remove the subcommand `--check-term-format` as it can now be called from
inside the function write_terms() C implementation.

Also `|| exit` is added when calling write-terms subcommand from
git-bisect.sh so as to exit whenever there is an error.

Using `--write-terms` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and its implementation will
be called by some other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 36 +++++++++++++++++++++++++++++-------
 git-bisect.sh            | 22 +++++++---------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a47f1f2..65cf519 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,9 +4,11 @@
 #include "bisect.h"
 #include "refs.h"
 
+static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
-	N_("git bisect--helper --check-term-format <term> <orig_term>"),
+	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	NULL
 };
 
@@ -57,18 +59,38 @@ static int check_term_format(const char *term, const char *orig_term)
 	return 0;
 }
 
+static int write_terms(const char *bad, const char *good)
+{
+	FILE *fp = NULL;
+	int res;
+
+	if (!strcmp(bad, good))
+		return error(_("please use two different terms"));
+
+	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
+		return -1;
+
+	fp = fopen(git_path_bisect_terms(), "w");
+	if (!fp)
+		return error_errno(_("could not open the file BISECT_TERMS"));
+
+	res = fprintf(fp, "%s\n%s\n", bad, good);
+	res |= fclose(fp);
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
@@ -83,10 +105,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index a727c59..9ef6cb8 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -209,7 +209,7 @@ bisect_start() {
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
https://github.com/git/git/pull/287
