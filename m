From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Evaluate short refnames into full names during push
Date: Sat,  7 Mar 2009 23:18:19 +0100
Message-ID: <1236464299-11491-1-git-send-email-robin.rosenberg@dewire.com>
References: <20090307211008.GP16213@spearce.org>
Cc: git@vger.kernel.org, Daniel Cheng <j16sdiz+freenet@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Mar 07 23:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg4s8-0000si-BD
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 23:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052AbZCGWS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 17:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757024AbZCGWS2
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 17:18:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:26051 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757155AbZCGWS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 17:18:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3EA9B15E0DE6;
	Sat,  7 Mar 2009 23:18:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1IjgWjXkVvpm; Sat,  7 Mar 2009 23:18:20 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 6A1C68026EF;
	Sat,  7 Mar 2009 23:18:20 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <20090307211008.GP16213@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112591>

With this we can use short names like master instead of refs/heads/master
when pushing. This is slightly more convenient. Pushing a delete still
requires the long format.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   11 ++++++++++
 .../src/org/spearce/jgit/transport/Transport.java  |   21 +++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 30bd4a3..3ab51b1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -928,6 +928,17 @@ public String getBranch() throws IOException {
 	}
 	
 	/**
+	 * Get a ref by name.
+	 * 
+	 * @param name
+	 * @return the Ref with the given name, or null if it does not exist
+	 * @throws IOException
+	 */
+	public Ref getRef(final String name) throws IOException {
+		return refs.readRef(name);
+	}
+
+	/**
 	 * @return all known refs (heads, tags, remotes).
 	 */
 	public Map<String, Ref> getAllRefs() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 3aec5ca..64745a8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -51,6 +51,7 @@
 
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.NullProgressMonitor;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
@@ -243,10 +244,24 @@ else if (TransportLocal.canHandle(remote))
 		final Collection<RefSpec> procRefs = expandPushWildcardsFor(db, specs);
 
 		for (final RefSpec spec : procRefs) {
-			final String srcRef = spec.getSource();
+			String srcRef = spec.getSource();
+			final Ref src = db.getRef(srcRef);
+			if (src != null)
+				srcRef = src.getName();
+			String remoteName = spec.getDestination();
 			// null destination (no-colon in ref-spec) is a special case
-			final String remoteName = (spec.getDestination() == null ? spec
-					.getSource() : spec.getDestination());
+			if (remoteName == null) {
+				remoteName = srcRef; 
+			} else {
+				if (!remoteName.startsWith(Constants.R_REFS)) {
+					// null source is another special case (delete)
+					if (srcRef != null) {
+						// assume the same type of ref at the destination
+						String srcPrefix = srcRef.substring(0, srcRef.indexOf('/', Constants.R_REFS.length()));
+						remoteName = srcPrefix + "/" + remoteName;
+					}
+				}
+			}
 			final boolean forceUpdate = spec.isForceUpdate();
 			final String localName = findTrackingRefName(remoteName, fetchSpecs);
 
-- 
1.6.1.285.g35d8b
