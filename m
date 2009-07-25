From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/4] Fix racy condition when a repository is repacked
Date: Sat, 25 Jul 2009 15:52:23 -0700
Message-ID: <1248562343-18815-5-git-send-email-spearce@spearce.org>
References: <1248562343-18815-1-git-send-email-spearce@spearce.org>
 <1248562343-18815-2-git-send-email-spearce@spearce.org>
 <1248562343-18815-3-git-send-email-spearce@spearce.org>
 <1248562343-18815-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUq6a-0002UW-9N
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 00:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbZGYWwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 18:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZGYWw3
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 18:52:29 -0400
Received: from george.spearce.org ([209.20.77.23]:58131 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbZGYWwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 18:52:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 24063381FF; Sat, 25 Jul 2009 22:52:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CA8C3381FD;
	Sat, 25 Jul 2009 22:52:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248562343-18815-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124087>

If the filesystem clock granularity is sufficiently large enough it
is possible for a repacking program such as `git repack` to change
the same directory more than once within the same modification time.

If JGit were to scan the directory between changes in the same
clock step it will never see the later edits, because the directory
modification time has not changed.

Instead we now keep track of the last time we read the directory.
If an object cannot be found on disk and the pack directory's last
modified time is less than 2 minutes since the last time we read
the directory's contents, we scan it again looking for changes.

Worst case scenario, JGit will list the pack directory once for
each requested missing object, until the directory has aged at
least 2 minutes.  Most repositories modify this directory only a
few times a week, so this is not an undue burden on the host.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |   60 +++++++++++++++++---
 1 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 0bb3c01..859824d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -66,7 +66,7 @@
  * {@link PackFile}s.
  */
 public class ObjectDirectory extends ObjectDatabase {
-	private static final PackList NO_PACKS = new PackList(-1, new PackFile[0]);
+	private static final PackList NO_PACKS = new PackList(-1, -1, new PackFile[0]);
 
 	private final File objects;
 
@@ -273,7 +273,7 @@ private void insertPack(final PackFile pf) {
 			final PackFile[] newList = new PackFile[1 + oldList.length];
 			newList[0] = pf;
 			System.arraycopy(oldList, 0, newList, 1, oldList.length);
-			n = new PackList(o.lastModified, newList);
+			n = new PackList(o.lastRead, o.lastModified, newList);
 		} while (!packList.compareAndSet(o, n));
 	}
 
@@ -290,7 +290,7 @@ private void removePack(final PackFile deadPack) {
 			final PackFile[] newList = new PackFile[oldList.length - 1];
 			System.arraycopy(oldList, 0, newList, 0, j);
 			System.arraycopy(oldList, j + 1, newList, j, newList.length - j);
-			n = new PackList(o.lastModified, newList);
+			n = new PackList(o.lastRead, o.lastModified, newList);
 		} while (!packList.compareAndSet(o, n));
 		deadPack.close();
 	}
@@ -324,6 +324,7 @@ private PackList scanPacks(final PackList original) {
 
 	private PackList scanPacksImpl(final PackList old) {
 		final Map<String, PackFile> forReuse = reuseMap(old);
+		final long lastRead = System.currentTimeMillis();
 		final long lastModified = packDirectory.lastModified();
 		final Set<String> names = listPackDirectory();
 		final List<PackFile> list = new ArrayList<PackFile>(names.size() >> 2);
@@ -362,18 +363,18 @@ private PackList scanPacksImpl(final PackList old) {
 		// return the same collection.
 		//
 		if (!foundNew && lastModified == old.lastModified && forReuse.isEmpty())
-			return old;
+			return old.updateLastRead(lastRead);
 
 		for (final PackFile p : forReuse.values()) {
 			p.close();
 		}
 
 		if (list.isEmpty())
-			return new PackList(lastModified, NO_PACKS.packs);
+			return new PackList(lastRead, lastModified, NO_PACKS.packs);
 
 		final PackFile[] r = list.toArray(new PackFile[list.size()]);
 		Arrays.sort(r, PackFile.SORT);
-		return new PackList(lastModified, r);
+		return new PackList(lastRead, lastModified, r);
 	}
 
 	private static Map<String, PackFile> reuseMap(final PackList old) {
@@ -449,19 +450,62 @@ private ObjectDatabase openAlternate(final String location)
 	}
 
 	private static final class PackList {
+		/** Last wall-clock time the directory was read. */
+		volatile long lastRead;
+
 		/** Last modification time of {@link ObjectDirectory#packDirectory}. */
 		final long lastModified;
 
 		/** All known packs, sorted by {@link PackFile#SORT}. */
 		final PackFile[] packs;
 
-		PackList(final long lastModified, final PackFile[] packs) {
+		private boolean cannotBeRacilyClean;
+
+		PackList(final long lastRead, final long lastModified,
+				final PackFile[] packs) {
+			this.lastRead = lastRead;
 			this.lastModified = lastModified;
 			this.packs = packs;
+			this.cannotBeRacilyClean = notRacyClean(lastRead);
+		}
+
+		private boolean notRacyClean(final long read) {
+			return read - lastModified > 2 * 60 * 1000L;
+		}
+
+		PackList updateLastRead(final long now) {
+			if (notRacyClean(now))
+				cannotBeRacilyClean = true;
+			lastRead = now;
+			return this;
 		}
 
 		boolean tryAgain(final long currLastModified) {
-			return lastModified < currLastModified;
+			// Any difference indicates the directory was modified.
+			//
+			if (lastModified != currLastModified)
+				return true;
+
+			// We have already determined the last read was far enough
+			// after the last modification that any new modifications
+			// are certain to change the last modified time.
+			//
+			if (cannotBeRacilyClean)
+				return false;
+
+			if (notRacyClean(lastRead)) {
+				// Our last read should have marked cannotBeRacilyClean,
+				// but this thread may not have seen the change. The read
+				// of the volatile field lastRead should have fixed that.
+				//
+				return false;
+			}
+
+			// We last read this directory too close to its last observed
+			// modification time. We may have missed a modification. Scan
+			// the directory again, to ensure we still see the same state.
+			//
+			return true;
 		}
 	}
 }
-- 
1.6.4.rc2.216.g769fa
