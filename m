From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Read symbolic refs too when reading all refs
Date: Mon, 11 May 2009 19:22:34 -0700
Message-ID: <20090512022234.GQ30527@spearce.org>
References: <1242082140-740-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.blewitt@gmail.com
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue May 12 04:22:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3hdp-0006Pt-1n
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 04:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795AbZELCWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 22:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbZELCWe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 22:22:34 -0400
Received: from george.spearce.org ([209.20.77.23]:56105 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756874AbZELCWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 22:22:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 32158381D5; Tue, 12 May 2009 02:22:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1242082140-740-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118867>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> We failed to read symrefs when scanning for all refs. Single refs
> were ok before too.

Hmm, I think this is a better patch, given that readOneLooseRef and
readRefBasic are basically trying to do the same thing here anyway.


--8<--
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Read symbolic refs too when reading all refs

We failed to read symrefs when scanning for all refs. Single refs
were ok before too.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/RefTest.java          |   72 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   70 ++-----------------
 2 files changed, 80 insertions(+), 62 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
new file mode 100644
index 0000000..cae5143
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
@@ -0,0 +1,72 @@
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
+		assertNotNull(refHEAD);
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
index 87f26bf..155ed9a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -41,7 +41,6 @@
 import static org.spearce.jgit.lib.Constants.R_TAGS;
 
 import java.io.BufferedReader;
-import java.io.EOFException;
 import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
@@ -53,7 +52,6 @@
 import org.spearce.jgit.errors.ObjectWritingException;
 import org.spearce.jgit.lib.Ref.Storage;
 import org.spearce.jgit.util.FS;
-import org.spearce.jgit.util.NB;
 
 class RefDatabase {
 	private static final String REFS_SLASH = "refs/";
@@ -229,69 +227,17 @@ private void readLooseRefs(final Map<String, Ref> avail,
 			final String entName = ent.getName();
 			if (".".equals(entName) || "..".equals(entName))
 				continue;
-			readOneLooseRef(avail, prefix + entName, prefix + entName, ent);
-		}
-	}
-
-	private synchronized void readOneLooseRef(final Map<String, Ref> avail,
-			final String origName, final String refName, final File ent) {
-		// Unchanged and cached? Don't read it again.
-		//
-		Ref ref = looseRefs.get(refName);
-		if (ref != null) {
-			Long cachedlastModified = looseRefsMTime.get(refName);
-			if (cachedlastModified != null && cachedlastModified == ent.lastModified()) {
-				avail.put(ref.getName(), ref);
-				return;
-			}
-			looseRefs.remove(refName);
-			looseRefsMTime.remove(refName);
-		}
-
-		// Recurse into the directory.
-		//
-		if (ent.isDirectory()) {
-			readLooseRefs(avail, refName + "/", ent);
-			return;
-		}
-
-		// Assume its a valid loose reference we need to cache.
-		//
-		try {
-			final FileInputStream in = new FileInputStream(ent);
-			try {
-				final ObjectId id;
+			if (ent.isDirectory()) {
+				readLooseRefs(avail, prefix + entName + "/", ent);
+			} else {
 				try {
-					final byte[] str = new byte[Constants.OBJECT_ID_LENGTH * 2];
-					NB.readFully(in, str, 0, str.length);
-					id = ObjectId.fromString(str, 0);
-				} catch (EOFException tooShortToBeRef) {
-					// Its below the minimum length needed. It could
-					// be a symbolic reference.
-					//
-					return;
-				} catch (IllegalArgumentException notRef) {
-					// It is not a well-formed ObjectId. It may be
-					// a symbolic reference ("ref: ").
-					//
-					return;
+					final Ref ref = readRefBasic(prefix + entName, 0);
+					if (ref != null)
+						avail.put(ref.getOrigName(), ref);
+				} catch (IOException e) {
+					continue;
 				}
-
-				ref = new Ref(Ref.Storage.LOOSE, origName, refName, id, null, false); // unpeeled
-
-				looseRefs.put(ref.getName(), ref);
-				looseRefsMTime.put(ref.getName(), ent.lastModified());
-				avail.put(ref.getName(), ref);
-			} finally {
-				in.close();
 			}
-		} catch (FileNotFoundException noFile) {
-			// Deleted while we were reading? Its gone now!
-			//
-		} catch (IOException err) {
-			// Whoops.
-			//
-			throw new RuntimeException("Cannot read ref " + ent, err);
 		}
 	}
 
-- 
1.6.3.48.g99c76
