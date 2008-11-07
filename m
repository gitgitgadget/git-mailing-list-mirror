From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/7] Handle peeling of loose refs.
Date: Fri,  7 Nov 2008 23:07:41 +0100
Message-ID: <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZWK-0008MC-LF
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYKGWH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYKGWHz
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:07:55 -0500
Received: from mail.dewire.com ([83.140.172.130]:11959 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbYKGWHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CA583147EAE3;
	Fri,  7 Nov 2008 23:07:49 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HLrme2qRxxfJ; Fri,  7 Nov 2008 23:07:48 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2CD8E147EAF9;
	Fri,  7 Nov 2008 23:07:46 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
In-Reply-To: <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100343>

For packed refs we got peeling automatically from packed-refs,
but for loose tags we have to follow the tags and get the leaf
object in order to comply with the documentation.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java |   22 +++++++++++----
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   28 +++++++++++++++++++-
 .../src/org/spearce/jgit/lib/Repository.java       |   13 +++++++++
 3 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
index 2f102af..1a6cc4c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
@@ -140,10 +140,7 @@ public boolean isPacked() {
 	 *            does not exist yet.
 	 */
 	public Ref(final Storage st, final String origName, final String refName, final ObjectId id) {
-		storage = st;
-		this.origName = origName;
-		name = refName;
-		objectId = id;
+		this(st, origName, refName, id, ObjectId.zeroId());
 	}
 
 	/**
@@ -158,7 +155,7 @@ public Ref(final Storage st, final String origName, final String refName, final 
 	 *            does not exist yet.
 	 */
 	public Ref(final Storage st, final String refName, final ObjectId id) {
-		this(st, refName, refName, id);
+		this(st, refName, refName, id, ObjectId.zeroId());
 	}
 
 	/**
@@ -175,7 +172,7 @@ public Ref(final Storage st, final String refName, final ObjectId id) {
 	 *            does not exist yet.
 	 * @param peel
 	 *            peeled value of the ref's tag. May be null if this is not a
-	 *            tag or the peeled value is not known.
+	 *            tag or the zero id if the peeled value is not known.
 	 */
 	public Ref(final Storage st, final String origName, final String refName, final ObjectId id,
 			final ObjectId peel) {
@@ -238,10 +235,19 @@ public ObjectId getObjectId() {
 	 *         refer to an annotated tag.
 	 */
 	public ObjectId getPeeledObjectId() {
+		if (peeledObjectId == ObjectId.zeroId())
+			return null;
 		return peeledObjectId;
 	}
 
 	/**
+	 * @return whether the Ref represents a peeled tag
+	 */
+	public boolean isPeeled() {
+		return peeledObjectId != null && peeledObjectId != ObjectId.zeroId();
+	}
+
+	/**
 	 * How was this ref obtained?
 	 * <p>
 	 * The current storage model of a Ref may influence how the ref must be
@@ -259,4 +265,8 @@ public String toString() {
 			o = "(" + origName + ")";
 		return "Ref[" + o + name + "=" + ObjectId.toString(getObjectId()) + "]";
 	}
+
+	void setPeeledObjectId(final ObjectId id) {
+		peeledObjectId = id;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 5a1b85f..0d73191 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -271,7 +271,8 @@ private void readOneLooseRef(final Map<String, Ref> avail,
 					return;
 				}
 
-				ref = new Ref(Ref.Storage.LOOSE, origName, refName, id);
+				ref = new Ref(Ref.Storage.LOOSE, origName, refName, id, null); // unpeeled
+
 				looseRefs.put(ref.getName(), ref);
 				looseRefsMTime.put(ref.getName(), ent.lastModified());
 				avail.put(ref.getName(), ref);
@@ -288,6 +289,28 @@ private void readOneLooseRef(final Map<String, Ref> avail,
 		}
 	}
 
+	Ref peel(final Ref ref) {
+		if (ref.isPeeled())
+			return ref;
+		try {
+			Object tt = db.mapObject(ref.getObjectId(), ref.getName());
+			if (tt != null && tt instanceof Tag) {
+				Tag t = (Tag)tt;
+				while (t != null && t.getType().equals(Constants.TYPE_TAG))
+					t = db.mapTag(t.getTag(), t.getObjId());
+				if (t != null)
+					ref.setPeeledObjectId(t.getObjId());
+				else
+					ref.setPeeledObjectId(null);
+			} else
+				ref.setPeeledObjectId(ref.getObjectId());
+		} catch (IOException e) {
+			// Serious error. Caller knows a ref should never be null
+			ref.setPeeledObjectId(null);
+		}
+		return ref;
+	}
+
 	private File fileForRef(final String name) {
 		if (name.startsWith(REFS_SLASH))
 			return new File(refsDir, name.substring(REFS_SLASH.length()));
@@ -364,6 +387,9 @@ private Ref readRefBasic(final String origName, final String name, final int dep
 		}
 
 		ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
+
+		looseRefs.put(origName, ref);
+		ref = new Ref(Ref.Storage.LOOSE, origName, id);
 		looseRefs.put(name, ref);
 		looseRefsMTime.put(name, mtime);
 		return ref;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 26748e2..4d6e6fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -939,6 +939,19 @@ public String getBranch() throws IOException {
 	}
 
 	/**
+	 * Peel a possibly unpeeled ref and updates it. If the ref cannot be peeled
+	 * the peeled id is set to {@link ObjectId#zeroId()}
+	 * 
+	 * @param ref
+	 *            The ref to peel
+	 * @return The same, an updated ref with peeled info or a new instance with
+	 *         more information
+	 */
+	public Ref peel(final Ref ref) {
+		return refs.peel(ref);
+	}
+
+	/**
 	 * @return true if HEAD points to a StGit patch.
 	 */
 	public boolean isStGitMode() {
-- 
1.6.0.3.578.g6a50
