From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] mergetool--lib: simplify API usage by removing more global variables
Date: Sat, 11 Apr 2009 20:41:56 -0700
Message-ID: <1239507716-6766-2-git-send-email-davvid@gmail.com>
References: <1239507716-6766-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	charles@hashpling.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 12 05:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsqbo-0004pK-Qa
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 05:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbZDLDmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 23:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756374AbZDLDmQ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 23:42:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:30281 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328AbZDLDmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 23:42:15 -0400
Received: by wa-out-1112.google.com with SMTP id j5so826569wah.21
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VwPTRR8+oYhzKv/Pd6vkGwwu0xtudKAZZ/rnoOw8jNc=;
        b=ZJVjeXNmTxFepHMT73y5fxvj0VVMaP2BFQNGBgGqcgUKv9KlD+h+tAHrq7aZm++F1H
         K9GDXppK1pxnG3Ifqb39QxxOxO9YuPuCjk7GBDc1RsMWItfMJpV6jNvbeD/guX9ouNFW
         mqQq50M/jEBKRr7D0/se2meZz/A4isJTvl5uI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ejIZ2AQC9WrIVDci5C/LJdiHx+weyxp6g3YVL8f04GLmGQE2SdSlU6h4OV9eQlrMXs
         oFwYAtC1ldJGKrQC1Z1zn8/5el6ISfwGh/DLOTmVRokCa+4DqzhveC1SdtsXTXOn4wyB
         1cNqMG4F+LtJKT4l43qxxP79TjKNmJcwxC+Aw=
Received: by 10.114.52.13 with SMTP id z13mr2570423waz.150.1239507735393;
        Sat, 11 Apr 2009 20:42:15 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j26sm3659052waf.24.2009.04.11.20.42.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 20:42:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.471.g6da14
In-Reply-To: <1239507716-6766-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116368>

The mergetool--lib scriplet was tricky to use because it relied upon
the existance of several global shell variables.  This removes more
global variables so that things are simpler for callers.

A side effect is that some variables are recomputed each time
run_merge_tool() is called, but the overhead for recomputing
them is justified by the simpler implementation.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This addresses Charles' notes by making the mergetool--lib
simpler to use.

We can now simply use:
	get_merge_tool
	get_merge_tool_path
	get_merge_tool_cmd
and things will work consistently.

Previous versions used global variables that would give
unexpected results if they had been set previously.

 Documentation/git-mergetool--lib.txt |   16 ++---
 git-difftool--helper.sh              |    6 +-
 git-mergetool--lib.sh                |  109 ++++++++++++++++++----------------
 git-mergetool.sh                     |   15 +++--
 4 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 3d57031..78eb03f 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -7,7 +7,7 @@ git-mergetool--lib - Common git merge tool shell scriptlets
 
 SYNOPSIS
 --------
-'. "$(git --exec-path)/git-mergetool--lib"'
+'TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool--lib"'
 
 DESCRIPTION
 -----------
@@ -20,14 +20,14 @@ The 'git-mergetool--lib' scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up functions for working
 with git merge tools.
 
-Before sourcing it, your script should set up a few variables;
-`TOOL_MODE` is used to define the operation mode for various
-functions.  'diff' and 'merge' are valid values.
+Before sourcing 'git-mergetool--lib', your script must set `TOOL_MODE`
+to define the operation mode for the functions listed below.
+'diff' and 'merge' are valid values.
 
 FUNCTIONS
 ---------
 get_merge_tool::
-	returns a merge tool
+	returns a merge tool.
 
 get_merge_tool_cmd::
 	returns the custom command for a merge tool.
@@ -38,10 +38,8 @@ get_merge_tool_path::
 run_merge_tool::
 	launches a merge tool given the tool name and a true/false
 	flag to indicate whether a merge base is present.
