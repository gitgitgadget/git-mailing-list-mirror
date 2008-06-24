From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/10] Default IndexPack to honor pack.indexversion configuration
Date: Mon, 23 Jun 2008 22:10:08 -0400
Message-ID: <1214273408-70793-11-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
 <1214273408-70793-4-git-send-email-spearce@spearce.org>
 <1214273408-70793-5-git-send-email-spearce@spearce.org>
 <1214273408-70793-6-git-send-email-spearce@spearce.org>
 <1214273408-70793-7-git-send-email-spearce@spearce.org>
 <1214273408-70793-8-git-send-email-spearce@spearce.org>
 <1214273408-70793-9-git-send-email-spearce@spearce.org>
 <1214273408-70793-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0a-0005iO-61
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYFXCKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbYFXCKw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49791 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbYFXCKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxzQ-0001PR-6q; Mon, 23 Jun 2008 22:10:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id D313820FBAE; Mon, 23 Jun 2008 22:10:46 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 328C420FBD3;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-10-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85975>

Users may already desire to create only v2 pack index files, as
the extra CRC code makes repacking faster due to quicker delta
reuse code paths being available.  However we still must default
to version 0 to select oldest version available to improve our
changes of being compatible with really old Git executables.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/CoreConfig.java       |   11 +++++++++++
 .../src/org/spearce/jgit/transport/IndexPack.java  |    4 +++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
index 01d4210..2dd8aea 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
@@ -48,8 +48,11 @@ public class CoreConfig {
 
 	private final int compression;
 
+	private final int packIndexVersion;
+
 	CoreConfig(final RepositoryConfig rc) {
 		compression = rc.getInt("core", "compression", DEFAULT_COMPRESSION);
+		packIndexVersion = rc.getInt("pack", "indexversion", 0);
 	}
 
 	/**
@@ -59,4 +62,12 @@ public class CoreConfig {
 	public int getCompression() {
 		return compression;
 	}
+
+	/**
+	 * @return the preferred pack index file format; 0 for oldest possible.
+	 * @see org.spearce.jgit.transport.IndexPack
+	 */
+	public int getPackIndexVersion() {
+		return packIndexVersion;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 06ef7cc..8083cc8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -102,7 +102,9 @@ public class IndexPack {
 		final File base;
 
 		base = new File(objdir, n.substring(0, n.length() - suffix.length()));
-		return new IndexPack(db, is, base);
+		final IndexPack ip = new IndexPack(db, is, base);
+		ip.setIndexVersion(db.getConfig().getCore().getPackIndexVersion());
+		return ip;
 	}
 
 	private final Repository repo;
-- 
1.5.6.74.g8a5e
