From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 21/21] Bidirectional protocol support for Amazon S3
Date: Sun, 29 Jun 2008 03:59:31 -0400
Message-ID: <1214726371-93520-22-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
 <1214726371-93520-9-git-send-email-spearce@spearce.org>
 <1214726371-93520-10-git-send-email-spearce@spearce.org>
 <1214726371-93520-11-git-send-email-spearce@spearce.org>
 <1214726371-93520-12-git-send-email-spearce@spearce.org>
 <1214726371-93520-13-git-send-email-spearce@spearce.org>
 <1214726371-93520-14-git-send-email-spearce@spearce.org>
 <1214726371-93520-15-git-send-email-spearce@spearce.org>
 <1214726371-93520-16-git-send-email-spearce@spearce.org>
 <1214726371-93520-17-git-send-email-spearce@spearce.org>
 <1214726371-93520-18-git-send-email-spearce@spearce.org>
 <1214726371-93520-19-git-send-email-spearce@spearce.org>
 <1214726371-93520-20-git-send-email-spearce@spearce.org>
 <1214726371-93520-21-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:03:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrx-0000I1-6n
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbYF2IBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbYF2IB3
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:01:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36899 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYF2IAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpw-0004QT-68; Sun, 29 Jun 2008 04:00:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id B172A20FBAE; Sun, 29 Jun 2008 04:00:40 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id AE1F420FBDF;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-21-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86782>

