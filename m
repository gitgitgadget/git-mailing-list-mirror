From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 6/8 v2] sh-tools: add a run_merge_tool function
Date: Mon, 30 Mar 2009 01:11:24 -0700
Message-ID: <1238400684-14881-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 10:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCbc-0001y7-SX
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbZC3IKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 04:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbZC3IKr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:10:47 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:43415 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZC3IKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 04:10:46 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2394018qwh.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KyXeFqx30GL/vOBvgqCcPhxH+WXM57cmEwEB+nJnUTE=;
        b=Qy2pOf9LxE7lMBxPPbPxdV/FS85LB9ZoDDKaz4GXD/v90kABunsT3OBOOzX697J9HB
         OpKN4u7myyFJ+cemwNlMyuePPbMkYj6eznfwY/NJ+Pw8wHi1Yc3X+kLtixOwpy3TzAxZ
         Fv/R+FSUfm/6UCZ3KKEQm2IVH/OfjvuP1Pejk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CqdBiHCjX85zaWWLOHfQmoZ2i3H7zPnQbvRQjs9tVZ4C6bdPiksWzqy7tLeK/Y/UpW
         tmUnirLxDSdlwGJWqrIAT5IshoDJ7t9Sq2tp82DUl1vGXueWuPkhYHvbwmW7R8azkA3p
         MPyRnsBEmYBx24hJ36b8nZzlC+sqAK9Y/aKRA=
Received: by 10.224.54.12 with SMTP id o12mr5720212qag.269.1238400644176;
        Mon, 30 Mar 2009 01:10:44 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm5524916qwf.10.2009.03.30.01.10.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 01:10:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115103>

This function launches merge tools and will be used to refactor
git-(diff|merge)tool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This fixes the problems spotted by Markus.

 Documentation/git-sh-tools.txt |    3 +
 git-sh-tools.sh                |  160 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 154 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-sh-tools.txt b/Documentation/git-sh-tools.txt
index 055a10c..68d1b37 100644
--- a/Documentation/git-sh-tools.txt
+++ b/Documentation/git-sh-tools.txt
@@ -36,6 +36,9 @@ init_merge_tool_path::
 	sets up `$merge_tool_path` according to '(diff|merge)tool.<tool>.path'
 	configurations.
 
+run_merge_tool::
+	runs the specified merge tool.
+
 Author
 ------
 Written by David Aguilar <davvid@gmail.com>
diff --git a/git-sh-tools.sh b/git-sh-tools.sh
index 234bac7..e8593fc 100644
--- a/git-sh-tools.sh
+++ b/git-sh-tools.sh
@@ -2,7 +2,12 @@
 # Built-in merge tools are always valid.
 valid_tool() {
 	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+	kompare)
+		if mergetool_mode; then
+			return 1
+		fi
+		;; # happy
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
 		;; # happy
 	*)
 		if ! valid_custom_tool "$1"; then
@@ -12,29 +17,34 @@ valid_tool() {
 	esac
 }
 
+# Test whether we're in merge mode
+mergetool_mode()
+{
+	test "$TOOL_MODE" = "merge"
+}
+
 # Verifies that (difftool|mergetool).<tool>.cmd exists
 # Requires $TOOL_MODE to be set.
 valid_custom_tool() {
-	if test "$TOOL_MODE" = "diff"; then
-		merge_tool_cmd="$(git config difftool.$1.cmd)"
-		test -z "$merge_tool_cmd" &&
+	if mergetool_mode; then
 		merge_tool_cmd="$(git config mergetool.$1.cmd)"
 		test -n "$merge_tool_cmd"
-	elif test "$TOOL_MODE" = "merge"; then
+	else
+		merge_tool_cmd="$(git config difftool.$1.cmd)"
+		test -z "$merge_tool_cmd" &&
 		merge_tool_cmd="$(git config mergetool.$1.cmd)"
 		test -n "$merge_tool_cmd"
 	fi
 }
 
