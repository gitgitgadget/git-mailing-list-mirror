Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47B61FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbcHJWQD (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:16:03 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:57614
	"EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752139AbcHJWQD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 18:16:03 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1470866239;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=y1l6eNmePCwZIuNLlf+V4VE5NF6wftt8B2LL3tFQw+M=;
	b=bsN++zrmgtAeJ5/w38pYj76557++qPwE8wiRxWJAIuM1CBoHudmFJ6A+W5LVJBV7
	4XZU5VgQ4vBYS0G55Lahjg6EqMy4oNq5S6ELMX/Nm746Q69i+zWF2t/0ZbsSxW0h0TV
	cmwuXI26rTqp80/IJt4LzrvtoFU+x2NnVYN8jglE=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201567675ae6a-d29ad308-fef5-44f2-8edf-6f7138e6cdf1-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v12 12/13] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Wed, 10 Aug 2016 21:57:19 +0000
X-SES-Outgoing:	2016.08.10-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `get_terms` and `bisect_terms` shell function in C and
add `bisect-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-terms` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++--
 git-bisect.sh            | 35 ++--------------------------
 2 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b6e9973..f912010 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -26,6 +26,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
+	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	NULL
 };
 
@@ -384,6 +385,52 @@ static int bisect_next_check(const struct bisect_terms *terms,
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
+static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int i;
+
+	if (get_terms(terms)) {
+		fprintf(stderr, N_("no terms defined\n"));
+		return -1;
+	}
+	if (argc == 0) {
+		printf(N_("Your current terms are %s for the old state\nand "
+		       "%s for the new state.\n"), terms->term_good.buf,
+		       terms->term_bad.buf);
+		return 0;
+	}
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--term-good"))
+			printf(N_("%s\n"), terms->term_good.buf);
+		else if (!strcmp(argv[i], "--term-bad"))
+			printf(N_("%s\n"), terms->term_bad.buf);
+		else
+			printf(N_("invalid argument %s for 'git bisect "
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
@@ -394,7 +441,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
-		BISECT_NEXT_CHECK
+		BISECT_NEXT_CHECK,
+		BISECT_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -414,6 +462,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
+		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
+			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -422,7 +472,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	bisect_terms_init(&terms);
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage, 0);
+			     git_bisect_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
@@ -471,6 +521,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&terms.term_bad, argv[1]);
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
https://github.com/git/git/pull/281
