From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Don't NPE in server code if a symbolic reference is incomplete
Date: Wed, 17 Jun 2009 19:12:00 -0700
Message-ID: <1245291120-16688-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 04:12:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH76p-00088O-It
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 04:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbZFRCMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 22:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbZFRCL7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 22:11:59 -0400
Received: from george.spearce.org ([209.20.77.23]:54468 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbZFRCL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 22:11:59 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BA449381FE; Thu, 18 Jun 2009 02:12:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CC64F3819E;
	Thu, 18 Jun 2009 02:12:00 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121790>

If a symbolic reference's target doesn't exist, then we still get the
Ref instance back from the database but its ObjectId is null.  Instead
of trying to advertise null as a SHA-1 to the client, skip it and say
nothing about that ref.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |   45 +++++++++++---------
 .../src/org/spearce/jgit/transport/UploadPack.java |    2 +
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index abaf876..c92a903 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -461,34 +461,39 @@ private void sendAdvertisedRefs() throws IOException {
 		final StringBuilder m = new StringBuilder(100);
 		final char[] idtmp = new char[2 * Constants.OBJECT_ID_LENGTH];
 		final Iterator<Ref> i = RefComparator.sort(refs.values()).iterator();
-		{
-			if (i.hasNext()) {
-				final Ref r = i.next();
-				format(m, idtmp, r.getObjectId(), r.getOrigName());
-			} else {
-				format(m, idtmp, ObjectId.zeroId(), "capabilities^{}");
-			}
-			m.append('\0');
-			m.append(' ');
-			m.append(CAPABILITY_DELETE_REFS);
-			m.append(' ');
-			m.append(CAPABILITY_REPORT_STATUS);
-			if (allowOfsDelta) {
-				m.append(' ');
-				m.append(CAPABILITY_OFS_DELTA);
-			}
-			m.append(' ');
-			writeAdvertisedRef(m);
-		}
-
+		boolean first = true;
 		while (i.hasNext()) {
 			final Ref r = i.next();
+			if (r.getObjectId() == null)
+				continue;
 			format(m, idtmp, r.getObjectId(), r.getOrigName());
+			if (first) {
+				first = false;
+				advertiseCapabilities(m);
+			}
+			writeAdvertisedRef(m);
+		}
+		if (first) {
+			format(m, idtmp, ObjectId.zeroId(), "capabilities^{}");
+			advertiseCapabilities(m);
 			writeAdvertisedRef(m);
 		}
 		pckOut.end();
 	}
 
+	private void advertiseCapabilities(final StringBuilder m) {
+		m.append('\0');
+		m.append(' ');
+		m.append(CAPABILITY_DELETE_REFS);
+		m.append(' ');
+		m.append(CAPABILITY_REPORT_STATUS);
+		if (allowOfsDelta) {
+			m.append(' ');
+			m.append(CAPABILITY_OFS_DELTA);
+		}
+		m.append(' ');
+	}
+
 	private void format(final StringBuilder m, final char[] idtmp,
 			final ObjectId id, final String name) {
 		m.setLength(0);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 159bd10..7d17b2d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -235,6 +235,8 @@ private void sendAdvertisedRefs() throws IOException {
 		}
 		while (i.hasNext()) {
 			final Ref r = i.next();
+			if (r.getObjectId() == null)
+				continue;
 			final RevObject o = safeParseAny(r.getObjectId());
 			if (o != null) {
 				advertise(m, idtmp, o, r.getOrigName());
-- 
1.6.3.2.406.gd6a466
