From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/8] Delete reflog when deleting ref during dumb transport push
Date: Mon, 30 Jun 2008 23:03:59 -0400
Message-ID: <1214881445-3931-3-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
 <1214881445-3931-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWKA-0003pl-LH
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbYGADNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYGADMy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:12:54 -0400
Received: from george.spearce.org ([209.20.77.23]:58264 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbYGADMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 46C57381FE; Tue,  1 Jul 2008 03:04:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CA07838153;
	Tue,  1 Jul 2008 03:04:28 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86998>

If we remove a ref we must also remove the reflog.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/WalkPushConnection.java |    7 +++++++
 .../jgit/transport/WalkRemoteObjectDatabase.java   |   13 +++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index f63bedd..5450b84 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -280,6 +280,13 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 				u.setMessage(e.getMessage());
 			}
 		}
+
+		try {
+			dest.deleteRefLog(u.getRemoteName());
+		} catch (IOException e) {
+			u.setStatus(Status.REJECTED_OTHER_REASON);
+			u.setMessage(e.getMessage());
+		}
 	}
 
 	private void updateCommand(final RemoteRefUpdate u) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index 1e13b33..b99144a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -269,6 +269,19 @@ abstract class WalkRemoteObjectDatabase {
 	}
 
 	/**
+	 * Delete a reflog from the remote repository.
+	 * 
+	 * @param name
+	 *            name of the ref within the ref space, for example
+	 *            <code>refs/heads/pu</code>.
+	 * @throws IOException
+	 *             deletion is not supported, or deletion failed.
+	 */
+	void deleteRefLog(final String name) throws IOException {
+		deleteFile("../logs/" + name);
+	}
+
+	/**
 	 * Overwrite (or create) a loose ref in the remote repository.
 	 * <p>
 	 * This method creates any missing parent directories, if necessary.
-- 
1.5.6.74.g8a5e
