From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 23/23] Correctly honor the thin parameter to PackWriter.writePack
Date: Wed, 24 Dec 2008 18:11:19 -0800
Message-ID: <1230171079-17156-24-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
 <1230171079-17156-7-git-send-email-spearce@spearce.org>
 <1230171079-17156-8-git-send-email-spearce@spearce.org>
 <1230171079-17156-9-git-send-email-spearce@spearce.org>
 <1230171079-17156-10-git-send-email-spearce@spearce.org>
 <1230171079-17156-11-git-send-email-spearce@spearce.org>
 <1230171079-17156-12-git-send-email-spearce@spearce.org>
 <1230171079-17156-13-git-send-email-spearce@spearce.org>
 <1230171079-17156-14-git-send-email-spearce@spearce.org>
 <1230171079-17156-15-git-send-email-spearce@spearce.org>
 <1230171079-17156-16-git-send-email-spearce@spearce.org>
 <1230171079-17156-17-git-send-email-spearce@spearce.org>
 <1230171079-17156-18-git-send-email-spearce@spearce.org>
 <1230171079-17156-19-git-send-email-spearce@spearce.org>
 <1230171079-17156-20-git-send-email-spearce@spearce.org>
 <1230171079-17156-21-git-send-email-spearce@spearce.org>
 <1230171079-17156-22-git-send-email-spearce@spearce.org>
 <1230171079-17156-23-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjR-00029A-7Z
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbYLYCMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbYLYCMC
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:12:02 -0500
Received: from george.spearce.org ([209.20.77.23]:59443 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbYLYCLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:32 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2D41738211; Thu, 25 Dec 2008 02:11:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3E0BF38265;
	Thu, 25 Dec 2008 02:11:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-23-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103877>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 4c01b6e..b2d0227 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -465,8 +465,9 @@ public void preparePack(
 			final Collection<? extends ObjectId> uninterestingObjects,
 			final boolean thin, final boolean ignoreMissingUninteresting)
 			throws IOException {
+		this.thin = thin;
 		ObjectWalk walker = setUpWalker(interestingObjects,
-				uninterestingObjects, thin, ignoreMissingUninteresting);
+				uninterestingObjects, ignoreMissingUninteresting);
 		findObjectsToPack(walker);
 	}
 
@@ -759,7 +760,7 @@ private void writeChecksum() throws IOException {
 	private ObjectWalk setUpWalker(
 			final Collection<? extends ObjectId> interestingObjects,
 			final Collection<? extends ObjectId> uninterestingObjects,
-			final boolean thin, final boolean ignoreMissingUninteresting)
+			final boolean ignoreMissingUninteresting)
 			throws MissingObjectException, IOException,
 			IncorrectObjectTypeException {
 		final ObjectWalk walker = new ObjectWalk(db);
-- 
1.6.1.rc4.301.g5497a
