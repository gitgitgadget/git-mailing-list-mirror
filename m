From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 1/2] Issue 23: Resolve tag^0 as tag^{commit}
Date: Thu, 11 Sep 2008 23:39:27 +0200
Message-ID: <20080911213927.GA20238@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdtu1-0000Mx-Et
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbYIKVja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYIKVja
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:39:30 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:48546 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbYIKVja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 17:39:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id D03CA19BCA3;
	Thu, 11 Sep 2008 23:39:28 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28066-06; Thu, 11 Sep 2008 23:39:27 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 90B3519BC77;
	Thu, 11 Sep 2008 23:39:27 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B722E6DF845; Thu, 11 Sep 2008 23:39:14 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 7B3311A4001; Thu, 11 Sep 2008 23:39:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95650>

Repository.resolve("tag^0") failed with "not a commit". Fix it and add a
test case for it.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../org/spearce/jgit/lib/T0008_testparserev.java   |    9 ++++++++-
 .../src/org/spearce/jgit/lib/Repository.java       |    5 +++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
index 8883b8b..3457574 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
@@ -109,10 +109,17 @@ public void testDerefTag() throws IOException {
 		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{blob}").name());
 	}
 
+	public void testDerefTagIssue23() throws IOException {
+		assertEquals("17768080a2318cd89bba4c8b87834401e2095703",db.resolve("refs/tags/B").name());
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B^{commit}").name());
+		// The special tag^0 == tag^{commit} rule
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B^0").name());
+	}
+
 	public void testDerefBlob() throws IOException {
 		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{}").name());
 		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{blob}").name());
 	}
-	
+
 	// TODO: ^{tree} for a tag pointing to a tag
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b27c23d..260a39d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -562,6 +562,11 @@ public ObjectId resolve(final String revstr) throws IOException {
 					case '9':
 						int j;
 						ref = mapObject(refId, null);
+						if (ref instanceof Tag && rev[i + 1] == '0') {
+							Tag tag = (Tag)ref;
+							refId = tag.getObjId();
+							ref = mapObject(refId, null);
+						}
 						if (!(ref instanceof Commit))
 							throw new IncorrectObjectTypeException(refId, Constants.TYPE_COMMIT);
 						for (j=i+1; j<rev.length; ++j) {
-- 
1.6.0.336.ga07ba


-- 
Jonas Fonseca
