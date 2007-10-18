From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2 v3] mergetool: use path to mergetool in config var mergetool.<tool>.path
Date: Thu, 18 Oct 2007 04:00:49 -0400
Message-ID: <20071018080049.GK14735@spearce.org>
References: <11926413722362-git-send-email-prohaska@zib.de> <11926413723666-git-send-email-prohaska@zib.de> <20071018052724.GA27813@spearce.org> <923DDB10-C9E9-4797-9FC1-D31DEEBE75B7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiQJW-0002Pq-CG
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 10:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbXJRIAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 04:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759466AbXJRIAy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 04:00:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55638 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbXJRIAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 04:00:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiQJC-0001fF-9W; Thu, 18 Oct 2007 04:00:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AED3E20FBAE; Thu, 18 Oct 2007 04:00:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <923DDB10-C9E9-4797-9FC1-D31DEEBE75B7@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61502>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Oct 18, 2007, at 7:27 AM, Shawn O. Pearce wrote:
> >...
> >>+    test -n "$merge_tool" || valid_tool "$merge_tool" || {
> >
> >Wouldn't an empty $merge_tool string be caught above in the
> >valid_tool function where it falls through and returns 1?
> >So isn't test -n here redundant?
> 
> Sharp eyes, thanks.
> 
> Correct is
> 
> test -z "$merge_tool" || valid_tool "$merge_tool" || {
> 
> No merge tool or a valid merge tool is allowed at this place.
> If the tool's already empty there's no need to tell the user
> that it will be reset to empty.
> 
> I'll send a v4 version.

Thanks but its a little late.  I'm about to push maint/master/next/pu
and this series is in next.  While testing it I found another
bug related to init_tool_merge_tool_path() not having $merge_tool
initialized and thus causing it to never select a default tool if
the user didn't have one configured.

Here's what I'm actually about to push out:

--8>--
From e3fa2c761fdc490494e8e0855bcee4d7e58ada6a Mon Sep 17 00:00:00 2001
From: Steffen Prohaska <prohaska@zib.de>
Date: Wed, 17 Oct 2007 19:16:11 +0200
Subject: [PATCH] mergetool: use path to mergetool in config var mergetool.<tool>.path

This commit adds a mechanism to provide absolute paths to the
external programs called by 'git mergetool'. A path can be
specified in the configuation variable mergetool.<tool>.path.
The configuration variable is similar to how we name branches
and remotes. It is extensible if we need to specify more details
about a tool.

The mechanism is especially useful on Windows, where external
programs are unlikely to be in PATH.

[sp: Fixed a few minor issues prior to applying]

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-mergetool.txt |    6 ++
 git-mergetool.sh                |   97 +++++++++++++++++++++-----------------
 2 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 6c32c6d..78b2f43 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -31,6 +31,12 @@ If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
 configuration variable merge.tool is not set, 'git mergetool'
 will pick a suitable default.
++
+You can explicitly provide a full path to the tool by setting the
+configuration variable mergetool.<tool>.path. For example, you
+can configure the absolute path to kdiff3 by setting
+mergetool.kdiff3.path. Otherwise, 'git mergetool' assumes the tool
+is available in PATH.
 
 Author
 ------
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9f4f313..4f89cbe 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -192,10 +192,10 @@ merge_file () {
     case "$merge_tool" in
 	kdiff3)
 	    if base_present ; then
-		(kdiff3 --auto --L1 "$path (Base)" --L2 "$path (Local)" --L3 "$path (Remote)" \
+		("$merge_tool_path" --auto --L1 "$path (Base)" --L2 "$path (Local)" --L3 "$path (Remote)" \
 		    -o "$path" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    else
-		(kdiff3 --auto --L1 "$path (Local)" --L2 "$path (Remote)" \
+		("$merge_tool_path" --auto --L1 "$path (Local)" --L2 "$path (Remote)" \
 		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
@@ -203,35 +203,35 @@ merge_file () {
 	    ;;
 	tkdiff)
 	    if base_present ; then
-		tkdiff -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
 	    else
-		tkdiff -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -o "$path" -- "$LOCAL" "$REMOTE"
 	    fi
 	    status=$?
 	    save_backup
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
-	    $merge_tool -- "$LOCAL" "$path" "$REMOTE"
+	    "$merge_tool_path" -- "$LOCAL" "$path" "$REMOTE"
 	    check_unchanged
 	    save_backup
 	    ;;
 	gvimdiff)
 		touch "$BACKUP"
-		gvimdiff -f -- "$LOCAL" "$path" "$REMOTE"
+		"$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
 		check_unchanged
 		save_backup
 		;;
 	xxdiff)
 	    touch "$BACKUP"
 	    if base_present ; then
-		xxdiff -X --show-merged-pane \
+		"$merge_tool_path" -X --show-merged-pane \
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
 		    --merged-file "$path" -- "$LOCAL" "$BASE" "$REMOTE"
 	    else
-		xxdiff -X --show-merged-pane \
+		"$merge_tool_path" -X --show-merged-pane \
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
@@ -243,18 +243,18 @@ merge_file () {
 	opendiff)
 	    touch "$BACKUP"
 	    if base_present; then
-		opendiff "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
 	    else
-		opendiff "$LOCAL" "$REMOTE" -merge "$path" | cat
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$path" | cat
 	    fi
 	    check_unchanged
 	    save_backup
 	    ;;
 	emerge)
 	    if base_present ; then
-		emacs -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$path")"
 	    else
-		emacs -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
 	    fi
 	    status=$?
 	    save_backup
@@ -297,17 +297,38 @@ do
     shift
 done
 
+valid_tool() {
+	case "$1" in
+		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff)
+			;; # happy
+		*)
+			return 1
+			;;
+	esac
+}
+
+init_merge_tool_path() {
+	merge_tool_path=`git config mergetool.$1.path`
+	if test -z "$merge_tool_path" ; then
+		case "$1" in
+			emerge)
+				merge_tool_path=emacs
+				;;
+			*)
+				merge_tool_path=$1
+				;;
+		esac
+	fi
+}
+
+
 if test -z "$merge_tool"; then
     merge_tool=`git config merge.tool`
