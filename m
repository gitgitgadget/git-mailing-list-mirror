From: =?UTF-8?q?Martin=20Kr=C3=BCger?= <martin.krueger@gmx.com>
Subject: [PATCH] correct folding of email-headers in conjunction with RFC2047
Date: Sat, 23 Oct 2010 12:35:54 +0200
Message-ID: <1287830154-12205-1-git-send-email-martin.krueger@gmx.com>
Cc: =?UTF-8?q?Martin=20Kr=C3=BCger?= <martin.krueger@gmx.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 12:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9bkG-0001wc-CL
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 12:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab0JWKxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 06:53:55 -0400
Received: from mailout01.t-online.de ([194.25.134.80]:50438 "EHLO
	mailout01.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab0JWKxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 06:53:54 -0400
X-Greylist: delayed 1048 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Oct 2010 06:53:54 EDT
Received: from fwd10.aul.t-online.de (fwd10.aul.t-online.de )
	by mailout01.t-online.de with smtp 
	id 1P9bSZ-0007oI-86; Sat, 23 Oct 2010 12:36:23 +0200
Received: from twiggy.upnx.de (ZeMCN6Z6ZhL4VeZTn8Zdgy3jSKpdcBylq0--IbVX1thuFWYvzcxAWyy8DuzMGAVw9k@[91.60.48.172]) by fwd10.aul.t-online.de
	with esmtp id 1P9bSX-1RofQG0; Sat, 23 Oct 2010 12:36:21 +0200
Received: from doppelhertz.upnx.de (unknown [192.168.221.100])
	by twiggy.upnx.de (Postfix) with ESMTP id 0379D1C125;
	Sat, 23 Oct 2010 12:44:15 +0200 (CEST)
Received: from martin by doppelhertz.upnx.de with local (Exim 4.72)
	(envelope-from <martin@doppelhertz.upnx.de>)
	id 1P9bSW-0003BN-0S; Sat, 23 Oct 2010 12:36:20 +0200
X-Mailer: git-send-email 1.7.1
X-ID: ZeMCN6Z6ZhL4VeZTn8Zdgy3jSKpdcBylq0--IbVX1thuFWYvzcxAWyy8DuzMGAVw9k@t-dialin.net
X-TOI-MSGID: 70ac7978-197d-4f56-a689-5b94decc0d30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159776>

according to RFC5322 a header must be passed unfolded to further processings.
If the WSP after CRLF is replaced with =20 by RFC2047 encoding the folding is no longer recognized.
So WSP indicating a folding must not be processed by the RFC2047 encoding.
Because a WSP is not valid in an RFC2047 encoded header-chunk every folded line has to be encoded seperately.
---
 pretty.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index f85444b..8a78a4e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -216,7 +216,7 @@ static int is_rfc2047_special(char ch)
 static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 		       const char *encoding)
 {
-	int i, last;
+	int i, last, num_foldings;
 
 	for (i = 0; i < len; i++) {
 		int ch = line[i];
@@ -229,8 +229,14 @@ static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 	return;
 
 needquote:
-	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
+        num_foldings=0;
+        for (i = 1; i < len; i++)
+          if(line[i]==' '&&line[i]=='\n')
+           num_foldings++;  
+ 
+	strbuf_grow(sb, len * 3 + num_foldings*(7+strlen(encoding)) + 100);
 	strbuf_addf(sb, "=?%s?q?", encoding);
+        unsigned last_ch=0;
 	for (i = last = 0; i < len; i++) {
 		unsigned ch = line[i] & 0xFF;
 		/*
@@ -240,10 +246,19 @@ needquote:
 		 * leave the underscore in place.
 		 */
 		if (is_rfc2047_special(ch) || ch == ' ') {
-			strbuf_add(sb, line + last, i - last);
-			strbuf_addf(sb, "=%02X", ch);
-			last = i + 1;
+                    if(!(ch == ' '&& last_ch=='\n')){
+                        strbuf_add(sb, line + last, i - last);
+			strbuf_addf(sb, "=%02X", ch);   
+                    }
+                    else{
+                     if(i>last+1)
+                      strbuf_add(sb, line + last, i - last-1);
+                     strbuf_addstr(sb, "?=\n ");
+                     strbuf_addf(sb, "=?%s?q?", encoding);
+                    }
+                  last = i + 1;
 		}
+           last_ch=ch;
 	}
 	strbuf_add(sb, line + last, len - last);
 	strbuf_addstr(sb, "?=");
-- 
1.7.1
