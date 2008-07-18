From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/28] Add parseTree method to RevWalk to obtain a RevTree from AnyObjectId
Date: Thu, 17 Jul 2008 21:44:01 -0400
Message-ID: <1216345461-59382-9-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2s-00060p-6q
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758622AbYGRBpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757950AbYGRBpA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:00 -0400
Received: from george.spearce.org ([209.20.77.23]:47012 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757722AbYGRBor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:47 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9B25D38508; Fri, 18 Jul 2008 01:44:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 17D353841F;
	Fri, 18 Jul 2008 01:44:26 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88956>

Some applications want to dereference an ObjectId back to a tree,
and they don't care what type of object the ObjectId supplied is
actually of.  If its an annotated tag we can peel the tag back to
either a tree, or a commit, and a commit can be peeled back to its
only tree.  So parseTree is a simple API for ^{tree}.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   35 ++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 946486c..42ec2a2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -612,6 +612,41 @@ public class RevWalk implements Iterable<RevCommit> {
 	}
 
 	/**
+	 * Locate a reference to a tree.
+	 * <p>
+	 * This method only returns successfully if the tree object exists, is
+	 * verified to be a tree, and was parsed without error.
+	 * 
+	 * @param id
+	 *            name of the tree object, or a commit or annotated tag that may
+	 *            reference a tree.
+	 * @return reference to the tree object. Never null.
+	 * @throws MissingObjectException
+	 *             the supplied tree does not exist.
+	 * @throws IncorrectObjectTypeException
+	 *             the supplied id is not a tree, a commit or an annotated tag.
+	 * @throws IOException
+	 *             a pack file or loose object could not be read.
+	 */
+	public RevTree parseTree(final AnyObjectId id)
+			throws MissingObjectException, IncorrectObjectTypeException,
+			IOException {
+		RevObject c = parseAny(id);
+		while (c instanceof RevTag) {
+			c = ((RevTag) c).getObject();
+			parse(c);
+		}
+		if (c instanceof RevCommit) {
+			c = ((RevCommit) c).getTree();
+			parse(c);
+		}
+		final RevTree t = (RevTree) c;
+		if (db.openObject(t).getType() != Constants.OBJ_TREE)
+			throw new IncorrectObjectTypeException(t, Constants.TYPE_TREE);
+		return t;
+	}
+
+	/**
 	 * Locate a reference to any object and immediately parse its content.
 	 * <p>
 	 * This method only returns successfully if the object exists and was parsed
-- 
1.5.6.3.569.ga9185
