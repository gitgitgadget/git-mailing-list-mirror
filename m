From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 05/20] Reverse pack index implementation: PackReverseIndex
Date: Sun, 15 Jun 2008 23:45:34 +0200
Message-ID: <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804E-0001bl-4J
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbYFOVqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYFOVqT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:31828 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbYFOVqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958498ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OWw6eiB4mjAWcInqEna+BpB4PIw0Fkr6QG9RQPMLi40=;
        b=IKK2NcG0anRxhM+p7UwMFPBLexvqXBz3o8BPfctku6tgGSBcT66KrNAZwvVLLKCRkv
         WnFh/cgpkBum7SeiRAfzZNXM6kEprWDvvjtWTzej8eQhaZ7dvW27Z2s0l9YuAHHZ+jsV
         dLzA2gRl8Oy55q8sEnMrTBUBtyP3Huqi+YBzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cHBR9v1jxzf6GkLCKQ+dupt0FN8HV2YQ//Uw9ex00rSfaYnYpYbt1uV9nipkg8d2on
         +xuzvr2DV4P7dw7fjCMvIxlBfGRA27YkDocjnqKHd+C1igMTF+OEf8CtRb2a70ITcSg8
         iw3dK7DnMEyVPDBznOzFfVOIBd/bAJ0sFK/v0=
Received: by 10.151.47.7 with SMTP id z7mr9416626ybj.198.1213566374362;
        Sun, 15 Jun 2008 14:46:14 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id p9sm14801573qbp.16.2008.06.15.14.46.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:13 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85131>

Let us quickly find ObjectId or next object for specified offset in a
pack, in O(log n) time.

Current implementation uses one level (reverse) indexing by an offset.
However, it tries to take small space as possible, by using 2 distinct
arrays for offsets with value < 2^31 (int[]) and those with value > 2^31
(long[]). Offsets are stored ordered in these 2 arrays. Binary search is
performed during requests.

Reverse index is constructed from an existing PackIndex instance, by
lazy initialization in a PackFile instance.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   20 +++
 .../src/org/spearce/jgit/lib/PackReverseIndex.java |  179 ++++++++++++++++++++
 2 files changed, 199 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 1b2c167..3880966 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -55,6 +55,8 @@ public class PackFile implements Iterable<PackIndex.MutableEntry> {
 
 	private final PackIndex idx;
 
+	private PackReverseIndex reverseIdx;
+
 	/**
 	 * Construct a reader for an existing, pre-indexed packfile.
 	 * 
@@ -172,6 +174,18 @@ public class PackFile implements Iterable<PackIndex.MutableEntry> {
 		return idx.getObjectCount();
 	}
 
+	/**
+	 * Search for object id with the specified start offset in associated pack
+	 * (reverse) index.
+	 * 
+	 * @param offset
+	 *            start offset of object to find
+	 * @return object id for this offset, or null if no object was found
+	 */
+	ObjectId findObjectForOffset(final long offset) {
+		return getReverseIdx().findObject(offset);
+	}
+
 	final UnpackedObjectCache.Entry readCache(final long position) {
 		return UnpackedObjectCache.get(pack, position);
 	}
@@ -264,4 +278,10 @@ public class PackFile implements Iterable<PackIndex.MutableEntry> {
 			throw new IOException("Unknown object type " + typeCode + ".");
 		}
 	}
