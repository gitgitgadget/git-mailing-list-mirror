From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH v2] Fixed QuotedStringGitPathStyleTest.testDequote_OctalAll 
	test that generated incorrect UTF-8 escape sequences
Date: Mon, 16 Feb 2009 21:50:21 +0300
Message-ID: <85647ef50902161050i43b478d4kb7faaa211dee727d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 19:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ8ZM-0002rF-2l
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbZBPSuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 13:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbZBPSuY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 13:50:24 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:43284 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZBPSuY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 13:50:24 -0500
Received: by bwz5 with SMTP id 5so3309975bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=+ehhzPwyWfHcAaONvdToHU6lPdQQDye56YbpTqlYQyw=;
        b=jjp+2h48kcSn7BdkMCqzI5I++rg1dJPv+M90BtaBLWDhw1i3WjmL9GkUXMwGYZUxEd
         hHIYClLTNJXaLx31ogjtG2vWR0RkvVoeKnGF2h28hMKRv6Zt3ARfyramIW2Rjvi7BChC
         d5LVeLndQ1SoPb9fuTWAKpGXKmm7DnXD1fe4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=EQzSpPgtOLr3h3ghr8PP0CEGd2/yjTrXkXK007Wd/RjnGZ7vi3NwlIYDPIEwSPEJZS
         dVHmvNzugDeUcA+7a7oDWuj+qwQStNPw3DaY+JUOvtUdxIaJq7mF8OUOr6eq97YODRQ6
         uJGgsMKqy3bpgYj8DJLTgNJnJ7lU4bqpdOw5o=
Received: by 10.181.235.6 with SMTP id m6mr790912bkr.190.1234810221930; Mon, 
	16 Feb 2009 10:50:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110228>

The test was failing on the system that use a encoding different
from ISO-8859-1. The reason was that invalid UTF-8 bytes were
generated for codepoints greater than U+7F, and in this case
the method RawParseUtils.decodeNoFallback falls backs to the
default system encoding.

Signed-off-by: Constantine Plotnikov <Constantine.Plotnikov@jetbrains.com>
---

The bug was causing failure for the maven build on the windows
environment that uses Cp1251 as a system encoding. However the test
worked from Eclipse until I have specified jvm option
-Dfile.ecoding=Cp1251, in the test case started to fail in Eclipse as
well.

 .../jgit/util/QuotedStringGitPathStyleTest.java    |   21 ++++++++++++++-----
 1 files changed, 15 insertions(+), 6 deletions(-)

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
-- 
1.6.1.2
