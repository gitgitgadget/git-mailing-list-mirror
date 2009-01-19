From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix TreeWalk.idEqual when both trees are missing the path
Date: Mon, 19 Jan 2009 09:52:36 -0800
Message-ID: <1232387556-10289-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>, tomi.pakarinen@iki.fi
X-From: git-owner@vger.kernel.org Mon Jan 19 18:54:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOyK2-0002y6-B6
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbZASRwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbZASRwi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:52:38 -0500
Received: from george.spearce.org ([209.20.77.23]:51347 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZASRwi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:52:38 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7BB9838211; Mon, 19 Jan 2009 17:52:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E5FED3816F;
	Mon, 19 Jan 2009 17:52:36 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.331.g9c367
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106376>

The Javadoc of idEqual() says its simply a faster form of
getObjectId(nthA).equals(getObjectId(nthB)), but its code
didn't match that definition when both trees didn't exist
at the current path.

If a tree doesn't exist for the current path getObjectId() returns
ObjectId.zero(), indicating the "magic" 0{40} SHA-1 for the current
path.  If both tree entries don't exist for the current path, we
should be doing a compare of ObjectId.zero() against ObjectId.zero(),
which must be true as the values are the same.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index ecf8851..414587c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -616,7 +616,16 @@ public boolean idEqual(final int nthA, final int nthB) {
 		final AbstractTreeIterator ch = currentHead;
 		final AbstractTreeIterator a = trees[nthA];
 		final AbstractTreeIterator b = trees[nthB];
-		return a.matches == ch && b.matches == ch && a.idEqual(b);
+		if (a.matches == ch && b.matches == ch)
+			return a.idEqual(b);
+		if (a.matches != ch && b.matches != ch) {
+			// If neither tree matches the current path node then neither
+			// tree has this entry. In such case the ObjectId is zero(),
+			// and zero() is always equal to zero().
+			//
+			return true;
+		}
+		return false;
 	}
 
 	/**
-- 
1.6.1.331.g9c367