+
+	private PackReverseIndex getReverseIdx() {
+		if (reverseIdx == null)
+			reverseIdx = new PackReverseIndex(idx);
+		return reverseIdx;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
new file mode 100644
index 0000000..3dede88
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
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
+package org.spearce.jgit.lib;
+
+import java.util.Arrays;
+import java.util.Comparator;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.lib.PackIndex.MutableEntry;
+
+/**
+ * <p>
+ * Reverse index for forward pack index. Provides operations based on offset
+ * instead of object id. Such offset-based reverse lookups are performed in
+ * O(log n) time.
+ * </p>
+ * 
+ * @see PackIndex
+ * @see PackFile
+ */
+class PackReverseIndex {
+	/**
+	 * (offset31, truly) Offsets accommodating in 31 bits.
+	 */
+	private final int offsets32[];
+
+	/**
+	 * Offsets not accommodating in 31 bits.
+	 */
+	private final long offsets64[];
+
+	/**
+	 * Object ids corresponding to {@link #offsets32} and {@link #offsets64}.
+	 */
+	private final int names[];
+
+	/**
+	 * Create reverse index from straight/forward pack index, by indexing all
+	 * its entries.
+	 * 
+	 * @param index
+	 *            forward index - entries to (reverse) index.
+	 */
+	PackReverseIndex(final PackIndex index) {
+		final long count = index.getObjectCount();
+		if (count > Integer.MAX_VALUE)
+			throw new IllegalArgumentException(
+					"Huge indexes (> 2^31 entries) are not supported by jgit, yet");
+
+		final MutableEntry entries[] = new MutableEntry[(int) count];
+		int i = 0;
+		int count32 = 0;
+		for (MutableEntry me : index) {
+			entries[i++] = me.cloneEntry();
+			if (me.getOffset() <= Integer.MAX_VALUE)
+				count32++;
+		}
+		Arrays.sort(entries, new Comparator<MutableEntry>() {
+			public int compare(MutableEntry o1, MutableEntry o2) {
+				return Long.signum(o1.getOffset() - o2.getOffset());
+			}
+		});
+
+		names = new int[entries.length * Constants.OBJECT_ID_LENGTH / 4];
+		offsets32 = new int[count32];
+		offsets64 = new long[entries.length - count32];
+		for (int j = 0, j32 = 0; j < entries.length; j++) {
+			final long offset = entries[j].getOffset();
+			if (offset <= Integer.MAX_VALUE)
+				offsets32[j32++] = (int) offset;
+			else
+				offsets64[j - j32] = offset;
+			entries[j].copyRawTo(names, j * Constants.OBJECT_ID_LENGTH / 4);
+		}
+	}
+
+	/**
+	 * Search for object id with the specified start offset in this pack
+	 * (reverse) index.
+	 * 
+	 * @param offset
+	 *            start offset of object to find.
+	 * @return object id for this offset, or null if no object was found.
+	 */
+	ObjectId findObject(final long offset) {
+		if (offset <= Integer.MAX_VALUE) {
+			final int i32 = Arrays.binarySearch(offsets32, (int) offset);
+			if (i32 < 0)
+				return null;
+			final int iNames = i32 * Constants.OBJECT_ID_LENGTH / 4;
+			return ObjectId.fromRaw(names, iNames);
+		} else {
+			final int i64 = Arrays.binarySearch(offsets64, offset);
+			if (i64 < 0)
+				return null;
+			final int iNames = (i64 + offsets32.length)
+					* Constants.OBJECT_ID_LENGTH / 4;
+			return ObjectId.fromRaw(names, iNames);
+		}
+	}
+
+	/**
+	 * Search for the next offset to the specified offset in this pack (reverse)
+	 * index.
+	 * 
+	 * @param offset
+	 *            start offset of previous object (must be valid-existing
+	 *            offset).
+	 * @param maxOffset
+	 *            maximum offset in a pack (returned when there is no next
+	 *            offset).
+	 * @return offset of the next object in a pack or maxOffset if provided
+	 *         offset was the last one.
+	 * @throws CorruptObjectException
+	 *             when there is no object with the provided offset.
+	 */
+	long findNextOffset(final long offset, final long maxOffset)
+			throws CorruptObjectException {
+		if (offset <= Integer.MAX_VALUE) {
+			final int i32 = Arrays.binarySearch(offsets32, (int) offset);
+			if (i32 < 0)
+				throw new CorruptObjectException(
+						"Can't find object in (reverse) pack index for the specified offset "
+								+ offset);
+
+			if (i32 + 1 == offsets32.length) {
+				if (offsets64.length > 0)
+					return offsets64[0];
+				return maxOffset;
+			}
+			return offsets32[i32 + 1];
+		} else {
+			final int i64 = Arrays.binarySearch(offsets64, offset);
+			if (i64 < 0)
+				throw new CorruptObjectException(
+						"Can't find object in (reverse) pack index for the specified offset "
+								+ offset);
+
+			if (i64 + 1 == offsets64.length)
+				return maxOffset;
+			return offsets64[i64 + 1];
+		}
+	}
+}
-- 
1.5.5.1
