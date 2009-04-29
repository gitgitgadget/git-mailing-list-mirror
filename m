From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/11] Fix more computation of integer average overflows
Date: Wed, 29 Apr 2009 11:54:38 -0700
Message-ID: <1241031288-23437-2-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:55:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwk-0003Rz-WB
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348AbZD2Syx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbZD2Syv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:54:51 -0400
Received: from george.spearce.org ([209.20.77.23]:32870 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbZD2Syu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3544A3806E; Wed, 29 Apr 2009 18:54:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 755F938064;
	Wed, 29 Apr 2009 18:54:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117914>

In 1d99aaab8e364c6ad722437e43c77fd54e13b071 Matthias Sohn pointed
out that (low+high)/2 can overflow, so (low+high)>>>1 is a better
choice when the result will be used as an array index.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Unchanged.

 .../src/org/spearce/jgit/lib/PackIndexV1.java      |    2 +-
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
index fdaa094..0ad29e1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
@@ -129,7 +129,7 @@ long findOffset(final AnyObjectId objId) {
 		int high = data.length / (4 + Constants.OBJECT_ID_LENGTH);
 		int low = 0;
 		do {
-			final int mid = (low + high) / 2;
+			final int mid = (low + high) >>> 1;
 			final int pos = ((4 + Constants.OBJECT_ID_LENGTH) * mid) + 4;
 			final int cmp = objId.compareTo(data, pos);
 			if (cmp < 0)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index eb56ed9..b539547 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -108,7 +108,7 @@ PackIndexV2(final InputStream fd) throws IOException {
 
 			final int intNameLen = (int) nameLen;
 			final byte[] raw = new byte[intNameLen];
-			final int[] bin = new int[intNameLen >> 2];
+			final int[] bin = new int[intNameLen >>> 2];
 			NB.readFully(fd, raw, 0, raw.length);
 			for (int i = 0; i < bin.length; i++)
 				bin[i] = NB.decodeInt32(raw, i << 2);
@@ -212,12 +212,12 @@ boolean hasCRC32Support() {
 
 	private int binarySearchLevelTwo(final AnyObjectId objId, final int levelOne) {
 		final int[] data = names[levelOne];
-		int high = offset32[levelOne].length >> 2;
+		int high = offset32[levelOne].length >>> 2;
 		if (high == 0)
 			return -1;
 		int low = 0;
 		do {
-			final int mid = (low + high) >> 1;
+			final int mid = (low + high) >>> 1;
 			final int mid4 = mid << 2;
 			final int cmp;
 
-- 
1.6.3.rc3.199.g24398
