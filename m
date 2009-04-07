From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 14/14] difftool/mergetool: refactor commands to use git-mergetool--lib
Date: Tue,  7 Apr 2009 01:21:23 -0700
Message-ID: <1239092483-14973-6-git-send-email-davvid@gmail.com>
References: <1239092483-14973-1-git-send-email-davvid@gmail.com>
 <1239092483-14973-2-git-send-email-davvid@gmail.com>
 <1239092483-14973-3-git-send-email-davvid@gmail.com>
 <1239092483-14973-4-git-send-email-davvid@gmail.com>
 <1239092483-14973-5-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 07 10:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6c9-00066J-QJ
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbZDGIWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 04:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZDGIWM
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:22:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:21178 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZDGIWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:22:02 -0400
Received: by wa-out-1112.google.com with SMTP id j5so2001989wah.21
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+vKfvhI2u5dqDb8lCs5+EiBVnk2nURoYTyaEVXiFVoA=;
        b=RXCtc892qx8lIOkxj5zfGICCaN3pjy8IsHnblwTiKpCLsCcPmHiRLmo29vvHPgcEs6
         n4wJdf6RoqH9lmFlbSSnhcQxzk4FGImvhqNW7+RSjXcxXxW3zMX3KQELnL8+V6/1bmdv
         UBHVNe+elcLLZq7SEIFB+ZDcPMwCQ0/+S6Qtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AL+niR4PsDULPm7p+TTLEhXF/ORTU6HOaJGdOyqUl3tfK1REprixjilYZ4lz3DLsL9
         v2aa63SF4d165kJcE/0Kvqub+nhaaLXTI/ksxRTlx1QmtXYmeXEvN74+gpn5JSUZhnpx
         Gl5v0Ek/RFDWLlJk3+9csFD+CxuogovlMKj9Y=
Received: by 10.114.208.20 with SMTP id f20mr2776110wag.225.1239092521246;
        Tue, 07 Apr 2009 01:22:01 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j39sm6565951waf.63.2009.04.07.01.21.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 01:22:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239092483-14973-5-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115935>

This consolidates the common functionality from git-mergetool and
git-difftool--helper into a single git-mergetool--lib scriptlet.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Includes suggestions from Markus.
We also moved opendiff up to the front so that it's
preferred when on Mac OS.

 .gitignore                           |    1 +
 Documentation/git-mergetool--lib.txt |   56 +++++
 Makefile                             |    1 +
 git-difftool--helper.sh              |  186 +----------------
 git-mergetool--lib.sh                |  387 ++++++++++++++++++++++++++++++++++
 git-mergetool.sh                     |  224 ++------------------
 6 files changed, 467 insertions(+), 388 deletions(-)
 create mode 100644 Documentation/git-mergetool--lib.txt
 create mode 100644 git-mergetool--lib.sh

diff --git a/.gitignore b/.gitignore
index a36da9d..757c7f0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,6 +80,7 @@ git-merge-recursive
 git-merge-resolve
 git-merge-subtree
 git-mergetool
