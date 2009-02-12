From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/6] Teach fetch to prune stale tracking branches
Date: Thu, 12 Feb 2009 15:54:40 -0800
Message-ID: <1234482880-1316-7-git-send-email-spearce@spearce.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org>
 <1234482880-1316-2-git-send-email-spearce@spearce.org>
 <1234482880-1316-3-git-send-email-spearce@spearce.org>
 <1234482880-1316-4-git-send-email-spearce@spearce.org>
 <1234482880-1316-5-git-send-email-spearce@spearce.org>
 <1234482880-1316-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlPo-0004ei-MO
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbZBLXy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbZBLXyy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:54:54 -0500
Received: from george.spearce.org ([209.20.77.23]:49164 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZBLXyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:54:46 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D788938211; Thu, 12 Feb 2009 23:54:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7473238210;
	Thu, 12 Feb 2009 23:54:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.226.gf08f
In-Reply-To: <1234482880-1316-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109691>

If the source branch for a local tracking branch has been removed
from the remote repository, users may also want (or need) to delete
it from the local repository.  A good example is when a branch named
"refs/heads/bar" switches from a file to a directory, and the local
path name in "refs/remotes/origin/bar" must also change.

Local deletes are done before updates, to handle this special case
of file to directory (or directory to file) conversions with as few
errors as possible.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/pgm/AbstractFetchCommand.java |    8 ++-
 .../src/org/spearce/jgit/pgm/Fetch.java            |    9 ++++
 .../org/spearce/jgit/transport/FetchProcess.java   |   48 ++++++++++++++++++++
 .../src/org/spearce/jgit/transport/Transport.java  |   27 +++++++++++
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
index ea6f277..f5a9d65 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
@@ -39,6 +39,7 @@
 
 import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.transport.FetchResult;
 import org.spearce.jgit.transport.TrackingRefUpdate;
@@ -75,9 +76,12 @@ private String longTypeOf(final TrackingRefUpdate u) {
 		final RefUpdate.Result r = u.getResult();
 		if (r == RefUpdate.Result.LOCK_FAILURE)
 			return "[lock fail]";
-
 		if (r == RefUpdate.Result.IO_FAILURE)
 			return "[i/o error]";
+		if (r == RefUpdate.Result.REJECTED)
+			return "[rejected]";
+		if (ObjectId.zeroId().equals(u.getNewObjectId()))
+			return "[deleted]";
 
 		if (r == RefUpdate.Result.NEW) {
 			if (u.getRemoteName().startsWith(Constants.R_HEADS))
@@ -99,8 +103,6 @@ else if (u.getLocalName().startsWith(Constants.R_TAGS))
 			return aOld + ".." + aNew;
 		}
 
-		if (r == RefUpdate.Result.REJECTED)
-			return "[rejected]";
 		if (r == RefUpdate.Result.NO_CHANGE)
 			return "[up to date]";
 		return "[" + r.name() + "]";
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index 8f3f7d5..81d6893 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -56,6 +56,12 @@ void nofsck(final boolean ignored) {
 		fsck = Boolean.FALSE;
 	}
 
+	@Option(name = "--prune", usage = "prune stale tracking refs")
+	private Boolean prune;
+
+	@Option(name = "--dry-run")
+	private boolean dryRun;
+
 	@Option(name = "--thin", usage = "fetch thin pack")
 	private Boolean thin;
 
@@ -75,6 +81,9 @@ protected void run() throws Exception {
 		final Transport tn = Transport.open(db, remote);
 		if (fsck != null)
 			tn.setCheckFetchedObjects(fsck.booleanValue());
+		if (prune != null)
+			tn.setRemoveDeletedRefs(prune.booleanValue());
+		tn.setDryRun(dryRun);
 		if (thin != null)
 			tn.setFetchThin(thin.booleanValue());
 		final FetchResult r;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index 2ca8aeb..df64817 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -59,6 +59,7 @@
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.ObjectWalk;
 import org.spearce.jgit.revwalk.RevWalk;
 
@@ -152,6 +153,8 @@ else if (tagopt == TagOpt.FETCH_TAGS)
 		}
 
 		final RevWalk walk = new RevWalk(transport.local);
+		if (transport.isRemoveDeletedRefs())
+			deleteStaleTrackingRefs(result, walk);
 		for (TrackingRefUpdate u : localUpdates) {
 			try {
 				u.update(walk);
@@ -366,6 +369,51 @@ private TrackingRefUpdate createUpdate(final RefSpec spec,
 		return new TrackingRefUpdate(transport.local, spec, newId, "fetch");
 	}
 
+	private void deleteStaleTrackingRefs(final FetchResult result,
+			final RevWalk walk) throws TransportException {
+		final Repository db = transport.local;
+		for (final Ref ref : db.getAllRefs().values()) {
+			final String refname = ref.getName();
+			for (final RefSpec spec : toFetch) {
+				if (spec.matchDestination(refname)) {
+					final RefSpec s = spec.expandFromDestination(refname);
+					if (result.getAdvertisedRef(s.getSource()) == null) {
+						deleteTrackingRef(result, db, walk, s, ref);
+					}
+				}
+			}
+		}
+	}
+
+	private void deleteTrackingRef(final FetchResult result,
+			final Repository db, final RevWalk walk, final RefSpec spec,
+			final Ref localRef) throws TransportException {
+		final String name = localRef.getName();
+		try {
+			final TrackingRefUpdate u = new TrackingRefUpdate(db, name, spec
+					.getSource(), true, ObjectId.zeroId(), "deleted");
+			result.add(u);
+			if (transport.isDryRun()){
+				return;
+			}
+			u.delete(walk);
+			switch (u.getResult()) {
+			case NEW:
+			case NO_CHANGE:
+			case FAST_FORWARD:
+			case FORCED:
+				break;
+			default:
+				throw new TransportException(transport.getURI(),
+						"Cannot delete stale tracking ref " + name + ": "
+								+ u.getResult().name());
+			}
+		} catch (IOException e) {
+			throw new TransportException(transport.getURI(),
+					"Cannot delete stale tracking ref " + name, e);
+		}
+	}
+
 	private static boolean isTag(final Ref r) {
 		return isTag(r.getName());
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index e58b72a..3aec5ca 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -355,6 +355,9 @@ private static String findTrackingRefName(final String remoteName,
 	/** Should an incoming (fetch) transfer validate objects? */
 	private boolean checkFetchedObjects;
 
+	/** Should refs no longer on the source be pruned from the destination? */
+	private boolean removeDeletedRefs;
+
 	/**
 	 * Create a new transport instance.
 	 * 
@@ -516,6 +519,30 @@ public void setPushThin(final boolean pushThin) {
 	}
 
 	/**
+	 * @return true if destination refs should be removed if they no longer
+	 *         exist at the source repository.
+	 */
+	public boolean isRemoveDeletedRefs() {
+		return removeDeletedRefs;
+	}
+
+	/**
+	 * Set whether or not to remove refs which no longer exist in the source.
+	 * <p>
+	 * If true, refs at the destination repository (local for fetch, remote for
+	 * push) are deleted if they no longer exist on the source side (remote for
+	 * fetch, local for push).
+	 * <p>
+	 * False by default, as this may cause data to become unreachable, and
+	 * eventually be deleted on the next GC.
+	 *
+	 * @param remove true to remove refs that no longer exist.
+	 */
+	public void setRemoveDeletedRefs(final boolean remove) {
+		removeDeletedRefs = remove;
+	}
+
+	/**
 	 * Apply provided remote configuration on this transport.
 	 *
 	 * @param cfg
-- 
1.6.2.rc0.226.gf08f
