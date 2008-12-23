From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Add "jgit clone" to support cloning off URLs that are JGit specific
Date: Tue, 23 Dec 2008 10:03:42 -0800
Message-ID: <1230055423-9944-5-git-send-email-spearce@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org>
 <1230055423-9944-2-git-send-email-spearce@spearce.org>
 <1230055423-9944-3-git-send-email-spearce@spearce.org>
 <1230055423-9944-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBdd-0002sv-Fq
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYLWSEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYLWSEA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:04:00 -0500
Received: from george.spearce.org ([209.20.77.23]:58229 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbYLWSD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 13:03:59 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0882D38210; Tue, 23 Dec 2008 18:03:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8E83638215;
	Tue, 23 Dec 2008 18:03:44 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230055423-9944-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103841>

The amazon-s3:// protocol is unique to JGit, and is not supported
by any other Git implementation.  The easiest way to clone off of
one of those URLs is to use "jgit clone".  This program also acts
as a simple example for any IDE developers who want to implement
a clone feature, as it is the minimum effort required to make a
user reasonably happy with the resulting repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../org/spearce/jgit/pgm/AbstractFetchCommand.java |  126 ++++++++++++++
 .../src/org/spearce/jgit/pgm/Clone.java            |  177 ++++++++++++++++++++
 .../src/org/spearce/jgit/pgm/Fetch.java            |   83 +---------
 4 files changed, 306 insertions(+), 81 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Clone.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 4a2b605..40177f9 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -1,4 +1,5 @@
 org.spearce.jgit.pgm.Branch
+org.spearce.jgit.pgm.Clone
 org.spearce.jgit.pgm.Daemon
 org.spearce.jgit.pgm.DiffTree
 org.spearce.jgit.pgm.Fetch
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
new file mode 100644
index 0000000..ea6f277
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.RefUpdate;
+import org.spearce.jgit.transport.FetchResult;
+import org.spearce.jgit.transport.TrackingRefUpdate;
+import org.spearce.jgit.transport.Transport;
+
+abstract class AbstractFetchCommand extends TextBuiltin {
+	@Option(name = "--verbose", aliases = { "-v" }, usage = "be more verbose")
+	private boolean verbose;
+
+	protected void showFetchResult(final Transport tn, final FetchResult r) {
+		boolean shownURI = false;
+		for (final TrackingRefUpdate u : r.getTrackingRefUpdates()) {
+			if (!verbose && u.getResult() == RefUpdate.Result.NO_CHANGE)
+				continue;
+
+			final char type = shortTypeOf(u.getResult());
+			final String longType = longTypeOf(u);
+			final String src = abbreviateRef(u.getRemoteName(), false);
+			final String dst = abbreviateRef(u.getLocalName(), true);
+
+			if (!shownURI) {
+				out.print("From ");
+				out.print(tn.getURI());
+				out.println();
+				shownURI = true;
+			}
+
+			out.format(" %c %-17s %-10s -> %s", type, longType, src, dst);
+			out.println();
+		}
+	}
+
+	private String longTypeOf(final TrackingRefUpdate u) {
+		final RefUpdate.Result r = u.getResult();
+		if (r == RefUpdate.Result.LOCK_FAILURE)
+			return "[lock fail]";
+
+		if (r == RefUpdate.Result.IO_FAILURE)
+			return "[i/o error]";
+
+		if (r == RefUpdate.Result.NEW) {
+			if (u.getRemoteName().startsWith(Constants.R_HEADS))
+				return "[new branch]";
+			else if (u.getLocalName().startsWith(Constants.R_TAGS))
+				return "[new tag]";
+			return "[new]";
+		}
+
+		if (r == RefUpdate.Result.FORCED) {
+			final String aOld = u.getOldObjectId().abbreviate(db).name();
+			final String aNew = u.getNewObjectId().abbreviate(db).name();
+			return aOld + "..." + aNew;
+		}
+
+		if (r == RefUpdate.Result.FAST_FORWARD) {
+			final String aOld = u.getOldObjectId().abbreviate(db).name();
+			final String aNew = u.getNewObjectId().abbreviate(db).name();
+			return aOld + ".." + aNew;
+		}
+
+		if (r == RefUpdate.Result.REJECTED)
+			return "[rejected]";
+		if (r == RefUpdate.Result.NO_CHANGE)
+			return "[up to date]";
+		return "[" + r.name() + "]";
+	}
+
+	private static char shortTypeOf(final RefUpdate.Result r) {
+		if (r == RefUpdate.Result.LOCK_FAILURE)
+			return '!';
+		if (r == RefUpdate.Result.IO_FAILURE)
+			return '!';
+		if (r == RefUpdate.Result.NEW)
+			return '*';
+		if (r == RefUpdate.Result.FORCED)
+			return '+';
+		if (r == RefUpdate.Result.FAST_FORWARD)
+			return ' ';
+		if (r == RefUpdate.Result.REJECTED)
+			return '!';
+		if (r == RefUpdate.Result.NO_CHANGE)
+			return '=';
+		return ' ';
+	}
+}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Clone.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Clone.java
new file mode 100644
index 0000000..51dd95d
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Clone.java
@@ -0,0 +1,177 @@
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
+import java.io.IOException;
+import java.net.URISyntaxException;
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.GitIndex;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RefComparator;
+import org.spearce.jgit.lib.RefUpdate;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.TextProgressMonitor;
+import org.spearce.jgit.lib.Tree;
+import org.spearce.jgit.lib.WorkDirCheckout;
+import org.spearce.jgit.transport.FetchResult;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
+
+@Command(common = true, usage = "Clone a repository into a new directory")
+class Clone extends AbstractFetchCommand {
+	@Option(name = "--origin", aliases = { "-o" }, metaVar = "name", usage = "use <name> instead of 'origin' to track upstream")
+	private String remoteName = "origin";
+
+	@Argument(index = 0, required = true, metaVar = "uri-ish")
+	private String sourceUri;
+
+	@Argument(index = 1, metaVar = "directory")
+	private String localName;
+
+	@Override
+	protected final boolean requiresRepository() {
+		return false;
+	}
+
+	@Override
+	protected void run() throws Exception {
+		if (localName != null && gitdir != null)
+			throw die("conflicting usage of --git-dir and arguments");
+
+		final URIish uri = new URIish(sourceUri);
+		if (localName == null) {
+			String p = uri.getPath();
+			while (p.endsWith("/"))
+				p = p.substring(0, p.length() - 1);
+			final int s = p.lastIndexOf('/');
+			if (s < 0)
+				throw die("cannot guess local name from " + sourceUri);
+			localName = p.substring(s + 1);
+			if (localName.endsWith(".git"))
+				localName = localName.substring(0, localName.length() - 4);
+		}
+		if (gitdir == null)
+			gitdir = new File(localName, ".git");
+		db = new Repository(gitdir);
+		db.create();
+		out.println("Initialized empty Git repository in "
+				+ gitdir.getAbsolutePath());
+		out.flush();
+
+		saveRemote(uri);
+		final FetchResult r = runFetch();
+		final Ref branch = guessHEAD(r);
+		doCheckout(branch);
+	}
+
+	private void saveRemote(final URIish uri) throws URISyntaxException,
+			IOException {
+		final RemoteConfig rc = new RemoteConfig(db.getConfig(), remoteName);
+		rc.addURI(uri);
+		rc.addFetchRefSpec(new RefSpec().setForceUpdate(true)
+				.setSourceDestination(Constants.R_HEADS + "*",
+						Constants.R_REMOTES + remoteName + "/*"));
+		rc.update(db.getConfig());
+		db.getConfig().save();
+	}
+
+	private FetchResult runFetch() throws NotSupportedException,
+			URISyntaxException, TransportException {
+		final Transport tn = Transport.open(db, remoteName);
+		final FetchResult r;
+		try {
+			r = tn.fetch(new TextProgressMonitor(), null);
+		} finally {
+			tn.close();
+		}
+		showFetchResult(tn, r);
+		return r;
+	}
+
+	private Ref guessHEAD(final FetchResult result) {
+		final Ref idHEAD = result.getAdvertisedRef(Constants.HEAD);
+		final List<Ref> availableRefs = new ArrayList<Ref>();
+		Ref head = null;
+		for (final Ref r : result.getAdvertisedRefs()) {
+			final String n = r.getName();
+			if (!n.startsWith(Constants.R_HEADS))
+				continue;
+			availableRefs.add(r);
+			if (idHEAD == null || head != null)
+				continue;
+			if (r.getObjectId().equals(idHEAD.getObjectId()))
+				head = r;
+		}
+		Collections.sort(availableRefs, RefComparator.INSTANCE);
+		if (idHEAD != null && head == null)
+			head = idHEAD;
+		return head;
+	}
+
+	private void doCheckout(final Ref branch) throws IOException {
+		if (branch == null)
+			throw die("cannot checkout; no HEAD advertised by remote");
+		if (!Constants.HEAD.equals(branch.getName()))
+			db.writeSymref(Constants.HEAD, branch.getName());
+
+		final Commit commit = db.mapCommit(branch.getObjectId());
+		final RefUpdate u = db.updateRef(Constants.HEAD);
+		u.setNewObjectId(commit.getCommitId());
+		u.forceUpdate();
+
+		final GitIndex index = new GitIndex(db);
+		final Tree tree = commit.getTree();
+		final WorkDirCheckout co;
+
+		co = new WorkDirCheckout(db, db.getWorkDir(), index, tree);
+		co.checkout();
+		index.write();
+	}
+}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index e9d3260..8f3f7d5 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -41,19 +41,13 @@
 
 import org.kohsuke.args4j.Argument;
 import org.kohsuke.args4j.Option;
-import org.spearce.jgit.lib.Constants;
-import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.TextProgressMonitor;
 import org.spearce.jgit.transport.FetchResult;
 import org.spearce.jgit.transport.RefSpec;
-import org.spearce.jgit.transport.TrackingRefUpdate;
 import org.spearce.jgit.transport.Transport;
 
 @Command(common = true, usage = "Update remote refs from another repository")
-class Fetch extends TextBuiltin {
-	@Option(name = "--verbose", aliases = { "-v" }, usage = "be more verbose")
-	private boolean verbose;
-
+class Fetch extends AbstractFetchCommand {
 	@Option(name = "--fsck", usage = "perform fsck style checks on receive")
 	private Boolean fsck;
 
@@ -91,79 +85,6 @@ protected void run() throws Exception {
 		} finally {
 			tn.close();
 		}
-
-		boolean shownURI = false;
-		for (final TrackingRefUpdate u : r.getTrackingRefUpdates()) {
-			if (!verbose && u.getResult() == RefUpdate.Result.NO_CHANGE)
-				continue;
-
-			final char type = shortTypeOf(u.getResult());
-			final String longType = longTypeOf(u);
-			final String src = abbreviateRef(u.getRemoteName(), false);
-			final String dst = abbreviateRef(u.getLocalName(), true);
-
-			if (!shownURI) {
-				out.print("From ");
-				out.print(tn.getURI());
-				out.println();
-				shownURI = true;
-			}
-
-			out.format(" %c %-17s %-10s -> %s", type, longType, src, dst);
-			out.println();
-		}
-	}
-
-	private String longTypeOf(final TrackingRefUpdate u) {
-		final RefUpdate.Result r = u.getResult();
-		if (r == RefUpdate.Result.LOCK_FAILURE)
-			return "[lock fail]";
-
-		if (r == RefUpdate.Result.IO_FAILURE)
-			return "[i/o error]";
-
-		if (r == RefUpdate.Result.NEW) {
-			if (u.getRemoteName().startsWith(Constants.R_HEADS))
-				return "[new branch]";
-			else if (u.getLocalName().startsWith(Constants.R_TAGS))
-				return "[new tag]";
-			return "[new]";
-		}
-
-		if (r == RefUpdate.Result.FORCED) {
-			final String aOld = u.getOldObjectId().abbreviate(db).name();
-			final String aNew = u.getNewObjectId().abbreviate(db).name();
-			return aOld + "..." + aNew;
-		}
-
-		if (r == RefUpdate.Result.FAST_FORWARD) {
-			final String aOld = u.getOldObjectId().abbreviate(db).name();
-			final String aNew = u.getNewObjectId().abbreviate(db).name();
-			return aOld + ".." + aNew;
-		}
-
-		if (r == RefUpdate.Result.REJECTED)
-			return "[rejected]";
-		if (r == RefUpdate.Result.NO_CHANGE)
-			return "[up to date]";
-		return "[" + r.name() + "]";
-	}
-
-	private static char shortTypeOf(final RefUpdate.Result r) {
-		if (r == RefUpdate.Result.LOCK_FAILURE)
-			return '!';
-		if (r == RefUpdate.Result.IO_FAILURE)
-			return '!';
-		if (r == RefUpdate.Result.NEW)
-			return '*';
-		if (r == RefUpdate.Result.FORCED)
-			return '+';
-		if (r == RefUpdate.Result.FAST_FORWARD)
-			return ' ';
-		if (r == RefUpdate.Result.REJECTED)
-			return '!';
-		if (r == RefUpdate.Result.NO_CHANGE)
-			return '=';
-		return ' ';
+		showFetchResult(tn, r);
 	}
 }
-- 
1.6.1.rc4.301.g5497a
