From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/4] mergetool--lib: Simplify command expressions
Date: Sun, 27 Jan 2013 16:52:23 -0800
Message-ID: <1359334346-5879-2-git-send-email-davvid@gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzcy2-0000zj-US
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 01:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab3A1Awe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 19:52:34 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57812 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab3A1Awc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 19:52:32 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so152116ieb.34
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 16:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ld+W5Mee7/Ny28ByWgIuHZK3Nsv0TNEDyTdCxSl9RK4=;
        b=jy1zx/mmgQAXmPGLUrPVDLEXd2mUiMjtoz6XWKe0/kUYUGYFPJgBEtDXCinlW3b0yi
         Aa7grUFDoPZDTviyoocKeezbWY6Ap4RPxCqEzC6Cr/1Suj971HLEmTYUSCkvTn+W8jjU
         XTiYBc0Zp1QmrK/g4CLC7O6dIrx3B9RDvlBJn/Ofoshct/78qvW+2DXxqskWoxkxBsRh
         EUx+qT06TqItavI3TAHg86exbsSu9JRiYqacoihh9W7FeQzKwOzP/MpCDKL19waPhu4t
         tIIcUKmtm16he+BaelMcm3qNjyCJ9ZR+Mdv1zY9SZ1wFxpXNbh/78Mk9kzSl051jX6jD
         7GVA==
X-Received: by 10.50.88.226 with SMTP id bj2mr3408568igb.105.1359334352310;
        Sun, 27 Jan 2013 16:52:32 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ke8sm1868421igc.17.2013.01.27.16.52.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 16:52:31 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.g3ff16bb
In-Reply-To: <1359334346-5879-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214759>

Update variable assignments to always use $(command "$arg")
in their RHS instead of "$(command "$arg")" as the latter
is harder to read.  Make get_merge_tool_cmd() simpler by
avoiding "echo" and $(command) substitutions completely.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
I reworded the commit message to be more clear.

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
1.8.0.13.g3ff16bb
