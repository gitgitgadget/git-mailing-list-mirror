From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Include a progress meter for large uploads to Amazon S3
Date: Thu, 10 Jul 2008 02:13:19 -0400
Message-ID: <1215670403-19191-2-git-send-email-spearce@spearce.org>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:14:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGpQH-0004ug-D3
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 08:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbYGJGN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 02:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbYGJGN2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 02:13:28 -0400
Received: from george.spearce.org ([209.20.77.23]:55187 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYGJGN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 02:13:26 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5FF4B38268; Thu, 10 Jul 2008 06:13:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7F481381FC;
	Thu, 10 Jul 2008 06:13:24 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1215670403-19191-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87944>

If we are uploading a sizable pack file or idx file to the S3
service the upload happens after we have finished writing the pack
to a local temporary file.  This causes a long pause for the user
while they wait for the data transfer to complete, with no real
indication of progress happening.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/AmazonS3.java   |   29 +++++++++++++++----
 .../spearce/jgit/transport/TransportAmazonS3.java  |    7 +++-
 .../org/spearce/jgit/transport/TransportSftp.java  |    5 +++-
 .../spearce/jgit/transport/WalkPushConnection.java |    5 ++-
 .../jgit/transport/WalkRemoteObjectDatabase.java   |   11 ++++++-
 5 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
index e8575aa..59337f8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
@@ -75,6 +75,8 @@ import javax.crypto.spec.SecretKeySpec;
 
 import org.spearce.jgit.awtui.AwtAuthenticator;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.NullProgressMonitor;
+import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.util.Base64;
 import org.spearce.jgit.util.HttpSupport;
 import org.spearce.jgit.util.TemporaryBuffer;
@@ -376,7 +378,7 @@ public class AmazonS3 {
 			// We have to copy to produce the cipher text anyway so use
 			// the large object code path as it supports that behavior.
 			//
-			final OutputStream os = beginPut(bucket, key);
+			final OutputStream os = beginPut(bucket, key, null, null);
 			os.write(data);
 			os.close();
 			return;
@@ -430,11 +432,17 @@ public class AmazonS3 {
 	 *            name of the bucket storing the object.
 	 * @param key
 	 *            key of the object within its bucket.
+	 * @param monitor
+	 *            (optional) progress monitor to post upload completion to
+	 *            during the stream's close method.
+	 * @param monitorTask
+	 *            (optional) task name to display during the close method.
 	 * @return a stream which accepts the new data, and transmits once closed.
 	 * @throws IOException
 	 *             if encryption was enabled it could not be configured.
 	 */
-	public OutputStream beginPut(final String bucket, final String key)
+	public OutputStream beginPut(final String bucket, final String key,
+			final ProgressMonitor monitor, final String monitorTask)
 			throws IOException {
 		final MessageDigest md5 = newMD5();
 		final TemporaryBuffer buffer = new TemporaryBuffer() {
@@ -442,7 +450,8 @@ public class AmazonS3 {
 			public void close() throws IOException {
 				super.close();
 				try {
-					putImpl(bucket, key, md5.digest(), this);
+					putImpl(bucket, key, md5.digest(), this, monitor,
+							monitorTask);
 				} finally {
 					destroy();
 				}
@@ -452,7 +461,13 @@ public class AmazonS3 {
 	}
 
 	private void putImpl(final String bucket, final String key,
-			final byte[] csum, final TemporaryBuffer buf) throws IOException {
+			final byte[] csum, final TemporaryBuffer buf,
+			ProgressMonitor monitor, String monitorTask) throws IOException {
+		if (monitor == null)
+			monitor = NullProgressMonitor.INSTANCE;
+		if (monitorTask == null)
+			monitorTask = "Uploading " + key;
+
 		final String md5str = Base64.encodeBytes(csum);
 		final long len = buf.length();
 		final String lenstr = String.valueOf(len);
@@ -465,10 +480,12 @@ public class AmazonS3 {
 			authorize(c);
 			c.setDoOutput(true);
 			c.setFixedLengthStreamingMode((int) len);
+			monitor.beginTask(monitorTask, (int) (len / 1024));
 			final OutputStream os = c.getOutputStream();
 			try {
-				buf.writeTo(os, null);
+				buf.writeTo(os, monitor);
 			} finally {
+				monitor.endTask();
 				os.close();
 			}
 
@@ -641,7 +658,7 @@ public class AmazonS3 {
 		} else if ("rm".equals(op) || "delete".equals(op)) {
 			s3.delete(bucket, key);
 		} else if ("put".equals(op)) {
-			final OutputStream os = s3.beginPut(bucket, key);
+			final OutputStream os = s3.beginPut(bucket, key, null, null);
 			final byte[] tmp = new byte[2048];
 			int n;
 			while ((n = System.in.read(tmp)) > 0)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
index d2f4c83..cd62c5b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
@@ -54,6 +54,7 @@ import java.util.TreeMap;
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Ref.Storage;
@@ -236,8 +237,10 @@ class TransportAmazonS3 extends WalkTransport {
 		}
 
 		@Override
-		OutputStream writeFile(final String path) throws IOException {
-			return s3.beginPut(bucket, resolveKey(path));
+		OutputStream writeFile(final String path,
+				final ProgressMonitor monitor, final String monitorTask)
+				throws IOException {
+			return s3.beginPut(bucket, resolveKey(path), monitor, monitorTask);
 		}
 
 		@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index a33406b..c2cbe6a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -54,6 +54,7 @@ import java.util.TreeMap;
 
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Ref.Storage;
@@ -294,7 +295,9 @@ class TransportSftp extends WalkTransport {
 		}
 
 		@Override
-		OutputStream writeFile(final String path) throws IOException {
+		OutputStream writeFile(final String path,
+				final ProgressMonitor monitor, final String monitorTask)
+				throws IOException {
 			try {
 				return ftp.put(path);
 			} catch (SftpException je) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index bb5a653..904a699 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -230,14 +230,15 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 			// Write the pack file, then the index, as readers look the
 			// other direction (index, then pack file).
 			//
-			OutputStream os = dest.writeFile(pathPack);
+			final String wt = "Put " + base.substring(0, 12);
+			OutputStream os = dest.writeFile(pathPack, monitor, wt + "..pack");
 			try {
 				pw.writePack(os);
 			} finally {
 				os.close();
 			}
 
-			os = dest.writeFile(pathIdx);
+			os = dest.writeFile(pathIdx, monitor, wt + "..idx");
 			try {
 				pw.writeIndex(os);
 			} finally {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index 915faac..c5a5199 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -52,6 +52,7 @@ import java.util.Map;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.util.NB;
 
@@ -213,11 +214,17 @@ abstract class WalkRemoteObjectDatabase {
 	 *         complete the write request. The stream is not buffered and each
 	 *         write may cause a network request/response so callers should
 	 *         buffer to smooth out small writes.
+	 * @param monitor
+	 *            (optional) progress monitor to post write completion to during
+	 *            the stream's close method.
+	 * @param monitorTask
+	 *            (optional) task name to display during the close method.
 	 * @throws IOException
 	 *             writing is not supported, or attempting to write the file
 	 *             failed, possibly due to permissions or remote disk full, etc.
 	 */
-	OutputStream writeFile(final String path) throws IOException {
+	OutputStream writeFile(final String path, final ProgressMonitor monitor,
+			final String monitorTask) throws IOException {
 		throw new IOException("Writing of '" + path + "' not supported.");
 	}
 
@@ -247,7 +254,7 @@ abstract class WalkRemoteObjectDatabase {
 	 *             failed, possibly due to permissions or remote disk full, etc.
 	 */
 	void writeFile(final String path, final byte[] data) throws IOException {
-		final OutputStream os = writeFile(path);
+		final OutputStream os = writeFile(path, null, null);
 		try {
 			os.write(data);
 		} finally {
-- 
1.5.6.2.393.g45096
