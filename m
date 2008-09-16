From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] More aggressively clear flags during RevWalk.reset
Date: Tue, 16 Sep 2008 12:34:37 -0700
Message-ID: <1221593677-24481-2-git-send-email-spearce@spearce.org>
References: <1221593677-24481-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfgKy-0004uF-KS
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 21:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbYIPTem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 15:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYIPTel
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 15:34:41 -0400
Received: from george.spearce.org ([209.20.77.23]:59771 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbYIPTej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 15:34:39 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 34B5438360; Tue, 16 Sep 2008 19:34:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E246A3835F;
	Tue, 16 Sep 2008 19:34:37 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.389.g421e0
In-Reply-To: <1221593677-24481-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96031>

We cannot rely upon SEEN to tell us if the commit has flags we
must clear, as some forms of RevWalk usage can get flags put in
places that don't have a clear SEEN trail leading to them.  To
ensure we have correctly reset the graph we need to follow down
any chain which has any flag we are not going to retain across
the reset, making the correct test ~retain (and not just SEEN).

This fixes an issue I identified in an application that makes
heavy use of the same RevWalk instance, constantly resetting
it and executing down different parts of the same DAG instance.

Some executions still had UNINTERESTING colored on commits,
even though they should have been cleared by the prior reset.
The clear failed as there was not a SEEN path leading into the
previously UNINTERESTING (but now interesting) commit.  This
missing SEEN path occurred because markUninteresting() runs
RevComit.carryFlags(), pushing the UNINTERESTING flag as far
down the DAG as we have parsed.  Not all of those DAG nodes
may get visited in a traversal (so they lack SEEN), but they
must get reset in order to reuse the same DAG instance.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 5cd7f71..d7e4c58 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -887,10 +887,11 @@ public final void resetRetain(final RevFlag... retainFlags) {
 	protected void reset(int retainFlags) {
 		finishDelayedFreeFlags();
 		retainFlags |= PARSED;
+		final int clearFlags = ~retainFlags;
 
 		final FIFORevQueue q = new FIFORevQueue();
 		for (final RevCommit c : roots) {
-			if ((c.flags & SEEN) == 0)
+			if ((c.flags & clearFlags) == 0)
 				continue;
 			c.flags &= retainFlags;
 			c.reset();
@@ -901,10 +902,13 @@ protected void reset(int retainFlags) {
 			final RevCommit c = q.next();
 			if (c == null)
 				break;
+			if (c.parents == null)
+				continue;
 			for (final RevCommit p : c.parents) {
-				if ((p.flags & SEEN) == 0)
+				if ((p.flags & clearFlags) == 0)
 					continue;
 				p.flags &= retainFlags;
+				p.reset();
 				q.add(p);
 			}
 		}
-- 
1.6.0.2.389.g421e0
