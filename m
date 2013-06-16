From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] mergetool--lib: refactor {diff,merge}_cmd logic
Date: Sun, 16 Jun 2013 18:51:22 +0100
Message-ID: <828585499e535649d14ef0ecd0f53403aefb10c2.1371405056.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 19:51:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoH78-0003xO-IZ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab3FPRvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 13:51:38 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:40874 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab3FPRvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 13:51:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7408ECDA599;
	Sun, 16 Jun 2013 18:51:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0XoCT--lx5A8; Sun, 16 Jun 2013 18:51:35 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 0DCC6CDA48A;
	Sun, 16 Jun 2013 18:51:29 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228021>

Instead of needing a wrapper to call the diff/merge command, simply
provide the diff_cmd and merge_cmd functions for user-specified tools in
the same way as we do for built-in tools.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 82 ++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 47 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index e338be5..6a72106 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -114,6 +114,33 @@ valid_tool () {
 	test -n "$cmd"
 }
 
+setup_user_tool () {
+	merge_tool_cmd=$(get_merge_tool_cmd "$tool")
+	test -n "$merge_tool_cmd" || return 1
+
+	diff_cmd () {
+		( eval $merge_tool_cmd )
+		status=$?
+		return $status
+	}
+
+	merge_cmd () {
+		trust_exit_code=$(git config --bool \
+			"mergetool.$1.trustExitCode" || echo false)
+		if test "$trust_exit_code" = "false"
+		then
+			touch "$BACKUP"
+			( eval $merge_tool_cmd )
+			status=$?
+			check_unchanged
+		else
+			( eval $merge_tool_cmd )
+			status=$?
+		fi
+		return $status
+	}
+}
+
 setup_tool () {
 	tool="$1"
 
@@ -142,15 +169,15 @@ setup_tool () {
 
 	if ! test -f "$MERGE_TOOLS_DIR/$tool"
 	then
-		# Use a special return code for this case since we want to
-		# source "defaults" even when an explicit tool path is
-		# configured since the user can use that to override the
-		# default path in the scriptlet.
-		return 2
+		setup_user_tool
+		return $?
 	fi
 
 	# Load the redefined functions
 	. "$MERGE_TOOLS_DIR/$tool"
+	# Now let the user override the default command for the tool.  If
+	# they have not done so then this will return 1 which we ignore.
+	setup_user_tool
 
 	if merge_mode && ! can_merge
 	then
@@ -187,20 +214,7 @@ run_merge_tool () {
 	status=0
 
 	# Bring tool-specific functions into scope
-	setup_tool "$1"
-	exitcode=$?
-	case $exitcode in
-	0)
-		:
-		;;
-	2)
-		# The configured tool is not a built-in tool.
-		test -n "$merge_tool_path" || return 1
-		;;
-	*)
-		return $exitcode
-		;;
-	esac
+	setup_tool "$1" || return 1
 
 	if merge_mode
 	then
@@ -213,38 +227,12 @@ run_merge_tool () {
 
 # Run a either a configured or built-in diff tool
 run_diff_cmd () {
-	merge_tool_cmd=$(get_merge_tool_cmd "$1")
-	if test -n "$merge_tool_cmd"
-	then
-		( eval $merge_tool_cmd )
-		status=$?
-		return $status
-	else
-		diff_cmd "$1"
-	fi
+	diff_cmd "$1"
 }
 
 # Run a either a configured or built-in merge tool
 run_merge_cmd () {
-	merge_tool_cmd=$(get_merge_tool_cmd "$1")
-	if test -n "$merge_tool_cmd"
-	then
-		trust_exit_code=$(git config --bool \
-			"mergetool.$1.trustExitCode" || echo false)
-		if test "$trust_exit_code" = "false"
-		then
-			touch "$BACKUP"
-			( eval $merge_tool_cmd )
-			status=$?
-			check_unchanged
-		else
-			( eval $merge_tool_cmd )
-			status=$?
-		fi
-		return $status
-	else
-		merge_cmd "$1"
-	fi
+	merge_cmd "$1"
 }
 
 list_merge_tool_candidates () {
-- 
1.8.3.779.g691e267
