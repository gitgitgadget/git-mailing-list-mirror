From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Improve bash prompt to detect various states like an unfinished merge
Date: Sun, 30 Sep 2007 02:20:45 +0200
Message-ID: <1191111645134-git-send-email-robin.rosenberg@dewire.com>
References: <20070904071301.GA18160@spearce.org>
Cc: git@vger.kernel.org, johannes.sixt@telecom.at, spearce@spearce.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 30 02:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbmWD-000190-Du
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 02:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbXI3ASh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 20:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbXI3ASh
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 20:18:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17742 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbXI3ASg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 20:18:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7A09680286A;
	Sun, 30 Sep 2007 02:10:15 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08187-07; Sun, 30 Sep 2007 02:10:14 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 6591980265E;
	Sun, 30 Sep 2007 02:10:14 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 60F6228DCD; Sun, 30 Sep 2007 02:20:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1.g80926
In-Reply-To: <20070904071301.GA18160@spearce.org>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59515>

This patch makes the git prompt (when enabled) show if a merge or a
rebase is unfinished. It also detects if a bisect is being done as
well as detached checkouts.

An uncompleted git-am cannot be distinguised from a rebase (the
non-interactive version). Instead of having an even longer prompt
we simply ignore that and hope the power users that use git-am knows
the difference.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 contrib/completion/git-completion.bash |   37 ++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 4 deletions(-)

This includes Shawns improvements

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e760930..6854074 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,12 +64,41 @@ __gitdir ()
 
 __git_ps1 ()
 {
-	local b="$(git symbolic-ref HEAD 2>/dev/null)"
-	if [ -n "$b" ]; then
+	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	if [ -n "$g" ]; then
+		local r
+		local b
+		if [ -d "$g/../.dotest" ]
+		then
+			r="|AM/REBASE"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		elif [ -f "$g/.dotest-merge/interactive" ]
+		then
+			r="|REBASE-i"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -d "$g/.dotest-merge" ]
+		then
+			r="|REBASE-m"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -f "$g/MERGE_HEAD" ]
+		then
+			r="|MERGING"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		else
+			if [ -f $g/BISECT_LOG ]
+			then
+				r="|BISECTING"
+			fi
+			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
+			then
+				b="$(cut -c1-7 $g/HEAD)..."
+			fi
+		fi
+
 		if [ -n "$1" ]; then
-			printf "$1" "${b##refs/heads/}"
+			printf "$1" "${b##refs/heads/}$r"
 		else
-			printf " (%s)" "${b##refs/heads/}"
+			printf " (%s)" "${b##refs/heads/}$r"
 		fi
 	fi
 }
-- 
1.5.3.1.g80926
