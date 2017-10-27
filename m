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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6F91FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdJ0PGv (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:06:51 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:44652
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbdJ0PGj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509116798;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=QPsGkIYBQb9mhzFhdUkJdUxXyXJRYEgh+u96E4mI7eQ=;
        b=RSKsp/24WVEeLNpt43DQJyyeOvHXJIZAGAwgKOVqNk7TjXHORt0XxXTYf67Hv1ke
        eEcPw64d02kuy8+gq95KKigI1DGsaCbb9fni27FZ2zYVOqi17Ab3Or4e506VNGcnPx7
        qnXipmyl0jF94ht/1A3fzkcEOy1qOoGIjhLO1oHo=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f5e5ee273-de8fa1d2-1d59-4990-93f5-d36a6cb3f45a-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 Part II 4/8] bisect--helper: `check_and_set_terms` shell
 function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Oct 2017 15:06:37 +0000
X-SES-Outgoing: 2017.10.27-54.240.7.11
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

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 36 ++++--------------------------------
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6295f53c850a8..65abf8a70c6d9 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,6 +20,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
+	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	NULL
 };
 
@@ -234,6 +235,35 @@ static int bisect_write(const char *state, const char *rev,
 	return retval;
 }
 
+static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
+{
+	int has_term_file = !is_empty_or_missing_file(git_path_bisect_terms());
+
+	if (one_of(cmd, "skip", "start", "terms", NULL))
+		return 0;
+
+	if (has_term_file && strcmp(cmd, terms->term_bad) &&
+	    strcmp(cmd, terms->term_good))
+		return error(_("Invalid command: you're currently in a "
+				"%s/%s bisect"), terms->term_bad,
+				terms->term_good);
+
+	if (!has_term_file) {
+		if (one_of(cmd, "bad", "good", NULL)) {
+			free_terms(terms);
+			set_terms(terms, "bad", "good");
+			return write_terms(terms->term_bad, terms->term_good);
+		}
+		else if (one_of(cmd, "new", "old", NULL)) {
+			free_terms(terms);
+			set_terms(terms, "new", "old");
+			return write_terms(terms->term_bad, terms->term_good);
+		}
+	}
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -242,7 +272,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
-		BISECT_WRITE
+		BISECT_WRITE,
+		CHECK_AND_SET_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -258,6 +289,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("update the refs according to the bisection state and may write it to BISECT_LOG"), BISECT_WRITE),
+		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
+			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -296,6 +329,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, argv[3], argv[2]);
 		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
+	case CHECK_AND_SET_TERMS:
+		if (argc != 3)
+			return error(_("--check-and-set-terms requires 3 arguments"));
+		set_terms(&terms, argv[2], argv[1]);
+		res = check_and_set_terms(&terms, argv[0]);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 1eab94ec943a1..0447b73aa588b 100755
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
https://github.com/git/git/pull/420
