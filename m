From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/11] Use cached Repository instances when resolving alternates
Date: Sat, 11 Jul 2009 13:19:25 -0700
Message-ID: <1247343566-19025-11-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
 <1247343566-19025-5-git-send-email-spearce@spearce.org>
 <1247343566-19025-6-git-send-email-spearce@spearce.org>
 <1247343566-19025-7-git-send-email-spearce@spearce.org>
 <1247343566-19025-8-git-send-email-spearce@spearce.org>
 <1247343566-19025-9-git-send-email-spearce@spearce.org>
 <1247343566-19025-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj3s-0003g9-SJ
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbZGKUTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbZGKUTs
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:48 -0400
Received: from george.spearce.org ([209.20.77.23]:39719 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbZGKUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7B38E38222; Sat, 11 Jul 2009 20:19:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2A28D38194;
	Sat, 11 Jul 2009 20:19:30 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123127>

Using a cached Repository instance when opening an alternate object
database ensures that if multiple repositories share the same base
repository (e.g. 4 forks of the Linux kernel all share the same
base "linus-2.6.git" repository) then the base object directory is
only monitored and tracked once in the JVM, instead of 4 times.  In
the case of the WindowCache, this means we will have greater reuse
of the windows from the base, as they won't be loaded 4 different
times under different keys.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/lib/AlternateRepositoryDatabase.java      |  127 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |   16 ++-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |   18 +++-
 3 files changed, 155 insertions(+), 6 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
new file mode 100644
index 0000000..ee4c4cf
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
@@ -0,0 +1,127 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+import java.util.Collection;
+
+/**
+ * An ObjectDatabase of another {@link Repository}.
+ * <p>
+ * This {@code ObjectDatabase} wraps around another {@code Repository}'s object
+ * database, providing its contents to the caller, and closing the Repository
+ * when this database is closed. The primary user of this class is
+ * {@link ObjectDirectory}, when the {@code info/alternates} file points at the
+ * {@code objects/} directory of another repository.
+ */
+public final class AlternateRepositoryDatabase extends ObjectDatabase {
+	private final Repository repository;
+
+	private final ObjectDatabase odb;
+
+	/**
+	 * @param alt
+	 *            the alternate repository to wrap and export.
+	 */
+	public AlternateRepositoryDatabase(final Repository alt) {
+		repository = alt;
+		odb = repository.getObjectDatabase();
+	}
+
+	/** @return the alternate repository objects are borrowed from. */
+	public Repository getRepository() {
+		return repository;
+	}
+
+	public void closeSelf() {
+		repository.close();
+	}
+
+	public void create() throws IOException {
+		repository.create();
+	}
+
+	public boolean exists() {
+		return odb.exists();
+	}
+
+	@Override
+	protected boolean hasObject1(final AnyObjectId objectId) {
+		return odb.hasObject1(objectId);
+	}
+
+	@Override
+	protected boolean tryAgain1() {
+		return odb.tryAgain1();
+	}
+
+	@Override
+	protected boolean hasObject2(final String objectName) {
+		return odb.hasObject2(objectName);
+	}
+
+	@Override
+	protected ObjectLoader openObject1(final WindowCursor curs,
+			final AnyObjectId objectId) throws IOException {
+		return odb.openObject1(curs, objectId);
+	}
+
+	@Override
+	protected ObjectLoader openObject2(final WindowCursor curs,
+			final String objectName, final AnyObjectId objectId)
+			throws IOException {
+		return odb.openObject2(curs, objectName, objectId);
+	}
+
+	@Override
+	void openObjectInAllPacks1(final Collection<PackedObjectLoader> out,
+			final WindowCursor curs, final AnyObjectId objectId)
+			throws IOException {
+		odb.openObjectInAllPacks1(out, curs, objectId);
+	}
+
+	@Override
+	protected ObjectDatabase[] loadAlternates() throws IOException {
+		return odb.getAlternates();
+	}
+
+	@Override
+	protected void closeAlternates(final ObjectDatabase[] alt) {
+		// Do nothing; these belong to odb to close, not us.
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
index 6a9ba4e..a547052 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -108,9 +108,7 @@ public final void closeAlternates() {
 		ObjectDatabase[] alt = alternates.get();
 		if (alt != null) {
 			alternates.set(null);
-			for (final ObjectDatabase d : alt) {
-				d.close();
-			}
+			closeAlternates(alt);
 		}
 	}
 
@@ -364,4 +362,16 @@ protected boolean tryAgain1() {
 	protected ObjectDatabase[] loadAlternates() throws IOException {
 		return NO_ALTERNATES;
 	}
+
+	/**
+	 * Close the list of alternates returned by {@link #loadAlternates()}.
+	 *
+	 * @param alt
+	 *            the alternate list, from {@link #loadAlternates()}.
+	 */
+	protected void closeAlternates(ObjectDatabase[] alt) {
+		for (final ObjectDatabase d : alt) {
+			d.close();
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index d3c43da..7cc459c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -52,6 +52,7 @@
 import java.util.concurrent.atomic.AtomicReference;
 
 import org.spearce.jgit.errors.PackMismatchException;
+import org.spearce.jgit.lib.RepositoryCache.FileKey;
 import org.spearce.jgit.util.FS;
 
 /**
@@ -415,11 +416,11 @@ public boolean accept(final File baseDir, final String n) {
 	@Override
 	protected ObjectDatabase[] loadAlternates() throws IOException {
 		final BufferedReader br = open(alternatesFile);
-		final List<ObjectDirectory> l = new ArrayList<ObjectDirectory>(4);
+		final List<ObjectDatabase> l = new ArrayList<ObjectDatabase>(4);
 		try {
 			String line;
 			while ((line = br.readLine()) != null) {
-				l.add(new ObjectDirectory(FS.resolve(objects, line)));
+				l.add(openAlternate(line));
 			}
 		} finally {
 			br.close();
@@ -428,11 +429,22 @@ public boolean accept(final File baseDir, final String n) {
 		if (l.isEmpty()) {
 			return NO_ALTERNATES;
 		}
-		return l.toArray(new ObjectDirectory[l.size()]);
+		return l.toArray(new ObjectDatabase[l.size()]);
 	}
 
 	private static BufferedReader open(final File f)
 			throws FileNotFoundException {
 		return new BufferedReader(new FileReader(f));
 	}
+
+	private ObjectDatabase openAlternate(final String location)
+			throws IOException {
+		final File objdir = FS.resolve(objects, location);
+		final File parent = objdir.getParentFile();
+		if (FileKey.isGitRepository(parent)) {
+			final Repository db = RepositoryCache.open(FileKey.exact(parent));
+			return new AlternateRepositoryDatabase(db);
+		}
+		return new ObjectDirectory(objdir);
+	}
 }
-- 
1.6.4.rc0.117.g28cb