-	'$merge_tool', '$merge_tool_path', and for custom commands,
-	'$merge_tool_cmd', must be defined prior to calling
-	run_merge_tool.  Additionally, '$MERGED', '$LOCAL', '$REMOTE',
-	and '$BASE' must be defined for use by the merge tool.
+	'$MERGED', '$LOCAL', '$REMOTE', and '$BASE' must be defined
+	for use by the merge tool.
 
 Author
 ------
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index b450036..57e8e32 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -47,9 +47,9 @@ launch_merge_tool () {
 test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
 test -n "$GIT_DIFF_TOOL" && merge_tool="$GIT_DIFF_TOOL"
 
-merge_tool=$(get_merge_tool "$merge_tool") || exit
-merge_tool_cmd="$(get_merge_tool_cmd "$merge_tool")"
-merge_tool_path="$(get_merge_tool_path "$merge_tool")" || exit
+if test -z "$merge_tool"; then
+	merge_tool="$(get_merge_tool)" || exit
+fi
 
 # Launch the merge tool on each path provided by 'git diff'
 while test $# -gt 6
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index c5db24e..a16a279 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -8,25 +8,20 @@ merge_mode() {
 }
 
 translate_merge_tool_path () {
-	if test -n "$2"; then
-		echo "$2"
-	else
-		case "$1" in
-		vimdiff)
-			path=vim
-			;;
-		gvimdiff)
-			path=gvim
-			;;
-		emerge)
-			path=emacs
-			;;
-		*)
-			path="$1"
-			;;
-		esac
-		echo "$path"
-	fi
+	case "$1" in
+	vimdiff)
+		echo vim
+		;;
+	gvimdiff)
+		echo gvim
+		;;
+	emerge)
+		echo emacs
+		;;
+	*)
+		echo "$1"
+		;;
+	esac
 }
 
 check_unchanged () {
@@ -69,15 +64,22 @@ valid_tool () {
 }
 
 get_merge_tool_cmd () {
-	diff_mode &&
-	custom_cmd="$(git config difftool.$1.cmd)"
-	test -z "$custom_cmd" &&
-	custom_cmd="$(git config mergetool.$1.cmd)"
-	test -n "$custom_cmd" &&
-	echo "$custom_cmd"
+	# Prints the custom command for a merge tool
+	if test -n "$1"; then
+		merge_tool="$1"
+	else
+		merge_tool="$(get_merge_tool)"
+	fi
+	if diff_mode; then
+		echo "$(git config difftool.$merge_tool.cmd ||
+		        git config mergetool.$merge_tool.cmd)"
+	else
+		echo "$(git config mergetool.$merge_tool.cmd)"
+	fi
 }
 
 run_merge_tool () {
+	merge_tool_path="$(get_merge_tool_path "$1")" || exit
 	base_present="$2"
 	status=0
 
@@ -103,9 +105,9 @@ run_merge_tool () {
 			status=$?
 		else
 			("$merge_tool_path" --auto \
-			 --L1 "$MERGED (A)" \
-			 --L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
-			 > /dev/null 2>&1)
+				--L1 "$MERGED (A)" \
+				--L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
+			> /dev/null 2>&1)
 		fi
 		;;
 	kompare)
@@ -262,6 +264,7 @@ run_merge_tool () {
 		fi
 		;;
 	*)
+		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
 		if test -z "$merge_tool_cmd"; then
 			if merge_mode; then
 				status=1
