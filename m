From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH] Fix update of the refs cache when updating via a symbolic ref
Date: Sat, 15 Aug 2009 20:43:39 +0200
Message-ID: <1250361819-20031-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, stefan.lay@sap.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:45:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McOFg-0007hW-S6
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 20:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbZHOSnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 14:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbZHOSno
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 14:43:44 -0400
Received: from mail.dewire.com ([83.140.172.130]:25322 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbZHOSno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 14:43:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EB91A1434E9C;
	Sat, 15 Aug 2009 20:43:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CEP4GlWlCnFs; Sat, 15 Aug 2009 20:43:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id E189280285E;
	Sat, 15 Aug 2009 20:43:42 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.115.gc0eb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126018>

The branch pointed to by HEAD was lost in the refs cache, i.e. the
HEAD Ref was inserted into the cache with the the peeled ref as
key instead of HEAD. Then when asking for the peeled ref name HEAD
was returned.

This only happened when the ref name was a loose ref and not in
packed-refs at all, hence we test with an unborn branch, though an
existing loose (only) ref would show the same problem.

See http://bugs.eclipse.org/285991

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   61 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    2 +-
 2 files changed, 62 insertions(+), 1 deletions(-)


I'm not posting the patch to bugzilla since this is bug in JGit and not EGit.

-- robin

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 8df8c2a..655e54e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -298,6 +298,67 @@ public void testUpdateRefNoChange() throws IOException {
 	}
 
 	/**
+	 * Test case originating from 
+	 * <a href="http://bugs.eclipse.org/285991">bug 285991</a>
+	 *
+	 * Make sure the in memory cache is updated properly after
+	 * update of symref. This one did not fail because the
+	 * ref was packed due to implementation issues.
+	 *
+	 * @throws Exception
+	 */
+	public void testRefsCacheAfterUpdate() throws Exception {
+		// Do not use the defalt repo for this case.
+		Map<String, Ref> allRefs = db.getAllRefs();
+		ObjectId oldValue = db.resolve("HEAD");
+		ObjectId newValue = db.resolve("HEAD^");
+		// first make HEAD refer to loose ref
+		RefUpdate updateRef = db.updateRef(Constants.HEAD);
+		updateRef.setForceUpdate(true);
+		updateRef.setNewObjectId(newValue);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update);
+		
+		// now update that ref
+		updateRef = db.updateRef(Constants.HEAD);
+		updateRef.setForceUpdate(true);
+		updateRef.setNewObjectId(oldValue);
+		update = updateRef.update();
+		assertEquals(Result.FAST_FORWARD, update);
+		allRefs = db.getAllRefs();
+		assertEquals("refs/heads/master", allRefs.get("refs/heads/master").getName());
+		assertEquals("refs/heads/master", allRefs.get("refs/heads/master").getOrigName());
+		assertEquals("refs/heads/master", allRefs.get("HEAD").getName());
+		assertEquals("HEAD", allRefs.get("HEAD").getOrigName());
+	}
+	
+	/**
+	 * Test case originating from 
+	 * <a href="http://bugs.eclipse.org/285991">bug 285991</a>
+	 *
+	 * Make sure the in memory cache is updated properly after
+	 * update of symref.
+	 *
+	 * @throws Exception
+	 */
+	public void testRefsCacheAfterUpdateLoosOnly() throws Exception {
+		// Do not use the defalt repo for this case.
+		Map<String, Ref> allRefs = db.getAllRefs();
+		ObjectId oldValue = db.resolve("HEAD");
+		db.writeSymref(Constants.HEAD, "refs/heads/newref");
+		RefUpdate updateRef = db.updateRef(Constants.HEAD);
+		updateRef.setForceUpdate(true);
+		updateRef.setNewObjectId(oldValue);
+		Result update = updateRef.update();
+		assertEquals(Result.NEW, update);
+		allRefs = db.getAllRefs();
+		assertEquals("refs/heads/newref", allRefs.get("HEAD").getName());
+		assertEquals("HEAD", allRefs.get("HEAD").getOrigName());
+		assertEquals("refs/heads/newref", allRefs.get("refs/heads/newref").getName());
+		assertEquals("refs/heads/newref", allRefs.get("refs/heads/newref").getOrigName());
+	}
+
+	/**
 	 * Try modify a ref, but get wrong expected old value
 	 *
 	 * @throws IOException
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index f7751c4..ba4b654 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -140,7 +140,7 @@ RefUpdate newUpdate(final String name) throws IOException {
 
 	void stored(final String origName, final String name, final ObjectId id, final long time) {
 		synchronized (this) {
-			looseRefs.put(name, new Ref(Ref.Storage.LOOSE, origName, name, id));
+			looseRefs.put(name, new Ref(Ref.Storage.LOOSE, name, name, id));
 			looseRefsMTime.put(name, time);
 			setModified();
 		}
-- 
1.6.4.115.gc0eb0
