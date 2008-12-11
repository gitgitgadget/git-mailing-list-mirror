From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Add copy(InputStream) to TemporaryBuffer
Date: Wed, 10 Dec 2008 20:58:39 -0800
Message-ID: <1228971522-28764-3-git-send-email-spearce@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org>
 <1228971522-28764-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 06:00:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAdeg-000260-Qp
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 06:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbYLKE6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbYLKE6u
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:58:50 -0500
Received: from george.spearce.org ([209.20.77.23]:51654 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYLKE6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:58:45 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E99BC38221; Thu, 11 Dec 2008 04:58:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DF37738211;
	Thu, 11 Dec 2008 04:58:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228971522-28764-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102775>

In some places we may find it ourselves with an InputStream we
need to copy into a TemporaryBuffer, so we can flatten out the
entire stream to a single byte[].  Putting the copy loop here
is more useful then duplicating it in application level code.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
index b1ffd6e..8f91246 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
@@ -42,6 +42,7 @@
 import java.io.FileInputStream;
 import java.io.FileOutputStream;
 import java.io.IOException;
+import java.io.InputStream;
 import java.io.OutputStream;
 import java.util.ArrayList;
 
@@ -135,6 +136,22 @@ public void write(final byte[] b, int off, int len) throws IOException {
 			diskOut.write(b, off, len);
 	}
 
+	/**
+	 * Copy all bytes remaining on the input stream into this buffer.
+	 * 
+	 * @param in
+	 *            the stream to read from, until EOF is reached.
+	 * @throws IOException
+	 *             an error occurred reading from the input stream, or while
+	 *             writing to a local temporary file.
+	 */
+	public void copy(final InputStream in) throws IOException {
+		final byte[] b = new byte[2048];
+		int n;
+		while ((n = in.read(b)) > 0)
+			write(b, 0, n);
+	}
+
 	private Block last() {
 		return blocks.get(blocks.size() - 1);
 	}
-- 
1.6.1.rc2.299.gead4c
