From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] contrib/difftool: use a separate config namespace for difftool commands
Date: Mon,  9 Mar 2009 02:12:36 -0700
Message-ID: <1236589956-13486-1-git-send-email-davvid@gmail.com>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 10:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgbYp-0005xI-38
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 10:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZCIJML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 05:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbZCIJMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 05:12:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:43935 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbZCIJMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 05:12:06 -0400
Received: by wa-out-1112.google.com with SMTP id v33so910888wah.21
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JCbc5KiTpYc2wuc8AsD6mXjTjfpw4GD2KydLq7IYn0M=;
        b=b99ayhT823UMuAd0bKhVTXsD9TbECSY1memEuon9D1Z51zD+4Y6XJEkCfkAQjPagRP
         tT5Jw1/TWv9qSCwkKbR2SncSMeLOWTLu1KXX2IwHYoJ3xo6Wy4jW+BAj8QfM38hcyHP4
         +5jkx1MEh3yopwFlwdbQhfx5pEQehaXTgRT1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IxADCZnZIuu/Gq16G18QQPgSXmMkvYSByY+G7KzsnEo9a+k2iT/eHAlXE+6uo3Sd+3
         VHktaMh74AyBzW7c3XU3GtyXpZXI4CMNiA2usdlItYiEWgJT9A7574068Cogs0Iooe8X
         w1Hnins1Fjar2IOuPDy93CzL9e8SVbDgt3xDQ=
Received: by 10.115.47.1 with SMTP id z1mr3394379waj.133.1236589924728;
        Mon, 09 Mar 2009 02:12:04 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m30sm3848859wag.12.2009.03.09.02.12.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Mar 2009 02:12:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.77.g8cc3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112679>

Some users have different mergetool and difftool settings, so teach
difftool to read config vars from the difftool.* namespace.  This allows
having distinct configurations for the diff and merge scenarios.

We don't want to force existing users to set new values for no reason
so difftool falls back to existing mergetool config variables when the
difftool equivalents are not defined.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This patch was motivated by an upset user telling me that
"difftool is wasting screen real-estate by launching a 3-way diff".
After looking into it I realized that they needed to be able to
support a diff.tool that is separate from git-mergetool's merge.tool.

This patch brought up a few questions:

	Custom difftool commands use $LOCAL and $REMOTE just like
mergetool but in a diff there really is no $LOCAL or $REMOTE.
At best there's $PRE and $POST, but even that breaks down when
viewing reverse diffs. So really there's just $A and $B.
I felt that keeping difftool and mergetool consistent was the
best choice since users are already familiar with $LOCAL and $REMOTE.

	A lot of the difftool code traces its lineage to the
mergetool command and thus the code uses variables such as
$merge_tool when talking about diff tools.  Renaming all of the
variables seemed pointless and would also have made reviewing
this patch much more difficult so I chose to leave the variables
named as-is.  If someone is really bothered by the variable naming
then I can send a second patch that renames things, but doing so
basically results in a complete rewrite of difftool-helper and
the documentation with no real added benefit.

	Why does difftool fallback to mergetool when choosing
defaults?  Answer: backwards compatibility, respect existing users,
and be friendly to lazy users that don't feel like configuring a
separate config variable just for difftool when they've already
configured a merge.tool that works in both situations as-is
(e.g. any of the built-in tools such as xxdiff, vimdiff, etc.)

 contrib/difftool/git-difftool        |    6 +++---
 contrib/difftool/git-difftool-helper |   19 ++++++++++++++-----
 contrib/difftool/git-difftool.txt    |   30 +++++++++++++++---------------
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/contrib/difftool/git-difftool b/contrib/difftool/git-difftool
index 0cda3d2..0deda3a 100755
--- a/contrib/difftool/git-difftool
+++ b/contrib/difftool/git-difftool
@@ -4,7 +4,7 @@
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
 # git-difftool-helper script.  This script exports
 # GIT_EXTERNAL_DIFF and GIT_PAGER for use by git, and
-# GIT_DIFFTOOL_NO_PROMPT and GIT_MERGE_TOOL for use by git-difftool-helper.
+# GIT_DIFFTOOL_NO_PROMPT and GIT_DIFF_TOOL for use by git-difftool-helper.
 # Any arguments that are unknown to this script are forwarded to 'git diff'.
 
 use strict;
