From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/4] mergetool--lib: Simplify command expressions
Date: Sun, 27 Jan 2013 13:24:43 -0800
Message-ID: <1359321886-80523-2-git-send-email-davvid@gmail.com>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZj6-0004lG-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 22:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445Ab3A0VYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 16:24:54 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:62644 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab3A0VYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 16:24:52 -0500
Received: by mail-ie0-f169.google.com with SMTP id c14so674851ieb.28
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 13:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bKHqbmS9ix1Wfm6xJnGQQZXybf7x88RcThWC64pJ1CU=;
        b=kmAWXzM3DSUJLLKiAYLWy2SbN0k9HtljIF9x3ylLuxjxQK3ukXgNzbMAzGBRtdBf9R
         hdSdSXGzL1QV8mWkQOvKTwDIUcmdwpQFl2qUXp5o9RPgWGAbLi3plhyyFlH5t7NP2aCh
         oBt2ZHLDsTdSuNO72TPajXvBqeKni7uwc3ygxIs08QtlaoVx6NreoWBPcbLdBk0qLASt
         QIZZgrO63K8NjTXTPThAg2jmkDPiDsDMsBNoEZ/TYEfBAxQ7i2iE5PN3KbgWemQDK2ql
         orB0PTrno7XyL4GD1yZFJrxTwawTTuoY4arAWlCDrfRsRVduoEc98fptlfPPL0qJO5HZ
         lxxw==
X-Received: by 10.50.157.130 with SMTP id wm2mr3686111igb.1.1359321892343;
        Sun, 27 Jan 2013 13:24:52 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id mj6sm4503782igc.9.2013.01.27.13.24.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 13:24:51 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.gf25ae33
In-Reply-To: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214734>

Use $(command "$arg") instead of "$(command "$arg")" as the latter is
harder to read.  Make the expression in get_merge_tool_cmd() even
simpler by avoiding "echo" completely.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1d0fb12..9a5aae9 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -32,17 +32,10 @@ check_unchanged () {
 	fi
 }
 
-valid_tool_config () {
-	if test -n "$(get_merge_tool_cmd "$1")"
-	then
-		return 0
-	else
-		return 1
-	fi
-}
-
 valid_tool () {
-	setup_tool "$1" || valid_tool_config "$1"
+	setup_tool "$1" && return 0
+	cmd=$(get_merge_tool_cmd "$1")
+	test -n "$cmd"
 }
 
 setup_tool () {
@@ -96,14 +89,13 @@ setup_tool () {
 }
 
 get_merge_tool_cmd () {
-	# Prints the custom command for a merge tool
 	merge_tool="$1"
 	if diff_mode
 	then
-		echo "$(git config difftool.$merge_tool.cmd ||
-			git config mergetool.$merge_tool.cmd)"
+		git config "difftool.$merge_tool.cmd" ||
+		git config "mergetool.$merge_tool.cmd"
 	else
-		echo "$(git config mergetool.$merge_tool.cmd)"
+		git config "mergetool.$merge_tool.cmd"
 	fi
 }
 
@@ -114,7 +106,7 @@ run_merge_tool () {
 	GIT_PREFIX=${GIT_PREFIX:-.}
 	export GIT_PREFIX
 
-	merge_tool_path="$(get_merge_tool_path "$1")" || exit
+	merge_tool_path=$(get_merge_tool_path "$1") || exit
 	base_present="$2"
 	status=0
 
@@ -145,7 +137,7 @@ run_merge_tool () {
 
 # Run a either a configured or built-in diff tool
 run_diff_cmd () {
-	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
+	merge_tool_cmd=$(get_merge_tool_cmd "$1")
 	if test -n "$merge_tool_cmd"
 	then
 		( eval $merge_tool_cmd )
@@ -158,11 +150,11 @@ run_diff_cmd () {
 
 # Run a either a configured or built-in merge tool
 run_merge_cmd () {
-	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
+	merge_tool_cmd=$(get_merge_tool_cmd "$1")
 	if test -n "$merge_tool_cmd"
 	then
-		trust_exit_code="$(git config --bool \
-			mergetool."$1".trustExitCode || echo false)"
+		trust_exit_code=$(git config --bool \
+			"mergetool.$1.trustExitCode" || echo false)
 		if test "$trust_exit_code" = "false"
 		then
 			touch "$BACKUP"
@@ -253,7 +245,7 @@ guess_merge_tool () {
 	# Loop over each candidate and stop when a valid merge tool is found.
 	for i in $tools
 	do
-		merge_tool_path="$(translate_merge_tool_path "$i")"
+		merge_tool_path=$(translate_merge_tool_path "$i")
 		if type "$merge_tool_path" >/dev/null 2>&1
 		then
 			echo "$i"
@@ -300,9 +292,9 @@ get_merge_tool_path () {
 	fi
 	if test -z "$merge_tool_path"
 	then
-		merge_tool_path="$(translate_merge_tool_path "$merge_tool")"
+		merge_tool_path=$(translate_merge_tool_path "$merge_tool")
 	fi
-	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
+	if test -z $(get_merge_tool_cmd "$merge_tool") &&
 		! type "$merge_tool_path" >/dev/null 2>&1
 	then
 		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as"\
@@ -314,11 +306,11 @@ get_merge_tool_path () {
 
 get_merge_tool () {
 	# Check if a merge tool has been configured
-	merge_tool="$(get_configured_merge_tool)"
+	merge_tool=$(get_configured_merge_tool)
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
-		merge_tool="$(guess_merge_tool)" || exit
+		merge_tool=$(guess_merge_tool) || exit
 	fi
 	echo "$merge_tool"
 }
-- 
1.8.0.13.gf25ae33
