From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool--lib: consolidate the last redundant bits in {diff,merge}tool
Date: Sat,  4 Apr 2009 20:45:18 -0700
Message-ID: <1238903118-7583-1-git-send-email-davvid@gmail.com>
Cc: markus.heidelberg@web.de, charles@hashpling.org,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 05 05:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJKS-000575-8X
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228AbZDEDpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 23:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757222AbZDEDpj
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 23:45:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:29592 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757152AbZDEDpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 23:45:38 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1308999wah.21
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ECW1ZbWcJxYLPKnD7rDUxE1QYUFUpW22049IkF09GaY=;
        b=v7qCdY7mPzQ/mylT5G7UfCwCgMm0tB/6NRHUBz8RMeqMZQn4LiUIV3TKga0twhFMty
         8r+Pb4L0NX+c1j3MWxttX/sbPvB4rsrZGNebNXRzn6Pus2R2F2iqauPA7RLiY5cBOA64
         Jc1qdAFTZtygK8IPHJus6cfR6PmJbInvQHGd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TtNOjv2Cgnf91gRrF9tRZsVp0VLsLgYFplXLvSvoxTGdEZH1rWa4pBXq8KXRp0lmRE
         rbf+ZyQYF3q0Ccw5Iovm7G/yguSC9MxQM17o8HczAs4EnGDUKFfvqVIMqUfkLdxNTB13
         pQm4x7baL6ZiZHY791v20180U4Y47q5cfDy8o=
Received: by 10.114.88.1 with SMTP id l1mr1496869wab.97.1238903134680;
        Sat, 04 Apr 2009 20:45:34 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m6sm3897254wag.14.2009.04.04.20.45.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 20:45:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115629>

This adds get_merge_tool, get_merge_tool_path, get_merge_tool_cmd
and uses them in git-mergetool and git-difftool--helper.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-mergetool--lib.txt |   22 ++++---
 git-difftool--helper.sh              |   80 ++------------------------
 git-mergetool--lib.sh                |  106 +++++++++++++++++++++++++++++++--
 git-mergetool.sh                     |   65 ++------------------
 t/t7800-difftool.sh                  |    8 +++
 5 files changed, 132 insertions(+), 149 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index ffda66b..3d57031 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -26,18 +26,22 @@ functions.  'diff' and 'merge' are valid values.
 
 FUNCTIONS
 ---------
-get_merge_tool_path::
-	returns the `merge_tool_path` for a `merge_tool`.
+get_merge_tool::
+	returns a merge tool
 
-run_mergetool::
-	launches a merge tool given the tool name and a true/false
-	flag to indicate whether a merge base is present
+get_merge_tool_cmd::
+	returns the custom command for a merge tool.
 
-valid_tool::
-	tests whether a merge tool is setup correctly.
+get_merge_tool_path::
+	returns the custom path for a merge tool.
 
-get_custom_cmd::
-	given a merge tool, returns the custom command for that tool.
+run_merge_tool::
+	launches a merge tool given the tool name and a true/false
+	flag to indicate whether a merge base is present.
+	'$merge_tool', '$merge_tool_path', and for custom commands,
+	'$merge_tool_cmd', must be defined prior to calling
+	run_merge_tool.  Additionally, '$MERGED', '$LOCAL', '$REMOTE',
+	and '$BASE' must be defined for use by the merge tool.
 
 Author
 ------
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 602cd4f..b450036 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -20,8 +20,7 @@ should_prompt () {
 	fi
 }
 
