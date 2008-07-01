From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 8/8] Don't try to pack 0{40} during push of delete and update
Date: Mon, 30 Jun 2008 23:04:05 -0400
Message-ID: <1214881445-3931-9-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
 <1214881445-3931-2-git-send-email-spearce@spearce.org>
 <1214881445-3931-3-git-send-email-spearce@spearce.org>
 <1214881445-3931-4-git-send-email-spearce@spearce.org>
 <1214881445-3931-5-git-send-email-spearce@spearce.org>
 <1214881445-3931-6-git-send-email-spearce@spearce.org>
 <1214881445-3931-7-git-send-email-spearce@spearce.org>
 <1214881445-3931-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWKA-0003pl-0u
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbYGADNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbYGADMx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:12:53 -0400
Received: from george.spearce.org ([209.20.77.23]:58262 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbYGADMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5CD3A38194; Tue,  1 Jul 2008 03:04:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F291338153;
	Tue,  1 Jul 2008 03:04:30 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86996>

`jgit push origin :refs/heads/die refs/heads/master` tries to pack
0{40} to delete branch "die" while also packing the objects needed
to update branch master.  Since "die" is being removed we do not
want to pack any objects for it, as there is nothing to pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BasePackPushConnection.java     |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 7ae3aa7..784a578 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -169,8 +169,10 @@ class BasePackPushConnection extends BasePackConnection implements
 
 		for (final Ref r : getRefs())
 			remoteObjects.add(r.getObjectId());
-		for (final RemoteRefUpdate r : refUpdates.values())
-			newObjects.add(r.getNewObjectId());
+		for (final RemoteRefUpdate r : refUpdates.values()) {
+			if (!ObjectId.zeroId().equals(r.getNewObjectId()))
+				newObjects.add(r.getNewObjectId());
+		}
 
 		writer.preparePack(newObjects, remoteObjects, thinPack, true);
 		writer.writePack(out);
-- 
1.5.6.74.g8a5e
