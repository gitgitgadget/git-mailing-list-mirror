From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Use ".have" advertisements during push to reduce what is transferred
Date: Wed, 24 Sep 2008 12:05:53 -0700
Message-ID: <1222283153-10534-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:07:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiZhZ-0000B9-QP
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 21:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYIXTF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 15:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbYIXTFz
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 15:05:55 -0400
Received: from george.spearce.org ([209.20.77.23]:49190 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYIXTFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 15:05:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6BAE538360; Wed, 24 Sep 2008 19:05:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AFE6A38357;
	Wed, 24 Sep 2008 19:05:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.471.g47a76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96681>

If a remote peer has an alternate object database it might show
the refs of the alternate repositories by sending special ".have"
ref lines in the advertisement.  These can be used to compute a
better common base, avoiding uploading objects which the remote
side has physically available (and complete), but which aren't in
the ref space of the remote repository.

As most repositories have more than one ref, there can be more than
one ".have" line, and the same object might appear more than once.
Collecting these into a special "additionalHaves" set avoids them
from showing up in the advertised refs collection.

PackWriter already gracefully skips over remoteObjects that
we don't have locally.  We can simply include the entire set
of additionalHaves when we start creating a pack for the push
transfer and PackWriter will seek the best common base available.
Anything advertised that we lack will be silently skipped.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I'm likely to merge Junio's jc/alternate-push branch in git.git
 from next to master when I start merging over the cooked topics.

 JGit clients need this to prevent crashing when they talk to a
 newer git-receive-pack process that is sending these .have lines.
 Without this patch JGit will throw a "duplicate advertisement"
 error when it receives more than one ref with the name ".have".

 Fortunately the entire implementation of the client side of this
 alternate-push feature is 7 lines of Java.

 See http://thread.gmane.org/gmane.comp.version-control.git/95351

 .../spearce/jgit/transport/BasePackConnection.java |    7 ++++++-
 .../jgit/transport/BasePackPushConnection.java     |    1 +
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 2d145a6..e5fc040 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -93,6 +93,9 @@
 	/** Capability tokens advertised by the remote side. */
 	private final Set<String> remoteCapablities = new HashSet<String>();
 
+	/** Extra objects the remote has, but which aren't offered as refs. */
+	protected final Set<ObjectId> additionalHaves = new HashSet<ObjectId>();
+
 	BasePackConnection(final PackTransport packTransport) {
 		local = packTransport.local;
 		uri = packTransport.uri;
@@ -160,7 +163,9 @@ private void readAdvertisedRefsImpl() throws IOException {
 			}
 
 			final ObjectId id = ObjectId.fromString(line.substring(0, 40));
-			if (name.endsWith("^{}")) {
+			if (name.equals(".have")) {
+				additionalHaves.add(id);
+			} else if (name.endsWith("^{}")) {
 				name = name.substring(0, name.length() - 3);
 				final Ref prior = avail.get(name);
 				if (prior == null)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 2594623..17f6915 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -195,6 +195,7 @@ private void writePack(final Map<String, RemoteRefUpdate> refUpdates,
 
 		for (final Ref r : getRefs())
 			remoteObjects.add(r.getObjectId());
+		remoteObjects.addAll(additionalHaves);
 		for (final RemoteRefUpdate r : refUpdates.values()) {
 			if (!ObjectId.zeroId().equals(r.getNewObjectId()))
 				newObjects.add(r.getNewObjectId());
-- 
1.6.0.2.471.g47a76
