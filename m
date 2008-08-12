From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 09/26] Support writing a .git/index through DirCache
Date: Mon, 11 Aug 2008 18:07:56 -0700
Message-ID: <1218503293-14057-10-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPS-0006OQ-B2
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYHLBIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYHLBIe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:34 -0400
Received: from george.spearce.org ([209.20.77.23]:38583 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYHLBIU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 975273838E; Tue, 12 Aug 2008 01:08:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0B7AF3838A;
	Tue, 12 Aug 2008 01:08:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92036>

We now support writing back the same entires we read in, with maybe
some minor entry level edits such as to change the mode of an entry,
or the assume valid flag.

We also include full support for smudging potentially 'racily clean'
entries while writing an updated index file back to disk.  We differ
from C Git in how we smudge an entry, but the effect should be the
same in that potentially racily clean entries will require C Git to
compare the content of the file, at least until Jan 19, 2038.  The
smudge rule needs to be different because we do not have access to
the working directory in order to validate a racily clean entry.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   97 ++++++++++++++++++++
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   75 +++++++++++++++
 2 files changed, 172 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 8f38a79..248e2a2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -38,12 +38,16 @@
 package org.spearce.jgit.dircache;
 
 import java.io.BufferedInputStream;
+import java.io.BufferedOutputStream;
 import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
+import java.io.OutputStream;
 import java.nio.ByteBuffer;
 import java.nio.channels.FileChannel;
+import java.security.DigestOutputStream;
+import java.security.MessageDigest;
 import java.util.Comparator;
 
 import org.spearce.jgit.errors.CorruptObjectException;
@@ -352,6 +356,99 @@ public class DirCache {
 	}
 
 	/**
+	 * Write the entry records from memory to disk.
+	 * <p>
+	 * The cache must be locked first by calling {@link #lock()} and receiving
+	 * true as the return value. Applications are encouraged to lock the index,
+	 * then invoke {@link #read()} to ensure the in-memory data is current,
+	 * prior to updating the in-memory entries.
+	 * <p>
+	 * Once written the lock is closed and must be either committed with
+	 * {@link #commit()} or rolled back with {@link #unlock()}.
+	 * 
+	 * @throws IOException
+	 *             the output file could not be created. The caller no longer
+	 *             holds the lock.
+	 */
+	public void write() throws IOException {
+		final LockFile tmp = myLock;
+		requireLocked(tmp);
+		try {
+			writeTo(new BufferedOutputStream(tmp.getOutputStream()));
+		} catch (IOException err) {
+			tmp.unlock();
+			throw err;
+		} catch (RuntimeException err) {
+			tmp.unlock();
+			throw err;
+		} catch (Error err) {
+			tmp.unlock();
+			throw err;
+		}
+	}
+
+	private void writeTo(final OutputStream os) throws IOException {
+		final MessageDigest foot = Constants.newMessageDigest();
+		final DigestOutputStream dos = new DigestOutputStream(os, foot);
+
+		// Write the header.
+		//
+		final byte[] tmp = new byte[128];
+		System.arraycopy(SIG_DIRC, 0, tmp, 0, SIG_DIRC.length);
+		NB.encodeInt32(tmp, 4, /* version */2);
+		NB.encodeInt32(tmp, 8, entryCnt);
+		dos.write(tmp, 0, 12);
+
+		// Write the individual file entries.
+		//
+		if (lastModified <= 0) {
+			// Write a new index, as no entries require smudging.
+			//
+			for (int i = 0; i < entryCnt; i++)
+				sortedEntries[i].write(dos);
+		} else {
+			final int smudge_s = (int) (lastModified / 1000);
+			final int smudge_ns = ((int) (lastModified % 1000)) * 1000000;
+			for (int i = 0; i < entryCnt; i++) {
+				final DirCacheEntry e = sortedEntries[i];
+				if (e.mightBeRacilyClean(smudge_s, smudge_ns))
+					e.smudgeRacilyClean();
+				e.write(dos);
+			}
+		}
+
+		os.write(foot.digest());
+		os.close();
+	}
+
+	/**
+	 * Commit this change and release the lock.
+	 * <p>
+	 * If this method fails (returns false) the lock is still released.
+	 * 
+	 * @return true if the commit was successful and the file contains the new
+	 *         data; false if the commit failed and the file remains with the
+	 *         old data.
+	 * @throws IllegalStateException
+	 *             the lock is not held.
+	 */
+	public boolean commit() {
+		final LockFile tmp = myLock;
+		requireLocked(tmp);
+		myLock = null;
+		if (!tmp.commit())
+			return false;
+		lastModified = tmp.getCommitLastModified();
+		return true;
+	}
+
+	private void requireLocked(final LockFile tmp) {
+		if (tmp == null)
+			throw new IllegalStateException("DirCache "
+					+ liveFile.getAbsolutePath() + " not locked.");
+	}
+
+	/**
 	 * Unlock this file and abort this change.
 	 * <p>
 	 * The temporary file (if created) is deleted before returning.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index 7efab48..8ca8f22 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -39,7 +39,9 @@ package org.spearce.jgit.dircache;
 
 import java.io.IOException;
 import java.io.InputStream;
+import java.io.OutputStream;
 import java.nio.ByteBuffer;
+import java.util.Arrays;
 
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
@@ -53,6 +55,8 @@ import org.spearce.jgit.util.NB;
  * then multiple DirCacheEntry instances may appear for the same path name.
  */
 public class DirCacheEntry {
+	private static final byte[] nullpad = new byte[8];
+
 	// private static final int P_CTIME = 0;
 
 	// private static final int P_CTIME_NSEC = 4;
@@ -110,6 +114,77 @@ public class DirCacheEntry {
 			in.skip(expLen - actLen);
 	}
 
+	void write(final OutputStream os) throws IOException {
+		final int pathLen = path.length;
+		os.write(info, infoOffset, INFO_LEN);
+		os.write(path, 0, pathLen);
+
+		// Index records are padded out to the next 8 byte alignment
+		// for historical reasons related to how C Git read the files.
+		//
+		final int actLen = INFO_LEN + pathLen;
+		final int expLen = (actLen + 8) & ~7;
+		if (actLen != expLen)
+			os.write(nullpad, 0, expLen - actLen);
+	}
+
+	/**
+	 * Is it possible for this entry to be accidently assumed clean?
+	 * <p>
+	 * The "racy git" problem happens when a work file can be updated faster
+	 * than the filesystem records file modification timestamps. It is possible
+	 * for an application to edit a work file, update the index, then edit it
+	 * again before the filesystem will give the work file a new modification
+	 * timestamp. This method tests to see if file was written out at the same
+	 * time as the index.
+	 * 
+	 * @param smudge_s
+	 *            seconds component of the index's last modified time.
+	 * @param smudge_ns
+	 *            nanoseconds component of the index's last modified time.
+	 * @return true if extra careful checks should be used.
+	 */
+	final boolean mightBeRacilyClean(final int smudge_s, final int smudge_ns) {
+		// If the index has a modification time then it came from disk
+		// and was not generated from scratch in memory. In such cases
+		// the entry is 'racily clean' if the entry's cached modification
+		// time is equal to or later than the index modification time. In
+		// such cases the work file is too close to the index to tell if
+		// it is clean or not based on the modification time alone.
+		//
+		final int base = infoOffset + P_MTIME;
+		final int mtime = NB.decodeInt32(info, base);
+		if (smudge_s < mtime)
+			return true;
+		if (smudge_s == mtime)
+			return smudge_ns <= NB.decodeInt32(info, base + 4) / 1000000;
+		return false;
+	}
+
+	/**
+	 * Force this entry to no longer match its working tree file.
+	 * <p>
+	 * This avoids the "racy git" problem by making this index entry no longer
+	 * match the file in the working directory. Later git will be forced to
+	 * compare the file content to ensure the file matches the working tree.
+	 */
+	final void smudgeRacilyClean() {
+		// We don't use the same approach as C Git to smudge the entry,
+		// as we cannot compare the working tree file to our SHA-1 and
+		// thus cannot use the "size to 0" trick without accidentally
+		// thinking a zero length file is clean.
+		//
+		// Instead we force the mtime to the largest possible value, so
+		// it is certainly after the index's own modification time and
+		// on a future read will cause mightBeRacilyClean to say "yes!".
+		// It is also unlikely to match with the working tree file.
+		//
+		// I'll see you again before Jan 19, 2038, 03:14:07 AM GMT.
+		//
+		final int base = infoOffset + P_MTIME;
+		Arrays.fill(info, base, base + 8, (byte) 127);
+	}
+
 	final byte[] idBuffer() {
 		return info;
 	}
-- 
1.6.0.rc2.22.g71b99
