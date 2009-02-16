From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH 1/1] Invalid test preventing a build using maven
Date: Mon, 16 Feb 2009 20:46:31 +0300
Message-ID: <85647ef50902160946m480542a3m1511366f6cafe04e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 18:48:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7Zb-0003YL-Af
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbZBPRqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZBPRqe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:46:34 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38372 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZBPRqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 12:46:34 -0500
Received: by bwz5 with SMTP id 5so3259893bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=G3A02YJDtZ/cyUaRHNxtoPIiSUs77qHzknno3o941z0=;
        b=r98eOA8EVxtJdDqfJrBilnj2RknCmrpsWBt1QlPfj3u27oEbxcTw6mQ3X5gR5Tuh3r
         OjLfxvNONaBjIQutLdJ62ZKB5fmZXHv1+lURhgauGjPjoWAdulaUiEMm2kf45MS1EEa3
         uEmFJJoYs+zBSFUb0fJAdOLXDGbK0kD46CRHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=eKkHSpLuZ5B4LU2eGa0dogfsO1lMILT/lgYgj3Xo7ZTo/ShEjHu0WCQ0veGO++muXd
         cCY07JHjgjj806TQOUOIrvkhgaAh9MleTi0Gh8XpHY0gm5JOmfJYeqKqnLgGdXUBEABm
         oy85PU0GA6Zo3hI5lYZL+xM2jsZcscgjtPO10=
Received: by 10.180.224.13 with SMTP id w13mr537416bkg.160.1234806391753; Mon, 
	16 Feb 2009 09:46:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110218>

I have tried to build jgit using maven on Windows and build failed due
to the failed test. The test
QuotedStringGitPathStyleTest.testDequote_OctalAll was dependent on the
system charset. If the test is run with -Dfile.encoding=Cp1251 under
eclipse, it failed as well.

This was cased that by the fact that corresponding test generated
invalid UTF-8 character sequence for code points U+80 - U+FF. In that
case the method RawParseUtils.decodeNoFallback fall backs to the
default system encoding that is Cp1251 in my environment.

The attached patch ensures that correct UTF-8 character sequence is
used in the test.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringGitPathStyleTest.java
b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringGitPathStyleTest.java
index 54fbd31..7d29f21 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringGitPathStyleTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/QuotedStringGitPathStyleTest.java
@@ -127,13 +127,22 @@ public void testDequote_NamedEscapes() {
 	}

 	public void testDequote_OctalAll() {
-		for (int i = 0; i < 256; i++) {
-			String s = Integer.toOctalString(i);
-			while (s.length() < 3) {
-				s = "0" + s;
-			}
-			assertDequote("" + (char) i, "\\" + s);
+		for (int i = 0; i < 127; i++) {
+			assertDequote("" + (char) i, octalEscape(i));
 		}
+		for (int i = 128; i < 256; i++) {
+			int f = 0xC0 | (i >> 6);
+			int s = 0x80 | (i & 0x3f);
+			assertDequote("" + (char) i, octalEscape(f)+octalEscape(s));
+		}
+	}
+
+	private String octalEscape(int i) {
+		String s = Integer.toOctalString(i);
+		while (s.length() < 3) {
+			s = "0" + s;
+		}
+		return "\\"+s;
 	}

 	public void testQuote_OctalAll() {
