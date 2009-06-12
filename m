From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Unify RevWalk parsing code to be more consistent across types
Date: Fri, 12 Jun 2009 16:00:17 -0700
Message-ID: <1244847619-7364-4-git-send-email-spearce@spearce.org>
References: <1244847619-7364-1-git-send-email-spearce@spearce.org>
 <1244847619-7364-2-git-send-email-spearce@spearce.org>
 <1244847619-7364-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFjm-000336-Qy
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbZFLXAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZFLXAa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:00:30 -0400
Received: from george.spearce.org ([209.20.77.23]:40051 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZFLXAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:00:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8FC8E381FE; Fri, 12 Jun 2009 23:00:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3A3E0381FF;
	Fri, 12 Jun 2009 23:00:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244847619-7364-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121462>

The parse() method now verifies the object actually exists, and
not just that we have a handle to it (e.g. in the case of a tree
or a blob type).  This allowed us to push a chunk of the loading
code up into the RevObject base class, removing some duplication.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevBlob.java      |    5 ----
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |   11 +--------
 .../src/org/spearce/jgit/revwalk/RevObject.java    |   23 +++++++++++++++++--
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    9 +-------
 .../src/org/spearce/jgit/revwalk/RevTree.java      |    5 ----
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   14 ++---------
 6 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
index cf241cf..70eeac0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
@@ -53,11 +53,6 @@ protected RevBlob(final AnyObjectId id) {
 	}
 
 	@Override
-	void parse(final RevWalk walk) {
-		flags |= PARSED;
-	}
-	
-	@Override
 	public final int getType() {
 		return Constants.OBJ_BLOB;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 2a59ec4..679718e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -46,7 +46,6 @@
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.MutableObjectId;
-import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.util.RawParseUtils;
 
@@ -54,8 +53,6 @@
 public class RevCommit extends RevObject {
 	static final RevCommit[] NO_PARENTS = {};
 
-	private static final String TYPE_COMMIT = Constants.TYPE_COMMIT;
-
 	private RevTree tree;
 
 	RevCommit[] parents;
@@ -79,13 +76,7 @@ protected RevCommit(final AnyObjectId id) {
 	@Override
 	void parse(final RevWalk walk) throws MissingObjectException,
 			IncorrectObjectTypeException, IOException {
-		final ObjectLoader ldr = walk.db.openObject(walk.curs, this);
-		if (ldr == null)
-			throw new MissingObjectException(this, TYPE_COMMIT);
-		final byte[] data = ldr.getCachedBytes();
-		if (Constants.OBJ_COMMIT != ldr.getType())
-			throw new IncorrectObjectTypeException(this, TYPE_COMMIT);
-		parseCanonical(walk, data);
+		parseCanonical(walk, loadCanonical(walk));
 	}
 
 	void parseCanonical(final RevWalk walk, final byte[] raw) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 1a13d0a..0e0386c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -39,11 +39,13 @@
 
 import java.io.IOException;
 
+import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectLoader;
 
 /** Base object type accessed during revision walking. */
 public abstract class RevObject extends ObjectId {
@@ -55,9 +57,24 @@ RevObject(final AnyObjectId name) {
 		super(name);
 	}
 
-	abstract void parse(RevWalk walk) throws MissingObjectException,
-			IncorrectObjectTypeException, IOException;
-	
+	void parse(final RevWalk walk) throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		loadCanonical(walk);
+		flags |= PARSED;
+	}
+
+	final byte[] loadCanonical(final RevWalk walk) throws IOException,
+			MissingObjectException, IncorrectObjectTypeException,
+			CorruptObjectException {
+		final ObjectLoader ldr = walk.db.openObject(walk.curs, this);
+		if (ldr == null)
+			throw new MissingObjectException(this, getType());
+		final byte[] data = ldr.getCachedBytes();
+		if (getType() != ldr.getType())
+			throw new IncorrectObjectTypeException(this, getType());
+		return data;
+	}
+
 	/**
 	 * Get Git object type. See {@link Constants}.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index 83fd873..e876025 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -45,7 +45,6 @@
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
-import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.util.MutableInteger;
@@ -72,13 +71,7 @@ protected RevTag(final AnyObjectId id) {
 	@Override
 	void parse(final RevWalk walk) throws MissingObjectException,
 			IncorrectObjectTypeException, IOException {
-		final ObjectLoader ldr = walk.db.openObject(walk.curs, this);
-		if (ldr == null)
-			throw new MissingObjectException(this, Constants.TYPE_TAG);
-		final byte[] data = ldr.getCachedBytes();
-		if (Constants.OBJ_TAG != ldr.getType())
-			throw new IncorrectObjectTypeException(this, Constants.TYPE_TAG);
-		parseCanonical(walk, data);
+		parseCanonical(walk, loadCanonical(walk));
 	}
 
 	void parseCanonical(final RevWalk walk, final byte[] rawTag)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
index 4d767e4..e9f5d91 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
@@ -53,11 +53,6 @@ protected RevTree(final AnyObjectId id) {
 	}
 
 	@Override
-	void parse(final RevWalk walk) {
-		flags |= PARSED;
-	}
-	
-	@Override
 	public final int getType() {
 		return Constants.OBJ_TREE;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index f567a33..40bdb4e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -667,15 +667,7 @@ else if (!(c instanceof RevTree))
 					Constants.TYPE_TREE);
 		else
 			t = (RevTree) c;
-
-		if ((t.flags & PARSED) != 0)
-			return t;
-		final ObjectLoader ldr = db.openObject(curs, t);
-		if (ldr == null)
-			throw new MissingObjectException(t, Constants.TYPE_TREE);
-		if (ldr.getType() != Constants.OBJ_TREE)
-			throw new IncorrectObjectTypeException(t, Constants.TYPE_TREE);
-		t.flags |= PARSED;
+		parse(t);
 		return t;
 	}
 
@@ -731,8 +723,8 @@ public RevObject parseAny(final AnyObjectId id)
 				throw new IllegalArgumentException("Bad object type: " + type);
 			}
 			objects.add(r);
-		} else if ((r.flags & PARSED) == 0)
-			r.parse(this);
+		} else
+			parse(r);
 		return r;
 	}
 
-- 
1.6.3.2.367.gf0de