+git-mergetool--lib
 git-mktag
 git-mktree
 git-name-rev
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
new file mode 100644
index 0000000..3d57031
--- /dev/null
+++ b/Documentation/git-mergetool--lib.txt
@@ -0,0 +1,56 @@
+git-mergetool--lib(1)
+=====================
+
+NAME
+----
+git-mergetool--lib - Common git merge tool shell scriptlets
+
+SYNOPSIS
+--------
+'. "$(git --exec-path)/git-mergetool--lib"'
+
+DESCRIPTION
+-----------
+
+This is not a command the end user would want to run.  Ever.
+This documentation is meant for people who are studying the
+Porcelain-ish scripts and/or are writing new ones.
+
+The 'git-mergetool--lib' scriptlet is designed to be sourced (using
+`.`) by other shell scripts to set up functions for working
+with git merge tools.
+
+Before sourcing it, your script should set up a few variables;
+`TOOL_MODE` is used to define the operation mode for various
+functions.  'diff' and 'merge' are valid values.
+
+FUNCTIONS
+---------
+get_merge_tool::
+	returns a merge tool
+
+get_merge_tool_cmd::
+	returns the custom command for a merge tool.
+
+get_merge_tool_path::
+	returns the custom path for a merge tool.
+
+run_merge_tool::
+	launches a merge tool given the tool name and a true/false
+	flag to indicate whether a merge base is present.
+	'$merge_tool', '$merge_tool_path', and for custom commands,
+	'$merge_tool_cmd', must be defined prior to calling
+	run_merge_tool.  Additionally, '$MERGED', '$LOCAL', '$REMOTE',
+	and '$BASE' must be defined for use by the merge tool.
+
+Author
+------
+Written by David Aguilar <davvid@gmail.com>
+
+Documentation
+--------------
+Documentation by David Aguilar and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index a80055f..3e56274 100644
--- a/Makefile
+++ b/Makefile
@@ -284,6 +284,7 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
+SCRIPT_SH += git-mergetool--lib.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index f3c27d8..b450036 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -5,6 +5,10 @@
 #
 # Copyright (c) 2009 David Aguilar
 
+# Load common functions from git-mergetool--lib
+TOOL_MODE=diff
+. git-mergetool--lib
+
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
@@ -16,8 +20,7 @@ should_prompt () {
 	fi
 }
 
-# This function prepares temporary files and launches the appropriate
-# merge tool.
+# Sets up shell variables and runs a merge tool
 launch_merge_tool () {
 	# Merged is the filename as it appears in the work tree
 	# Local is the contents of a/filename
@@ -37,187 +40,16 @@ launch_merge_tool () {
 	fi
 
 	# Run the appropriate merge tool command
-	case "$merge_tool" in
-	kdiff3)
-		basename=$(basename "$MERGED")
-		"$merge_tool_path" --auto \
-			--L1 "$basename (A)" \
-			--L2 "$basename (B)" \
-			"$LOCAL" "$REMOTE" \
-			> /dev/null 2>&1
-		;;
-
-	kompare)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-
-	tkdiff)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-
-	meld)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-
-	diffuse)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
-		;;
-
-	vimdiff)
-		"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
-		;;
-
-	gvimdiff)
-		"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$REMOTE"
-		;;
-
-	xxdiff)
-		"$merge_tool_path" \
-			-R 'Accel.Search: "Ctrl+F"' \
-			-R 'Accel.SearchForward: "Ctrl-G"' \
-			"$LOCAL" "$REMOTE"
-		;;
-
-	opendiff)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
-		;;
-
-	ecmerge)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			--default --mode=merge2 --to="$MERGED"
-		;;
-
-	emerge)
-		"$merge_tool_path" -f emerge-files-command \
-			"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
-		;;
-
-	*)
-		if test -n "$merge_tool_cmd"; then
-			( eval $merge_tool_cmd )
-		fi
-		;;
-	esac
-}
-
-# Verifies that (difftool|mergetool).<tool>.cmd exists
-valid_custom_tool() {
-	merge_tool_cmd="$(git config difftool.$1.cmd)"
-	test -z "$merge_tool_cmd" &&
-	merge_tool_cmd="$(git config mergetool.$1.cmd)"
-	test -n "$merge_tool_cmd"
-}
-
-# Verifies that the chosen merge tool is properly setup.
-# Built-in merge tools are always valid.
-valid_tool() {
-	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
-		;; # happy
-	*)
-		if ! valid_custom_tool "$1"
-		then
-			return 1
-		fi
-		;;
-	esac
-}
-
-# Sets up the merge_tool_path variable.
-# This handles the difftool.<tool>.path configuration.
-# This also falls back to mergetool defaults.
-init_merge_tool_path() {
-	merge_tool_path=$(git config difftool."$1".path)
-	test -z "$merge_tool_path" &&
-	merge_tool_path=$(git config mergetool."$1".path)
-	if test -z "$merge_tool_path"; then
-		case "$1" in
-		vimdiff)
-			merge_tool_path=vim
-			;;
-		gvimdiff)
-			merge_tool_path=gvim
-			;;
-		emerge)
-			merge_tool_path=emacs
-			;;
-		*)
-			merge_tool_path="$1"
-			;;
-		esac
-	fi
+	run_merge_tool "$merge_tool"
 }
 
 # Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
 test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
 test -n "$GIT_DIFF_TOOL" && merge_tool="$GIT_DIFF_TOOL"
 
