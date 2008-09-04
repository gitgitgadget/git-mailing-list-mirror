From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/7] Cleanup RevWalk.parseCommit, parseTree to not throw ClassCastException
Date: Thu,  4 Sep 2008 16:42:13 -0700
Message-ID: <1220571739-4219-2-git-send-email-spearce@spearce.org>
References: <1220571739-4219-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOU8-0000iN-QV
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbYIDXmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYIDXmX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:23 -0400
Received: from george.spearce.org ([209.20.77.23]:33764 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYIDXmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:21 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 198503838D; Thu,  4 Sep 2008 23:42:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 72E8338353;
	Thu,  4 Sep 2008 23:42:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
In-Reply-To: <1220571739-4219-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94975>

Throwing ClassCastException here for non-commits is really difficult
to work with at the caller level because we may catch the wrong sort
of ClassCastException and may mask a bug deep inside of RevWalk's
parsing code.  It is cleaner to throw IncorrectObjectTypeException
and catch that.  Besides, the method javadoc says that is what gets
thrown if either method is given the wrong type.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |    2 --
 .../org/spearce/jgit/pgm/opt/RevCommitHandler.java |    2 --
 .../org/spearce/jgit/pgm/opt/RevTreeHandler.java   |    2 --
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    7 ++++++-
 .../jgit/transport/BasePackFetchConnection.java    |    2 --
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
index e439c87..9432d5f 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
@@ -112,8 +112,6 @@ public int parseArguments(final Parameters params) throws CmdLineException {
 		final CanonicalTreeParser p = new CanonicalTreeParser();
 		try {
 			p.reset(clp.getRepository(), clp.getRevWalk().parseTree(id));
-		} catch (ClassCastException e) {
-			throw new CmdLineException(name + " is not a tree");
 		} catch (MissingObjectException e) {
 			throw new CmdLineException(name + " is not a tree");
 		} catch (IncorrectObjectTypeException e) {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java
index 772a8d7..5bfc61e 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java
@@ -115,8 +115,6 @@ private void addOne(final String name, final boolean interesting)
 		final RevCommit c;
 		try {
 			c = clp.getRevWalk().parseCommit(id);
-		} catch (ClassCastException e) {
-			throw new CmdLineException(name + " is not a commit");
 		} catch (MissingObjectException e) {
 			throw new CmdLineException(name + " is not a commit");
 		} catch (IncorrectObjectTypeException e) {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevTreeHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevTreeHandler.java
index de64336..0a0c5d2 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevTreeHandler.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevTreeHandler.java
@@ -88,8 +88,6 @@ public int parseArguments(final Parameters params) throws CmdLineException {
 		final RevTree c;
 		try {
 			c = clp.getRevWalk().parseTree(id);
-		} catch (ClassCastException e) {
-			throw new CmdLineException(name + " is not a tree");
 		} catch (MissingObjectException e) {
 			throw new CmdLineException(name + " is not a tree");
 		} catch (IncorrectObjectTypeException e) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index c90f2a3..243d9b3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -608,6 +608,9 @@ public RevCommit parseCommit(final AnyObjectId id)
 			c = ((RevTag) c).getObject();
 			parse(c);
 		}
+		if (!(c instanceof RevCommit))
+			throw new IncorrectObjectTypeException(id.toObjectId(),
+					Constants.TYPE_COMMIT);
 		return (RevCommit) c;
 	}
 
@@ -639,7 +642,9 @@ public RevTree parseTree(final AnyObjectId id)
 		if (c instanceof RevCommit) {
 			c = ((RevCommit) c).getTree();
 			parse(c);
-		}
+		} else if (!(c instanceof RevTree))
+			throw new IncorrectObjectTypeException(id.toObjectId(),
+					Constants.TYPE_TREE);
 		final RevTree t = (RevTree) c;
 		if (db.openObject(t).getType() != Constants.OBJ_TREE)
 			throw new IncorrectObjectTypeException(t, Constants.TYPE_TREE);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 39fa761..a22b33d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -197,8 +197,6 @@ private void markReachable(final int maxTime) throws IOException {
 				reachableCommits.add(o);
 			} catch (IOException readError) {
 				// If we cannot read the value of the ref skip it.
-			} catch (ClassCastException cce) {
-				// Not a commit type.
 			}
 		}
 
-- 
1.6.0.1.319.g9f32b
