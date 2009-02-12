From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/9] Remove dead stats code from WindowCache
Date: Wed, 11 Feb 2009 18:36:52 -0800
Message-ID: <1234406219-19547-3-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRUP-00037t-Jt
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675AbZBLChN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757832AbZBLChL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:11 -0500
Received: from george.spearce.org ([209.20.77.23]:39174 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZBLChD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:03 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id BD6D138239; Thu, 12 Feb 2009 02:37:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6B7B93819E;
	Thu, 12 Feb 2009 02:37:00 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109568>

I used this code to try and tune the WindowCache a bit, but we're
about as good as we can do for now.  There's no point in keeping
it all around in somewhat critical paths if we never use it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |   28 --------------------
 1 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 0077f52..600ebdf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -76,14 +76,6 @@ private static final int bits(int newSize) {
 
 	private static int openByteCount;
 
-	private static int hits;
-
-	private static int reqs;
-
-	private static int opens;
-
-	private static int closes;
-
 	static {
 		maxByteCount = 10 * MB;
 		windowSizeShift = bits(8 * KB);
@@ -93,22 +85,6 @@ private static final int bits(int newSize) {
 		clearedWindowQueue = new ReferenceQueue<Object>();
 	}
 
-	static synchronized String statString() {
-		int maxChain = 0, tot = 0;
-		for (ByteWindow<?> e : cache) {
-			int n = 0;
-			for (; e != null; e = e.chainNext) {
-				n++;
-				tot++;
-			}
-			maxChain = Math.max(maxChain, n);
-		}
-		return "WindowCache[ hits: " + (hits * 100 / reqs) + "%"
-				+ "; windows: " + tot + " maxChain: " + maxChain + "; kb:"
-				+ (openByteCount / KB) + "; cache: " + cache.length + " fds: "
-				+ (opens - closes) + "," + opens + "," + closes + " ]";
-	}
-
 	private static int cacheTableSize() {
 		return 5 * (maxByteCount / windowSize) / 2;
 	}
@@ -215,7 +191,6 @@ private static synchronized void reconfigureImpl(final int packedGitLimit,
 	 */
 	public static synchronized final void get(final WindowCursor curs,
 			final WindowedFile wp, final long position) throws IOException {
-		reqs++;
 		final int id = (int) (position >> windowSizeShift);
 		final int idx = hash(wp, id);
 		for (ByteWindow<?> e = cache[idx]; e != null; e = e.chainNext) {
@@ -223,7 +198,6 @@ public static synchronized final void get(final WindowCursor curs,
 				if ((curs.handle = e.get()) != null) {
 					curs.window = e;
 					makeMostRecent(e);
-					hits++;
 					return;
 				}
 
@@ -234,7 +208,6 @@ public static synchronized final void get(final WindowCursor curs,
 
 		if (wp.openCount == 0) {
 			try {
-				opens++;
 				wp.openCount = 1;
 				wp.cacheOpen();
 			} catch (IOException ioe) {
@@ -340,7 +313,6 @@ private static void clear(final ByteWindow<?> e) {
 	private static void unlinkSize(final ByteWindow<?> e) {
 		if (e.sizeActive) {
 			if (--e.provider.openCount == 0) {
-				closes++;
 				e.provider.cacheClose();
 			}
 			openByteCount -= e.size;
-- 
1.6.2.rc0.204.gf6b427
