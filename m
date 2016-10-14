Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC16209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757419AbcJNOPA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:15:00 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:32822
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757302AbcJNOOY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=FUa4/rSAzoUUx4rh9GemYy5gcPLqNSy9ejMnnFPuDjc=;
        b=XkMmg+5XQnvR+NYZt5dseKXdipeh6tUm3uesQjyTLW+7ipOW8fAsoTNDaTvHgFuA
        PDyKudcyrc1B2hMfNF+tGkyYiRVXExNU2ppwZzKgzCcO50RVxtFMtwtodGLHTNwv4Xa
        e5aH50ugncd5vhauDDiJxpdR/EMoDhuiw97FZN8c=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b54-0ac61448-98b1-4c7d-bfdd-47af95f52153-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 19/27] bisect--helper: `bisect_state` & `bisect_head`
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

Reimplement the `bisect_state` shell function in C and also add a
subcommand `--bisect-state` to `git-bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-state` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

`bisect_head` is called from `bisect_state` thus its not required to
introduce another subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 57 +++-----------------------------
 2 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1767916..1481c6d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-autostart"),
+	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
+	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
 };
 
@@ -784,6 +786,79 @@ static int bisect_autostart(struct bisect_terms *terms)
 	return 0;
 }
 
+static char *bisect_head(void)
+{
+	if (is_empty_or_missing_file(git_path_bisect_head()))
+		return "HEAD";
+	else
+		return "BISECT_HEAD";
+}
+
+static int bisect_state(struct bisect_terms *terms, const char **argv,
+			int argc)
+{
+	const char *state = argv[0];
+
+	get_terms(terms);
+	if (check_and_set_terms(terms, state))
+		return -1;
+
+	if (!argc)
+		die(_("Please call `--bisect-state` with at least one argument"));
+
+	if (argc == 1 && one_of(state, terms->term_good,
+	    terms->term_bad, "skip", NULL)) {
+		const char *bisected_head = xstrdup(bisect_head());
+		const char *hex[1];
+		unsigned char sha1[20];
+
+		if (get_sha1(bisected_head, sha1))
+			die(_("Bad rev input: %s"), bisected_head);
+		if (bisect_write(state, sha1_to_hex(sha1), terms, 0))
+			return -1;
+
+		*hex = xstrdup(sha1_to_hex(sha1));
+		if (check_expected_revs(hex, 1))
+			return -1;
+		return bisect_auto_next(terms, NULL);
+	}
+
+	if ((argc == 2 && !strcmp(state, terms->term_bad)) ||
+			one_of(state, terms->term_good, "skip", NULL)) {
+		int i;
+		struct string_list hex = STRING_LIST_INIT_DUP;
+
+		for (i = 1; i < argc; i++) {
+			unsigned char sha1[20];
+
+			if (get_sha1(argv[i], sha1)) {
+				string_list_clear(&hex, 0);
+				die(_("Bad rev input: %s"), argv[i]);
+			}
+			string_list_append(&hex, sha1_to_hex(sha1));
+		}
+		for (i = 0; i < hex.nr; i++) {
+			const char **hex_string = (const char **) &hex.items[i].string;
+			if(bisect_write(state, *hex_string, terms, 0)) {
+				string_list_clear(&hex, 0);
+				return -1;
+			}
+			if (check_expected_revs(hex_string, 1)) {
+				string_list_clear(&hex, 0);
+				return -1;
+			}
+		}
+		string_list_clear(&hex, 0);
+		return bisect_auto_next(terms, NULL);
+	}
+
+	if (!strcmp(state, terms->term_bad))
+		die(_("'git bisect %s' can take only one argument."),
+		      terms->term_bad);
+
+	return -1;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -798,6 +873,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -823,6 +899,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -902,6 +980,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		terms.term_bad = "bad";
 		res = bisect_autostart(&terms);
 		break;
+	case BISECT_STATE:
+		if (argc == 0)
+			die(_("--bisect-state requires at least 1 argument"));
+		terms.term_good = "good";
+		terms.term_bad = "bad";
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index cd56551..a9eebbb 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,16 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_head()
-{
-	if test -f "$GIT_DIR/BISECT_HEAD"
-	then
-		echo BISECT_HEAD
-	else
-		echo HEAD
-	fi
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -61,44 +51,7 @@ bisect_skip() {
 		esac
 		all="$all $revs"
 	done
-	eval bisect_state 'skip' $all
-}
-
-bisect_state() {
-	git bisect--helper --bisect-autostart
-	state=$1
-	get_terms
-	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
-	get_terms
-	case "$#,$state" in
-	0,*)
-		die "Please call 'bisect_state' with at least one argument." ;;
-	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
-		bisected_head=$(bisect_head)
-		rev=$(git rev-parse --verify "$bisected_head") ||
-			die "$(eval_gettext "Bad rev input: \$bisected_head")"
-		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
-		git bisect--helper --check-expected-revs "$rev" ;;
-	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
-		shift
-		hash_list=''
-		for rev in "$@"
-		do
-			sha=$(git rev-parse --verify "$rev^{commit}") ||
-				die "$(eval_gettext "Bad rev input: \$rev")"
-			hash_list="$hash_list $sha"
-		done
-		for rev in $hash_list
-		do
-			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
-		done
-		git bisect--helper --check-expected-revs $hash_list ;;
-	*,"$TERM_BAD")
-		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argument.")" ;;
-	*)
-		usage ;;
-	esac
-	git bisect--helper --bisect-auto-next || exit
+	eval git bisect--helper --bisect-state 'skip' $all
 }
 
 bisect_visualize() {
@@ -184,8 +137,8 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state="$TERM_GOOD"
 		fi
 
-		# We have to use a subshell because "bisect_state" can exit.
-		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
+		# We have to use a subshell because "--bisect-state" can exit.
+		( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )
 		res=$?
 
 		cat "$GIT_DIR/BISECT_RUN"
@@ -200,7 +153,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 		if [ $res -ne 0 ]
 		then
 			eval_gettextln "bisect run failed:
-'bisect_state \$state' exited with error code \$res" >&2
+'git bisect--helper --bisect-state \$state' exited with error code \$res" >&2
 			exit $res
 		fi
 
@@ -241,7 +194,7 @@ case "$#" in
 	start)
 		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		bisect_state "$cmd" "$@" ;;
+		git bisect--helper --bisect-state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
 	next)

--
https://github.com/git/git/pull/287
