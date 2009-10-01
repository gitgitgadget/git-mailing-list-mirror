From: "Christian Halstrick" <christian.halstrick@sap.com>
Subject: [JGIT PATCH] Add support for logAllRefUpdates configuration parameter
Date: Thu,  1 Oct 2009 16:13:09 +0200
Message-ID: <1254406389-7472-1-git-send-email-christian.halstrick@sap.com>
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@sap.com>,
	Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 16:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtMRO-0008At-59
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 16:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbZJAONO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbZJAONO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 10:13:14 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:51512 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbZJAONM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 10:13:12 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n91EDC8I027121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Oct 2009 16:13:12 +0200 (MEST)
X-Mailer: git-send-email 1.6.4.msysgit.0
X-Scanner: Virus Scanner virwal08
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129394>

From: Christian Halstrick <christian.halstrick@sap.com>

Honor the configuration parameter core.logAllRefUpdates when writing reflogs.
Instead of writing reflog entries always only write reflogs if this parameter
is set to true or if the corresponding file in the <git-dir>/logs directory
already exists. In other words: if you are updating a ref and this parameter is
set to false and there is no file corresponding to your ref in the
<git-dir>/logs folder then no reflog will be written.

This is a fix for the issue http://code.google.com/p/egit/issues/detail?id=4

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
Signed-off-by: Christian Halstrick <christian.halstrick@sap.com>
---
 .../tst/org/eclipse/jgit/lib/ReflogConfigTest.java |  116 ++++++++++++++++++++
 .../src/org/eclipse/jgit/lib/CoreConfig.java       |   10 ++
 .../src/org/eclipse/jgit/lib/RefLogWriter.java     |   18 ++--
 .../src/org/eclipse/jgit/lib/Repository.java       |    1 +
 4 files changed, 137 insertions(+), 8 deletions(-)
 create mode 100644 org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/ReflogConfigTest.java

