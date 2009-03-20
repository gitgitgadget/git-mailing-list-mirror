From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Split refspecs on the last : not the first
Date: Fri, 20 Mar 2009 08:12:12 -0700
Message-ID: <1237561932-26482-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 16:14:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkgPv-0007nT-Lm
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 16:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbZCTPMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbZCTPMP
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 11:12:15 -0400
Received: from george.spearce.org ([209.20.77.23]:58873 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZCTPMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 11:12:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EDE3B38222; Fri, 20 Mar 2009 15:12:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6053E381D3;
	Fri, 20 Mar 2009 15:12:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.352.gae594
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113969>

Recent discussion about a potential ':%branchname' syntax for
remote branches led rise to the question on #git of whether or
not this could be used on the lhs of a push refspec, such as
"+:%master:master".

Testing shows git-core permits this, as it must be splitting the
refspec with strrchr(), splitting along the last : in the string.
Make JGit match the split semantics.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/RefSpecTestCase.java    |   12 ++++++++++++
 .../src/org/spearce/jgit/transport/RefSpec.java    |    2 +-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
index 11e7cdb..2f7214c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RefSpecTestCase.java
@@ -63,6 +63,18 @@ public void testMasterMaster() {
 		assertFalse(rs.matchDestination(r));
 	}
 
+	public void testSplitLastColon() {
+		final String lhs = ":m:a:i:n:t";
+		final String rhs = "refs/heads/maint";
+		final RefSpec rs = new RefSpec(lhs + ":" + rhs);
+		assertFalse(rs.isForceUpdate());
+		assertFalse(rs.isWildcard());
+		assertEquals(lhs, rs.getSource());
+		assertEquals(rhs, rs.getDestination());
+		assertEquals(lhs + ":" + rhs, rs.toString());
+		assertEquals(rs, new RefSpec(rs.toString()));
+	}
+
 	public void testForceMasterMaster() {
 		final String sn = "refs/heads/master";
 		final RefSpec rs = new RefSpec("+" + sn + ":" + sn);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
index e75b272..273aacc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
@@ -115,7 +115,7 @@ public RefSpec(final String spec) {
 			s = s.substring(1);
 		}
 
-		final int c = s.indexOf(':');
+		final int c = s.lastIndexOf(':');
 		if (c == 0) {
 			s = s.substring(1);
 			if (isWildcard(s))
-- 
1.6.2.1.352.gae594
