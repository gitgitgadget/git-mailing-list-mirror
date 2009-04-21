From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/10] Safely handle closing an already closed WindowedFile
Date: Mon, 20 Apr 2009 18:21:03 -0700
Message-ID: <1240276872-17893-2-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hR-00021g-20
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607AbZDUBVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757595AbZDUBVS
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:18 -0400
Received: from george.spearce.org ([209.20.77.23]:33013 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbZDUBVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E997B38260; Tue, 21 Apr 2009 01:21:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A55ED38211;
	Tue, 21 Apr 2009 01:21:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117061>

If cacheOpen throws an exception (e.g. FileNotFoundException) we
may wind up in cacheClose, where the fd is null because we didn't
successfully construct the RandomAccessFile.  In such cases there
is nothing to attempt to close.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 938f44c..9293eb9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -297,14 +297,16 @@ void cacheOpen() throws IOException {
 	}
 
 	void cacheClose() {
-		try {
-			fd.close();
-		} catch (IOException err) {
-			// Ignore a close event. We had it open only for reading.
-			// There should not be errors related to network buffers
-			// not flushed, etc.
+		if (fd != null) {
+			try {
+				fd.close();
+			} catch (IOException err) {
+				// Ignore a close event. We had it open only for reading.
+				// There should not be errors related to network buffers
+				// not flushed, etc.
+			}
+			fd = null;
 		}
-		fd = null;
 	}
 
 	void allocWindow(final WindowCursor curs, final int windowId,
-- 
1.6.3.rc1.188.ga02b
