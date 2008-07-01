From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/8] Refuse to create or delete funny ref names over dumb transports
Date: Mon, 30 Jun 2008 23:04:00 -0400
Message-ID: <1214881445-3931-4-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
 <1214881445-3931-2-git-send-email-spearce@spearce.org>
 <1214881445-3931-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWKB-0003pl-Tk
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbYGADNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYGADNe
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:13:34 -0400
Received: from george.spearce.org ([209.20.77.23]:58267 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbYGADMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9C5FB381FF; Tue,  1 Jul 2008 03:04:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 398FB38193;
	Tue,  1 Jul 2008 03:04:29 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87001>

If the RemoteRefUpdate requests us to create a remote name of just
"master" (say due to a bug in the push command line tool) we would do
just that, creating "$project.git/master" on the remote side.  This is
not a valid ref for Git and confusion ensues when C Git tries to
operate on the same repository.

Normally these sorts of bad refs are blocked by git-receive-pack
on the remote side, but here we don't have that so we must do the
blocking as part of the push connection.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/WalkPushConnection.java |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index 5450b84..e11b85a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -129,6 +129,13 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 		//
 		final List<RemoteRefUpdate> updates = new ArrayList<RemoteRefUpdate>();
 		for (final RemoteRefUpdate u : refUpdates.values()) {
+			final String n = u.getRemoteName();
+			if (!n.startsWith("refs/") || !Repository.isValidRefName(n)) {
+				u.setStatus(Status.REJECTED_OTHER_REASON);
+				u.setMessage("funny refname");
+				continue;
+			}
+
 			if (AnyObjectId.equals(ObjectId.zeroId(), u.getNewObjectId()))
 				deleteCommand(u);
 			else
-- 
1.5.6.74.g8a5e
