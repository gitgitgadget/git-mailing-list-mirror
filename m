From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/3] Allow RefUpdate callers to control the PersonIdent recorded
Date: Wed,  4 Feb 2009 15:15:40 -0800
Message-ID: <1233789342-28079-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:17:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqze-0003e7-HS
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbZBDXPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbZBDXPp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:15:45 -0500
Received: from george.spearce.org ([209.20.77.23]:54318 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbZBDXPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:15:44 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id C97243821F; Wed,  4 Feb 2009 23:15:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C2CC93815E;
	Wed,  4 Feb 2009 23:15:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.2.492.g8554a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108459>

In server applications we may want to ensure the remote user
identity is used within the reflog, rather than whatever the
local repository might come up with.

This change introduces an optional RefLogIdent property of
the RefUpdate, settable by the caller to override any default
guessing performed within the ref log writer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   71 ++++++++++++-------
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   32 ++++++++-
 2 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
index 6de8c0f..a077051 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
@@ -42,7 +42,6 @@
 import java.io.File;
 import java.io.FileOutputStream;
 import java.io.IOException;
-import java.io.PrintWriter;
 
 /**
  * Utility class to add reflog entries
@@ -50,6 +49,49 @@
  * @author Dave Watson
  */
 public class RefLogWriter {
+	static void append(final RefUpdate u, final String msg) throws IOException {
+		final ObjectId oldId = u.getOldObjectId();
+		final ObjectId newId = u.getNewObjectId();
+		final Repository db = u.getRepository();
+		final PersonIdent ident = u.getRefLogIdent();
+
+		appendOneRecord(oldId, newId, ident, msg, db, u.getName());
+	}
+
+	private static void appendOneRecord(final ObjectId oldId,
+			final ObjectId newId, PersonIdent ident, final String msg,
+			final Repository db, final String refName) throws IOException {
+		if (ident == null)
+			ident = new PersonIdent(db);
+		else
+			ident = new PersonIdent(ident);
+
+		final StringBuilder r = new StringBuilder();
+		r.append(ObjectId.toString(oldId));
+		r.append(' ');
+		r.append(ObjectId.toString(newId));
+		r.append(' ');
+		r.append(ident.toExternalString());
+		r.append('\t');
+		r.append(msg);
+		r.append('\n');
+
+		final byte[] rec = Constants.encode(r.toString());
+		final File logdir = new File(db.getDirectory(), Constants.LOGS);
+		final File reflog = new File(logdir, refName);
+		final File refdir = reflog.getParentFile();
+
+		if (!refdir.exists() && !refdir.mkdirs())
+			throw new IOException("Cannot create directory " + refdir);
+
+		final FileOutputStream out = new FileOutputStream(reflog, true);
+		try {
+			out.write(rec);
+		} finally {
+			out.close();
+		}
+	}
+
 	/**
 	 * Writes reflog entry for ref specified by refName
 	 * 
@@ -64,33 +106,10 @@
 	 * @param refName
 	 *            full ref name
 	 * @throws IOException
+	 * @deprecated rely upon {@link RefUpdate}'s automatic logging instead.
 	 */
 	public static void writeReflog(Repository repo, ObjectId oldCommit,
 			ObjectId commit, String message, String refName) throws IOException {
-		String entry = buildReflogString(repo, oldCommit, commit, message);
-
-		File directory = repo.getDirectory();
-		File reflogfile = new File(directory, Constants.LOGS + "/" + refName);
-		File reflogdir = reflogfile.getParentFile();
-		if (!reflogdir.exists())
-			if (!reflogdir.mkdirs())
-				throw new IOException("Cannot create directory "+reflogdir);
-		PrintWriter writer = new PrintWriter(new FileOutputStream(reflogfile, true));
-		writer.println(entry);
-		writer.close();
+		appendOneRecord(oldCommit, commit, null, message, repo, refName);
 	}
-
-	private static String buildReflogString(Repository repo,
-			ObjectId oldCommit, ObjectId commit, String message) {
-		PersonIdent me = new PersonIdent(repo);
-		String initial = "";
-		if (oldCommit == null) {
-			oldCommit = ObjectId.zeroId();
-			initial = " (initial)";
-		}
-		String s = oldCommit.name() + " " + commit.name() + " "
-				+ me.toExternalString() + "\t" + message + initial;
-		return s;
-	}
-
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 1417f2c..1ce1e71 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -140,6 +140,9 @@
 	/** Does this specification ask for forced updated (rewind/reset)? */
 	private boolean force;
 
+	/** Identity to record action as within the reflog. */
+	private PersonIdent refLogIdent;
+
 	/** Message the caller wants included in the reflog. */
 	private String refLogMessage;
 
@@ -164,6 +167,11 @@ RefUpdate(final RefDatabase r, final Ref ref, final File f) {
 		looseFile = f;
 	}
 
+	/** @return the repository the updated ref resides in */
+	public Repository getRepository() {
+		return db.getRepository();
+	}
+
 	/**
 	 * Get the name of the ref this update will operate on.
 	 * 
@@ -232,6 +240,27 @@ public void setForceUpdate(final boolean b) {
 		force = b;
 	}
 
+	/** @return identity of the user making the change in the reflog. */
+	public PersonIdent getRefLogIdent() {
+		return refLogIdent;
+	}
+
+	/**
+	 * Set the identity of the user appearing in the reflog.
+	 * <p>
+	 * The timestamp portion of the identity is ignored. A new identity with the
+	 * current timestamp will be created automatically when the update occurs
+	 * and the log record is written.
+	 * 
+	 * @param pi
+	 *            identity of the user. If null the identity will be
+	 *            automatically determined based on the repository
+	 *            configuration.
+	 */
+	public void setRefLogIdent(final PersonIdent pi) {
+		refLogIdent = pi;
+	}
+
 	/**
 	 * Get the message to include in the reflog.
 	 * 
@@ -450,8 +479,7 @@ else if (status == Result.FAST_FORWARD)
 			else if (status == Result.NEW)
 				msg += ": created";
 		}
-		RefLogWriter.writeReflog(db.getRepository(), oldValue, newValue, msg,
-				getName());
+		RefLogWriter.append(this, msg);
 		if (!lock.commit())
 			return Result.LOCK_FAILURE;
 		db.stored(this.ref.getOrigName(),  ref.getName(), newValue, lock.getCommitLastModified());
-- 
1.6.1.2.492.g8554a
