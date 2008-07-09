From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/4] Automatically initialize a new dumb repository during push
Date: Wed,  9 Jul 2008 00:15:30 -0400
Message-ID: <1215576931-4174-4-git-send-email-spearce@spearce.org>
References: <1215576931-4174-1-git-send-email-spearce@spearce.org>
 <1215576931-4174-2-git-send-email-spearce@spearce.org>
 <1215576931-4174-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 06:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGR6q-0004Ib-6h
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 06:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYGIEPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 00:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbYGIEPj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 00:15:39 -0400
Received: from george.spearce.org ([209.20.77.23]:46878 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbYGIEPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 00:15:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1254B382A1; Wed,  9 Jul 2008 04:15:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3D0DD38195;
	Wed,  9 Jul 2008 04:15:33 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1215576931-4174-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87843>

If we are pushing into a repository which has no refs and no packs
we can reasonably assume the repository is brand new.  In such
cases we must ensure there is a valid HEAD and config file in the
repository, otherwise Git clients reading the repository may not
be able to recognize its contents correctly.

By default we try to create HEAD from refs/heads/master, if that
is among the branches being pushed by the user.  This mirrors what
git-init would have initialized HEAD to be.  However if master was
not among the branches pushed then another branch is selected as a
reasonable default.

We initialize .git/config to a very bare configuration, listing
only the repository version.  We avoid setting up core.filemode as
we cannot genrally detect if the remote side understands executable
mode bits.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/WalkPushConnection.java |   54 ++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index e11b85a..bb5a653 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -48,6 +48,7 @@ import java.util.TreeMap;
 
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PackWriter;
 import org.spearce.jgit.lib.ProgressMonitor;
@@ -151,6 +152,12 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 		for (final RemoteRefUpdate u : updates)
 			updateCommand(u);
 
+		// Is this a new repository? If so we should create additional
+		// metadata files so it is properly initialized during the push.
+		//
+		if (!updates.isEmpty() && isNewRepository())
+			createNewRepository(updates);
+
 		if (!packedRefUpdates.isEmpty()) {
 			try {
 				dest.writePackedRefs(newRefs.values());
@@ -307,4 +314,51 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 			u.setMessage(e.getMessage());
 		}
 	}
+
+	private boolean isNewRepository() {
+		return getRefsMap().isEmpty() && packNames != null
+				&& packNames.isEmpty();
+	}
+
+	private void createNewRepository(final List<RemoteRefUpdate> updates)
+			throws TransportException {
+		try {
+			final String ref = "ref: " + pickHEAD(updates) + "\n";
+			final byte[] bytes = ref.getBytes(Constants.CHARACTER_ENCODING);
+			dest.writeFile("../HEAD", bytes);
+		} catch (IOException e) {
+			throw new TransportException(uri, "cannot create HEAD", e);
+		}
+
+		try {
+			final String config = "[core]\n"
+					+ "\trepositoryformatversion = 0\n";
+			final byte[] bytes = config.getBytes(Constants.CHARACTER_ENCODING);
+			dest.writeFile("../config", bytes);
+		} catch (IOException e) {
+			throw new TransportException(uri, "cannot create config", e);
+		}
+	}
+
+	private static String pickHEAD(final List<RemoteRefUpdate> updates) {
+		// Try to use master if the user is pushing that, it is the
+		// default branch and is likely what they want to remain as
+		// the default on the new remote.
+		//
+		for (final RemoteRefUpdate u : updates) {
+			final String n = u.getRemoteName();
+			if (n.equals(Constants.HEADS_PREFIX + "/" + Constants.MASTER))
+				return n;
+		}
+
+		// Pick any branch, under the assumption the user pushed only
+		// one to the remote side.
+		//
+		for (final RemoteRefUpdate u : updates) {
+			final String n = u.getRemoteName();
+			if (n.startsWith(Constants.HEADS_PREFIX + "/"))
+				return n;
+		}
+		return updates.get(0).getRemoteName();
+	}
 }
-- 
1.5.6.74.g8a5e
