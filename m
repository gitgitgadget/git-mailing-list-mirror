From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/13] Cleanup stupid release of the cached Inflater in IndexPack
Date: Mon, 22 Dec 2008 16:27:12 -0800
Message-ID: <1229992043-1053-3-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv8h-0005Qg-Ld
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYLWA1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYLWA13
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:29 -0500
Received: from george.spearce.org ([209.20.77.23]:54467 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbYLWA10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:26 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 489E43821F; Tue, 23 Dec 2008 00:27:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BFB2538197;
	Tue, 23 Dec 2008 00:27:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103783>

The try/finally idiom avoids placing the Inflater on the stack,
which means it goes unreachable slightly faster.  Its also much
less obtuse to read.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 2752bb0..3e2187c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -320,9 +320,11 @@ public void index(final ProgressMonitor progress) throws IOException {
 					writeIdx();
 
 			} finally {
-				final Inflater inf = inflater;
-				inflater = null;
-				InflaterCache.release(inf);
+				try {
+					InflaterCache.release(inflater);
+				} finally {
+					inflater = null;
+				}
 
 				progress.endTask();
 				if (packOut != null)
-- 
1.6.1.rc4.301.g5497a
