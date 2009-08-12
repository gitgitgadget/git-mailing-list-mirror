From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT 3/5] Introduce InvalidObjectIdException to reduce code duplicated
Date: Wed, 12 Aug 2009 11:06:30 -0400
Message-ID: <1250089590-22401-1-git-send-email-fonseca@diku.dk>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFPu-0002zZ-SR
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbZHLPGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbZHLPGd
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:06:33 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:53744 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbZHLPGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:06:32 -0400
Received: by yxe5 with SMTP id 5so93282yxe.33
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=vXtWwRekneegizUiIvBRXMjwV+MxGB5AEFtksvi0SE0=;
        b=t3B8NMQaquu225mZftXw9/6dwABNFWkEO7hv90mjeIMXPnqwBPjUHw6a/GN7dsLMEN
         ftpI6zHpqizkkzpQ7lBBPIaecjZbhI5KDkFPbY05XnpgGN2zMBwxo8pJxkiK0aKZzHgl
         aw9YW85T15ZfJGEhqOPBKCI7PH3ASRfGRDc/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=GADSzDYBanEk7Do7PZi5hEQEjY5pBhS/BNasksVPIkRR9afkEcXK4yWt/YZkxTypk4
         5R9HfZGIcXjj+4v1wJnQPQ+qV5nhlMeDqNxRpz55QMI2ByVGwk6rXyiyJlnzjf6H2iBy
         HVQ8DbrBiyIuiy/MWtxiPtIcnQ7I5hLyhsfTo=
Received: by 10.90.149.6 with SMTP id w6mr125918agd.90.1250089593080;
        Wed, 12 Aug 2009 08:06:33 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178045554.dsl.bell.ca [70.55.140.114])
        by mx.google.com with ESMTPS id 7sm2722743aga.27.2009.08.12.08.06.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 08:06:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.195.g2b05f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125706>

Collects error handling code related to parsing of object id's in one
place.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../jgit/errors/InvalidObjectIdException.java      |   69 ++++++++++++++++++++
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |   10 +--
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |   12 +---
 .../src/org/spearce/jgit/lib/ObjectId.java         |   10 +--
 4 files changed, 75 insertions(+), 26 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/InvalidObjectIdException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidObjectIdException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidObjectIdException.java
new file mode 100644
index 0000000..5d50884
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidObjectIdException.java
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, Jonas Fonseca <fonseca@diku.dk>
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
+import java.io.UnsupportedEncodingException;
+
+/**
+ * Thrown when an invalid object id is passed in as an argument.
+ */
+public class InvalidObjectIdException extends IllegalArgumentException {
+
+	/**
+	 * Create exception with bytes of the invalid object id.
+	 *
+	 * @param bytes containing the invalid id.
+	 * @param offset in the byte array where the error occured.
+	 * @param length of the sequence of invalid bytes.
+	 */
+	public InvalidObjectIdException(byte[] bytes, int offset, int length) {
+		super("Invalid id" + asAscii(bytes, offset, length));
+	}
+
+	private static String asAscii(byte[] bytes, int offset, int length) {
+		try {
+			return ": " + new String(bytes, offset, length, "US-ASCII");
+		} catch (UnsupportedEncodingException e2) {
+			return "";
+		} catch (StringIndexOutOfBoundsException e2) {
+			return "";
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
index 1706e88..6ad2ea1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
@@ -37,8 +37,7 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.UnsupportedEncodingException;
-
+import org.spearce.jgit.errors.InvalidObjectIdException;
 import org.spearce.jgit.util.NB;
 import org.spearce.jgit.util.RawParseUtils;
 
@@ -97,12 +96,7 @@ private static final AbbreviatedObjectId fromHexString(final byte[] bs,
 			final int e = hexUInt32(bs, ptr + 32, end);
 			return new AbbreviatedObjectId(end - ptr, a, b, c, d, e);
 		} catch (ArrayIndexOutOfBoundsException e1) {
-			try {
-				final String str = new String(bs, ptr, end - ptr, "US-ASCII");
-				throw new IllegalArgumentException("Invalid id: " + str);
-			} catch (UnsupportedEncodingException e2) {
-				throw new IllegalArgumentException("Invalid id");
-			}
+			throw new InvalidObjectIdException(bs, ptr, end - ptr);
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
index 805f328..9e25908 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
@@ -37,8 +37,7 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.UnsupportedEncodingException;
-
+import org.spearce.jgit.errors.InvalidObjectIdException;
 import org.spearce.jgit.util.NB;
 import org.spearce.jgit.util.RawParseUtils;
 
@@ -166,14 +165,7 @@ private void fromHexString(final byte[] bs, int p) {
 			w4 = RawParseUtils.parseHexInt32(bs, p + 24);
 			w5 = RawParseUtils.parseHexInt32(bs, p + 32);
 		} catch (ArrayIndexOutOfBoundsException e1) {
-			try {
-				final String str = new String(bs, p, STR_LEN, "US-ASCII");
-				throw new IllegalArgumentException("Invalid id: " + str);
-			} catch (UnsupportedEncodingException e2) {
-				throw new IllegalArgumentException("Invalid id");
-			} catch (StringIndexOutOfBoundsException e2) {
-				throw new IllegalArgumentException("Invalid id");
-			}
+			throw new InvalidObjectIdException(bs, p, STR_LEN);
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index cdd523f..310d6e0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -38,8 +38,7 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.UnsupportedEncodingException;
-
+import org.spearce.jgit.errors.InvalidObjectIdException;
 import org.spearce.jgit.util.NB;
 import org.spearce.jgit.util.RawParseUtils;
 
@@ -230,12 +229,7 @@ private static final ObjectId fromHexString(final byte[] bs, int p) {
 			final int e = RawParseUtils.parseHexInt32(bs, p + 32);
 			return new ObjectId(a, b, c, d, e);
 		} catch (ArrayIndexOutOfBoundsException e1) {
-			try {
-				final String str = new String(bs, p, STR_LEN, "US-ASCII");
-				throw new IllegalArgumentException("Invalid id: " + str);
-			} catch (UnsupportedEncodingException e2) {
-				throw new IllegalArgumentException("Invalid id");
-			}
+			throw new InvalidObjectIdException(bs, p, STR_LEN);
 		}
 	}
 
-- 
1.6.4.rc3.195.g2b05f
