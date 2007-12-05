From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/6] Test "git remote show" and "git remote prune"
Date: Wed, 5 Dec 2007 19:02:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051901550.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 20:03:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzWo-0001zS-D3
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbXLETCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXLETCb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:02:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:57248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751885AbXLETCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:02:30 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:02:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 05 Dec 2007 20:02:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vmAEIc9uv9HuNwx7pnXabzl95hFe54CqRLW8sAn
	qYhSl7n6rfc73H
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712051858270.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67177>


While at it, also fix a few instances where a cd was done outside of a
subshell.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 636aec2..c7d7242 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -97,4 +97,38 @@ test_expect_success 'remove remote' '
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
1.5.3.7.2157.g9598e
