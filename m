From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/21] Allow PackWriter to create a corresponding index file
Date: Sun, 29 Jun 2008 03:59:17 -0400
Message-ID: <1214726371-93520-8-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrk-0000I1-Bd
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbYF2IAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbYF2IAm
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36750 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbYF2IAB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpE-0004Mk-Py; Sun, 29 Jun 2008 03:59:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 3D50A20FBAE; Sun, 29 Jun 2008 03:59:57 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 69AF320FBCF;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-7-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86778>

If we are packing for local use, or are sending the pack file to
a dumb server we must also genrate the matching .idx file so Git
can use random access requests to read object data.  Since all
of the necessary information is available in our ObjectToPack we
can just pass off the sorted list to PackIndexWriter.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   38 ++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 6adb629..e346668 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -192,6 +192,8 @@ public class PackWriter {
 
 	private int maxDeltaDepth = DEFAULT_MAX_DELTA_DEPTH;
 
+	private int outputVersion;
+
 	private boolean thin;
 
 	/**
@@ -348,6 +350,18 @@ public class PackWriter {
 	}
 
 	/**
+	 * Set the pack index file format version this instance will create.
+	 * 
+	 * @param version
+	 *            the version to write. The special version 0 designates the
+	 *            oldest (most compatible) format available for the objects.
+	 * @see PackIndexWriter
+	 */
+	public void setIndexVersion(final int version) {
+		outputVersion = version;
+	}
+
+	/**
 	 * Returns objects number in a pack file that was created by this writer.
 	 *
 	 * @return number of objects in pack.
@@ -482,6 +496,30 @@ public class PackWriter {
 		return ObjectId.fromRaw(md.digest());
 	}
 
+	/**
+	 * Create an index file to match the pack file just written.
+	 * <p>
+	 * This method can only be invoked after {@link #writePack(Iterator)} or
+	 * {@link #writePack(Collection, Collection, boolean, boolean)} has been
+	 * invoked and completed successfully. Writing a corresponding index is an
+	 * optional feature that not all pack users may require.
+	 * 
+	 * @param indexStream
+	 *            output for the index data. Caller is responsible for closing
+	 *            this stream.
+	 * @throws IOException
+	 *             the index data could not be written to the supplied stream.
+	 */
+	public void writeIndex(final OutputStream indexStream) throws IOException {
+		final List<ObjectToPack> list = sortByName();
+		final PackIndexWriter iw;
+		if (outputVersion <= 0)
+			iw = PackIndexWriter.createOldestPossible(indexStream, list);
+		else
+			iw = PackIndexWriter.createVersion(indexStream, outputVersion);
+		iw.write(list, packcsum);
+	}
+
 	private List<ObjectToPack> sortByName() {
 		if (sortedByName == null) {
 			sortedByName = new ArrayList<ObjectToPack>(objectsMap.size());
-- 
1.5.6.74.g8a5e
