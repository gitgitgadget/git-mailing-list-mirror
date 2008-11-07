From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/7] Keep original ref name when reading refs
Date: Fri,  7 Nov 2008 23:07:40 +0100
Message-ID: <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZWL-0008MC-Hc
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYKGWH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYKGWH5
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:07:57 -0500
Received: from mail.dewire.com ([83.140.172.130]:11962 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbYKGWHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BBBE1147EAF9;
	Fri,  7 Nov 2008 23:07:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0VxWJ7gDqZP; Fri,  7 Nov 2008 23:07:47 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E0A0D147EAF6;
	Fri,  7 Nov 2008 23:07:45 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
In-Reply-To: <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100345>

We want to know the original name of refs, not just the target name.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java |   63 +++++++++++++++++++-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   45 +++++++++-----
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   14 ++---
 3 files changed, 94 insertions(+), 28 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
index db94875..2f102af 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
@@ -43,6 +43,11 @@
  * A ref in Git is (more or less) a variable that holds a single object
  * identifier. The object identifier can be any valid Git object (blob, tree,
  * commit, annotated tag, ...).
+ * <p>
+ * The ref name has the attributes of the ref that was asked for as well as
+ * the ref it was resolved to for symbolic refs plus the object id it points
+ * to and (for tags) the peeled target object id, i.e. the tag resolved
+ * recursively until a non-tag object is referenced.
  */
 public class Ref {
 	/** Location where a {@link Ref} is stored. */
@@ -119,19 +124,24 @@ public boolean isPacked() {
 
 	private ObjectId peeledObjectId;
 
+	private final String origName;
+
 	/**
 	 * Create a new ref pairing.
 	 * 
 	 * @param st
 	 *            method used to store this ref.
+	 * @param origName
+	 *            The name used to resolve this ref
 	 * @param refName
 	 *            name of this ref.
 	 * @param id
 	 *            current value of the ref. May be null to indicate a ref that
 	 *            does not exist yet.
 	 */
-	public Ref(final Storage st, final String refName, final ObjectId id) {
+	public Ref(final Storage st, final String origName, final String refName, final ObjectId id) {
 		storage = st;
+		this.origName = origName;
 		name = refName;
 		objectId = id;
 	}
@@ -146,19 +156,56 @@ public Ref(final Storage st, final String refName, final ObjectId id) {
 	 * @param id
 	 *            current value of the ref. May be null to indicate a ref that
 	 *            does not exist yet.
+	 */
+	public Ref(final Storage st, final String refName, final ObjectId id) {
+		this(st, refName, refName, id);
+	}
+
+	/**
+	 * Create a new ref pairing.
+	 * 
+	 * @param st
+	 *            method used to store this ref.
+	 * @param origName
+	 *            The name used to resolve this ref
+	 * @param refName
+	 *            name of this ref.
+	 * @param id
+	 *            current value of the ref. May be null to indicate a ref that
+	 *            does not exist yet.
 	 * @param peel
 	 *            peeled value of the ref's tag. May be null if this is not a
 	 *            tag or the peeled value is not known.
 	 */
-	public Ref(final Storage st, final String refName, final ObjectId id,
+	public Ref(final Storage st, final String origName, final String refName, final ObjectId id,
 			final ObjectId peel) {
 		storage = st;
+		this.origName = origName;
 		name = refName;
 		objectId = id;
 		peeledObjectId = peel;
 	}
 
 	/**
+	 * Create a new ref pairing.
+	 * 
+	 * @param st
+	 *            method used to store this ref.
+	 * @param refName
+	 *            name of this ref.
+	 * @param id
+	 *            current value of the ref. May be null to indicate a ref that
+	 *            does not exist yet.
+	 * @param peel
+	 *            peeled value of the ref's tag. May be null if this is not a
+	 *            tag or the peeled value is not known.
+	 */
+	public Ref(final Storage st, final String refName, final ObjectId id,
+			final ObjectId peel) {
+		this(st, refName, refName, id, peel);
+	}
+
+	/**
 	 * What this ref is called within the repository.
 	 * 
 	 * @return name of this ref.
@@ -168,6 +215,13 @@ public String getName() {
 	}
 
 	/**
+	 * @return the originally resolved name
+	 */
+	public String getOrigName() {
+		return origName;
+	}
+
+	/**
 	 * Cached value of this ref.
 	 * 
 	 * @return the value of this ref at the last time we read it.
@@ -200,6 +254,9 @@ public Storage getStorage() {
 	}
 
 	public String toString() {
-		return "Ref[" + name + "=" + ObjectId.toString(getObjectId()) + "]";
+		String o = "";
+		if (!origName.equals(name))
+			o = "(" + origName + ")";
+		return "Ref[" + o + name + "=" + ObjectId.toString(getObjectId()) + "]";
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 5c1f060..5a1b85f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -51,6 +51,7 @@
 import java.util.Map;
 
 import org.spearce.jgit.errors.ObjectWritingException;
+import org.spearce.jgit.lib.Ref.Storage;
 import org.spearce.jgit.util.FS;
 import org.spearce.jgit.util.NB;
 
@@ -135,8 +136,8 @@ RefUpdate newUpdate(final String name) throws IOException {
 		return new RefUpdate(this, r, fileForRef(r.getName()));
 	}
 
-	void stored(final String name, final ObjectId id, final long time) {
-		looseRefs.put(name, new Ref(Ref.Storage.LOOSE, name, id));
+	void stored(final String origName, final String name, final ObjectId id, final long time) {
+		looseRefs.put(name, new Ref(Ref.Storage.LOOSE, origName, name, id));
 		looseRefsMTime.put(name, time);
 		setModified();
 		db.fireRefsMaybeChanged();
@@ -222,12 +223,12 @@ private void readLooseRefs(final Map<String, Ref> avail,
 			final String entName = ent.getName();
 			if (".".equals(entName) || "..".equals(entName))
 				continue;
-			readOneLooseRef(avail, prefix + entName, ent);
+			readOneLooseRef(avail, prefix + entName, prefix + entName, ent);
 		}
 	}
 
 	private void readOneLooseRef(final Map<String, Ref> avail,
-			final String refName, final File ent) {
+			final String origName, final String refName, final File ent) {
 		// Unchanged and cached? Don't read it again.
 		//
 		Ref ref = looseRefs.get(refName);
@@ -270,7 +271,7 @@ private void readOneLooseRef(final Map<String, Ref> avail,
 					return;
 				}
 
-				ref = new Ref(Ref.Storage.LOOSE, refName, id);
+				ref = new Ref(Ref.Storage.LOOSE, origName, refName, id);
 				looseRefs.put(ref.getName(), ref);
 				looseRefsMTime.put(ref.getName(), ent.lastModified());
 				avail.put(ref.getName(), ref);
@@ -293,27 +294,35 @@ private File fileForRef(final String name) {
 		return new File(gitDir, name);
 	}
 
-	private Ref readRefBasic(final String name, final int depth)
+	private Ref readRefBasic(final String name, final int depth) throws IOException {
+		return readRefBasic(name, name, depth);
+	}
+
+	private Ref readRefBasic(final String origName, final String name, final int depth)
 			throws IOException {
 		// Prefer loose ref to packed ref as the loose
 		// file can be more up-to-date than a packed one.
 		//
-		Ref ref = looseRefs.get(name);
+		Ref ref = looseRefs.get(origName);
 		final File loose = fileForRef(name);
 		final long mtime = loose.lastModified();
 		if (ref != null) {
 			Long cachedlastModified = looseRefsMTime.get(name);
 			if (cachedlastModified != null && cachedlastModified == mtime)
 				return ref;
-			looseRefs.remove(name);
-			looseRefsMTime.remove(name);
+			looseRefs.remove(origName);
+			looseRefsMTime.remove(origName);
 		}
 
 		if (mtime == 0) {
 			// If last modified is 0 the file does not exist.
 			// Try packed cache.
 			//
-			return packedRefs.get(name);
+			ref = packedRefs.get(name);
+			if (ref != null)
+				if (!ref.getOrigName().equals(origName))
+					ref = new Ref(Storage.LOOSE_PACKED, origName, name, ref.getObjectId());
+			return ref;
 		}
 
 		final String line;
@@ -324,7 +333,7 @@ private Ref readRefBasic(final String name, final int depth)
 		}
 
 		if (line == null || line.length() == 0)
-			return new Ref(Ref.Storage.LOOSE, name, null);
+			return new Ref(Ref.Storage.LOOSE, origName, name, null);
 
 		if (line.startsWith("ref: ")) {
 			if (depth >= 5) {
@@ -333,12 +342,16 @@ private Ref readRefBasic(final String name, final int depth)
 			}
 
 			final String target = line.substring("ref: ".length());
-			final Ref r = readRefBasic(target, depth + 1);
+			Ref r = readRefBasic(target, target, depth + 1);
 			Long cachedMtime = looseRefsMTime.get(name);
 			if (cachedMtime != null && cachedMtime != mtime)
 				setModified();
 			looseRefsMTime.put(name, mtime);
-			return r != null ? r : new Ref(Ref.Storage.LOOSE, target, null);
+			if (r == null)
+				return new Ref(Ref.Storage.LOOSE, origName, target, null);
+			if (!origName.equals(r.getName()))
+				r = new Ref(Ref.Storage.LOOSE_PACKED, origName, r.getName(), r.getObjectId(), r.getPeeledObjectId());
+			return r; 
 		}
 
 		setModified();
@@ -350,7 +363,7 @@ private Ref readRefBasic(final String name, final int depth)
 			throw new IOException("Not a ref: " + name + ": " + line);
 		}
 
-		ref = new Ref(Ref.Storage.LOOSE, name, id);
+		ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
 		looseRefs.put(name, ref);
 		looseRefsMTime.put(name, mtime);
 		return ref;
@@ -384,7 +397,7 @@ private void refreshPackedRefs() {
 
 						final ObjectId id = ObjectId.fromString(p.substring(1));
 						last = new Ref(Ref.Storage.PACKED, last.getName(), last
-								.getObjectId(), id);
+								.getName(), last.getObjectId(), id);
 						newPackedRefs.put(last.getName(), last);
 						continue;
 					}
@@ -392,7 +405,7 @@ private void refreshPackedRefs() {
 					final int sp = p.indexOf(' ');
 					final ObjectId id = ObjectId.fromString(p.substring(0, sp));
 					final String name = new String(p.substring(sp + 1));
-					last = new Ref(Ref.Storage.PACKED, name, id);
+					last = new Ref(Ref.Storage.PACKED, name, name, id);
 					newPackedRefs.put(last.getName(), last);
 				}
 			} finally {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 86b44c5..235c2fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -131,9 +131,6 @@
 	/** Repository the ref is stored in. */
 	private final RefDatabase db;
 
-	/** Name of the ref. */
-	private final String name;
-
 	/** Location of the loose file holding the value of this ref. */
 	private final File looseFile;
 
@@ -160,7 +157,6 @@
 	RefUpdate(final RefDatabase r, final Ref ref, final File f) {
 		db = r;
 		this.ref = ref;
-		name = ref.getName();
 		oldValue = ref.getObjectId();
 		looseFile = f;
 	}
@@ -171,7 +167,7 @@ RefUpdate(final RefDatabase r, final Ref ref, final File f) {
 	 * @return name of this ref.
 	 */
 	public String getName() {
-		return name;
+		return ref.getName();
 	}
 
 	/**
@@ -349,9 +345,9 @@ public Result delete() throws IOException {
 	 * @throws IOException
 	 */
 	public Result delete(final RevWalk walk) throws IOException {
-		if (name.startsWith(Constants.R_HEADS)) {
+		if (getName().startsWith(Constants.R_HEADS)) {
 			final Ref head = db.readRef(Constants.HEAD);
-			if (head != null && name.equals(head.getName()))
+			if (head != null && getName().equals(head.getName()))
 				return Result.REJECTED_CURRENT_BRANCH;
 		}
 
@@ -373,7 +369,7 @@ private Result updateImpl(final RevWalk walk, final Store store)
 		if (!lock.lock())
 			return Result.LOCK_FAILURE;
 		try {
-			oldValue = db.idOf(name);
+			oldValue = db.idOf(getName());
 			if (oldValue == null)
 				return store.store(lock, Result.NEW);
 
@@ -428,7 +424,7 @@ else if (status == Result.NEW)
 				getName());
 		if (!lock.commit())
 			return Result.LOCK_FAILURE;
-		db.stored(name, newValue, lock.getCommitLastModified());
+		db.stored(this.ref.getOrigName(),  ref.getName(), newValue, lock.getCommitLastModified());
 		return status;
 	}
 
-- 
1.6.0.3.578.g6a50
