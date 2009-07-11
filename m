From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/11] Send .have lines in ReceivePack for alternate repositories
Date: Sat, 11 Jul 2009 13:19:26 -0700
Message-ID: <1247343566-19025-12-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
 <1247343566-19025-5-git-send-email-spearce@spearce.org>
 <1247343566-19025-6-git-send-email-spearce@spearce.org>
 <1247343566-19025-7-git-send-email-spearce@spearce.org>
 <1247343566-19025-8-git-send-email-spearce@spearce.org>
 <1247343566-19025-9-git-send-email-spearce@spearce.org>
 <1247343566-19025-10-git-send-email-spearce@spearce.org>
 <1247343566-19025-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj3t-0003g9-Ks
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbZGKUTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbZGKUTv
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:51 -0400
Received: from george.spearce.org ([209.20.77.23]:39721 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZGKUTe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D6B77381FF; Sat, 11 Jul 2009 20:19:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 743FE381D2;
	Sat, 11 Jul 2009 20:19:30 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123126>

If we are borrowing objects from an alternate repository we should
send the alternates' refs, but under the magical ".have" name, so
that a push client won't transmit objects that our alternate already
contains for us.  To save bandwidth during the advertisement phase
of the connection any duplicates are skipped.  This way we don't
send a ".have" if we have already sent that same object name under
a different ref, or under a prior have line.

In 5d3a6706eef2 we introduced the client side support for this,
and now we introduce the corresponding server side support.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |    1 +
 .../org/spearce/jgit/transport/RefAdvertiser.java  |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 1c490af..472e0b5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -514,6 +514,7 @@ private void sendAdvertisedRefs() throws IOException {
 		adv.send(refs.values());
 		if (head != null && head.getName() == head.getOrigName())
 			adv.advertiseHave(head.getObjectId());
+		adv.includeAdditionalHaves();
 		if (adv.isEmpty())
 			adv.advertiseId(ObjectId.zeroId(), "capabilities^{}");
 		pckOut.end();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
index 91700da..1f6adc5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
@@ -42,10 +42,13 @@
 import java.util.LinkedHashSet;
 import java.util.Set;
 
+import org.spearce.jgit.lib.AlternateRepositoryDatabase;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectDatabase;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefComparator;
+import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevTag;
@@ -104,6 +107,22 @@ void advertiseHave(AnyObjectId id) throws IOException {
 		}
 	}
 
+	void includeAdditionalHaves() throws IOException {
+		additionalHaves(walk.getRepository().getObjectDatabase());
+	}
+
+	private void additionalHaves(final ObjectDatabase db) throws IOException {
+		if (db instanceof AlternateRepositoryDatabase)
+			additionalHaves(((AlternateRepositoryDatabase) db).getRepository());
+		for (ObjectDatabase alt : db.getAlternates())
+			additionalHaves(alt);
+	}
+
+	private void additionalHaves(final Repository alt) throws IOException {
+		for (final Ref r : alt.getAllRefs().values())
+			advertiseHave(r.getObjectId());
+	}
+
 	boolean isEmpty() {
 		return first;
 	}
-- 
1.6.4.rc0.117.g28cb
