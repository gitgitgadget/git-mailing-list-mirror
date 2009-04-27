From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Computation of average could overflow
Date: Tue, 28 Apr 2009 01:02:55 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 04:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyci9-00037L-SM
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 04:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbZD1CGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 22:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756964AbZD1CGI
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 22:06:08 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.171]:39394 "EHLO
	smtpde01.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbZD1CGH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 22:06:07 -0400
Received: from mail.sap.corp
	by smtpde01.sap-ag.de (26) with ESMTP id n3RN2vSC013399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Apr 2009 01:02:57 +0200 (MEST)
Received: from dewdfe1i3.wdf.sap.corp (dewdfe1i3.wdf.sap.corp [10.17.149.41])
	by mail.sap.corp (mail03-25) with ESMTP id n3RN2oZK023049;
	Tue, 28 Apr 2009 01:02:57 +0200 (MEST)
Received: from dewdfe18.wdf.sap.corp ([10.21.20.140]) by dewdfe1i3.wdf.sap.corp with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 01:02:56 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH JGIT] Computation of average could overflow
Thread-Index: AcnHjEysWP+qTjB1Tm2zGBLNNuNqlA==
X-OriginalArrivalTime: 27 Apr 2009 23:02:56.0635 (UTC) FILETIME=[4D7FF4B0:01C9C78C]
X-Scanner: Virus Scanner virwal08
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117741>

The code computes the average of two integers using either division or
signed right shift, and then uses the result as the
index of an array. If the values being averaged are very large, this can
overflow (resulting in the computation of a negative
average). Assuming that the result is intended to be nonnegative, you
can use an unsigned right shift instead. In other
words, rather that using (low+high)/2, use (low+high) >>> 1

This bug exists in many earlier implementations of binary search and
merge sort. Martin Buchholz found and fixed it
(http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6412541) in the JDK
libraries, and Joshua Bloch widely publicized
the bug pattern
(http://googleresearch.blogspot.com/2006/06/extra-extra-read-all-about-i
t-nearly.html).

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |    2 +-
 .../src/org/spearce/jgit/lib/Tree.java             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git
a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 58da014..fa906fa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -593,7 +593,7 @@ int findEntry(final byte[] p, final int pLen) {
 		int low = 0;
 		int high = entryCnt;
 		do {
-			int mid = (low + high) >> 1;
+			int mid = (low + high) >>> 1;
 			final int cmp = cmp(p, pLen,
sortedEntries[mid]);
 			if (cmp < 0)
 				high = mid;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
index 0ecd04d..ff9e666 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
@@ -136,7 +136,7 @@ private static final int binarySearch(final
TreeEntry[] entries,
 		int high = entries.length;
 		int low = 0;
 		do {
-			final int mid = (low + high) / 2;
+			final int mid = (low + high) >>> 1;
 			final int cmp =
compareNames(entries[mid].getNameUTF8(), nameUTF8,
 					nameStart, nameEnd,
TreeEntry.lastChar(entries[mid]), nameUTF8last);
 			if (cmp < 0)
-- 
1.6.2.2.1669.g7eaf8
