From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/11] Use getCachedBytes in IndexPack to avoid an unnecessary copy
Date: Wed, 29 Apr 2009 11:54:43 -0700
Message-ID: <1241031288-23437-7-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
 <1241031288-23437-2-git-send-email-spearce@spearce.org>
 <1241031288-23437-3-git-send-email-spearce@spearce.org>
 <1241031288-23437-4-git-send-email-spearce@spearce.org>
 <1241031288-23437-5-git-send-email-spearce@spearce.org>
 <1241031288-23437-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwt-0003Rz-55
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670AbZD2SzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757185AbZD2Sy7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:54:59 -0400
Received: from george.spearce.org ([209.20.77.23]:32888 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619AbZD2Syx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:53 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6B8F73807B; Wed, 29 Apr 2009 18:54:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3A1363806D;
	Wed, 29 Apr 2009 18:54:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117919>

This is deep within the library code, where we know we won't overwrite
the cached buffer for an object.  Using getCachedBytes saves a full
array copy while fixing a thin pack and appending whole objects.  The
extra copy isn't so much an issue of CPU time as it is about creating
unnecessary temporary garbage for the GC to clean up.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Unchanged.

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
1.6.3.rc3.199.g24398
