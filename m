From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/21] Simplify walker transport ref advertisement setup
Date: Sun, 29 Jun 2008 03:59:20 -0400
Message-ID: <1214726371-93520-11-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrn-0000I1-3s
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYF2IAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYF2IAv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36783 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYF2IAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpO-0004Ng-68; Sun, 29 Jun 2008 04:00:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 8950720FBAE; Sun, 29 Jun 2008 04:00:06 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 8012C20FBD2;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-10-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86781>

We need to perform the same advertisement setup during push for
any of these protocols but we won't have a WalkFetchConnection.
Returning the map simplifies the code and allows it to be used
for the push variant.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportHttp.java  |   15 +++++++--------
 .../org/spearce/jgit/transport/TransportSftp.java  |    8 ++++----
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index b18b8e3..231dbfe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -50,6 +50,7 @@ import java.net.URL;
 import java.net.URLConnection;
 import java.util.ArrayList;
 import java.util.Collection;
+import java.util.Map;
 import java.util.TreeMap;
 
 import org.spearce.jgit.errors.NotSupportedException;
@@ -102,7 +103,7 @@ class TransportHttp extends WalkTransport {
 	public FetchConnection openFetch() throws TransportException {
 		final HttpObjectDB c = new HttpObjectDB(objectsUrl);
 		final WalkFetchConnection r = new WalkFetchConnection(this, c);
-		c.readAdvertisedRefs(r);
+		r.available(c.readAdvertisedRefs());
 		return r;
 	}
 
@@ -188,12 +189,11 @@ class TransportHttp extends WalkTransport {
 			}
 		}
 
-		void readAdvertisedRefs(final WalkFetchConnection c)
-				throws TransportException {
+		Map<String, Ref> readAdvertisedRefs() throws TransportException {
 			try {
 				final BufferedReader br = openReader(INFO_REFS);
 				try {
-					readAdvertisedImpl(br, c);
+					return readAdvertisedImpl(br);
 				} finally {
 					br.close();
 				}
@@ -208,9 +208,8 @@ class TransportHttp extends WalkTransport {
 			}
 		}
 
-		private void readAdvertisedImpl(final BufferedReader br,
-				final WalkFetchConnection connection) throws IOException,
-				PackProtocolException {
+		private Map<String, Ref> readAdvertisedImpl(final BufferedReader br)
+				throws IOException, PackProtocolException {
 			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
 			for (;;) {
 				String line = br.readLine();
@@ -244,7 +243,7 @@ class TransportHttp extends WalkTransport {
 						throw duplicateAdvertisement(name);
 				}
 			}
-			connection.available(avail);
+			return avail;
 		}
 
 		private PackProtocolException outOfOrderAdvertisement(final String n) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index 092c5d3..c2f34f7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -48,6 +48,7 @@ import java.util.Collections;
 import java.util.Comparator;
 import java.util.HashMap;
 import java.util.List;
+import java.util.Map;
 import java.util.TreeMap;
 
 import org.spearce.jgit.errors.TransportException;
@@ -96,7 +97,7 @@ class TransportSftp extends WalkTransport {
 	public FetchConnection openFetch() throws TransportException {
 		final SftpObjectDB c = new SftpObjectDB(uri.getPath());
 		final WalkFetchConnection r = new WalkFetchConnection(this, c);
-		c.readAdvertisedRefs(r);
+		r.available(c.readAdvertisedRefs());
 		return r;
 	}
 
@@ -245,8 +246,7 @@ class TransportSftp extends WalkTransport {
 			}
 		}
 
-		void readAdvertisedRefs(final WalkFetchConnection connection)
-				throws TransportException {
+		Map<String, Ref> readAdvertisedRefs() throws TransportException {
 			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
 			try {
 				final BufferedReader br = openReader("../packed-refs");
@@ -262,7 +262,7 @@ class TransportSftp extends WalkTransport {
 			}
 			readRef(avail, "../HEAD", "HEAD");
 			readLooseRefs(avail, "../refs", "refs/");
-			connection.available(avail);
+			return avail;
 		}
 
 		private void readPackedRefs(final TreeMap<String, Ref> avail,
-- 
1.5.6.74.g8a5e
