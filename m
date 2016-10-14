Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B501F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbcJNOY3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:24:29 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:39420
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752876AbcJNOY2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:24:28 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Oct 2016 10:24:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=1A8RKVH50Z2Pt5eVWC3qWrgxSi8Ixl1AbiyucZUYmDc=;
        b=EyEipggCG8xNiM8WnIf+sjCO74tkaKErjLtDfusU/h9rUUDcSQgny39q7YRLjQmA
        Fxevxwc3t+tMFbO0a97Hg69y8n4cD4YYwiMtV7tRM1XTvmYh/IOtQMZTXYy63IPaqC3
        6cfvjt6Uf25GDzuYlTrcIDAn/LW0+nod7s06gVQ8=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1aa0-0c1fed14-e058-4621-9958-973113d7e45f-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 07/27] bisect--helper: `bisect_reset` shell function in
 C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.19
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
 builtin/bisect--helper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 28 ++--------------------------
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4254d61..d84ba86 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,17 +3,22 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
+#include "dir.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
+	N_("git bisect--helper --bisect-reset [<commit>]"),
 	NULL
 };
 
@@ -84,12 +89,47 @@ static int write_terms(const char *bad, const char *good)
 	return (res < 0) ? -1 : 0;
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
+		unsigned char sha1[20];
+		if (get_sha1_committish(commit, sha1))
+			return error(_("'%s' is not a valid commit"), commit);
+		strbuf_addstr(&branch, commit);
+	}
+
+	if (!file_exists(git_path_bisect_head())) {
+		struct argv_array argv = ARGV_ARRAY_INIT;
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
-		BISECT_CLEAN_STATE
+		BISECT_CLEAN_STATE,
+		BISECT_RESET
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -99,6 +139,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -121,6 +163,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index f1202df..442397b 100755
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
https://github.com/git/git/pull/287
