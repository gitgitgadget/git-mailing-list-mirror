From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/10] Reuse the magic tOc constant for pack index headers
Date: Mon, 23 Jun 2008 22:10:04 -0400
Message-ID: <1214273408-70793-7-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
 <1214273408-70793-4-git-send-email-spearce@spearce.org>
 <1214273408-70793-5-git-send-email-spearce@spearce.org>
 <1214273408-70793-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0X-0005iO-A1
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbYFXCKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbYFXCKl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49773 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbYFXCKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxzE-0001OV-4D; Mon, 23 Jun 2008 22:10:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 000BF20FBC9; Mon, 23 Jun 2008 22:10:33 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 1F56A20FBAE;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-6-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85974>

We need this constant to detect version 2 index files at read time,
but we also need it to create version 2 index files.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackIndex.java        |    3 ++-
 .../src/org/spearce/jgit/lib/PackIndexWriter.java  |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 3935d4f..ef4b13d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -42,6 +42,7 @@ import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
+import java.util.Arrays;
 import java.util.Iterator;
 
 import org.spearce.jgit.util.NB;
@@ -104,7 +105,7 @@ public abstract class PackIndex implements Iterable<PackIndex.MutableEntry> {
 	}
 
 	private static boolean isTOC(final byte[] h) {
-		return h[0] == -1 && h[1] == 't' && h[2] == 'O' && h[3] == 'c';
+		return Arrays.equals(h, PackIndexWriter.TOC);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
index 473e6cf..c9b27d2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
@@ -55,6 +55,9 @@ import org.spearce.jgit.util.NB;
  * to the byte offset within the pack where the object's data can be read.
  */
 public abstract class PackIndexWriter {
+	/** Magic constant indicating post-version 1 format. */
+	protected static final byte[] TOC = { -1, 't', 'O', 'c' };
+
 	/**
 	 * Create a new writer for the oldest (most widely understood) format.
 	 * <p>
-- 
1.5.6.74.g8a5e
