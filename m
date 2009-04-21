From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/10] Introduce a new exception type for an in-place pack modification
Date: Mon, 20 Apr 2009 18:21:07 -0700
Message-ID: <1240276872-17893-6-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
 <1240276872-17893-2-git-send-email-spearce@spearce.org>
 <1240276872-17893-3-git-send-email-spearce@spearce.org>
 <1240276872-17893-4-git-send-email-spearce@spearce.org>
 <1240276872-17893-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hV-00021g-Bk
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667AbZDUBV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757361AbZDUBVZ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:25 -0400
Received: from george.spearce.org ([209.20.77.23]:33025 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757588AbZDUBVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:17 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9F41138268; Tue, 21 Apr 2009 01:21:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 15DB938211;
	Tue, 21 Apr 2009 01:21:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117067>

If a pack file is modified in place by "git gc" or "git repack"
it means that the list of objects contained within the pack has
not changed, but it is possible for the layout of the pack to
be modified.

The layout can change when the compressed version of any object
is changed, and usually happens because the packer has found a
smaller way to represent a contained object.  It also can change
if an object's delta base encoding format is switched, such as from
OBJ_REF to OBJ_OFS.

This new exception type can be caught by callers to recognize that
the object contents of the pack is quite likely the same, but that
any offsets and cached windows are wrong and need to be computed
or loaded again.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/errors/PackMismatchException.java |   55 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |   15 +++--
 2 files changed, 64 insertions(+), 6 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/PackMismatchException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/PackMismatchException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/PackMismatchException.java
new file mode 100644
index 0000000..b96f9e8
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/PackMismatchException.java
@@ -0,0 +1,55 @@
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
+import java.io.IOException;
+
+/** Thrown when a PackFile no longer matches the PackIndex. */
+public class PackMismatchException extends IOException {
+	private static final long serialVersionUID = 1L;
+
+	/**
+	 * Construct a pack modification error.
+	 *
+	 * @param why
+	 *            description of the type of error.
+	 */
+	public PackMismatchException(final String why) {
+		super(why);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index b525a82..bda4843 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -51,6 +51,7 @@
 import java.util.zip.DataFormatException;
 
 import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.errors.PackMismatchException;
 import org.spearce.jgit.util.NB;
 
 /**
@@ -292,16 +293,18 @@ private void onOpenPack() throws IOException {
 		final long packCnt = NB.decodeUInt32(intbuf, 0);
 		final long idxCnt = idx.getObjectCount();
 		if (idxCnt != packCnt)
-			throw new IOException("Pack index"
-					+ " object count mismatch; expected " + packCnt
-					+ " found " + idxCnt + ": " + pack.getName());
+			throw new PackMismatchException("Pack object count mismatch:"
+					+ " pack " + packCnt
+					+ " index " + idxCnt
+					+ ": " + pack.getName());
 
 		final byte[] csumbuf = new byte[20];
 		pack.readFully(pack.length() - 20, csumbuf, curs);
 		if (!Arrays.equals(csumbuf, idx.packChecksum))
-			throw new IOException("Pack index mismatch; pack SHA-1 is "
-					+ ObjectId.fromRaw(csumbuf).name() + ", index expects "
-					+ ObjectId.fromRaw(idx.packChecksum).name());
+			throw new PackMismatchException("Pack checksum mismatch:"
+					+ " pack " + ObjectId.fromRaw(csumbuf).name()
+					+ " index " + ObjectId.fromRaw(idx.packChecksum).name()
+					+ ": " + pack.getName());
 	}
 
 	private PackedObjectLoader reader(final WindowCursor curs,
-- 
1.6.3.rc1.188.ga02b