@@ -49,12 +49,12 @@ sub generate_command
 		}
 		if ($arg eq '-t' or $arg eq '--tool') {
 			usage() if $#ARGV <= $idx;
-			$ENV{GIT_MERGE_TOOL} = $ARGV[$idx + 1];
+			$ENV{GIT_DIFF_TOOL} = $ARGV[$idx + 1];
 			$skip_next = 1;
 			next;
 		}
 		if ($arg =~ /^--tool=/) {
-			$ENV{GIT_MERGE_TOOL} = substr($arg, 7);
+			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
 			next;
 		}
 		if ($arg eq '--no-prompt') {
diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index db3af6a..9c0a134 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -128,8 +128,10 @@ launch_merge_tool () {
 	cleanup_temp_files
 }
 
-# Verifies that mergetool.<tool>.cmd exists
+# Verifies that (difftool|mergetool).<tool>.cmd exists
 valid_custom_tool() {
+	merge_tool_cmd="$(git config difftool.$1.cmd)"
+	test -z "$merge_tool_cmd" &&
 	merge_tool_cmd="$(git config mergetool.$1.cmd)"
 	test -n "$merge_tool_cmd"
 }
@@ -150,8 +152,11 @@ valid_tool() {
 }
 
 # Sets up the merge_tool_path variable.
-# This handles the mergetool.<tool>.path configuration.
+# This handles the difftool.<tool>.path configuration.
+# This also falls back to mergetool defaults.
 init_merge_tool_path() {
+	merge_tool_path=$(git config difftool."$1".path)
+	test -z "$merge_tool_path" &&
 	merge_tool_path=$(git config mergetool."$1".path)
 	if test -z "$merge_tool_path"; then
 		case "$1" in
@@ -165,15 +170,19 @@ init_merge_tool_path() {
 	fi
 }
 
-# Allow the GIT_MERGE_TOOL variable to provide a default value
+# Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
 test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
+test -n "$GIT_DIFF_TOOL" && merge_tool="$GIT_DIFF_TOOL"
 
-# If not merge tool was specified then use the merge.tool
+# If merge tool was not specified then use the diff.tool
 # configuration variable.  If that's invalid then reset merge_tool.
+# Fallback to merge.tool.
 if test -z "$merge_tool"; then
+	merge_tool=$(git config diff.tool)
+	test -z "$merge_tool" &&
 	merge_tool=$(git config merge.tool)
 	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
-		echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
+		echo >&2 "git config option diff.tool set to unknown tool: $merge_tool"
 		echo >&2 "Resetting to default..."
 		unset merge_tool
 	fi
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index 6e2610c..2b7bc03 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -32,23 +32,23 @@ OPTIONS
 	vimdiff, gvimdiff, ecmerge, and opendiff
 +
 If a merge resolution program is not specified, 'git-difftool'
-will use the configuration variable `merge.tool`.  If the
-configuration variable `merge.tool` is not set, 'git difftool'
+will use the configuration variable `diff.tool`.  If the
+configuration variable `diff.tool` is not set, 'git-difftool'
 will pick a suitable default.
 +
 You can explicitly provide a full path to the tool by setting the
-configuration variable `mergetool.<tool>.path`. For example, you
+configuration variable `difftool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
-`mergetool.kdiff3.path`. Otherwise, 'git-difftool' assumes the
+`difftool.kdiff3.path`. Otherwise, 'git-difftool' assumes the
 tool is available in PATH.
 +
 Instead of running one of the known merge tool programs,
 'git-difftool' can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
-variable `mergetool.<tool>.cmd`.
+variable `difftool.<tool>.cmd`.
 +
 When 'git-difftool' is invoked with this tool (either through the
-`-t` or `--tool` option or the `merge.tool` configuration variable)
+`-t` or `--tool` option or the `diff.tool` configuration variable)
 the configured command line will be invoked with the following
 variables available: `$LOCAL` is set to the name of the temporary
 file containing the contents of the diff pre-image and `$REMOTE`
@@ -61,24 +61,24 @@ with custom merge tool commands and has the same value as `$LOCAL`.
 
 CONFIG VARIABLES
 ----------------
-merge.tool::
-	The default merge tool to use.
-+
-See the `--tool=<tool>` option above for more details.
+'git-difftool' falls back to 'git-mergetool' config variables when the
+difftool equivalents have not been defined.
 
-merge.keepBackup::
-	The original, unedited file content can be saved to a file with
-	a `.orig` extension.  Defaults to `true` (i.e. keep the backup files).
+diff.tool::
+	The default merge tool to use.
 
-mergetool.<tool>.path::
+difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
-mergetool.<tool>.cmd::
+difftool.<tool>.cmd::
 	Specify the command to invoke the specified merge tool.
 +
 See the `--tool=<tool>` option above for more details.
 
+merge.keepBackup::
+	The original, unedited file content can be saved to a file with
+	a `.orig` extension.  Defaults to `true` (i.e. keep the backup files).
 
 SEE ALSO
 --------
-- 
1.6.2.77.g8cc3f
