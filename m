From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/7] Cleanup RevWalk.parseTree semantics
Date: Thu,  4 Sep 2008 16:42:14 -0700
Message-ID: <1220571739-4219-3-git-send-email-spearce@spearce.org>
References: <1220571739-4219-1-git-send-email-spearce@spearce.org>
 <1220571739-4219-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOUA-0000iN-AA
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYIDXm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYIDXmY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:24 -0400
Received: from george.spearce.org ([209.20.77.23]:33767 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbYIDXmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 67574383A3; Thu,  4 Sep 2008 23:42:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B93F23835F;
	Thu,  4 Sep 2008 23:42:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
In-Reply-To: <1220571739-4219-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94977>

When we call parseAny we may have opened the ObjectLoader for the
tree we are going after.  If that worked we know the object exists
in the repository and is certainly recorded as type "tree" so we
do not need to open the object a second time before returning to
the caller.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 243d9b3..5a29dcf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -639,15 +639,21 @@ public RevTree parseTree(final AnyObjectId id)
 			c = ((RevTag) c).getObject();
 			parse(c);
 		}
-		if (c instanceof RevCommit) {
-			c = ((RevCommit) c).getTree();
-			parse(c);
-		} else if (!(c instanceof RevTree))
+		
+		final RevTree t;
+		if (c instanceof RevCommit)
+			t = ((RevCommit) c).getTree();
+		else if (!(c instanceof RevTree))
 			throw new IncorrectObjectTypeException(id.toObjectId(),
 					Constants.TYPE_TREE);
-		final RevTree t = (RevTree) c;
+		else
+			t = (RevTree) c;
+
+		if ((t.flags & PARSED) != 0)
+			return t;
 		if (db.openObject(t).getType() != Constants.OBJ_TREE)
 			throw new IncorrectObjectTypeException(t, Constants.TYPE_TREE);
+		t.flags |= PARSED;
 		return t;
 	}
 
@@ -685,10 +691,12 @@ public RevObject parseAny(final AnyObjectId id)
 			}
 			case Constants.OBJ_TREE: {
 				r = new RevTree(ldr.getId());
+				r.flags |= PARSED;
 				break;
 			}
 			case Constants.OBJ_BLOB: {
 				r = new RevBlob(ldr.getId());
+				r.flags |= PARSED;
 				break;
 			}
 			case Constants.OBJ_TAG: {
-- 
1.6.0.1.319.g9f32b
