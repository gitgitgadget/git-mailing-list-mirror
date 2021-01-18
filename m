Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFBC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E04D207C4
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394480AbhARVE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389954AbhARVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:03:26 -0500
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A70C0613C1
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:02:38 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10IL09Zb024950;
        Tue, 19 Jan 2021 00:00:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611003610; bh=/beYap/o+qTVLycEtD8N3sNqtaHPR1IZ9IOhLO749rM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=omWUaXDRnFI9GutRs/KApW1Brsb/A0LoMMPgRoU7WT+BbzqIAiG3tdiIuI03DdzFg
         UmOgfJRlvSchFhJue4bTCO5NLBj1/24S946ZyBe4Ye4IqMUPMVKLYXJ74hnv7TsK8c
         U7Ba/HEt+uv9CK746+JvYWNF4EqLuLMGv1dpcCiM=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10IL09bq024949;
        Tue, 19 Jan 2021 00:00:09 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [RFC PATCH v2 2/3] difftool-helper: conciliate difftool.tabbed and difftool.prompt settings
Date:   Tue, 19 Jan 2021 00:00:02 +0300
Message-Id: <20210118210003.3071205-3-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210118210003.3071205-1-nicholas@guriev.su>
References: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
 <20210118210003.3071205-1-nicholas@guriev.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit combines paths of compared files into a separate temporary
file and prints them before launch the tool on last invocation of the
helper. All temporary files will be removed before exiting after that.
At least, we try. But it may happen the files remain in case of a bug
or a random SIGKILL.
---
 git-difftool--helper.sh | 39 ++++++++++++++++++++++++++-------------
 git-mergetool--lib.sh   | 34 +++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 46af3e60b7..529d55c96d 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -11,8 +11,8 @@ TOOL_MODE=diff
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
-	prompt_merge=$(git config --bool mergetool.prompt || echo true)
-	prompt=$(git config --bool difftool.prompt || echo $prompt_merge)
+	prompt=$(git config --bool mergetool.prompt || echo true)
+	prompt=$(git config --bool difftool.prompt || echo $prompt)
 	if test "$prompt" = true
 	then
 		test -z "$GIT_DIFFTOOL_NO_PROMPT"
@@ -26,6 +26,18 @@ use_ext_cmd () {
 	test -n "$GIT_DIFFTOOL_EXTCMD"
 }
 
+prompt_before_launch () {
+	while true
+	do
+		printf "Launch '%s' [Y/n]? " "${GIT_DIFFTOOL_EXTCMD:-$merge_tool}"
+		read ans 2>/dev/null || return 1
+		case "${ans-y}" in
+		[yY]*) return 0 ;;
+		[nN]*) return 1 ;;
+		esac
+	done
+}
+
 launch_merge_tool () {
 	# Merged is the filename as it appears in the work tree
 	# Local is the contents of a/filename
@@ -40,19 +52,20 @@ launch_merge_tool () {
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt
 	then
-		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
-			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
-		if use_ext_cmd
+		append_templist merged-paths "$MERGED"
+		# Do preinit before test whether the tool supports tabbed run.
+		use_ext_cmd || setup_tool "$merge_tool"
+
+		if ! is_difftool_tabbed
 		then
-			printf "Launch '%s' [Y/n]? " \
-				"$GIT_DIFFTOOL_EXTCMD"
-		else
-			printf "Launch '%s' [Y/n]? " "$merge_tool"
-		fi
-		read ans || return
-		if test "$ans" = n
+			printf "\nViewing (%d/%d): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
+				"$GIT_DIFF_PATH_TOTAL" "$MERGED"
+			prompt_before_launch || return
+		elif on_last_file
 		then
-			return
+			printf "Viewing %d files:\n" "$GIT_DIFF_PATH_TOTAL"
+			printf "  '%s'\n" `cat "$LAST_TEMPFILE"`
+			prompt_before_launch || return
 		fi
 	fi
 
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 2a1edbb9b9..4bb0e31dac 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -22,6 +22,10 @@ is_available () {
 	type "$merge_tool_path" >/dev/null 2>&1
 }
 
+on_last_file () {
+	test "$GIT_DIFF_PATH_COUNTER" -eq "$GIT_DIFF_PATH_TOTAL" 2>/dev/null
+}
+
 list_config_tools () {
 	section=$1
 	line_prefix=${2:-}
@@ -277,6 +281,26 @@ is_difftool_tabbed () {
 	type diff_combo_cmd >/dev/null 2>&1
 }
 
+# Save lines to the chosen temporary file for usage from subsequent invocations.
+# Path to the file will be placed to the LAST_TEMPFILE variable for later links.
+append_templist () {
+	LAST_TEMPFILE="${TMPDIR:-/tmp}/git-${PPID}_$1"
+	shift
+
+	if test "$GIT_DIFF_PATH_COUNTER" -eq 1
+	then
+		printf '%s\n' "$@" >"$LAST_TEMPFILE"
+	else
+		printf '%s\n' "$@" >>"$LAST_TEMPFILE"
+	fi
+}
+
+# Clean any temporary files that may create this script.
+clean_templists () {
+	rm -f -- "${TMPDIR:-/tmp}/git-${PPID}"_*
+}
+trap 'on_last_file && clean_templists' EXIT INT TERM
+
 
 # Entry point for running tools
 run_merge_tool () {
@@ -303,14 +327,10 @@ run_merge_tool () {
 run_diff_cmd () {
 	if is_difftool_tabbed
 	then
-		temp_file="${TMPDIR:-/tmp}/git-${PPID}_tabbed-queue"
-		test "$GIT_DIFF_PATH_COUNTER" -eq 1 && >"$temp_file"
-		printf '%s\n' "$LOCAL" "$REMOTE" >>"$temp_file"
-
-		if test "$GIT_DIFF_PATH_COUNTER" -eq "$GIT_DIFF_PATH_TOTAL"
+		append_templist tabbed-queue "$LOCAL" "$REMOTE"
+		if on_last_file
 		then
-			diff_combo_cmd 3<"$temp_file"
-			rm -f -- "$temp_file"
+			diff_combo_cmd 3<"$LAST_TEMPFILE"
 		fi
 	else
 		diff_cmd "$1"
-- 
2.27.0

