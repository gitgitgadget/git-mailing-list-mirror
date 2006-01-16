From: Linus Torvalds <torvalds@osdl.org>
Subject: git-mailinfo: cut lines at ^M
Date: Mon, 16 Jan 2006 11:13:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601161104070.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyZnD-0003fw-Ed
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 20:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWAPTNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 14:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWAPTNZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 14:13:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65412 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751162AbWAPTNY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 14:13:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0GJDJDZ008802
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Jan 2006 11:13:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0GJDFMx001836;
	Mon, 16 Jan 2006 11:13:17 -0800
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14755>


This changes "eatspace()" to cut lines at the first ^M (\r, CR) character.

Normally it should make no difference at all, since even if you have a 
non-UNIX CR/LF end-of-line, it would have removed the ^M at the end of the 
line as whitespace.

The main reason for this patch is that I seem to have something buggy in 
my mail path (possibly fetchmail) which very occasionally causes the mail 
headers to have an appended "^M)" line. This silly thing works around it, 
and shouldn't hurt anything else.

The alternative would be to simply disallow control characters in the 
commit message (so that I would not commit these things by mistake).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Junio, feel free to ignore this. It shouldn't hurt, but admittedly it's a 
stupid hack for a problem that has nothing to do with git. The "disallow 
control characters" fix is probably better, if you prefer that I can do it 
that way instead.

		Linus

diff --git a/mailinfo.c b/mailinfo.c
index 0265a29..e1c95a9 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -226,9 +226,19 @@ static int is_multipart_boundary(const c
 
 static int eatspace(char *line)
 {
-	int len = strlen(line);
-	while (len > 0 && isspace(line[len-1]))
-		line[--len] = 0;
+	int len, idx;
+
+	len = idx = 0;
+	for (;;) {
+		unsigned char c = line[idx++];
+		if (isspace(c)) {
+			if (c == '\n' || c == '\r')
+				break;
+			continue;
+		}
+		len = idx;
+	}
+	line[len] = 0;
 	return len;
 }
 
