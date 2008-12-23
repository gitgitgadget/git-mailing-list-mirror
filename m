From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Add "jgit receive-pack" and permit commands to start not in a repository
Date: Tue, 23 Dec 2008 10:03:39 -0800
Message-ID: <1230055423-9944-2-git-send-email-spearce@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBdb-0002sv-NG
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYLWSDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbYLWSDv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:03:51 -0500
Received: from george.spearce.org ([209.20.77.23]:58220 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbYLWSDu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 13:03:50 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 808C938221; Tue, 23 Dec 2008 18:03:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A6E8838200;
	Tue, 23 Dec 2008 18:03:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230055423-9944-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103845>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Main.java             |   19 +++---
 .../src/org/spearce/jgit/pgm/ReceivePack.java      |   67 ++++++++++++++++++++
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   24 ++++++-
 4 files changed, 99 insertions(+), 12 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 5fb0953..0e7e7d8 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -9,6 +9,7 @@ org.spearce.jgit.pgm.LsRemote
 org.spearce.jgit.pgm.LsTree
 org.spearce.jgit.pgm.MergeBase
 org.spearce.jgit.pgm.Push
+org.spearce.jgit.pgm.ReceivePack
 org.spearce.jgit.pgm.RevList
 org.spearce.jgit.pgm.Rm
 org.spearce.jgit.pgm.ShowRev
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
index c8bade8..8de4ae9 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
@@ -143,15 +143,18 @@ private void execute(final String[] argv) throws Exception {
 			System.exit(1);
 		}
 
-		if (gitdir == null)
-			gitdir = findGitDir();
-		if (gitdir == null || !gitdir.isDirectory()) {
-			System.err.println("error: can't find git directory");
-			System.exit(1);
-		}
-
 		final TextBuiltin cmd = subcommand;
-		cmd.init(new Repository(gitdir));
+		if (cmd.requiresRepository()) {
+			if (gitdir == null)
+				gitdir = findGitDir();
+			if (gitdir == null || !gitdir.isDirectory()) {
+				System.err.println("error: can't find git directory");
+				System.exit(1);
+			}
+			cmd.init(new Repository(gitdir), gitdir);
+		} else {
+			cmd.init(null, gitdir);
+		}
 		try {
 			cmd.execute(arguments.toArray(new String[arguments.size()]));
 		} finally {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java
new file mode 100644
index 0000000..579f893
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+ * - Neither the name of the Git Development Community nor the
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
+
+package org.spearce.jgit.pgm;
+
+import java.io.File;
+
+import org.kohsuke.args4j.Argument;
+import org.spearce.jgit.lib.Repository;
+
+@Command(common = false, usage = "Server side backend for 'jgit push'")
+class ReceivePack extends TextBuiltin {
+	@Argument(index = 0, required = true, metaVar = "DIRECTORY", usage = "Repository to receive into")
+	File gitdir;
+
+	@Override
+	protected final boolean requiresRepository() {
+		return false;
+	}
+
+	@Override
+	protected void run() throws Exception {
+		final org.spearce.jgit.transport.ReceivePack rp;
+
+		if (new File(gitdir, ".git").isDirectory())
+			gitdir = new File(gitdir, ".git");
+		db = new Repository(gitdir);
+		if (!db.getObjectsDirectory().isDirectory())
+			throw die("'" + gitdir.getPath() + "' not a git repository");
+		rp = new org.spearce.jgit.transport.ReceivePack(db);
+		rp.receive(System.in, System.out, System.err);
+	}
+}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index 1f3a136..d3e32b3 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -43,6 +43,7 @@
 import static org.spearce.jgit.lib.Constants.R_TAGS;
 
 import java.io.BufferedWriter;
+import java.io.File;
 import java.io.IOException;
 import java.io.OutputStreamWriter;
 import java.io.PrintWriter;
@@ -77,6 +78,9 @@
 	/** Git repository the command was invoked within. */
 	protected Repository db;
 
+	/** Directory supplied via --git-dir command line option. */
+	protected File gitdir;
+
 	/** RevWalk used during command line parsing, if it was required. */
 	protected RevWalk argWalk;
 
@@ -84,10 +88,15 @@ final void setCommandName(final String name) {
 		commandName = name;
 	}
 
-	void init(final Repository repo) {
+	/** @return true if {@link #db}/{@link #getRepository()} is required. */
+	protected boolean requiresRepository() {
+		return true;
+	}
+
+	void init(final Repository repo, final File gd) {
 		try {
-			String outputEncoding = repo.getConfig().getString("i18n", null,
-					"logOutputEncoding");
+			final String outputEncoding = repo != null ? repo.getConfig()
+					.getString("i18n", null, "logOutputEncoding") : null;
 			if (outputEncoding != null)
 				out = new PrintWriter(new BufferedWriter(
 						new OutputStreamWriter(System.out, outputEncoding)));
@@ -97,7 +106,14 @@ void init(final Repository repo) {
 		} catch (IOException e) {
 			throw die("cannot create output stream");
 		}
-		db = repo;
+
+		if (repo != null) {
+			db = repo;
+			gitdir = repo.getDirectory();
+		} else {
+			db = null;
+			gitdir = gd;
+		}
 	}
 
 	/**
-- 
1.6.1.rc4.301.g5497a
