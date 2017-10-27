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
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B9D1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbdJ0PGk (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:06:40 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:52682
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751001AbdJ0PGj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509116797;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=/5A2oCj1bOfBd/9U/4EhcyWJKzCt8SqMECRjNacXDYw=;
        b=jp2ZnXtuql10QieEg58f8DdOMrEsujE9savdoAPdaZNf486Szi0QBtLEnG1czN/D
        RcITIgathXzpza1L87Rtu0SbTxidncacx5uNX1yXjd59FMVGx6pOpU/SJPwzREe0SSc
        IUTkQBccdLszV7rf639ysvefXxnOOCAakAo6YxwA=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Oct 2017 15:06:37 +0000
X-SES-Outgoing: 2017.10.27-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the `bisect_write` shell function in C and add a
`bisect-write` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-write` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
from the global shell script thus we need to pass it to the subcommand
using the arguments. We then store them in a struct bisect_terms and
pass the memory address around functions.

Add a log_commit() helper function to write the contents of the commit message
header to a file which will be re-used in future parts of the code as
well.

Also introduce a function free_terms() to free the memory of `struct
bisect_terms` and set_terms() to set the values of members in `struct
bisect_terms`.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 107 +++++++++++++++++++++++++++++++++++++++++++++--
 git-bisect.sh            |  25 ++---------
 2 files changed, 108 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 12754448f7b6a..6295f53c850a8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -12,15 +12,37 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
+static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
+	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
 	NULL
 };
 
+struct bisect_terms {
+	const char *term_good;
+	const char *term_bad;
+};
+
+static void free_terms(struct bisect_terms *terms)
+{
+	if (!terms->term_good)
+		free((void *) terms->term_good);
+	if (!terms->term_bad)
+		free((void *) terms->term_bad);
+}
+
+static void set_terms(struct bisect_terms *terms, const char *bad,
+		      const char *good)
+{
+	terms->term_good = xstrdup(good);
+	terms->term_bad = xstrdup(bad);
+}
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -146,6 +168,72 @@ static int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
 
+static void log_commit(FILE *fp, char *fmt, const char *state,
+		       struct commit *commit)
+{
+	struct pretty_print_context pp = {0};
+	struct strbuf commit_msg = STRBUF_INIT;
+	char *label = xstrfmt(fmt, state);
+
+	format_commit_message(commit, "%s", &commit_msg, &pp);
+
+	fprintf(fp, "# %s: [%s] %s\n", label, oid_to_hex(&commit->object.oid),
+		commit_msg.buf);
+
+	strbuf_release(&commit_msg);
+	free(label);
+}
+
+static int bisect_write(const char *state, const char *rev,
+			const struct bisect_terms *terms, int nolog)
+{
+	struct strbuf tag = STRBUF_INIT;
+	struct object_id oid;
+	struct commit *commit;
+	FILE *fp = NULL;
+	int retval = 0;
+
+	if (!strcmp(state, terms->term_bad)) {
+		strbuf_addf(&tag, "refs/bisect/%s", state);
+	} else if (one_of(state, terms->term_good, "skip", NULL)) {
+		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
+	} else {
+		error(_("Bad bisect_write argument: %s"), state);
+		goto fail;
+	}
+
+	if (get_oid(rev, &oid)) {
+		error(_("couldn't get the oid of the rev '%s'"), rev);
+		goto fail;
+	}
+
+	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
+		       UPDATE_REFS_MSG_ON_ERR))
+		goto fail;
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp) {
+		error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
+		goto fail;
+	}
+
+	commit = lookup_commit_reference(&oid);
+	log_commit(fp, "%s", state, commit);
+
+	if (!nolog)
+		fprintf(fp, "git bisect %s %s\n", state, rev);
+
+	goto finish;
+
+fail:
+	retval = -1;
+finish:
+	if (fp)
+		fclose(fp);
+	strbuf_release(&tag);
+	return retval;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -153,9 +241,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
-		BISECT_RESET
+		BISECT_RESET,
+		BISECT_WRITE
 	} cmdmode = 0;
-	int no_checkout = 0;
+	int no_checkout = 0, res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -167,10 +256,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
+		OPT_CMDMODE(0, "bisect-write", &cmdmode,
+			 N_("update the refs according to the bisection state and may write it to BISECT_LOG"), BISECT_WRITE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
 	};
+	struct bisect_terms terms;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
@@ -179,6 +271,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
+	int nolog;
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
 	case WRITE_TERMS:
@@ -196,8 +289,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		return bisect_reset(argc ? argv[0] : NULL);
+	case BISECT_WRITE:
+		if (argc != 4 && argc != 5)
+			return error(_("--bisect-write requires either 4 or 5 arguments"));
+		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
+		set_terms(&terms, argv[3], argv[2]);
+		res = bisect_write(argv[0], argv[1], &terms, nolog);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
-	return 0;
+	free_terms(&terms);
+	return res;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index 4d403242482cf..1eab94ec943a1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -144,7 +144,7 @@ bisect_start() {
 		0) state=$TERM_BAD ; bad_seen=1 ;;
 		*) state=$TERM_GOOD ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+		eval="$eval git bisect--helper --bisect-write '$state' '$rev' '$TERM_GOOD' '$TERM_BAD' 'nolog' &&"
 	done
 	#
 	# Verify HEAD.
@@ -220,23 +220,6 @@ bisect_start() {
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
 		bisected_head=$(bisect_head)
 		rev=$(git rev-parse --verify "$bisected_head") ||
 			die "$(eval_gettext "Bad rev input: \$bisected_head")"
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
https://github.com/git/git/pull/420
