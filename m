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
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EAE1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdJ0PGx (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:06:53 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:44650
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751511AbdJ0PGj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509116798;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=aS1t4leRPcInfjLSOrapZHCv7fdh7MfH3zrmbrckAh4=;
        b=alEGJJNuEtFFNPZKwMvaw5Pjp10nzEW/thOqYQRQhGUB8XAD517XWyetVpkTP8tJ
        AbHYEwFq8jiSRJeFQM0xjIiiaLtMTyjkwjpuy6f0g2uLz5A+7cJ2B8xe2Ox/6+AKnos
        upgzvQZRd1PZsf/v4e5PcdFII/leIKIm3FWthOGU=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 Part II 1/8] bisect--helper: `bisect_reset` shell
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

Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
subcommand to `git bisect--helper` to call it from git-bisect.sh .

Using `bisect_reset` subcommand is a temporary measure to port shell
functions to C so as to use the existing test suite. As more functions
are ported, this subcommand would be retired but its implementation will
be called by some other method.

Note: --bisect-clean-state subcommand has not been retired as there are
still a function namely `bisect_start()` which still uses this
subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
Hey,

This is the part 2 of the initial series[1] on bisect re-write. When I
submitted my patches of the part 1 of the bisect series, Ramsay informed
that he has been working on my previous patches and pointed me to his
patches. I have incorporated his changes into this series. Stephan did a
awesome job in reviewing my series and I have incorporated those changes
as well.

Ramsay's requested changes which have been incorporated:
 * bisect--helper: convert to struct object_id: I have took out the bits
   which were in this series and hand-picked them in this series.
 * bisect--helper: add a log_commit() helper function: This function
   might not seem to be very relevant in this part of the series, but it
   is going to be in future parts of the series as described in
   `188ea5855d93df` of Ramsay's git.git repo[2].
 * bisect--helper: reduce scope of a variable in `bisect_start`
 * bisect--helper: remove useless sub-expression in condition: I had
   already done this change as suggested by Stephan.
 * bisect--helper: set correct term from --term-new= option: I had
   already done this change as suggested by Stephan.
 * bisect--helper: remove redundant assignment to has_double_dash
 * bisect--helper: remove redundant goto's
 * bisect--helper: add some vertical whitespace
 * bisect--helper: fixup some coding style issues

Ramsay's changes which I had already done ([]-ed comments):
 * `bisect_write`: add a GIT_PATH_FUNC() removed earlier
 * `bisect_write`: lookup_commit_reference() now takes an object_id
 * `bisect_next_check`: addressed comments in Stephan's review and
   Junio's squash
 * `bisect_terms`: fixed up usage string and tested for --term-[good|old] and
   --term-[bad|new] in bisect-terms subcommand argument processing:
   instead of fixing up usage string, I just removed it as Stephan
   suggested.

Stephan's requested changes which have been incorporated:
 * Use goto's using `goto fail` and `goto finish`
 * Marking strings for translation
 * Stored res value and then returned it at the end
 * Implement set_terms() and free_terms() for proper memory handling for
   struct bisect_terms and fixed all leakages
 * Remove bisect_voc() function
 * Remove the bisect_term_usage string in bisect_terms()
 * Use return error() every where instead of die()
 * Improving readability of a message in bisect_terms()
 * bisect_start(): fix some typos, remove has_double_dash, join the two
   if branches, fix the bug when it should be terms->term_bad,
   decomposed it into smaller functions by introducing
   bisect_append_log()

A big thanks to Stephan and Ramsay for patiently reviewing my series and
helping me get this merged.

[1]:
https://public-inbox.org/git/0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com/

[2]: git://repo.or.cz/git/raj.git
Regards,
Pranit Bauva
---
 builtin/bisect--helper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 28 ++-------------------------
 2 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 35d2105f941c6..12754448f7b6a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,15 +3,21 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
+#include "dir.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
+static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
+	N_("git bisect--helper --bisect-reset [<commit>]"),
 	NULL
 };
 
@@ -106,13 +112,48 @@ static void check_expected_revs(const char **revs, int rev_nr)
 	}
 }
 
+static int bisect_reset(const char *commit)
+{
+	struct strbuf branch = STRBUF_INIT;
+
+	if (!commit) {
+		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
+			return !printf(_("We are not bisecting.\n"));
+		strbuf_rtrim(&branch);
+	} else {
+		struct object_id oid;
+
+		if (get_oid_commit(commit, &oid))
+			return error(_("'%s' is not a valid commit"), commit);
+		strbuf_addstr(&branch, commit);
+	}
+
+	if (!file_exists(git_path_bisect_head())) {
+		struct argv_array argv = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
+		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			error(_("Could not check out original HEAD '%s'. Try "
+				"'git bisect reset <commit>'."), branch.buf);
+			strbuf_release(&branch);
+			argv_array_clear(&argv);
+			return -1;
+		}
+		argv_array_clear(&argv);
+	}
+
+	strbuf_release(&branch);
+	return bisect_clean_state();
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
-		CHECK_EXPECTED_REVS
+		CHECK_EXPECTED_REVS,
+		BISECT_RESET
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -124,6 +165,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -149,6 +192,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
+	case BISECT_RESET:
+		if (argc > 1)
+			return error(_("--bisect-reset requires either no argument or a commit"));
+		return bisect_reset(argc ? argv[0] : NULL);
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 0138a8860e377..4d403242482cf 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -393,35 +393,11 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_reset() {
-	test -s "$GIT_DIR/BISECT_START" || {
-		gettextln "We are not bisecting."
-		return
-	}
-	case "$#" in
-	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" >/dev/null || {
-			invalid="$1"
-			die "$(eval_gettext "'\$invalid' is not a valid commit")"
-		}
-		branch="$1" ;;
-	*)
-		usage ;;
-	esac
-
-	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
-	then
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
-Try 'git bisect reset <commit>'.")"
-	fi
-	git bisect--helper --bisect-clean-state || exit
-}
-
 bisect_replay () {
 	file="$1"
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	bisect_reset
+	git bisect--helper --bisect-reset || exit
 	while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
@@ -611,7 +587,7 @@ case "$#" in
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)
-		bisect_reset "$@" ;;
+		git bisect--helper --bisect-reset "$@" ;;
 	replay)
 		bisect_replay "$@" ;;
 	log)

--
https://github.com/git/git/pull/420
