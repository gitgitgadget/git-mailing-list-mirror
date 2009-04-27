From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Method invokes inefficient Number constructor; use static valueOf instead
Date: Tue, 28 Apr 2009 01:08:17 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A2878002FCE7E9@dewdfe18.wdf.sap.corp>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:08:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZwL-0004YO-Lf
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840AbZD0XIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755151AbZD0XIX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:08:23 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:65393 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbZD0XIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 19:08:22 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2009 19:08:22 EDT
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n3RN8JdE014122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Apr 2009 01:08:19 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH JGIT] Method invokes inefficient Number constructor; use static valueOf instead
Thread-Index: AcnHjEysWP+qTjB1Tm2zGBLNNuNqlAAAC8hQAAAVRmA=
X-OriginalArrivalTime: 27 Apr 2009 23:08:18.0506 (UTC) FILETIME=[0D5992A0:01C9C78D]
X-Scanner: Virus Scanner virwal02
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117728>

Using new Integer(int) is guaranteed to always result in a new object
whereas Integer.valueOf(int) allows caching of values
to be done by the compiler, class library, or JVM. Using of cached
values avoids object allocation and the code will be faster.

Values between -128 and 127 are guaranteed to have corresponding cached
instances and using valueOf is approximately
3.5 times faster than using constructor. For values outside the constant
range the performance of both styles is the same.

Unless the class must be compatible with JVMs predating Java 1.5, use
either autoboxing or the valueOf() method when
creating instances of Long, Integer, Short, Character, and Byte.

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git
a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index e0e4855..04ef59d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -383,7 +383,7 @@ private void resolveDeltas(final ProgressMonitor
progress)
 	private void resolveDeltas(final PackedObjectInfo oe) throws
IOException {
 		final int oldCRC = oe.getCRC();
 		if (baseById.containsKey(oe)
-				|| baseByPos.containsKey(new
Long(oe.getOffset())))
+				||
baseByPos.containsKey(Long.valueOf(oe.getOffset())))
 			resolveDeltas(oe.getOffset(), oldCRC,
Constants.OBJ_BAD, null, oe);
 	}
 
@@ -448,7 +448,7 @@ private void resolveDeltas(final long pos, final int
oldCRC, int type,
 	private void resolveChildDeltas(final long pos, int type, byte[]
data,
 			PackedObjectInfo oe) throws IOException {
 		final ArrayList<UnresolvedDelta> a =
baseById.remove(oe);
-		final ArrayList<UnresolvedDelta> b =
baseByPos.remove(new Long(pos));
+		final ArrayList<UnresolvedDelta> b =
baseByPos.remove(Long.valueOf(pos));
 		int ai = 0, bi = 0;
 		if (a != null && b != null) {
 			while (ai < a.size() && bi < b.size()) {
@@ -679,7 +679,7 @@ private void indexOneObject() throws IOException {
 				ofs <<= 7;
 				ofs += (c & 127);
 			}
-			final Long base = new Long(pos - ofs);
+			final Long base = Long.valueOf(pos - ofs);
 			ArrayList<UnresolvedDelta> r =
baseByPos.get(base);
 			if (r == null) {
 				r = new ArrayList<UnresolvedDelta>(8);
-- 
1.6.2.2.1669.g7eaf8
