From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix WindowCacheGetTest.testCache_TooSmallLimit
	failures
Date: Sat, 25 Jul 2009 13:00:56 -0700
Message-ID: <20090725200056.GD11191@spearce.org>
References: <85647ef50907220623i2b7e50dal67650a638921ec0f@mail.gmail.com> <20090724225118.GZ11191@spearce.org> <200907251934.37145.robin.rosenberg.lists@dewire.com> <20090725194254.GC11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 22:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUnQd-0008MD-1c
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 22:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbZGYUA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 16:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZGYUA5
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 16:00:57 -0400
Received: from george.spearce.org ([209.20.77.23]:49196 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbZGYUA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 16:00:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B015C381FD; Sat, 25 Jul 2009 20:00:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090725194254.GC11191@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124063>

Ever since 2d77d30b5f when I rewrote WindowCache we have been seeing
random failures inside of the TooSmallLimit test case.

These test failures have been occurring because the cache contained
more open bytes than it was configured to permit.

The cache was permitted to open more bytes than its configured limit
because the eviction routine was always skipping the last bucket
under some conditions.  If the cache table was sized the same as its
evictBatch, which happens for any fairly small table, the eviction
routine broke too early if it started at a non-zero position in the
table and wrapped around during its search.  By breaking too early
the routine did not actually perform an eviction, leaving windows
open it should have closed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  > Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
  > > > Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
  > > > > The test WindowCacheGetTest.testCache_TooSmallLimit sometimes fails
  > > > > (on less than third of runs on Windows) with the following stacktrace:
  > > 
  > > Could it be threading-related (cache). I've never seen it on the machine where I build for
  > > the update site and it is a single core machine, but I "this" machine that has two cores it happens, not
  > > as offen as 1/6, but enough to annoy me a bit, perhaps 1/20. If it is related to bad synchronization
  > > it should happen more often the more cores you have.
  
  I think this fixes it.

 .../src/org/spearce/jgit/lib/OffsetCache.java      |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
index b81c7e0..7ac532d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
@@ -253,12 +253,11 @@ private void hit(final Ref<V> r) {
 	}
 
 	private void evict() {
-		final int start = rng.nextInt(tableSize);
-		int ptr = start;
 		while (isFull()) {
+			int ptr = rng.nextInt(tableSize);
 			Entry<V> old = null;
 			int slot = 0;
-			for (int b = evictBatch - 1; b >= 0; b--) {
+			for (int b = evictBatch - 1; b >= 0; b--, ptr++) {
 				if (tableSize <= ptr)
 					ptr = 0;
 				for (Entry<V> e = table.get(ptr); e != null; e = e.next) {
@@ -269,8 +268,6 @@ private void evict() {
 						slot = ptr;
 					}
 				}
-				if (++ptr == start)
-					return;
 			}
 			if (old != null) {
 				old.kill();
-- 
1.6.4.rc2.216.g769fa
