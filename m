From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Clean up .dotest if an error occurs before rebase work starts
Date: Wed,  5 Sep 2007 21:27:16 +0200
Message-ID: <1189020436633-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 05 21:48:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0rx-0004DJ-Lo
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbXIETsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbXIETsw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:48:52 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25481 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932134AbXIETsv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:48:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5D047802A98;
	Wed,  5 Sep 2007 21:40:54 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07677-06; Wed,  5 Sep 2007 21:40:54 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 152F380288E;
	Wed,  5 Sep 2007 21:40:54 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 7C45D2984B; Wed,  5 Sep 2007 21:27:16 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57754>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 git-rebase.sh |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 3bd66b0..81c48d1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -253,23 +253,33 @@ else
 fi
 
 # The tree must be really really clean.
-git update-index --refresh || exit
+git update-index --refresh || {
+	rm -rf .dotest
+	exit 1
+}
+
 diff=$(git diff-index --cached --name-status -r HEAD)
 case "$diff" in
 ?*)	echo "cannot rebase: your index is not up-to-date"
 	echo "$diff"
+	rm -rf .dotest
 	exit 1
 	;;
 esac
 
 # The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
-upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-    die "invalid upstream $upstream_name"
+upstream=`git rev-parse --verify "${upstream_name}^0"` || {
+	rm -rf .dotest
+	die "invalid upstream $upstream_name"
+}
 
 # Make sure the branch to rebase onto is valid.
 onto_name=${newbase-"$upstream_name"}
-onto=$(git rev-parse --verify "${onto_name}^0") || exit
+onto=$(git rev-parse --verify "${onto_name}^0") || {
+	rm -rf .dotest
+	exit 1
+}
 
 # If a hook exists, give it a chance to interrupt
 if test -x "$GIT_DIR/hooks/pre-rebase"
-- 
1.5.3
