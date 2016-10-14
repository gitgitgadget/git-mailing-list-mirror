Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2252A1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbcJNOOr (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:47 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:32823
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757334AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=WgvE7rqyxkOQoseevzVSFFvLWSpZ5HF6hHrt0WDmSOw=;
        b=QOdecHwulj4lhC0NL1suftDLnyH+i7b5zBGR0Mg6g0uuMCTkbeIo1Je8FKM7SY/P
        9KVPJZljiVc6yj6Qu/LU4yDwUSgazi2guwy9/5QJ16ExJGgZBXKIV3OPFz9klryiD/p
        hyN4EZTFBLkENA9VFIV3lHi85C9rYs1ZzP+zH2FM=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1ad5-0f90c88e-2077-4155-94e9-7d71dbbac38f-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 12/27] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the `get_terms` and `bisect_terms` shell function in C and
add `bisect-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-terms` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Also use error() to report "no terms defined" and accordingly change the
test in t6030.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c    | 72 +++++++++++++++++++++++++++++++++++++++++++--
 git-bisect.sh               | 35 ++--------------------
 t/t6030-bisect-porcelain.sh |  2 +-
 3 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 317d671..6a5878c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -23,6 +23,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
+	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	NULL
 };
 
@@ -343,6 +344,65 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	return retval;
 }
 
+static int get_terms(struct bisect_terms *terms)
+{
+	struct strbuf str = STRBUF_INIT;
+	FILE *fp = NULL;
+	int res = 0;
+	fp = fopen(git_path_bisect_terms(), "r");
+	if (!fp) {
+		res = -1;
+		goto finish;
+	}
+	strbuf_getline_lf(&str, fp);
+	terms->term_bad = strbuf_detach(&str, NULL);
+	strbuf_getline_lf(&str, fp);
+	terms->term_good = strbuf_detach(&str, NULL);
+	goto finish;
+finish:
+	if (fp)
+		fclose(fp);
+	strbuf_release(&str);
+	return res;
+}
+
+static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int i;
+	const char bisect_term_usage[] =
+"git bisect--helper --bisect-terms [--term-good | --term-bad | ]"
+"--term-old | --term-new";
+
+	if (get_terms(terms))
+		return error(_("no terms defined"));
+
+	if (argc > 1) {
+		usage(bisect_term_usage);
+		return -1;
+	}
+
+	if (argc == 0) {
+		printf(_("Your current terms are %s for the old state\nand "
+		       "%s for the new state.\n"), terms->term_good,
+		       terms->term_bad);
+		return 0;
+	}
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--term-good"))
+			printf("%s\n", terms->term_good);
+		else if (!strcmp(argv[i], "--term-bad"))
+			printf("%s\n", terms->term_bad);
+		else
+			die(_("invalid argument %s for 'git bisect "
+				  "terms'.\nSupported options are: "
+				  "--term-good|--term-old and "
+				  "--term-bad|--term-new."), argv[i]);
+	}
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -353,7 +413,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
-		BISECT_NEXT_CHECK
+		BISECT_NEXT_CHECK,
+		BISECT_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -373,6 +434,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
+		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
+			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -380,7 +443,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct bisect_terms terms;
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage, 0);
+			     git_bisect_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
@@ -429,6 +492,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		terms.term_bad = xstrdup(argv[1]);
 		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
 		break;
+	case BISECT_TERMS:
+		if (argc > 1)
+			die(_("--bisect-terms requires 0 or 1 argument"));
+		res = bisect_terms(&terms, argv, argc);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index fe6c9d0..d6c8b5a 100755
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
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 18e7998..e62e2a8 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -802,7 +802,7 @@ test_expect_success 'bisect terms needs 0 or 1 argument' '
 	test_must_fail git bisect terms only-one &&
 	test_must_fail git bisect terms 1 2 &&
 	test_must_fail git bisect terms 2>actual &&
-	echo "no terms defined" >expected &&
+	echo "error: no terms defined" >expected &&
 	test_i18ncmp expected actual
 '
 

--
https://github.com/git/git/pull/287
