From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/11] Don't advertise HEAD from ReceivePack
Date: Sat, 11 Jul 2009 13:19:20 -0700
Message-ID: <1247343566-19025-6-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
 <1247343566-19025-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj3p-0003g9-7r
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbZGKUTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbZGKUTj
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:39 -0400
Received: from george.spearce.org ([209.20.77.23]:39703 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZGKUTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E543E38262; Sat, 11 Jul 2009 20:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 952AD38194;
	Sat, 11 Jul 2009 20:19:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123124>

The HEAD ref cannot be pushed to by a client, if it is a detached HEAD
the client shouldn't be permitted to change it, if it is a symref to
another ref then the client should update the destination ref and not
the symref.  Instead offer the HEAD ref as a ".have" line, which is an
invalid ref that the client can't update but still lets the client know
we have its target object reachable.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |    5 ++++-
 .../org/spearce/jgit/transport/RefAdvertiser.java  |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index fd8aa86..1c490af 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -509,8 +509,11 @@ private void sendAdvertisedRefs() throws IOException {
 		adv.advertiseCapability(CAPABILITY_REPORT_STATUS);
 		if (allowOfsDelta)
 			adv.advertiseCapability(CAPABILITY_OFS_DELTA);
-		refs = db.getAllRefs();
+		refs = new HashMap<String, Ref>(db.getAllRefs());
+		final Ref head = refs.remove(Constants.HEAD);
 		adv.send(refs.values());
+		if (head != null && head.getName() == head.getOrigName())
+			adv.advertiseHave(head.getObjectId());
 		if (adv.isEmpty())
 			adv.advertiseId(ObjectId.zeroId(), "capabilities^{}");
 		pckOut.end();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
index 245891d..91700da 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
@@ -95,6 +95,15 @@ void send(final Collection<Ref> refs) throws IOException {
 		}
 	}
 
+	void advertiseHave(AnyObjectId id) throws IOException {
+		RevObject obj = parseAnyOrNull(id);
+		if (obj != null) {
+			advertiseAnyOnce(obj, ".have");
+			if (obj instanceof RevTag)
+				advertiseAnyOnce(((RevTag) obj).getObject(), ".have");
+		}
+	}
+
 	boolean isEmpty() {
 		return first;
 	}
@@ -109,6 +118,12 @@ private RevObject parseAnyOrNull(final AnyObjectId id) {
 		}
 	}
 
+	private void advertiseAnyOnce(final RevObject obj, final String refName)
+			throws IOException {
+		if (!obj.has(ADVERTISED))
+			advertiseAny(obj, refName);
+	}
+
 	private void advertiseAny(final RevObject obj, final String refName)
 			throws IOException {
 		obj.add(ADVERTISED);
-- 
1.6.4.rc0.117.g28cb
