From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH] Read symbolic refs too when reading all refs
Date: Tue, 12 May 2009 00:49:00 +0200
Message-ID: <1242082140-740-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, alex.blewitt@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue May 12 00:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3eJP-0002yd-US
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 00:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758899AbZEKWtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 18:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757392AbZEKWtJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 18:49:09 -0400
Received: from mail.dewire.com ([83.140.172.130]:26119 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756723AbZEKWtG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 18:49:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 168FB1444174;
	Tue, 12 May 2009 00:49:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ozUtlZEHlJmx; Tue, 12 May 2009 00:49:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 866B11444173;
	Tue, 12 May 2009 00:49:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118860>

We failed to read symrefs when scanning for all refs. Single refs
were ok before too.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefTest.java          |   71 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   13 ++--
 2 files changed, 77 insertions(+), 7 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
new file mode 100644
index 0000000..db79a8a
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2009, Robin Rosenberg
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+package org.spearce.jgit.lib;
+
+import java.util.Map;
+
+/**
+ * Misc tests for refs. A lot of things are tested elsewhere so not having a
+ * test for a ref related method, does not mean it is untested.
+ */
+public class RefTest extends RepositoryTestCase {
+
+	public void testReadAllIncludingSymrefs() throws Exception {
+		ObjectId masterId = db.resolve("refs/heads/master");
+		RefUpdate updateRef = db.updateRef("refs/remotes/origin/master");
+		updateRef.setNewObjectId(masterId);
+		updateRef.setForceUpdate(true);
+		updateRef.update();
+		db
+				.writeSymref("refs/remotes/origin/HEAD",
+						"refs/remotes/origin/master");
+
+		ObjectId r = db.resolve("refs/remotes/origin/HEAD");
+		assertEquals(masterId, r);
+
+		Map<String, Ref> allRefs = db.getAllRefs();
+		Ref refHEAD = allRefs.get("refs/remotes/origin/HEAD");
+		assertEquals(masterId, refHEAD.getObjectId());
+		assertTrue(refHEAD.isPeeled());
+		assertNull(refHEAD.getPeeledObjectId());
+
+		Ref refmaster = allRefs.get("refs/remotes/origin/master");
+		assertEquals(masterId, refmaster.getObjectId());
+		assertFalse(refmaster.isPeeled());
+		assertNull(refmaster.getPeeledObjectId());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 87f26bf..e364b15 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -265,23 +265,22 @@ private synchronized void readOneLooseRef(final Map<String, Ref> avail,
 					final byte[] str = new byte[Constants.OBJECT_ID_LENGTH * 2];
 					NB.readFully(in, str, 0, str.length);
 					id = ObjectId.fromString(str, 0);
+					ref = new Ref(Ref.Storage.LOOSE, origName, refName, id, null, false); // unpeeled
 				} catch (EOFException tooShortToBeRef) {
 					// Its below the minimum length needed. It could
 					// be a symbolic reference.
 					//
-					return;
+					ref = readRefBasic(refName, refName, 0); 
 				} catch (IllegalArgumentException notRef) {
 					// It is not a well-formed ObjectId. It may be
 					// a symbolic reference ("ref: ").
 					//
-					return;
+					ref = readRefBasic(refName, refName, 0); 
 				}
 
-				ref = new Ref(Ref.Storage.LOOSE, origName, refName, id, null, false); // unpeeled
-
-				looseRefs.put(ref.getName(), ref);
-				looseRefsMTime.put(ref.getName(), ent.lastModified());
-				avail.put(ref.getName(), ref);
+				looseRefs.put(ref.getOrigName(), ref);
+				looseRefsMTime.put(ref.getOrigName(), ent.lastModified());
+				avail.put(ref.getOrigName(), ref);
 			} finally {
 				in.close();
 			}
-- 
1.6.3.dirty