-    case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
-	    ;; # happy
-	*)
+    if ! valid_tool "$merge_tool"; then
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
 	    echo >&2 "Resetting to default..."
 	    unset merge_tool
-	    ;;
-    esac
+    fi
 fi
 
 if test -z "$merge_tool" ; then
@@ -329,40 +350,30 @@ if test -z "$merge_tool" ; then
     merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
-        if test $i = emerge ; then
-            cmd=emacs
-        else
-            cmd=$i
-        fi
-        if type $cmd > /dev/null 2>&1; then
+        init_merge_tool_path $i
+        if type "$merge_tool_path" > /dev/null 2>&1; then
             merge_tool=$i
             break
         fi
     done
     if test -z "$merge_tool" ; then
-	echo "No available merge resolution programs available."
+	echo "No known merge resolution program available."
 	exit 1
     fi
+else
+    if ! valid_tool "$merge_tool"; then
+        echo >&2 "Unknown merge_tool $merge_tool"
+        exit 1
+    fi
+
+    init_merge_tool_path "$merge_tool"
+
+    if ! type "$merge_tool_path" > /dev/null 2>&1; then
+        echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
+        exit 1
+    fi
 fi
 
-case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff|gvimdiff|opendiff)
-	if ! type "$merge_tool" > /dev/null 2>&1; then
-	    echo "The merge tool $merge_tool is not available"
-	    exit 1
-	fi
-	;;
-    emerge)
-	if ! type "emacs" > /dev/null 2>&1; then
-	    echo "Emacs is not available"
-	    exit 1
-	fi
-	;;
-    *)
-	echo "Unknown merge tool: $merge_tool"
-	exit 1
-	;;
-esac
 
 if test $# -eq 0 ; then
 	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
-- 
1.5.3.4.1231.gac645


-- 
Shawn.
