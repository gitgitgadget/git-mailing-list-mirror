From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Use Deflater directly in PackWriter
Date: Wed, 25 Mar 2009 18:21:55 -0700
Message-ID: <1238030515-31768-5-git-send-email-spearce@spearce.org>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org>
 <1238030515-31768-2-git-send-email-spearce@spearce.org>
 <1238030515-31768-3-git-send-email-spearce@spearce.org>
 <1238030515-31768-4-git-send-email-spearce@spearce.org>
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 02:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmeKK-00027D-QW
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 02:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbZCZBWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 21:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbZCZBWM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 21:22:12 -0400
Received: from george.spearce.org ([209.20.77.23]:40186 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbZCZBWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 21:22:01 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 30B1038215; Thu, 26 Mar 2009 01:21:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4E07D38211;
	Thu, 26 Mar 2009 01:21:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
In-Reply-To: <1238030515-31768-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114702>

Rather than going through all of the indirection that makes up the
DeflaterOutputStream, including the new object construction for it
and the temporary buffer it allocates internally, we can pump data
directly through our Deflater instance and use our existing 16 KB
temporary "buf" for the transient storage as we compress data to
the pack output stream.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 2f34255..2d05c4e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -47,7 +47,6 @@
 import java.util.Iterator;
 import java.util.List;
 import java.util.zip.Deflater;
-import java.util.zip.DeflaterOutputStream;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
@@ -699,12 +698,15 @@ private void writeWholeObject(final ObjectToPack otp) throws IOException {
 		} else {
 			final ObjectLoader loader = db.openObject(windowCursor, otp);
 			final byte[] data = loader.getCachedBytes();
-			final DeflaterOutputStream deflaterOut = new DeflaterOutputStream(
-					out, deflater);
 			writeObjectHeader(otp.getType(), data.length);
-			deflaterOut.write(data);
-			deflaterOut.finish();
 			deflater.reset();
+			deflater.setInput(data, 0, data.length);
+			deflater.finish();
+			do {
+				final int n = deflater.deflate(buf, 0, buf.length);
+				if (n > 0)
+					out.write(buf, 0, n);
+			} while (!deflater.finished());
 		}
 	}
 
-- 
1.6.2.1.471.g682837
