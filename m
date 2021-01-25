Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D7C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5180D20853
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbhAYVYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbhAYVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:22:26 -0500
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7AC0613D6
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:21:40 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10PLLaXu032148;
        Tue, 26 Jan 2021 00:21:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611609696; bh=tg039QY3k+lLd/GBmLRkO320kzmEEY6CK3iPg/vr61E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gotWG4BrMzc9LpgsQsKahXJBXB93/r1fBqvdZyBVfyi1rFCuOmgGCYTDbL+5aYSFG
         6HiaDOlEpm0xpLpNtyt+sYq7IeB/CSy30xjAA7zNYc/tf8jpMjH3c/sYw5bJygwuPE
         DcsH+jE4i+iaWiyXANcys3KlE+LKfjaCGmY7n19w=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10PLLaMX032147;
        Tue, 26 Jan 2021 00:21:36 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [PATCH v3 1/4] mergetools: support difftool.tabbed setting
Date:   Tue, 26 Jan 2021 00:21:29 +0300
Message-Id: <20210125212132.894458-2-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125212132.894458-1-nicholas@guriev.su>
References: <20210118210003.3071205-1-nicholas@guriev.su>
 <20210125212132.894458-1-nicholas@guriev.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch introduces a new boolean setting, difftool.tabbed, which
allows a user to view diffs in single window at one go. The `--tabbed`
command line option and the GIT_DIFFTOOL_TABBED environment variable are
also available. For now, it works only with vimdiff and related, meld.

We call to a new invented function, diff_combo_cmd, if it is provided by
the diff tool, and pass to it a list of pairs of compared files. The
list is available through third file descriptor, filenames are separated
by a line feed, '\n', so they can be split by means of unmodified $IFS.
The function may close that descriptor after reading the list.

Signed-off-by: Nicholas Guriev <nicholas@guriev.su>
---
 builtin/difftool.c    |  7 +++++-
 diff.c                | 10 ++++++++-
 git-mergetool--lib.sh | 51 ++++++++++++++++++++++++++++++++++++++-----
 mergetools/meld       |  8 +++++++
 mergetools/vimdiff    | 21 ++++++++++++++++++
 5 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6e18e623fd..f061d3c029 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -689,7 +689,7 @@ static int run_file_diff(int prompt, const char *prefix,
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0, no_index = 0;
+	    tabbed = -1, tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
@@ -708,6 +708,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "tool-help", &tool_help,
 			 N_("print a list of diff tools that may be used with "
 			    "`--tool`")),
+		OPT_BOOL_F(0, "tabbed", &tabbed,
+			   N_("use tabs in diff tool if supported"), 0),
 		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
 			 N_("make 'git-difftool' exit when an invoked diff "
 			    "tool returns a non - zero exit code")),
@@ -756,6 +758,9 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			die(_("no <cmd> given for --extcmd=<cmd>"));
 	}
 
+	if (tabbed >= 0)
+		setenv("GIT_DIFFTOOL_TABBED", tabbed ? "true" : "false", 1);
+
 	setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
 	       trust_exit_code ? "true" : "false", 1);
 
diff --git a/diff.c b/diff.c
index 2253ec8802..2868848bba 100644
--- a/diff.c
+++ b/diff.c
@@ -1730,6 +1730,14 @@ static struct diff_tempfile *claim_diff_tempfile(void)
 	BUG("diff is failing to clean up its tempfiles");
 }
 
+static void forget_tempfile(void)
+{
+	for (int i = 0; i < ARRAY_SIZE(diff_temp); i++) {
+		close_tempfile_gently(diff_temp[i].tempfile);
+		diff_temp[i] = (struct diff_tempfile){0};
+	}
+}
+
 static void remove_tempfile(void)
 {
 	int i;
@@ -4275,7 +4283,7 @@ static void run_external_diff(const char *pgm,
 	if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v))
 		die(_("external diff died, stopping at %s"), name);
 
