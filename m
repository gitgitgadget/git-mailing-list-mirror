From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 22/23] Don't cut off existing delta chains if we are reusing deltas
Date: Wed, 24 Dec 2008 18:11:18 -0800
Message-ID: <1230171079-17156-23-git-send-email-spearce@spearce.org>
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
 <1230171079-17156-22-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjQ-00029A-Gz
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbYLYCMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbYLYCL7
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:59 -0500
Received: from george.spearce.org ([209.20.77.23]:59416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYLYCLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:32 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D856A38200; Thu, 25 Dec 2008 02:11:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E1C4A38239;
	Thu, 25 Dec 2008 02:11:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-22-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103881>

The existing pack file may have chains longer than our current max
depth, such as if it is a historical pack and was generated with a
maximum chain depth >100.  Cutting off the chains would create a
bigger pack file that we need to transmit, and it costs a lot more
CPU time to expand the delta object in order to recompress it whole,
because we couldn't copy it directly from the pack file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 69b4294..4c01b6e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -681,12 +681,6 @@ private void writeObject(final ObjectToPack otp) throws IOException {
 					writeObject(deltaBase);
 				}
 			}
-
-			otp.updateDeltaDepth();
-			if (otp.getDeltaDepth() > maxDeltaDepth) {
-				otp.clearDeltaBase();
-				otp.disposeLoader();
-			}
 		}
 
 		assert !otp.isWritten();
-- 
1.6.1.rc4.301.g5497a
