From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 19/21] Create a really simple Amazon S3 REST client
Date: Sun, 29 Jun 2008 03:59:29 -0400
Message-ID: <1214726371-93520-20-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrru-0000I1-7L
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYF2IBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbYF2IBV
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:01:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36890 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYF2IAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpp-0004Pv-Vw; Sun, 29 Jun 2008 04:00:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 7EC7820FBAE; Sun, 29 Jun 2008 04:00:34 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id A3D8720FBDD;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-19-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86775>

This is a very basic client for Amazon's Simple Storage Service (S3).
The client is able to perform the basic FTP like operations necessary
to support storing a Git repository on the S3 servers, assuming the
transport is implemented as a dumb protocol style transport similar
to the existing sftp:// transport.

A tiny command line client is included to facilitate manual testing
against the S3 servers, as well as emergency operations such as
getting content or deleting content.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/AmazonS3.java   |  696 ++++++++++++++++++++
 1 files changed, 696 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
new file mode 100644
index 0000000..466d9e9
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
@@ -0,0 +1,696 @@
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
+import java.io.EOFException;
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.net.HttpURLConnection;
+import java.net.Proxy;
+import java.net.ProxySelector;
+import java.net.URL;
+import java.net.URLConnection;
+import java.security.DigestOutputStream;
+import java.security.InvalidKeyException;
+import java.security.MessageDigest;
+import java.security.NoSuchAlgorithmException;
+import java.text.SimpleDateFormat;
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.Date;
+import java.util.HashSet;
+import java.util.Iterator;
+import java.util.List;
+import java.util.Locale;
+import java.util.Map;
+import java.util.Properties;
+import java.util.Set;
+import java.util.SortedMap;
+import java.util.TimeZone;
+import java.util.TreeMap;
+
+import javax.crypto.Mac;
+import javax.crypto.spec.SecretKeySpec;
+
+import org.spearce.jgit.awtui.AwtAuthenticator;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.util.Base64;
+import org.spearce.jgit.util.HttpSupport;
+import org.spearce.jgit.util.TemporaryBuffer;
+import org.xml.sax.Attributes;
+import org.xml.sax.InputSource;
+import org.xml.sax.SAXException;
+import org.xml.sax.XMLReader;
+import org.xml.sax.helpers.DefaultHandler;
+import org.xml.sax.helpers.XMLReaderFactory;
+
+/**
+ * A simple HTTP REST client for the Amazon S3 service.
+ * <p>
+ * This client uses the REST API to communicate with the Amazon S3 servers and
+ * read or write content through a bucket that the user has access to. It is a
+ * very lightweight implementation of the S3 API and therefore does not have all
+ * of the bells and whistles of popular client implementations.
+ * <p>
+ * Authentication is always performed using the user's AWSAccessKeyId and their
+ * private AWSSecretAccessKey.
+ */
+public class AmazonS3 {
+	private static final Set<String> SIGNED_HEADERS;
+
+	private static final String HMAC = "HmacSHA1";
+
+	private static final String DOMAIN = "s3.amazonaws.com";
+
+	private static final String X_AMZ_ACL = "x-amz-acl";
+
+	static {
+		SIGNED_HEADERS = new HashSet<String>();
+		SIGNED_HEADERS.add("content-type");
+		SIGNED_HEADERS.add("content-md5");
+		SIGNED_HEADERS.add("date");
+	}
+
+	private static boolean isSignedHeader(final String name) {
+		final String nameLC = name.toLowerCase();
+		return SIGNED_HEADERS.contains(nameLC) || nameLC.startsWith("x-amz-");
+	}
+
+	private static String toCleanString(final List<String> list) {
+		final StringBuilder s = new StringBuilder();
+		for (final String v : list) {
+			if (s.length() > 0)
+				s.append(',');
+			s.append(v.replaceAll("\n", "").trim());
+		}
+		return s.toString();
+	}
+
+	private static String remove(final Map<String, String> m, final String k) {
+		final String r = m.remove(k);
+		return r != null ? r : "";
+	}
+
+	private static String httpNow() {
+		final String tz = "GMT";
+		final SimpleDateFormat fmt;
+		fmt = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss", Locale.US);
+		fmt.setTimeZone(TimeZone.getTimeZone(tz));
+		return fmt.format(new Date()) + " " + tz;
+	}
+
+	private static MessageDigest newMD5() {
+		try {
+			return MessageDigest.getInstance("MD5");
+		} catch (NoSuchAlgorithmException e) {
+			throw new RuntimeException("JRE lacks MD5 implementation", e);
+		}
+	}
+
+	/** AWSAccessKeyId, public string that identifies the user's account. */
+	private final String publicKey;
+
+	/** Decoded form of the private AWSSecretAccessKey, to sign requests. */
+	private final SecretKeySpec privateKey;
+
+	/** Our HTTP proxy support, in case we are behind a firewall. */
+	private final ProxySelector proxySelector;
+
+	/** ACL to apply to created objects. */
+	private final String acl;
+
+	/** Maximum number of times to try an operation. */
+	private final int maxAttempts;
+
+	/**
+	 * Create a new S3 client for the supplied user information.
+	 * <p>
+	 * The connection properties are a subset of those supported by the popular
+	 * <a href="http://jets3t.s3.amazonaws.com/index.html">jets3t</a> library.
+	 * For example:
+	 * 
+	 * <pre>
+	 * # AWS Access and Secret Keys (required)
+	 * accesskey: &lt;YourAWSAccessKey&gt;
+	 * secretkey: &lt;YourAWSSecretKey&gt;
+	 * 
+	 * # Access Control List setting to apply to uploads, must be one of:
+	 * # PRIVATE, PUBLIC_READ (defaults to PRIVATE).
+	 * acl: PRIVATE
+	 * 
+	 * # Number of times to retry after internal error from S3.
+	 * httpclient.retry-max: 3
+	 * </pre>
+	 * 
+	 * @param props
+	 *            connection properties.
+	 * 
+	 */
+	public AmazonS3(final Properties props) {
+		publicKey = props.getProperty("accesskey");
+		if (publicKey == null)
+			throw new IllegalArgumentException("Missing accesskey.");
+
+		final String secret = props.getProperty("secretkey");
+		if (secret == null)
+			throw new IllegalArgumentException("Missing secretkey.");
+		privateKey = new SecretKeySpec(Constants.encodeASCII(secret), HMAC);
+
+		final String pacl = props.getProperty("acl", "PRIVATE");
+		if ("PRIVATE".equalsIgnoreCase(pacl))
+			acl = "private";
+		else if ("PUBLIC".equalsIgnoreCase(pacl))
+			acl = "public-read";
+		else if ("PUBLIC-READ".equalsIgnoreCase(pacl))
+			acl = "public-read";
+		else if ("PUBLIC_READ".equalsIgnoreCase(pacl))
+			acl = "public-read";
+		else
+			throw new IllegalArgumentException("Invalid acl: " + pacl);
+
+		maxAttempts = Integer.parseInt(props.getProperty(
+				"httpclient.retry-max", "3"));
+		proxySelector = ProxySelector.getDefault();
+	}
+
+	/**
+	 * Get the content of a bucket object.
+	 * 
+	 * @param bucket
+	 *            name of the bucket storing the object.
+	 * @param key
+	 *            key of the object within its bucket.
+	 * @return connection to stream the content of the object. The request
+	 *         properties of the connection may not be modified by the caller as
+	 *         the request parameters have already been signed.
+	 * @throws IOException
+	 *             sending the request was not possible.
+	 */
+	public URLConnection get(final String bucket, final String key)
+			throws IOException {
+		for (int curAttempt = 0; curAttempt < maxAttempts; curAttempt++) {
+			final HttpURLConnection c = open("GET", bucket, key);
+			authorize(c);
+			switch (HttpSupport.response(c)) {
+			case HttpURLConnection.HTTP_OK:
+				return c;
+			case HttpURLConnection.HTTP_NOT_FOUND:
+				throw new FileNotFoundException(key);
+			case HttpURLConnection.HTTP_INTERNAL_ERROR:
+				continue;
+			default:
+				throw error("Reading", key, c);
+			}
+		}
+		throw maxAttempts("Reading", key);
+	}
+
+	/**
+	 * List the names of keys available within a bucket.
+	 * <p>
+	 * This method is primarily meant for obtaining a "recursive directory
+	 * listing" rooted under the specified bucket and prefix location.
+	 * 
+	 * @param bucket
+	 *            name of the bucket whose objects should be listed.
+	 * @param prefix
+	 *            common prefix to filter the results by. Must not be null.
+	 *            Supplying the empty string will list all keys in the bucket.
+	 *            Supplying a non-empty string will act as though a trailing '/'
+	 *            appears in prefix, even if it does not.
+	 * @return list of keys starting with <code>prefix</code>, after removing
+	 *         <code>prefix</code> (or <code>prefix + "/"</code>)from all
+	 *         of them.
+	 * @throws IOException
+	 *             sending the request was not possible, or the response XML
+	 *             document could not be parsed properly.
+	 */
+	public List<String> list(final String bucket, String prefix)
+			throws IOException {
+		if (prefix.length() > 0 && !prefix.endsWith("/"))
+			prefix += "/";
+		final ListParser lp = new ListParser(bucket, prefix);
+		do {
+			lp.list();
+		} while (lp.truncated);
+		return lp.entries;
+	}
+
+	/**
+	 * Delete a single object.
+	 * <p>
+	 * Deletion always succeeds, even if the object does not exist.
+	 * 
+	 * @param bucket
+	 *            name of the bucket storing the object.
+	 * @param key
+	 *            key of the object within its bucket.
+	 * @throws IOException
+	 *             deletion failed due to communications error.
+	 */
+	public void delete(final String bucket, final String key)
+			throws IOException {
+		for (int curAttempt = 0; curAttempt < maxAttempts; curAttempt++) {
+			final HttpURLConnection c = open("DELETE", bucket, key);
+			authorize(c);
+			switch (HttpSupport.response(c)) {
+			case HttpURLConnection.HTTP_NO_CONTENT:
+				return;
+			case HttpURLConnection.HTTP_INTERNAL_ERROR:
+				continue;
+			default:
+				throw error("Deletion", key, c);
+			}
+		}
+		throw maxAttempts("Deletion", key);
+	}
+
+	/**
+	 * Atomically create or replace a single small object.
+	 * <p>
+	 * This form is only suitable for smaller contents, where the caller can
+	 * reasonable fit the entire thing into memory.
+	 * <p>
+	 * End-to-end data integrity is assured by internally computing the MD5
+	 * checksum of the supplied data and transmitting the checksum along with
+	 * the data itself.
+	 * 
+	 * @param bucket
+	 *            name of the bucket storing the object.
+	 * @param key
+	 *            key of the object within its bucket.
+	 * @param data
+	 *            new data content for the object. Must not be null. Zero length
+	 *            array will create a zero length object.
+	 * @throws IOException
+	 *             creation/updating failed due to communications error.
+	 */
+	public void put(final String bucket, final String key, final byte[] data)
+			throws IOException {
+		final String md5str = Base64.encodeBytes(newMD5().digest(data));
+		final String lenstr = String.valueOf(data.length);
+		for (int curAttempt = 0; curAttempt < maxAttempts; curAttempt++) {
+			final HttpURLConnection c = open("PUT", bucket, key);
+			c.setRequestProperty("Content-Length", lenstr);
+			c.setRequestProperty("Content-MD5", md5str);
+			c.setRequestProperty(X_AMZ_ACL, acl);
+			authorize(c);
+			c.setDoOutput(true);
+			c.setFixedLengthStreamingMode(data.length);
+			final OutputStream os = c.getOutputStream();
+			try {
+				os.write(data);
+			} finally {
+				os.close();
+			}
+
+			switch (HttpSupport.response(c)) {
+			case HttpURLConnection.HTTP_OK:
+				return;
+			case HttpURLConnection.HTTP_INTERNAL_ERROR:
+				continue;
+			default:
+				throw error("Writing", key, c);
+			}
+		}
+		throw maxAttempts("Writing", key);
+	}
+
+	/**
+	 * Atomically create or replace a single large object.
+	 * <p>
+	 * Initially the returned output stream buffers data into memory, but if the
+	 * total number of written bytes starts to exceed an internal limit the data
+	 * is spooled to a temporary file on the local drive.
+	 * <p>
+	 * Network transmission is attempted only when <code>close()</code> gets
+	 * called at the end of output. Closing the returned stream can therefore
+	 * take significant time, especially if the written content is very large.
+	 * <p>
+	 * End-to-end data integrity is assured by internally computing the MD5
+	 * checksum of the supplied data and transmitting the checksum along with
+	 * the data itself.
+	 * 
+	 * @param bucket
+	 *            name of the bucket storing the object.
+	 * @param key
+	 *            key of the object within its bucket.
+	 * @return a stream which accepts the new data, and transmits once closed.
+	 */
+	public OutputStream beginPut(final String bucket, final String key) {
+		final MessageDigest md5 = newMD5();
+		final TemporaryBuffer buffer = new TemporaryBuffer() {
+			@Override
+			public void close() throws IOException {
+				super.close();
+				try {
+					putImpl(bucket, key, md5.digest(), this);
+				} finally {
+					destroy();
+				}
+			}
+		};
+		return new DigestOutputStream(buffer, md5);
+	}
+
+	private void putImpl(final String bucket, final String key,
+			final byte[] csum, final TemporaryBuffer buf) throws IOException {
+		final String md5str = Base64.encodeBytes(csum);
+		final long len = buf.length();
+		final String lenstr = String.valueOf(len);
+		for (int curAttempt = 0; curAttempt < maxAttempts; curAttempt++) {
+			final HttpURLConnection c = open("PUT", bucket, key);
+			c.setRequestProperty("Content-Length", lenstr);
+			c.setRequestProperty("Content-MD5", md5str);
+			c.setRequestProperty(X_AMZ_ACL, acl);
+			authorize(c);
+			c.setDoOutput(true);
+			c.setFixedLengthStreamingMode((int) len);
+			final OutputStream os = c.getOutputStream();
+			try {
+				buf.writeTo(os, null);
+			} finally {
+				os.close();
+			}
+
+			switch (HttpSupport.response(c)) {
+			case HttpURLConnection.HTTP_OK:
+				return;
+			case HttpURLConnection.HTTP_INTERNAL_ERROR:
+				continue;
+			default:
+				throw error("Writing", key, c);
+			}
+		}
+		throw maxAttempts("Writing", key);
+	}
+
+	private IOException error(final String action, final String key,
+			final HttpURLConnection c) throws IOException {
+		return new IOException(action + " of '" + key + "' failed: "
+				+ HttpSupport.response(c) + " " + c.getResponseMessage());
+	}
+
+	private IOException maxAttempts(final String action, final String key) {
+		return new IOException(action + " of '" + key + "' failed:"
+				+ " Giving up after " + maxAttempts + " attempts.");
+	}
+
+	private HttpURLConnection open(final String method, final String bucket,
+			final String key) throws IOException {
+		final Map<String, String> noArgs = Collections.emptyMap();
+		return open(method, bucket, key, noArgs);
+	}
+
+	private HttpURLConnection open(final String method, final String bucket,
+			final String key, final Map<String, String> args)
+			throws IOException {
+		final StringBuilder urlstr = new StringBuilder();
+		urlstr.append("http://");
+		urlstr.append(bucket);
+		urlstr.append('.');
+		urlstr.append(DOMAIN);
+		urlstr.append('/');
+		if (key.length() > 0)
+			HttpSupport.encode(urlstr, key);
+		if (!args.isEmpty()) {
+			final Iterator<Map.Entry<String, String>> i;
+
+			urlstr.append('?');
+			i = args.entrySet().iterator();
+			while (i.hasNext()) {
+				final Map.Entry<String, String> e = i.next();
+				urlstr.append(e.getKey());
+				urlstr.append('=');
+				HttpSupport.encode(urlstr, e.getValue());
+				if (i.hasNext())
+					urlstr.append('&');
+			}
+		}
+
+		final URL url = new URL(urlstr.toString());
+		final Proxy proxy = HttpSupport.proxyFor(proxySelector, url);
+		final HttpURLConnection c;
+
+		c = (HttpURLConnection) url.openConnection(proxy);
+		c.setRequestMethod(method);
+		c.setRequestProperty("User-Agent", "jgit/1.0");
+		c.setRequestProperty("Date", httpNow());
+		return c;
+	}
+
+	private void authorize(final HttpURLConnection c) throws IOException {
+		final Map<String, List<String>> reqHdr = c.getRequestProperties();
+		final SortedMap<String, String> sigHdr = new TreeMap<String, String>();
+		for (final String hdr : reqHdr.keySet()) {
+			if (isSignedHeader(hdr))
+				sigHdr.put(hdr.toLowerCase(), toCleanString(reqHdr.get(hdr)));
+		}
+
+		final StringBuilder s = new StringBuilder();
+		s.append(c.getRequestMethod());
+		s.append('\n');
+
+		s.append(remove(sigHdr, "content-md5"));
+		s.append('\n');
+
+		s.append(remove(sigHdr, "content-type"));
+		s.append('\n');
+
+		s.append(remove(sigHdr, "date"));
+		s.append('\n');
+
+		for (final Map.Entry<String, String> e : sigHdr.entrySet()) {
+			s.append(e.getKey());
+			s.append(':');
+			s.append(e.getValue());
+			s.append('\n');
+		}
+
+		final String host = c.getURL().getHost();
+		s.append('/');
+		s.append(host.substring(0, host.length() - DOMAIN.length() - 1));
+		s.append(c.getURL().getPath());
+
+		final String sec;
+		try {
+			final Mac m = Mac.getInstance(HMAC);
+			m.init(privateKey);
+			sec = Base64.encodeBytes(m.doFinal(s.toString().getBytes("UTF-8")));
+		} catch (NoSuchAlgorithmException e) {
+			throw new IOException("No " + HMAC + " support:" + e.getMessage());
+		} catch (InvalidKeyException e) {
+			throw new IOException("Invalid key: " + e.getMessage());
+		}
+		c.setRequestProperty("Authorization", "AWS " + publicKey + ":" + sec);
+	}
+
+	/**
+	 * Simple command line interface to {@link AmazonS3}.
+	 * 
+	 * @param argv
+	 *            command line arguments. See usage for details.
+	 * @throws IOException
+	 *             an error occurred.
+	 */
+	public static void main(final String[] argv) throws IOException {
+		if (argv.length != 4) {
+			commandLineUsage();
+			return;
+		}
+
+		AwtAuthenticator.install();
+		HttpSupport.configureHttpProxy();
+
+		final AmazonS3 s3 = new AmazonS3(properties(new File(argv[0])));
+		final String op = argv[1];
+		final String bucket = argv[2];
+		final String key = argv[3];
+		if ("get".equals(op)) {
+			final URLConnection c = s3.get(bucket, key);
+			int len = c.getContentLength();
+			final InputStream in = c.getInputStream();
+			try {
+				final byte[] tmp = new byte[2048];
+				while (len > 0) {
+					final int n = in.read(tmp);
+					if (n < 0)
+						throw new EOFException("Expected " + len + " bytes.");
+					System.out.write(tmp, 0, n);
+					len -= n;
+				}
+			} finally {
+				in.close();
+			}
+		} else if ("ls".equals(op) || "list".equals(op)) {
+			for (final String k : s3.list(bucket, key))
+				System.out.println(k);
+		} else if ("rm".equals(op) || "delete".equals(op)) {
+			s3.delete(bucket, key);
+		} else if ("put".equals(op)) {
+			final OutputStream os = s3.beginPut(bucket, key);
+			final byte[] tmp = new byte[2048];
+			int n;
+			while ((n = System.in.read(tmp)) > 0)
+				os.write(tmp, 0, n);
+			os.close();
+		} else {
+			commandLineUsage();
+		}
+	}
+
+	private static void commandLineUsage() {
+		System.err.println("usage: conn.prop op bucket key");
+		System.err.println();
+		System.err.println("    where conn.prop is a jets3t properties file.");
+		System.err.println("    op is one of: get ls rm put");
+		System.err.println("    bucket is the name of the S3 bucket");
+		System.err.println("    key is the name of the object.");
+		System.exit(1);
+	}
+
+	static Properties properties(final File authFile)
+			throws FileNotFoundException, IOException {
+		final Properties p = new Properties();
+		final FileInputStream in = new FileInputStream(authFile);
+		try {
+			p.load(in);
+		} finally {
+			in.close();
+		}
+		return p;
+	}
+
+	private final class ListParser extends DefaultHandler {
+		final List<String> entries = new ArrayList<String>();
+
+		private final String bucket;
+
+		private final String prefix;
+
+		boolean truncated;
+
+		private StringBuilder data;
+
+		ListParser(final String bn, final String p) {
+			bucket = bn;
+			prefix = p;
+		}
+
+		void list() throws IOException {
+			final Map<String, String> args = new TreeMap<String, String>();
+			if (prefix.length() > 0)
+				args.put("prefix", prefix);
+			if (!entries.isEmpty())
+				args.put("marker", prefix + entries.get(entries.size() - 1));
+
+			for (int curAttempt = 0; curAttempt < maxAttempts; curAttempt++) {
+				final HttpURLConnection c = open("GET", bucket, "", args);
+				authorize(c);
+				switch (HttpSupport.response(c)) {
+				case HttpURLConnection.HTTP_OK:
+					truncated = false;
+					data = null;
+
+					final XMLReader xr;
+					try {
+						xr = XMLReaderFactory.createXMLReader();
+					} catch (SAXException e) {
+						throw new IOException("No XML parser available.");
+					}
+					xr.setContentHandler(this);
+					final InputStream in = c.getInputStream();
+					try {
+						xr.parse(new InputSource(in));
+					} catch (SAXException parsingError) {
+						final IOException p;
+						p = new IOException("Error listing " + prefix);
+						p.initCause(parsingError);
+						throw p;
+					} finally {
+						in.close();
+					}
+					return;
+
+				case HttpURLConnection.HTTP_INTERNAL_ERROR:
+					continue;
+
+				default:
+					throw AmazonS3.this.error("Listing", prefix, c);
+				}
+			}
+			throw maxAttempts("Listing", prefix);
+		}
+
+		@Override
+		public void startElement(final String uri, final String name,
+				final String qName, final Attributes attributes)
+				throws SAXException {
+			if ("Key".equals(name) || "IsTruncated".equals(name))
+				data = new StringBuilder();
+		}
+
+		@Override
+		public void ignorableWhitespace(final char[] ch, final int s,
+				final int n) throws SAXException {
+			if (data != null)
+				data.append(ch, s, n);
+		}
+
+		@Override
+		public void characters(final char[] ch, final int s, final int n)
+				throws SAXException {
+			if (data != null)
+				data.append(ch, s, n);
+		}
+
+		@Override
+		public void endElement(final String uri, final String name,
+				final String qName) throws SAXException {
+			if ("Key".equals(name))
+				entries.add(data.toString().substring(prefix.length()));
+			else if ("IsTruncated".equals(name))
+				truncated = "true".equalsIgnoreCase(data.toString());
+			data = null;
+		}
+	}
+}
-- 
1.5.6.74.g8a5e
