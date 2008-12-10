From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/6] Simplify RawParseUtils next and nextLF loops
Date: Wed, 10 Dec 2008 14:05:47 -0800
Message-ID: <1228946751-12708-3-git-send-email-spearce@spearce.org>
References: <1228946751-12708-1-git-send-email-spearce@spearce.org>
 <1228946751-12708-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:08:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXDL-00031R-La
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039AbYLJWF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755517AbYLJWF5
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:05:57 -0500
Received: from george.spearce.org ([209.20.77.23]:39011 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbYLJWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:05:54 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6190138239; Wed, 10 Dec 2008 22:05:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3FBFE38210;
	Wed, 10 Dec 2008 22:05:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228946751-12708-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102729>

We always need ptr + 1 after we read the current position,
so we might as well do the much more common foo[ptr++]. A
good JIT would be more likely to optimize this case over
the weird else branch we had.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 10c2239..5a40911 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -221,10 +221,8 @@ public static final int parseTimeZoneOffset(final byte[] b, int ptr) {
 	public static final int next(final byte[] b, int ptr, final char chrA) {
 		final int sz = b.length;
 		while (ptr < sz) {
-			if (b[ptr] == chrA)
-				return ptr + 1;
-			else
-				ptr++;
+			if (b[ptr++] == chrA)
+				return ptr;
 		}
 		return ptr;
 	}
@@ -260,11 +258,9 @@ public static final int nextLF(final byte[] b, int ptr) {
 	public static final int nextLF(final byte[] b, int ptr, final char chrA) {
 		final int sz = b.length;
 		while (ptr < sz) {
-			final byte c = b[ptr];
+			final byte c = b[ptr++];
 			if (c == chrA || c == '\n')
-				return ptr + 1;
-			else
-				ptr++;
+				return ptr;
 		}
 		return ptr;
 	}
-- 
1.6.1.rc2.299.gead4c
