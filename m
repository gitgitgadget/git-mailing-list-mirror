From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 14/21] Extract readPackedRefs from TransportSftp for reuse
Date: Sun, 29 Jun 2008 03:59:24 -0400
Message-ID: <1214726371-93520-15-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrq-0000I1-4J
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYF2IBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbYF2IBD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:01:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36816 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYF2IAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpa-0004Od-ES; Sun, 29 Jun 2008 04:00:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id F18AF20FBAE; Sun, 29 Jun 2008 04:00:18 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 8F05020FBD7;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-14-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86769>

Other dumb transports may need this functionality available to them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportHttp.java  |    5 ++
 .../org/spearce/jgit/transport/TransportSftp.java  |   47 ++--------------
 .../src/org/spearce/jgit/transport/URIish.java     |   22 ++++++++
 .../jgit/transport/WalkRemoteObjectDatabase.java   |   58 ++++++++++++++++++++
 4 files changed, 91 insertions(+), 41 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index 4655950..2f28f2c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -119,6 +119,11 @@ class TransportHttp extends WalkTransport {
 		}
 
 		@Override
+		URIish getURI() {
+			return new URIish(objectsUrl);
+		}
+
+		@Override
 		Collection<WalkRemoteObjectDatabase> getAlternates() throws IOException {
 			try {
 				return readAlternates(INFO_HTTP_ALTERNATES);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index e5db6cc..a33406b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -193,6 +193,11 @@ class TransportSftp extends WalkTransport {
 		}
 
 		@Override
+		URIish getURI() {
+			return uri.setPath(objectsPath);
+		}
+
+		@Override
 		Collection<WalkRemoteObjectDatabase> getAlternates() throws IOException {
 			try {
 				return readAlternates(INFO_ALTERNATES);
@@ -355,52 +360,12 @@ class TransportSftp extends WalkTransport {
 
 		Map<String, Ref> readAdvertisedRefs() throws TransportException {
 			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
-			try {
-				final BufferedReader br = openReader(PACKED_REFS);
-				try {
-					readPackedRefs(avail, br);
-				} finally {
-					br.close();
-				}
-			} catch (FileNotFoundException notPacked) {
-				// Perhaps it wasn't worthwhile, or is just an older repository.
-			} catch (IOException e) {
-				throw new TransportException(uri, "error in packed-refs", e);
-			}
+			readPackedRefs(avail);
 			readRef(avail, "../HEAD", "HEAD");
 			readLooseRefs(avail, "../refs", "refs/");
 			return avail;
 		}
 
-		private void readPackedRefs(final TreeMap<String, Ref> avail,
-				final BufferedReader br) throws IOException {
-			Ref last = null;
-			for (;;) {
-				String line = br.readLine();
-				if (line == null)
-					break;
-				if (line.charAt(0) == '#')
-					continue;
-				if (line.charAt(0) == '^') {
-					if (last == null)
-						throw new TransportException("Peeled line before ref.");
-					final ObjectId id = ObjectId.fromString(line + 1);
-					last = new Ref(Ref.Storage.PACKED, last.getName(), last
-							.getObjectId(), id);
-					avail.put(last.getName(), last);
-					continue;
-				}
-
-				final int sp = line.indexOf(' ');
-				if (sp < 0)
-					throw new TransportException("Unrecognized ref: " + line);
-				final ObjectId id = ObjectId.fromString(line.substring(0, sp));
-				final String name = line.substring(sp + 1);
-				last = new Ref(Ref.Storage.PACKED, name, id);
-				avail.put(last.getName(), last);
-			}
-		}
-
 		private void readLooseRefs(final TreeMap<String, Ref> avail,
 				final String dir, final String prefix)
 				throws TransportException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
index 307b591..9e7ca83 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
@@ -39,6 +39,7 @@
 package org.spearce.jgit.transport;
 
 import java.net.URISyntaxException;
+import java.net.URL;
 import java.util.regex.Matcher;
 import java.util.regex.Pattern;
 
@@ -100,6 +101,27 @@ public class URIish {
 		}
 	}
 
+	/**
+	 * Construct a URIish from a standard URL.
+	 * 
+	 * @param u
+	 *            the source URL to convert from.
+	 */
+	public URIish(final URL u) {
+		scheme = u.getProtocol();
+		path = u.getPath();
+
+		final String ui = u.getUserInfo();
+		if (ui != null) {
+			final int d = ui.indexOf(':');
+			user = d < 0 ? ui : ui.substring(0, d);
+			pass = d < 0 ? null : ui.substring(d + 1);
+		}
+
+		port = u.getPort();
+		host = u.getHost();
+	}
+
 	/** Create an empty, non-configured URI. */
 	public URIish() {
 		// Configure nothing.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index 57d525f..4f5a1cb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -47,7 +47,9 @@ import java.io.OutputStream;
 import java.io.StringWriter;
 import java.util.ArrayList;
 import java.util.Collection;
+import java.util.Map;
 
+import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Ref;
@@ -76,6 +78,8 @@ abstract class WalkRemoteObjectDatabase {
 
 	static final String PACKED_REFS = "../packed-refs";
 
+	abstract URIish getURI();
+
 	/**
 	 * Obtain the list of available packs (if any).
 	 * <p>
@@ -469,6 +473,60 @@ abstract class WalkRemoteObjectDatabase {
 		}
 	}
 
+	/**
+	 * Read a standard Git packed-refs file to discover known references.
+	 * 
+	 * @param avail
+	 *            return collection of references. Any existing entries will be
+	 *            replaced if they are found in the packed-refs file.
+	 * @throws TransportException
+	 *             an error occurred reading from the packed refs file.
+	 */
+	protected void readPackedRefs(final Map<String, Ref> avail)
+			throws TransportException {
+		try {
+			final BufferedReader br = openReader(PACKED_REFS);
+			try {
+				readPackedRefsImpl(avail, br);
+			} finally {
+				br.close();
+			}
+		} catch (FileNotFoundException notPacked) {
+			// Perhaps it wasn't worthwhile, or is just an older repository.
+		} catch (IOException e) {
+			throw new TransportException(getURI(), "error in packed-refs", e);
+		}
+	}
+
+	private void readPackedRefsImpl(final Map<String, Ref> avail,
+			final BufferedReader br) throws IOException {
+		Ref last = null;
+		for (;;) {
+			String line = br.readLine();
+			if (line == null)
+				break;
+			if (line.charAt(0) == '#')
+				continue;
+			if (line.charAt(0) == '^') {
+				if (last == null)
+					throw new TransportException("Peeled line before ref.");
+				final ObjectId id = ObjectId.fromString(line + 1);
+				last = new Ref(Ref.Storage.PACKED, last.getName(), last
+						.getObjectId(), id);
+				avail.put(last.getName(), last);
+				continue;
+			}
+
+			final int sp = line.indexOf(' ');
+			if (sp < 0)
+				throw new TransportException("Unrecognized ref: " + line);
+			final ObjectId id = ObjectId.fromString(line.substring(0, sp));
+			final String name = line.substring(sp + 1);
+			last = new Ref(Ref.Storage.PACKED, name, id);
+			avail.put(last.getName(), last);
+		}
+	}
+
 	static final class FileStream {
 		final InputStream in;
 
-- 
1.5.6.74.g8a5e
