From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/10 v2] Reuse the magic tOc constant for pack index headers
Date: Wed, 25 Jun 2008 00:01:48 -0400
Message-ID: <20080625040148.GZ11793@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org> <1214273408-70793-2-git-send-email-spearce@spearce.org> <1214273408-70793-3-git-send-email-spearce@spearce.org> <1214273408-70793-4-git-send-email-spearce@spearce.org> <1214273408-70793-5-git-send-email-spearce@spearce.org> <1214273408-70793-6-git-send-email-spearce@spearce.org> <1214273408-70793-7-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMDv-0002Rz-Sn
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbYFYEBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbYFYEBy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:01:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35929 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbYFYEBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:01:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBMCP-0003wX-9H; Wed, 25 Jun 2008 00:01:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6EE1320FBAE; Wed, 25 Jun 2008 00:01:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1214273408-70793-7-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86213>

We need this constant to detect version 2 index files at read time,
but we also need it to create version 2 index files.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Fixed isTOC test to return true when h.length == 8, which
 is always the case as it has both the TOC and the version.

 Also rebased into my branch:
 
   repo.or.cz:/srv/git/egit/spearce.git index-v2

 With this patch in the series all tests pass again.

 .../src/org/spearce/jgit/lib/PackIndex.java        |    6 +++++-
 .../src/org/spearce/jgit/lib/PackIndexWriter.java  |    3 +++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 3935d4f..c5718fa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -104,7 +104,11 @@ public abstract class PackIndex implements Iterable<PackIndex.MutableEntry> {
 	}
 
 	private static boolean isTOC(final byte[] h) {
-		return h[0] == -1 && h[1] == 't' && h[2] == 'O' && h[3] == 'c';
+		final byte[] toc = PackIndexWriter.TOC;
+		for (int i = 0; i < toc.length; i++)
+			if (h[i] != toc[i])
+				return false;
+		return true;
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

-- 
Shawn.
