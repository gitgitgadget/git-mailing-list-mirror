Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4CCC43381
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BB9207B6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbhAYVXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732608AbhAYVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:22:26 -0500
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61416C061786
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:21:44 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10PLLe3r032178;
        Tue, 26 Jan 2021 00:21:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611609700; bh=tYaD5ZxgYQdAX/fKKGh66LiJMK3Voyw3LHEgF8Xbhjw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iwlqJaq3+sUWsHNmX69PqnSarZThtaPnbVTIJtesZnonqx7NDNRXY99LixHpoWsFS
         F5QJAy+yf2d0+nGT3bI8RYxAvwcgPt1KDhcsCXNpJ/6ZGjggWAWNDmPV9tk8HLZSyg
         pL+WgRODA6v8/nepbOylT1yZSPo7elZVGe8TE7kQ=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10PLLebi032177;
        Tue, 26 Jan 2021 00:21:40 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [PATCH v3 3/4] doc: describe new difftool.tabbed feature
Date:   Tue, 26 Jan 2021 00:21:31 +0300
Message-Id: <20210125212132.894458-4-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125212132.894458-1-nicholas@guriev.su>
References: <20210118210003.3071205-1-nicholas@guriev.su>
 <20210125212132.894458-1-nicholas@guriev.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And related the `--tabbed` command line option, and the
GIT_DIFFTOOL_TABBED environment variable.

Signed-off-by: Nicholas Guriev <nicholas@guriev.su>
---
 Documentation/config/difftool.txt    |  6 +++
 Documentation/git-difftool.txt       | 19 +++++++--
 Documentation/git-mergetool--lib.txt | 62 ++++++++++++++++++++++++++++
 Documentation/git.txt                |  8 ++++
 4 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index 6762594480..ac609aee66 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -12,3 +12,9 @@ difftool.<tool>.cmd::
 
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
+
+difftool.tabbed::
+	Show compared files in different tabs using single invocation of
+	the diff tool. Must be a boolean value. Only the following tools
+	are currently supported: vimdiff and related, meld. Tools with
+	overridden command line will ignore this configuration variable.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 484c485fd0..1b7a5345ad 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -69,6 +69,13 @@ with custom merge tool commands and has the same value as `$MERGED`.
 --tool-help::
 	Print a list of diff tools that may be used with `--tool`.
 
+--[no-]tabbed::
+	Open compared files in different tabs using single invocation
+	of the diff tool. This overrides configuration or environment.
+	Currently, only the following tools are supported: vimdiff and
+	related, meld. Tools with overridden command line will ignore
+	this option.
+
 --[no-]symlinks::
 	'git difftool''s default behavior is create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
@@ -95,10 +102,11 @@ instead.  `--no-symlinks` is the default on Windows.
 	`diff.tool`, `merge.tool` until a tool is found.
 
 --[no-]trust-exit-code::
-	'git-difftool' invokes a diff tool individually on each file.
-	Errors reported by the diff tool are ignored by default.
-	Use `--trust-exit-code` to make 'git-difftool' exit when an
-	invoked diff tool returns a non-zero exit code.
+	'git-difftool' invokes a diff tool individually on each file
+	unless tabbed mode is active. Errors reported by the diff tool
+	are ignored by default. Use `--trust-exit-code` to make
+	'git-difftool' exit immediately when an invoked diff tool
+	returns a non-zero exit code.
 +
 'git-difftool' will forward the exit code of the invoked tool when
 `--trust-exit-code` is used.
@@ -128,6 +136,9 @@ See the `--tool=<tool>` option above for more details.
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
 
+difftool.tabbed::
+	Configure default value of the `--tabbed` option. See above.
+
 difftool.trustExitCode::
 	Exit difftool if the invoked diff tool returns a non-zero exit status.
 +
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 4da9d24096..1b9fb3591e 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -44,6 +44,68 @@ run_merge_tool::
 	'$MERGED', '$LOCAL', '$REMOTE', and '$BASE' must be defined
 	for use by the merge tool.
 
+TOOLS
+-----
+
+There are several built-in merge tool wrappers which are located in the
+'$(git --exec-path)/mergetools' directory. They are shell scripts and provide
+a unified interface for the discussed scriptlet. It expects to find the
+following functions defined by the each wrapper. However, most of them have
+sane default implementation and the wrapper may write less boilerplate.
+
+can_merge::
+	returns zero status (true) if the tool can be used by `git mergetool`,
+	otherwise the command will be unavailable. Default: true.
+
+can_diff::
+	returns zero status (true) if the tool can be used by `git difftool`,
+	otherwise the command will be unavailable. Default: true.
+
+merge_cmd::
+	should actually launch the tool in merging mode for a single path.
+	Positional argument: '$1' -- name of the merge tool. Predefined
+	variables: '$MERGED', '$LOCAL', '$REMOTE', and '$BASE' mentioned above,
+	'$merge_tool_path' -- absolute path to the binary of the tool or its name
+	if seen in default search path, '$base_present' -- string `true` or `false`.
+
+diff_cmd::
+	should actually launch the tool in diffing mode for a single path.
+	Positional argument: '$1' -- name of the diff tool. Predefined
+	variables: '$LOCAL' and '$REMOTE', '$merge_tool_path' -- absolute path
+	to the binary of the tool or its name if seen in default search path.
+
+diff_combo_supported::
+	returns zero status (true) if the tool can operate in tabbed mode,
+	otherwise the feature will be skipped. Default: false.
+
+diff_combo_cmd::
+	should actually launch the tool with all compared files. The function
+	receives list of pairs of files to compare, every filename is followed
+	by proper input field separator, '$IFS', the list is reachable through
+	third opened file descriptor and the function may close this fd after
+	reading all its content. System file descriptors remain untouched.
+	Predefined variable: '$merge_tool_path' -- absolute path to the binary
+	of the tool or its name if seen in default search path.
++
+Example:
++
+[listing]
+diff_combo_cmd () {
+	"$merge_tool_path" -- `cat <&3` 3<&-
+}
+
+translate_merge_tool_path::
+	can print preset '$merge_tool_path'. Positional argument: '$1' -- name
+	of the merge tool.
+
+exit_code_trustable::
+	returns zero status (true) if a caller is allowed to rely on the exit
+	code of the merge tool, otherwise one should check a backup of the file
+	to determine whether or not merging was successful. Default: false.
+
+list_tool_variants::
+	prints all possible names that may be passed to the '--tool' option.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a6d4ad0818..3ef75aae36 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -583,6 +583,14 @@ For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
 `GIT_DIFF_PATH_TOTAL`::
 	The total number of paths.
 
+`GIT_DIFFTOOL_PROMPT`::
+	Issue an interactive prompting right before launch the diff
+	tool. It must contain a boolean value.
+
+`GIT_DIFFTOOL_TABBED`::
+	Run the diff tool in tabbed mode opening all compared files
+	together. It must contain a boolean value.
+
 other
 ~~~~~
 `GIT_MERGE_VERBOSITY`::
-- 
2.27.0

