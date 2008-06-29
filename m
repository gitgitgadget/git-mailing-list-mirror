From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 20/21] Add client side encryption to Amazon S3 client library
Date: Sun, 29 Jun 2008 03:59:30 -0400
Message-ID: <1214726371-93520-21-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:03:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrw-0000I1-C8
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYF2IB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbYF2IB0
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:01:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36894 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbYF2IAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpt-0004Q4-2p; Sun, 29 Jun 2008 04:00:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 98DA520FBAE; Sun, 29 Jun 2008 04:00:37 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id AA46720FBDE;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-20-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86783>

By encrypting (and decrypting) all data on the client side we
are able to safely hide the content of our repository from the
owners/operators the Amazon S3 service, making it a secure backup
solution for Git repositories.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/AmazonS3.java   |   82 ++++++++-
 .../org/spearce/jgit/transport/WalkEncryption.java |  188 ++++++++++++++++++++
 2 files changed, 266 insertions(+), 4 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/WalkEncryption.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
index 466d9e9..4c82967 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
@@ -37,6 +37,7 @@
 
 package org.spearce.jgit.transport;
 
+import java.io.ByteArrayOutputStream;
 import java.io.EOFException;
 import java.io.File;
 import java.io.FileInputStream;
@@ -53,6 +54,7 @@ import java.security.DigestOutputStream;
 import java.security.InvalidKeyException;
 import java.security.MessageDigest;
 import java.security.NoSuchAlgorithmException;
+import java.security.spec.InvalidKeySpecException;
 import java.text.SimpleDateFormat;
 import java.util.ArrayList;
 import java.util.Collections;
@@ -93,6 +95,11 @@ import org.xml.sax.helpers.XMLReaderFactory;
  * <p>
  * Authentication is always performed using the user's AWSAccessKeyId and their
  * private AWSSecretAccessKey.
