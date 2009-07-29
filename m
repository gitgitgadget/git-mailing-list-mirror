From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Don't dispose of RevFlag used to advertise objects in ReceivePack
Date: Wed, 29 Jul 2009 08:50:23 -0700
Message-ID: <1248882627-7285-2-git-send-email-spearce@spearce.org>
References: <1248882627-7285-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBQo-0000Sa-8K
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 17:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbZG2Pue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 11:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbZG2Puc
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 11:50:32 -0400
Received: from george.spearce.org ([209.20.77.23]:45982 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbZG2Pu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 11:50:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2AE4438221; Wed, 29 Jul 2009 15:50:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A6F9E381FE;
	Wed, 29 Jul 2009 15:50:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc3.201.gd9d59
In-Reply-To: <1248882627-7285-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124360>

Back in 3ae30ae64d56113a71a07a3ff12d0af71cf538e2 I refactored how the
ReceivePack and UploadPack programs advertise the set of refs that
the server-side currently has.  As part of this change ReceivePack
allocated a new RevFlag and marked it on all objects it advertised
to the client, because the common code with UploadPack requires the
RevFlag to mark objects.  It also uses this RevFlag to avoid sending
".have" lines for objects we have already described.

Disposing of the RevFlag however is problematic for any application
that uses the ReceivePack's RevWalk instance within a PreReceiveHook
or a PostReceiveHook implementation.  By disposing of the RevFlag,
the flag bit was not actually unset from the advertised objects,
it was only marked as being eligible for reallocation in another
RevFlag.  If the flag bit was reallocated, any advertised objects
would automatically have the bit set, which can confuse the new
user of the bit.

RevWalk's isMergedInto() really got confused, as it allocates a
temporary RevFlag for each input RevCommit in order to compute the
merge base.

The simplest fix is to just never dispose of this RevFlag once
it has been allocated.  We could dispose of it and also unset it
from all objects we advertised, but that would require us to keep
track of the full advertised set, a potentially expensive thing to
do given that most callers will never need to allocate a RevFlag,
let alone care about the 1 bit leaked by the protocol.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index ca4a7ec..eb21254 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -547,7 +547,6 @@ private void sendAdvertisedRefs() throws IOException {
 		if (adv.isEmpty())
 			adv.advertiseId(ObjectId.zeroId(), "capabilities^{}");
 		pckOut.end();
-		walk.disposeFlag(advertised);
 	}
 
 	private void recvCommands() throws IOException {
-- 
1.6.4.rc3.201.gd9d59
