From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 13/23] Dispose of RevCommit buffers when they aren't used in PackWriter
Date: Wed, 24 Dec 2008 18:11:09 -0800
Message-ID: <1230171079-17156-14-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjS-00029A-Ib
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYLYCML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYLYCMI
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:12:08 -0500
Received: from george.spearce.org ([209.20.77.23]:59416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbYLYCL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 681C838262; Thu, 25 Dec 2008 02:11:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 01BAB38267;
	Thu, 25 Dec 2008 02:11:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-13-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103886>

We don't need the commit buffer, so we might as well throw it
away immediately to reduce the total memory usage within the
writer process.

The same goes for the buffers within UploadPack when its doing
a check to see if it has a complete base.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    2 ++
 .../src/org/spearce/jgit/transport/UploadPack.java |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 89460f2..88b2b1f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -802,10 +802,12 @@ private void findObjectsToPack(final ObjectWalk walker)
 
 		while ((o = walker.next()) != null) {
 			addObject(o);
+			o.dispose();
 			initMonitor.update(1);
 		}
 		while ((o = walker.nextObject()) != null) {
 			addObject(o);
+			o.dispose();
 			initMonitor.update(1);
 		}
 		initMonitor.endTask();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 4401951..d57df03 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -434,6 +434,7 @@ private boolean wantSatisfied(final RevCommit want) throws IOException {
 				}
 				return true;
 			}
+			c.dispose();
 		}
 		return false;
 	}
-- 
1.6.1.rc4.301.g5497a
