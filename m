From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 18/21] Extract the basic HTTP proxy support to its own class
Date: Sun, 29 Jun 2008 03:59:28 -0400
Message-ID: <1214726371-93520-19-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrt-0000I1-Cf
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYF2IBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYF2IBR
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:01:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36869 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYF2IAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpm-0004PT-Uw; Sun, 29 Jun 2008 04:00:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 63D4920FBAE; Sun, 29 Jun 2008 04:00:31 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 9FEE420FBDC;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-18-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86771>

This way the proxy can be initialized from locations other than
jgit's Main, such as from Eclipse plugin initialization or other
command line tools that wrap jgit.

We also moved the proxy lookup code to the utility class as the
error handling is several lines of code and may be shared.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Main.java             |   36 +----
 .../org/spearce/jgit/transport/TransportHttp.java  |   36 ++---
 .../src/org/spearce/jgit/util/HttpSupport.java     |  165 ++++++++++++++++++++
 3 files changed, 182 insertions(+), 55 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java
index 8afd0d7..3d507c6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java
@@ -39,13 +39,12 @@
 package org.spearce.jgit.pgm;
 
 import java.io.File;
-import java.net.MalformedURLException;
-import java.net.URL;
 import java.util.Arrays;
 
 import org.spearce.jgit.awtui.AwtAuthenticator;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.util.HttpSupport;
 
 /** Command line entry point. */
 public class Main {
@@ -60,7 +59,7 @@ public class Main {
 	public static void main(final String[] argv) {
 		try {
 			AwtAuthenticator.install();
-			configureHttpProxy();
+			HttpSupport.configureHttpProxy();
 			execute(argv);
 		} catch (Die err) {
 			System.err.println("fatal: " + err.getMessage());
@@ -170,35 +169,4 @@ public class Main {
 		System.err.println("jgit [--git-dir=path] cmd ...");
 		System.exit(1);
 	}
-
-	private static void configureHttpProxy() {
-		final String s = System.getenv("http_proxy");
-		if (s == null || s.equals(""))
-			return;
-
-		final URL u;
-		try {
-			u = new URL(s);
-		} catch (MalformedURLException e) {
-			throw new Die("Invalid http_proxy: " + s + ": " + e.getMessage());
-		}
-		if (!"http".equals(u.getProtocol()))
-			throw new Die("Invalid http_proxy: " + s + ": Only http supported.");
-
-		final String proxyHost = u.getHost();
-		final int proxyPort = u.getPort();
-
-		System.setProperty("http.proxyHost", proxyHost);
-		if (proxyPort > 0)
-			System.setProperty("http.proxyPort", String.valueOf(proxyPort));
-
-		final String userpass = u.getUserInfo();
-		if (userpass != null && userpass.contains(":")) {
-			final int c = userpass.indexOf(':');
-			final String user = userpass.substring(0, c);
-			final String pass = userpass.substring(c + 1);
-			AwtAuthenticator.add(new AwtAuthenticator.CachedAuthentication(
-					proxyHost, proxyPort, user, pass));
-		}
-	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index 2f28f2c..9351a12 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -41,13 +41,11 @@ import java.io.BufferedReader;
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStream;
-import java.net.ConnectException;
+import java.net.HttpURLConnection;
 import java.net.MalformedURLException;
 import java.net.Proxy;
 import java.net.ProxySelector;
-import java.net.URISyntaxException;
 import java.net.URL;
-import java.net.URLConnection;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Map;
@@ -59,6 +57,7 @@ import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.util.HttpSupport;
 
 /**
  * Transport over the non-Git aware HTTP and FTP protocol.
@@ -107,10 +106,6 @@ class TransportHttp extends WalkTransport {
 		return r;
 	}
 
-	Proxy proxyFor(final URL u) throws URISyntaxException {
-		return proxySelector.select(u.toURI()).get(0);
-	}
-
 	class HttpObjectDB extends WalkRemoteObjectDatabase {
 		private final URL objectsUrl;
 
@@ -172,23 +167,22 @@ class TransportHttp extends WalkTransport {
 		@Override
 		FileStream open(final String path) throws IOException {
 			final URL base = objectsUrl;
-			try {
-				final URL u = new URL(base, path);
-				final URLConnection c = u.openConnection(proxyFor(u));
+			final URL u = new URL(base, path);
+			final Proxy proxy = HttpSupport.proxyFor(proxySelector, u);
+			final HttpURLConnection c;
+
+			c = (HttpURLConnection) u.openConnection(proxy);
+			switch (HttpSupport.response(c)) {
+			case HttpURLConnection.HTTP_OK:
 				final InputStream in = c.getInputStream();
 				final int len = c.getContentLength();
 				return new FileStream(in, len);
-			} catch (ConnectException ce) {
-				// The standard J2SE error message is not very useful.
-				//
-				if ("Connection timed out: connect".equals(ce.getMessage()))
-					throw new ConnectException("Connection timed out: " + base);
-				throw new ConnectException(ce.getMessage() + " " + base);
-			} catch (URISyntaxException e) {
-				final ConnectException err;
-				err = new ConnectException("Cannot determine proxy for " + base);
-				err.initCause(e);
-				throw err;
+			case HttpURLConnection.HTTP_NOT_FOUND:
+				throw new FileNotFoundException(u.toString());
+			default:
+				throw new IOException(u.toString() + ": "
+						+ HttpSupport.response(c) + " "
+						+ c.getResponseMessage());
 			}
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java b/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
new file mode 100644
index 0000000..29b4d8e
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
@@ -0,0 +1,165 @@
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
+package org.spearce.jgit.util;
+
+import java.io.IOException;
+import java.io.UnsupportedEncodingException;
+import java.net.ConnectException;
+import java.net.HttpURLConnection;
+import java.net.MalformedURLException;
+import java.net.Proxy;
+import java.net.ProxySelector;
+import java.net.URISyntaxException;
+import java.net.URL;
+import java.net.URLEncoder;
+
+import org.spearce.jgit.awtui.AwtAuthenticator;
+
+/** Extra utilities to support usage of HTTP. */
+public class HttpSupport {
+	/**
+	 * Configure the JRE's standard HTTP based on <code>http_proxy</code>.
+	 * <p>
+	 * The popular libcurl library honors the <code>http_proxy</code>
+	 * environment variable as a means of specifying an HTTP proxy for requests
+	 * made behind a firewall. This is not natively recognized by the JRE, so
+	 * this method can be used by command line utilities to configure the JRE
+	 * before the first request is sent.
+	 * 
+	 * @throws MalformedURLException
+	 *             the value in <code>http_proxy</code> is unsupportable.
+	 */
+	public static void configureHttpProxy() throws MalformedURLException {
+		final String s = System.getenv("http_proxy");
+		if (s == null || s.equals(""))
+			return;
+
+		final URL u = new URL(s);
+		if (!"http".equals(u.getProtocol()))
+			throw new MalformedURLException("Invalid http_proxy: " + s
+					+ ": Only http supported.");
+
+		final String proxyHost = u.getHost();
+		final int proxyPort = u.getPort();
+
+		System.setProperty("http.proxyHost", proxyHost);
+		if (proxyPort > 0)
+			System.setProperty("http.proxyPort", String.valueOf(proxyPort));
+
+		final String userpass = u.getUserInfo();
+		if (userpass != null && userpass.contains(":")) {
+			final int c = userpass.indexOf(':');
+			final String user = userpass.substring(0, c);
+			final String pass = userpass.substring(c + 1);
+			AwtAuthenticator.add(new AwtAuthenticator.CachedAuthentication(
+					proxyHost, proxyPort, user, pass));
+		}
+	}
+
+	/**
+	 * URL encode a value string into an output buffer.
+	 * 
+	 * @param urlstr
+	 *            the output buffer.
+	 * @param key
+	 *            value which must be encoded to protected special characters.
+	 */
+	public static void encode(final StringBuilder urlstr, final String key) {
+		if (key == null || key.length() == 0)
+			return;
+		try {
+			urlstr.append(URLEncoder.encode(key, "UTF-8"));
+		} catch (UnsupportedEncodingException e) {
+			throw new RuntimeException("Could not URL encode to UTF-8", e);
+		}
+	}
+
+	/**
+	 * Get the HTTP response code from the request.
+	 * <p>
+	 * Roughly the same as <code>c.getResponseCode()</code> but the
+	 * ConnectException is translated to be more understandable.
+	 * 
+	 * @param c
+	 *            connection the code should be obtained from.
+	 * @return r HTTP status code, usually 200 to indicate success. See
+	 *         {@link HttpURLConnection} for other defined constants.
+	 * @throws IOException
+	 *             communications error prevented obtaining the response code.
+	 */
+	public static int response(final HttpURLConnection c) throws IOException {
+		try {
+			return c.getResponseCode();
+		} catch (ConnectException ce) {
+			final String host = c.getURL().getHost();
+			// The standard J2SE error message is not very useful.
+			//
+			if ("Connection timed out: connect".equals(ce.getMessage()))
+				throw new ConnectException("Connection time out: " + host);
+			throw new ConnectException(ce.getMessage() + " " + host);
+		}
+	}
+
+	/**
+	 * Determine the proxy server (if any) needed to obtain a URL.
+	 * 
+	 * @param proxySelector
+	 *            proxy support for the caller.
+	 * @param u
+	 *            location of the server caller wants to talk to.
+	 * @return proxy to communicate with the supplied URL.
+	 * @throws ConnectException
+	 *             the proxy could not be computed as the supplied URL could not
+	 *             be read. This failure should never occur.
+	 */
+	public static Proxy proxyFor(final ProxySelector proxySelector, final URL u)
+			throws ConnectException {
+		try {
+			return proxySelector.select(u.toURI()).get(0);
+		} catch (URISyntaxException e) {
+			final ConnectException err;
+			err = new ConnectException("Cannot determine proxy for " + u);
+			err.initCause(e);
+			throw err;
+		}
+	}
+
+	private HttpSupport() {
+		// Utility class only.
+	}
+}
-- 
1.5.6.74.g8a5e
