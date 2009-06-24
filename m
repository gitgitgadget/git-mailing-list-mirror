From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH 3/3] Added BlobBasedConfig that allows accessing configuration files stored in the blobs
Date: Wed, 24 Jun 2009 21:48:05 +0400
Message-ID: <1245865685-1288-4-git-send-email-constantine.plotnikov@gmail.com>
References: <1245865685-1288-1-git-send-email-constantine.plotnikov@gmail.com>
 <1245865685-1288-2-git-send-email-constantine.plotnikov@gmail.com>
 <1245865685-1288-3-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 19:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJWad-0003ms-Kq
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 19:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761423AbZFXRsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761203AbZFXRsP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 13:48:15 -0400
Received: from mail.intellij.net ([213.182.181.98]:51269 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760100AbZFXRsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 13:48:09 -0400
Received: (qmail 32396 invoked by uid 89); 24 Jun 2009 17:48:06 -0000
Received: by simscan 1.1.0 ppid: 32219, pid: 32388, t: 0.0057s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 24 Jun 2009 17:48:06 -0000
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <1245865685-1288-3-git-send-email-constantine.plotnikov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122150>

The class BlobBasedConfig allows loading files stored in blobs inside
the repository. This class can be used to access .gitmodules file stored
inside the repository. To simplify API for this class the method
Commit.getRepository() is added. And the type of the last argument in
TreeWalk.forPath(db, path, trees) is changed from AnyObjectId[] to
AnyObjectId...

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---

Note that after this patch the method TreeWalk.forPath(Repository,
String, RevTree) is needed for binary backward compatibility only. 
It can be removed without breaking source compatibility.
 
 .../src/org/spearce/jgit/lib/BlobBasedConfig.java  |  145 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Commit.java           |    7 +
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    2 +-
 3 files changed, 153 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
new file mode 100644
index 0000000..0385a3b
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2009, JetBrains s.r.o.
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
+import java.io.ByteArrayInputStream;
+import java.io.IOException;
+import java.io.InputStream;
+import java.util.concurrent.Callable;
+
+import org.spearce.jgit.treewalk.TreeWalk;
+
+/**
+ * The configuration file based on the blobs stored in the repository
+ */
+public class BlobBasedConfig extends Config {
+	private Callable<byte[]> blobProvider;
+
+	/**
+	 * The constructor for blob based config
+	 *
+	 * @param base
+	 *            the base configuration file
+	 * @param blob
+	 *            the provider for blobs
+	 */
+	public BlobBasedConfig(Config base, Callable<byte[]> blob) {
+		super(base);
+		blobProvider = blob;
+	}
+
+	/**
+	 * The constructor from a byte array
+	 *
+	 * @param base
+	 *            the base configuration file
+	 * @param blob
+	 *            the byte array
+	 */
+	public BlobBasedConfig(Config base, final byte[] blob) {
+		this(base, new Callable<byte[]>() {
+			public byte[] call() throws Exception {
+				return blob;
+			}
+		});
+	}
+
+	/**
+	 * The constructor from object identifier
+	 *
+	 * @param base
+	 *            the base configuration file
+	 * @param r
+	 *            the repository
+	 * @param objectId
+	 *            the object identifier
+	 */
+	public BlobBasedConfig(Config base, final Repository r,
+			final ObjectId objectId) {
+		this(base, new Callable<byte[]>() {
+			public byte[] call() throws Exception {
+				ObjectLoader loader = r.openBlob(objectId);
+				if (loader == null) {
+					throw new IOException("Blob not found: " + objectId);
+				}
+				return loader.getBytes();
+			}
+		});
+	}
+
+	/**
+	 * The constructor from commit and path
+	 *
+	 * @param base
+	 *            the base configuration file
+	 * @param commit
+	 *            the commit that contains the object
+	 * @param path
+	 *            the path within the tree of the commit
+	 */
+	public BlobBasedConfig(Config base, final Commit commit, final String path) {
+		this(base, new Callable<byte[]>() {
+			public byte[] call() throws Exception {
+				final ObjectId treeId = commit.getTreeId();
+				final Repository r = commit.getRepository();
+				final TreeWalk tree = TreeWalk.forPath(r, path, treeId);
+				if (tree == null) {
+					throw new IOException("Entry not found by path: " + path);
+				}
+				ObjectId blobId = tree.getObjectId(0);
+				ObjectLoader loader = tree.getRepository().openBlob(blobId);
+				if (loader == null) {
+					throw new IOException("Blob not found: " + blobId + " for path: " + path);
+				}
+				return loader.getBytes();
+			}
+		});
+	}
+
+	@Override
+	protected InputStream openInputStream() throws IOException {
+		try {
+			return new ByteArrayInputStream(blobProvider.call());
+		} catch (IOException e) {
+			throw e;
+		} catch (RuntimeException e) {
+			throw e;
+		} catch (Exception e) {
+			throw new RuntimeException(e);
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
index 085e2b9..030d4a4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
@@ -149,6 +149,13 @@ public Commit(final Repository db, final ObjectId id, final byte[] raw) {
 	}
 
 	/**
+	 * @return get repository for the commit
+	 */
+	public Repository getRepository() {
+		return objdb;
+	}
+
+	/**
 	 * @return The commit object id
 	 */
 	public ObjectId getCommitId() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 250b213..5705936 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -103,7 +103,7 @@
 	 *             a tree object was not found.
 	 */
 	public static TreeWalk forPath(final Repository db, final String path,
-			final AnyObjectId[] trees) throws MissingObjectException,
+			final AnyObjectId... trees) throws MissingObjectException,
 			IncorrectObjectTypeException, CorruptObjectException, IOException {
 		final TreeWalk r = new TreeWalk(db);
 		r.setFilter(PathFilterGroup.createFromStrings(Collections
-- 
1.6.1.2
