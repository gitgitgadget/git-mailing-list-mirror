From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2 1/2] Ensure that a PackFile instance stays invalid
	when overwritten
Date: Mon, 4 May 2009 12:30:45 -0700
Message-ID: <20090504193045.GA23604@spearce.org>
References: <1241296230-19342-1-git-send-email-spearce@spearce.org> <200905031005.57638.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 04 21:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M13sO-0002iC-5k
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 21:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbZEDTar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 15:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbZEDTaq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 15:30:46 -0400
Received: from george.spearce.org ([209.20.77.23]:54654 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbZEDTap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 15:30:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B77E438196; Mon,  4 May 2009 19:30:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905031005.57638.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118257>

If a PackFile gets overwritten after we read its pack-*.idx we
throw a PackMismatchException and then close the PackFile, which
discards the index.  At this point the PackFile instance is dead
and must be discarded by the GC, as it is used as part of the key
in the WindowCache and the UnpackedObjectCache.

There is however a subtle race condition here.  If the PackFile is
opened again after the PackMismatchException is thrown we load the
new index file into memory, possibly seeing the footer in the index
match the footer in the pack, and believing that the file is valid.
This can mean that stale windows that haven't yet expired out of the
WindowCache suddenly become valid again, even though they contain
data from the old version of the pack.

By caching the pack signature the very first time we open it we
can more reliably detect this overwrite race condition and keep
the PackFile instance invalid.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
  > > @@ -339,6 +351,8 @@ synchronized boolean endWindowCache() {
  > >  
  > >  	private void doOpen() throws IOException {
  > >  		try {
  > > +			if (invalid)
  > > +				throw new PackMismatchException("Pack checksum mismatch");
  >
  > That /may/ be the case. We no longer know why the index failed to open. One way
  > is to save the reason, the other is not to be so d** sure and use a less specific
  > message.

  Good point.  v2 fixes that by using a new special exception type.

 .../spearce/jgit/errors/PackInvalidException.java  |   56 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |   19 ++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/PackInvalidException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/PackInvalidException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/PackInvalidException.java
new file mode 100644
index 0000000..2e5485f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/PackInvalidException.java
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.errors;
+
+import java.io.File;
+import java.io.IOException;
+
+/** Thrown when a PackFile previously failed and is known to be unusable */
+public class PackInvalidException extends IOException {
+	private static final long serialVersionUID = 1L;
+
+	/**
+	 * Construct a pack invalid error.
+	 *
+	 * @param path
+	 *            path of the invalid pack file.
+	 */
+	public PackInvalidException(final File path) {
+		super("Pack file invalid: " + path.getAbsolutePath());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index b107dfe..7e17613 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -54,6 +54,7 @@
 import java.util.zip.DataFormatException;
 
 import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.errors.PackInvalidException;
 import org.spearce.jgit.errors.PackMismatchException;
 import org.spearce.jgit.util.NB;
 import org.spearce.jgit.util.RawParseUtils;
@@ -89,6 +90,8 @@ public int compare(final PackFile a, final PackFile b) {
 
 	private volatile boolean invalid;
 
+	private byte[] packChecksum;
+
 	private PackIndex loadedIdx;
 
 	private PackReverseIndex reverseIdx;
@@ -115,8 +118,18 @@ public PackFile(final File idxFile, final File packFile) {
 
 	private synchronized PackIndex idx() throws IOException {
 		if (loadedIdx == null) {
+			if (invalid)
+				throw new PackInvalidException(packFile);
+
 			try {
-				loadedIdx = PackIndex.open(idxFile);
+				final PackIndex idx = PackIndex.open(idxFile);
+
+				if (packChecksum == null)
+					packChecksum = idx.packChecksum;
+				else if (!Arrays.equals(packChecksum, idx.packChecksum))
+					throw new PackMismatchException("Pack checksum mismatch");
+
+				loadedIdx = idx;
 			} catch (IOException e) {
 				invalid = true;
 				throw e;
@@ -339,6 +352,8 @@ synchronized boolean endWindowCache() {
 
 	private void doOpen() throws IOException {
 		try {
+			if (invalid)
+				throw new PackInvalidException(packFile);
 			fd = new RandomAccessFile(packFile, "r");
 			length = fd.length();
 			onOpenPack();
@@ -423,7 +438,7 @@ private void onOpenPack() throws IOException {
 					+ ": " + getPackFile());
 
 		NB.readFully(fd.getChannel(), length - 20, buf, 0, 20);
-		if (!Arrays.equals(buf, idx.packChecksum))
+		if (!Arrays.equals(buf, packChecksum))
 			throw new PackMismatchException("Pack checksum mismatch:"
 					+ " pack " + ObjectId.fromRaw(buf).name()
 					+ " index " + ObjectId.fromRaw(idx.packChecksum).name()
-- 
1.6.3.rc4.206.g03e16
