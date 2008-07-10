From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/9] Cached modification times for symbolic refs too
Date: Fri, 11 Jul 2008 00:40:44 +0200
Message-ID: <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vT-0004Lo-8r
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbYGJWqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbYGJWqB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:01 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13111 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754167AbYGJWqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 16323147B7EC;
	Fri, 11 Jul 2008 00:45:59 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ekbv-RbNEGx; Fri, 11 Jul 2008 00:45:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C97C3802C0D;
	Fri, 11 Jul 2008 00:45:57 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88031>

We want to detect changes to symbolic refs like HEAD. When HEAD is
redirected to another branch, that's a change even if if the branch
head itself did not change.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   48 +++++++++++---------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 4be33b8..17a74e5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -71,7 +71,8 @@ class RefDatabase {
 
 	private final File refsDir;
 
-	private Map<String, CachedRef> looseRefs;
+	private Map<String, Ref> looseRefs;
+	private Map<String, Long> looseRefsMTime;
 
 	private final File packedRefsFile;
 
@@ -94,7 +95,8 @@ class RefDatabase {
 	}
 
 	void clearCache() {
-		looseRefs = new HashMap<String, CachedRef>();
+		looseRefs = new HashMap<String, Ref>();
+		looseRefsMTime = new HashMap<String, Long>();
 		packedRefs = new HashMap<String, Ref>();
 		packedRefsLastModified = 0;
 		packedRefsLength = 0;
@@ -135,7 +137,8 @@ class RefDatabase {
 	}
 
 	void stored(final String name, final ObjectId id, final long time) {
-		looseRefs.put(name, new CachedRef(Ref.Storage.LOOSE, name, id, time));
+		looseRefs.put(name, new Ref(Ref.Storage.LOOSE, name, id));
+		looseRefsMTime.put(name, time);
 		setModified();
 		db.fireRefsMaybeChanged();
 	}
@@ -203,7 +206,11 @@ class RefDatabase {
 		final HashMap<String, Ref> avail = new HashMap<String, Ref>();
 		readPackedRefs(avail);
 		readLooseRefs(avail, REFS_SLASH, refsDir);
-		readOneLooseRef(avail, Constants.HEAD, new File(gitDir, Constants.HEAD));
+		try {
+			avail.put(Constants.HEAD, readRefBasic(Constants.HEAD, 0));
+		} catch (IOException e) {
+			// ignore here
+		}
 		db.fireRefsMaybeChanged();
 		return avail;
 	}
@@ -231,13 +238,15 @@ class RefDatabase {
 			final String refName, final File ent) {
 		// Unchanged and cached? Don't read it again.
 		//
-		CachedRef ref = looseRefs.get(refName);
+		Ref ref = looseRefs.get(refName);
 		if (ref != null) {
-			if (ref.lastModified == ent.lastModified()) {
+			Long cachedlastModified = looseRefsMTime.get(refName);
+			if (cachedlastModified != null && cachedlastModified == ent.lastModified()) {
 				avail.put(ref.getName(), ref);
 				return;
 			}
 			looseRefs.remove(refName);
+			looseRefsMTime.remove(refName);
 		}
 
 		// Recurse into the directory.
@@ -269,9 +278,9 @@ class RefDatabase {
 					return;
 				}
 
-				ref = new CachedRef(Ref.Storage.LOOSE, refName, id, ent
-						.lastModified());
+				ref = new Ref(Ref.Storage.LOOSE, refName, id);
 				looseRefs.put(ref.getName(), ref);
+				looseRefsMTime.put(ref.getName(), ent.lastModified());
 				avail.put(ref.getName(), ref);
 			} finally {
 				in.close();
@@ -297,13 +306,15 @@ class RefDatabase {
 		// Prefer loose ref to packed ref as the loose
 		// file can be more up-to-date than a packed one.
 		//
-		CachedRef ref = looseRefs.get(name);
+		Ref ref = looseRefs.get(name);
 		final File loose = fileForRef(name);
 		final long mtime = loose.lastModified();
 		if (ref != null) {
-			if (ref.lastModified == mtime)
+			Long cachedlastModified = looseRefsMTime.get(name);
+			if (cachedlastModified != null && cachedlastModified == mtime)
 				return ref;
 			looseRefs.remove(name);
+			looseRefsMTime.remove(name);
 		}
 
 		if (mtime == 0) {
@@ -331,6 +342,10 @@ class RefDatabase {
 
 			final String target = line.substring("ref: ".length());
 			final Ref r = readRefBasic(target, depth + 1);
+			Long cachedMtime = looseRefsMTime.get(name);
+			if (cachedMtime != null && cachedMtime != mtime)
+				setModified();
+			looseRefsMTime.put(name, mtime);
 			return r != null ? r : new Ref(Ref.Storage.LOOSE, target, null);
 		}
 
@@ -343,8 +358,9 @@ class RefDatabase {
 			throw new IOException("Not a ref: " + name + ": " + line);
 		}
 
-		ref = new CachedRef(Ref.Storage.LOOSE, name, id, mtime);
+		ref = new Ref(Ref.Storage.LOOSE, name, id);
 		looseRefs.put(name, ref);
+		looseRefsMTime.put(name, mtime);
 		return ref;
 	}
 
@@ -421,14 +437,4 @@ class RefDatabase {
 				fileLocation), CHAR_ENC));
 	}
 
-	private static class CachedRef extends Ref {
-		final long lastModified;
-
-		CachedRef(final Storage st, final String refName, final ObjectId id,
-				final long mtime) {
-			super(st, refName, id);
-			lastModified = mtime;
-		}
-	}
-
 }
-- 
1.5.6.2.220.g44701