@@ -269,7 +272,9 @@ run_merge_tool () {
 			break
 		fi
 		if merge_mode; then
-			if test "$merge_tool_trust_exit_code" = "false"; then
+			trust_exit_code="$(git config --bool \
+				mergetool."$1".trustExitCode || echo false)"
+			if test "$trust_exit_code" = "false"; then
 				touch "$BACKUP"
 				( eval $merge_tool_cmd )
 				check_unchanged
@@ -315,64 +320,66 @@ guess_merge_tool () {
 	do
 		merge_tool_path="$(translate_merge_tool_path "$i")"
 		if type "$merge_tool_path" > /dev/null 2>&1; then
-			merge_tool="$i"
-			break
+			echo "$i"
+			return 0
 		fi
 	done
 
-	if test -z "$merge_tool" ; then
-		echo >&2 "No known merge resolution program available."
-		return 1
-	fi
-	echo "$merge_tool"
+	echo >&2 "No known merge resolution program available."
+	return 1
 }
 
 get_configured_merge_tool () {
 	# Diff mode first tries diff.tool and falls back to merge.tool.
 	# Merge mode only checks merge.tool
 	if diff_mode; then
-		tool=$(git config diff.tool)
-	fi
-	if test -z "$tool"; then
-		tool=$(git config merge.tool)
+		merge_tool=$(git config diff.tool || git config merge.tool)
+	else
+		merge_tool=$(git config merge.tool)
 	fi
 	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
 		echo >&2 "git config option $TOOL_MODE.tool set to unknown tool: $merge_tool"
 		echo >&2 "Resetting to default..."
 		return 1
 	fi
-	echo "$tool"
+	echo "$merge_tool"
 }
 
 get_merge_tool_path () {
 	# A merge tool has been set, so verify that it's valid.
+	if test -n "$1"; then
+		merge_tool="$1"
+	else
+		merge_tool="$(get_merge_tool)"
+	fi
 	if ! valid_tool "$merge_tool"; then
 		echo >&2 "Unknown merge tool $merge_tool"
 		exit 1
 	fi
 	if diff_mode; then
-		merge_tool_path=$(git config difftool."$merge_tool".path)
+		merge_tool_path=$(git config difftool."$merge_tool".path ||
+		                  git config mergetool."$merge_tool".path)
+	else
+		merge_tool_path=$(git config mergetool."$merge_tool".path)
 	fi
 	if test -z "$merge_tool_path"; then
-		merge_tool_path=$(git config mergetool."$merge_tool".path)
+		merge_tool_path="$(translate_merge_tool_path "$merge_tool")"
 	fi
-	merge_tool_path="$(translate_merge_tool_path "$merge_tool" "$merge_tool_path")"
-	if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
-		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as '$merge_tool_path'"
+	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
+	! type "$merge_tool_path" > /dev/null 2>&1; then
+		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as"\
+		         "'$merge_tool_path'"
 		exit 1
 	fi
 	echo "$merge_tool_path"
 }
 
 get_merge_tool () {
-	merge_tool="$1"
 	# Check if a merge tool has been configured
-	if test -z "$merge_tool"; then
-		merge_tool=$(get_configured_merge_tool)
-	fi
+	merge_tool=$(get_configured_merge_tool)
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"; then
-		merge_tool=$(guess_merge_tool) || exit
+		merge_tool="$(guess_merge_tool)" || exit
 	fi
 	echo "$merge_tool"
 }
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2e3e02b..b52a741 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -174,9 +174,11 @@ merge_file () {
 	read ans
     fi
 
-    present=false
-    base_present &&
-    present=true
+    if base_present; then
+	    present=true
+    else
+	    present=false
+    fi
 
     if ! run_merge_tool "$merge_tool" "$present"; then
 	echo "merge of $MERGED failed" 1>&2
@@ -254,12 +256,11 @@ prompt_after_failed_merge() {
     done
 }
 
-merge_tool=$(get_merge_tool "$merge_tool") || exit
-merge_tool_cmd="$(get_merge_tool_cmd "$merge_tool")"
-merge_tool_path="$(get_merge_tool_path "$merge_tool")" || exit
+if test -z "$merge_tool"; then
+    merge_tool=$(get_merge_tool "$merge_tool") || exit
+fi
 merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-merge_tool_trust_exit_code="$(git config --bool mergetool."$merge_tool".trustExitCode || echo false)"
 
 last_status=0
 rollup_status=0
-- 
1.6.2.2.471.g6da14
