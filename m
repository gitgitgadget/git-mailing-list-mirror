From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH] git-p4: Fix checkout bug when using --import-local.
Date: Thu, 28 Aug 2008 00:36:12 +0200
Message-ID: <1219876572-24736-1-git-send-email-torarvid@gmail.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org, Simon Hausmann <simon@lst.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:37:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTde-0001NM-NT
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbYH0WgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 18:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYH0WgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:36:16 -0400
Received: from 213-187-171-142.dd.nextgentel.com ([213.187.171.142]:37052 "EHLO
	webl.heads.no" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754849AbYH0WgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:36:15 -0400
Received: by webl.heads.no (Postfix, from userid 1001)
	id 85038318316; Thu, 28 Aug 2008 00:36:12 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.90.g436ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93972>

When this option is passed to git p4 clone, the checkout at the end would
previously fail. This patch fixes it by optionally creating the master branch
from refs/heads/p4/master, which is the correct one for this option.

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 46136d4..c4b8b4c 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1733,8 +1733,12 @@ class P4Clone(P4Sync):
         if not P4Sync.run(self, depotPaths):
             return False
         if self.branch != "master":
-            if gitBranchExists("refs/remotes/p4/master"):
-                system("git branch master refs/remotes/p4/master")
+            if self.importIntoRemotes:
+                masterbranch = "refs/remotes/p4/master"
+            else:
+                masterbranch = "refs/heads/p4/master"
+            if gitBranchExists(masterbranch):
+                system("git branch master %s" % masterbranch)
                 system("git checkout -f")
             else:
                 print "Could not detect main branch. No checkout/master branch created."
-- 
1.6.0.GIT
