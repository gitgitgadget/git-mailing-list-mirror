From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 05/26] Allow AbstractTreeIterators to find out about StopWalkExceptions
Date: Mon, 11 Aug 2008 18:07:52 -0700
Message-ID: <1218503293-14057-6-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPP-0006OQ-8g
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbYHLBI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYHLBIY
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:24 -0400
Received: from george.spearce.org ([209.20.77.23]:38566 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbYHLBIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:17 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A5B4538391; Tue, 12 Aug 2008 01:08:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D6BE63837A;
	Tue, 12 Aug 2008 01:08:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92049>

If a tree iterator has overridden skip() to specially handle entries
which the TreeWalk has decided are not relevant then it might also
need to pay attention to a StopWalkException.  The SWE is thrown out
of a filter and behaves much like skip, except it skips everything
else in the tree.  This is used by PathFilterGroup to break out of
a walk once we know that no additional records could ever match.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |   11 +++++++++++
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |    6 ++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    2 ++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 6d7159c..98fec09 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -391,4 +391,15 @@ public abstract class AbstractTreeIterator {
 	public void skip() throws CorruptObjectException {
 		next();
 	}
+
+	/**
+	 * Indicates to the iterator that no more entries will be read.
+	 * <p>
+	 * This is only invoked by TreeWalk when the iteration is aborted early due
+	 * to a {@link org.spearce.jgit.errors.StopWalkException} being thrown from
+	 * within a TreeFilter.
+	 */
+	public void stopWalk() {
+		// Do nothing by default.  Most iterators do not care.
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
index 09d2bde..c5dc4ad 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
@@ -87,4 +87,10 @@ public class EmptyTreeIterator extends AbstractTreeIterator {
 	public void next() throws CorruptObjectException {
 		// Do nothing.
 	}
+
+	@Override
+	public void stopWalk() {
+		if (parent != null)
+			parent.stopWalk();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index d4050ec..1d842bc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -408,6 +408,8 @@ public class TreeWalk {
 				return true;
 			}
 		} catch (StopWalkException stop) {
+			for (final AbstractTreeIterator t : trees)
+				t.stopWalk();
 			return false;
 		}
 	}
-- 
1.6.0.rc2.22.g71b99
