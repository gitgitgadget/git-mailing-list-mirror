From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Method ignores results of InputStream.skip()
Date: Wed, 29 Apr 2009 00:26:15 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A287800302A241@dewdfe18.wdf.sap.corp>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E9@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7EA@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 00:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyvkt-0005vd-FC
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 00:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbZD1W0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbZD1W0P
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 18:26:15 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.171]:51304 "EHLO
	smtpde01.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbZD1W0O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 18:26:14 -0400
Received: from mail.sap.corp
	by smtpde01.sap-ag.de (26) with ESMTP id n3SMQAgV001662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Apr 2009 00:26:10 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7EA@dewdfe18.wdf.sap.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH JGIT] Method ignores results of InputStream.skip()
Thread-Index: AcnHjEysWP+qTjB1Tm2zGBLNNuNqlAAAC8hQAAAVRmAAABVskAAwuh9w
X-OriginalArrivalTime: 28 Apr 2009 22:26:10.0179 (UTC) FILETIME=[54C33D30:01C9C850]
X-Scanner: Virus Scanner virwal05
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117823>

This method ignores the return value of java.io.InputStream.skip() which can skip multiple bytes.  If the return value is not checked, the caller will not be able to correctly handle the case where fewer bytes were skipped than the caller requested. This is a particularly insidious kind of bug, because in many programs, skips from input streams usually do skip the full amount of data requested, causing the program to fail only sporadically. With buffered streams, however, skip() will only skip data in the buffer, and will routinely fail to skip the requested number of bytes.

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
---
hopefully this time Exchange server doesn't mangle the patch

 .../jgit/transport/BundleFetchConnection.java      |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
index 40bf7db..2e2977e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
@@ -60,6 +60,7 @@
 import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.util.NB;
 import org.spearce.jgit.util.RawParseUtils;
 
 /**
@@ -139,9 +140,9 @@ private String readLine(final byte[] hdrbuf) throws IOException {
 		while (lf < cnt && hdrbuf[lf] != '\n')
 			lf++;
 		bin.reset();
-		bin.skip(lf);
+		NB.skipFully(bin, lf);
 		if (lf < cnt && hdrbuf[lf] == '\n')
-			bin.skip(1);
+			NB.skipFully(bin, 1);
 		return RawParseUtils.decode(Constants.CHARSET, hdrbuf, 0, lf);
 	}
 
-- 
1.6.2.2.1669.g7eaf8
