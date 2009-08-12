From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Use SoftReference in WindowCache to keep Repository around
Date: Wed, 12 Aug 2009 10:03:04 -0700
Message-ID: <1250096584-27641-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:03:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbHEN-00007I-2M
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 19:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbZHLRDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 13:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbZHLRDF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 13:03:05 -0400
Received: from george.spearce.org ([209.20.77.23]:38114 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbZHLRDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 13:03:05 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D855D381FE; Wed, 12 Aug 2009 17:03:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4D72B3816F;
	Wed, 12 Aug 2009 17:03:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.225.gb589e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125716>

This is meant to be a memory sensitive cache that holds the
Repository object around if there is JVM memory available to
store it, and any packs it might have loaded.

Unfortunately I wrote the cache with a WeakReference, which
is cleared as soon as there are no more strong references to
the Repository.  This isn't very suitable for use in a server
application or a GUI which is depending upon this cache to hold
frequently accessed Repositories for near-term reuse.

Switching these to SoftReference, which is what we also use in the
WindowCache, permits the JVM to retain these Repository objects until
the JVM is low on memory and the Repository is not strongly held.
This new behavior is more consistent with the name and intent of
the class.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RepositoryCache.java  |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
index 386f798..3aaffee 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
@@ -40,7 +40,7 @@
 import java.io.File;
 import java.io.IOException;
 import java.lang.ref.Reference;
-import java.lang.ref.WeakReference;
+import java.lang.ref.SoftReference;
 import java.util.Iterator;
 import java.util.Map;
 import java.util.concurrent.ConcurrentHashMap;
@@ -156,7 +156,7 @@ private Repository openRepository(final Key location,
 				db = ref != null ? ref.get() : null;
 				if (db == null) {
 					db = location.open(mustExist);
-					ref = new WeakReference<Repository>(db);
+					ref = new SoftReference<Repository>(db);
 					cacheMap.put(location, ref);
 				}
 			}
@@ -167,7 +167,7 @@ private Repository openRepository(final Key location,
 
 	private void registerRepository(final Key location, final Repository db) {
 		db.incrementOpen();
-		WeakReference<Repository> newRef = new WeakReference<Repository>(db);
+		SoftReference<Repository> newRef = new SoftReference<Repository>(db);
 		Reference<Repository> oldRef = cacheMap.put(location, newRef);
 		Repository oldDb = oldRef != null ? oldRef.get() : null;
 		if (oldDb != null)
-- 
1.6.4.225.gb589e
