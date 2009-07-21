From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/12] Use NB.readFully(File) to slurp complete file contents
Date: Tue, 21 Jul 2009 13:19:19 -0700
Message-ID: <1248207570-13880-2-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpv-0001jT-BW
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133AbZGUUTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbZGUUTi
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:38 -0400
Received: from george.spearce.org ([209.20.77.23]:59239 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbZGUUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 504C5381FE; Tue, 21 Jul 2009 20:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 56C47381FE;
	Tue, 21 Jul 2009 20:19:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123699>

When we want the entire file contents and its likely a very small
file (e.g. a ref, configuration file) NB.readFully(File) is an
easier method to get the content then using FileInputStream from
application code.

When looking at a file that we believe should contain only a SHA-1
or be a symbolic ref to another file within this repository,
we use a maximum read cap of 4096 bytes for the slurp, so that
we don't accidentally allocate a very large buffer and blow the
JVM heap up.  This reasonableness cap is particularly important
for the RepositoryCache.FileKey.isGitRepository() test logic, in
case it comes across a file called HEAD that isn't really part of
a Git repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Due to the patch to RepositoryCache here, this applies on top of
 my other 11 patch series that introduced the class.

 .../src/org/spearce/jgit/lib/RefDatabase.java      |   15 +++--
 .../src/org/spearce/jgit/lib/ReflogReader.java     |   32 ++++--------
 .../src/org/spearce/jgit/lib/RepositoryCache.java  |   20 +++----
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   15 +-----
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   52 ++++++++++++++++++++
 5 files changed, 81 insertions(+), 53 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 383877f..f7751c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -52,6 +52,8 @@
 import org.spearce.jgit.errors.ObjectWritingException;
 import org.spearce.jgit.lib.Ref.Storage;
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 class RefDatabase {
 	private static final String REFS_SLASH = "refs/";
@@ -494,12 +496,13 @@ protected void writeFile(String name, byte[] content) throws IOException {
 
 	private static String readLine(final File file)
 			throws FileNotFoundException, IOException {
-		final BufferedReader br = openReader(file);
-		try {
-			return br.readLine();
-		} finally {
-			br.close();
-		}
+		final byte[] buf = NB.readFully(file, 4096);
+		int n = buf.length;
+		if (n == 0)
+			return null;
+		if (buf[n - 1] == '\n')
+			n--;
+		return RawParseUtils.decode(buf, 0, n);
 	}
 
 	private static BufferedReader openReader(final File fileLocation)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
index e86a723..5f2d28c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
@@ -37,7 +37,6 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
-import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.util.ArrayList;
@@ -157,31 +156,20 @@ public Entry getLastEntry() throws IOException {
 	 * @throws IOException
 	 */
 	public List<Entry> getReverseEntries(int max) throws IOException {
-		FileInputStream fileInputStream;
+		final byte[] log;
 		try {
-			fileInputStream = new FileInputStream(logName);
+			log = NB.readFully(logName);
 		} catch (FileNotFoundException e) {
 			return Collections.emptyList();
 		}
-		try {
-			long logSize = fileInputStream.getChannel().size();
-			if (logSize > Integer.MAX_VALUE) {
-				// implementation limit, will suck with smaller files too
-				throw new IOException("Cannot handle reflog larger than "
-						+ Integer.MAX_VALUE + " bytes");
-			}
-			byte[] log = new byte[(int) logSize];
-			NB.readFully(fileInputStream, log, 0, log.length);
-			int rs = RawParseUtils.prevLF(log, log.length);
-			List<Entry> ret = new ArrayList<Entry>();
-			while (rs >= 0 && max-- > 0) {
-				rs = RawParseUtils.prevLF(log, rs);
-				Entry entry = new Entry(log, rs < 0 ? 0 : rs + 2);
-				ret.add(entry);
-			}
-			return ret;
-		} finally {
-			fileInputStream.close();
+
+		int rs = RawParseUtils.prevLF(log, log.length);
+		List<Entry> ret = new ArrayList<Entry>();
+		while (rs >= 0 && max-- > 0) {
+			rs = RawParseUtils.prevLF(log, rs);
+			Entry entry = new Entry(log, rs < 0 ? 0 : rs + 2);
+			ret.add(entry);
 		}
+		return ret;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
index 50b4330..5f90b55 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
@@ -37,11 +37,8 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.BufferedReader;
 import java.io.File;
-import java.io.FileInputStream;
 import java.io.IOException;
-import java.io.InputStreamReader;
 import java.lang.ref.Reference;
 import java.lang.ref.WeakReference;
 import java.util.Iterator;
@@ -50,6 +47,8 @@
 
 import org.spearce.jgit.errors.RepositoryNotFoundException;
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /** Cache of active {@link Repository} instances. */
 public class RepositoryCache {
@@ -341,14 +340,13 @@ private static boolean isValidHead(final File head) {
 
 		private static String readFirstLine(final File head) {
 			try {
-				final BufferedReader br = new BufferedReader(
-						new InputStreamReader(new FileInputStream(head),
-								Constants.CHARSET));
-				try {
-					return br.readLine();
-				} finally {
-					br.close();
-				}
+				final byte[] buf = NB.readFully(head, 4096);
+				int n = buf.length;
+				if (n == 0)
+					return null;
+				if (buf[n - 1] == '\n')
+					n--;
+				return RawParseUtils.decode(buf, 0, n);
 			} catch (IOException e) {
 				return null;
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index e2de41c..b5abeb9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -39,7 +39,6 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
-import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.util.zip.DataFormatException;
@@ -74,19 +73,7 @@
 	 */
 	public UnpackedObjectLoader(final File path, final AnyObjectId id)
 			throws IOException {
-		this(readCompressed(path), id);
-	}
-
-	private static byte[] readCompressed(final File path)
-			throws FileNotFoundException, IOException {
-		final FileInputStream in = new FileInputStream(path);
-		try {
-			final byte[] compressed = new byte[(int) in.getChannel().size()];
-			NB.readFully(in, compressed, 0, compressed.length);
-			return compressed;
-		} finally {
-			in.close();
-		}
+		this(NB.readFully(path), id);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
index 032997f..17b3398 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
@@ -38,6 +38,9 @@
 package org.spearce.jgit.util;
 
 import java.io.EOFException;
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStream;
 import java.nio.ByteBuffer;
@@ -46,6 +49,55 @@
 /** Conversion utilities for network byte order handling. */
 public final class NB {
 	/**
+	 * Read an entire local file into memory as a byte array.
+	 *
+	 * @param path
+	 *            location of the file to read.
+	 * @return complete contents of the requested local file.
+	 * @throws FileNotFoundException
+	 *             the file does not exist.
+	 * @throws IOException
+	 *             the file exists, but its contents cannot be read.
+	 */
+	public static final byte[] readFully(final File path)
+			throws FileNotFoundException, IOException {
+		return readFully(path, Integer.MAX_VALUE);
+	}
+
+	/**
+	 * Read an entire local file into memory as a byte array.
+	 *
+	 * @param path
+	 *            location of the file to read.
+	 * @param max
+	 *            maximum number of bytes to read, if the file is larger than
+	 *            this limit an IOException is thrown.
+	 * @return complete contents of the requested local file.
+	 * @throws FileNotFoundException
+	 *             the file does not exist.
+	 * @throws IOException
+	 *             the file exists, but its contents cannot be read.
+	 */
+	public static final byte[] readFully(final File path, final int max)
+			throws FileNotFoundException, IOException {
+		final FileInputStream in = new FileInputStream(path);
+		try {
+			final long sz = in.getChannel().size();
+			if (sz > max)
+				throw new IOException("File is too large: " + path);
+			final byte[] buf = new byte[(int) sz];
+			readFully(in, buf, 0, buf.length);
+			return buf;
+		} finally {
+			try {
+				in.close();
+			} catch (IOException ignored) {
+				// ignore any close errors, this was a read only stream
+			}
+		}
+	}
+
+	/**
 	 * Read the entire byte array into memory, or throw an exception.
 	 * 
 	 * @param fd
-- 
1.6.4.rc1.186.g60aa0c
