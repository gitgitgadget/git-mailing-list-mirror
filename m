From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 2/2] git-svn: test that extra blank lines aren't inserted in commit messages.
Date: Thu, 12 Jun 2008 19:10:51 -0400
Message-ID: <1213312251-8081-2-git-send-email-apenwarr@gmail.com>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
Cc: gitster@pobox.com, Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 01:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6w4M-0003oQ-9Q
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 01:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252AbYFLXSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbYFLXSH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 19:18:07 -0400
Received: from host.239.160.mtl.cablemodem.vdn.ca ([206.223.239.160]:52907
	"EHLO insight.mtl.versabanq.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756233AbYFLXSG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 19:18:06 -0400
Received: by insight.mtl.versabanq.com (Postfix, from userid 1000)
	id 8F696E7C530; Thu, 12 Jun 2008 19:10:51 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.rc2.26.g8c37
In-Reply-To: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84811>

Improve the git-svn-author test to check that extra newlines aren't inserted
into commit messages as they take a round trip from git to svn and back.

We test both with and without the --add-author-from option to git-svn.

git-svn: test that svn repo doesn't have extra newlines.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 t/t9122-git-svn-author.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 8c58f0b..1190576 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -64,7 +64,21 @@ test_expect_success 'interact with it via git-svn' '
 
 	# Make sure --add-author-from with --use-log-author affected
 	# the authorship information
-	grep "^Author: A U Thor " actual.4
+	grep "^Author: A U Thor " actual.4 &&
+
+	# Make sure there are no commit messages with excess blank lines
+	test $(grep "^ " actual.2 | wc -l) = 3 &&
+	test $(grep "^ " actual.3 | wc -l) = 5 &&
+	test $(grep "^ " actual.4 | wc -l) = 5 &&
+
+	# Make sure there are no svn commit messages with excess blank lines
+	(
+		cd work.svn &&
+		svn up &&
+		
+		test $(svn log -r2:2 | wc -l) = 5 &&
+		test $(svn log -r4:4 | wc -l) = 7
+	)
 '
 
 test_done
-- 
1.5.4.3
