From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/10] Extract inner ObjectEntry from IndexPack class
Date: Mon, 23 Jun 2008 22:09:59 -0400
Message-ID: <1214273408-70793-2-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy06-0005dy-Eh
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYFXCKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbYFXCKZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49647 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbYFXCKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxyy-0001M4-JF; Mon, 23 Jun 2008 22:10:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 66D0B20FBCA; Mon, 23 Jun 2008 22:10:18 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id E776D20FBCB;
	Mon, 23 Jun 2008 22:10:08 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-1-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85969>

This type is useful not just for IndexPack but also for PackWriter
as it is essentially the index record (ObjectId and offset).  Both
data items are necessary to compute a valid index record, so we can
unify the index writing code if we have a common type.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |   10 ----
 .../org/spearce/jgit/transport/ObjectEntry.java    |   51 ++++++++++++++++++++
 2 files changed, 51 insertions(+), 10 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index bec211c..e182cfc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -54,7 +54,6 @@ import java.util.zip.Deflater;
 import java.util.zip.Inflater;
 
 import org.spearce.jgit.errors.CorruptObjectException;
-import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.BinaryDelta;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.InflaterCache;
@@ -715,15 +714,6 @@ public class IndexPack {
 				+ dfe.getMessage());
 	}
 
-	private static class ObjectEntry extends ObjectId {
-		final long pos;
-
-		ObjectEntry(final long headerOffset, final AnyObjectId id) {
-			super(id);
-			pos = headerOffset;
-		}
-	}
-
 	private static class UnresolvedDelta {
 		final long position;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
new file mode 100644
index 0000000..58d2eb2
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.transport;
+
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.ObjectId;
+
+class ObjectEntry extends ObjectId {
+	final long pos;
+
+	ObjectEntry(final long headerOffset, final AnyObjectId id) {
+		super(id);
+		pos = headerOffset;
+	}
+}
-- 
1.5.6.74.g8a5e
