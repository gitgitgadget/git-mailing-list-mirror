From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/13] Use getCachedBytes in IndexPack to avoid an unnecessary copy
Date: Tue, 28 Apr 2009 14:12:25 -0700
Message-ID: <1240953146-12878-13-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
 <1240953146-12878-3-git-send-email-spearce@spearce.org>
 <1240953146-12878-4-git-send-email-spearce@spearce.org>
 <1240953146-12878-5-git-send-email-spearce@spearce.org>
 <1240953146-12878-6-git-send-email-spearce@spearce.org>
 <1240953146-12878-7-git-send-email-spearce@spearce.org>
 <1240953146-12878-8-git-send-email-spearce@spearce.org>
 <1240953146-12878-9-git-send-email-spearce@spearce.org>
 <1240953146-12878-10-git-send-email-spearce@spearce.org>
 <1240953146-12878-11-git-send-email-spearce@spearce.org>
 <1240953146-12878-12-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyueN-0006Nh-QC
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbZD1VMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757084AbZD1VMo
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:44 -0400
Received: from george.spearce.org ([209.20.77.23]:58331 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbZD1VMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:37 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5E5C938239; Tue, 28 Apr 2009 21:12:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C516438262;
	Tue, 28 Apr 2009 21:12:30 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117813>

This is deep within the library code, where we know we won't overwrite
the cached buffer for an object.  Using getCachedBytes saves a full
array copy while fixing a thin pack and appending whole objects.  The
extra copy isn't so much an issue of CPU time as it is about creating
unnecessary temporary garbage for the GC to clean up.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index eecad9c..eeeae16 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -500,7 +500,7 @@ private void fixThinPack(final ProgressMonitor progress) throws IOException {
 				missing.add(baseId);
 				continue;
 			}
-			final byte[] data = ldr.getBytes();
+			final byte[] data = ldr.getCachedBytes();
 			final int typeCode = ldr.getType();
 			final PackedObjectInfo oe;
 
-- 
1.6.3.rc1.205.g37f8