-# This function prepares temporary files and launches the appropriate
-# merge tool.
+# Sets up shell variables and runs a merge tool
 launch_merge_tool () {
 	# Merged is the filename as it appears in the work tree
 	# Local is the contents of a/filename
@@ -41,85 +40,16 @@ launch_merge_tool () {
 	fi
 
 	# Run the appropriate merge tool command
-	run_mergetool "$merge_tool";
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
-		merge_tool_path="$(get_merge_tool_path "$i")"
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
-	merge_tool_cmd=$(get_custom_cmd "$merge_tool")
-else
-	# A merge tool has been set, so verify that it's valid.
-	if ! valid_tool "$merge_tool"; then
-		echo >&2 "Unknown merge tool $merge_tool"
-		exit 1
-	fi
-
-	merge_tool_cmd=$(get_custom_cmd "$merge_tool")
-	merge_tool_path=$(git config difftool."$1".path)
-	test -z "$merge_tool_path" &&
-	merge_tool_path=$(git config mergetool."$1".path)
-	merge_tool_path="$(get_merge_tool_path "$merge_tool" \
-	                                       "$merge_tool_path")"
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
index b8566b2..dcd4516 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -7,9 +7,10 @@ merge_mode() {
 	test $TOOL_MODE = "merge"
 }
 
-get_merge_tool_path () {
-	path="$1"
-	if test -z "$2"; then
+translate_merge_tool_path () {
+	if test -n "$2"; then
+		echo "$2"
+	else
 		case "$1" in
 		emerge)
 			path=emacs
@@ -18,8 +19,8 @@ get_merge_tool_path () {
 			path="$1"
 			;;
 		esac
+		echo "$path"
 	fi
-	echo "$path"
 }
 
 check_unchanged () {
@@ -51,14 +52,14 @@ valid_tool () {
 		fi
 		;; # happy
 	*)
-		if test -z "$(get_custom_cmd "$1")"; then
+		if test -z "$(get_merge_tool_cmd "$1")"; then
 			return 1
 		fi
 		;;
 	esac
 }
 
-get_custom_cmd () {
+get_merge_tool_cmd () {
 	diff_mode &&
 	custom_cmd="$(git config difftool.$1.cmd)"
 	test -z "$custom_cmd" &&
@@ -67,7 +68,7 @@ get_custom_cmd () {
 	echo "$custom_cmd"
 }
 
-run_mergetool () {
+run_merge_tool () {
 	base_present="$2"
 	if diff_mode; then
 		base_present="false"
@@ -235,3 +236,94 @@ run_mergetool () {
 	esac
 	return $status
 }
+
+guess_merge_tool () {
+	if diff_mode; then
+		kompare="kompare"
+	fi
+	if test -n "$DISPLAY"; then
+		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
+			tools="meld kdiff3 $kompare tkdiff"
+			tools="$tools xxdiff gvimdiff diffuse"
+		else
+			tools="kdiff3 $kompare tkdiff xxdiff"
+			tools="$tools meld gvimdiff diffuse"
+		fi
+	fi
+	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
+		# $EDITOR is emacs so add emerge as a candidate
+		tools="$tools emerge opendiff vimdiff"
+	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
+		# $EDITOR is vim so add vimdiff as a candidate
+		tools="$tools vimdiff opendiff emerge"
+	else
+		tools="$tools opendiff emerge vimdiff"
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
index 298b0a1..efa31a2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -178,7 +178,7 @@ merge_file () {
     base_present &&
     present=true
 
-    if ! run_mergetool "$merge_tool" "$present"; then
+    if ! run_merge_tool "$merge_tool" "$present"; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
 
@@ -254,63 +254,12 @@ prompt_after_failed_merge() {
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
-            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff diffuse"
-        else
-            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff diffuse"
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
-        merge_tool_path="$(get_merge_tool_path "$i" "$merge_tool_path")"
-        if type "$merge_tool_path" > /dev/null 2>&1; then
-            merge_tool=$i
-            break
-        fi
-    done
-    if test -z "$merge_tool" ; then
-	echo "No known merge resolution program available."
-	exit 1
-    fi
-    merge_tool_cmd="$(git config mergetool."$merge_tool".cmd)"
-else
-    if ! valid_tool "$merge_tool"; then
-        echo >&2 "Unknown merge_tool $merge_tool"
-        exit 1
-    fi
-
-    merge_tool_cmd="$(git config mergetool.$merge_tool.cmd)"
-    merge_tool_path="$(get_merge_tool_path "$merge_tool")"
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
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 33d07e6..cbfbe87 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -200,4 +200,12 @@ test_expect_success 'difftool + mergetool config variables' '
 	restore_test_defaults
 '
 
+test_expect_success 'difftool.<tool>.path' '
+	git config difftool.tkdiff.path echo &&
+	diff=$(git difftool -y -t tkdiff branch) &&
+	git config --unset difftool.tkdiff.path &&
+	lines=$(echo "$diff" | grep file | wc -l) &&
+	test "$lines" = 1
+'
+
 test_done
-- 
1.6.2.1.469.gdffc1
