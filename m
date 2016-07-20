Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B5A203C1
	for <e@80x24.org>; Wed, 20 Jul 2016 21:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbcGTVsB (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:48:01 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:41050
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755523AbcGTVr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 17:47:56 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469051273;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=S7MhLgrm6SDS/TlUYXDCrYKIPJA8bJ4JCt9j8GxKI3g=;
	b=CRrBk6zGqlewfQE11eUPGEuydfdI/ePAHawmH8FdiabArC2v5lmJ2EasZh2tW8SB
	DZu8UejGn/ZrR7DAXrLX/rJl09xyq/8D4mVjZTrf4HRiUbXcOgnCq37GS1BlnShsMw/
	mMDZg1YX7PC1OyQ+ycJjwHMufST9WiNdhena/Axc=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Wed, 20 Jul 2016 21:47:53 +0000
X-SES-Outgoing:	2016.07.20-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `get_terms` and `bisect_terms` shell function in C and
add `bisect-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

In the shell version, the terms were identified by strings but in C
version its done by bit manipulation and passing the integer value to
the function.

Using `--bisect-terms` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 35 ++---------------------
 2 files changed, 75 insertions(+), 34 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 001096a..185a8ad 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -8,6 +8,13 @@
 #include "run-command.h"
 #include "prompt.h"
 
+enum terms_defined {
+	TERM_BAD = 1,
+	TERM_GOOD = 2,
+	TERM_NEW = 4,
+	TERM_OLD = 8
+};
+
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
@@ -26,6 +33,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
+	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	NULL
 };
 
@@ -359,6 +367,43 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	return 0;
 }
 
+static int get_terms(struct bisect_terms *terms)
+{
+	FILE *fp;
+	int res;
+	fp = fopen(git_path_bisect_terms(), "r");
+	if (!fp)
+		return -1;
+
+	bisect_terms_reset(terms);
+	res = strbuf_getline(&terms->term_bad, fp) == EOF ||
+	      strbuf_getline(&terms->term_good, fp) == EOF;
+
+	fclose(fp);
+	return res ? -1 : 0;
+}
+
+static int bisect_terms(struct bisect_terms *terms, int term_defined)
+{
+	if (get_terms(terms)) {
+		fprintf(stderr, "no terms defined\n");
+		return -1;
+	}
+	if (!term_defined) {
+		printf("Your current terms are %s for the old state\nand "
+		       "%s for the new state.\n", terms->term_good.buf,
+		       terms->term_bad.buf);
+		return 0;
+	}
+
+	if (term_defined == TERM_GOOD || term_defined == TERM_OLD)
+		printf("%s\n", terms->term_good.buf);
+	if (term_defined == TERM_BAD || term_defined == TERM_NEW)
+		printf("%s\n", terms->term_bad.buf);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -369,9 +414,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
-		BISECT_NEXT_CHECK
+		BISECT_NEXT_CHECK,
+		BISECT_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
+	enum terms_defined term_defined = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -389,6 +436,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
+		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
+			 N_("print out the bisect terms"), BISECT_TERMS),
+		OPT_BIT(0, "term-bad", &term_defined,
+			 N_("show the bad term"), TERM_BAD),
+		OPT_BIT(0, "term-good", &term_defined,
+			 N_("show the good term"), TERM_GOOD),
+		OPT_BIT(0, "term-new", &term_defined,
+			 N_("show the new term"), TERM_NEW),
+		OPT_BIT(0, "term-old", &term_defined,
+			 N_("show the old term"), TERM_OLD),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -399,6 +456,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
+	if (cmdmode != BISECT_TERMS && term_defined)
+		die(_("--term-bad, --term-good, --term-new and --term-old "
+		      "can be used only with --bisect-terms"));
+
+	if (term_defined != 0 && term_defined != TERM_BAD &&
+	    term_defined != TERM_GOOD && term_defined != TERM_NEW &&
+	    term_defined != TERM_OLD)
+		die(_("only one option among --term-bad, --term-good, "
+		      "--term-new and --term-old can be used."));
+
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
 
@@ -446,6 +513,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&terms.term_bad, argv[1]);
 		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
 		break;
+	case BISECT_TERMS:
+		if (argc > 1)
+			die(_("--bisect-terms requires 0 or 1 argument"));
+		res = bisect_terms(&terms, term_defined);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index c2d6319..aea97c5f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -355,7 +355,7 @@ bisect_replay () {
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
-			bisect_terms $rev ;;
+			git bisect--helper --bisect-terms $rev  || exit;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
@@ -437,37 +437,6 @@ get_terms () {
 	fi
 }
 
-bisect_terms () {
-	get_terms
-	if ! test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		die "$(gettext "no terms defined")"
-	fi
-	case "$#" in
-	0)
-		gettextln "Your current terms are $TERM_GOOD for the old state
-and $TERM_BAD for the new state."
-		;;
-	1)
-		arg=$1
-		case "$arg" in
-			--term-good|--term-old)
-				printf '%s\n' "$TERM_GOOD"
-				;;
-			--term-bad|--term-new)
-				printf '%s\n' "$TERM_BAD"
-				;;
-			*)
-				die "$(eval_gettext "invalid argument \$arg for 'git bisect terms'.
-Supported options are: --term-good|--term-old and --term-bad|--term-new.")"
-				;;
-		esac
-		;;
-	*)
-		usage ;;
-	esac
-}
-
 case "$#" in
 0)
 	usage ;;
@@ -498,7 +467,7 @@ case "$#" in
 	run)
 		bisect_run "$@" ;;
 	terms)
-		bisect_terms "$@" ;;
+		git bisect--helper --bisect-terms "$@" || exit;;
 	*)
 		usage ;;
 	esac

--
https://github.com/git/git/pull/273