-# If merge tool was not specified then use the diff.tool
-# configuration variable.  If that's invalid then reset merge_tool.
-# Fallback to merge.tool.
-if test -z "$merge_tool"; then
-	merge_tool=$(git config diff.tool)
-	test -z "$merge_tool" &&
-	merge_tool=$(git config merge.tool)
-	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
-		echo >&2 "git config option diff.tool set to unknown tool: $merge_tool"
-		echo >&2 "Resetting to default..."
-		unset merge_tool
-	fi
-fi
-
-# Try to guess an appropriate merge tool if no tool has been set.
-if test -z "$merge_tool"; then
-	# We have a $DISPLAY so try some common UNIX merge tools
-	if test -n "$DISPLAY"; then
-		# If gnome then prefer meld, otherwise, prefer kdiff3 or kompare
-		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-			merge_tool_candidates="meld kdiff3 kompare tkdiff xxdiff gvimdiff diffuse"
-		else
-			merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff diffuse"
-		fi
-	fi
-	if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-		# $EDITOR is emacs so add emerge as a candidate
-		merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
-	elif echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
-		# $EDITOR is vim so add vimdiff as a candidate
-		merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
-	else
-		merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
-	fi
-	echo "merge tool candidates: $merge_tool_candidates"
-
-	# Loop over each candidate and stop when a valid merge tool is found.
-	for i in $merge_tool_candidates
-	do
-		init_merge_tool_path $i
-		if type "$merge_tool_path" > /dev/null 2>&1; then
-			merge_tool=$i
-			break
-		fi
-	done
-
-	if test -z "$merge_tool" ; then
-		echo "No known merge resolution program available."
-		exit 1
-	fi
-
-else
-	# A merge tool has been set, so verify that it's valid.
-	if ! valid_tool "$merge_tool"; then
-		echo >&2 "Unknown merge tool $merge_tool"
-		exit 1
-	fi
-
-	init_merge_tool_path "$merge_tool"
-
-	if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
-		echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
-		exit 1
-	fi
-fi
-
+merge_tool=$(get_merge_tool "$merge_tool") || exit
+merge_tool_cmd="$(get_merge_tool_cmd "$merge_tool")"
+merge_tool_path="$(get_merge_tool_path "$merge_tool")" || exit
 
 # Launch the merge tool on each path provided by 'git diff'
 while test $# -gt 6
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
new file mode 100644
index 0000000..a2f45ee
--- /dev/null
+++ b/git-mergetool--lib.sh
@@ -0,0 +1,387 @@
+# git-mergetool--lib is a library for common merge tool functions
+diff_mode() {
+	test $TOOL_MODE = "diff"
+}
+
+merge_mode() {
+	test $TOOL_MODE = "merge"
+}
+
+translate_merge_tool_path () {
+	if test -n "$2"; then
+		echo "$2"
+	else
+		case "$1" in
+		vimdiff)
+			path=vim
+			;;
+		gvimdiff)
+			path=gvim
+			;;
+		emerge)
+			path=emacs
+			;;
+		*)
+			path="$1"
+			;;
+		esac
+		echo "$path"
+	fi
+}
+
+check_unchanged () {
+	if merge_mode; then
+		if test "$MERGED" -nt "$BACKUP"; then
+			status=0
+		else
+			while true; do
+				echo "$MERGED seems unchanged."
+				printf "Was the merge successful? [y/n] "
+				read answer < /dev/tty
+				case "$answer" in
+				y*|Y*) status=0; break ;;
+				n*|N*) status=1; break ;;
+				esac
+			done
+		fi
+	else
+		status=0
+	fi
+}
+
+valid_tool () {
+	case "$1" in
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
+	emerge | vimdiff | gvimdiff | ecmerge | diffuse)
+		;; # happy
+	tortoisemerge)
+		if ! merge_mode; then
+			return 1
+		fi
+		;;
+	kompare)
+		if ! diff_mode; then
+			return 1
+		fi
+		;;
+	*)
+		if test -z "$(get_merge_tool_cmd "$1")"; then
+			return 1
+		fi
+		;;
+	esac
+}
+
+get_merge_tool_cmd () {
+	diff_mode &&
+	custom_cmd="$(git config difftool.$1.cmd)"
+	test -z "$custom_cmd" &&
+	custom_cmd="$(git config mergetool.$1.cmd)"
+	test -n "$custom_cmd" &&
+	echo "$custom_cmd"
+}
+
+run_merge_tool () {
+	base_present="$2"
+	if diff_mode; then
+		status=0
+		base_present="false"
+	fi
+
+	case "$1" in
+	kdiff3)
+		if merge_mode; then
+			if $base_present; then
+				("$merge_tool_path" --auto \
+					--L1 "$MERGED (Base)" \
+					--L2 "$MERGED (Local)" \
+					--L3 "$MERGED (Remote)" \
+					-o "$MERGED" \
+					"$BASE" "$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1)
+			else
+				("$merge_tool_path" --auto \
+					--L1 "$MERGED (Local)" \
+					--L2 "$MERGED (Remote)" \
+					-o "$MERGED" \
+					"$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1)
+			fi
+			status=$?
+		else
+			("$merge_tool_path" --auto \
+			 --L1 "$MERGED (A)" \
+			 --L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
+			 > /dev/null 2>&1)
+		fi
+		;;
+	kompare)
+		"$merge_tool_path" "$LOCAL" "$REMOTE"
+		;;
+	tkdiff)
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" -a "$BASE" \
+					-o "$MERGED" "$LOCAL" "$REMOTE"
+			else
+				"$merge_tool_path" \
+					-o "$MERGED" "$LOCAL" "$REMOTE"
+			fi
+			status=$?
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
+		fi
+		;;
+	meld)
+		if merge_mode; then
+			touch "$BACKUP"
+			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
+		fi
+		;;
+	diffuse)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" \
+					"$LOCAL" "$MERGED" "$REMOTE" \
+					"$BASE" | cat
+			else
+				"$merge_tool_path" \
+					"$LOCAL" "$MERGED" "$REMOTE" | cat
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+		fi
+		;;
+	vimdiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			"$merge_tool_path" -d -c "wincmd l" \
+				"$LOCAL" "$MERGED" "$REMOTE"
+			check_unchanged
+		else
+			"$merge_tool_path" -d -c "wincmd l" \
+				"$LOCAL" "$REMOTE"
+		fi
+		;;
+	gvimdiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			"$merge_tool_path" -d -c "wincmd l" -f \
+				"$LOCAL" "$MERGED" "$REMOTE"
+			check_unchanged
+		else
+			"$merge_tool_path" -d -c "wincmd l" -f \
+				"$LOCAL" "$REMOTE"
+		fi
+		;;
+	xxdiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" -X --show-merged-pane \
+					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+					-R 'Accel.Search: "Ctrl+F"' \
+					-R 'Accel.SearchForward: "Ctrl-G"' \
+					--merged-file "$MERGED" \
+					"$LOCAL" "$BASE" "$REMOTE"
+			else
+				"$merge_tool_path" -X $extra \
+					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+					-R 'Accel.Search: "Ctrl+F"' \
+					-R 'Accel.SearchForward: "Ctrl-G"' \
+					--merged-file "$MERGED" \
+					"$LOCAL" "$REMOTE"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				"$LOCAL" "$REMOTE"
+		fi
+		;;
+	opendiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					-ancestor "$BASE" \
+					-merge "$MERGED" | cat
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					-merge "$MERGED" | cat
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+		fi
+		;;
+	ecmerge)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+					--default --mode=merge3 --to="$MERGED"
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					--default --mode=merge2 --to="$MERGED"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				--default --mode=merge2 --to="$MERGED"
+		fi
+		;;
+	emerge)
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" \
+					-f emerge-files-with-ancestor-command \
+					"$LOCAL" "$REMOTE" "$BASE" \
+					"$(basename "$MERGED")"
+			else
+				"$merge_tool_path" \
+					-f emerge-files-command \
+					"$LOCAL" "$REMOTE" \
+					"$(basename "$MERGED")"
+			fi
+			status=$?
+		else
+			"$merge_tool_path" -f emerge-files-command \
+				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
+		fi
+		;;
+	tortoisemerge)
+		if $base_present; then
+			touch "$BACKUP"
+			"$merge_tool_path" \
+				-base:"$BASE" -mine:"$LOCAL" \
+				-theirs:"$REMOTE" -merged:"$MERGED"
+			check_unchanged
+		else
+			echo "TortoiseMerge cannot be used without a base" 1>&2
+			status=1
+		fi
+		;;
+	*)
+		if test -z "$merge_tool_cmd"; then
+			if merge_mode; then
+				status=1
+			fi
+			break
+		fi
+		if merge_mode; then
+			if test "$merge_tool_trust_exit_code" = "false"; then
+				touch "$BACKUP"
+				( eval $merge_tool_cmd )
+				check_unchanged
+			else
+				( eval $merge_tool_cmd )
+			fi
+			status=$?
+		else
+			( eval $merge_tool_cmd )
+		fi
+		;;
+	esac
+	return $status
+}
+
+guess_merge_tool () {
+	tools="ecmerge"
+	if merge_mode; then
+		tools="$tools tortoisemerge"
+	else
+		kompare=" kompare "
+	fi
+	if test -n "$DISPLAY"; then
+		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
+			tools="meld opendiff kdiff3""$kompare""tkdiff $tools"
+			tools="$tools xxdiff gvimdiff diffuse"
+		else
+			tools="opendiff kdiff3""$kompare""tkdiff xxdiff $tools"
+			tools="$tools meld gvimdiff diffuse"
+		fi
+	fi
+	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
+		# $EDITOR is emacs so add emerge as a candidate
+		tools="$tools emerge vimdiff"
+	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
+		# $EDITOR is vim so add vimdiff as a candidate
+		tools="$tools vimdiff emerge"
+	else
+		tools="$tools emerge vimdiff"
+	fi
+	echo >&2 "merge tool candidates: $tools"
+
+	# Loop over each candidate and stop when a valid merge tool is found.
+	for i in $tools
+	do
+		merge_tool_path="$(translate_merge_tool_path "$i")"
+		if type "$merge_tool_path" > /dev/null 2>&1; then
+			merge_tool="$i"
+			break
+		fi
+	done
+
+	if test -z "$merge_tool" ; then
+		echo >&2 "No known merge resolution program available."
+		return 1
+	fi
+	echo "$merge_tool"
+}
+
+get_configured_merge_tool () {
+	# Diff mode first tries diff.tool and falls back to merge.tool.
+	# Merge mode only checks merge.tool
+	if diff_mode; then
+		tool=$(git config diff.tool)
+	fi
+	if test -z "$tool"; then
+		tool=$(git config merge.tool)
+	fi
+	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
+		echo >&2 "git config option $TOOL_MODE.tool set to unknown tool: $merge_tool"
+		echo >&2 "Resetting to default..."
+		return 1
+	fi
+	echo "$tool"
+}
+
+get_merge_tool_path () {
+	# A merge tool has been set, so verify that it's valid.
+	if ! valid_tool "$merge_tool"; then
+		echo >&2 "Unknown merge tool $merge_tool"
+		exit 1
+	fi
+	if diff_mode; then
+		merge_tool_path=$(git config difftool."$merge_tool".path)
+	fi
+	if test -z "$merge_tool_path"; then
+		merge_tool_path=$(git config mergetool."$merge_tool".path)
+	fi
+	merge_tool_path="$(translate_merge_tool_path "$merge_tool" "$merge_tool_path")"
+	if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
+		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as '$merge_tool_path'"
+		exit 1
+	fi
+	echo "$merge_tool_path"
+}
+
+get_merge_tool () {
+	merge_tool="$1"
+	# Check if a merge tool has been configured
+	if test -z "$merge_tool"; then
+		merge_tool=$(get_configured_merge_tool)
+	fi
+	# Try to guess an appropriate merge tool if no tool has been set.
+	if test -z "$merge_tool"; then
+		merge_tool=$(guess_merge_tool) || exit
+	fi
+	echo "$merge_tool"
+}
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cceebb7..efa31a2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -11,7 +11,9 @@
 USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
