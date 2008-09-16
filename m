From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Paper bag fix RevWalk.reset after inMergeBase is used
Date: Tue, 16 Sep 2008 12:34:36 -0700
Message-ID: <1221593677-24481-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:35:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfgKx-0004uF-SV
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 21:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYIPTej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 15:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYIPTej
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 15:34:39 -0400
Received: from george.spearce.org ([209.20.77.23]:59768 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbYIPTej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 15:34:39 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6A57738368; Tue, 16 Sep 2008 19:34:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 999A03835A;
	Tue, 16 Sep 2008 19:34:37 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.389.g421e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96032>

We need to remove delayedFreeFlags from carryFlags anytime we
mark those delayedFreeFlags as actually freeFlags.  In other
words we do not want to continue carrying a flag which we have
now freed and will recycle for a different use in the future,
one which may not want to be carried automatically onto parent
commits during revision traversal.

I had the boolean expression incorrect (call it a typo).  The
correct way to remove set b from a is "a &= ~b" not "a &= b".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 079432c..5cd7f71 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -824,7 +824,7 @@ void freeFlag(final int mask) {
 	private void finishDelayedFreeFlags() {
 		if (delayFreeFlags != 0) {
 			freeFlags |= delayFreeFlags;
-			carryFlags &= delayFreeFlags;
+			carryFlags &= ~delayFreeFlags;
 			delayFreeFlags = 0;
 		}
 	}
-- 
1.6.0.2.389.g421e0
