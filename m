From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 17/23] Only do one getCachedBytes per whole object written
Date: Wed, 24 Dec 2008 18:11:13 -0800
Message-ID: <1230171079-17156-18-git-send-email-spearce@spearce.org>
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
 <1230171079-17156-14-git-send-email-spearce@spearce.org>
 <1230171079-17156-15-git-send-email-spearce@spearce.org>
 <1230171079-17156-16-git-send-email-spearce@spearce.org>
 <1230171079-17156-17-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjO-00029A-FE
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbYLYCL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYLYCLx
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:53 -0500
Received: from george.spearce.org ([209.20.77.23]:59443 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbYLYCLb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:31 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5066638211; Thu, 25 Dec 2008 02:11:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 243B53826E;
	Thu, 25 Dec 2008 02:11:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-17-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103880>

Getting the size of an object may cause getCachedBytes to be invoked,
and then have its result discarded.  To save time we should make the
call to getCachedBytes first, hold onto the byte[], then obtain the
size off the byte[], and finally write from the byte[].

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index a0823c7..bb889e8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -710,10 +710,11 @@ private void writeWholeObject(final ObjectToPack otp) throws IOException {
 			otp.disposeLoader();
 		} else {
 			final ObjectLoader loader = db.openObject(windowCursor, otp);
+			final byte[] data = loader.getCachedBytes();
 			final DeflaterOutputStream deflaterOut = new DeflaterOutputStream(
 					out, deflater);
-			writeObjectHeader(otp.getType(), loader.getSize());
-			deflaterOut.write(loader.getCachedBytes());
+			writeObjectHeader(otp.getType(), data.length);
+			deflaterOut.write(data);
 			deflaterOut.finish();
 			deflater.reset();
 		}
-- 
1.6.1.rc4.301.g5497a
