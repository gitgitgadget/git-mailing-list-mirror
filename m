From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: move 'git-difftool' out of contrib
Date: Thu, 19 Mar 2009 01:25:25 -0700
Message-ID: <1237451125-10611-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 19 09:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkDaD-0003h1-5y
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 09:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbZCSIY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 04:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbZCSIY5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 04:24:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:20052 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbZCSIYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 04:24:54 -0400
Received: by wa-out-1112.google.com with SMTP id j5so288708wah.21
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BFUwwIU6JHj26Y8ZS9DI+WA6mwmWQu6G7KY4ZCt/LAc=;
        b=qQ3uR2mQUqFC9poaoq5Q7Xx25ZudUG6m32vp8kAy93ajAI789LvRhwMeF6jH/WhTcE
         wwwFbIyDKDqcDBw5XLxXHm9EOJgYDR3Cn2EzFwQwiGLC+XejwA3VCO0YFpkf9og3r/qG
         AcDXZh1iuaPo18A+X29R79gSlral5uFdIxZ3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NR92mdAUIJz6G3ywKFYUvJXIxRslwcNBliY9K3QoINUSQtWQH6DifyvxXXru21WeQW
         Ev9VwuhyChWsMt5njXVHvaLa9/VrKV63j5YJQr2RcOv92+mQj4W8gwvxgxqj0fr7B0Ts
         8Qr64CI9NyGzUcaoSeSb4eLjc4w06Vt+hQCdE=
Received: by 10.114.200.2 with SMTP id x2mr1466489waf.83.1237451092669;
        Thu, 19 Mar 2009 01:24:52 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v25sm919881wah.16.2009.03.19.01.24.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 01:24:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.77.g8cc3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113732>

This prepares 'git-difftool' and its documentation for
mainstream use.  The backup file feature was removed since
most users found it annoying.  The reasoning is that it's
better to start out with less features from the get-go and
only add things as users ask for them.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Most of these documentation changes were done to make things
more consistent.

 .gitignore                                         |    2 +
 Documentation/config.txt                           |   17 +++++++++
 .../difftool => Documentation}/git-difftool.txt    |   35 +++++++------------
 Makefile                                           |    2 +
 .../git-difftool-helper => git-difftool-helper.sh  |   34 +------------------
 contrib/difftool/git-difftool => git-difftool.perl |    0
 6 files changed, 35 insertions(+), 55 deletions(-)
 rename {contrib/difftool => Documentation}/git-difftool.txt (73%)
 rename contrib/difftool/git-difftool-helper => git-difftool-helper.sh (86%)
 rename contrib/difftool/git-difftool => git-difftool.perl (100%)

diff --git a/.gitignore b/.gitignore
index 1c57d4c..966c886 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,6 +35,8 @@ git-diff
 git-diff-files
 git-diff-index
 git-diff-tree
+git-difftool
+git-difftool-helper
 git-describe
 git-fast-export
 git-fast-import
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 12540b6..fda6c4c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -663,6 +663,23 @@ diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
+diff.tool::
+	Controls which diff tool is used.  `diff.tool` overrides
+	`merge.tool` when used by linkgit:git-difftool[1] and has
+	the same valid values as `merge.tool`.
+
+difftool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+difftool.<tool>.cmd::
+	Specify the command to invoke the specified diff tool.
+	The specified command is evaluated in shell with the following
+	variables available:  'LOCAL' is set to the name of the temporary
+	file containing the contents of the diff pre-image and 'REMOTE'
+	is set to the name of the temporary file containing the contents
+	of the diff post-image.
+
 diff.wordRegex::
 	A POSIX Extended Regular Expression used to determine what is a "word"
 	when performing word-by-word difference calculations.  Character
diff --git a/contrib/difftool/git-difftool.txt b/Documentation/git-difftool.txt
similarity index 73%
rename from contrib/difftool/git-difftool.txt
rename to Documentation/git-difftool.txt
index 2b7bc03..5ae02f8 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -3,35 +3,31 @@ git-difftool(1)
 
 NAME
 ----
-git-difftool - compare changes using common merge tools
+git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-'git difftool' [--tool=<tool>] [--no-prompt] ['git diff' options]
+'git difftool' [--tool=<tool>] [--no-prompt] [<'git diff' options>]
 
 DESCRIPTION
 -----------
 'git-difftool' is a git command that allows you to compare and edit files
