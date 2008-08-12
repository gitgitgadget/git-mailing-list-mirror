From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 08/26] Support locking (and unlocking) a .git/index through DirCache
Date: Mon, 11 Aug 2008 18:07:55 -0700
Message-ID: <1218503293-14057-9-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPR-0006OQ-Lz
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYHLBIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYHLBIc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:32 -0400
Received: from george.spearce.org ([209.20.77.23]:38580 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYHLBIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E288838389; Tue, 12 Aug 2008 01:08:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C293E3837B;
	Tue, 12 Aug 2008 01:08:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92037>

In order to safely perform an update of the .git/index file (or any
other DirCache file) we need to lock the file prior to reading its
contents into memory.  This ensures that the contents will not be
modified between the time we start processing the entires and when
the update operation is completed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   86 ++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index f8ca60d..8f38a79 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -48,6 +48,7 @@ import java.util.Comparator;
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.LockFile;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.util.NB;
 
@@ -144,6 +145,56 @@ public class DirCache {
 		return read(new File(db.getDirectory(), "index"));
 	}
 
+	/**
+	 * Create a new in-core index representation, lock it, and read from disk.
+	 * <p>
+	 * The new index will be locked and then read before it is returned to the
+	 * caller. Read failures are reported as exceptions and therefore prevent
+	 * the method from returning a partially populated index.
+	 * 
+	 * @param indexLocation
+	 *            location of the index file on disk.
+	 * @return a cache representing the contents of the specified index file (if
+	 *         it exists) or an empty cache if the file does not exist.
+	 * @throws IOException
+	 *             the index file is present but could not be read, or the lock
+	 *             could not be obtained.
+	 * @throws CorruptObjectException
+	 *             the index file is using a format or extension that this
+	 *             library does not support.
+	 */
+	public static DirCache lock(final File indexLocation)
+			throws CorruptObjectException, IOException {
+		final DirCache c = new DirCache(indexLocation);
+		if (!c.lock())
+			throw new IOException("Cannot lock " + indexLocation);
+		c.read();
+		return c;
+	}
+
+	/**
+	 * Create a new in-core index representation, lock it, and read from disk.
+	 * <p>
+	 * The new index will be locked and then read before it is returned to the
+	 * caller. Read failures are reported as exceptions and therefore prevent
+	 * the method from returning a partially populated index.
+	 * 
+	 * @param db
+	 *            repository the caller wants to read the default index of.
+	 * @return a cache representing the contents of the specified index file (if
+	 *         it exists) or an empty cache if the file does not exist.
+	 * @throws IOException
+	 *             the index file is present but could not be read, or the lock
+	 *             could not be obtained.
+	 * @throws CorruptObjectException
+	 *             the index file is using a format or extension that this
+	 *             library does not support.
+	 */
+	public static DirCache lock(final Repository db)
+			throws CorruptObjectException, IOException {
+		return lock(new File(db.getDirectory(), "index"));
+	}
+
 	/** Location of the current version of the index file. */
 	private final File liveFile;
 
@@ -156,6 +207,9 @@ public class DirCache {
 	/** Number of positions within {@link #sortedEntries} that are valid. */
 	private int entryCnt;
 
+	/** Our active lock (if we hold it); null if we don't have it locked. */
+	private LockFile myLock;
+
 	/**
 	 * Create a new in-core index representation.
 	 * <p>
@@ -279,6 +333,38 @@ public class DirCache {
 	}
 
 	/**
+	 * Try to establish an update lock on the cache file.
+	 * 
+	 * @return true if the lock is now held by the caller; false if it is held
+	 *         by someone else.
+	 * @throws IOException
+	 *             the output file could not be created. The caller does not
+	 *             hold the lock.
+	 */
+	public boolean lock() throws IOException {
+		final LockFile tmp = new LockFile(liveFile);
+		if (tmp.lock()) {
+			tmp.setNeedStatInformation(true);
+			myLock = tmp;
+			return true;
+		}
+		return false;
+	}
+
+	/**
+	 * Unlock this file and abort this change.
+	 * <p>
+	 * The temporary file (if created) is deleted before returning.
+	 */
+	public void unlock() {
+		final LockFile tmp = myLock;
+		if (tmp != null) {
+			myLock = null;
+			tmp.unlock();
+		}
+	}
+
+	/**
 	 * Locate the position a path's entry is at in the index.
 	 * <p>
 	 * If there is at least one entry in the index for this path the position of
-- 
1.6.0.rc2.22.g71b99
