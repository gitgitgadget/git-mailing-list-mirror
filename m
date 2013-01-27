From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/4] mergetool--lib: Add functions for finding available tools
Date: Sun, 27 Jan 2013 13:24:45 -0800
Message-ID: <1359321886-80523-4-git-send-email-davvid@gmail.com>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZjB-0004mz-Gx
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 22:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab3A0VY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 16:24:59 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48995 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab3A0VY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 16:24:56 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so518549ieb.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nP0R03UW3/k9jrm4QngmHzmkrcrkdmhAtm4EpA+8KGk=;
        b=eOCF4VjxGbdU2rkr/+3liyBH4f+NOIf1XaD27VNMXe7DS4zQeTP/VCrU60ERejpl+2
         dwFbr9XmnCxGCuYlB6ZkHh81ztASav655pefHv3qjTHs+DOUqOQq8OivukN+T6nCEq8L
         9BCdJw+wk5qltqXVbcy1xA5UN9pgdC1SYLNAo23CtRjyVMGtFsLjP+E9KsHcW79e3WjP
         Z+XdGttGbQtjv4UjnmXDBT3nkNpGTBwXjN2cIWwE45lEVJLNjpKGYJFrsyxcr0w6izAN
         KaYvqWu31IGpP7iT9Z6LMYxNmWC2hFyodeH+mNW5tBVenLs6+Awo5j5b0cX+V/Ylhqyj
         dhhA==
X-Received: by 10.42.95.146 with SMTP id f18mr7708327icn.9.1359321896232;
        Sun, 27 Jan 2013 13:24:56 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id mj6sm4503782igc.9.2013.01.27.13.24.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 13:24:55 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.gf25ae33
In-Reply-To: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214737>

Refactor show_tool_help() so that the tool-finding logic is broken out
into separate functions.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 60 +++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index cf52423..894b849 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -2,6 +2,33 @@
 # git-mergetool--lib is a library for common merge tool functions
 MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
 
+mode_ok () {
+	diff_mode && can_diff ||
+	merge_mode && can_merge
+}
+
+is_available () {
+	merge_tool_path=$(translate_merge_tool_path "$1") &&
+	type "$merge_tool_path" >/dev/null 2>&1
+}
+
+filter_tools () {
+	filter="$1"
+	prefix="$2"
+	(
+		cd "$MERGE_TOOLS_DIR" &&
+		for i in *
+		do
+			echo "$i"
+		done
+	) | sort | while read tool
+	do
+		setup_tool "$tool" 2>/dev/null &&
+		(eval "$filter" "$tool") &&
+		printf "$prefix$tool\n"
+	done
+}
+
 diff_mode() {
 	test "$TOOL_MODE" = diff
 }
@@ -199,27 +226,13 @@ list_merge_tool_candidates () {
 }
 
 show_tool_help () {
-	unavailable= available= LF='
-'
-	for i in "$MERGE_TOOLS_DIR"/*
-	do
-		tool=$(basename "$i")
-		setup_tool "$tool" 2>/dev/null || continue
-
-		merge_tool_path=$(translate_merge_tool_path "$tool")
-		if type "$merge_tool_path" >/dev/null 2>&1
-		then
-			available="$available$tool$LF"
-		else
-			unavailable="$unavailable$tool$LF"
-		fi
-	done
-
 	cmd_name=${TOOL_MODE}tool
+	available=$(filter_tools 'mode_ok && is_available' '\t\t')
+	unavailable=$(filter_tools 'mode_ok && ! is_available' '\t\t')
 	if test -n "$available"
 	then
 		echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
-		echo "$available" | sort | sed -e 's/^/	/'
+		printf "$available"
 	else
 		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
 	fi
@@ -227,7 +240,7 @@ show_tool_help () {
 	then
 		echo
 		echo 'The following tools are valid, but not currently available:'
-		echo "$unavailable" | sort | sed -e 's/^/	/'
+		printf "$unavailable"
 	fi
 	if test -n "$unavailable$available"
 	then
@@ -250,17 +263,12 @@ $tools
 	printf "$msg" >&2
 
 	# Loop over each candidate and stop when a valid merge tool is found.
-	for i in $tools
+	for tool in $tools
 	do
-		merge_tool_path=$(translate_merge_tool_path "$i")
-		if type "$merge_tool_path" >/dev/null 2>&1
-		then
-			echo "$i"
-			return 0
-		fi
+		is_available "$tool" && echo "$tool" && return 0
 	done
 
-	echo >&2 "No known merge resolution program available."
+	echo >&2 "No known ${TOOL_MODE} tool is available."
 	return 1
 }
 
-- 
1.8.0.13.gf25ae33
