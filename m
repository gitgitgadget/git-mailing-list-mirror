From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Method ignores results of InputStream.skip()
Date: Tue, 28 Apr 2009 01:10:35 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A2878002FCE7EA@dewdfe18.wdf.sap.corp>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E9@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:10:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZyL-0005Be-0z
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZD0XKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbZD0XKk
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:10:40 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:33097 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZD0XKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 19:10:39 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n3RNAac7015588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Apr 2009 01:10:36 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7E9@dewdfe18.wdf.sap.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH JGIT] Method ignores results of InputStream.skip()
Thread-Index: AcnHjEysWP+qTjB1Tm2zGBLNNuNqlAAAC8hQAAAVRmAAABVskA==
X-OriginalArrivalTime: 27 Apr 2009 23:10:36.0022 (UTC) FILETIME=[5F50D960:01C9C78D]
X-Scanner: Virus Scanner virwal04
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117730>

This method ignores the return value of java.io.InputStream.skip() which
can skip multiple bytes.  If the return value is not
checked, the caller will not be able to correctly handle the case where
fewer bytes were skipped than the caller requested.
This is a particularly insidious kind of bug, because in many programs,
skips from input streams usually do skip the full amount
of data requested, causing the program to fail only sporadically. With
Buffered streams, however, skip() will only skip data
in the buffer, and will routinely fail to skip the requested number of
bytes.

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
---
 .../jgit/transport/BundleFetchConnection.java      |   16
++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git
a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.
java
b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.
java
index 40bf7db..642c984 100644
---
a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.
java
+++
b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.
java
@@ -39,6 +39,7 @@
 package org.spearce.jgit.transport;
 
 import java.io.BufferedInputStream;
+import java.io.EOFException;
 import java.io.IOException;
 import java.io.InputStream;
 import java.util.ArrayList;
@@ -139,12 +140,23 @@ private String readLine(final byte[] hdrbuf)
throws IOException {
 		while (lf < cnt && hdrbuf[lf] != '\n')
 			lf++;
 		bin.reset();
-		bin.skip(lf);
+		skipFully(bin, lf);
 		if (lf < cnt && hdrbuf[lf] == '\n')
-			bin.skip(1);
+			skipFully(bin, 1);
 		return RawParseUtils.decode(Constants.CHARSET, hdrbuf,
0, lf);
 	}
 
+	// skip given number of bytes on InputStream respecting return
value of InputStream.skip()
+	static private void skipFully(InputStream in, long nBytes)
throws IOException {
+		long remaining = nBytes;
+		while (remaining != 0) {
+			long skipped = in.skip(remaining);
+			if (skipped == 0) // EOF
+				throw new EOFException();
+			remaining -= skipped;
+		}
+	}
+	
 	public boolean didFetchTestConnectivity() {
 		return false;
 	}
-- 
1.6.2.2.1669.g7eaf8
