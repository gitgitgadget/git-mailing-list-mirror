From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 1/2] fixed error in whitespace handling of RefDatabase#readLine
Date: Wed,  2 Sep 2009 20:00:27 +0200
Message-ID: <1251914428-1687-1-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 02 20:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiuEe-00023n-52
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 20:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbZIBSGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 14:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbZIBSGz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 14:06:55 -0400
Received: from n65.bullet.mail.sp1.yahoo.com ([98.136.44.190]:35110 "HELO
	n65.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752540AbZIBSGy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 14:06:54 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Sep 2009 14:06:54 EDT
Received: from [216.252.122.219] by n65.bullet.mail.sp1.yahoo.com with NNFMP; 02 Sep 2009 18:00:03 -0000
Received: from [68.142.230.28] by t4.bullet.sp1.yahoo.com with NNFMP; 02 Sep 2009 18:00:03 -0000
Received: from [216.252.111.167] by t1.bullet.re2.yahoo.com with NNFMP; 02 Sep 2009 18:00:03 -0000
Received: from [127.0.0.1] by omp102.mail.re3.yahoo.com with NNFMP; 02 Sep 2009 18:00:02 -0000
X-Yahoo-Newman-Id: 992232.84221.bm@omp102.mail.re3.yahoo.com
Received: (qmail 90079 invoked from network); 2 Sep 2009 18:00:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
  b=Z5nLQfOrp2g8sPTY33FW2jLN5xghILBdavuoMurZUO01d8hNpsgD05Wv4kYStUgaZ6ldCoG8YCShrAlgWDmfnTEKApISQmefFmAzMXSzeEecyxIXDdXQ2PRUh+bPqTSPeXqq9V2P/eJEuRXgfCiSAJ5nLFhccG7hxVfWp19OZaY=  ;
Received: from unknown (HELO localhost.localdomain) (struberg@62.178.39.60 with login)
  by smtp109.plus.mail.re1.yahoo.com with SMTP; 2 Sep 2009 18:00:02 -0000
X-Yahoo-SMTP: 2UDFDYyswBBwji.xRJsDPvpy2xFg
X-YMail-OSG: D0ZD4WIVM1kYtwZkgqeLsR1gOCTBUc77dp6E.hKrvsZ_UNj1U9Cz6Q3CDmBomSBAPFpn4UQQo5i56Ewj_tC835NOZ2qapRDvm8mhy4ak3qdi7utRf6XtJw6Pk52EmfXaeNDZ6hFP46porTN4Ge6cc9GC6aXeHSPjqut7MgX87GTBUtNcpCxBPyfC0MB0ZSHPhQ7OodxZSQcLxY5e4zQyvgjf4OMXXqlUpw..aJvSdjnN.brrE8RR6K.ZHKctNr5onmYtOiyKfIj3QdvJMXEY.gzkgOiM1v4VvESS.h0s98464RdQlLXRPh6Vqdiy23donvnFB0.Z55b4ImvMXHRtaGkEkO_0ofswYHsga8LkRw--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127624>

jgit fails with "cannot checkout; no HEAD advertised by remote"
in guessHEAD on some repositories.

JGIT used to work on my test repo for the maven-scm-providers-git until a few weeks. 
I tracked it down with git bisect and found commit 
72b1f0d334729a49cc52e4762093148be62bea39 to be the bad one.

I glimpsed at the code and it appears that the new code in 
RefDatabase#readLine is not Windows CR+LF aware. 
(This hits me although I use Linux because our SVN at 
apache.org seems to have it stored with CR+LF.)

Fixed by subsequently removing all Character.isWhitespaceChar() from the end of the buffer

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index ba4b654..477dc62 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -500,8 +500,12 @@ private static String readLine(final File file)
 		int n = buf.length;
 		if (n == 0)
 			return null;
-		if (buf[n - 1] == '\n')
+		
+		// remove trailing whitespaces
+		while (n > 0 && Character.isWhitespace(buf[n - 1])) {
 			n--;
+		}
+		
 		return RawParseUtils.decode(buf, 0, n);
 	}
 
-- 
1.6.2.5
