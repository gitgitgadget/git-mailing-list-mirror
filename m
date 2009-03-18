From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Micro-optimize the merge base generator
Date: Wed, 18 Mar 2009 11:01:49 -0700
Message-ID: <1237399309-29493-2-git-send-email-spearce@spearce.org>
References: <1237399309-29493-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:03:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk075-0002TA-SR
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbZCRSBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbZCRSBx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:01:53 -0400
Received: from george.spearce.org ([209.20.77.23]:42374 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbZCRSBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:01:52 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6B65238222; Wed, 18 Mar 2009 18:01:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E56A238221;
	Wed, 18 Mar 2009 18:01:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.337.g6270ba
In-Reply-To: <1237399309-29493-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113644>

Instead of doing 3 bit-wise and operations followed by 3 compares
and two boolean and conditions on every commit we evaluate in the
history, we can fold all of the tests into a pair of fields and
do one bit mask and compare.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/revwalk/MergeBaseGenerator.java   |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
index 2eb9688..8694e4c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
@@ -73,6 +73,10 @@
 
 	private int branchMask;
 
+	private int recarryTest;
+
+	private int recarryMask;
+
 	MergeBaseGenerator(final RevWalk w) {
 		walker = w;
 		pending = new DateRevQueue();
@@ -91,6 +95,12 @@ void init(final AbstractRevQueue p) {
 			// will be available for reuse when the walk resets.
 			//
 			walker.freeFlag(branchMask);
+
+			// Setup the condition used by carryOntoOne to detect a late
+			// merge base and produce it on the next round.
+			//
+			recarryTest = branchMask | POPPED;
+			recarryMask = branchMask | POPPED | MERGE_BASE;
 		}
 	}
 
@@ -187,8 +197,7 @@ private boolean carryOntoOne(final RevCommit p, final int carry) {
 		final boolean haveAll = (p.flags & carry) == carry;
 		p.flags |= carry;
 
-		if ((p.flags & POPPED) != 0 && (carry & MERGE_BASE) == 0
-				&& (p.flags & branchMask) == branchMask) {
+		if ((p.flags & recarryMask) == recarryTest) {
 			// We were popped without being a merge base, but we just got
 			// voted to be one. Inject ourselves back at the front of the
 			// pending queue and tell all of our ancestors they are within
-- 
1.6.2.1.337.g6270ba