-between revisions using common merge tools.  At its most basic level,
-'git-difftool' does what 'git-mergetool' does but its use is for non-merge
-situations such as when preparing commits or comparing changes against
-the index.
-
-'git difftool' is a frontend to 'git diff' and accepts the same
-arguments and options.
-
-See linkgit:git-diff[1] for the full list of supported options.
+between revisions using common diff tools.  'git difftool' is a frontend
+to 'git-diff' and accepts the same options and arguments.
 
 OPTIONS
 -------
+--no-prompt::
+	Do not prompt before launching a diff tool.
+
 -t <tool>::
 --tool=<tool>::
-	Use the merge resolution program specified by <tool>.
+	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
 	vimdiff, gvimdiff, ecmerge, and opendiff
 +
-If a merge resolution program is not specified, 'git-difftool'
+If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
 configuration variable `diff.tool` is not set, 'git-difftool'
 will pick a suitable default.
@@ -42,7 +38,7 @@ can configure the absolute path to kdiff3 by setting
 `difftool.kdiff3.path`. Otherwise, 'git-difftool' assumes the
 tool is available in PATH.
 +
-Instead of running one of the known merge tool programs,
+Instead of running one of the known diff tools,
 'git-difftool' can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `difftool.<tool>.cmd`.
@@ -56,8 +52,7 @@ is set to the name of the temporary file containing the contents
 of the diff post-image.  `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$LOCAL`.
 
---no-prompt::
-	Do not prompt before launching a diff tool.
+See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIG VARIABLES
 ----------------
@@ -65,21 +60,17 @@ CONFIG VARIABLES
 difftool equivalents have not been defined.
 
 diff.tool::
-	The default merge tool to use.
+	The default diff tool to use.
 
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
 difftool.<tool>.cmd::
-	Specify the command to invoke the specified merge tool.
+	Specify the command to invoke the specified diff tool.
 +
 See the `--tool=<tool>` option above for more details.
 
-merge.keepBackup::
-	The original, unedited file content can be saved to a file with
-	a `.orig` extension.  Defaults to `true` (i.e. keep the backup files).
-
 SEE ALSO
 --------
 linkgit:git-diff[1]::
diff --git a/Makefile b/Makefile
index b96c2b3..cb99c5d 100644
--- a/Makefile
+++ b/Makefile
@@ -265,6 +265,7 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
+SCRIPT_SH += git-difftool-helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -284,6 +285,7 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_PERL += git-add--interactive.perl
+SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
diff --git a/contrib/difftool/git-difftool-helper b/git-difftool-helper.sh
similarity index 86%
rename from contrib/difftool/git-difftool-helper
rename to git-difftool-helper.sh
index 9c0a134..b91002b 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/git-difftool-helper.sh
@@ -9,31 +9,7 @@
 
 # Set GIT_DIFFTOOL_NO_PROMPT to bypass the per-file prompt.
 should_prompt () {
-	! test -n "$GIT_DIFFTOOL_NO_PROMPT"
-}
-
-# Should we keep the backup .orig file?
-keep_backup_mode="$(git config --bool merge.keepBackup || echo true)"
-keep_backup () {
-	test "$keep_backup_mode" = "true"
-}
-
-# This function manages the backup .orig file.
-# A backup $MERGED.orig file is created if changes are detected.
-cleanup_temp_files () {
-	if test -n "$MERGED"; then
-		if keep_backup && test "$MERGED" -nt "$BACKUP"; then
-			test -f "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"
-		else
-			rm -f -- "$BACKUP"
-		fi
-	fi
-}
-
-# This is called when users Ctrl-C out of git-difftool-helper
-sigint_handler () {
-	cleanup_temp_files
-	exit 1
+	test -z "$GIT_DIFFTOOL_NO_PROMPT"
 }
 
 # This function prepares temporary files and launches the appropriate
@@ -47,12 +23,6 @@ launch_merge_tool () {
 	LOCAL="$2"
 	REMOTE="$3"
 	BASE="$1"
-	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-	BACKUP="$MERGED.BACKUP.$ext"
-
-	# Create and ensure that we clean up $BACKUP
-	test -f "$MERGED" && cp -- "$MERGED" "$BACKUP"
-	trap sigint_handler INT
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
@@ -124,8 +94,6 @@ launch_merge_tool () {
 		fi
 		;;
 	esac
-
-	cleanup_temp_files
 }
 
 # Verifies that (difftool|mergetool).<tool>.cmd exists
diff --git a/contrib/difftool/git-difftool b/git-difftool.perl
similarity index 100%
rename from contrib/difftool/git-difftool
rename to git-difftool.perl
-- 
1.6.2.77.g8cc3f
