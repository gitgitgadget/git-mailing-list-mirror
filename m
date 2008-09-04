From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/7] Refactor bundle transport to permit streaming from application
Date: Thu,  4 Sep 2008 16:42:19 -0700
Message-ID: <1220571739-4219-8-git-send-email-spearce@spearce.org>
References: <1220571739-4219-1-git-send-email-spearce@spearce.org>
 <1220571739-4219-2-git-send-email-spearce@spearce.org>
 <1220571739-4219-3-git-send-email-spearce@spearce.org>
 <1220571739-4219-4-git-send-email-spearce@spearce.org>
 <1220571739-4219-5-git-send-email-spearce@spearce.org>
 <1220571739-4219-6-git-send-email-spearce@spearce.org>
 <1220571739-4219-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOUt-0000st-3S
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbYIDXma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYIDXm1
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:27 -0400
Received: from george.spearce.org ([209.20.77.23]:33780 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYIDXmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E6CBD3835F; Thu,  4 Sep 2008 23:42:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2192338377;
	Thu,  4 Sep 2008 23:42:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
In-Reply-To: <1220571739-4219-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94979>

The new TransportBundleStream is public and can be created by an
application directly from any InputStream.  This permits the app
to obtain the bundle data on its own via any means and feed it
into the bundle transport.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Transport.java  |    4 +-
 .../spearce/jgit/transport/TransportBundle.java    |   36 +-------
 .../jgit/transport/TransportBundleFile.java        |   82 +++++++++++++++
 .../jgit/transport/TransportBundleStream.java      |  105 ++++++++++++++++++++
 4 files changed, 191 insertions(+), 36 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 65f2c6b..7284b28 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -204,8 +204,8 @@ else if (TransportGitAnon.canHandle(remote))
 		else if (TransportAmazonS3.canHandle(remote))
 			return new TransportAmazonS3(local, remote);
 
-		else if (TransportBundle.canHandle(remote))
-			return new TransportBundle(local, remote);
+		else if (TransportBundleFile.canHandle(remote))
+			return new TransportBundleFile(local, remote);
 
 		else if (TransportLocal.canHandle(remote))
 			return new TransportLocal(local, remote);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 765fc0f..fed34e8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -40,9 +40,6 @@
 package org.spearce.jgit.transport;
 
 import java.io.BufferedInputStream;
-import java.io.File;
-import java.io.FileInputStream;
-import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStream;
 import java.util.ArrayList;
@@ -52,8 +49,8 @@
 import java.util.List;
 import java.util.Set;
 
-import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.MissingBundlePrerequisiteException;
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.PackProtocolException;
 import org.spearce.jgit.errors.TransportException;
@@ -66,7 +63,6 @@
 import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevWalk;
-import org.spearce.jgit.util.FS;
 import org.spearce.jgit.util.RawParseUtils;
 
 /**
@@ -76,39 +72,11 @@
  * communicate with to decide what the peer already knows. So push is not
  * supported by the bundle transport.
  */
-class TransportBundle extends PackTransport {
+abstract class TransportBundle extends PackTransport {
 	static final String V2_BUNDLE_SIGNATURE = "# v2 git bundle";
 
-	static boolean canHandle(final URIish uri) {
-		if (uri.getHost() != null || uri.getPort() > 0 || uri.getUser() != null
-				|| uri.getPass() != null || uri.getPath() == null)
-			return false;
-
-		if ("file".equals(uri.getScheme()) || uri.getScheme() == null) {
-			final File f = FS.resolve(new File("."), uri.getPath());
-			return f.isFile() || f.getName().endsWith(".bundle");
-		}
-
-		return false;
-	}
-
-	private final File bundle;
-
 	TransportBundle(final Repository local, final URIish uri) {
 		super(local, uri);
-		bundle = FS.resolve(new File("."), uri.getPath()).getAbsoluteFile();
-	}
-
-	@Override
-	public FetchConnection openFetch() throws NotSupportedException,
-			TransportException {
-		final InputStream src;
-		try {
-			src = new FileInputStream(bundle);
-		} catch (FileNotFoundException err) {
-			throw new TransportException(uri, "not found");
-		}
-		return new BundleFetchConnection(src);
 	}
 
 	@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
new file mode 100644
index 0000000..c9ff1b2
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.transport;
+
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.InputStream;
+
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.util.FS;
+
+class TransportBundleFile extends TransportBundle {
+	static boolean canHandle(final URIish uri) {
+		if (uri.getHost() != null || uri.getPort() > 0 || uri.getUser() != null
+				|| uri.getPass() != null || uri.getPath() == null)
+			return false;
+
+		if ("file".equals(uri.getScheme()) || uri.getScheme() == null) {
+			final File f = FS.resolve(new File("."), uri.getPath());
+			return f.isFile() || f.getName().endsWith(".bundle");
+		}
+
+		return false;
+	}
+
+	private final File bundle;
+
+	TransportBundleFile(final Repository local, final URIish uri) {
+		super(local, uri);
+		bundle = FS.resolve(new File("."), uri.getPath()).getAbsoluteFile();
+	}
+
+	@Override
+	public FetchConnection openFetch() throws NotSupportedException,
+			TransportException {
+		final InputStream src;
+		try {
+			src = new FileInputStream(bundle);
+		} catch (FileNotFoundException err) {
+			throw new TransportException(uri, "not found");
+		}
+		return new BundleFetchConnection(src);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java
new file mode 100644
index 0000000..0272261
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.transport;
+
+import java.io.IOException;
+import java.io.InputStream;
+
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * Single shot fetch from a streamed Git bundle.
+ * <p>
+ * The bundle is read from an unbuffered input stream, which limits the
+ * transport to opening at most one FetchConnection before needing to recreate
+ * the transport instance.
+ */
+public class TransportBundleStream extends TransportBundle {
+	private InputStream src;
+
+	/**
+	 * Create a new transport to fetch objects from a streamed bundle.
+	 * <p>
+	 * The stream can be unbuffered (buffering is automatically provided
+	 * internally to smooth out short reads) and unpositionable (the stream is
+	 * read from only once, sequentially).
+	 * <p>
+	 * When the FetchConnection or the this instance is closed the supplied
+	 * input stream is also automatically closed. This frees callers from
+	 * needing to keep track of the supplied stream.
+	 * 
+	 * @param db
+	 *            repository the fetched objects will be loaded into.
+	 * @param uri
+	 *            symbolic name of the source of the stream. The URI can
+	 *            reference a non-existent resource. It is used only for
+	 *            exception reporting.
+	 * @param in
+	 *            the stream to read the bundle from.
+	 */
+	public TransportBundleStream(final Repository db, final URIish uri,
+			final InputStream in) {
+		super(db, uri);
+		src = in;
+	}
+
+	@Override
+	public FetchConnection openFetch() throws TransportException {
+		if (src == null)
+			throw new TransportException(uri, "Only one fetch supported");
+		try {
+			return new BundleFetchConnection(src);
+		} finally {
+			src = null;
+		}
+	}
+
+	@Override
+	public void close() {
+		if (src != null) {
+			try {
+				src.close();
+			} catch (IOException err) {
+				// Ignore a close error.
+			} finally {
+				src = null;
+			}
+		}
+	}
+}
-- 
1.6.0.1.319.g9f32b
