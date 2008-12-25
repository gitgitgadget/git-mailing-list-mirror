From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 21/23] Use an ArrayList for the reuseLoader collection in PackWriter
Date: Wed, 24 Dec 2008 18:11:17 -0800
Message-ID: <1230171079-17156-22-git-send-email-spearce@spearce.org>
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
 <1230171079-17156-20-git-send-email-spearce@spearce.org>
 <1230171079-17156-21-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:14:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjR-00029A-TD
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYLYCMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbYLYCMF
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:12:05 -0500
Received: from george.spearce.org ([209.20.77.23]:59453 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYLYCLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:32 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8F2B23821F; Thu, 25 Dec 2008 02:11:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9C7CF38200;
	Thu, 25 Dec 2008 02:11:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-21-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103889>

Nulling out the elements of the array is quicker than deallocating
LinkedList nodes and allocating new ones for the next use.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 3ef9154..69b4294 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -46,7 +46,6 @@
 import java.util.Collection;
 import java.util.Collections;
 import java.util.Iterator;
-import java.util.LinkedList;
 import java.util.List;
 import java.util.zip.Deflater;
 import java.util.zip.DeflaterOutputStream;
@@ -577,8 +576,7 @@ public void writePack(OutputStream packStream) throws IOException {
 
 	private void searchForReuse() throws IOException {
 		initMonitor.beginTask(SEARCHING_REUSE_PROGRESS, getObjectsNumber());
-		final Collection<PackedObjectLoader> reuseLoaders = new LinkedList<PackedObjectLoader>();
-
+		final Collection<PackedObjectLoader> reuseLoaders = new ArrayList<PackedObjectLoader>();
 		for (List<ObjectToPack> list : objectsLists) {
 			for (ObjectToPack otp : list) {
 				if (initMonitor.isCancelled())
-- 
1.6.1.rc4.301.g5497a
