From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Verify git-commit provides a reflog message.
Date: Wed, 24 May 2006 23:33:18 -0400
Message-ID: <20060525033318.GB4403@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 05:33:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj6bM-0004Xx-2F
	for gcvg-git@gmane.org; Thu, 25 May 2006 05:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWEYDd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 23:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWEYDdZ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 23:33:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18839 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964863AbWEYDdY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 23:33:24 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fj6az-00056z-7g; Wed, 24 May 2006 23:33:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0F81620FB0C; Wed, 24 May 2006 23:33:18 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20720>

The reflog message from git-commit should include the first line
of the commit message as supplied by the user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t1400-update-ref.sh |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f6b076b..2b1f4c8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -178,22 +178,36 @@ rm -f .git/$m .git/logs/$m expect
 
 test_expect_success \
     'creating initial files' \
-    'cp ../../COPYING COPYING &&
-     git-add COPYING &&
+    'echo TEST >F &&
+     git-add F &&
+	 GIT_AUTHOR_DATE="2005-05-26 23:30" \
 	 GIT_COMMITTER_DATE="2005-05-26 23:30" git-commit -m add -a &&
-	 cp ../../Makefile COPYING &&
-	 GIT_COMMITTER_DATE="2005-05-26 23:41" git-commit -m change -a'
+	 h_TEST=$(git-rev-parse --verify HEAD)
+	 echo The other day this did not work. >M &&
+	 echo And then Bob told me how to fix it. >>M &&
+	 echo OTHER >F &&
+	 GIT_AUTHOR_DATE="2005-05-26 23:41" \
+	 GIT_COMMITTER_DATE="2005-05-26 23:41" git-commit -F m -a &&
+	 h_OTHER=$(git-rev-parse --verify HEAD)
+	 rm -f m'
+
+cat >expect <<EOF
+$Z $h_TEST $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	commit: add
+$h_TEST $h_OTHER $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000	commit: The other day this did not work.
+EOF
+test_expect_success \
+	'git-commit logged updates' \
+	'diff expect .git/logs/$m'
+unset h_TEST h_OTHER
 
 test_expect_success \
-	'git-cat-file blob master:COPYING (expect Makefile)' \
-	'git-cat-file blob master:COPYING | diff - ../../Makefile'
+	'git-cat-file blob master:F (expect OTHER)' \
+	'test OTHER = $(git-cat-file blob master:F)'
 test_expect_success \
-	'git-cat-file blob master@{2005-05-26 23:30}:COPYING (expect COPYING)' \
-	'git-cat-file blob "master@{2005-05-26 23:30}:COPYING" \
-	  | diff - ../../COPYING'
+	'git-cat-file blob master@{2005-05-26 23:30}:F (expect TEST)' \
+	'test TEST = $(git-cat-file blob "master@{2005-05-26 23:30}:F")'
 test_expect_success \
-	'git-cat-file blob master@{2005-05-26 23:42}:COPYING (expect Makefile)' \
-	'git-cat-file blob "master@{2005-05-26 23:42}:COPYING" \
-	  | diff - ../../Makefile'
+	'git-cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
+	'test OTHER = $(git-cat-file blob "master@{2005-05-26 23:42}:F")'
 
 test_done
-- 
1.3.3.g45d8