+ * <p>
+ * Optional client-side encryption may be enabled if requested. The format is
+ * compatible with <a href="http://jets3t.s3.amazonaws.com/index.html">jets3t</a>,
+ * a popular Java based Amazon S3 client library. Enabling encryption can hide
+ * sensitive data from the operators of the S3 service.
  */
 public class AmazonS3 {
 	private static final Set<String> SIGNED_HEADERS;
@@ -103,6 +110,8 @@ public class AmazonS3 {
 
 	private static final String X_AMZ_ACL = "x-amz-acl";
 
+	private static final String X_AMZ_META = "x-amz-meta-";
+
 	static {
 		SIGNED_HEADERS = new HashSet<String>();
 		SIGNED_HEADERS.add("content-type");
@@ -161,6 +170,9 @@ public class AmazonS3 {
 	/** Maximum number of times to try an operation. */
 	private final int maxAttempts;
 
+	/** Encryption algorithm, may be a null instance that provides pass-through. */
+	private final WalkEncryption encryption;
+
 	/**
 	 * Create a new S3 client for the supplied user information.
 	 * <p>
@@ -179,6 +191,10 @@ public class AmazonS3 {
 	 * 
 	 * # Number of times to retry after internal error from S3.
 	 * httpclient.retry-max: 3
+	 * 
+	 * # End-to-end encryption (hides content from S3 owners)
+	 * password: &lt;encryption pass-phrase&gt;
+	 * crypto.algorithm: PBEWithMD5AndDES
 	 * </pre>
 	 * 
 	 * @param props
@@ -207,6 +223,22 @@ public class AmazonS3 {
 		else
 			throw new IllegalArgumentException("Invalid acl: " + pacl);
 
+		try {
+			final String cPas = props.getProperty("password");
+			if (cPas != null) {
+				String cAlg = props.getProperty("crypto.algorithm");
+				if (cAlg == null)
+					cAlg = "PBEWithMD5AndDES";
+				encryption = new WalkEncryption.ObjectEncryptionV2(cAlg, cPas);
+			} else {
+				encryption = WalkEncryption.NONE;
+			}
+		} catch (InvalidKeySpecException e) {
+			throw new IllegalArgumentException("Invalid encryption", e);
+		} catch (NoSuchAlgorithmException e) {
+			throw new IllegalArgumentException("Invalid encryption", e);
+		}
+
 		maxAttempts = Integer.parseInt(props.getProperty(
 				"httpclient.retry-max", "3"));
 		proxySelector = ProxySelector.getDefault();
@@ -232,6 +264,7 @@ public class AmazonS3 {
 			authorize(c);
 			switch (HttpSupport.response(c)) {
 			case HttpURLConnection.HTTP_OK:
+				encryption.validate(c, X_AMZ_META);
 				return c;
 			case HttpURLConnection.HTTP_NOT_FOUND:
 				throw new FileNotFoundException(key);
@@ -245,6 +278,19 @@ public class AmazonS3 {
 	}
 
 	/**
+	 * Decrypt an input stream from {@link #get(String, String)}.
+	 * 
+	 * @param u
+	 *            connection previously created by {@link #get(String, String)}}.
+	 * @return stream to read plain text from.
+	 * @throws IOException
+	 *             decryption could not be configured.
+	 */
+	public InputStream decrypt(final URLConnection u) throws IOException {
+		return encryption.decrypt(u.getInputStream());
+	}
+
+	/**
 	 * List the names of keys available within a bucket.
 	 * <p>
 	 * This method is primarily meant for obtaining a "recursive directory
@@ -326,6 +372,16 @@ public class AmazonS3 {
 	 */
 	public void put(final String bucket, final String key, final byte[] data)
 			throws IOException {
+		if (encryption != WalkEncryption.NONE) {
+			// We have to copy to produce the cipher text anyway so use
+			// the large object code path as it supports that behavior.
+			//
+			final OutputStream os = beginPut(bucket, key);
+			os.write(data);
+			os.close();
+			return;
+		}
+
 		final String md5str = Base64.encodeBytes(newMD5().digest(data));
 		final String lenstr = String.valueOf(data.length);
 		for (int curAttempt = 0; curAttempt < maxAttempts; curAttempt++) {
@@ -375,8 +431,11 @@ public class AmazonS3 {
 	 * @param key
 	 *            key of the object within its bucket.
 	 * @return a stream which accepts the new data, and transmits once closed.
+	 * @throws IOException
+	 *             if encryption was enabled it could not be configured.
 	 */
-	public OutputStream beginPut(final String bucket, final String key) {
+	public OutputStream beginPut(final String bucket, final String key)
+			throws IOException {
 		final MessageDigest md5 = newMD5();
 		final TemporaryBuffer buffer = new TemporaryBuffer() {
 			@Override
@@ -389,7 +448,7 @@ public class AmazonS3 {
 				}
 			}
 		};
-		return new DigestOutputStream(buffer, md5);
+		return encryption.encrypt(new DigestOutputStream(buffer, md5));
 	}
 
 	private void putImpl(final String bucket, final String key,
@@ -402,6 +461,7 @@ public class AmazonS3 {
 			c.setRequestProperty("Content-Length", lenstr);
 			c.setRequestProperty("Content-MD5", md5str);
 			c.setRequestProperty(X_AMZ_ACL, acl);
+			encryption.request(c, X_AMZ_META);
 			authorize(c);
 			c.setDoOutput(true);
 			c.setFixedLengthStreamingMode((int) len);
@@ -426,8 +486,22 @@ public class AmazonS3 {
 
 	private IOException error(final String action, final String key,
 			final HttpURLConnection c) throws IOException {
-		return new IOException(action + " of '" + key + "' failed: "
-				+ HttpSupport.response(c) + " " + c.getResponseMessage());
+		final IOException err = new IOException(action + " of '" + key
+				+ "' failed: " + HttpSupport.response(c) + " "
+				+ c.getResponseMessage());
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		byte[] buf = new byte[2048];
+		for (;;) {
+			final int n = c.getErrorStream().read(buf);
+			if (n < 0)
+				break;
+			if (n > 0)
+				b.write(buf, 0, n);
+		}
+		buf = b.toByteArray();
+		if (buf.length > 0)
+			err.initCause(new IOException("\n" + new String(buf)));
+		return err;
 	}
 
 	private IOException maxAttempts(final String action, final String key) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkEncryption.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkEncryption.java
new file mode 100644
index 0000000..cec6d75
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkEncryption.java
@@ -0,0 +1,188 @@
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
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.net.HttpURLConnection;
+import java.security.InvalidAlgorithmParameterException;
+import java.security.InvalidKeyException;
+import java.security.NoSuchAlgorithmException;
+import java.security.spec.InvalidKeySpecException;
+
+import javax.crypto.Cipher;
+import javax.crypto.CipherInputStream;
+import javax.crypto.CipherOutputStream;
+import javax.crypto.NoSuchPaddingException;
+import javax.crypto.SecretKey;
+import javax.crypto.SecretKeyFactory;
+import javax.crypto.spec.PBEKeySpec;
+import javax.crypto.spec.PBEParameterSpec;
+
+abstract class WalkEncryption {
+	static final WalkEncryption NONE = new NoEncryption();
+
+	static final String JETS3T_CRYPTO_VER = "jets3t-crypto-ver";
+
+	static final String JETS3T_CRYPTO_ALG = "jets3t-crypto-alg";
+
+	abstract OutputStream encrypt(OutputStream os) throws IOException;
+
+	abstract InputStream decrypt(InputStream in) throws IOException;
+
+	abstract void request(HttpURLConnection u, String prefix);
+
+	abstract void validate(HttpURLConnection u, String p) throws IOException;
+
+	protected void validateImpl(final HttpURLConnection u, final String p,
+			final String version, final String name) throws IOException {
+		String v;
+
+		v = u.getHeaderField(p + JETS3T_CRYPTO_VER);
+		if (v == null)
+			v = "";
+		if (!version.equals(v))
+			throw new IOException("Unsupported encryption version: " + v);
+
+		v = u.getHeaderField(p + JETS3T_CRYPTO_ALG);
+		if (v == null)
+			v = "";
+		if (!name.equals(v))
+			throw new IOException("Unsupported encryption algorithm: " + v);
+	}
+
+	IOException error(final Throwable why) {
+		final IOException e;
+		e = new IOException("Encryption error: " + why.getMessage());
+		e.initCause(why);
+		return e;
+	}
+
+	private static class NoEncryption extends WalkEncryption {
+		@Override
+		void request(HttpURLConnection u, String prefix) {
+			// Don't store any request properties.
+		}
+
+		@Override
+		void validate(final HttpURLConnection u, final String p)
+				throws IOException {
+			validateImpl(u, p, "", "");
+		}
+
+		@Override
+		InputStream decrypt(InputStream in) {
+			return in;
+		}
+
+		@Override
+		OutputStream encrypt(OutputStream os) {
+			return os;
+		}
+	}
+
+	static class ObjectEncryptionV2 extends WalkEncryption {
+		private static int ITERATION_COUNT = 5000;
+
+		private static byte[] salt = { (byte) 0xA4, (byte) 0x0B, (byte) 0xC8,
+				(byte) 0x34, (byte) 0xD6, (byte) 0x95, (byte) 0xF3, (byte) 0x13 };
+
+		private final String algorithmName;
+
+		private final SecretKey skey;
+
+		private final PBEParameterSpec aspec;
+
+		ObjectEncryptionV2(final String algo, final String key)
+				throws InvalidKeySpecException, NoSuchAlgorithmException {
+			algorithmName = algo;
+
+			final PBEKeySpec s;
+			s = new PBEKeySpec(key.toCharArray(), salt, ITERATION_COUNT, 32);
+			skey = SecretKeyFactory.getInstance(algo).generateSecret(s);
+			aspec = new PBEParameterSpec(salt, ITERATION_COUNT);
+		}
+
+		@Override
+		void request(final HttpURLConnection u, final String prefix) {
+			u.setRequestProperty(prefix + JETS3T_CRYPTO_VER, "2");
+			u.setRequestProperty(prefix + JETS3T_CRYPTO_ALG, algorithmName);
+		}
+
+		@Override
+		void validate(final HttpURLConnection u, final String p)
+				throws IOException {
+			validateImpl(u, p, "2", algorithmName);
+		}
+
+		@Override
+		OutputStream encrypt(final OutputStream os) throws IOException {
+			try {
+				final Cipher c = Cipher.getInstance(algorithmName);
+				c.init(Cipher.ENCRYPT_MODE, skey, aspec);
+				return new CipherOutputStream(os, c);
+			} catch (NoSuchAlgorithmException e) {
+				throw error(e);
+			} catch (NoSuchPaddingException e) {
+				throw error(e);
+			} catch (InvalidKeyException e) {
+				throw error(e);
+			} catch (InvalidAlgorithmParameterException e) {
+				throw error(e);
+			}
+		}
+
+		@Override
+		InputStream decrypt(final InputStream in) throws IOException {
+			try {
+				final Cipher c = Cipher.getInstance(algorithmName);
+				c.init(Cipher.DECRYPT_MODE, skey, aspec);
+				return new CipherInputStream(in, c);
+			} catch (NoSuchAlgorithmException e) {
+				throw error(e);
+			} catch (NoSuchPaddingException e) {
+				throw error(e);
+			} catch (InvalidKeyException e) {
+				throw error(e);
+			} catch (InvalidAlgorithmParameterException e) {
+				throw error(e);
+			}
+		}
+	}
+}
-- 
1.5.6.74.g8a5e
