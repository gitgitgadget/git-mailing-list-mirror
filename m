From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 4/4] Fix DirCache's skip over null byte padding when reading a DIRC file
Date: Mon, 18 Aug 2008 09:35:33 -0700
Message-ID: <1219077333-29226-4-git-send-email-spearce@spearce.org>
References: <1219077333-29226-1-git-send-email-spearce@spearce.org>
 <1219077333-29226-2-git-send-email-spearce@spearce.org>
 <1219077333-29226-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, John Franey <jjfraney@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV7il-0002lV-Rq
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 18:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbYHRQfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 12:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYHRQfl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 12:35:41 -0400
Received: from george.spearce.org ([209.20.77.23]:43121 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbYHRQfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 12:35:36 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EDA5D38376; Mon, 18 Aug 2008 16:35:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D0BED38368;
	Mon, 18 Aug 2008 16:35:34 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219077333-29226-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92713>

Sometimes we hit EOFException while reading from a 'DIRC' file with
the new DirCache API.  This was caused by BufferedInputStream.skip
skipping only part of the range we asked it to skip if the range we
asked it to skip spanned over the end of the current buffer block.
Two skip requests are necessary in this case: one to force the stream
to skip to the end of the buffer, and another to skip over data in
the source stream before reading the next buffer block into memory.

NB.skipFully handles this by abstracting the necessary loop into
a utility function, much like NB.readFully handles the necessary
read loop to ensure we read a full block of data.

DirCacheEntry and DirCache both need to use this routine to skip
over the parts of the DIRC file they do not wish to read.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

  This actually fixes the bug EOFException bug identified by John Franey.

 .../src/org/spearce/jgit/dircache/DirCache.java    |    2 +-
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |    2 +-
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   27 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 995942c..76657c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -370,7 +370,7 @@ private void readFrom(final FileInputStream inStream) throws IOException,
 					// a performance optimization. Since we do not
 					// understand it, we can safely skip past it.
 					//
-					in.skip(NB.decodeInt32(hdr, 4));
+					NB.skipFully(in, NB.decodeUInt32(hdr, 4));
 				} else {
 					// The extension is not an optimization and is
 					// _required_ to understand this index format.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index bcf5596..011bc16 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -116,7 +116,7 @@ DirCacheEntry(final byte[] sharedInfo, final int infoAt,
 		final int actLen = INFO_LEN + pathLen;
 		final int expLen = (actLen + 8) & ~7;
 		if (actLen != expLen)
-			in.skip(expLen - actLen);
+			NB.skipFully(in, expLen - actLen);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
index fa13354..759caf5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
@@ -71,6 +71,33 @@ public static void readFully(final InputStream fd, final byte[] dst,
 	}
 
 	/**
+	 * Skip an entire region of an input stream.
+	 * <p>
+	 * The input stream's position is moved forward by the number of requested
+	 * bytes, discarding them from the input. This method does not return until
+	 * the exact number of bytes requested has been skipped.
+	 * 
+	 * @param fd
+	 *            the stream to skip bytes from.
+	 * @param toSkip
+	 *            total number of bytes to be discarded. Must be >= 0.
+	 * @throws EOFException
+	 *             the stream ended before the requested number of bytes were
+	 *             skipped.
+	 * @throws IOException
+	 *             there was an error reading from the stream.
+	 */
+	public static void skipFully(final InputStream fd, long toSkip)
+			throws IOException {
+		while (toSkip > 0) {
+			final long r = fd.skip(toSkip);
+			if (r <= 0)
+				throw new EOFException("Short skip of block");
+			toSkip -= r;
+		}
+	}
+
+	/**
 	 * Compare a 32 bit unsigned integer stored in a 32 bit signed integer.
 	 * <p>
 	 * This function performs an unsigned compare operation, even though Java
-- 
1.6.0.87.g2858d
