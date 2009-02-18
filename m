From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Do not store ObjectId subclasses in RefDatabase caches
Date: Tue, 17 Feb 2009 19:36:51 -0800
Message-ID: <1234928211-30408-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 04:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZdGP-0004yd-7V
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 04:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbZBRDg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 22:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbZBRDg4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 22:36:56 -0500
Received: from george.spearce.org ([209.20.77.23]:60245 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZBRDgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 22:36:54 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id A176F38211; Wed, 18 Feb 2009 03:36:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 957573819F;
	Wed, 18 Feb 2009 03:36:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc1.209.gfe624
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110501>

We cannot permit an ObjectId subclass, such as RevCommit, to be
cached inside of the RefDatabase cache.  Instead of toObjectId()
use copy() to ensure we get exactly an ObjectId for the new value,
as that is the instance we will cache in the RefDatabase.

Caching the ObjectId subclass in RefDatabase will cause any later
cached read of the ref to return that RevCommit, confusing all
application code using "ref.getObjectId().equals(...)" due to the
overridden definition of equals(ObjectId).

ReceivePack was bitten by this, sometimes reporting "invalid old id"
to clients if the ref was last updated using a RevCommit instead
of an ObjectId.  It also caused the history of that repository to
be pinned in memory as RevCommit instances, all of them reachable
from the RefDatabase cache of the last updated Ref.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I know I've sent a bunch of patches, but this one is fairly
 critical, and is simple enough.  Applications that are able
 to cache their Repository for a while can get nailed by this
 ObjectId.equals() quirk.  Gerrit2 is getting hit for example.

 I think we need to revisit RevObject extending ObjectId.  But
 doing that is much more invasive than 1 line of code, and we
 would probably want this change to use copy() anyway.  So my
 suggestion is, we include this now, and I'll try to split the
 RevObject tree off ObjectId later this week to fix the root
 cause of the problem.

 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   18 ++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |    2 +-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 12f9ada..55d7441 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -43,6 +43,7 @@
 import java.util.Map.Entry;
 
 import org.spearce.jgit.lib.RefUpdate.Result;
+import org.spearce.jgit.revwalk.RevCommit;
 
 public class RefUpdateTest extends RepositoryTestCase {
 
@@ -64,6 +65,23 @@ private void delete(final RefUpdate ref, final Result expected,
 		assertEquals(!removed, db.getAllRefs().containsKey(ref.getName()));
 	}
 
+	public void testNoCacheObjectIdSubclass() throws IOException {
+		final String newRef = "refs/heads/abc";
+		final RefUpdate ru = updateRef(newRef);
+		final RevCommit newid = new RevCommit(ru.getNewObjectId()) {
+			// empty
+		};
+		ru.setNewObjectId(newid);
+		ru.update();
+		final Ref r = db.getAllRefs().get(newRef);
+		assertNotNull(r);
+		assertEquals(newRef, r.getName());
+		assertNotNull(r.getObjectId());
+		assertNotSame(newid, r.getObjectId());
+		assertSame(ObjectId.class, r.getObjectId().getClass());
+		assertEquals(newid.copy(), r.getObjectId());
+	}
+
 	public void testLooseDelete() throws IOException {
 		final String newRef = "refs/heads/abc";
 		RefUpdate ref = updateRef(newRef);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 7ad2bab..32095c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -197,7 +197,7 @@ public ObjectId getNewObjectId() {
 	 *            the new value.
 	 */
 	public void setNewObjectId(final AnyObjectId id) {
-		newValue = id.toObjectId();
+		newValue = id.copy();
 	}
 
 	/**
-- 
1.6.2.rc1.209.gfe624
