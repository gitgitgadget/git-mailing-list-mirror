From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH] fixed error in whitespace handling of RefDatabase#readLine
Date: Tue, 1 Sep 2009 21:18:52 +0000 (GMT)
Message-ID: <196796.47610.qm@web27808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Spearce <spearce@spearce.org>, robin.rosenberg@dewire.com
X-From: git-owner@vger.kernel.org Tue Sep 01 23:19:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miakm-0004Il-8A
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 23:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbZIAVSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZIAVSv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 17:18:51 -0400
Received: from web27808.mail.ukl.yahoo.com ([217.146.182.13]:31921 "HELO
	web27808.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752014AbZIAVSu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 17:18:50 -0400
Received: (qmail 51074 invoked by uid 60001); 1 Sep 2009 21:18:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1251839932; bh=//gSuJg8seMvEh1MPuyDBC6iEoTHN4tPFqtVQRLS11A=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type; b=VLM92tldFqW8jH2QOqiX3DImTjpbMuy4RKF3wAV7MNmyNfMwEWDAkPd4TUIoX6LSFbezNhWDqjoGONaVqXZjav+T6iw9L/eDVSaGNfrnW3BTdjYq/JmxW67IUgyZRZqZCzweC1UogWxci+Bm1KmkigiS3UX1QNLqtTu+d2ZLg1k=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type;
  b=kcV4cQwkiJeRML5fbnPQZ1Lw2aNXbmBheVWc9jGnTS1E+V/+Tir66/3nYlTIRN8wF5+wbd8PKlzKK/WJxyJeVxxU1pqosCfS3IQHZmy5u8mQGNCx1PPZRUhKYH3f44QTHZvyjpUr0esG0+n8JqJ+juJy07aS0RbPCso6IfYJdcM=;
X-YMail-OSG: b5nbAQwVM1mlPAVqdyaMSEm396b9pREfaTuEA_FlhfRymIkTij2h8TRciRTz11hc0QJrgUNp5i0Ib09Ha67QJvIDJ2k4cwLh0jhisTUwjnEm.Mc7CbdDqTemGzSaWilZYf389zdof_xeIdO3V4pjZVIr8yjFjkQGY7e2weergBdex72_8mSWJC750x9pSVY13Y0R5GekePI1QZjMxwFemMAP0gS93I4Y_44_qkkHMUMDVeKlt2xO46hsDBS3V18ZS_Tua3MzqkXS0qcRjThhyL8u4ur6uxUww7aL65gYQvU1Qf0Ne3vnBcUWb8T3_A--
Received: from [62.47.156.223] by web27808.mail.ukl.yahoo.com via HTTP; Tue, 01 Sep 2009 21:18:52 GMT
X-Mailer: YahooMailRC/1358.27 YahooMailWebService/0.7.338.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127558>

jgit fails with "cannot checkout; no HEAD advertised by remote"
in guessHEAD on some repositories.

JGIT used to work on my test repo for the maven-scm-providers-git until a few weeks. I tracked it down with git bisect and found commit 72b1f0d334729a49cc52e4762093148be62bea39 to be the bad one.

I glimpsed at the code and it appears that the new code in RefDatabase#readLine is not Windows CR+LF aware. (This hits me although I use Linux because our SVN at apache.org seems to have it stored with CR+LF.)

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
-        if (buf[n - 1] == '\n')
+        
+        // remove trailing whitespaces
+        while (n > 0 && Character.isWhitespace(buf[n - 1])) {
             n--;
+        }
+        
         return RawParseUtils.decode(buf, 0, n);
     }
 
-- 
1.6.2.5


      
