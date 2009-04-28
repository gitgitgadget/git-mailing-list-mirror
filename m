From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/13] Better handle concurrent reads during a WindowCache reconfiguration
Date: Tue, 28 Apr 2009 14:12:19 -0700
Message-ID: <1240953146-12878-7-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
 <1240953146-12878-3-git-send-email-spearce@spearce.org>
 <1240953146-12878-4-git-send-email-spearce@spearce.org>
 <1240953146-12878-5-git-send-email-spearce@spearce.org>
 <1240953146-12878-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyube-0004xr-8w
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323AbZD1VMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757084AbZD1VMk
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:40 -0400
Received: from george.spearce.org ([209.20.77.23]:58325 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbZD1VMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5EA2A38239; Tue, 28 Apr 2009 21:12:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B3D5838267;
	Tue, 28 Apr 2009 21:12:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the WindowCache is reconfigured during a read we may wind up with
the newly read window referenced by the old cache.  This could cause
skew on the PackFile's reference counts, potentially never allowing
the pack's reference count to drop to 0, and pegging the file open.

One way to deal with this is to use a multi-reader/single-writer lock
around the cache variable, and only permit reconfiguration when there
are no concurrent accesses to the cache.  This is also quite costly
for an operation that occurs very infrequently, if ever.

Another approach is a double checked idiom.  If the cache was replaced
while we were accessing the window, there is a good chance that we put
the window back into the old cache.  If that occurs, calling removeAll
again on the old cache will ensure the window isn't referenced anymore
by that old cache.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index aaad033..91c7cf3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -123,7 +123,16 @@ public static void reconfigure(final WindowCacheConfig cfg) {
 	static final ByteWindow get(final PackFile pack, final long offset)
 			throws IOException {
 		final WindowCache c = cache;
-		return c.getOrLoad(pack, c.toStart(offset));
+		final ByteWindow r = c.getOrLoad(pack, c.toStart(offset));
+		if (c != cache) {
+			// The cache was reconfigured while we were using the old one
+			// to load this window. The window is still valid, but our
+			// cache may think its still live. Ensure the window is removed
+			// from the old cache so resources can be released.
+			//
+			c.removeAll();
+		}
+		return r;
 	}
 
 	static final void purge(final PackFile pack) {
-- 
1.6.3.rc1.205.g37f8
