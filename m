From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/4] git-mergetool: move show_tool_help to mergetool--lib
Date: Thu, 24 Jan 2013 19:55:13 +0000
Message-ID: <7045909ebfafde008c5f1667088d59d5f1f6c354.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 20:56:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySu6-0007Dq-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614Ab3AXTzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:55:45 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55532 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab3AXTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:55:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1E43D23100;
	Thu, 24 Jan 2013 19:55:44 +0000 (GMT)
X-Quarantine-ID: <BrkGEHuXuWz2>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrkGEHuXuWz2; Thu, 24 Jan 2013 19:55:43 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 198DF2318D;
	Thu, 24 Jan 2013 19:55:35 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1.364.gbbf604e.dirty
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214446>

This is the first step in unifying "git difftool --tool-help" and
"git mergetool --tool-help".

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 37 +++++++++++++++++++++++++++++++++++++
 git-mergetool.sh      | 37 -------------------------------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f013a03..89a857f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -174,6 +174,43 @@ list_merge_tool_candidates () {
 	esac
 }
 
+show_tool_help () {
+	TOOL_MODE=merge
+	list_merge_tool_candidates
+	unavailable= available= LF='
+'
+	for i in $tools
+	do
+		merge_tool_path=$(translate_merge_tool_path "$i")
+		if type "$merge_tool_path" >/dev/null 2>&1
+		then
+			available="$available$i$LF"
+		else
+			unavailable="$unavailable$i$LF"
+		fi
+	done
+	if test -n "$available"
+	then
+		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
+		echo "$available" | sort | sed -e 's/^/	/'
+	else
+		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
+	fi
+	if test -n "$unavailable"
+	then
+		echo
+		echo 'The following tools are valid, but not currently available:'
+		echo "$unavailable" | sort | sed -e 's/^/	/'
+	fi
+	if test -n "$unavailable$available"
+	then
+		echo
+		echo "Some of the tools listed above only work in a windowed"
+		echo "environment. If run in a terminal-only session, they will fail."
+	fi
+	exit 0
+}
+
 guess_merge_tool () {
 	list_merge_tool_candidates
 	echo >&2 "merge tool candidates: $tools"
diff --git a/git-mergetool.sh b/git-mergetool.sh
index c50e18a..c0ee9aa 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -315,43 +315,6 @@ merge_file () {
 	return 0
 }
 
-show_tool_help () {
-	TOOL_MODE=merge
-	list_merge_tool_candidates
-	unavailable= available= LF='
-'
-	for i in $tools
-	do
-		merge_tool_path=$(translate_merge_tool_path "$i")
-		if type "$merge_tool_path" >/dev/null 2>&1
-		then
-			available="$available$i$LF"
-		else
-			unavailable="$unavailable$i$LF"
-		fi
-	done
-	if test -n "$available"
-	then
-		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
-		echo "$available" | sort | sed -e 's/^/	/'
-	else
-		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
-	fi
-	if test -n "$unavailable"
-	then
-		echo
-		echo 'The following tools are valid, but not currently available:'
-		echo "$unavailable" | sort | sed -e 's/^/	/'
-	fi
-	if test -n "$unavailable$available"
-	then
-		echo
-		echo "Some of the tools listed above only work in a windowed"
-		echo "environment. If run in a terminal-only session, they will fail."
-	fi
-	exit 0
-}
-
 prompt=$(git config --bool mergetool.prompt || echo true)
 
 while test $# != 0
-- 
1.8.1
