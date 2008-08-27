From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] index-pack: Use fsync to ensure received pack data is on disk
Date: Wed, 27 Aug 2008 14:48:44 -0700
Message-ID: <1219873724-13348-2-git-send-email-spearce@spearce.org>
References: <1219873724-13348-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:49:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYStp-00014B-8k
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbYH0Vst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbYH0Vst
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:48:49 -0400
Received: from george.spearce.org ([209.20.77.23]:60382 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbYH0Vsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:48:47 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9945238376; Wed, 27 Aug 2008 21:48:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8F27D38375;
	Wed, 27 Aug 2008 21:48:45 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219873724-13348-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93959>

C Git uses fsync() to ensure that a pack file is stable on disk before
it starts to delete any other copies of the data, or before it tries
to update refs to refer to data stored in the pack.  This makes it a
lot less likely that a repository will see corruption due to refs
pointing at unavailable objects.

We now force our pack and its associated .idx file to disk before
we close the file descriptors, but after we have finished reading
and writing all of the data.  This way we can be fairly certain
a future user of the data (like a RefUpdate) always has objects.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index db9268e..7b1f7ee 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -259,6 +259,8 @@ public void index(final ProgressMonitor progress) throws IOException {
 						fixThinPack(progress);
 					}
 				}
+				if (packOut != null)
+					packOut.getChannel().force(true);
 
 				packDigest = null;
 				baseById = null;
@@ -510,6 +512,7 @@ private void writeIdx() throws IOException {
 			else
 				iw = PackIndexWriter.createVersion(os, outputVersion);
 			iw.write(list, packcsum);
+			os.getChannel().force(true);
 		} finally {
 			os.close();
 		}
-- 
1.6.0.174.gd789c
