From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sat,  1 Sep 2007 12:22:37 +0200
Message-ID: <11886421573285-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Sep 01 13:25:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRR5y-00042h-9T
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 13:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbXIALYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 07:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbXIALYt
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 07:24:49 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4974 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbXIALYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 07:24:48 -0400
X-Greylist: delayed 1988 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Sep 2007 07:24:48 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 15F1D802849;
	Sat,  1 Sep 2007 12:43:48 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16989-03; Sat,  1 Sep 2007 12:43:24 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6BB2380264D;
	Sat,  1 Sep 2007 12:43:24 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 45AD4293CF; Sat,  1 Sep 2007 12:22:38 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc7.844.gfd3c5
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57271>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 contrib/completion/git-completion.bash |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5ed1821..1fef857 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,12 +64,34 @@ __gitdir ()
 
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
+			local b="$(git symbolic-ref HEAD 2>/dev/null)"
+			r="|REBASEING"
+		else
+			if [ -d "$g/.dotest-merge" ]
+			then
+				r="|REBASING"
+				b="$(cat $g/.dotest-merge/head-name)"
+			else
+				if [ -f "$g/MERGE_HEAD" ]
+				then
+					r="|MERGING"
+					b="$(git symbolic-ref HEAD 2>/dev/null)"
+				else
+					b="$(git symbolic-ref HEAD 2>/dev/null)"
+				fi
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
1.5.3.rc7.844.gfd3c5
