Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350192034E
	for <e@80x24.org>; Wed, 20 Jul 2016 21:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbcGTVsF (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:48:05 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:41054
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755535AbcGTVsB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 17:48:01 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469051273;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=gcyxLkO+fH2KYt8wLTQtMQtY6Z5wVb7z0LANKdBzaX8=;
	b=KfKFCl9VY5KlgEGa+UPC0mpDz/RUuCPUAP4haKxttWyO9fGh4b0OIyoLEYXbKjhc
	f4L8WA44v3OU1QUV573ke7Ta0Mu7gDko3abjR8SGNhzqWNiG9yR10jCXZ+OB5B/pb6w
	m3c8fVDk2yYBQfdwvRmbxmUWlteVG2l3Xpa4EPGE=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201560a4782c2-a78be092-6998-48d2-bd34-02186f8d12e1-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v10 10/12] bisect--helper: `check_and_set_terms` shell
 function in C
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

Reimplement the `check_and_set_terms` shell function in C and add
`check-and-set-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--check-and-set-terms` subcommand is a temporary measure to port
shell function in C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and will be called
by some other methods.

check_and_set_terms() sets and receives two global variables namely
TERM_GOOD and TERM_BAD in the shell script. Luckily the file BISECT_TERMS
also contains the value of those variables so its appropriate to evoke the
method get_terms() after calling the subcommand so that it retrieves the
value of TERM_GOOD and TERM_BAD from the file BISECT_TERMS. The two
global variables are passed as arguments to the subcommand.

Also introduce bisect_terms_reset() to empty the contents of `term_good`
and `term_bad` of `struct bisect_terms`.

Also introduce set_terms() to copy the `term_good` and `term_bad` into
`struct bisect_terms` and write it out to the file BISECT_TERMS.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 36 ++++-----------------------------
 2 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d1d12f2..b9119e3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -23,6 +23,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
+	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	NULL
 };
 
@@ -43,6 +44,12 @@ static void bisect_terms_release(struct bisect_terms *terms)
 	strbuf_release(&terms->term_bad);
 }
 
+static void bisect_terms_reset(struct bisect_terms *term)
+{
+	strbuf_reset(&term->term_good);
+	strbuf_reset(&term->term_bad);
+}
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -252,6 +259,39 @@ static int bisect_write(const char *state, const char *rev,
 	return 0;
 }
 
+static int set_terms(struct bisect_terms *terms, const char *bad,
+		     const char *good)
+{
+	bisect_terms_reset(terms);
+	strbuf_addstr(&terms->term_good, good);
+	strbuf_addstr(&terms->term_bad, bad);
+	return write_terms(terms->term_bad.buf, terms->term_good.buf);
+}
+
+static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
+{
+	int no_term_file = is_empty_or_missing_file(git_path_bisect_terms());
+
+	if (one_of(cmd, "skip", "start", "terms", NULL))
+		return 0;
+
+	if (!no_term_file &&
+	    strcmp(cmd, terms->term_bad.buf) &&
+	    strcmp(cmd, terms->term_good.buf))
+		return error(_("Invalid command: you're currently in a "
+				"'%s' '%s' bisect"), terms->term_bad.buf,
+				terms->term_good.buf);
+
+	if (no_term_file) {
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
@@ -260,7 +300,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_CLEAN_STATE,
 		BISECT_RESET,
 		CHECK_EXPECTED_REVS,
-		BISECT_WRITE
+		BISECT_WRITE,
+		CHECK_AND_SET_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -276,6 +317,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
+		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
+			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -319,6 +362,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&terms.term_bad, argv[3]);
 		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
+	case CHECK_AND_SET_TERMS:
+		if (argc != 3)
+			die(_("--check-and-set-terms requires 3 arguments"));
+		strbuf_addstr(&terms.term_good, argv[1]);
+		strbuf_addstr(&terms.term_bad, argv[2]);
+		res = check_and_set_terms(&terms, argv[0]);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index b9896a4..a41e69b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -239,7 +239,8 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
-	check_and_set_terms $state
+	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
+	get_terms
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
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
https://github.com/git/git/pull/273
