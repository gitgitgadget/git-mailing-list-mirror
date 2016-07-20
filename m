Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5B12034E
	for <e@80x24.org>; Wed, 20 Jul 2016 22:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbcGTWhn (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 18:37:43 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:50381
	"EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753441AbcGTWhm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 18:37:42 -0400
X-Greylist: delayed 1797 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jul 2016 18:37:41 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469051273;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=n94T9qVwhazJjOB3ttZWHshJwSAXyU4bBtCrTh1JMsQ=;
	b=K5I2ym1eFapNYP+pU2bwHs0/XvQUOkomC+mGJKYSTOtSb26JQGzKkS2QJnJ215qp
	kKvme/OP6IQvmmqW961dPV60xKDkkDBO83G8u1bwYVk2l2wDSfIsEh92kB1Fu44foIM
	yxDTkJAcPAaFWjRaFWzNSTmfyl2ATgan9Q+MOKEQ=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201560a478295-723db87e-2c2c-49c1-bf5e-c9d7997b873a-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v10 07/12] bisect--helper: `bisect_reset` shell function in
 C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Wed, 20 Jul 2016 21:47:53 +0000
X-SES-Outgoing:	2016.07.20-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
subcommand to `git bisect--helper` to call it from git-bisect.sh .

Using `bisect_reset` subcommand is a temporary measure to port shell
functions to C so as to use the existing test suite. As more functions
are ported, this subcommand would be retired and will be called by some
other method.

Note: --bisect-clean-state subcommand has not been retired as there are
still a function namely `bisect_start()` which still uses this
subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 28 ++--------------------------
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ad67a97..d125fd3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,6 +4,8 @@
 #include "bisect.h"
 #include "refs.h"
 #include "dir.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -13,11 +15,13 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
+	N_("git bisect--helper --bisect-reset [<commit>]"),
 	NULL
 };
 
@@ -124,12 +128,47 @@ static int bisect_clean_state(void)
 	return result;
 }
 
+static int bisect_reset(const char *commit)
+{
+	struct strbuf branch = STRBUF_INIT;
+
+	if (!commit) {
+		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
+			printf("We are not bisecting.\n");
+			return 0;
+		}
+		strbuf_rtrim(&branch);
+	} else {
+		struct object_id oid;
+		if (get_oid(commit, &oid))
+			return error(_("'%s' is not a valid commit"), commit);
+		strbuf_addstr(&branch, commit);
+	}
+
+	if (!file_exists(git_path_bisect_head())) {
+		struct argv_array argv = ARGV_ARRAY_INIT;
+		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
+		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			error(_("Could not check out original HEAD '%s'. Try"
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
-		BISECT_CLEAN_STATE
+		BISECT_CLEAN_STATE,
+		BISECT_RESET
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -139,6 +178,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -161,6 +202,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 0)
 			die(_("--bisect-clean-state requires no arguments"));
 		return bisect_clean_state();
+	case BISECT_RESET:
+		if (argc > 1)
+			die(_("--bisect-reset requires either zero or one arguments"));
+		return bisect_reset(argc ? argv[0] : NULL);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index bbc57d2..18580b7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -409,35 +409,11 @@ bisect_visualize() {
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
@@ -627,7 +603,7 @@ case "$#" in
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)
-		bisect_reset "$@" ;;
+		git bisect--helper --bisect-reset "$@" ;;
 	replay)
 		bisect_replay "$@" ;;
 	log)

--
https://github.com/git/git/pull/273