-
 # Set up $merge_tool_path for (diff|merge)tool.<tool>.path configurations
 init_merge_tool_path() {
-	if test "$TOOL_MODE" = "diff"; then
+	if mergetool_mode; then
+		merge_tool_path=$(git config mergetool."$1".path)
+	else
 		merge_tool_path=$(git config difftool."$1".path)
 		test -z "$merge_tool_path" &&
 		merge_tool_path=$(git config mergetool."$1".path)
-	elif test "$TOOL_MODE" = "merge"; then
-		merge_tool_path=$(git config mergetool."$1".path)
 	fi
 
 	if test -z "$merge_tool_path" ; then
@@ -48,3 +58,135 @@ init_merge_tool_path() {
 		esac
 	fi
 }
+
+# Runs a side-by-side merge tool
+run_merge_tool()
+{
+	merge_tool="$1"
+
+	# base_present is always false when !mergetool_mode
+	case "$merge_tool" in
+	kdiff3)
+		if mergetool_mode; then
+			base=Base
+			local=Local
+			remote=Remote
+		else
+			base=A
+			local=A
+			remote=B
+		fi
+		if base_present; then
+			("$merge_tool_path" --auto \
+				--L1 "$MERGED ($base)" \
+				--L2 "$MERGED ($local)" \
+				--L3 "$MERGED ($remote)" \
+				-o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" \
+			 > /dev/null 2>&1)
+		else
+			("$merge_tool_path" --auto \
+				--L1 "$MERGED ($local)" \
+				--L2 "$MERGED ($remote)" \
+				-o "$MERGED" "$LOCAL" "$REMOTE" \
+			 > /dev/null 2>&1)
+		fi
+		status=$?
+		;;
+
+	kompare)
+		"$merge_tool_path" "$LOCAL" "$REMOTE"
+		status=$?
+		;;
+
+	tkdiff)
+		if base_present; then
+			"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
+		else
+			"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
+		fi
+		status=$?
+		;;
+	meld)
+		mergetool_mode && touch "$BACKUP"
+		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		mergetool_mode && check_unchanged
+		;;
+	vimdiff)
+		mergetool_mode && touch "$BACKUP"
+		"$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+		mergetool_mode && check_unchanged
+		;;
+	gvimdiff)
+		mergetool_mode && touch "$BACKUP"
+		"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
+		mergetool_mode && check_unchanged
+		;;
+	xxdiff)
+		if mergetool_mode; then
+			touch "$BACKUP"
+			xtra_args='--show-merged-pane'
+		else
+			xtra_args=
+		fi
+		if base_present; then
+			"$merge_tool_path" -X $xtra_args \
+				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				--merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+		else
+			"$merge_tool_path" -X $xtra_args \
+				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				--merged-file "$MERGED" "$LOCAL" "$REMOTE"
+		fi
+		mergetool_mode && check_unchanged
+		;;
+	opendiff)
+		mergetool_mode && touch "$BACKUP"
+		if base_present; then
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				-ancestor "$BASE" -merge "$MERGED" | cat
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				-merge "$MERGED" | cat
+		fi
+		mergetool_mode && check_unchanged
+		;;
+	ecmerge)
+		mergetool_mode && touch "$BACKUP"
+		if base_present; then
+			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+				--default --mode=merge3 --to="$MERGED"
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				--default --mode=merge2 --to="$MERGED"
+		fi
+		mergetool_mode && check_unchanged
+		;;
+	emerge)
+		if base_present ; then
+			"$merge_tool_path" -f emerge-files-with-ancestor-command \
+				"$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
+		else
+			"$merge_tool_path" -f emerge-files-command \
+				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
+		fi
+		status=$?
+		;;
+	*)
+		if test -n "$merge_tool_cmd"; then
+			if test "$merge_tool_trust_exit_code" = "false"; then
+				mergetool_mode && touch "$BACKUP"
+				( eval $merge_tool_cmd )
+				mergetool_mode && check_unchanged
+			else
+				( eval $merge_tool_cmd )
+				status=$?
+			fi
+		fi
+		;;
+	esac
+	return $status
+}
-- 
1.6.2.1.303.g63699
