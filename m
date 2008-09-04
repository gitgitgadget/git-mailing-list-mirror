From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/7] Fix potential NullPointerException in RevWalk.parseTree
Date: Thu,  4 Sep 2008 16:42:15 -0700
Message-ID: <1220571739-4219-4-git-send-email-spearce@spearce.org>
References: <1220571739-4219-1-git-send-email-spearce@spearce.org>
 <1220571739-4219-2-git-send-email-spearce@spearce.org>
 <1220571739-4219-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOU9-0000iN-IO
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbYIDXm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbYIDXm0
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:26 -0400
Received: from george.spearce.org ([209.20.77.23]:33770 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbYIDXmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A2A1E383A4; Thu,  4 Sep 2008 23:42:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0301638360;
	Thu,  4 Sep 2008 23:42:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
In-Reply-To: <1220571739-4219-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94974>

If we have previously obtained this RevTree by lookupTree (such as
in a commit) but we are missing in the repository and call parseTree
we want a MissingObjectException to be thrown, not an NPE.  The NPE
tells us nothing and could be the same as a bug internal to RevWalk.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 5a29dcf..0dead10 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -651,7 +651,10 @@ else if (!(c instanceof RevTree))
 
 		if ((t.flags & PARSED) != 0)
 			return t;
-		if (db.openObject(t).getType() != Constants.OBJ_TREE)
+		final ObjectLoader ldr = db.openObject(t);
+		if (ldr == null)
+			throw new MissingObjectException(t, Constants.TYPE_TREE);
+		if (ldr.getType() != Constants.OBJ_TREE)
 			throw new IncorrectObjectTypeException(t, Constants.TYPE_TREE);
 		t.flags |= PARSED;
 		return t;
-- 
1.6.0.1.319.g9f32b
