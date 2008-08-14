From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Paper bag fix 'jgit glog' handling of commit-ish arguments
Date: Thu, 14 Aug 2008 16:26:03 -0700
Message-ID: <1218756363-27702-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmDp-0003Pq-6P
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYHNX0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 19:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbYHNX0H
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:26:07 -0400
Received: from george.spearce.org ([209.20.77.23]:60835 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYHNX0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:26:06 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8118A38376; Thu, 14 Aug 2008 23:26:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1982538265;
	Thu, 14 Aug 2008 23:26:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc3.250.g8dd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92440>

When we parsed these arguments into RevCommit instances they were
done against the wrong RevWalk instance.  We parsed them into a
generic RevWalk which has no plotting support, so the objects do
not have the extra fields used by the plotting code.  We need to
lookup the commit from the PlotRevWalk and use those instances.

One of the calls (markStart) failed to use the secondary RevWalk
instance, resulting in a ClassCastException during plotting.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/pgm/RevWalkTextBuiltin.java   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
index 97fe7a4..338af40 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
@@ -152,7 +152,7 @@ abstract class RevWalkTextBuiltin extends TextBuiltin {
 			if (c.has(RevFlag.UNINTERESTING))
 				walk.markUninteresting(real);
 			else
-				walk.markStart(c);
+				walk.markStart(real);
 		}
 
 		final long start = System.currentTimeMillis();
-- 
1.6.0.rc3.250.g8dd0
