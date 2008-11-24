From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Avoid breaking the walk prematurely
Date: Tue, 25 Nov 2008 00:45:48 +0100
Message-ID: <1227570348-20092-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Nov 25 00:47:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4l9G-0004wE-GH
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 00:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbYKXXpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 18:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbYKXXpv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 18:45:51 -0500
Received: from mail.dewire.com ([83.140.172.130]:1694 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307AbYKXXpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 18:45:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2515F147D510;
	Tue, 25 Nov 2008 00:45:49 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7eeLtsHsicV; Tue, 25 Nov 2008 00:45:48 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 7921C80267A;
	Tue, 25 Nov 2008 00:45:48 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101633>

The optimization broke the walk when all changes we adds, assuming
the parent was an empty tree. This assumption was wrong. The tree does
not have to bee empty, it can contain other trees and blobs.

http://code.google.com/p/egit/issues/detail?id=46

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/revwalk/RewriteTreeFilter.java    |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

We could introduce a fixed version later on if we supply an option to select
whether to optimize the walk this way. The problem with doing it without an
option is that imports from legacy SCMs do not necessarily record file moves
as add/removes in direct sucession, but other events may happen in beteens
for various reasons.

-- robin 

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java
index 587d6d2..a5edbf0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java
@@ -118,13 +118,6 @@ public boolean include(final RevWalk walker, final RevCommit c)
 				//
 				c.flags |= REWRITE;
 				return false;
-			} else if (chgs == adds) {
-				// We added everything, so the parent may as well just
-				// be an empty tree. Kill our parent, we can assume
-				// it did not supply interesting changes.
-				//
-				c.parents = RevCommit.NO_PARENTS;
-				return true;
 			} else {
 				// We have interesting items, but neither of the special
 				// cases denoted above.
-- 
1.6.0.3.640.g6331a
