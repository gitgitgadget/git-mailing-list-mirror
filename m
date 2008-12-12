From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/15] Correct use of TemporaryBuffer in Patch
Date: Thu, 11 Dec 2008 18:46:07 -0800
Message-ID: <1229049981-14152-2-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4v-00057A-7v
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbYLLCq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbYLLCqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:25 -0500
Received: from george.spearce.org ([209.20.77.23]:41569 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779AbYLLCqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:23 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 36A3638221; Fri, 12 Dec 2008 02:46:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E0AB938200;
	Fri, 12 Dec 2008 02:46:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102874>

We need to destroy the buffer in case it created a
temporary file to hold the content.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/Patch.java          |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 165058d..d59635a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -105,9 +105,13 @@ public void parse(final InputStream is) throws IOException {
 
 	private static byte[] readFully(final InputStream is) throws IOException {
 		final TemporaryBuffer b = new TemporaryBuffer();
-		b.copy(is);
-		final byte[] buf = b.toByteArray();
-		return buf;
+		try {
+			b.copy(is);
+			b.close();
+			return b.toByteArray();
+		} finally {
+			b.destroy();
+		}
 	}
 
 	/**
-- 
1.6.1.rc2.306.ge5d5e
