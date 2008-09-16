From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix push to empty repository
Date: Mon, 15 Sep 2008 22:38:04 -0700
Message-ID: <1221543484-51295-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 07:39:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfTHf-0001B0-7w
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 07:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYIPFiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 01:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbYIPFiI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 01:38:08 -0400
Received: from george.spearce.org ([209.20.77.23]:34012 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbYIPFiI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 01:38:08 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 03EFD38360; Tue, 16 Sep 2008 05:38:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0100C3835A;
	Tue, 16 Sep 2008 05:38:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.337.g5c7d67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95973>

If the remote repository has no commits we received an exception
about "capabilities^{} coming before capabilities".  This happens
because we didn't correctly ignore the dummy capability ref line.

http://code.google.com/p/egit/issues/detail?id=34

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 184a5fd..2d145a6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -147,18 +147,18 @@ for (String c : line.substring(nul + 1).split(" "))
 						remoteCapablities.add(c);
 					line = line.substring(0, nul);
 				}
-
-				if (line.equals("capabilities^{}")) {
-					// special line from git-receive-pack to show
-					// capabilities when there are no refs to advertise
-					continue;
-				}
 			}
 
 			if (line.length() == 0)
 				break;
 
 			String name = line.substring(41, line.length());
+			if (avail.isEmpty() && name.equals("capabilities^{}")) {
+				// special line from git-receive-pack to show
+				// capabilities when there are no refs to advertise
+				continue;
+			}
+
 			final ObjectId id = ObjectId.fromString(line.substring(0, 40));
 			if (name.endsWith("^{}")) {
 				name = name.substring(0, name.length() - 3);
-- 
1.6.0.1.337.g5c7d67
