From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/21] Refactor PackWriter to hold onto the sorted object list
Date: Sun, 29 Jun 2008 03:59:14 -0400
Message-ID: <1214726371-93520-5-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrri-0000I1-F6
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYF2IAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYF2IAe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36735 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYF2H7w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:59:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrp5-0004MD-M4; Sun, 29 Jun 2008 03:59:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id E6DD520FBAE; Sun, 29 Jun 2008 03:59:47 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 5663020FBCC;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-4-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86766>

When creating pack files we sometimes need the sorted object list
of all contents for two reasons.  The first is to get the name of
the pack, which computeName() returns today.  The other reason is
to generate a corresponding .idx file for this pack, to support
random access into the data.

Since not all uses of PackWriter require the sorted object name list
(for example streaming the pack to a network socket) the sorting is
done on demand, and cached to avoid needing to do it a second time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   24 ++++++++++++-------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index ccc6cfe..0f4cbb4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -180,6 +180,8 @@ public class PackWriter {
 
 	private final WindowCursor windowCursor = new WindowCursor();
 
+	private List<ObjectToPack> sortedByName;
+
 	private boolean reuseDeltas = DEFAULT_REUSE_DELTAS;
 
 	private boolean reuseObjects = DEFAULT_REUSE_OBJECTS;
@@ -470,22 +472,26 @@ public class PackWriter {
 	 * @return ObjectId representing SHA-1 name of a pack that was created.
 	 */
 	public ObjectId computeName() {
-		final ArrayList<ObjectToPack> sorted = new ArrayList<ObjectToPack>(
-				objectsMap.size());
-		for (List<ObjectToPack> list : objectsLists) {
-			for (ObjectToPack otp : list)
-				sorted.add(otp);
-		}
-
 		final MessageDigest md = Constants.newMessageDigest();
-		Collections.sort(sorted);
-		for (ObjectToPack otp : sorted) {
+		for (ObjectToPack otp : sortByName()) {
 			otp.copyRawTo(buf, 0);
 			md.update(buf, 0, Constants.OBJECT_ID_LENGTH);
 		}
 		return ObjectId.fromRaw(md.digest());
 	}
 
+	private List<ObjectToPack> sortByName() {
+		if (sortedByName == null) {
+			sortedByName = new ArrayList<ObjectToPack>(objectsMap.size());
+			for (List<ObjectToPack> list : objectsLists) {
+				for (ObjectToPack otp : list)
+					sortedByName.add(otp);
+			}
+			Collections.sort(sortedByName);
+		}
+		return sortedByName;
+	}
+
 	private void writePackInternal() throws IOException {
 		if (reuseDeltas || reuseObjects)
 			searchForReuse();
-- 
1.5.6.74.g8a5e
