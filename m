Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824141FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbdJ0PGq (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:06:46 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:54472
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751617AbdJ0PGj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509116798;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=c9tdZedrt1BjzvwKc1g4DMAbY04MvgwIyGURGcKdzP4=;
        b=bIk5H5ryLAgwjY6IIb1+Bque52tOhwrGl52LOEi3KPnCLoUBfYCSPRaizJhdCKZr
        z7gSpfaGSob88tdWVzH/mBrcnyjY3HTBPk9R2KmlVHsQpTgfWb6KcLvSma3g7Jl0f/t
        Y0oTn5y63PWhSH5/T152Ha3ZCKK3cCentofc9Hwc=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell
 function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Oct 2017 15:06:37 +0000
X-SES-Outgoing: 2017.10.27-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement `bisect_next_check` shell function in C and add
`bisect-next-check` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

`bisect_voc` shell function is no longer useful now and is replaced by
using a char *[] of "new|bad" and "good|old" values.

Using `--bisect-next-check` is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Helped-by: Stephan Beyer <s-beyer@gmx.net>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 60 +++----------------------------
 2 files changed, 94 insertions(+), 57 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 65abf8a70c6d9..0f9c3e63821b8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -6,6 +6,7 @@
 #include "dir.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "prompt.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -21,6 +22,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
+	N_("git bisect--helper --bisect-next-check [<term>] <good_term> <bad_term>"),
 	NULL
 };
 
@@ -44,6 +46,11 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 	terms->term_bad = xstrdup(bad);
 }
 
+static const char *voc[] = {
+	"bad|new",
+	"good|old"
+};
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -264,6 +271,79 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 	return 0;
 }
 
+static int mark_good(const char *refname, const struct object_id *oid,
+		     int flag, void *cb_data)
+{
+	int *m_good = (int *)cb_data;
+	*m_good = 0;
+	return 1;
+}
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	int missing_good = 1, missing_bad = 1, retval = 0;
+	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
+	const char *good_glob = xstrfmt("%s-*", terms->term_good);
+
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+
+	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
+			     (void *) &missing_good);
+
+	if (!missing_good && !missing_bad)
+		goto finish;
+
+	if (!current_term)
+		goto fail;
+
+	if (missing_good && !missing_bad && current_term &&
+	    !strcmp(current_term, terms->term_good)) {
+		char *yesno;
+		/*
+		 * have bad (or new) but not good (or old). We could bisect
+		 * although this is less optimum.
+		 */
+		fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
+			terms->term_bad);
+		if (!isatty(0))
+			goto finish;
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. The program will only accept English input
+		 * at this point.
+		 */
+		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
+		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
+			goto fail;
+
+		goto finish;
+	}
+	if (!is_empty_or_missing_file(git_path_bisect_start())) {
+		error(_("You need to give me at least one %s and "
+			"%s revision. You can use \"git bisect %s\" "
+			"and \"git bisect %s\" for that.\n"),
+			voc[0], voc[1], voc[0], voc[1]);
+		goto fail;
+	} else {
+		error(_("You need to start by \"git bisect start\". You "
+			"then need to give me at least one %s and %s "
+			"revision. You can use \"git bisect %s\" and "
+			"\"git bisect %s\" for that.\n"),
+			voc[1], voc[0], voc[1], voc[0]);
+		goto fail;
+	}
+	goto finish;
+
+fail:
+	retval = -1;
+finish:
+	free((void *) good_glob);
+	free((void *) bad_ref);
+	return retval;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -273,7 +353,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
-		CHECK_AND_SET_TERMS
+		CHECK_AND_SET_TERMS,
+		BISECT_NEXT_CHECK
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -291,6 +372,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("update the refs according to the bisection state and may write it to BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
+		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
+			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -335,6 +418,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, argv[2], argv[1]);
 		res = check_and_set_terms(&terms, argv[0]);
 		break;
+	case BISECT_NEXT_CHECK:
+		if (argc != 2 && argc != 3)
+			return error(_("--bisect-next-check requires 2 or 3 arguments"));
+		set_terms(&terms, argv[1], argv[0]);
+		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 0447b73aa588b..c21fafc62d71f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -271,59 +271,14 @@ bisect_state() {
 	bisect_auto_next
 }
 
-bisect_next_check() {
-	missing_good= missing_bad=
-	git show-ref -q --verify refs/bisect/$TERM_BAD || missing_bad=t
-	test -n "$(git for-each-ref "refs/bisect/$TERM_GOOD-*")" || missing_good=t
-
-	case "$missing_good,$missing_bad,$1" in
-	,,*)
-		: have both $TERM_GOOD and $TERM_BAD - ok
-		;;
-	*,)
-		# do not have both but not asked to fail - just report.
-		false
-		;;
-	t,,"$TERM_GOOD")
-		# have bad (or new) but not good (or old).  we could bisect although
-		# this is less optimum.
-		eval_gettextln "Warning: bisecting only with a \$TERM_BAD commit." >&2
-		if test -t 0
-		then
-			# TRANSLATORS: Make sure to include [Y] and [n] in your
-			# translation. The program will only accept English input
-			# at this point.
-			gettext "Are you sure [Y/n]? " >&2
-			read yesno
-			case "$yesno" in [Nn]*) exit 1 ;; esac
-		fi
-		: bisect without $TERM_GOOD...
-		;;
-	*)
-		bad_syn=$(bisect_voc bad)
-		good_syn=$(bisect_voc good)
-		if test -s "$GIT_DIR/BISECT_START"
-		then
-
-			eval_gettextln "You need to give me at least one \$bad_syn and one \$good_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		else
-			eval_gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one \$good_syn and one \$bad_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		fi
-		exit 1 ;;
-	esac
-}
-
 bisect_auto_next() {
-	bisect_next_check && bisect_next || :
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next || :
 }
 
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check $TERM_GOOD
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
@@ -355,7 +310,7 @@ bisect_next() {
 }
 
 bisect_visualize() {
-	bisect_next_check fail
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
 	if test $# = 0
 	then
@@ -409,7 +364,7 @@ bisect_replay () {
 }
 
 bisect_run () {
-	bisect_next_check fail
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
 	while true
 	do
@@ -482,13 +437,6 @@ get_terms () {
 	fi
 }
 
-bisect_voc () {
-	case "$1" in
-	bad) echo "bad|new" ;;
-	good) echo "good|old" ;;
-	esac
-}
-
 bisect_terms () {
 	get_terms
 	if ! test -s "$GIT_DIR/BISECT_TERMS"

--
https://github.com/git/git/pull/420
