From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 02/26] Protect WorkingTreeIterator's name encoding from weird ByteBuffers
Date: Mon, 11 Aug 2008 18:07:49 -0700
Message-ID: <1218503293-14057-3-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:09:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiO2-0005x2-QO
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbYHLBIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbYHLBIR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:17 -0400
Received: from george.spearce.org ([209.20.77.23]:38563 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYHLBIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E5A543837C; Tue, 12 Aug 2008 01:08:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0017C38376;
	Tue, 12 Aug 2008 01:08:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92032>

If a ByteBuffer decides to be cute and give us an array but use
an array offset that isn't zero we cannot use its array as our
own encodedName array.  Instead we must create a copy of the array
so we can safely assume where the path starts.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index 4ac711b..356222b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -415,7 +415,7 @@ public abstract class WorkingTreeIterator extends AbstractTreeIterator {
 				throws CharacterCodingException {
 			final ByteBuffer b = enc.encode(CharBuffer.wrap(getName()));
 			encodedNameLen = b.limit();
-			if (b.hasArray())
+			if (b.hasArray() && b.arrayOffset() == 0)
 				encodedName = b.array();
 			else
 				b.get(encodedName = new byte[encodedNameLen]);
-- 
1.6.0.rc2.22.g71b99
