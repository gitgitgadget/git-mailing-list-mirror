From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/3] Use a common skipObject method to avoid UNINTERESTING items
Date: Fri, 13 Mar 2009 11:11:52 -0700
Message-ID: <1236967912-15088-3-git-send-email-spearce@spearce.org>
References: <1236967912-15088-1-git-send-email-spearce@spearce.org>
 <1236967912-15088-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 19:14:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiBtH-0007LW-Ge
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 19:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbZCMSMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 14:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbZCMSL7
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 14:11:59 -0400
Received: from george.spearce.org ([209.20.77.23]:57849 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZCMSLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 14:11:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 069F73821F; Fri, 13 Mar 2009 18:11:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 01CE238215;
	Fri, 13 Mar 2009 18:11:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
In-Reply-To: <1236967912-15088-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113217>

All cases are using the same logic to decide that we should skip
this current object and not return it to the caller.  A common
implementation makes the code easier to follow, especially as it
reduces the ugly line wrap involved in the loop body.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index a481639..b92629e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -255,8 +255,7 @@ public RevObject nextObject() throws MissingObjectException,
 				if ((o.flags & SEEN) != 0)
 					break;
 				o.flags |= SEEN;
-				if ((o.flags & UNINTERESTING) != 0
-						&& !hasRevSort(RevSort.BOUNDARY))
+				if (skipObject(o))
 					break;
 				fromTreeWalk = true;
 				return o;
@@ -267,8 +266,7 @@ public RevObject nextObject() throws MissingObjectException,
 				if ((o.flags & SEEN) != 0)
 					break;
 				o.flags |= SEEN;
-				if ((o.flags & UNINTERESTING) != 0
-						&& !hasRevSort(RevSort.BOUNDARY))
+				if (skipObject(o))
 					break;
 				nextSubtree = o;
 				fromTreeWalk = true;
@@ -294,7 +292,7 @@ public RevObject nextObject() throws MissingObjectException,
 			if ((o.flags & SEEN) != 0)
 				continue;
 			o.flags |= SEEN;
-			if ((o.flags & UNINTERESTING) != 0 && !hasRevSort(RevSort.BOUNDARY))
+			if (skipObject(o))
 				continue;
 			if (o instanceof RevTree) {
 				currentTree = (RevTree) o;
@@ -304,6 +302,10 @@ public RevObject nextObject() throws MissingObjectException,
 		}
 	}
 
+	private final boolean skipObject(final RevObject o) {
+		return (o.flags & UNINTERESTING) != 0 && !hasRevSort(RevSort.BOUNDARY);
+	}
+
 	/**
 	 * Verify all interesting objects are available, and reachable.
 	 * <p>
-- 
1.6.2.288.gc3f22
