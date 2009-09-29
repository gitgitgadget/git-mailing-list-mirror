From: "Sasa Zivkov" <sasa.zivkov@sap.com>
Subject: [JGIT PATCH] Include description for missing prereqs
Date: Tue, 29 Sep 2009 16:03:40 +0200
Message-ID: <1254233020-756-1-git-send-email-sasa.zivkov@sap.com>
Cc: git@vger.kernel.org, Sasa Zivkov <sasa.zivkov@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 18:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsfwW-0001Bt-3s
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 18:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZI2Qwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbZI2Qwi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 12:52:38 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.171]:62347 "EHLO
	smtpde01.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZI2Qwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 12:52:38 -0400
X-Greylist: delayed 10137 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2009 12:52:37 EDT
Received: from mail.sap.corp
	by smtpde01.sap-ag.de (26) with ESMTP id n8TE3eec004272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 16:03:40 +0200 (MEST)
Received: from localhost.localdomain (wdfd00180222a.dhcp.wdf.sap.corp [10.18.83.113])
	by mail.sap.corp (mail03-25) with ESMTP id n8TE3dmN017931;
	Tue, 29 Sep 2009 16:03:40 +0200 (MEST)
X-Mailer: git-send-email 1.6.4.msysgit.0
X-Scanner: Virus Scanner virwal08
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129314>

From: Sasa Zivkov <sasa.zivkov@sap.com>

When throwing MissingBundlePrerequisiteException we
also include the short description, if available, of
each missing object.

This is the fix for the following issue:
http://code.google.com/p/egit/issues/detail?id=25

Signed-off-by: Sasa Zivkov <sasa.zivkov@sap.com>
---
 .../errors/MissingBundlePrerequisiteException.java |   19 +++++++++++--------
 .../jgit/transport/BundleFetchConnection.java      |   20 +++++++++++++-------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java
index d2335c1..d90350c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java
@@ -37,7 +37,7 @@
 
 package org.spearce.jgit.errors;
 
-import java.util.Collection;
+import java.util.Map;
 
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.transport.URIish;
@@ -48,12 +48,14 @@
 public class MissingBundlePrerequisiteException extends TransportException {
 	private static final long serialVersionUID = 1L;
 
-	private static String format(final Collection<ObjectId> ids) {
+	private static String format(final Map<ObjectId, String> missingCommits) {
 		final StringBuilder r = new StringBuilder();
 		r.append("missing prerequisite commits:");
-		for (final ObjectId p : ids) {
+		for (final Map.Entry<ObjectId, String> e : missingCommits.entrySet()) {
 			r.append("\n  ");
-			r.append(p.name());
+			r.append(e.getKey().name());
+			if (e.getValue() != null)
+				r.append(" ").append(e.getValue());
 		}
 		return r.toString();
 	}
@@ -63,11 +65,12 @@ private static String format(final Collection<ObjectId> ids) {
 	 *
 	 * @param uri
 	 *            URI used for transport
-	 * @param ids
-	 *            the ids of the base/common object(s) we don't have.
+	 * @param missingCommits
+	 *            the Map of the base/common object(s) we don't have. Keys are
+	 *            ids of the missing objects and values are short descriptions.
 	 */
 	public MissingBundlePrerequisiteException(final URIish uri,
-			final Collection<ObjectId> ids) {
-		super(uri, format(ids));
+			final Map<ObjectId, String> missingCommits) {
+		super(uri, format(missingCommits));
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
index 14e0c7d..034e158 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
@@ -44,9 +44,10 @@
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Collections;
-import java.util.HashSet;
+import java.util.HashMap;
 import java.util.LinkedHashMap;
 import java.util.List;
+import java.util.Map;
 import java.util.Set;
 
 import org.spearce.jgit.errors.MissingBundlePrerequisiteException;
@@ -75,7 +76,7 @@
 
 	InputStream bin;
 
-	final Set<ObjectId> prereqs = new HashSet<ObjectId>();
+	final Map<ObjectId, String> prereqs = new HashMap<ObjectId, String>();
 
 	private String lockMessage;
 
@@ -120,7 +121,11 @@ private void readBundleV2() throws IOException {
 				break;
 
 			if (line.charAt(0) == '-') {
-				prereqs.add(ObjectId.fromString(line.substring(1, 41)));
+				ObjectId id = ObjectId.fromString(line.substring(1, 41));
+				String shortDesc = null;
+				if (line.length() > 42)
+					shortDesc = line.substring(42);
+				prereqs.put(id, shortDesc);
 				continue;
 			}
 
@@ -199,9 +204,10 @@ private void verifyPrerequisites() throws TransportException {
 		final RevFlag PREREQ = rw.newFlag("PREREQ");
 		final RevFlag SEEN = rw.newFlag("SEEN");
 
-		final List<ObjectId> missing = new ArrayList<ObjectId>();
+		final Map<ObjectId, String> missing = new HashMap<ObjectId, String>();
 		final List<RevObject> commits = new ArrayList<RevObject>();
-		for (final ObjectId p : prereqs) {
+		for (final Map.Entry<ObjectId, String> e : prereqs.entrySet()) {
+			ObjectId p = e.getKey();
 			try {
 				final RevCommit c = rw.parseCommit(p);
 				if (!c.has(PREREQ)) {
@@ -209,7 +215,7 @@ private void verifyPrerequisites() throws TransportException {
 					commits.add(c);
 				}
 			} catch (MissingObjectException notFound) {
-				missing.add(p);
+				missing.put(p, e.getValue());
 			} catch (IOException err) {
 				throw new TransportException(transport.uri, "Cannot read commit "
 						+ p.name(), err);
@@ -243,7 +249,7 @@ private void verifyPrerequisites() throws TransportException {
 		if (remaining > 0) {
 			for (final RevObject o : commits) {
 				if (!o.has(SEEN))
-					missing.add(o);
+					missing.put(o, prereqs.get(o));
 			}
 			throw new MissingBundlePrerequisiteException(transport.uri, missing);
 		}
-- 
1.6.4.msysgit.0