-	remove_tempfile();
+	forget_tempfile();
 	strvec_clear(&argv);
 	strvec_clear(&env);
 }
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 78f3647ed9..fef9289618 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -151,19 +151,25 @@ setup_tool () {
 
 	# Fallback definitions, to be overridden by tools.
 	can_merge () {
-		return 0
+		true
 	}
 
 	can_diff () {
-		return 0
+		true
 	}
 
 	diff_cmd () {
-		return 1
+		false
+	}
+
+	# The concrete diff tool may define that it supports combined
+	# invocations and the diff_combo_cmd function may be called.
+	diff_combo_supported () {
+		false
 	}
 
 	merge_cmd () {
-		return 1
+		false
 	}
 
 	translate_merge_tool_path () {
@@ -250,6 +256,28 @@ trust_exit_code () {
 	fi
 }
 
+# Check whether tabbed mode is requested and current loaded tool supports it.
+is_difftool_tabbed () {
+	: "${GIT_DIFFTOOL_TABBED=$(git config --type=bool \
+		--default=false difftool.tabbed || echo bad value)}"
+	case $(printf "%s" "$GIT_DIFFTOOL_TABBED" | tr '[:upper:]' '[:lower:]') in
+	yes|on|true|1)
+		GIT_DIFFTOOL_TABBED=true
+		;;
+	no|off|false|0|'')
+		GIT_DIFFTOOL_TABBED=false
+		;;
+	*)
+		echo "error: bad boolean value of GIT_DIFFTOOL_TABBED" >&2
+		exit 1
+		;;
+	esac
+
+	test "$GIT_DIFFTOOL_TABBED" = true &&
+	test "${GIT_DIFF_PATH_TOTAL=0}" -gt 1 &&
+	diff_combo_supported
+}
+
 
 # Entry point for running tools
 run_merge_tool () {
@@ -274,7 +302,20 @@ run_merge_tool () {
 
 # Run a either a configured or built-in diff tool
 run_diff_cmd () {
-	diff_cmd "$1"
+	if is_difftool_tabbed
+	then
+		temp_file="${TMPDIR:-/tmp}/git-${PPID}_tabbed-queue"
+		test "$GIT_DIFF_PATH_COUNTER" -eq 1 && >"$temp_file"
+		printf '%s\n' "$LOCAL" "$REMOTE" >>"$temp_file"
+
+		if test "$GIT_DIFF_PATH_COUNTER" -eq "$GIT_DIFF_PATH_TOTAL"
+		then
+			diff_combo_cmd 3<"$temp_file"
+			rm -f -- "$temp_file"
+		fi
+	else
+		diff_cmd "$1"
+	fi
 }
 
 # Run a either a configured or built-in merge tool
diff --git a/mergetools/meld b/mergetools/meld
index aab4ebb935..e2b9d456c1 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -2,6 +2,14 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+diff_combo_cmd () {
+	"$merge_tool_path" $(printf -- '--diff\n%s\n%s\n' `cat <&3`) 3<&-
+}
+
+diff_combo_supported () {
+	true
+}
+
 merge_cmd () {
 	check_meld_for_features
 
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index abc8ce4ec4..fe1923076b 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -3,6 +3,27 @@ diff_cmd () {
 		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
 }
 
+multitabbed_script='
+	let i = 1
+	while i < argc()
+		execute "tabedit" fnameescape(argv(i - 1))
+		execute "diffsplit" fnameescape(argv(i))
+		wincmd L
+		let i = i + 2
+	endwhile
+	tabfirst
+	tabclose
+	unlet i
+	chdir $GIT_PREFIX
+'
+diff_combo_cmd () {
+	"$merge_tool_path" -R -f -c "$multitabbed_script" -- `cat <&3` 3<&-
+}
+
+diff_combo_supported () {
+	true
+}
+
 merge_cmd () {
 	case "$1" in
 	*vimdiff)
-- 
2.27.0

