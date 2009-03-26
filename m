From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Write the pack header in one shot
Date: Wed, 25 Mar 2009 18:21:54 -0700
Message-ID: <1238030515-31768-4-git-send-email-spearce@spearce.org>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org>
 <1238030515-31768-2-git-send-email-spearce@spearce.org>
 <1238030515-31768-3-git-send-email-spearce@spearce.org>
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 02:23:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmeJk-0001u1-G5
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 02:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbZCZBWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 21:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755170AbZCZBWH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 21:22:07 -0400
Received: from george.spearce.org ([209.20.77.23]:40183 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbZCZBV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 21:21:59 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id CD66038221; Thu, 26 Mar 2009 01:21:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E80B338215;
	Thu, 26 Mar 2009 01:21:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
In-Reply-To: <1238030515-31768-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114700>

Instead of making 3 individual write calls of 4 bytes each, write
the entire header as a single 12 byte buffer.  Its also a little
bit easier to follow the final code, that these items appear at
the 0/4/8 offsets within the 12 byte long header.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index cfec35c..2f34255 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -644,13 +644,10 @@ private void selectObjectReuseForObject(final ObjectToPack otp,
 	}
 
 	private void writeHeader() throws IOException {
-		out.write(Constants.PACK_SIGNATURE);
-
-		NB.encodeInt32(buf, 0, PACK_VERSION_GENERATED);
-		out.write(buf, 0, 4);
-
-		NB.encodeInt32(buf, 0, getObjectsNumber());
-		out.write(buf, 0, 4);
+		System.arraycopy(Constants.PACK_SIGNATURE, 0, buf, 0, 4);
+		NB.encodeInt32(buf, 4, PACK_VERSION_GENERATED);
+		NB.encodeInt32(buf, 8, getObjectsNumber());
+		out.write(buf, 0, 12);
 	}
 
 	private void writeObjects() throws IOException {
-- 
1.6.2.1.471.g682837
