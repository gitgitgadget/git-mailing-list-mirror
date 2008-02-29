From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/5] Test "git remote show" and "git remote prune"
Date: Fri, 29 Feb 2008 01:45:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290145160.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 29 02:46:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUuKf-0001Ct-2x
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbYB2BqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbYB2Bp7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:45:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:51273 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750765AbYB2Bp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:45:59 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:45:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp031) with SMTP; 29 Feb 2008 02:45:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19P8+VAeClPE8X7h6L8Zk5YHykauLAj9s+P9p9w8A
	jiQJ9tKKyZg3oG
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802290144130.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75489>


While at it, also fix a few instances where a cd was done outside of a
subshell.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4fc62f5..e1e0a18 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -94,4 +94,38 @@ test_expect_success 'remove remote' '
 )
 '
 
+cat > test/expect << EOF
+* remote origin
+  URL: $(pwd)/one/.git
+  Remote branch(es) merged with 'git pull' while on branch master
+    master
+  New remote branches (next fetch will store in remotes/origin)
+    master
+  Tracked remote branches
+    side master
+EOF
+
+test_expect_success 'show' '
+	(cd test &&
+	 git config --add remote.origin.fetch \
+		refs/heads/master:refs/heads/upstream &&
+	 git fetch &&
+	 git branch -d -r origin/master &&
+	 (cd ../one &&
+	  echo 1 > file &&
+	  git commit -m update file) &&
+	 git remote show origin > output &&
+	 git diff expect output)
+'
+
+test_expect_success 'prune' '
+	(cd one &&
+	 git branch -m side side2) &&
+	(cd test &&
+	 git fetch origin &&
+	 git remote prune origin &&
+	 git rev-parse refs/remotes/origin/side2 &&
+	 ! git rev-parse refs/remotes/origin/side)
+'
+
 test_done
-- 
1.5.4.3.431.g066fa


