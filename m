From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 2/2] improve the handling of empty lines
Date: Wed,  2 Sep 2009 20:00:28 +0200
Message-ID: <1251914428-1687-2-git-send-email-struberg@yahoo.de>
References: <1251914428-1687-1-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 02 20:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiuDv-0001os-2W
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 20:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZIBSGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 14:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbZIBSGL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 14:06:11 -0400
Received: from n9.bullet.re3.yahoo.com ([68.142.237.94]:23212 "HELO
	n9.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753122AbZIBSGK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 14:06:10 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Sep 2009 14:06:10 EDT
Received: from [68.142.237.87] by n9.bullet.re3.yahoo.com with NNFMP; 02 Sep 2009 18:00:04 -0000
Received: from [66.196.97.156] by t3.bullet.re3.yahoo.com with NNFMP; 02 Sep 2009 18:00:04 -0000
Received: from [127.0.0.1] by omp209.mail.re3.yahoo.com with NNFMP; 02 Sep 2009 18:00:04 -0000
X-Yahoo-Newman-Id: 289449.51808.bm@omp209.mail.re3.yahoo.com
Received: (qmail 90107 invoked from network); 2 Sep 2009 18:00:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=yvxV4tUwmzWbEEBcNyf0QOaVjeRhTyI49Mh9oNxYCpsZYY2nicJgDXbs/vytbnw6Etzr3Rrq+nEwhGwVNJ1s7J3ScwyBY5QNYSfClsi+6VyggETGiG7f9tbZJj5FlinfZURx9tmW2Qdo4LyhAoN7ASJnEDc3eKiJvGBk0ApqAIc=  ;
Received: from unknown (HELO localhost.localdomain) (struberg@62.178.39.60 with login)
  by smtp109.plus.mail.re1.yahoo.com with SMTP; 2 Sep 2009 18:00:03 -0000
X-Yahoo-SMTP: 2UDFDYyswBBwji.xRJsDPvpy2xFg
X-YMail-OSG: cyVP.fgVM1nH6rSTXoOOKxrmWKMk4rBo2_8KBbZfddOk1MSnn..n4evjPUMpl.N6HO59gIdp7YBCWlvBIKvKO4q3GZk72M6UPDGSdzrNn5Jb2kFrLtpEuAoyrhigYp3feQ8Y9f14vofyrjtll7ACSBNRtugYR_soVSz8MudilqAzRQIRZmydHpizxI0pWNve3pykMgddFSgjekRxKWn4EPVjafzsTzev7ks_qOJwd6OY9RNdnNwkaDxWVHikiR_PKQMCc.lxEyA_LBrPk3EEHHbSXyj5lSAyx2Lk8mAgmb028qNwwVOvLIjphTx1naXfgwbCjw13ObYHOvOO6jVNase41EJ9AOMYAlrybV0m_w--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1251914428-1687-1-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127623>

Move the 'empty-line' check in RefDatabase#readLine down a bit after we removed all the whitespaces.
This way we consistently return null regardless if the line 
is empty or if it does only contain whitespaces.

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 477dc62..acc835b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -498,14 +498,15 @@ private static String readLine(final File file)
 			throws FileNotFoundException, IOException {
 		final byte[] buf = NB.readFully(file, 4096);
 		int n = buf.length;
-		if (n == 0)
-			return null;
 		
 		// remove trailing whitespaces
 		while (n > 0 && Character.isWhitespace(buf[n - 1])) {
 			n--;
 		}
-		
+
+		if (n == 0)
+			return null;
+
 		return RawParseUtils.decode(buf, 0, n);
 	}
 
-- 
1.6.2.5
