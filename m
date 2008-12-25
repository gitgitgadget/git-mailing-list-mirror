From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 19/23] Allow more direct access to determine isWritten
Date: Wed, 24 Dec 2008 18:11:15 -0800
Message-ID: <1230171079-17156-20-git-send-email-spearce@spearce.org>
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
 <1230171079-17156-18-git-send-email-spearce@spearce.org>
 <1230171079-17156-19-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjU-00029A-KO
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYLYCMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbYLYCMS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:12:18 -0500
Received: from george.spearce.org ([209.20.77.23]:59420 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYLYCLb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:31 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E6A9238215; Thu, 25 Dec 2008 02:11:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D67683821F;
	Thu, 25 Dec 2008 02:11:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-19-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103887>

This gives the JVM a better chance to inline the isWritten method
when writing a pack file out.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    2 +-
 .../spearce/jgit/transport/PackedObjectInfo.java   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index bb889e8..50d06c2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -932,7 +932,7 @@ boolean isDeltaRepresentation() {
 		 * @return true if object is already written; false otherwise.
 		 */
 		boolean isWritten() {
-			return getOffset() != 0;
+			return offset != 0;
 		}
 
 		PackedObjectLoader getReuseLoader() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
index f37f421..045b795 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
@@ -49,7 +49,7 @@
  * objects from the pack. This extension of ObjectId includes the offset.
  */
 public class PackedObjectInfo extends ObjectId {
-	private long offset;
+	protected long offset;
 
 	private int crc;
 
-- 
1.6.1.rc4.301.g5497a
