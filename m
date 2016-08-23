Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2581FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 13:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757960AbcHWNmz (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 09:42:55 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:49157
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757348AbcHWNmy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 09:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=t6cwZ/5T+/oAusqSBgGmrByG7MUY2/EM9qs2Ehzm9PU=;
        b=WhIjjt/wjbwmm7XUZFlJI96i9BxAhi1Cm9QYRej7yLuQwzR8KSzR3DXl1ef2V2TN
        ypTQrE+e0bl4rJN2n8rzb/qaDu5u5hZEbRmH33ZMiVR0XFiphoxQbtGwlgZvhcCUtgX
        XfXry1zEt071roWMAYvBVLfDlifr0GrOweaa7Ihw=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6ae-27df9d50-59b2-4ee2-8c5b-89e7e70a2dd0-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 11/27] bisect--helper: `bisect_next_check` & bisect_voc
 shell function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement `bisect_next_check` shell function in C and add
`bisect-next-check` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Also reimplement `bisect_voc` shell function in C and call it from
`bisect_next_check` implementation in C.

Using `--bisect-next-check` is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  60 ++-------------------------
 2 files changed, 106 insertions(+), 57 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 450426c..aca3908 100644
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
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
+	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
 	NULL
 };
 
@@ -253,6 +255,95 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
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
+static char *bisect_voc(char *revision_type)
+{
+	if (!strcmp(revision_type, "bad"))
+		return "bad|new";
+	if (!strcmp(revision_type, "good"))
+		return "good|old";
+
+	return NULL;
+}
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	int missing_good = 1, missing_bad = 1;
+	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad.buf);
+	char *good_glob = xstrfmt("%s-*", terms->term_good.buf);
+	char *bad_syn, *good_syn;
+
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+	free(bad_ref);
+
+	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
+			     (void *) &missing_good);
+	free(good_glob);
+
+	if (!missing_good && !missing_bad)
+		return 0;
+
+	if (!current_term)
+		return -1;
+
+	if (missing_good && !missing_bad && current_term &&
+	    !strcmp(current_term, terms->term_good.buf)) {
+		char *yesno;
+		/*
+		 * have bad (or new) but not good (or old). We could bisect
+		 * although this is less optimum.
+		 */
+		fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
+			terms->term_bad.buf);
+		if (!isatty(0))
+			return 0;
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. The program will only accept English input
+		 * at this point.
+		 */
+		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
+		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
+			return -1;
+
+		return 0;
+	}
+	bad_syn = xstrdup(bisect_voc("bad"));
+	good_syn = xstrdup(bisect_voc("good"));
+	if (!is_empty_or_missing_file(git_path_bisect_start())) {
+		error(_("You need to give me at least one %s and "
+			"%s revision. You can use \"git bisect %s\" "
+			"and \"git bisect %s\" for that. \n"),
+			bad_syn, good_syn, bad_syn, good_syn);
+		free(bad_syn);
+		free(good_syn);
+		return -1;
+	}
+	else {
+		error(_("You need to start by \"git bisect start\". You "
+			"then need to give me at least one %s and %s "
+			"revision. You can use \"git bisect %s\" and "
+			"\"git bisect %s\" for that.\n"),
+			good_syn, bad_syn, bad_syn, good_syn);
+		free(bad_syn);
+		free(good_syn);
+		return -1;
+	}
+	free(bad_syn);
+	free(good_syn);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -262,7 +353,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET,
 		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
-		CHECK_AND_SET_TERMS
+		CHECK_AND_SET_TERMS,
+		BISECT_NEXT_CHECK
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -280,6 +372,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
+		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
+			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -330,6 +424,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&terms.term_bad, argv[2]);
 		res = check_and_set_terms(&terms, argv[0]);
 		break;
+	case BISECT_NEXT_CHECK:
+		if (argc != 2 && argc != 3)
+			die(_("--bisect-next-check requires 2 or 3 arguments"));
+		strbuf_addstr(&terms.term_good, argv[0]);
+		strbuf_addstr(&terms.term_bad, argv[1]);
+		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index bdf2227..fe6c9d0 100755
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
https://github.com/git/git/pull/287
