From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/4] utf8.c: remove strbuf_write()
Date: Fri, 19 Feb 2010 23:16:45 +0100
Message-ID: <4B7F0DCD.6040006@lsrfire.ath.cx>
References: <4B7F0D08.6040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:16:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nib9X-0007bk-MC
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 23:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab0BSWQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 17:16:47 -0500
Received: from india601.server4you.de ([85.25.151.105]:43437 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab0BSWQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 17:16:46 -0500
Received: from [10.0.1.100] (p57B7E04C.dip.t-dialin.net [87.183.224.76])
	by india601.server4you.de (Postfix) with ESMTPSA id 763252F806C;
	Fri, 19 Feb 2010 23:16:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B7F0D08.6040608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140489>

The patch before the previous one made sure that all callers of
strbuf_add_wrapped_text() supply a strbuf.  Replace all calls of
strbuf_write() with regular strbuf functions and remove it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 utf8.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/utf8.c b/utf8.c
index 5146d30..87437b0 100644
--- a/utf8.c
+++ b/utf8.c
@@ -280,14 +280,6 @@ int is_utf8(const char *text)
 	return 1;
 }
 
-static inline void strbuf_write(struct strbuf *sb, const char *buf, int len)
-{
-	if (sb)
-		strbuf_insert(sb, sb->len, buf, len);
-	else
-		fwrite(buf, len, 1, stdout);
-}
-
 static void strbuf_addchars(struct strbuf *sb, int c, size_t n)
 {
 	strbuf_grow(sb, n);
@@ -305,7 +297,7 @@ static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
 		if (*eol == '\n')
 			eol++;
 		strbuf_addchars(buf, ' ', indent);
-		strbuf_write(buf, text, eol - text);
+		strbuf_add(buf, text, eol - text);
 		text = eol;
 		indent = indent2;
 	}
@@ -364,7 +356,7 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 					start = space;
 				else
 					strbuf_addchars(buf, ' ', indent);
-				strbuf_write(buf, start, text - start);
+				strbuf_add(buf, start, text - start);
 				if (!c)
 					return w;
 				space = text;
@@ -373,20 +365,20 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 				else if (c == '\n') {
 					space++;
 					if (*space == '\n') {
-						strbuf_write(buf, "\n", 1);
+						strbuf_addch(buf, '\n');
 						goto new_line;
 					}
 					else if (!isalnum(*space))
 						goto new_line;
 					else
-						strbuf_write(buf, " ", 1);
+						strbuf_addch(buf, ' ');
 				}
 				w++;
 				text++;
 			}
 			else {
 new_line:
-				strbuf_write(buf, "\n", 1);
+				strbuf_addch(buf, '\n');
 				text = bol = space + isspace(*space);
 				space = NULL;
 				w = indent = indent2;
-- 
1.7.0