+TOOL_MODE=merge
 . git-sh-setup
+. git-mergetool--lib
 require_work_tree
 
 # Returns true if the mode reflects a symlink
@@ -110,22 +112,6 @@ resolve_deleted_merge () {
 	done
 }
 
-check_unchanged () {
-    if test "$MERGED" -nt "$BACKUP" ; then
-	status=0;
-    else
-	while true; do
-	    echo "$MERGED seems unchanged."
-	    printf "Was the merge successful? [y/n] "
-	    read answer < /dev/tty
-	    case "$answer" in
-		y*|Y*) status=0; break ;;
-		n*|N*) status=1; break ;;
-	    esac
-	done
-    fi
-}
-
 checkout_staged_file () {
     tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
 
@@ -188,107 +174,11 @@ merge_file () {
 	read ans
     fi
 
-    case "$merge_tool" in
-	kdiff3)
-	    if base_present ; then
-		("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
-		    -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
-	    else
-		("$merge_tool_path" --auto --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
-		    -o "$MERGED" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
-	    fi
-	    status=$?
-	    ;;
-	tkdiff)
-	    if base_present ; then
-		"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
-	    else
-		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
-	    fi
-	    status=$?
-	    ;;
-	meld)
-	    touch "$BACKUP"
-	    "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-	    check_unchanged
-	    ;;
-	vimdiff)
-	    touch "$BACKUP"
-	    "$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
-	    check_unchanged
-	    ;;
-	gvimdiff)
-	    touch "$BACKUP"
-	    "$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
-	    check_unchanged
-	    ;;
-	xxdiff)
-	    touch "$BACKUP"
-	    if base_present ; then
-		"$merge_tool_path" -X --show-merged-pane \
-		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
-		    -R 'Accel.Search: "Ctrl+F"' \
-		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
-	    else
-		"$merge_tool_path" -X --show-merged-pane \
-		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
-		    -R 'Accel.Search: "Ctrl+F"' \
-		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$MERGED" "$LOCAL" "$REMOTE"
-	    fi
-	    check_unchanged
-	    ;;
-	opendiff)
-	    touch "$BACKUP"
-	    if base_present; then
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED" | cat
-	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$MERGED" | cat
-	    fi
-	    check_unchanged
-	    ;;
-	ecmerge)
-	    touch "$BACKUP"
-	    if base_present; then
-		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"
-	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" --default --mode=merge2 --to="$MERGED"
-	    fi
-	    check_unchanged
-	    ;;
-	emerge)
-	    if base_present ; then
-		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
-	    else
-		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$MERGED")"
-	    fi
-	    status=$?
-	    ;;
-	tortoisemerge)
-	    if base_present ; then
-		touch "$BACKUP"
-		"$merge_tool_path" -base:"$BASE" -mine:"$LOCAL" -theirs:"$REMOTE" -merged:"$MERGED"
-		check_unchanged
-	    else
-		echo "TortoiseMerge cannot be used without a base" 1>&2
-		status=1
-	    fi
-	    ;;
-	*)
-	    if test -n "$merge_tool_cmd"; then
-		if test "$merge_tool_trust_exit_code" = "false"; then
-		    touch "$BACKUP"
-		    ( eval $merge_tool_cmd )
-		    check_unchanged
-		else
-		    ( eval $merge_tool_cmd )
-		    status=$?
-		fi
-	    fi
-	    ;;
-    esac
-    if test "$status" -ne 0; then
+    present=false
+    base_present &&
+    present=true
+
+    if ! run_merge_tool "$merge_tool" "$present"; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
 
