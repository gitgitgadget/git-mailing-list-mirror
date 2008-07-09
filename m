From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/4] Fix pushing of annotated tags to actually include the tag object
Date: Wed,  9 Jul 2008 00:15:29 -0400
Message-ID: <1215576931-4174-3-git-send-email-spearce@spearce.org>
References: <1215576931-4174-1-git-send-email-spearce@spearce.org>
 <1215576931-4174-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 06:16:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGR6W-0004EZ-Jp
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 06:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbYGIEPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 00:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbYGIEPh
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 00:15:37 -0400
Received: from george.spearce.org ([209.20.77.23]:46874 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYGIEPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 00:15:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6E9C138268; Wed,  9 Jul 2008 04:15:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DC4F5381FC;
	Wed,  9 Jul 2008 04:15:32 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1215576931-4174-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87841>

When we pushed an annotated tag to a remote repository jgit was
failing to include the annotated tag object itself as ObjectWalk
nextObject() failed to pop the object out of the internal pending
queue and return it for inclusion in the generated pack file.

We need to use two different flags for SEEN and IN_PENDING as a blob
or tree object can be SEEN during a TreeWalk, yet may also have been
inserted into the pending object list.  SEEN means we have output
the object to the caller, IN_PENDING means we have placed it into
the pending object list.  Together these prevent duplicates in the
queue and duplicate return values.

Noticed by Robin while trying to push an annotated tag:

  $ git tag -m foo X
  $ git rev-parse X
  49aa0e93621...

  $ jgit push somerepo refs/tags/X
  error: unpack should have generated 49aa0e93621...
  To somerepo.git
   ! [remote rejected] X -> X (bad pack)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 6a5b857..1ba21eb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -66,6 +66,15 @@ import org.spearce.jgit.treewalk.TreeWalk;
  * commits that are returned first.
  */
 public class ObjectWalk extends RevWalk {
+	/**
+	 * Indicates a non-RevCommit is in {@link #pendingObjects}.
+	 * <p>
+	 * We can safely reuse {@link RevWalk#REWRITE} here for the same value as it
+	 * is only set on RevCommit and {@link #pendingObjects} never has RevCommit
+	 * instances inserted into it.
+	 */
+	private static final int IN_PENDING = RevWalk.REWRITE;
+
 	private final TreeWalk treeWalk;
 
 	private BlockObjQueue pendingObjects;
@@ -361,8 +370,8 @@ public class ObjectWalk extends RevWalk {
 	}
 
 	private void addObject(final RevObject o) {
-		if ((o.flags & SEEN) == 0) {
-			o.flags |= SEEN;
+		if ((o.flags & IN_PENDING) == 0) {
+			o.flags |= IN_PENDING;
 			pendingObjects.add(o);
 		}
 	}
-- 
1.5.6.74.g8a5e
