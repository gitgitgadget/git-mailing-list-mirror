From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/13] Fix invalid "double checked locking" in InflaterCache
Date: Mon, 22 Dec 2008 16:27:11 -0800
Message-ID: <1229992043-1053-2-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9t-0005lu-0d
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbYLWA13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbYLWA11
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:27 -0500
Received: from george.spearce.org ([209.20.77.23]:54464 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbYLWA1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:25 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id EE37138200; Tue, 23 Dec 2008 00:27:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 29F1638200;
	Tue, 23 Dec 2008 00:27:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103785>

We move the Inflater allocation out of the synchronized block as
it requires JNI code to build the libz structure.  This permits
other threads to get into the Inflater allocation faster.

We also fix the release implementation to validate the array size
only after we enter the lock, rather than before.  This prevents
us from releasing an inflater due to a stale copy of the open
count being in our processor cache.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/InflaterCache.java    |   31 ++++++++++---------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InflaterCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InflaterCache.java
index f0f9139..578911c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/InflaterCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InflaterCache.java
@@ -59,13 +59,18 @@
 	 * 
 	 * @return an available inflater. Never null.
 	 */
-	public synchronized static Inflater get() {
+	public static Inflater get() {
+		final Inflater r = getImpl();
+		return r != null ? r : new Inflater(false);
+	}
+
+	private synchronized static Inflater getImpl() {
 		if (openInflaterCount > 0) {
 			final Inflater r = inflaterCache[--openInflaterCount];
 			inflaterCache[openInflaterCount] = null;
 			return r;
 		}
-		return new Inflater(false);
+		return null;
 	}
 
 	/**
@@ -76,23 +81,19 @@ public synchronized static Inflater get() {
 	 *            does nothing.
 	 */
 	public static void release(final Inflater i) {
-		if (i == null)
-			return;
-
-		if (openInflaterCount == SZ) {
-			i.end();
-			return;
+		if (i != null) {
+			i.reset();
+			if (releaseImpl(i))
+				i.end();
 		}
-
-		i.reset();
-		releaseImpl(i);
 	}
 
-	private static synchronized void releaseImpl(final Inflater i) {
-		if (openInflaterCount == SZ)
-			i.end();
-		else
+	private static synchronized boolean releaseImpl(final Inflater i) {
+		if (openInflaterCount < SZ) {
 			inflaterCache[openInflaterCount++] = i;
+			return false;
+		}
+		return true;
 	}
 
 	private InflaterCache() {
-- 
1.6.1.rc4.301.g5497a