The new "amazon-s3://" transport provides bi-directional communication
for Git repositories to the S3 service.  This may be useful for backup
of private data which users do not want published to the world.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Transport.java  |    3 +
 .../spearce/jgit/transport/TransportAmazonS3.java  |  319 ++++++++++++++++++++
 .../src/org/spearce/jgit/transport/URIish.java     |    2 +-
 3 files changed, 323 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 5376a9e..b962162 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -140,6 +140,9 @@ public abstract class Transport {
 		else if (TransportGitAnon.canHandle(remote))
 			return new TransportGitAnon(local, remote);
 
+		else if (TransportAmazonS3.canHandle(remote))
+			return new TransportAmazonS3(local, remote);
+
 		else if (TransportBundle.canHandle(remote))
 			return new TransportBundle(local, remote);
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
new file mode 100644
index 0000000..ceb6848
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
@@ -0,0 +1,319 @@
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
+import java.io.BufferedReader;
+import java.io.File;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.net.URLConnection;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.HashSet;
+import java.util.Map;
+import java.util.Properties;
+import java.util.TreeMap;
+
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Ref.Storage;
+import org.spearce.jgit.util.FS;
+
+/**
+ * Transport over the non-Git aware Amazon S3 protocol.
+ * <p>
+ * This transport communicates with the Amazon S3 servers (a non-free commercial
+ * hosting service that users must subscribe to). Some users may find transport
+ * to and from S3 to be a useful backup service.
+ * <p>
+ * The transport does not require any specialized Git support on the remote
+ * (server side) repository, as Amazon does not provide any such support.
+ * Repository files are retrieved directly through the S3 API, which uses
+ * extended HTTP/1.1 semantics. This make it possible to read or write Git data
+ * from a remote repository that is stored on S3.
+ * <p>
+ * Unlike the HTTP variant (see {@link TransportHttp}) we rely upon being able
+ * to list objects in a bucket, as the S3 API supports this function. By listing
+ * the bucket contents we can avoid relying on <code>objects/info/packs</code>
+ * or <code>info/refs</code> in the remote repository.
+ * <p>
+ * Concurrent pushing over this transport is not supported. Multiple concurrent
+ * push operations may cause confusion in the repository state.
+ * 
+ * @see WalkFetchConnection
+ * @see WalkPushConnection
+ */
+class TransportAmazonS3 extends WalkTransport {
+	static final String S3_SCHEME = "amazon-s3";
+
+	static boolean canHandle(final URIish uri) {
+		if (!uri.isRemote())
+			return false;
+		return S3_SCHEME.equals(uri.getScheme());
+	}
+
+	/** User information necessary to connect to S3. */
+	private final AmazonS3 s3;
+
+	/** Bucket the remote repository is stored in. */
+	private final String bucket;
+
+	/**
+	 * Key prefix which all objects related to the repository start with.
+	 * <p>
+	 * The prefix does not start with "/".
+	 * <p>
+	 * The prefix does not end with "/". The trailing slash is stripped during
+	 * the constructor if a trailing slash was supplied in the URIish.
+	 * <p>
+	 * All files within the remote repository start with
+	 * <code>keyPrefix + "/"</code>.
+	 */
+	private final String keyPrefix;
+
+	TransportAmazonS3(final Repository local, final URIish uri)
+			throws NotSupportedException {
+		super(local, uri);
+
+		Properties props = null;
+		File propsFile = new File(local.getDirectory(), uri.getUser());
+		if (!propsFile.isFile())
+			propsFile = new File(FS.userHome(), uri.getUser());
+		if (propsFile.isFile()) {
+			try {
+				props = AmazonS3.properties(propsFile);
+			} catch (IOException e) {
+				throw new NotSupportedException("cannot read " + propsFile, e);
+			}
+		} else {
+			props = new Properties();
+			props.setProperty("accesskey", uri.getUser());
+			props.setProperty("secretkey", uri.getPass());
+		}
+
+		s3 = new AmazonS3(props);
+		bucket = uri.getHost();
+
+		String p = uri.getPath();
+		if (p.startsWith("/"))
+			p = p.substring(1);
+		if (p.endsWith("/"))
+			p = p.substring(0, p.length() - 1);
+		keyPrefix = p;
+	}
+
+	@Override
+	public FetchConnection openFetch() throws TransportException {
+		final DatabaseS3 c = new DatabaseS3(bucket, keyPrefix + "/objects");
+		final WalkFetchConnection r = new WalkFetchConnection(this, c);
+		r.available(c.readAdvertisedRefs());
+		return r;
+	}
+
+	@Override
+	public PushConnection openPush() throws TransportException {
+		final DatabaseS3 c = new DatabaseS3(bucket, keyPrefix + "/objects");
+		final WalkPushConnection r = new WalkPushConnection(this, c);
+		r.available(c.readAdvertisedRefs());
+		return r;
+	}
+
+	class DatabaseS3 extends WalkRemoteObjectDatabase {
+		private final String bucketName;
+
+		private final String objectsKey;
+
+		DatabaseS3(final String b, final String o) {
+			bucketName = b;
+			objectsKey = o;
+		}
+
+		private String resolveKey(String subpath) {
+			if (subpath.endsWith("/"))
+				subpath = subpath.substring(0, subpath.length() - 1);
+			String k = objectsKey;
+			while (subpath.startsWith("../")) {
+				k = k.substring(0, k.lastIndexOf('/'));
+				subpath = subpath.substring(3);
+			}
+			return k + "/" + subpath;
+		}
+
+		@Override
+		URIish getURI() {
+			URIish u = new URIish();
+			u = u.setScheme(S3_SCHEME);
+			u = u.setHost(bucketName);
+			u = u.setPath("/" + objectsKey);
+			return u;
+		}
+
+		@Override
+		Collection<WalkRemoteObjectDatabase> getAlternates() throws IOException {
+			try {
+				return readAlternates(INFO_ALTERNATES);
+			} catch (FileNotFoundException err) {
+				// Fall through.
+			}
+			return null;
+		}
+
+		@Override
+		WalkRemoteObjectDatabase openAlternate(final String location)
+				throws IOException {
+			return new DatabaseS3(bucketName, resolveKey(location));
+		}
+
+		@Override
+		Collection<String> getPackNames() throws IOException {
+			final HashSet<String> have = new HashSet<String>();
+			have.addAll(s3.list(bucket, resolveKey("pack")));
+
+			final Collection<String> packs = new ArrayList<String>();
+			for (final String n : have) {
+				if (!n.startsWith("pack-") || !n.endsWith(".pack"))
+					continue;
+
+				final String in = n.substring(0, n.length() - 5) + ".idx";
+				if (have.contains(in))
+					packs.add(n);
+			}
+			return packs;
+		}
+
+		@Override
+		FileStream open(final String path) throws IOException {
+			final URLConnection c = s3.get(bucket, resolveKey(path));
+			final InputStream raw = c.getInputStream();
+			final InputStream in = s3.decrypt(c);
+			final int len = c.getContentLength();
+			return new FileStream(in, raw == in ? len : -1);
+		}
+
+		@Override
+		void deleteFile(final String path) throws IOException {
+			s3.delete(bucket, resolveKey(path));
+		}
+
+		@Override
+		OutputStream writeFile(final String path) throws IOException {
+			return s3.beginPut(bucket, resolveKey(path));
+		}
+
+		@Override
+		void writeFile(final String path, final byte[] data) throws IOException {
+			s3.put(bucket, resolveKey(path), data);
+		}
+
+		Map<String, Ref> readAdvertisedRefs() throws TransportException {
+			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
+			readPackedRefs(avail);
+			readLooseRefs(avail);
+			readRef(avail, "HEAD");
+			return avail;
+		}
+
+		private void readLooseRefs(final TreeMap<String, Ref> avail)
+				throws TransportException {
+			try {
+				for (final String n : s3.list(bucket, resolveKey("../refs")))
+					readRef(avail, "refs/" + n);
+			} catch (IOException e) {
+				throw new TransportException(getURI(), "cannot list refs", e);
+			}
+		}
+
+		private Ref readRef(final TreeMap<String, Ref> avail, final String rn)
+				throws TransportException {
+			final String s;
+			try {
+				final BufferedReader br = openReader("../" + rn);
+				try {
+					s = br.readLine();
+				} finally {
+					br.close();
+				}
+			} catch (FileNotFoundException noRef) {
+				return null;
+			} catch (IOException err) {
+				throw new TransportException(getURI(), "read ../" + rn, err);
+			}
+
+			if (s == null)
+				throw new TransportException(getURI(), "Empty ref: " + rn);
+
+			if (s.startsWith("ref: ")) {
+				final String target = s.substring("ref: ".length());
+				Ref r = avail.get(target);
+				if (r == null)
+					r = readRef(avail, target);
+				if (r == null)
+					return null;
+				r = new Ref(r.getStorage(), rn, r.getObjectId(), r
+						.getPeeledObjectId());
+				avail.put(r.getName(), r);
+				return r;
+			}
+
+			if (ObjectId.isId(s)) {
+				final Ref r = new Ref(loose(avail.get(rn)), rn, ObjectId
+						.fromString(s));
+				avail.put(r.getName(), r);
+				return r;
+			}
+
+			throw new TransportException(getURI(), "Bad ref: " + rn + ": " + s);
+		}
+
+		private Storage loose(final Ref r) {
+			if (r != null && r.getStorage() == Storage.PACKED)
+				return Storage.LOOSE_PACKED;
+			return Storage.LOOSE;
+		}
+
+		@Override
+		void close() {
+			// We do not maintain persistent connections.
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
index 9e7ca83..8aa5d35 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
@@ -51,7 +51,7 @@ import java.util.regex.Pattern;
  */
 public class URIish {
 	private static final Pattern FULL_URI = Pattern
-			.compile("^(?:([a-z+]+)://(?:([^/]+?)(?::([^/]+?))?@)?(?:([^/]+?))?(?::(\\d+))?)?((?:[A-Za-z]:)?/.+)$");
+			.compile("^(?:([a-z0-9+-]+)://(?:([^/]+?)(?::([^/]+?))?@)?(?:([^/]+?))?(?::(\\d+))?)?((?:[A-Za-z]:)?/.+)$");
 
 	private static final Pattern SCP_URI = Pattern
 			.compile("^(?:([^@]+?)@)?([^:]+?):(.+)$");
-- 
1.5.6.74.g8a5e
