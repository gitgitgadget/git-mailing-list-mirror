Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99EF2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 22:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbcGTWoM (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 18:44:12 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:42895
	"EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932133AbcGTWoK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 18:44:10 -0400
X-Greylist: delayed 2335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jul 2016 18:44:10 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469051273;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=bzEy8Fm4AXy7jstCrSSPNiMgLtetmOzarZbexOXZF8I=;
	b=Ec28I5oZBwGYZRa7JQTfKDidvFodFpco2errK0fA/gt3X1kAv24f3FEKx3ZBKJb6
	4t9SGxB+8shwkXCXb4OXf7e6WVALcx1zUNfRk7nqL4N7WjAVPHDff/IIflryU3LVuF/
	uY9wAwGm/vUe9iuwg76Jkg1ozeyKmmDRClU/rS+o=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201560a4782ac-5add737e-3648-4ed6-a8a2-e451378a1782-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v10 09/12] bisect--helper: `bisect_write` shell function in
 C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Wed, 20 Jul 2016 21:47:53 +0000
X-SES-Outgoing:	2016.07.20-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `bisect_write` shell function in C and add a
`bisect-write` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-write` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
from the global shell script thus we need to pass it to the subcommand
using the arguments. We then store them in a struct bisect_terms and
pass the memory address around functions.

This patch also introduces new methods namely bisect_state_init() and
bisect_terms_release() for easy memory management for the struct
bisect_terms.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 97 ++++++++++++++++++++++++++++++++++++++++++++----
 git-bisect.sh            | 25 ++-----------
 2 files changed, 94 insertions(+), 28 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 86bb334..d1d12f2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,9 +22,27 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
+	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	NULL
 };
 
+struct bisect_terms {
+	struct strbuf term_good;
+	struct strbuf term_bad;
+};
+
+static void bisect_terms_init(struct bisect_terms *terms)
+{
+	strbuf_init(&terms->term_good, 0);
+	strbuf_init(&terms->term_bad, 0);
+}
+
+static void bisect_terms_release(struct bisect_terms *terms)
+{
+	strbuf_release(&terms->term_good);
+	strbuf_release(&terms->term_bad);
+}
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -188,6 +206,52 @@ static int check_expected_revs(const char **revs, int rev_nr)
 	return 0;
 }
 
+static int bisect_write(const char *state, const char *rev,
+			const struct bisect_terms *terms, int nolog)
+{
+	struct strbuf tag = STRBUF_INIT;
+	struct strbuf commit_name = STRBUF_INIT;
+	struct object_id oid;
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+	FILE *fp;
+
+	if (!strcmp(state, terms->term_bad.buf))
+		strbuf_addf(&tag, "refs/bisect/%s", state);
+	else if (one_of(state, terms->term_good.buf, "skip", NULL))
+		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
+	else
+		return error(_("Bad bisect_write argument: %s"), state);
+
+	if (get_oid(rev, &oid)) {
+		strbuf_release(&tag);
+		return error(_("couldn't get the oid of the rev '%s'"), rev);
+	}
+
+	if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
+		       UPDATE_REFS_MSG_ON_ERR)) {
+		strbuf_release(&tag);
+		return -1;
+	}
+	strbuf_release(&tag);
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp)
+		return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
+
+	commit = lookup_commit_reference(oid.hash);
+	format_commit_message(commit, "%s", &commit_name, &pp);
+	fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
+		commit_name.buf);
+	strbuf_release(&commit_name);
+
+	if (!nolog)
+		fprintf(fp, "git bisect %s %s\n", state, rev);
+
+	fclose(fp);
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -195,9 +259,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
 		BISECT_RESET,
-		CHECK_EXPECTED_REVS
+		CHECK_EXPECTED_REVS,
+		BISECT_WRITE
 	} cmdmode = 0;
-	int no_checkout = 0;
+	int no_checkout = 0, res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -209,10 +274,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
+		OPT_CMDMODE(0, "bisect-write", &cmdmode,
+			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
 	};
+	struct bisect_terms terms;
+	bisect_terms_init(&terms);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
@@ -221,24 +290,38 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
+	int nolog;
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
 	case WRITE_TERMS:
 		if (argc != 2)
 			die(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
+		res = write_terms(argv[0], argv[1]);
+		break;
 	case BISECT_CLEAN_STATE:
 		if (argc != 0)
 			die(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
+		res = bisect_clean_state();
+		break;
 	case BISECT_RESET:
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));
-		return bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
+		break;
 	case CHECK_EXPECTED_REVS:
-		return check_expected_revs(argv, argc);
+		res = check_expected_revs(argv, argc);
+		break;
+	case BISECT_WRITE:
+		if (argc != 4 && argc != 5)
+			die(_("--bisect-write requires either 4 or 5 arguments"));
+		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
+		strbuf_addstr(&terms.term_good, argv[2]);
+		strbuf_addstr(&terms.term_bad, argv[3]);
+		res = bisect_write(argv[0], argv[1], &terms, nolog);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
-	return 0;
+	bisect_terms_release(&terms);
+	return res;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index 4f6545e..b9896a4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -145,7 +145,7 @@ bisect_start() {
 		0) state=$TERM_BAD ; bad_seen=1 ;;
 		*) state=$TERM_GOOD ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+		eval="$eval git bisect--helper --bisect-write '$state' '$rev' '$TERM_GOOD' '$TERM_BAD' 'nolog' &&"
 	done
 	#
 	# Verify HEAD.
@@ -221,23 +221,6 @@ bisect_start() {
 	trap '-' 0
 }
 
-bisect_write() {
-	state="$1"
-	rev="$2"
-	nolog="$3"
-	case "$state" in
-		"$TERM_BAD")
-			tag="$state" ;;
-		"$TERM_GOOD"|skip)
-			tag="$state"-"$rev" ;;
-		*)
-			die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
-	esac
-	git update-ref "refs/bisect/$tag" "$rev" || exit
-	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
-	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -263,7 +246,7 @@ bisect_state() {
 	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
-		bisect_write "$state" "$rev"
+		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		git bisect--helper --check-expected-revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
@@ -276,7 +259,7 @@ bisect_state() {
 		done
 		for rev in $hash_list
 		do
-			bisect_write "$state" "$rev"
+			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		done
 		git bisect--helper --check-expected-revs $hash_list ;;
 	*,"$TERM_BAD")
@@ -413,7 +396,7 @@ bisect_replay () {
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			bisect_write "$command" "$rev" ;;
+			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
 			bisect_terms $rev ;;
 		*)

--
https://github.com/git/git/pull/273
