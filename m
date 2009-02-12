From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/9] Arrange pack files in recency order to improve quick hits
Date: Wed, 11 Feb 2009 18:36:55 -0800
Message-ID: <1234406219-19547-6-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
 <1234406219-19547-3-git-send-email-spearce@spearce.org>
 <1234406219-19547-4-git-send-email-spearce@spearce.org>
 <1234406219-19547-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTg-0002tJ-FP
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758324AbZBLCha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756786AbZBLCh3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:29 -0500
Received: from george.spearce.org ([209.20.77.23]:39183 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbZBLChE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:04 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id C060D38221; Thu, 12 Feb 2009 02:37:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9761D38222;
	Thu, 12 Feb 2009 02:37:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109561>

Packs with newer modification dates are more likely to contain data
related to recent commits, and thus will have a better probability
of containing an object we care about when we are looking only at
recent history.

In some cases, this may permit JGit to avoid reading a very large
historical pack's index file into memory if the only data we ever
need is available in newer pack files.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   11 +++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 3542560..7a16bf7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -43,6 +43,7 @@
 import java.io.IOException;
 import java.io.OutputStream;
 import java.util.Collections;
+import java.util.Comparator;
 import java.util.Iterator;
 import java.util.zip.CRC32;
 import java.util.zip.CheckedOutputStream;
@@ -57,10 +58,19 @@
  * objects are similar.
  */
 public class PackFile implements Iterable<PackIndex.MutableEntry> {
+	/** Sorts PackFiles to be most recently created to least recently created. */
+	public static Comparator<PackFile> SORT = new Comparator<PackFile>() {
+		public int compare(final PackFile a, final PackFile b) {
+			return b.packLastModified - a.packLastModified;
+		}
+	};
+
 	private final File idxFile;
 
 	private final WindowedFile pack;
 
+	private int packLastModified;
+
 	private PackIndex loadedIdx;
 
 	private PackReverseIndex reverseIdx;
@@ -75,6 +85,7 @@
 	 */
 	public PackFile(final File idxFile, final File packFile) {
 		this.idxFile = idxFile;
+		this.packLastModified = (int) (packFile.lastModified() >> 10);
 		pack = new WindowedFile(packFile) {
 			@Override
 			protected void onOpen() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b9c7b2e..96c62df 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -823,6 +823,7 @@ public void scanForPacks() {
 			scanForPacks(new File(d, "pack"), p);
 		final PackFile[] arr = new PackFile[p.size()];
 		p.toArray(arr);
+		Arrays.sort(arr, PackFile.SORT);
 		synchronized (this) {
 			packFileList = arr;
 		}
-- 
1.6.2.rc0.204.gf6b427
