From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Fix UnpackedObjectLoader.getBytes to return a copy
Date: Tue, 30 Sep 2008 18:31:27 -0700
Message-ID: <1222824690-7632-3-git-send-email-spearce@spearce.org>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org>
 <1222824690-7632-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 03:33:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkqal-0006Nd-Jq
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 03:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYJABbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 21:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbYJABbf
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 21:31:35 -0400
Received: from george.spearce.org ([209.20.77.23]:51627 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbYJABbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 21:31:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3CCBC383A3; Wed,  1 Oct 2008 01:31:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 38EB338360;
	Wed,  1 Oct 2008 01:31:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.569.g798a2a
In-Reply-To: <1222824690-7632-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97179>

The contract for ObjectLoader.getBytes() says the caller can modify
the returned array.  UnpackedObjectLoader must copy the data and not
return its internal cached byte array.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |    7 ++++++-
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    7 -------
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |    4 ----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
index 5282491..87e861f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
@@ -105,7 +105,12 @@ protected void setId(final ObjectId id) {
 	 * @throws IOException
 	 *             the object cannot be read.
 	 */
-	public abstract byte[] getBytes() throws IOException;
+	public final byte[] getBytes() throws IOException {
+		final byte[] data = getCachedBytes();
+		final byte[] copy = new byte[data.length];
+		System.arraycopy(data, 0, copy, 0, data.length);
+		return data;
+	}
 
 	/**
 	 * Obtain a reference to the (possibly cached) bytes of this object.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index fa414d6..35983fe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -80,13 +80,6 @@ public long getDataOffset() {
 		return dataOffset;
 	}
 
-	public final byte[] getBytes() throws IOException {
-		final byte[] data = getCachedBytes();
-		final byte[] copy = new byte[data.length];
-		System.arraycopy(data, 0, copy, 0, data.length);
-		return data;
-	}
-
 	/**
 	 * Copy raw object representation from storage to provided output stream.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index 3c61254..3ad273f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -200,10 +200,6 @@ public long getSize() {
 		return objectSize;
 	}
 
-	public byte[] getBytes() {
-		return bytes;
-	}
-
 	@Override
 	public byte[] getCachedBytes() throws IOException {
 		return bytes;
-- 
1.6.0.2.569.g798a2a
