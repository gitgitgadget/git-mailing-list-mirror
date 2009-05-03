From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 8/6] Fix zero context insert and delete hunk headers
	to match CGit
Date: Sat, 2 May 2009 17:14:23 -0700
Message-ID: <20090503001423.GO23604@spearce.org>
References: <20090503000540.GN23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 03 02:14:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0PLk-0000Ni-36
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 02:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbZECAOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 20:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbZECAOY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 20:14:24 -0400
Received: from george.spearce.org ([209.20.77.23]:53573 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbZECAOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 20:14:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F030238081; Sun,  3 May 2009 00:14:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090503000540.GN23604@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118152>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  "Shawn O. Pearce" <spearce@spearce.org> wrote:
  >  This test currently fails because it shows the difference between
  >  the way CGit and JGit number a zero context line patch.
  > 
  >  Either we hack JGit to match CGit here

  And here is that hack.  It just feels wrong to me that I need
  to subtract 1 from the Edit region's line numbers, *only* when
  context is 0, in order to get the same output as CGit.

 .../src/org/spearce/jgit/diff/DiffFormatter.java   |   23 ++++++++++++++++---
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
index 97db9a2..9930904 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
@@ -120,7 +120,7 @@ private void formatEdits(final OutputStream out, final RawText a,
 			final int aEnd = Math.min(a.size(), endEdit.getEndA() + context);
 			final int bEnd = Math.min(b.size(), endEdit.getEndB() + context);
 
-			writeHunkHeader(out, aCur, aEnd, bCur, bEnd, curIdx == 0);
+			writeHunkHeader(out, aCur, aEnd, bCur, bEnd, curEdit, curIdx == 0);
 
 			while (aCur < aEnd || bCur < bEnd) {
 				if (aCur < curEdit.getBeginA() || endIdx + 1 < curIdx) {
@@ -141,9 +141,24 @@ private void formatEdits(final OutputStream out, final RawText a,
 		}
 	}
 
-	private void writeHunkHeader(final OutputStream out, final int aCur,
-			final int aEnd, final int bCur, final int bEnd,
-			final boolean firstHunk) throws IOException {
+	private void writeHunkHeader(final OutputStream out, int aCur, int aEnd,
+			int bCur, int bEnd, final Edit curEdit, final boolean firstHunk)
+			throws IOException {
+		if (context == 0) {
+			switch (curEdit.getType()) {
+			case INSERT:
+				aCur--;
+				aEnd--;
+				break;
+			case DELETE:
+				bCur--;
+				bEnd--;
+				break;
+			default:
+				break;
+			}
+		}
+
 		out.write('@');
 		out.write('@');
 		if (firstHunk) {
-- 
1.6.3.rc4.190.g4648
