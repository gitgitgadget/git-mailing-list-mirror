From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 2/3] Fix off by one distance during resolving of
	commit~N
Date: Fri, 12 Sep 2008 12:57:29 +0200
Message-ID: <20080912105729.GB7945@diku.dk>
References: <20080911213927.GA20238@diku.dk> <200809120047.58484.robin.rosenberg.lists@dewire.com> <20080912000007.GA31931@diku.dk> <200809120847.13541.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 12:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6MX-0004JZ-UP
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbYILK5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbYILK5d
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:57:33 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:38786 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501AbYILK5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 06:57:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 5357A52C37B;
	Fri, 12 Sep 2008 12:57:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50iKyCwQWqNG; Fri, 12 Sep 2008 12:57:30 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 10BD552C359;
	Fri, 12 Sep 2008 12:57:30 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 578146DF823; Fri, 12 Sep 2008 12:57:16 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id ED2701A4001; Fri, 12 Sep 2008 12:57:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809120847.13541.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95707>

To be compatible with git-rev-parse, commit~0 should resolve to commit,
commit~1 to commit^, etc.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../org/spearce/jgit/lib/T0008_testparserev.java   |    9 +++++----
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
index 8883b8b..506f51f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
@@ -82,10 +82,11 @@ public void testRef_refname() throws IOException {
 	}
 
 	public void testDistance() throws IOException {
-		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~0").name());
-		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~1").name());
-		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~2").name());
-		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~02").name());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~0").name());
+		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~1").name());
+		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~2").name());
+		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~3").name());
+		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~03").name());
 	}
 
 	public void testTree() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 730a267..894fe3b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -688,7 +688,7 @@ else if (item.equals("")) {
 					throw new RevisionSyntaxException(
 							"Invalid ancestry length", revstr);
 				}
-				while (dist >= 0) {
+				while (dist > 0) {
 					final ObjectId[] parents = ((Commit) ref).getParentIds();
 					if (parents.length == 0) {
 						refId = null;
-- 
1.6.0.1.451.gc8d31

-- 
Jonas Fonseca
