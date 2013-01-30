From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 1/4] mergetool--lib: simplify command expressions
Date: Tue, 29 Jan 2013 22:20:54 -0800
Message-ID: <1359526854-25132-1-git-send-email-davvid@gmail.com>
References: <7vip6foc9m.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:21:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0R2y-0000ME-5m
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 07:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab3A3GVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 01:21:01 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39858 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3A3GVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 01:21:00 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so1046081ieb.29
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pBMm96H8vWBygGYsulV8fxGpnWC4c8/B04g6u5kMlS0=;
        b=MLInY17UKvOpQ+GvHwIX3iU9JztUArCULLQ9Cw1L7zVIZK+9AyTrPK39yvXb5WSyr/
         31EvhsHEspoxNiDDh/pbmueDhgzBf0jBzulsAlnXyUcE7ogvujzEK64624gcVGXQaE0R
         hylprNBlwS222hhaHqzDVgW/VnmE6nUXFscFZxEUz/IxxvDq2nQ12tn7YOr0vbbE6RdD
         yW5XOAhDK9PxXSPk+mgADrvdTZpfY/VYwUo7l6tgXIfH1Kn8KQZkcYpp70Q+NJNVE+T+
         PcZ0f4LbMVmiIJA/teKvIHBqf46mhu7YrolGKemD7BR3FmEL6HtWGxy/xMj420QUxfY8
         jdwA==
X-Received: by 10.42.126.70 with SMTP id d6mr2383552ics.14.1359526859728;
        Tue, 29 Jan 2013 22:20:59 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id k5sm645828igq.9.2013.01.29.22.20.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 22:20:58 -0800 (PST)
X-Mailer: git-send-email 1.8.0.9.g3370a50
In-Reply-To: <7vip6foc9m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214994>

Update variable assignments to always use $(command "$arg")
in their RHS instead of "$(command "$arg")" as the latter
is harder to read.  Make get_merge_tool_cmd() simpler by
avoiding "echo" and $(command) substitutions completely.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is a replacement patch for what's currently in pu to
fix the empty "test -z" expression.

 git-mergetool--lib.sh | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1d0fb12..1ff6d38 100644
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
@@ -300,9 +292,11 @@ get_merge_tool_path () {
 	fi
 	if test -z "$merge_tool_path"
 	then
-		merge_tool_path="$(translate_merge_tool_path "$merge_tool")"
+		merge_tool_path=$(translate_merge_tool_path "$merge_tool")
 	fi
-	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
+
+	merge_tool_cmd=$(get_merge_tool_cmd "$merge_tool")
+	if test -z "$merge_tool_cmd" &&
 		! type "$merge_tool_path" >/dev/null 2>&1
 	then
 		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as"\
@@ -314,11 +308,11 @@ get_merge_tool_path () {
 
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
1.8.0.9.g3370a50
