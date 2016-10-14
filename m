Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2241209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757373AbcJNOOe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:34 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:32818
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757294AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=U4ViTuOK5Ql5xtpZNX34BGmuK5wxtk9qoErBF/xjRY8=;
        b=AVjP9ncNuTZNyAqdoDNVyskl+QNgqjn90t3I0EWx8QOfGtyjGzOYphik4Yk6cD1H
        cmR17qN8di/He1hYI6uisKbMoZym+6uEYiXr7Ghfvqcg9wAdGj4DhQQcobL7ZOzTw6Y
        WFL0DjX0Mqg/JJlZdakjmtthoeUFOjwV40yNi0y8=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1aca-0c26fb8c-404f-4f57-afe7-7ebb552a1002-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 10/27] bisect--helper: `check_and_set_terms` shell
 function in C
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

Reimplement the `check_and_set_terms` shell function in C and add
`check-and-set-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--check-and-set-terms` subcommand is a temporary measure to port
shell function in C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired but its
implementation will be called by some other methods.

check_and_set_terms() sets and receives two global variables namely
TERM_GOOD and TERM_BAD in the shell script. Luckily the file BISECT_TERMS
also contains the value of those variables so its appropriate to evoke the
method get_terms() after calling the subcommand so that it retrieves the
value of TERM_GOOD and TERM_BAD from the file BISECT_TERMS. The two
global variables are passed as arguments to the subcommand.

Also introduce set_terms() to copy the `term_good` and `term_bad` into
`struct bisect_terms` and write it out to the file BISECT_TERMS.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 36 ++++--------------------------------
 2 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3f19b68..c6c11e3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,6 +20,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
+	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	NULL
 };
 
@@ -212,6 +213,38 @@ static int bisect_write(const char *state, const char *rev,
 	return retval;
 }
 
+static int set_terms(struct bisect_terms *terms, const char *bad,
+		     const char *good)
+{
+	terms->term_good = xstrdup(good);
+	terms->term_bad = xstrdup(bad);
+	return write_terms(terms->term_bad, terms->term_good);
+}
+
+static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
+{
+	int has_term_file = !is_empty_or_missing_file(git_path_bisect_terms());
+
+	if (one_of(cmd, "skip", "start", "terms", NULL))
+		return 0;
+
+	if (has_term_file &&
+	    strcmp(cmd, terms->term_bad) &&
+	    strcmp(cmd, terms->term_good))
+		return error(_("Invalid command: you're currently in a "
+				"%s/%s bisect"), terms->term_bad,
+				terms->term_good);
+
+	if (!has_term_file) {
+		if (one_of(cmd, "bad", "good", NULL))
+			return set_terms(terms, "bad", "good");
+		if (one_of(cmd, "new", "old", NULL))
+			return set_terms(terms, "new", "old");
+	}
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -220,7 +253,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_CLEAN_STATE,
 		BISECT_RESET,
 		CHECK_EXPECTED_REVS,
-		BISECT_WRITE
+		BISECT_WRITE,
+		CHECK_AND_SET_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -236,6 +270,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
+		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
+			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -278,6 +314,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		terms.term_bad = xstrdup(argv[3]);
 		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
+	case CHECK_AND_SET_TERMS:
+		if (argc != 3)
+			die(_("--check-and-set-terms requires 3 arguments"));
+		terms.term_good = xstrdup(argv[1]);
+		terms.term_bad = xstrdup(argv[2]);
+		res = check_and_set_terms(&terms, argv[0]);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index dfdec33..bdf2227 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -238,7 +238,8 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
-	check_and_set_terms $state
+	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
+	get_terms
 	case "$#,$state" in
 	0,*)
 		die "Please call 'bisect_state' with at least one argument." ;;
@@ -390,7 +391,8 @@ bisect_replay () {
 			command="$bisect"
 		fi
 		get_terms
-		check_and_set_terms "$command"
+		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
+		get_terms
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
@@ -480,36 +482,6 @@ get_terms () {
 	fi
 }
 
-check_and_set_terms () {
-	cmd="$1"
-	case "$cmd" in
-	skip|start|terms) ;;
-	*)
-		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$TERM_BAD" && test "$cmd" != "$TERM_GOOD"
-		then
-			die "$(eval_gettext "Invalid command: you're currently in a \$TERM_BAD/\$TERM_GOOD bisect.")"
-		fi
-		case "$cmd" in
-		bad|good)
-			if ! test -s "$GIT_DIR/BISECT_TERMS"
-			then
-				TERM_BAD=bad
-				TERM_GOOD=good
-				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
-			fi
-			;;
-		new|old)
-			if ! test -s "$GIT_DIR/BISECT_TERMS"
-			then
-				TERM_BAD=new
-				TERM_GOOD=old
-				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
-			fi
-			;;
-		esac ;;
-	esac
-}
-
 bisect_voc () {
 	case "$1" in
 	bad) echo "bad|new" ;;

--
https://github.com/git/git/pull/287
