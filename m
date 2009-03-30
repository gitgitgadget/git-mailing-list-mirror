From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 6/8] sh-tools: add a run_merge_tool function
Date: Sun, 29 Mar 2009 22:03:46 -0700
Message-ID: <1238389428-69328-7-git-send-email-davvid@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
 <1238389428-69328-3-git-send-email-davvid@gmail.com>
 <1238389428-69328-4-git-send-email-davvid@gmail.com>
 <1238389428-69328-5-git-send-email-davvid@gmail.com>
 <1238389428-69328-6-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9hA-0004he-FH
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbZC3FE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbZC3FEY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:04:24 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39536 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbZC3FEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:04:22 -0400
Received: by mail-qy0-f118.google.com with SMTP id 16so3307690qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LUkxyPGhwZxgfQ50sMfWbffU7rmz+AdsYmDemYvWjy8=;
        b=MHIewe1yPSlx5JJFUrm0CU7laU5aW3XFFrwT4vHF9tvtvdIns4BQIeWclWtQpelyAo
         mlgaIaGdtWQacrNQE2YldTcXDa8haezJ7yaiYlK8NLPqH5F0XRWoBVL83o6H+HufMOuc
         jKYpiq4hdhz7d9AfVV4to1/A7CfhnHIPDe8zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y+e6QD+DPVtThTnDqXzx+ve65caJ/uvQeDNTNz962rVEf4ZMUJJayw61oRuQ4prG+c
         KG5ZrwCrE5QRSmRvJYout0gpU/ct+26AYMSfiRf42K3F3LzmK7A93txbd8AbhUY3JPMC
         g909M7Phm/9ROB5kP9JZT5KzSg6zgodNcGJoU=
Received: by 10.224.2.65 with SMTP id 1mr5568836qai.255.1238389460719;
        Sun, 29 Mar 2009 22:04:20 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm5385983qwd.8.2009.03.29.22.04.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:04:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.404.gb0085
In-Reply-To: <1238389428-69328-6-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115072>

This function launches merge tools and will be used to refactor
git-(diff|merge)tool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-sh-tools.txt |    3 +
 git-sh-tools.sh                |  147 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 142 insertions(+), 8 deletions(-)

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
index 234bac7..5c7bd18 100644
--- a/git-sh-tools.sh
+++ b/git-sh-tools.sh
@@ -12,29 +12,34 @@ valid_tool() {
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
@@ -48,3 +53,129 @@ init_merge_tool_path() {
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
+			base=Baes
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
1.6.1.3
