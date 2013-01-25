From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/7] git-mergetool: move show_tool_help to mergetool--lib
Date: Fri, 25 Jan 2013 01:43:48 -0800
Message-ID: <1359107034-14606-2-git-send-email-davvid@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:45:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfqN-0008GQ-BD
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab3AYJon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:44:43 -0500
Received: from mail-ia0-f173.google.com ([209.85.210.173]:40494 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3AYJoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:44:05 -0500
Received: by mail-ia0-f173.google.com with SMTP id l29so285542iag.32
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kUoZWYWpNkcihpIXQTDKhIkNyghzOpO0OhIHTBNi9j4=;
        b=upOnuJRAqaRl8rHefMs9HybVSfgCEFF2iWUw23l1VobJW21VfRQLDoxDgHXpETo2qf
         yWJRL7lEg+llqnwAyBLorsYJVqt2DKxGEdxIWfD2p9foGOE/gOpqILrHC5Ggej6o75Qb
         wKsyl6i0J4KGt0JNXfUDBoYta5lXbaAPolqwNgGJ5VDfKjnSzX7JS88G5qhja3W93EeV
         eJUmVzgYHbfM5X4swYfBBknsKuxjNBIacy8KShGcJjS/6pqpTGAFGbKzyAbFafFgT9iw
         giwxMgfhkpOgL9dlvrjYDVYJW1WV+XYrgy+VsiYhpjyZ8UaNElDYWlY2NtPBXVgpqPnq
         +g3g==
X-Received: by 10.50.171.104 with SMTP id at8mr1142591igc.1.1359107045258;
        Fri, 25 Jan 2013 01:44:05 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
In-Reply-To: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214532>

From: John Keeping <john@keeping.me.uk>

This is the first step in unifying "git difftool --tool-help" and
"git mergetool --tool-help".

Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: David Aguilar <davvid@gmail.com>
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
1.8.1.1.367.g22b1720.dirty