diff --git a/org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/ReflogConfigTest.java b/org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/ReflogConfigTest.java
new file mode 100644
index 0000000..6021050
--- /dev/null
+++ b/org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/ReflogConfigTest.java
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2009, Christian Halstrick, Matthias Sohn, SAP AG
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
+ * - Neither the name of the Eclipse Foundation, Inc. nor the
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
+package org.eclipse.jgit.lib;
+
+import java.io.IOException;
+
+public class ReflogConfigTest extends RepositoryTestCase {
+	public void testlogAllRefUpdates() throws Exception {
+		long commitTime = 1154236443000L;
+		int tz = -4 * 60;
+		int nrOfReflogs;
+
+		// check how many entries exist in the reflog and turn off writing
+		// reflogs
+		assertTrue(db.getConfig().getCore().isLogAllRefUpdates());
+		nrOfReflogs = db.getReflogReader(Constants.HEAD).getReverseEntries()
+				.size();
+		db.getConfig().setBoolean("core", null, "logAllRefUpdates", false);
+
+		// do one commit and check that reflog size is 0: no reflogs should be
+		// written
+		final Tree t = new Tree(db);
+		addFileToTree(t, "i-am-a-file", "and this is the data in me\n");
+		commit(t, "A Commit\n", new PersonIdent(jauthor, commitTime, tz),
+				new PersonIdent(jcommitter, commitTime, tz));
+		commitTime += 100;
+		assertTrue(
+				"Reflog for HEAD should contain one entry",
+				db.getReflogReader(Constants.HEAD).getReverseEntries().size() == nrOfReflogs);
+
+		// set the logAllRefUpdates parameter to true and check it
+		db.getConfig().setBoolean("core", null, "logAllRefUpdates", true);
+		assertTrue(db.getConfig().getCore().isLogAllRefUpdates());
+
+		// do one commit and check that reflog size is increased
+		addFileToTree(t, "i-am-another-file", "and this is other data in me\n");
+		commit(t, "A Commit\n", new PersonIdent(jauthor, commitTime, tz),
+				new PersonIdent(jcommitter, commitTime, tz));
+		commitTime += 100;
+		assertTrue(
+				"Reflog for HEAD should contain one additional entry",
+				db.getReflogReader(Constants.HEAD).getReverseEntries().size() == nrOfReflogs + 1);
+
+		// set the logAllRefUpdates parameter to false and check it
+		db.getConfig().setBoolean("core", null, "logAllRefUpdates", false);
+		assertFalse(db.getConfig().getCore().isLogAllRefUpdates());
+
+		// do one commit and check that reflog size is 2
+		addFileToTree(t, "i-am-anotheranother-file",
+				"and this is other other data in me\n");
+		commit(t, "A Commit\n", new PersonIdent(jauthor, commitTime, tz),
+				new PersonIdent(jcommitter, commitTime, tz));
+		assertTrue(
+				"Reflog for HEAD should contain two additional entries",
+				db.getReflogReader(Constants.HEAD).getReverseEntries().size() == nrOfReflogs + 2);
+	}
+
+	private void addFileToTree(final Tree t, String filename, String content)
+			throws IOException {
+		FileTreeEntry f = t.addFile(filename);
+		writeTrashFile(f.getName(), content);
+		t.accept(new WriteTree(trash, db), TreeEntry.MODIFIED_ONLY);
+	}
+
+	private void commit(final Tree t, String commitMsg, PersonIdent author,
+			PersonIdent committer) throws IOException {
+		final Commit commit = new Commit(db);
+		commit.setAuthor(author);
+		commit.setCommitter(committer);
+		commit.setMessage(commitMsg);
+		commit.setTree(t);
+		ObjectWriter writer = new ObjectWriter(db);
+		commit.setCommitId(writer.writeCommit(commit));
+
+		int nl = commitMsg.indexOf('\n');
+		final RefUpdate ru = db.updateRef(Constants.HEAD);
+		ru.setNewObjectId(commit.getCommitId());
+		ru.setRefLogMessage("commit : "
+				+ ((nl == -1) ? commitMsg : commitMsg.substring(0, nl)), false);
+		ru.forceUpdate();
+	}
+}
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/CoreConfig.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/CoreConfig.java
index d44120a..a945894 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/CoreConfig.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/CoreConfig.java
@@ -57,9 +57,12 @@ public CoreConfig parse(final Config cfg) {
 
 	private final int packIndexVersion;
 
+	private final boolean logAllRefUpdates;
+
 	private CoreConfig(final Config rc) {
 		compression = rc.getInt("core", "compression", DEFAULT_COMPRESSION);
 		packIndexVersion = rc.getInt("pack", "indexversion", 2);
+		logAllRefUpdates = rc.getBoolean("core", "logAllRefUpdates", true);
 	}
 
 	/**
@@ -77,4 +80,11 @@ public int getCompression() {
 	public int getPackIndexVersion() {
 		return packIndexVersion;
 	}
+
+	/**
+	 * @return whether to log all refUpdates
+	 */
+	public boolean isLogAllRefUpdates() {
+		return logAllRefUpdates;
+	}
 }
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/RefLogWriter.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/RefLogWriter.java
index 4141a13..a473c42 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/RefLogWriter.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/RefLogWriter.java
@@ -112,16 +112,18 @@ private static void appendOneRecord(final ObjectId oldId,
 		final byte[] rec = Constants.encode(r.toString());
 		final File logdir = new File(db.getDirectory(), Constants.LOGS);
 		final File reflog = new File(logdir, refName);
-		final File refdir = reflog.getParentFile();
+		if (reflog.exists() || db.getConfig().getCore().isLogAllRefUpdates()) {
+			final File refdir = reflog.getParentFile();
 
-		if (!refdir.exists() && !refdir.mkdirs())
-			throw new IOException("Cannot create directory " + refdir);
+			if (!refdir.exists() && !refdir.mkdirs())
+				throw new IOException("Cannot create directory " + refdir);
 
-		final FileOutputStream out = new FileOutputStream(reflog, true);
-		try {
-			out.write(rec);
-		} finally {
-			out.close();
+			final FileOutputStream out = new FileOutputStream(reflog, true);
+			try {
+				out.write(rec);
+			} finally {
+				out.close();
+			}
 		}
 	}
 
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/Repository.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/Repository.java
index f2451d4..1eb5895 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/Repository.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/Repository.java
@@ -187,6 +187,7 @@ public void create(boolean bare) throws IOException {
 		cfg.setBoolean("core", null, "filemode", true);
 		if (bare)
 			cfg.setBoolean("core", null, "bare", true);
+		cfg.setBoolean("core", null, "logAllRefupdates", !bare);
 		cfg.save();
 	}
 
-- 
1.6.4.msysgit.0
