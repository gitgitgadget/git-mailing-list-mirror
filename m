From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/13] Make PackFile thread-safe
Date: Mon, 22 Dec 2008 16:27:15 -0800
Message-ID: <1229992043-1053-6-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9v-0005lu-1i
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbYLWA1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYLWA1f
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:35 -0500
Received: from george.spearce.org ([209.20.77.23]:54476 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYLWA12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E5E9438262; Tue, 23 Dec 2008 00:27:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 00A9D38215;
	Tue, 23 Dec 2008 00:27:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103794>

We really should try to avoid allocating the reverse index within
the pack object itself, and instead make the applications that do
use this data manage it themselves.  This way the index could be
released in memory when its no longer used, and the locking could
be bypassed entirely.

Since most of PackFile is dependent upon the WindowedFile we can
mostly ignore synchronization in this class.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 6cd85b1..ca5681b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -341,7 +341,7 @@ private long findEndOffset(final long startOffset)
 		return getReverseIdx().findNextOffset(startOffset, maxOffset);
 	}
 
-	private PackReverseIndex getReverseIdx() {
+	private synchronized PackReverseIndex getReverseIdx() {
 		if (reverseIdx == null)
 			reverseIdx = new PackReverseIndex(idx);
 		return reverseIdx;
-- 
1.6.1.rc4.301.g5497a
