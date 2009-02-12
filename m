From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/9] Document why WindowFile's hash is *31
Date: Wed, 11 Feb 2009 18:36:53 -0800
Message-ID: <1234406219-19547-4-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
 <1234406219-19547-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTc-0002tJ-1w
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669AbZBLChK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756571AbZBLChH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:07 -0500
Received: from george.spearce.org ([209.20.77.23]:39176 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbZBLChD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:03 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5723738260; Thu, 12 Feb 2009 02:37:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D420E38211;
	Thu, 12 Feb 2009 02:37:00 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109559>

It doesn't really make sense on its own, but if you know about
the assumption in WindowCache.hash() it all becomes a bit more
clear to the reader.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |    3 +++
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 600ebdf..0b9d20c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -362,6 +362,9 @@ private static void insertLRU(final ByteWindow<?> e) {
 	}
 
 	private static int hash(final WindowedFile wp, final int id) {
+		// wp.hash was already "stirred up" a bit by * 31 when
+		// it was created. Its reasonable to just add here.
+		//
 		return ((wp.hash + id) >>> 1) % cache.length;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 5eb8465..db8ea88 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -88,6 +88,10 @@
 	 */
 	public WindowedFile(final File file) {
 		fPath = file;
+
+		// Multiply by 31 here so we can more directly combine with another
+		// value in WindowCache.hash(), without doing the multiply there.
+		//
 		hash = System.identityHashCode(this) * 31;
 		length = Long.MAX_VALUE;
 	}
-- 
1.6.2.rc0.204.gf6b427
