Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA03C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875D522C9E
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393981AbhARVHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390055AbhARVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:03:26 -0500
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D1C0613CF
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:02:38 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10IL07CD024935;
        Tue, 19 Jan 2021 00:00:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611003608; bh=ut5EwP8uiXY8NhOqOqdHMzqbbI6t4sbULTC9T3o2/FU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KeeeJNFhIKWmRRSV3qLeoN6j2WEkJWo3Aev6V2mwuDZ8hvHINit4LWwGtoYfzU7ZU
         R1LMB04sKDLIoZcIUszCThdyvNCyZP5b3nbhIySIEz4tLdP49C9IsjiSk/fFdm/H9L
         rAlfqGFYtJleXi3jAXP+dOauMV0aCKB+dew2LISs=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10IL07HO024934;
        Tue, 19 Jan 2021 00:00:07 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [RFC PATCH v2 1/3] mergetools: support difftool.tabbed setting
Date:   Tue, 19 Jan 2021 00:00:01 +0300
Message-Id: <20210118210003.3071205-2-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210118210003.3071205-1-nicholas@guriev.su>
References: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
 <20210118210003.3071205-1-nicholas@guriev.su>
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
---
 builtin/difftool.c    |  7 ++++++-
 diff.c                | 10 +++++++++-
 git-mergetool--lib.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
 mergetools/meld       |  4 ++++
 mergetools/vimdiff    | 17 +++++++++++++++++
 5 files changed, 77 insertions(+), 3 deletions(-)

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
index 78f3647ed9..2a1edbb9b9 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -195,6 +195,11 @@ setup_tool () {
 		false
 	}
 
+	# Clear combo function declared by a previous tool (if any) to
+	# unambiguously indicate that the current one supports the feature or
+	# not.
+	unset -f diff_combo_cmd
+
 	if test -f "$MERGE_TOOLS_DIR/$tool"
 	then
 		. "$MERGE_TOOLS_DIR/$tool"
@@ -250,6 +255,28 @@ trust_exit_code () {
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
+	type diff_combo_cmd >/dev/null 2>&1
+}
+
 
 # Entry point for running tools
 run_merge_tool () {
@@ -274,7 +301,20 @@ run_merge_tool () {
 
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
index aab4ebb935..2f40262a70 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+diff_combo_cmd () {
+	"$merge_tool_path" $(printf -- '--diff\n%s\n%s\n' `cat <&3`) 3<&-
+}
+
 merge_cmd () {
 	check_meld_for_features
 
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index abc8ce4ec4..006e7b825d 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -3,6 +3,23 @@ diff_cmd () {
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
 merge_cmd () {
 	case "$1" in
 	*vimdiff)
-- 
2.27.0