@@ -347,44 +237,6 @@ do
     shift
 done
 
-valid_custom_tool()
-{
-    merge_tool_cmd="$(git config mergetool.$1.cmd)"
-    test -n "$merge_tool_cmd"
-}
-
-valid_tool() {
-	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | tortoisemerge)
-			;; # happy
-		*)
-			if ! valid_custom_tool "$1"; then
-				return 1
-			fi
-			;;
-	esac
-}
-
-init_merge_tool_path() {
-	merge_tool_path=$(git config mergetool.$1.path)
-	if test -z "$merge_tool_path" ; then
-		case "$1" in
-			vimdiff)
-				merge_tool_path=vim
-				;;
-			gvimdiff)
-				merge_tool_path=gvim
-				;;
-			emerge)
-				merge_tool_path=emacs
-				;;
-			*)
-				merge_tool_path=$1
-				;;
-		esac
-	fi
-}
-
 prompt_after_failed_merge() {
     while true; do
 	printf "Continue merging other unresolved paths (y/n) ? "
@@ -402,62 +254,12 @@ prompt_after_failed_merge() {
     done
 }
 
-if test -z "$merge_tool"; then
-    merge_tool=$(git config merge.tool)
-    if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
-	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
-	    echo >&2 "Resetting to default..."
-	    unset merge_tool
-    fi
-fi
-
-if test -z "$merge_tool" ; then
-    if test -n "$DISPLAY"; then
-        if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-            merge_tool_candidates="meld kdiff3 tkdiff xxdiff tortoisemerge gvimdiff diffuse"
-        else
-            merge_tool_candidates="kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff diffuse"
-        fi
-    fi
-    if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
-    elif echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
-    else
-        merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
-    fi
-    echo "merge tool candidates: $merge_tool_candidates"
-    for i in $merge_tool_candidates; do
-        init_merge_tool_path $i
-        if type "$merge_tool_path" > /dev/null 2>&1; then
-            merge_tool=$i
-            break
-        fi
-    done
-    if test -z "$merge_tool" ; then
-	echo "No known merge resolution program available."
-	exit 1
-    fi
-else
-    if ! valid_tool "$merge_tool"; then
-        echo >&2 "Unknown merge_tool $merge_tool"
-        exit 1
-    fi
-
-    init_merge_tool_path "$merge_tool"
-
-    merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
-    merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-
-    if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
-        echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
-        exit 1
-    fi
-
-    if ! test -z "$merge_tool_cmd"; then
-        merge_tool_trust_exit_code="$(git config --bool mergetool.$merge_tool.trustExitCode || echo false)"
-    fi
-fi
+merge_tool=$(get_merge_tool "$merge_tool") || exit
+merge_tool_cmd="$(get_merge_tool_cmd "$merge_tool")"
+merge_tool_path="$(get_merge_tool_path "$merge_tool")" || exit
+merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
+merge_tool_trust_exit_code="$(git config --bool mergetool."$merge_tool".trustExitCode || echo false)"
 
 last_status=0
 rollup_status=0
-- 
1.6.2.2.414.g81aa9
