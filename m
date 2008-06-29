From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/21] Save the pack checksum after computing it in PackWriter
Date: Sun, 29 Jun 2008 03:59:15 -0400
Message-ID: <1214726371-93520-6-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrj-0000I1-3G
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYF2IAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYF2IAh
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36741 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYF2H7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:59:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrp8-0004MP-HI; Sun, 29 Jun 2008 03:59:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 0D02C20FBAE; Sun, 29 Jun 2008 03:59:51 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 640D120FBCD;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-5-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86773>

In order to create a matching .idx file for the pack we have
written out we must retain the last 20 bytes of the pack file
so we can include it at the trailing end of the index file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 0f4cbb4..6adb629 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -182,6 +182,8 @@ public class PackWriter {
 
 	private List<ObjectToPack> sortedByName;
 
+	private byte packcsum[];
+
 	private boolean reuseDeltas = DEFAULT_REUSE_DELTAS;
 
 	private boolean reuseObjects = DEFAULT_REUSE_OBJECTS;
@@ -690,8 +692,8 @@ public class PackWriter {
 
 	private void writeChecksum() throws IOException {
 		out.on(false);
-		final byte checksum[] = out.getMessageDigest().digest();
-		out.write(checksum);
+		packcsum = out.getMessageDigest().digest();
+		out.write(packcsum);
 	}
 
 	private ObjectWalk setUpWalker(
-- 
1.5.6.74.g8a5e
