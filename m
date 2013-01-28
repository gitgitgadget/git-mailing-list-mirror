From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 3/4] mergetool--lib: Add functions for finding available tools
Date: Sun, 27 Jan 2013 16:52:25 -0800
Message-ID: <1359334346-5879-4-git-send-email-davvid@gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzcyF-00013K-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 01:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828Ab3A1Awl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 19:52:41 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46224 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740Ab3A1Awg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 19:52:36 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so450829iea.22
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UkwISxvov/DW8t1yC/lVabqE0kIN7K4rel581m/JDlI=;
        b=HA67iSdo1ltEOjAAld6pEesrTS8nuf1NGxH3Ist91sGb1TGpOdQCO/FJ2mqiqV8KXM
         XJrzRtXNoZglUfYPlQYyb9aj1mL5tUYzmqXKgTjV+6HQaX4fC1GIbaA29jEhwB48n+T/
         tcvqkpkqNkII9ezYb4kCJEEYD0Xarhj6gxDPAXzHdtP/mLYSthRRYdeSI+u7ZwAtLpcQ
         Vsw2A3lYJVzr1W9uqZkDCgA1hbWMHrFyqRH2+P6rBo8ZNEtSa1bqB1gj92LI8pjQGIwy
         UG8DGXJ1NuiRRo+1wxy51rrlM42YIiLuqxw8OXysKtHbiAYFTx0pbyDhuTbbrqrfoyG/
         QloA==
X-Received: by 10.50.190.134 with SMTP id gq6mr3829363igc.104.1359334356348;
        Sun, 27 Jan 2013 16:52:36 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ke8sm1868421igc.17.2013.01.27.16.52.34
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 16:52:35 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.g3ff16bb
In-Reply-To: <1359334346-5879-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214760>

Refactor show_tool_help() so that the tool-finding logic is broken out
into a separate show_tool_names() function.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
filter_tools renamed to show_tool_names() and simplfied
to use ls -1.  show_tool_names() now has a preamble as discussed.

 git-mergetool--lib.sh | 68 +++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index db3eb58..fe068f6 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -2,6 +2,35 @@
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
+show_tool_names () {
+	condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}
+
+	( cd "$MERGE_TOOLS_DIR" && ls -1 * ) |
+	while read toolname
+	do
+		if setup_tool "$toolname" 2>/dev/null &&
+			(eval "$condition" "$toolname")
+		then
+			if test -n "$preamble"
+			then
+				echo "$preamble"
+				preamble=
+			fi
+			printf "%s%s\n" "$per_line_prefix" "$tool"
+		fi
+	done
+}
+
 diff_mode() {
 	test "$TOOL_MODE" = diff
 }
@@ -199,35 +228,21 @@ list_merge_tool_candidates () {
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
-	cmd_name=${TOOL_MODE}tool
+	tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
+	available=$(show_tool_names 'mode_ok && is_available' '\t\t' \
+		"$tool_opt may be set to one of the following:")
+	unavailable=$(show_tool_names 'mode_ok && ! is_available' '\t\t' \
+		"The following tools are valid, but not currently available:")
 	if test -n "$available"
 	then
-		echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
-		echo "$available" | sort | sed -e 's/^/	/'
+		echo "$available"
 	else
 		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
 	fi
 	if test -n "$unavailable"
 	then
 		echo
-		echo 'The following tools are valid, but not currently available:'
-		echo "$unavailable" | sort | sed -e 's/^/	/'
+		echo "$unavailable"
 	fi
 	if test -n "$unavailable$available"
 	then
@@ -248,17 +263,12 @@ See 'git ${TOOL_MODE}tool --tool-help' or 'git help config' for more details.
 $tools
 EOF
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
1.8.0.13.g3ff16bb
