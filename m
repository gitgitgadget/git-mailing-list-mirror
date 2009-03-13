From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix sorting of thin packs in PackWriter
Date: Fri, 13 Mar 2009 08:45:25 -0700
Message-ID: <1236959125-3789-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 16:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li9b8-0002QL-Da
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 16:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbZCMPp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 11:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbZCMPp2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 11:45:28 -0400
Received: from george.spearce.org ([209.20.77.23]:46269 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCMPp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 11:45:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 07EB138215; Fri, 13 Mar 2009 15:45:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8BBCA3814F;
	Fri, 13 Mar 2009 15:45:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113197>

We must retain the TOPO and COMMIT_TIME_DESC rules when we add in
BOUNDARY for a thin pack, otherwise the resulting thin pack won't
match the expected ordering.

Its a non-critical error to sort the pack wrong, but it may cause the
client to skip around the pack data more frequently during access.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index f9945c4..b878409 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -765,10 +765,10 @@ private ObjectWalk setUpWalker(
 			throws MissingObjectException, IOException,
 			IncorrectObjectTypeException {
 		final ObjectWalk walker = new ObjectWalk(db);
-		walker.sort(RevSort.TOPO, true);
+		walker.sort(RevSort.TOPO);
 		walker.sort(RevSort.COMMIT_TIME_DESC, true);
 		if (thin)
-			walker.sort(RevSort.BOUNDARY);
+			walker.sort(RevSort.BOUNDARY, true);
 
 		for (ObjectId id : interestingObjects) {
 			RevObject o = walker.parseAny(id);
-- 
1.6.2.288.gc3f22
